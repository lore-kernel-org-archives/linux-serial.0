From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 4/8] isicom: Deinline WaitTillCardIsFree, save 1120 bytes
Date: Tue, 27 Oct 2015 17:39:58 +0100
Message-ID: <1445964002-10093-5-git-send-email-dvlasenk@redhat.com>
References: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 96 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/isicom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index 2054427..c7698fb 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -220,7 +220,7 @@ static struct isi_port  isi_ports[PORT_COUNT];
  *	it wants to talk.
  */
 
-static inline int WaitTillCardIsFree(unsigned long base)
+static int WaitTillCardIsFree(unsigned long base)
 {
 	unsigned int count = 0;
 	unsigned int a = in_atomic(); /* do we run under spinlock? */
-- 
1.8.1.4
