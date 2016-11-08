From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] tty: rocket: fix invalid user-pointer checks
Date: Tue,  8 Nov 2016 13:24:54 +0100
Message-ID: <1478607895-23447-3-git-send-email-johan@kernel.org>
References: <1478607895-23447-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478607895-23447-1-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Drop invalid user-pointer checks from custom ioctl handlers.

A NULL-pointer can be valid in user space and copy_to_user() takes care
of sanity checking.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/rocket.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index b0cc47c77b40..d66c1edd9892 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1189,8 +1189,6 @@ static int get_config(struct r_port *info, struct rocket_config __user *retinfo)
 {
 	struct rocket_config tmp;
 
-	if (!retinfo)
-		return -EFAULT;
 	memset(&tmp, 0, sizeof (tmp));
 	mutex_lock(&info->port.mutex);
 	tmp.line = info->line;
@@ -1255,8 +1253,6 @@ static int get_ports(struct r_port *info, struct rocket_ports __user *retports)
 	struct rocket_ports tmp;
 	int board;
 
-	if (!retports)
-		return -EFAULT;
 	memset(&tmp, 0, sizeof (tmp));
 	tmp.tty_major = rocket_driver->major;
 
-- 
2.7.3
