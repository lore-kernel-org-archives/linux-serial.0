From: Greg KH <greg@kroah.com>
Subject: Re: [PPC/MPC5200B] strange data loss on uart reception
Date: Sun, 31 Oct 2010 20:10:03 -0700
Message-ID: <20101101031003.GA2903@kroah.com>
References: <1288546021.1866.1@antares>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:44873 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755272Ab0KADKl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 31 Oct 2010 23:10:41 -0400
Content-Disposition: inline
In-Reply-To: <1288546021.1866.1@antares>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Albrecht Dre? <albrecht.dress@arcor.de>
Cc: linux-serial@vger.kernel.org

On Sun, Oct 31, 2010 at 06:27:00PM +0100, Albrecht Dre? wrote:
 Am I simply too dumb to use the uart correctly, or is there some issue
> in the kernel causing this effect?  I noticed that the function
> mpc52xx_uart_int_rx_chars() does not check the return value of
> tty_insert_flip_char().  If the system runs out of space (actually,
> the maximum buffer size used should be limited, in particular on
> embedded systems!), might this go undetected?  This might explain the
> bigger "chunks", as the '5200's uart has a rather big fifo (512
> bytes).

That might help, have you tried changing this and seeing if it fixes
anything?

Also, are you sure your userspace application is checking the return
value of write() to verify that it really wrote everything it thought it
did?

thanks,

greg k-h
