From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] jsm_tty: Fix a possible null pointer dereference in two
 functions
Date: Wed, 29 Nov 2017 17:40:15 +0100
Message-ID: <5c78db97-88f5-8655-9a47-eeee0a043fba@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 29 Nov 2017 17:30:36 +0100

Move two debug messages so that a null pointer access can not happen
for the variable "ch" in these functions.

This issue was detected by using the Coccinelle software.

Fixes: 669fef464468d3f02d60a5cf725fc097e03c5cb8 ("serial: jsm: Convert jsm_printk to jsm_dbg")

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/jsm/jsm_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 469927d37b41..a34eed7344e5 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -521,11 +521,10 @@ void jsm_input(struct jsm_channel *ch)
 	int s = 0;
 	int i = 0;
 
-	jsm_dbg(READ, &ch->ch_bd->pci_dev, "start\n");
-
 	if (!ch)
 		return;
 
+	jsm_dbg(READ, &ch->ch_bd->pci_dev, "start\n");
 	port = &ch->uart_port.state->port;
 	tp = port->tty;
 
@@ -647,10 +646,10 @@ static void jsm_carrier(struct jsm_channel *ch)
 	int virt_carrier = 0;
 	int phys_carrier = 0;
 
-	jsm_dbg(CARR, &ch->ch_bd->pci_dev, "start\n");
 	if (!ch)
 		return;
 
+	jsm_dbg(CARR, &ch->ch_bd->pci_dev, "start\n");
 	bd = ch->ch_bd;
 
 	if (!bd)
-- 
2.15.0
