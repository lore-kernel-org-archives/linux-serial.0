From: Craig McQueen <craig.mcqueen@beamcommunications.com>
Subject: Where is TX buffer in driver based on struct uart_port
Date: Wed, 7 Aug 2013 12:01:06 +0000
Message-ID: <DB8F1B3EEF94C3439BFFE674EB05E3CC2409A892@SINPRD0211MB405.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:14241
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932544Ab3HGMBS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Aug 2013 08:01:18 -0400
Received: from mail17-ch1 (localhost [127.0.0.1])	by mail17-ch1-R.bigfish.com
 (Postfix) with ESMTP id 43F2430030D	for <linux-serial@vger.kernel.org>; Wed,
  7 Aug 2013 12:01:16 +0000 (UTC)
Received: from CH1EHSMHS025.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.231])	by mail17-ch1.bigfish.com (Postfix) with ESMTP id 36DE448004D
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2013 12:01:14 +0000 (UTC)
Content-Language: en-AU
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

I'm running a Freescale ARM i.MX28, with a UART driver "mxs-auart.c" based on struct uart_port in Linux kernel 2.6.35.

I'm using it in a radio communications application that operates at 2400 bps.

I'm finding that when transmitting data, the TX data is being buffered somewhere in the drivers, and the buffer size appears to be something like 4000 bytes. At 2400 bps, that works out to be something like 17 seconds of buffering, which causes too much end-to-end delay in the pipeline when the buffer is full.

So I'd like to find where this 4000 byte buffer is, with the goal of reducing its size to reduce the maximum end-to-end delay. But looking through the code for the driver, it's not obvious to me so far where this buffering might be happening. Can anyone point me in the general direction?

Ultimately I want to do PPP through this serial device. Would this 4000 byte buffer also apply in a PPP line discipline scenario?

(I've previously experimented with modifications to another serial driver "tty0tty" based on struct tty_driver, and I could control TX buffering in the struct tty_operations -> write and write_room functions. But this driver using struct uart_port doesn't seem such easy to understand write operations.)

Thanks,
Craig McQueen

