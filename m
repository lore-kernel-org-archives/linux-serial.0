From: Stanislav Kozina <skozina@redhat.com>
Subject: Patch for panic in n_tty_read()
Date: Mon, 25 Jun 2012 17:41:58 +0200
Message-ID: <4FE886C6.7090606@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000907070205010301070806"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21038 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516Ab2FYPmB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Jun 2012 11:42:01 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------000907070205010301070806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg,

(my first suggested patch for Linux kernel, so please bear with me if I 
don't follow process correctly. Thank you.)

We had few customers who met panics in n_tty_read() with following 
backtrace:

      #8 [ffff880018b8dcd0] page_fault at ffffffff814ddfe5
         [exception RIP: n_tty_read+0x2c9]
<register output removed>
      #9 [ffff880018b8dea0] tty_read at ffffffff81300b16
     #10 [ffff880018b8def0] vfs_read at ffffffff81172f85
     #11 [ffff880018b8df30] sys_read at ffffffff811730c1
     #12 [ffff880018b8df80] system_call_fastpath at ffffffff8100b172

My patch for this panic is attached (tty_panic.patch), in short - I 
believe that we need to hold &tty->read_lock while checking 
tty->read_cnt in while-loop condition in n_tty_read() here:

1835                         while (nr && tty->read_cnt) {
1836                                 int eol;
1837
1838                                 eol = 
test_and_clear_bit(tty->read_tail,
1839                                                 tty->read_flags);
1840                                 c = tty->read_buf[tty->read_tail];
1841                                 spin_lock_irqsave(&tty->read_lock, 
flags);

We gave this patch to the customers, they were testing it for a month on 
several tens of machines without being able to reproduce the problem.

Please can you integrate the patch into the kernel?

My testing
====
The patch pulls the spinlock out of the while loop. This makes 
reset_buffer_flags() and others wait before changing either read_buf or 
read_cnt. So this should solve the issue - the question is if this can 
cause any deadlock.

I inserted the msleep(2000) when the lock is held. This should trigger 
any deadlock of possible.

I found out that:
1) n_tty_read() runs when I e.g. log on the serial console
2) reset_buffer_flags() is running when I push CTRL+C on any terminal

That's why my plan was to log on serial console, and than (in shorter 
time than 2 seconds) press CTRL+C on any terminal. I wrote a stap script 
to verify that both functions were running, the stap script is attached.
And this is part of the output from attached stap script:

1336070859652 -> reset_buffer_flags (PID: 225)
1336070859652 <- reset_buffer_flags (PID: 225)
1336070859652 <- n_tty_read (PID: 7527, retval: -512)
1336070859652 -> n_tty_read (PID: 7527)
1336070859654 -> n_tty_read (PID: 7502)
1336070859654 <- n_tty_read (PID: 7502, retval: 53)
1336070867135 -> n_tty_read (PID: 7498)
1336070867135 <- n_tty_read (PID: 7498, retval: 1)
1336070868260 -> reset_buffer_flags (PID: 237)
1336070868260 <- reset_buffer_flags (PID: 237)

It's clear to see when we were in the msleep(2000) - it forced 
n_tty_read to be delayed by 2 seconds in PID 7498. That's why even 
reset_buffer_flags was not running.

--------------000907070205010301070806
Content-Type: text/plain;
 name="tty_panic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tty_panic.patch"

diff --git a/drivers/char/n_tty.c b/drivers/char/n_tty.c
index 2e50f4d..ace0c19 100644
--- a/drivers/char/n_tty.c
+++ b/drivers/char/n_tty.c
@@ -1813,13 +1813,13 @@ do_it_again:
 
 		if (tty->icanon) {
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
@@ -1831,7 +1831,6 @@ do_it_again:
 					if (--tty->canon_data < 0)
 						tty->canon_data = 0;
 				}
-				spin_unlock_irqrestore(&tty->read_lock, flags);
 
 				if (!eol || (c != __DISABLED_CHAR)) {
 					if (tty_put_user(tty, c, b++)) {
@@ -1846,6 +1845,7 @@ do_it_again:
 					break;
 				}
 			}
+			spin_unlock_irqrestore(&tty->read_lock, flags);
 			if (retval)
 				break;
 		} else {

--------------000907070205010301070806
Content-Type: text/plain;
 name="trace.stp"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="trace.stp"

probe kernel.function("reset_buffer_flags").call
{
	printf("%d -> %s (PID: %d)\n", gettimeofday_ms(), probefunc(), pid());
}

probe kernel.function("reset_buffer_flags").return
{
	printf("%d <- %s (PID: %d)\n", gettimeofday_ms(), probefunc(), pid());
}

probe kernel.function("n_tty_read").call
{
	printf("%d -> %s (PID: %d)\n", gettimeofday_ms(), probefunc(), pid());
}

probe kernel.function("n_tty_read").return
{
	printf("%d <- %s (PID: %d, retval: %d)\n", gettimeofday_ms(), probefunc(), pid(), $return)
}

--------------000907070205010301070806--
