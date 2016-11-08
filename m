From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] serial: crisv10: fix invalid user-pointer check
Date: Tue,  8 Nov 2016 13:24:55 +0100
Message-ID: <1478607895-23447-4-git-send-email-johan@kernel.org>
References: <1478607895-23447-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478607895-23447-1-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com
List-Id: linux-serial@vger.kernel.org

Drop invalid user-pointer check from TIOCGSERIAL handler.

A NULL-pointer can be valid in user space and copy_to_user() takes care
of sanity checking.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: linux-cris-kernel@axis.com
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/crisv10.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 315c84979b18..d4cb6ff52e7a 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -3214,8 +3214,6 @@ get_serial_info(struct e100_serial * info,
 	 * should set them to something else than 0.
 	 */
 
-	if (!retinfo)
-		return -EFAULT;
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.type = info->type;
 	tmp.line = info->line;
-- 
2.7.3
