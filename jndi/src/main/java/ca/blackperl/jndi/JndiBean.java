package ca.blackperl.jndi;

import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NameClassPair;
import javax.naming.NamingEnumeration;

import org.apache.juli.logging.Log;
import org.apache.juli.logging.LogFactory;

public class JndiBean {
	Log log = LogFactory.getLog(JndiBean.class);
	
	public List<String> getList() {
		try {

			List<String> list = new ArrayList<String>();

			InitialContext initialContext = new InitialContext();

			NamingEnumeration<NameClassPair> listBindings = initialContext
					.list("");

			while (listBindings.hasMoreElements()) {
				NameClassPair binding = listBindings.nextElement();

				String name = binding.getName();
				log.debug(name);
				list.add(name);
			}
			
			log.debug("list = " + list.size() );

			return list;

		} catch (Exception e) {
			log.error(e, e);
			return new ArrayList<String>();
		}

	}
}
