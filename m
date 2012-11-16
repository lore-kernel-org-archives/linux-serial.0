From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty/8250_early: Turn serial_in/serial_out into weak
 symbols.
Date: Thu, 15 Nov 2012 17:11:24 -0800
Message-ID: <20121116011124.GA12506@kroah.com>
References: <20121012195102.5781c7d4@pyramind.ukuu.org.uk>
 <264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
 <20121012220604.3f99d003@pyramind.ukuu.org.uk>
 <264C179F799EF24AB26D5319053335E80CC30499A9@ezexch.ezchip.com>
 <20121013145212.27f6fcbd@pyramind.ukuu.org.uk>
 <264C179F799EF24AB26D5319053335E80CC3001073@ezexch.ezchip.com>
 <20121014133216.686277e1@pyramind.ukuu.org.uk>
 <264C179F799EF24AB26D5319053335E80CC300184F@ezexch.ezchip.com>
 <20121025121815.0689c196@pyramind.ukuu.org.uk>
 <264C179F799EF24AB26D5319053335E80CC30499FF@ezexch.ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:36830 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab2KPBL1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 20:11:27 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so908433dak.19
        for <linux-serial@vger.kernel.org>; Thu, 15 Nov 2012 17:11:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <264C179F799EF24AB26D5319053335E80CC30499FF@ezexch.ezchip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Gilad Ben Yossef <giladb@ezchip.com>

On Sun, Nov 11, 2012 at 06:34:30AM +0200, Noam Camus wrote:
> From: Noam Camus <noamc@ezchip.com>
> 
> Allows overriding default methods serial_in/serial_out.
> 
> In such platform specific replacement it is possible to use,
> other regshift, biased register offset, any other manipulation
> that is not covered with common default methods.
> 
> Overriding default methods may be useful for platforms which got
> serial peripheral with registers represented in big endian.
> In this situation and assuming that 32 bit operations / alignment
> is required then it may be useful to swab words before/after
> accessing the serial registers.
> 
> Signed-off-by: Noam Camus <noamc@ezchip.com>
> Acked-by: Alan Cox <alan@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_early.c |   42 +++++++++++++++++-----------------
>  include/linux/serial_8250.h          |    2 +
>  2 files changed, 23 insertions(+), 21 deletions(-)

This patch no longer applies to my tree.  Can you please refresh it
against the tty-next tree and resend it, with Alan's ack kept on it, so
I remember it is there?

thanks,

greg k-h
