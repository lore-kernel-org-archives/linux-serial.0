From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/7] tty: cyclades+mxser, do not initialize to zero
Date: Mon,  9 May 2016 09:11:55 +0200
Message-ID: <1462777919-10367-3-git-send-email-jslaby@suse.cz>
References: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Do not initialize members of initialized structures to zero. They are
zeroed automatically.

Part of hub6 cleanup series.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/cyclades.c | 1 -
 drivers/tty/mxser.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 2943d6ff54df..7251430bf149 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -2288,7 +2288,6 @@ static int cy_get_serial_info(struct cyclades_port *info,
 		.closing_wait = info->port.closing_wait,
 		.baud_base = info->baud,
 		.custom_divisor = info->custom_divisor,
-		.hub6 = 0,		/*!!! */
 	};
 	return copy_to_user(retinfo, &tmp, sizeof(*retinfo)) ? -EFAULT : 0;
 }
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index ebb8c0034101..2ff280d8045a 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1219,7 +1219,6 @@ static int mxser_get_serial_info(struct tty_struct *tty,
 		.close_delay = info->port.close_delay,
 		.closing_wait = info->port.closing_wait,
 		.custom_divisor = info->custom_divisor,
-		.hub6 = 0
 	};
 	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
 		return -EFAULT;
-- 
2.8.2
