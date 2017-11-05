From: Gimcuan Hui <gimcuan@gmail.com>
Subject: [PATCH 1/5] tty: serial: jsm: change the type of local variable
Date: Sun,  5 Nov 2017 05:06:18 +0000
Message-ID: <5c64f328c41e74b635d38e9e5614dcfb627afb5c.1509853735.git.gimcuan@gmail.com>
References: <cover.1509853735.git.gimcuan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509853735.git.gimcuan@gmail.com>
In-Reply-To: <cover.1509853735.git.gimcuan@gmail.com>
References: <cover.1509853735.git.gimcuan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The return type of jsm_get_mstat was int, and the local var result
was for the return should be int, make the change.

This patch fixes the checkpatch.pl warning:
Prefer 'unsigned int' to bare use of 'unsigned'.

Signed-off-by: Gimcuan Hui <gimcuan@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index e69227cc3827..729d2a083a74 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -36,7 +36,7 @@ static void jsm_carrier(struct jsm_channel *ch);
 static inline int jsm_get_mstat(struct jsm_channel *ch)
 {
 	unsigned char mstat;
-	unsigned result;
+	int result;
 
 	jsm_dbg(IOCTL, &ch->ch_bd->pci_dev, "start\n");
 
-- 
2.11.0
