From: =?iso-8859-1?Q?Chris_Dor=E9?= <cdore@connecttech.com>
Subject: RE: Handling RTS
Date: Mon, 14 Jan 2008 10:05:03 -0500
Message-ID: <005401c856be$d8db3a00$8a91ae00$@com>
References: <008101c852ff$36201730$a2604590$@com> <OF13421728.28514CCE-ONC12573CC.002D2F04-C12573CC.002E6D4E@cemitec.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inetc.connecttech.com ([64.7.140.42]:4463 "EHLO
	inetc.connecttech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbYANPFW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jan 2008 10:05:22 -0500
Received: from connecttech.com (cti2.connecttech.com [206.130.75.42])
	by inetc.connecttech.com (8.13.3P/8.13.3) with ESMTP id m0EF5LUO018644
	for <linux-serial@vger.kernel.org>; Mon, 14 Jan 2008 10:05:21 -0500 (EST)
	(envelope-from cdore@connecttech.com)
Received: from cdore ([206.130.75.122]) by connecttech.com (8.10.1/UW7.1.1-NSCd) with ESMTP id m0EF55V02939 for <linux-serial@vger.kernel.org>; Mon, 14 Jan 2008 10:05:05 -0500 (EST)
In-Reply-To: <OF13421728.28514CCE-ONC12573CC.002D2F04-C12573CC.002E6D4E@cemitec.com>
Content-Language: en-ca
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>

> From: linux-serial-owner@vger.kernel.org [mailto:linux-serial-
> owner@vger.kernel.org] On Behalf Of JZabalza@cemitec.com
> Sent: January 10, 2008 3:27 AM
> To: linux-serial
> Subject: RE: Handling RTS
> 
>         Thanks for your response. I have a PC, so dmesg said
> 
>                 serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> 
>         How I said, I just handle RTS but from userland. This means a big
> latency between RTS activation and begin out data. I want only reduce this
> latency activating RTS on driver. My question is, is this *protocol*
> implemented actually or I must implement them.

I'm not an expert on the current 8250 driver, but I believe you will have to
implement your 485 control.

We may have done this in one of our drivers, but in my quick search I can't
find one that doesn't take advantage of the extra features supplied by the
UARTs we use.


Best of luck, Chris


