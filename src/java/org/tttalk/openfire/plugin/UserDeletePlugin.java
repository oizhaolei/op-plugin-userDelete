package org.tttalk.openfire.plugin;

import java.io.File;

import org.jivesoftware.openfire.XMPPServer;
import org.jivesoftware.openfire.container.Plugin;
import org.jivesoftware.openfire.container.PluginManager;
import org.jivesoftware.openfire.user.User;
import org.jivesoftware.openfire.user.UserManager;
import org.jivesoftware.openfire.user.UserNotFoundException;

/**
 * To change this template use File | Settings | File Templates.
 */
public class UserDeletePlugin implements Plugin {


	public void initializePlugin(PluginManager manager, File pluginDirectory) {
		// Do nothing
	}

	public void destroyPlugin() {
		// Do nothing
	}

	public void deleteUsers(String str) {
		String[] usernames = str.split(",");
		// Delete users
		XMPPServer server = XMPPServer.getInstance();
		UserManager userManager = server.getUserManager();
//		RosterManager rosterManager = server.getRosterManager();
		System.out.println("Deleting users accounts: " + usernames.length);
		int delete = 0;
		for (String username : usernames) {
			try {
				User user = userManager.getUser(username);

				// deleteRosters(user, rosterManager);
				userManager.deleteUser(user);
				delete++;
			} catch (UserNotFoundException e) {
				// Ignore
			}
		}
		System.out.println("Accounts deleted successfully: " + delete);
	}
}
