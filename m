From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 6/8] serial/jsm: Deinline neo_parse_isr, save 688 bytes
Date: Tue, 27 Oct 2015 17:40:00 +0100
Message-ID: <1445964002-10093-7-git-send-email-dvlasenk@redhat.com>
References: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 811 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/serial/jsm/jsm_neo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index 932b2ac..c6fdd63 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -714,7 +714,7 @@ static void neo_clear_break(struct jsm_channel *ch)
 /*
  * Parse the ISR register.
  */
-static inline void neo_parse_isr(struct jsm_board *brd, u32 port)
+static void neo_parse_isr(struct jsm_board *brd, u32 port)
 {
 	struct jsm_channel *ch;
 	u8 isr;
-- 
1.8.1.4
