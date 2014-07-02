package ca.blackperl.servlet;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.juli.logging.Log;
import org.apache.juli.logging.LogFactory;

public class JndiServlet extends HttpServlet {

	private static final Log log = LogFactory.getLog(JndiServlet.class);

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String requestURI = req.getServletPath();
		log.debug("ServletPath: " + req.getServletPath());
		log.debug("Request URL: " + requestURI );
		
		int lastIndexOf = requestURI.lastIndexOf(".");
		String jspName = requestURI.substring(0, lastIndexOf) + ".jsp";
		
		log.debug(jspName);
		

		if (log.isDebugEnabled()) {
			Enumeration<String> headerNames = req.getHeaderNames();
			log.debug("Headers:");
			while (headerNames.hasMoreElements()) {
				String name = (String) headerNames.nextElement();
				log.debug(name + ": " + req.getHeader(name));
			}
		}

		HttpSession session = req.getSession();
		if (log.isDebugEnabled()) {
			log.debug("Session Attributes:");
			Enumeration<String> attributeNames2 = session.getAttributeNames();
			while (attributeNames2.hasMoreElements()) {
				String name = (String) attributeNames2.nextElement();
				log.debug(name + ": " + session.getAttribute(name));
			}
		}

		if (log.isDebugEnabled()) {
			Enumeration<String> attributeNames = req.getAttributeNames();
			log.debug("Attributes:");
			while (attributeNames.hasMoreElements()) {
				String name = (String) attributeNames.nextElement();
				log.debug(name + ": " + req.getAttribute(name));
			}
		}

		if (log.isDebugEnabled()) {
			log.debug("Parameters:");
			Enumeration<String> parameterNames = req.getParameterNames();
			while (parameterNames.hasMoreElements()) {
				String name = (String) parameterNames.nextElement();
				log.debug(name + ": " + req.getParameter(name));
			}
		}
		
		req.getServletContext().getRequestDispatcher(jspName)
				.forward(req, resp);
	}
}
