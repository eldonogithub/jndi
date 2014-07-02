package ca.blackperl.bean;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.IDN;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import org.apache.log4j.Logger;

public class Whois {

	private Logger log = Logger.getLogger(Whois.class);

	private String domainName = "";
	private String command = "";
	private String method = "";
	private String sentence = "";
	private String server = "";

	public String getServer() {
		return server;
	}

	public void setServer(String server) {
		this.server = server;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getCommand() {
		return command;
	}

	public void setCommand(String command) {
		this.command = command;
	}

	@SuppressWarnings("serial")
	private static final SortedMap<String, String> commandSet = new TreeMap<String, String>() {
		{
			put("domain", "Lookup Domain");
			put("nameserver", "Lookup Name Server");
			put("registrar", "Lookup Registrar");
			put("full", "Show detailed display for EACH match");
			put("expand", "Show all parts of display without asking");
			put("summary", "Always show summary, even for only one match");
			put("partial", "Match targets STARTING with given string");
			put("?", "Enters help program for full documentation");
		}
	};

	@SuppressWarnings("serial")
	private static final SortedMap<String, String> whoisServers = new TreeMap<String, String>() {
		{
			put("whois.internic.net", "Internic");
			put("whois.nic.us", "US domain");
			put("whois.cira.ca", "CA domain");

		}
	};

	@SuppressWarnings("serial")
	private static final List<String> colours = new ArrayList<String>() {
		{
			add("Blue");
			add("Red");
			add("Green");
			add("Yellow");
			add("Purple");
			add("Orange");
		}
	};

	public List<String> getColours() {
		return colours;
	}

	public SortedMap<String, String> getWhoisServers() {
		return whoisServers;
	}

	public Map<String, String> getCommandSet() {
		return commandSet;
	}

	public String getDomainName() {
		return domainName;
	}

	public void setDomainName(String domainName) {
		this.domainName = domainName;
	}

	public List<String> getFormats() throws Exception {
		List<String> list = new ArrayList<String>();

		if (server.isEmpty()) {
			server = "whois.internic.net";
		}

		if (!whoisServers.containsKey(server)) {
			return list;
		}
		try (Socket connection = new Socket(server, 43)) {
			PrintStream out = new PrintStream(connection.getOutputStream());

			BufferedReader bufferedReader = new BufferedReader(
					new InputStreamReader(connection.getInputStream()));

			log.debug("processing request");

			if ("Help".equals(method)) {
				log.debug("method=" + method);
				command = "?";
			}

			if (command.isEmpty()) {
				log.debug("command=" + command);
				command = "domain";
			}

			if (commandSet.containsKey(command)) {

				log.debug("command is valid");

				if (domainName.isEmpty()) {
					log.debug("domain is empty");
					command = "?";
				}

				String idn = IDN.toASCII(domainName);

				sentence = command + " " + idn;
				log.debug("sentence=" + sentence);
				out.println(sentence);

				String line;

				while ((line = bufferedReader.readLine()) != null) {
					list.add(line);
				}
			}
		}
		return list;
	}

	public String getSentence() {
		return sentence;
	}

	public void setSentence(String sentence) {
		this.sentence = sentence;
	}

	public static void main(String[] args) {

		try(Socket connection = new Socket("whois.internic.net", 43)) {
			
			PrintStream out = new PrintStream(connection.getOutputStream());

			BufferedReader bufferedReader = new BufferedReader(
					new InputStreamReader(connection.getInputStream()));

			out.println("DO manning.com");

			String line;

			while ((line = bufferedReader.readLine()) != null) {
				System.out.println(line);
			}
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
