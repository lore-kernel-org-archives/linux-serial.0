From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 11/22] tty: Call hangup method in modern style
Date: Mon, 16 Jun 2014 09:17:08 -0400
Message-ID: <1402924639-5164-12-git-send-email-peter@hurleysoftware.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 3411071..714320b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -688,7 +688,7 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 			for (n = 0; n < closecount; n++)
 				tty->ops->close(tty, cons_filp);
 	} else if (tty->ops->hangup)
-		(tty->ops->hangup)(tty);
+		tty->ops->hangup(tty);
 	/*
 	 * We don't want to have driver/ldisc interactions beyond
 	 * the ones we did here. The driver layer expects no
-- 
2.0.0
