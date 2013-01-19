From: Yi Qingliang <niqingliang2003@gmail.com>
Subject: sysvinit freeze 30seconds on close /dev/console
Date: Sat, 19 Jan 2013 10:16:46 +0800
Message-ID: <1978342.XoIOWg0br0@ll-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:60199 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab3ASCQ6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jan 2013 21:16:58 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so1873804dae.31
        for <linux-serial@vger.kernel.org>; Fri, 18 Jan 2013 18:16:57 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I'm running 3.6.9 kernel on my s3c2442 board.
the sysvinit freeze 30seconds after print out "INIT:",
and then freeze 30seconds after print out "version 2.88 booting".
I checked it's code, the 'close(fd)' should be responsible for the 30 seconds.

same binary running well on mini2440(s3c2440 board).
Through several days hard work, I got the root cause.
the close called wait_until_sent with timeout(30seconds).
the uart clock source selection is different.
although both of the two boards selected 'pclk',
related register: UCON0[11:10] 0x50000004
s3c2440 use '10', s3c2442 use '00'.

on s3c2440, the '10' is selected in initialalize stage.
on s3c2442, it can't find propriate clock, so use default value '00'.

in initialize stage, it will found 'clk_uart_baud2", but not on s3c2442.
I checked 'arch/arm/mach-s3c24xx/clock-s3c2440.c', it is only registered for 
s3c2440_subsys, but not for s3c2442_sys.
after registered 's3c2440_clk_lookup' for s3c2442_subsys, everything OK.

problem:
1. I don't know the different between 00 and 10 of pck in register 
UCON0[11:10].
2. why kernel code have not registered s3c2440_clk_lookup for s3c2442? and 
also dma-s3c2440.c.

I checked 'arch/arm/mach-s3c24xx/s3c2442.c', it is for the s3c2442's clock, 
but why the file name is not 'clock-s3c2442.c'? an it only contain cam related 
clock, no uart related clock.

Yi Qingliang
Nanjing Jilong
niqingliang2003@gmai.com





