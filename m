From: Gimcuan Hui <gimcuan@gmail.com>
Subject: [PATCH 2/5] tty: serial: jsm: add blank line after declarations
Date: Sun,  5 Nov 2017 05:06:19 +0000
Message-ID: <cbda8893586ac3dd6e80369a25a0fdae16feb044.1509853735.git.gimcuan@gmail.com>
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

Missing a blank line after declarations.

Signed-off-by: Gimcuan Hui <gimcuan@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 729d2a083a74..ed58dfc3d40e 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -124,6 +124,7 @@ static void jsm_tty_set_mctrl(struct uart_port *port, unsigned int mctrl)
 static void jsm_tty_write(struct uart_port *port)
 {
 	struct jsm_channel *channel;
+
 	channel = container_of(port, struct jsm_channel, uart_port);
 	channel->ch_bd->bd_ops->copy_data_from_queue_to_uart(channel);
 }
-- 
2.11.0
