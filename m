From: digger vermont <dv_mlist@verizon.net>
Subject: bluetooth pcmcia/cf serial errors with 2.6 kernel
Date: Fri, 23 Jan 2004 14:16:42 -0500
Sender: bluez-users-admin@lists.sourceforge.net
Message-ID: <1074885137.3532.9.camel@myrna>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <bluez-users-admin@lists.sourceforge.net>
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
To: Russell King <rmk+serial@arm.linux.org.uk>, Linux Serial <linux-serial@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Max Krasnyansky <maxk@qualcomm.com>, bluez-users <bluez-users@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-serial@vger.kernel.org

Hello Russell King and Linux Serial Mailing List,

	Changes to the serial driver in 2.6.xx kernels have caused problems
with some bluetooth pcmcia/cf cards that do work properly with 2.4.xx
kernels. 

When the cards are plugged the uarts are correctly identified and the
ports created.  However, hciattach returns errors when trying to attach
the port to the BlueZ stack. Different settings have been tried such as
baud rates and irq's through setserial with no difference.
	
The problem is not platform specific.  It occurs on my powerbook.  I'm
not sure of the platforms of the other reported errors, but they are not
powerpc's.

Here are more specifics:

kernel 2.4.24 works fine

kernel 2.6.2-rc1 and 2.6.2-rc1-ben1
	Com One Platinum:Reported to work fine.
	Xircom PC cards:Reported to time out.
	Socket CF:	Error is "BCSP initialization timed out".
			Card is reported as "Socket", "CF+ Personal
			Network Card Rev 2.5"

Here is the top of the thread on the bluez-users mailing list:
	http://thread.gmane.org/gmane.linux.bluez.user/1864
	
If there is any other information I can help with please let me know.


Thanks,

digger	
	




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
