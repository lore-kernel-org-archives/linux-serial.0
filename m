From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Add PCI IDs and quirks for WCH CH353 2S1P card
Date: Wed, 5 Sep 2012 16:38:04 -0700
Message-ID: <20120905233804.GA12305@kroah.com>
References: <20120828122458.GB1258@server>
 <20120828135529.6a826b19@pyramind.ukuu.org.uk>
 <20120828135720.GA2803@server>
 <20120829142815.231d5fdf@pyramind.ukuu.org.uk>
 <20120829182429.GA15239@server>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49318 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab2IEXki (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Sep 2012 19:40:38 -0400
Received: by ieje11 with SMTP id e11so2042701iej.19
        for <linux-serial@vger.kernel.org>; Wed, 05 Sep 2012 16:40:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120829182429.GA15239@server>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gianluca <gianluca@sottospazio.it>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Wed, Aug 29, 2012 at 08:24:29PM +0200, gianluca wrote:
> Add new PCI ids for WCH CH353 2Serial 1Parallel Multi-IO PCI Card to
> parport_serial.c.
> 
> To allow parport_serial to handle the card the same PCI ids are blacklisted
> in 8250_pci.c using the existing softmodem blacklist mechanism.
> 
> The blacklist array is also renamed because it now covers this new use case.
> 
> Since the two serial ports are autodetected as XScale instead of 16550A clones,
> add also a quirk to 8250_pci.c to skip autodetection and set the correct port
> type.
> 
> The patch is against linux v3.5.3 but applies cleanly also to latest git head.

This patch doesn't apply at all to the tty-next branch of the linux-next
tree, which is where I need to apply it.  Can you redo it against that
branch and resend it so that I can apply it properly?

thanks,

greg k-h
