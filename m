From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: 8250 check iir rdi in interrupt
Date: Fri, 26 Oct 2012 15:19:02 +0100
Message-ID: <20121026151902.0a382d16@pyramind.ukuu.org.uk>
References: <alpine.LFD.2.02.1210221633450.28146@nightowl>
	<20121023110133.62bed522@pyramind.ukuu.org.uk>
	<CAJ0e-Fofs48N9VnYr1_8Kch6+yHjGx9iCWBRtRsqpD-B_rWutQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55383 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933043Ab2JZOOA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Oct 2012 10:14:00 -0400
In-Reply-To: <CAJ0e-Fofs48N9VnYr1_8Kch6+yHjGx9iCWBRtRsqpD-B_rWutQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Min Zhang <mzhang@mvista.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> It is racing. For "too much work for irq", here is sequence events
> analyzed by a Motorola engineer:

Thanks - this is enormously helpful in understanding the report.

>         5) The LSR indicates that the transmitter needs data,
> but also indicates the presence of data in the FIFO (0x61 in the LSR)
>         6) The processing function receives the characters, and
> outputs data to the FIFO
>         7) At the exact time (very very small window) that the
> character is read from the FIFO, the FIFO timeout occurs locking in an
> interrupt cause
>         8) The next loop through the interrupt code begins
>         9) The IIR now indicates the data timeout interrupt
> (0xCC in the IIR)
>         10) The processing function is called and it reads the
> LSR
>         11) The LSR is 0 indicating nothing to do

>         12) The interrupt loop continues (the IIR won't clear
> until a character is pulled) until it reaches its max count and
> displays the error.

So we only need to check this in serial8250_handle_irq when IIR indicates
a data timeout interrupt ? 

Can we do

	if ((iir & 0x0F) == 0x0C) {
		/* Expensive RDI check */
	}



Alan
