From: Gimcuan Hui <gimcuan@gmail.com>
Subject: [PATCH 5/5] tty: serial: jsm: add space before the open parenthesis '('
Date: Sun,  5 Nov 2017 05:06:22 +0000
Message-ID: <4a6d5be09c39a4f0f6ee1ee5b3216129f110957e.1509853735.git.gimcuan@gmail.com>
References: <cover.1509853735.git.gimcuan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509853735.git.gimcuan@gmail.com>
In-Reply-To: <cover.1509853735.git.gimcuan@gmail.com>
References: <cover.1509853735.git.gimcuan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch fixes the checkpatch.pl complains:

space required before the open parenthesis '('.

Signed-off-by: Gimcuan Hui <gimcuan@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 3853bfa5aa46..cbbadafe61fb 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -541,7 +541,7 @@ void jsm_input(struct jsm_channel *ch)
 	tp = port->tty;
 
 	bd = ch->ch_bd;
-	if(!bd)
+	if (!bd)
 		return;
 
 	spin_lock_irqsave(&ch->ch_lock, lock_flags);
@@ -781,7 +781,7 @@ void jsm_check_queue_flow_control(struct jsm_channel *ch)
 	if (qleft < 256) {
 		/* HWFLOW */
 		if (ch->ch_c_cflag & CRTSCTS) {
-			if(!(ch->ch_flags & CH_RECEIVER_OFF)) {
+			if (!(ch->ch_flags & CH_RECEIVER_OFF)) {
 				bd_ops->disable_receiver(ch);
 				ch->ch_flags |= (CH_RECEIVER_OFF);
 				jsm_dbg(READ, &ch->ch_bd->pci_dev,
-- 
2.11.0
