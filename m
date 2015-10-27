From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 02/15] isicom: Deinline drop_dtr, save 112 bytes
Date: Tue, 27 Oct 2015 18:46:34 +0100
Message-ID: <1445968007-12616-3-git-send-email-dvlasenk@redhat.com>
References: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 181 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/isicom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index 2054427..029fd0d 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -280,7 +280,7 @@ static void raise_dtr(struct isi_port *port)
 }
 
 /* card->lock HAS to be held */
-static inline void drop_dtr(struct isi_port *port)
+static void drop_dtr(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
 	unsigned long base = card->base;
-- 
1.8.1.4
