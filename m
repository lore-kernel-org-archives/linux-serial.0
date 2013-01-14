From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] RS485 serial communication on ColdFire
Date: Sun, 13 Jan 2013 19:33:14 -0800
Message-ID: <20130114033314.GB21784@kroah.com>
References: <CAODWn4qouGj+JGZzGrJD6b1Larc7v0rWE5t=_p5xW7SnVm3ErA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:45311 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab3ANDc0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 13 Jan 2013 22:32:26 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so1921856pbb.1
        for <linux-serial@vger.kernel.org>; Sun, 13 Jan 2013 19:32:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAODWn4qouGj+JGZzGrJD6b1Larc7v0rWE5t=_p5xW7SnVm3ErA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Nguyen <afelion@gmail.com>
Cc: linux-serial@vger.kernel.org

On Mon, Jan 14, 2013 at 09:21:52AM +1000, Kevin Nguyen wrote:
> Hi
> 
> I've attached the patch that adds support RS485 communication in
> ColdFire serial driver.
> 
> As defined in Documentation/serial/serial-rs485.txt, switching between
> read or write mode can be done by toggling RTS signal that is
> supported by ColdFire chips.
> 
> I actually wrote it more than a year ago (on Linux 3.2) but haven't
> seen any similar patch for ColdFire microcontrollers so that I think
> it would be useful for someone using this serial driver for RS485
> communication. It is tested on my MCF5271 board.
> 
> Your comments are appreciated.

Is there any way to do this so that the option can be enabled at
runtime, instead of build time?  Also, getting rid of a lot of the
#ifdefs in the .c file would be great to accomplish.

thanks,

greg k-h
