From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] atmel-serial: fix RS485 half-duplex problem
Date: Tue, 27 Mar 2012 10:54:33 -0700
Message-ID: <20120327175433.GA6623@kroah.com>
References: <6FF0F449D45DEE479E93D93A0C07A8BD025E8F0631@USROCEX01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44451 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab2C0Ryi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Mar 2012 13:54:38 -0400
Received: by gghe5 with SMTP id e5so178216ggh.19
        for <linux-serial@vger.kernel.org>; Tue, 27 Mar 2012 10:54:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6FF0F449D45DEE479E93D93A0C07A8BD025E8F0631@USROCEX01>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Siftar, Gabe" <Gabe.Siftar@getingeusa.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Claudio Scordino <claudio@evidence.eu.com>, Bernhard Roth <br@pwrnet.de>

On Tue, Mar 27, 2012 at 01:43:39PM -0400, Siftar, Gabe wrote:
> On our custom board, we are using RS485 in half-duplex mode on an AT91SAM9G45. 
> SER_RS485_RX_DURING_TX is not set as we do not want to receive the data we 
> transmit (our transceiver will receive transmitted data).  Although the current 
> driver attempts to disable and enable the receiver at the appropriate points, 
> incoming data is still loaded into the receive register causing our code to 
> receive the very last byte that was sent once the receiver is enabled.
>  
> I ran this by Atmel support and they wrote:  "The issue comes from the fact 
> that you disable the PDC/DMA Reception and not the USART Reception channel.  In 
> your case, the[n] you will still receive data into the USART_RHR register, and 
> maybe you [h]ave the overun flag set.  So please disable the USART reception 
> channel."
>   
> The following patch should force the driver to enable/disable the receiver via 
> RXEN/RXDIS fields of the USART control register.  It fixed the issue I was 
> having - perhaps others will find it useful as well.
> 
> Signed-off-by: Gabe Siftar <gabe.siftar@getingeusa.com>

That's nice, but:

> This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to which they are addressed. If you have received this email in error please notify the system manager. This message contains confidential information and is intended only for the individual named. If you are not the named addressee you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately by e-mail if you have received this e-mail by mistake and delete this e-mail from your system. If you are not the intended recipient you are notified that disclosing, copying, distributing or taking any action in reliance on the contents of this information is strictly prohibited.--

This footer just contridicted your signed-off-by:

So, what should I believe?

Hint, please remove such footers, and tell anyone who insists on them
that they directly prevent you from contributing to the kernel, as I can
not accept patches with this on it.

Care to resend this without the footer so I can accept it?

greg k-h
