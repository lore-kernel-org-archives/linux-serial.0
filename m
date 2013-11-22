From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH staging-next 2/4] staging/fwserial: Up the tty buffer limit to 128K
Date: Fri, 22 Nov 2013 13:06:09 -0500
Message-ID: <1385143571-3571-3-git-send-email-peter@hurleysoftware.com>
References: <1385143571-3571-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385143571-3571-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The firewire driver can overrun the tty buffers before the
line discipline can throttle the input; up the buffer limit.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/staging/fwserial/fwserial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index c96f62e..cad9e3f 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -2225,6 +2225,7 @@ static int fwserial_create(struct fw_unit *unit)
 		port->index = FWTTY_INVALID_INDEX;
 		port->port.ops = &fwtty_port_ops;
 		port->serial = serial;
+		tty_buffer_set_limit(&port->port, 128 * 1024);
 
 		spin_lock_init(&port->lock);
 		INIT_DELAYED_WORK(&port->drain, fwtty_drain_tx);
-- 
1.8.1.2
