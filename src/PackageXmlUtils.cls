/**
 * メタデータのユーティリティクラスです。
 */
public class PackageXmlUtils {

    public class PackageXml {
        public Type[] types {get; set;}
        public Map<String, Type> typeMap {get; set;}
        public String version {get; set;}
        
        public PackageXml() {
            types = new Type[0];
            typeMap = new Map<String, Type>();
        }
        
        public PackageXml(String xml) {
            this();
            Dom.Document doc = new Dom.Document();
            doc.load(xml);
            
            for (Dom.XMLNode typeNode : getChildElements(doc.getRootElement(), 'types')) {
                addType(new Type(typeNode));
            }
            version = getChildElement(doc.getRootElement(), 'version').getText();
        }
        
        public void addType(Type t) {
            types.add(t);
            typeMap.put(t.name, t);
        }
        
        /**
         * 積集合を返します。
         */
        public PackageXml intersect(PackageXml other) {
            PackageXml r = new PackageXml();
            r.version = version;
            for (Type t : types) {
                Type ot = other.typeMap.get(t.name);
                if (ot == null) {
                    continue;
                }
                Type rt = new Type();
                for (String m : t.members) {
                    if (ot.memberSet.contains(m)) {
                        rt.addMember(m);
                    }
                }
                if (!rt.members.isEmpty()) {
                    rt.name = t.name;
                    r.addType(rt);
                }
            }
            return r;
        }
        
        /**
         * 和集合を返します。
         */
        public PackageXml union(PackageXml other) {
            PackageXml r = new PackageXml();
            r.version = version;
            for (Type t : types) {
                Type rt = new Type();
                rt.name = t.name;
                for (String m : t.members) {
                    rt.addMember(m);
                }
                r.addType(rt);
            }
            for (Type ot : other.types) {
                Type rt = r.typeMap.get(ot.name);
                if (rt == null) {
                    rt = new Type();
                    rt.name = ot.name;
                    r.addType(rt);
                }
                for (String m : ot.members) {
                    if (!rt.memberSet.contains(m)) {
                        rt.addMember(m);
                    }
                }
            }
            return r;
        }
        
        /**
         * 差集合を返します。
         */
        public PackageXml diff(PackageXml other) {
            PackageXml r = new PackageXml();
            r.version = version;
            for (Type t : types) {
                Type ot = other.typeMap.get(t.name);
                Type rt = new Type();
                for (String m : t.members) {
                    if (ot == null || !ot.memberSet.contains(m)) {
                        rt.addMember(m);
                    }
                }
                if (!rt.members.isEmpty()) {
                    rt.name = t.name;
                    r.addType(rt);
                }
            }
            return r;
        }
        
        public override String toString() {
            String[] typeTexts = new String[0];
            for (Type t : types) {
                typeTexts.add(t.toString());
            }
            return ''
                + '<Package xmlns="http://soap.sforce.com/2006/04/metadata">\n'
                + String.join(typeTexts, '')
                + '  <version>' + version + '</version>\n'
                + '</Package>\n';
        }
    }
    
    public class Type {
        public String name {get; set;}
        public String[] members {get; set;}
        public Set<String> memberSet {get; set;}
        
        public Type() {
            members = new String[0];
            memberSet = new Set<String>();
        }

        public Type(Dom.XMLNode typeNode) {
            this();
            name = getChildElement(typeNode, 'name').getText();
            for (Dom.XMLNode memberNode : getChildElements(typeNode, 'members')) {
                addMember(memberNode.getText());
            }
        }
        
        public void addMember(String m) {
            members.add(m);
            memberSet.add(m);
        }
        
        public override String toString() {
            String[] memberTexts = new String[0];
            for (String m : members) {
                memberTexts.add('    <members>' + m + '</members>\n');
            }
            return ''
                + '  <types>\n'
                + String.join(memberTexts, '')
                + '    <name>' + name + '</name>\n'
                + '  </types>\n';
        }
    }
    
    public static Dom.XMLNode[] getChildElements(Dom.XMLNode node, String elemName) {
        Dom.XMLNode[] childs = new Dom.XMLNode[0];
        for (Dom.XMLNode child : node.getChildElements()) {
            if (child.getName() == elemName) {
                childs.add(child);
            }
        }
        return childs;
    }
    
    public static Dom.XMLNode getChildElement(Dom.XMLNode node, String elemName) {
        for (Dom.XMLNode child : node.getChildElements()) {
            if (child.getName() == elemName) {
                return child;
            }
        }
        return null;
    }
}