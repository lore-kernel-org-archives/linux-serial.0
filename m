From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH] serial/68360serial: replace schedule_timeout() with msleep_interruptible()
Date: Thu, 3 Mar 2005 10:54:11 -0800
Message-ID: <20050303185411.GM11600@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from e4.ny.us.ibm.com ([32.97.182.144]:57052 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261571AbVCCSyO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Mar 2005 13:54:14 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j23IsDE8023599
	for <linux-serial@vger.kernel.org>; Thu, 3 Mar 2005 13:54:13 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j23IsDc5206990
	for <linux-serial@vger.kernel.org>; Thu, 3 Mar 2005 13:54:13 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j23IsDgA021675
	for <linux-serial@vger.kernel.org>; Thu, 3 Mar 2005 13:54:13 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: Kernel-Janitors <kernel-janitors@lists.osdl.org>, linux-serial@vger.kernel.org

Hi,

Russell, sorry if you are not responsible for this driver, but I figure
the more eyes the better.

Thanks,
Nish


Please consider applying.

Description: Use msleep_interruptible() instead of schedule_timeout() in
send_break() to guarantee the task delays as expected. Change
@duration's units to milliseconds, and modify arguments in callers
appropriately.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.11-kj-v/drivers/serial/68360serial.c	2005-03-01 23:38:26.000000000 -0800
+++ 2.6.11-kj/drivers/serial/68360serial.c	2005-03-02 14:40:38.000000000 -0800
@@ -1394,14 +1394,13 @@ static void end_break(ser_info_t *info)
 /*
  * This routine sends a break character out the serial port.
  */
-static void send_break(ser_info_t *info, int duration)
+static void send_break(ser_info_t *info, unsigned int duration)
 {
-	set_current_state(TASK_INTERRUPTIBLE);
 #ifdef SERIAL_DEBUG_SEND_BREAK
 	printk("rs_send_break(%d) jiff=%lu...", duration, jiffies);
 #endif
 	begin_break(info);
-	schedule_timeout(duration);
+	msleep_interruptible(duration);
 	end_break(info);
 #ifdef SERIAL_DEBUG_SEND_BREAK
 	printk("done jiffies=%lu\n", jiffies);
@@ -1436,7 +1435,7 @@ static int rs_360_ioctl(struct tty_struc
 			if (signal_pending(current))
 				return -EINTR;
 			if (!arg) {
-				send_break(info, HZ/4);	/* 1/4 second */
+				send_break(info, 250);	/* 1/4 second */
 				if (signal_pending(current))
 					return -EINTR;
 			}
@@ -1448,7 +1447,7 @@ static int rs_360_ioctl(struct tty_struc
 			tty_wait_until_sent(tty, 0);
 			if (signal_pending(current))
 				return -EINTR;
-			send_break(info, arg ? arg*(HZ/10) : HZ/4);
+			send_break(info, arg ? arg*100 : 250);
 			if (signal_pending(current))
 				return -EINTR;
 			return 0;
