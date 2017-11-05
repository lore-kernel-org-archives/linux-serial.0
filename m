From: Gimcuan Hui <gimcuan@gmail.com>
Subject: [PATCH 4/5] tty: serial: jsm: fix coding style
Date: Sun,  5 Nov 2017 05:06:21 +0000
Message-ID: <b3ee288fe90c27a7f262613b48b6d1b35f540227.1509853735.git.gimcuan@gmail.com>
References: <cover.1509853735.git.gimcuan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509853735.git.gimcuan@gmail.com>
In-Reply-To: <cover.1509853735.git.gimcuan@gmail.com>
References: <cover.1509853735.git.gimcuan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch fixes the checkpatch.pl complain:

ERROR: else should follow close brace '}'.

Signed-off-by: Gimcuan Hui <gimcuan@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 53c3f53da241..3853bfa5aa46 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -478,8 +478,7 @@ int jsm_uart_port_init(struct jsm_board *brd)
 		if (rc) {
 			printk(KERN_INFO "jsm: Port %d failed. Aborting...\n", i);
 			return rc;
-		}
-		else
+		} else
 			printk(KERN_INFO "jsm: Port %d added\n", i);
 	}
 
-- 
2.11.0
