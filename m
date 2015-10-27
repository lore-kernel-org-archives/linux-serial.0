From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 3/8] cyclades: Deinline serial_paranoia_check, save 304 bytes
Date: Tue, 27 Oct 2015 17:39:57 +0100
Message-ID: <1445964002-10093-4-git-send-email-dvlasenk@redhat.com>
References: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 52 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/cyclades.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 7f9f635..6ead43f 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -329,7 +329,7 @@ static inline bool cyz_is_loaded(struct cyclades_card *card)
 			readl(&fw_id->signature) == ZFIRM_ID;
 }
 
-static inline int serial_paranoia_check(struct cyclades_port *info,
+static int serial_paranoia_check(struct cyclades_port *info,
 		const char *name, const char *routine)
 {
 #ifdef SERIAL_PARANOIA_CHECK
-- 
1.8.1.4
