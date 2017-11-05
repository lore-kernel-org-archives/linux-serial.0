From: Gimcuan Hui <gimcuan@gmail.com>
Subject: [PATCH 3/5] tty: serial: jsm: delete space between function name and '('
Date: Sun,  5 Nov 2017 05:06:20 +0000
Message-ID: <603107bc3e9512612df10f22f0b9a46223c0e279.1509853735.git.gimcuan@gmail.com>
References: <cover.1509853735.git.gimcuan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509853735.git.gimcuan@gmail.com>
In-Reply-To: <cover.1509853735.git.gimcuan@gmail.com>
References: <cover.1509853735.git.gimcuan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch fixes checkpatch.pl warning:

space prohibited between function name and open parenthesis '('.

Signed-off-by: Gimcuan Hui <gimcuan@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index ed58dfc3d40e..53c3f53da241 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -474,7 +474,7 @@ int jsm_uart_port_init(struct jsm_board *brd)
 		} else
 			set_bit(line, linemap);
 		brd->channels[i]->uart_port.line = line;
-		rc = uart_add_one_port (&jsm_uart_driver, &brd->channels[i]->uart_port);
+		rc = uart_add_one_port(&jsm_uart_driver, &brd->channels[i]->uart_port);
 		if (rc) {
 			printk(KERN_INFO "jsm: Port %d failed. Aborting...\n", i);
 			return rc;
-- 
2.11.0
