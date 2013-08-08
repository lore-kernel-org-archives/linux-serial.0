From: Craig McQueen <craig.mcqueen@beamcommunications.com>
Subject: Re: Where is TX buffer in driver based on struct uart_port
Date: Thu, 8 Aug 2013 14:14:10 +1000
Message-ID: <52031B12.8090204@beamcommunications.com>
References: <DB8F1B3EEF94C3439BFFE674EB05E3CC2409A892@SINPRD0211MB405.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:23402
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751899Ab3HHEOS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 00:14:18 -0400
Received: from mail117-co9 (localhost [127.0.0.1])	by
 mail117-co9-R.bigfish.com (Postfix) with ESMTP id 3B99AC400C7	for
 <linux-serial@vger.kernel.org>; Thu,  8 Aug 2013 04:14:17 +0000 (UTC)
Received: from CO9EHSMHS005.bigfish.com (unknown [10.236.132.245])	by
 mail117-co9.bigfish.com (Postfix) with ESMTP id 720F5440049	for
 <linux-serial@vger.kernel.org>; Thu,  8 Aug 2013 04:14:15 +0000 (UTC)
In-Reply-To: <DB8F1B3EEF94C3439BFFE674EB05E3CC2409A892@SINPRD0211MB405.apcprd02.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On 07/08/13 22:01, Craig McQueen wrote:
> I'm running a Freescale ARM i.MX28, with a UART driver "mxs-auart.c" based on struct uart_port in Linux kernel 2.6.35.
>
> I'm using it in a radio communications application that operates at 2400 bps.
>
> I'm finding that when transmitting data, the TX data is being buffered somewhere in the drivers, and the buffer size appears to be something like 4000 bytes. At 2400 bps, that works out to be something like 17 seconds of buffering, which causes too much end-to-end delay in the pipeline when the buffer is full.
>
> So I'd like to find where this 4000 byte buffer is, with the goal of reducing its size to reduce the maximum end-to-end delay. But looking through the code for the driver, it's not obvious to me so far where this buffering might be happening. Can anyone point me in the general direction?
>
> Ultimately I want to do PPP through this serial device. Would this 4000 byte buffer also apply in a PPP line discipline scenario?
>
> (I've previously experimented with modifications to another serial driver "tty0tty" based on struct tty_driver, and I could control TX buffering in the struct tty_operations -> write and write_room functions. But this driver using struct uart_port doesn't seem such easy to understand write operations.)

I realised that the driver has several references to PAGE_SIZE, which is 
4096 for ARM. Also several of UART_XMIT_SIZE which is defined as 
PAGE_SIZE in serial_core.h. (Some of the references to PAGE_SIZE are 
relating to DMA; I am not using DMA currently.)

Is it easy to change these values, or override them in serial_core? I'm 
fairly inexperienced with Linux serial architecture.

Craig McQueen

