From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 1/8] cyclades: Deinline cyy_readb, save 368 bytes
Date: Tue, 27 Oct 2015 17:39:55 +0100
Message-ID: <1445964002-10093-2-git-send-email-dvlasenk@redhat.com>
References: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 32 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/cyclades.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 87f6578..cf81fbc 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -299,7 +299,7 @@ static inline void cyy_writeb(struct cyclades_port *port, u32 reg, u8 val)
 	cy_writeb(port->u.cyy.base_addr + (reg << card->bus_index), val);
 }
 
-static inline u8 cyy_readb(struct cyclades_port *port, u32 reg)
+static u8 cyy_readb(struct cyclades_port *port, u32 reg)
 {
 	struct cyclades_card *card = port->card;
 
-- 
1.8.1.4
