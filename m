From: ZhangXiao <xiao.zhang@windriver.com>
Subject: Output character lost with 8250 UART driver
Date: Wed, 25 Jun 2008 16:06:42 +0800
Message-ID: <1214381202.6938.76.camel@xzhang1-desktop>
Reply-To: xiao.zhang@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:38051 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbYFYIIk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Jun 2008 04:08:40 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m5P88b33003177
	for <linux-serial@vger.kernel.org>; Wed, 25 Jun 2008 01:08:37 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: xiao.zhang@windriver.com, Paul Gortmaker <paul.gortmaker@windriver.com>

Hi,

When I boot one of my target I find the UART(8250) works improperly.
Sometimes lost output characters. When I dig in the 8250.c I find
something strange in function transmit_chars. 

Below is the very piece of this function:

...
1	count = up->tx_loadsz;
2	do {
3		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
4		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
5		up->port.icount.tx++;
6		if (uart_circ_empty(xmit))
7			break;
8	} while (--count > 0);
...

Based on theses lines, characters should be written to the THR
continuous, no matter if it had already move the character to the TSR. I
think it is not safe in some cases so I add a line

	wait_for_xmitr(up, UART_LSR_THRE);

before line 3. And then the issue in my target was disappeared. This is
a static function that was already exist in the same file. It just check
and wait until the THR was empty.

I noticed that in the same file (8250.c), in console part, all data
written to THR was protected by the "wait_for_xmitr". So for the
function "transmit_chars", does that a bug and should be resolved? Or
there are any reasons that it needn't this protection?

Thanks a lot
Xiao
