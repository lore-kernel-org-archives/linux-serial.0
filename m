From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: Patch for panic in n_tty_read()
Date: Fri, 27 Jul 2012 14:05:16 +0200
Message-ID: <501283FC.8070409@redhat.com>
References: <4FE886C6.7090606@redhat.com> <20120626152159.2a34dcaf@pyramind.ukuu.org.uk> <50094C8E.5010308@redhat.com> <20120720161123.58fc9703@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040802070406000305040103"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15419 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004Ab2G0MF1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2012 08:05:27 -0400
In-Reply-To: <20120720161123.58fc9703@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------040802070406000305040103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan,

Thank you, updated fix (tested on bits based on commit 
bdc0077af574800d24318b6945cf2344e8dbb050) is attached.
Is this correct now?

Thanks and regards,
-Stanislav Kozina

>> You mean call to tty_put_user(), correct? Thanks for this catch.
>> So what about to unlock the lock for this time? Because we need to hold
>> the lock while checking tty->read_cnt in the while loop condition, correct?
> I think you are right on that yes.
>
> Alan


--------------040802070406000305040103
Content-Type: text/plain;
 name="tty_panic_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tty_panic_2.patch"

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index ee1c268..54d1fc5 100644
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
@@ -1864,6 +1864,7 @@ do_it_again:
 					tty_audit_push(tty);
 					break;
 				}
+				spin_lock_irqsave(&tty->read_lock, flags);
 			}
 			if (retval)
 				break;

--------------040802070406000305040103--
