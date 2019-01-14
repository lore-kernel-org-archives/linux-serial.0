From: yes@vger.kernel.org
Subject: [PATCH] tty: not call tty close in fallback
Date: Mon, 14 Jan 2019 14:56:01 +0800
Message-ID: <24367.9433399395$1547448857@news.gmane.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

when fail to open tty, tty is not in open status and not need
to call close

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/tty/serdev/serdev-ttyport.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index fa1672993b4c..bcc1e27d00de 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -121,7 +121,7 @@ static int ttyport_open(struct serdev_controller *ctrl)
 
 	ret = tty->ops->open(serport->tty, NULL);
 	if (ret)
-		goto err_close;
+		goto err_unlock;
 
 	tty_unlock(serport->tty);
 
@@ -142,8 +142,6 @@ static int ttyport_open(struct serdev_controller *ctrl)
 
 	return 0;
 
-err_close:
-	tty->ops->close(tty, NULL);
 err_unlock:
 	tty_unlock(tty);
 	tty_release_struct(tty, serport->tty_idx);
-- 
2.16.2
