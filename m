From: Greg KH <greg@kroah.com>
Subject: Re: Setting PL2303 baud rate
Date: Mon, 6 May 2013 13:43:20 -0700
Message-ID: <20130506204320.GA11963@kroah.com>
References: <51881247.9050809@alice.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34387 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756836Ab3EFUnX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 May 2013 16:43:23 -0400
Content-Disposition: inline
In-Reply-To: <51881247.9050809@alice.it>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fernando Di Nucci <f.dinucci@alice.it>
Cc: linux-serial@vger.kernel.org

On Mon, May 06, 2013 at 10:27:51PM +0200, Fernando Di Nucci wrote:
> I have a PL2303HX adapter and I need to set up its baud rate to
> 1228800 or 2457600
> 
> (openwrt, linux kernel 3.3.8, coreutils 8.16 and ubuntu quantal
> 3.5.0-28, same coreutils).
> 
> I tried stty -F /dev/ttyUSB0 baudrate
> 
> Well, when baudrate is 921600 or 3000000 everything is fine, but
> when I try 1228800 or 2457600 stty complaints:
> stty: invalid argument '2457600'.
> 
> I searched stty source and added:
> 
> #ifdef B1228800
>   {"1228800", B1228800, 1228800},
> #endif
> #ifdef B2457600
>   {"2457600", B2457600, 2457600},
> #endif
> 
> and compiled but no luck. I don't know where else those values need
> also to be modified.
> 
> Can you please point me to the right direction?

I don't think stty can handle the higher baud rates, you are going to
have to do the tty ioctl commands yourself in your program.

Take a look at the cfsetospeed() man page for details.

Hope this helps,

greg k-h
