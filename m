From: Stanislav Kozina <skozina@redhat.com>
Subject: [PATCH V2] [tty] Fix possible race in n_tty_read()
Date: Wed, 08 Aug 2012 16:28:47 +0200
Message-ID: <5022779F.8060309@redhat.com>
References: <4FE886C6.7090606@redhat.com> <20120626152159.2a34dcaf@pyramind.ukuu.org.uk> <50094C8E.5010308@redhat.com> <20120720161123.58fc9703@pyramind.ukuu.org.uk> <50221C30.20607@redhat.com> <20120808100019.6ca011a9@pyramind.ukuu.org.uk> <502256E8.5040300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763Ab2HHO26 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Aug 2012 10:28:58 -0400
In-Reply-To: <502256E8.5040300@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>

Fix possible panic caused by unlocked access to tty->read_cnt in 
while-loop condition in n_tty_read().

Signed-off-by: Stanislav Kozina <skozina@redhat.com>
---
  drivers/tty/n_tty.c |    6 +++++-
  1 files changed, 5 insertions(+), 1 deletions(-)
  v1->v2: Add spin_unlock_irqrestore() call after the while loop

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index ee1c268..df21f39 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1832,13 +1832,13 @@ do_it_again:

  		if (tty->icanon && !L_EXTPROC(tty)) {
  			/* N.B. avoid overrun if nr == 0 */
+			spin_lock_irqsave(&tty->read_lock, flags);
  			while (nr && tty->read_cnt) {
  				int eol;

  				eol = test_and_clear_bit(tty->read_tail,
  						tty->read_flags);
  				c = tty->read_buf[tty->read_tail];
-				spin_lock_irqsave(&tty->read_lock, flags);
  				tty->read_tail = ((tty->read_tail+1) &
  						  (N_TTY_BUF_SIZE-1));
  				tty->read_cnt--;
@@ -1856,15 +1856,19 @@ do_it_again:
  					if (tty_put_user(tty, c, b++)) {
  						retval = -EFAULT;
  						b--;
+						spin_lock_irqsave(&tty->read_lock, flags);
  						break;
  					}
  					nr--;
  				}
  				if (eol) {
  					tty_audit_push(tty);
+					spin_lock_irqsave(&tty->read_lock, flags);
  					break;
  				}
+				spin_lock_irqsave(&tty->read_lock, flags);
  			}
+			spin_unlock_irqrestore(&tty->read_lock, flags);
  			if (retval)
  				break;
  		} else {
-- 
1.7.1
