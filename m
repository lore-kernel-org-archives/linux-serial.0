From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug in USB FTDI SIO driver
Date: Sat, 8 Sep 2012 18:16:34 +0100
Message-ID: <20120908181634.7c6e5c73@pyramind.ukuu.org.uk>
References: <20120908121439.15264wgwo05hva8f@webmail.axiris.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49704 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605Ab2IHRLs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Sep 2012 13:11:48 -0400
In-Reply-To: <20120908121439.15264wgwo05hva8f@webmail.axiris.be>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: peter.sheeren@axiris.be
Cc: linux-serial@vger.kernel.org

On Sat, 08 Sep 2012 12:14:39 +0200
peter.sheeren@axiris.be wrote:

> 	if (((old_priv.flags & ASYNC_SPD_MASK) !=
> 	     (priv->flags & ASYNC_SPD_MASK)) ||
> 	    (((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST) &&
> 	     (old_priv.custom_divisor != priv->custom_divisor))) {
> 		change_speed(tty, port);
> 
> Function change_speed() is called only when the baudrate  
> (custom_divisor) has changed but after a USB replug this assumption is  
> wrong. Also note that /dev/ttyUSB0 remains in existence on the system  
> under test. If it were up to me, I'd always send the baudrate setting  
> over the USB bus nomatter whether the baudrate (supposedly) has  
> changed or not.

We don't do that because if you gratuitously send speed changes that have
no effect the hardware seems to reset its configuration and you lose
characters, something a lot of software doesn't expect.

If you think that if check is the problem can you replace it with an
unconditional call to change_speed(tty, port) and the re-test. That will
confirm if it is the cause.

If it is then we can think about fixing it somehow.

Alan
