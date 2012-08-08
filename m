From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: Patch for panic in n_tty_read()
Date: Wed, 08 Aug 2012 09:58:40 +0200
Message-ID: <50221C30.20607@redhat.com>
References: <4FE886C6.7090606@redhat.com> <20120626152159.2a34dcaf@pyramind.ukuu.org.uk> <50094C8E.5010308@redhat.com> <20120720161123.58fc9703@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050807000500050900040604"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45026 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932214Ab2HHH6v (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Aug 2012 03:58:51 -0400
In-Reply-To: <20120720161123.58fc9703@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------050807000500050900040604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan,

I am not sure if you got my last email, so I'm resending it now:

 > I am very sorry, but I don't see it. We didn't held the lock while 
calling tty_audit_push() before, and we don't hold it after the patch 
neither.
 > So what's the locking scheme change here? Is there some binding 
between n_tty_read() and tty_audit_push() I just don't see?

Please can you advice me why I should check this patch with audit folks?

Thanks a lot,
-Stanislav

 >> Looks good to me. However it changes the locking rules on
 >> tty_audit_push() so please check the audit folks are ok with it. I don't
 >> think that causes any problems.
 >>
 >> Alan

--------------050807000500050900040604
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


--------------050807000500050900040604--
