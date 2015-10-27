From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 01/15] cyclades: Deinline cyz_is_loaded, save 240 bytes
Date: Tue, 27 Oct 2015 18:46:33 +0100
Message-ID: <1445968007-12616-2-git-send-email-dvlasenk@redhat.com>
References: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 58 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/cyclades.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 87f6578..1492938 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -321,7 +321,7 @@ static inline bool cyz_fpga_loaded(struct cyclades_card *card)
 	return __cyz_fpga_loaded(card->ctl_addr.p9060);
 }
 
-static inline bool cyz_is_loaded(struct cyclades_card *card)
+static bool cyz_is_loaded(struct cyclades_card *card)
 {
 	struct FIRM_ID __iomem *fw_id = card->base_addr + ID_ADDRESS;
 
-- 
1.8.1.4
