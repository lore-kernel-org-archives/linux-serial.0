From: gianluca <gianluca@sottospazio.it>
Subject: Re: [PATCH] Add PCI IDs and quirks for WCH CH353 2S1P card
Date: Thu, 6 Sep 2012 08:41:09 +0200
Message-ID: <20120906064108.GA13664@server>
References: <20120828122458.GB1258@server>
 <20120828135529.6a826b19@pyramind.ukuu.org.uk>
 <20120828135720.GA2803@server>
 <20120829142815.231d5fdf@pyramind.ukuu.org.uk>
 <20120829182429.GA15239@server>
 <20120905233804.GA12305@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:52513 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753675Ab2IFGla (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Sep 2012 02:41:30 -0400
Content-Disposition: inline
In-Reply-To: <20120905233804.GA12305@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Wed, Sep 05, 2012 at 04:38:04PM -0700, Greg KH wrote:
> This patch doesn't apply at all to the tty-next branch of the linux-next
> tree, which is where I need to apply it.  Can you redo it against that
> branch and resend it so that I can apply it properly?
> 
> thanks,
> 
> greg k-h

no need for that, as it has been already submitted by Alan Cox and accepted in
your tty-next tree as commit 6971c635af27b1d18d409e337e70bae25d2fa8ec
parport_serial: Add support for the WCH353 2S/1P multi-IO card

I see my name in the Author field was mispelled, but the patch is ok :)

Thank you

Gianluca
