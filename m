From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 2/2] tty: Correct INPCK handling
Date: Mon, 16 Jun 2014 08:10:42 -0400
Message-ID: <1402920642-4855-2-git-send-email-peter@hurleysoftware.com>
References: <1402920642-4855-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402920642-4855-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ivan <athlon_@mail.ru>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

If INPCK is not set, input parity detection should be disabled. This means
parity errors should not be received from the tty driver, and the data
received should be treated normally.

SUS v3, 11.2.2, General Terminal Interface - Input Modes, states:
  "If INPCK is set, input parity checking shall be enabled. If INPCK is
   not set, input parity checking shall be disabled, allowing output parity
   generation without input parity errors. Note that whether input parity
   checking is enabled or disabled is independent of whether parity detection
   is enabled or disabled (see Control Modes). If parity detection is enabled
   but input parity checking is disabled, the hardware to which the terminal
   is connected shall recognize the parity bit, but the terminal special file
   shall not check whether or not this bit is correctly set."

Ignore parity errors reported by the tty driver when INPCK is not set, and
handle the received data normally.

Fixes: Bugzilla #71681, 'Improvement of n_tty_receive_parity_error from n_tty.c'
Reported-by: Ivan <athlon_@mail.ru>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index fe9d129..0391f17 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1214,15 +1214,16 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (I_IGNPAR(tty))
-		return;
-	if (I_PARMRK(tty)) {
-		put_tty_queue('\377', ldata);
-		put_tty_queue('\0', ldata);
-		put_tty_queue(c, ldata);
-	} else	if (I_INPCK(tty))
-		put_tty_queue('\0', ldata);
-	else
+	if (I_INPCK(tty)) {
+		if (I_IGNPAR(tty))
+			return;
+		if (I_PARMRK(tty)) {
+			put_tty_queue('\377', ldata);
+			put_tty_queue('\0', ldata);
+			put_tty_queue(c, ldata);
+		} else
+			put_tty_queue('\0', ldata);
+	} else
 		put_tty_queue(c, ldata);
 	if (waitqueue_active(&tty->read_wait))
 		wake_up_interruptible(&tty->read_wait);
-- 
2.0.0
