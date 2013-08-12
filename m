From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Where is TX buffer in driver based on struct uart_port
Date: Mon, 12 Aug 2013 08:22:31 -0400
Message-ID: <5208D387.40206@hurleysoftware.com>
References: <DB8F1B3EEF94C3439BFFE674EB05E3CC2409A892@SINPRD0211MB405.apcprd02.prod.outlook.com>,<52031B12.8090204@beamcommunications.com> <DB8F1B3EEF94C3439BFFE674EB05E3CC240B21DB@SINPRD0211MB405.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:53032 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752052Ab3HLMWe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Aug 2013 08:22:34 -0400
In-Reply-To: <DB8F1B3EEF94C3439BFFE674EB05E3CC240B21DB@SINPRD0211MB405.apcprd02.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Craig McQueen <craig.mcqueen@beamcommunications.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On 08/12/2013 03:55 AM, Craig McQueen wrote:
> I'd really appreciate any advice that anyone can offer on this.
>
> I've also observed similar behaviour on a PC with a PCI serial card, running Ubuntu 13.04 with kernel 3.8.0. The serial TX buffer is around 4000 bytes, which when full is 17 seconds of latency at 2400 bps.
>
> Is there some userspace ioctl() call or tcsetattr() call available to change the TX buffer size from a userspace application? Or do I need to change the TX buffer size somehow in the serial driver itself?

With the N_TTY line discipline, you can use the TIOCOUTQ ioctl
to query how much data is still in the tx fifo. I didn't look into
how that would be done with PPP because the net fifos will buffer
outbound data as well.

You may be reduced to writing data at the desired line rate in the
application.

> ________________________________________
> From: linux-serial-owner@vger.kernel.org [linux-serial-owner@vger.kernel.org] on behalf of Craig McQueen [craig.mcqueen@beamcommunications.com]
> Sent: Thursday, 8 August 2013 2:14 PM
> To: linux-serial@vger.kernel.org
> Subject: Re: Where is TX buffer in driver based on struct uart_port
>
> On 07/08/13 22:01, Craig McQueen wrote:
>> I'm running a Freescale ARM i.MX28, with a UART driver "mxs-auart.c" based on struct uart_port in Linux kernel 2.6.35.
>>
>> I'm using it in a radio communications application that operates at 2400 bps.
>>
>> I'm finding that when transmitting data, the TX data is being buffered somewhere in the drivers, and the buffer size appears to be something like 4000 bytes. At 2400 bps, that works out to be something like 17 seconds of buffering, which causes too much end-to-end delay in the pipeline when the buffer is full.
>>
>> So I'd like to find where this 4000 byte buffer is, with the goal of reducing its size to reduce the maximum end-to-end delay. But looking through the code for the driver, it's not obvious to me so far where this buffering might be happening. Can anyone point me in the general direction?

The tx buffer is allocated in uart_port_startup(). The tx fifo is assumed to be
1 page in size and is defined system-wide in include/linux/serial_core.h:

	#define UART_XMIT_SIZE	PAGE_SIZE

>> Ultimately I want to do PPP through this serial device. Would this 4000 byte buffer also apply in a PPP line discipline scenario?
>>
>> (I've previously experimented with modifications to another serial driver "tty0tty" based on struct tty_driver, and I could control TX buffering in the struct tty_operations -> write and write_room functions. But this driver using struct uart_port doesn't seem such easy to understand write operations.)
>
> I realised that the driver has several references to PAGE_SIZE, which is
> 4096 for ARM. Also several of UART_XMIT_SIZE which is defined as
> PAGE_SIZE in serial_core.h. (Some of the references to PAGE_SIZE are
> relating to DMA; I am not using DMA currently.)
>
> Is it easy to change these values, or override them in serial_core? I'm
> fairly inexperienced with Linux serial architecture.

No, the UART miniport design does not envision your use-case and thus makes
no provision for it.

Regards,
Peter Hurley
