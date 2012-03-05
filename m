From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 22/68] TTY: serial, include pci.h in m32r_sio
Date: Mon,  5 Mar 2012 14:52:09 +0100
Message-ID: <1330955575-26641-23-git-send-email-jslaby@suse.cz>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-serial@vger.kernel.org

It uses pointers to pci_dev, but compiler complains it doesn't know
it:
In file included from .../m32r_sio.c:53:
.../m32r_sio.h:21: warning: "struct pci_dev" declared inside parameter list
.../m32r_sio.h:21: warning: its scope is only this definition or declaration, which is probably not what you want
.../m32r_sio.h:22: warning: "struct pci_dev" declared inside parameter list

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/m32r_sio.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/m32r_sio.h b/drivers/tty/serial/m32r_sio.h
index e9b7e11..8129824 100644
--- a/drivers/tty/serial/m32r_sio.h
+++ b/drivers/tty/serial/m32r_sio.h
@@ -15,6 +15,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/pci.h>
 
 struct m32r_sio_probe {
 	struct module	*owner;
-- 
1.7.9.2
