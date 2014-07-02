package ca.blackperl.jndi;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.naming.spi.InitialContextFactory;
import javax.naming.spi.InitialContextFactoryBuilder;
import javax.naming.spi.NamingManager;

import org.postgresql.ds.PGPoolingDataSource;

public class Driver {
	private static final class InitialContextFactoryBuilderImplementation
			implements InitialContextFactoryBuilder, InitialContextFactory {

		PGPoolingDataSource source = new PGPoolingDataSource();
		@Override
		public InitialContextFactory createInitialContextFactory(
				Hashtable<?, ?> environment) throws NamingException {
			return this;
		}

		@Override
		public Context getInitialContext(Hashtable<?, ?> arg0)
				throws NamingException {
			// TODO Auto-generated method stub
			return new InitialContext() {
				@Override
				public Object lookup(String name) throws NamingException {
					source.setDataSourceName("A Data Source");
					source.setServerName("localhost");
					source.setDatabaseName("test1");
					source.setUser("postgres");
					source.setPassword("qwerty");
					source.setMaxConnections(10);

					return null;
				}
			};
		}
	}

	public static void main(String[] args) {
		InitialContextFactoryBuilder builder = new InitialContextFactoryBuilderImplementation();

		try {
			NamingManager.setInitialContextFactoryBuilder(builder);
		} catch (NamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		PGPoolingDataSource source = new PGPoolingDataSource();
		source.setDataSourceName("A Data Source");
		source.setServerName("localhost");
		source.setDatabaseName("test1");
		source.setUser("postgres");
		source.setPassword("qwerty");
		source.setMaxConnections(10);

		try {
			@SuppressWarnings("unused")
			Connection connection = source.getConnection();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
}
