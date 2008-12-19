From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH/RFC] serial: Add ioctl to enable auto rs485 mode with some Exar UARTs
Date: Fri, 19 Dec 2008 16:13:29 +0100
Message-ID: <200812191613.29657.laurentp@cse-semaphore.com>
References: <200812190048.35249.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:12560 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750950AbYLSPNd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Dec 2008 10:13:33 -0500
In-Reply-To: <200812190048.35249.mfuchs@ma-fu.de>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthias Fuchs <mfuchs@ma-fu.de>
Cc: linux-serial@vger.kernel.org

Hi Matthias,

On Friday 19 December 2008 00:48:34 Matthias Fuchs wrote:
> Hi,
>
> please see my patch for enabling the RS485 half-duplex control below.
> Please note that I am using this on a PowerPC platform. So I needed to
> add the ioctl to the PowerPC header. As Wolfgang stated, it is
> already in the x86 header. I am not sure if I have to post the modification
> on the powerpc header to the PowerPC list or if it will be accepted here
> as well.  .... But first I will have to see what you think of this patch
> :-)
>
> Matthias
>
>
> Some Exar UARTs support a auto rs485 mode. In this mode
> the UART's RTS# pin is activated during transmitting and
> can be used to enable a rs485 line driver. This has nothing
> to do with attempts to do this by manually by asserting/
> deasserting handshake lines.

[snip]
> +		serial_outp(up, UART_LCR, 0xbf);
> +		fctr = serial_inp(up, UART_FCTR);
> +		if (rs485ctrl.flags & SER_RS485_ENABLED)
> +			fctr |= 0x08;
> +		else
> +			fctr &= ~0x08;
> +		serial_outp(up, UART_FCTR, fctr);
> +		serial_outp(up, UART_LCR, 0);

You might also want to add a

#define UART_FCTR_RS485	0x08

to include/linux/serial_reg.h instead of using a hardcoded 0x08 constant.

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
