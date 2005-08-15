From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [-mm PATCH 30/32] serial: fix-up schedule_timeout() usage
Date: Mon, 15 Aug 2005 11:28:52 -0700
Message-ID: <20050815182852.GG2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:38023 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964891AbVHOS27 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Aug 2005 14:28:59 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7FISsp4017600
	for <linux-serial@vger.kernel.org>; Mon, 15 Aug 2005 14:28:54 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7FISsPJ155456
	for <linux-serial@vger.kernel.org>; Mon, 15 Aug 2005 14:28:54 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7FISrwT029395
	for <linux-serial@vger.kernel.org>; Mon, 15 Aug 2005 14:28:54 -0400
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: starvik@axis.com, rmk+serial@arm.linux.org.uk
Cc: akpm@osdl.org, dev-etrax@axis.com, linux-serial@vger.kernel.org

Description: Use schedule_timeout_uninterruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 drivers/serial/crisv10.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff -urpN 2.6.13-rc5-mm1/drivers/serial/crisv10.c 2.6.13-rc5-mm1-dev/drivers/serial/crisv10.c
--- 2.6.13-rc5-mm1/drivers/serial/crisv10.c	2005-08-07 09:58:14.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/drivers/serial/crisv10.c	2005-08-10 14:27:46.000000000 -0700
@@ -4417,10 +4417,8 @@ rs_close(struct tty_struct *tty, struct 
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
-		}
+		if (info->close_delay)
+			schedule_timeout_interruptible(info->close_delay);
 		wake_up_interruptible(&info->open_wait);
 	}
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
@@ -4470,8 +4468,7 @@ static void rs_wait_until_sent(struct tt
 	while (info->xmit.head != info->xmit.tail || /* More in send queue */
 	       (*info->ostatusadr & 0x007f) ||  /* more in FIFO */
 	       (elapsed_usec < 2*info->char_time_usec)) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_interruptible(1);
 		if (signal_pending(current))
 			break;
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
