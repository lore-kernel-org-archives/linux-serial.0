From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Questions regarding adding a patch in linux/drivers/char/8250.c
Date: Mon, 21 May 2012 10:28:48 +0100
Message-ID: <20120521102848.7bfb49e0@pyramind.ukuu.org.uk>
References: <00a301cd3719$b3faa370$1befea50$@com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52969 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455Ab2EUJZ4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 May 2012 05:25:56 -0400
In-Reply-To: <00a301cd3719$b3faa370$1befea50$@com.tw>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Donald <donald@asix.com.tw>
Cc: linux-serial@vger.kernel.org

On Mon, 21 May 2012 14:19:34 +0800
"Donald" <donald@asix.com.tw> wrote:

> Hi,
> 
> This is Donald from ASIX Electronics Corp. My company has three PCI to Serial controllers, including MCS9845, MCS9835, and MCS9820.
> Currently those serial devices using these three chips can directly use the Linux kernel's serial driver in
> linux/drivers/char/8250.c. Recently we find these three chips have a hardware bug relating to parity error count function. We have a
> software workaround for this issue. Below for reference is a pseudo code for this workaround.
> 
> serial8250_do_set_termios() {
> 	If ((PID == MCS9845 || PID == MCS935 || PID == MCS9820) && ((termios->c_cflag & PARENB))) {
> 		port->fifosize = 1; /* Change RX FIFO size to 1 byte */
> 		up->ier &= ~UART_IER_RLSI; /* Disable RLSI interrupt */
> 	}	
> }
> 
> Is it possible to add a patch into linux/drivers/char/8250.c for our chips' hardware issue? 

Sure.

The only question I would have is how do we reliably detect the presence
of the UART devices with this erratum. Can we do it from the PCI
identifier ?

Alan
