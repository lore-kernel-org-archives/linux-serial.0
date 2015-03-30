From: Joe Perches <joe@perches.com>
Subject: [PATCH 7/7] serial: kgdb_nmi: Use bool function return values of true/false not 1/0
Date: Mon, 30 Mar 2015 10:43:23 -0700
Message-ID: <6a716f753b4f3dc753c85cb6f84f8f07ce4cfcd1.1427736972.git.joe@perches.com>
References: <cover.1427736972.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1427736972.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use the normal return values for bool functions

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/tty/serial/kgdb_nmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 129dc5b..117df15 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -173,18 +173,18 @@ static int kgdb_nmi_poll_one_knock(void)
 bool kgdb_nmi_poll_knock(void)
 {
 	if (kgdb_nmi_knock < 0)
-		return 1;
+		return true;
 
 	while (1) {
 		int ret;
 
 		ret = kgdb_nmi_poll_one_knock();
 		if (ret == NO_POLL_CHAR)
-			return 0;
+			return false;
 		else if (ret == 1)
 			break;
 	}
-	return 1;
+	return true;
 }
 
 /*
-- 
2.1.2
