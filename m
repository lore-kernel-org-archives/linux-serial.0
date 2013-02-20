From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 32/32] tty: Drop "tty is NULL" flip buffer diagnostic
Date: Wed, 20 Feb 2013 15:03:19 -0500
Message-ID: <1361390599-15195-33-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
References: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>, Shawn Guo <shawn.guo@linaro.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Although this warning uncovered a multitude of races and errors
in the tty and ldisc layers, this diagnostic now has too many
false-positives.

An expected outcome of the separation of driver i/o paths from
tty lifetimes (added in 3.9) is that the tty may already be
in advanced stages of teardown when scheduled flip buffer work
runs. Ldisc i/o is prevented in this case because flush_to_ldisc()
cannot acquire an ldisc reference.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 0dd35ce..8e8d730 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -425,7 +425,7 @@ static void flush_to_ldisc(struct work_struct *work)
 	struct tty_ldisc *disc;
 
 	tty = port->itty;
-	if (WARN_RATELIMIT(tty == NULL, "tty is NULL\n"))
+	if (tty == NULL)
 		return;
 
 	disc = tty_ldisc_ref(tty);
-- 
1.8.1.2
