From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 2/8] cyclades: Deinline cyy_writeb, save 880 bytes
Date: Tue, 27 Oct 2015 17:39:56 +0100
Message-ID: <1445964002-10093-3-git-send-email-dvlasenk@redhat.com>
References: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 35 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/cyclades.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index cf81fbc..7f9f635 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -292,7 +292,7 @@ static void cyz_rx_restart(unsigned long);
 static struct timer_list cyz_rx_full_timer[NR_PORTS];
 #endif				/* CONFIG_CYZ_INTR */
 
-static inline void cyy_writeb(struct cyclades_port *port, u32 reg, u8 val)
+static void cyy_writeb(struct cyclades_port *port, u32 reg, u8 val)
 {
 	struct cyclades_card *card = port->card;
 
-- 
1.8.1.4
