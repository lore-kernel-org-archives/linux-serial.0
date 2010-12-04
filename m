From: Ondrej Puzman <puzman@gmail.com>
Subject: Re: Bug in 8250.c - uninitialized FIFOs
Date: Sat, 4 Dec 2010 21:17:38 +0100
Message-ID: <20101204201738.GD30648@postman.amit.cz>
References: <4CF92F40.5070004@gmail.com> <20101203184536.GA17665@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from postman.amit.cz ([188.95.124.147]:41747 "EHLO postman.amit.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab0LDU1Z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 4 Dec 2010 15:27:25 -0500
Content-Disposition: inline
In-Reply-To: <20101203184536.GA17665@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

On Fri, Dec 03, 2010 at 10:45:36AM -0800, Greg KH wrote: 
> I would like to include it, but I need it in a form I can apply it in.
> Your email client turned the tabs to spaces, and I need a
> "Signed-off-by:" line in order to be able to apply it.  Take a look at
> the file, Documentation/SubmittingPatches for details about this.
> 
> Care to fix this and resend it so I can apply it?
> 

Ok, here is a new attempt with another email client. I hope that the message
format will be ok now.

Ondrej

Signed-off-by: Ondrej Puzman <puzman@gmail.com>

--- ./drivers/serial/8250.c.orig	2010-11-22 20:03:49.000000000 +0100
+++ ./drivers/serial/8250.c	2010-12-03 18:42:22.000000000 +0100
@@ -1952,6 +1952,8 @@ static int serial8250_startup(struct uar
 	unsigned char lsr, iir;
 	int retval;
 
+	up->port.fifosize = uart_config[up->port.type].fifo_size;
+	up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
 	up->capabilities = uart_config[up->port.type].flags;
 	up->mcr = 0;
 
