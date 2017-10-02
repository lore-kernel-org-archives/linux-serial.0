From: Gimcuan Hui <gimcuan@gmail.com>
Subject: [PATCH] tty: serial: jsm: Add space before the open brace
Date: Mon,  2 Oct 2017 22:48:17 +0800
Message-ID: <1506955697-31025-1-git-send-email-gimcuan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gimcuan Hui <gimcuan@gmail.com>
List-Id: linux-serial@vger.kernel.org

This patch fixes the checkpatch.pl error complain:

ERROR: space required before the open brace '{'

Signed-off-by: Gimcuan Hui <gimcuan@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index ec7d838..e69227c 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -474,7 +474,7 @@ int jsm_uart_port_init(struct jsm_board *brd)
 			set_bit(line, linemap);
 		brd->channels[i]->uart_port.line = line;
 		rc = uart_add_one_port (&jsm_uart_driver, &brd->channels[i]->uart_port);
-		if (rc){
+		if (rc) {
 			printk(KERN_INFO "jsm: Port %d failed. Aborting...\n", i);
 			return rc;
 		}
-- 
2.7.4
