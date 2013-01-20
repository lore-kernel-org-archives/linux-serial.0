From: Yi Qingliang <niqingliang2003@gmail.com>
Subject: close /dev/console casue 30seconds' hang
Date: Sun, 20 Jan 2013 19:28:42 +0800
Message-ID: <5857088.8tFJrCsqj8@ll-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:63900 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab3ATL2s (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 20 Jan 2013 06:28:48 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so2154465pbc.12
        for <linux-serial@vger.kernel.org>; Sun, 20 Jan 2013 03:28:47 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I'm running 3.6.9 kernel on my s3c2442 board.
the sysvinit freeze 30seconds after print out "INIT:",
and then freeze 30seconds after print out "version 2.88 booting".
I checked it's code, the 'close(fd)' should be responsible for that.

same binary running well on mini2440(s3c2440 board).
Through several days hard work, I got the root cause.
the close called wait_until_sent with timeout(30seconds).
the uart clock source selection is different.
although both of the two boards selected 'pclk',
related register: UCON0[11:10] 0x50000004
s3c2440 use '10', s3c2442 use '00'.

on s3c2440, the '10' is selected in initialalize stage. on s3c2442, it
can't find propriate clock, so use default value '00'.

in initialize stage, it will found 'clk_uart_baud2", but not on s3c2442. I
checked 'arch/arm/mach-s3c24xx/clock-s3c2440.c', it is only registered
for s3c2440_subsys,
but not for s3c2442_sys. after registered 's3c2440_clk_lookup' for
s3c2442_subsys, everything OK.

problem:
1. I don't know the different between 00 and 10 of pck in register
UCON0[11:10].
2. why kernel code have not registered s3c2440_clk_lookup for s3c2442? and 
also
dma-s3c2440.c.

I checked 'arch/arm/mach-s3c24xx/s3c2442.c', it is for the s3c2442's clock,
but why the file name is not 'clock-s3c2442.c'? an it only contain cam
related
clock, no uart related clock.
