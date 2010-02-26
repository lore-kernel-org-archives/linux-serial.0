From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: Add driver for the Altera JTAG UART
Date: Fri, 26 Feb 2010 11:27:15 +0000
Message-ID: <20100226112715.207bbd13@lxorguk.ukuu.org.uk>
References: <1267108523-32767-1-git-send-email-tklauser@distanz.ch>
	<20100225152622.7eb479aa@lxorguk.ukuu.org.uk>
	<20100226090456.GA32296@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57049 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934303Ab0BZLXs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Feb 2010 06:23:48 -0500
In-Reply-To: <20100226090456.GA32296@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org

> > Use tty_termios_copy_hw() to copy the old termios hardware settings back
> > so that the caller sees it cannot set them.
> 
> Would the following be sufficient?
> 
>   if (old)
>           tty_termios_copy_hw(termios, old);

That will do the trick yes.

>   spin_lock(&port->lock);
> 
>   if (isr & ALTERA_JTAGUART_CONTROL_RE_MSK)
>           altera_jtaguart_rx_chars(pp);
>   if (isr & ALTERA_JTAGUART_CONTROL_WE_MSK)
>           altera_jtaguart_tx_chars(pp);
> 
>   spin_unlock(&port->lock);

Yes - that stops ->tty becoming NULL while your handler is running

Alan
