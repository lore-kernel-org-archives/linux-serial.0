From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2] serial: samsung: fix serial console break
Date: Fri, 17 Apr 2015 08:43:09 +0200
Message-ID: <1429252989-4724-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, jslaby@suse.cz, cw00.choi@samsung.com, peter@hurleysoftware.com, m.szyprowski@samsung.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

This patch fixes problems with serial console break. When function
s3c64xx_serial_startup() was started while serial console has been working,
it caused lose of characters written to TX FIFO. This effect was particularly
observable with systemd, which closes serial port every time when it's
not currently needed, hence function s3c64xx_serial_startup() is called
quite often there. To fix this problem we avoid resetting TX FIFO if port is
used as serial console.

Example of broken console log:

[ 1086.7         Expecting device dev-ttySAC1.device...
[ 1086.[  OK  ] Reached target Paths.
[ 1086.756416] s[  OK  ] Reached target Swap.
[ 1086.776413] systemd[1]: Reached target Swap.
[ 1086.776642] systemd[1]: Starting Root Slice.
[    5.53403[  OK  ] Created slice Root Slice.
[    5.548433] systemd[1]: Create[  OK  ] Created slice User and Session Slice.
[    5.568414] sys[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[    5.588388] s[  OK  ] Listening on Delayed Shutdown Socket.
[    5.608376] sy[  OK  ] Listening on Journal Socket (/dev/log).
[    5.628361] [  OK  ] Listening on udev Kernel Socket.
[    5.648357] s[  OK  ] Listening on udev Control Socket.
[    5.668353] s[  OK  ] Listening on Journal Socket.
[    5.688366] systemd[1]: Listeni[  OK  ] Created slice System Slice.
[    5.708393]          Mounting Temporary Directory...
[ 7139.067436]          Starting prepare device daemon...
[ 7139.091726] sy         Starting Generate environment from /etc/profile.d...
[    5.792867] system         Starting Create Static Device Nodes in /dev...
[ 7848.718         Mounting Debug File System...
[ 7848.7384         Mounting Configuration File System...
[    5.852         Starting Apply Kernel Variables...
[    5.8720         Starting Setup Virtual Console...
[ 7848.798         Starting udev Coldplug all Devices...
[ 7848.817         Starting Journal Service...
[  OK  ] Started Journal Service.
[ 7848.854222] s[  OK  ] Reached target Slices.
         Starting Remount Root and Kernel File Systems...
[  OK  ] Mounted Configuration File System.

Reported-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---

Changelog:

v2:
- addressed Peter's comment

v1: http://www.spinics.net/lists/linux-serial/msg16941.html

 drivers/tty/serial/samsung.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index cf08876..a0ae942 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1068,8 +1068,9 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 
 	ufcon = rd_regl(port, S3C2410_UFCON);
-	ufcon |= S3C2410_UFCON_RESETRX | S3C2410_UFCON_RESETTX |
-			S5PV210_UFCON_RXTRIG8;
+	ufcon |= S3C2410_UFCON_RESETRX | S5PV210_UFCON_RXTRIG8;
+	if (!uart_console(port))
+		ufcon |= S3C2410_UFCON_RESETTX;
 	wr_regl(port, S3C2410_UFCON, ufcon);
 
 	enable_rx_pio(ourport);
-- 
1.9.1
