From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial: altera_uart: Check for NULL platform_data
 in probe.
Date: Thu, 29 Mar 2012 12:47:11 -0700
Message-ID: <20120329194711.GB12194@kroah.com>
References: <1333007727-24045-1-git-send-email-tklauser@distanz.ch>
 <20120329161337.GA28858@kroah.com>
 <20120329193855.GW21503@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44450 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758786Ab2C2TrP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Mar 2012 15:47:15 -0400
Received: by pbcun15 with SMTP id un15so544965pbc.19
        for <linux-serial@vger.kernel.org>; Thu, 29 Mar 2012 12:47:15 -0700 (PDT)
In-Reply-To: <20120329193855.GW21503@distanz.ch>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, Yuriy Kozlov <ykozlov@ptcusa.com>

On Thu, Mar 29, 2012 at 09:38:55PM +0200, Tobias Klauser wrote:
> On 2012-03-29 at 18:13:37 +0200, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > On Thu, Mar 29, 2012 at 09:55:27AM +0200, Tobias Klauser wrote:
> > > From: Yuriy Kozlov <ykozlov@ptcusa.com>
> > > 
> > > Follow altera_jtag_uart.  This fixes a crash if there is a mistake in the DTS.
> > 
> > Is this something you have seen in the wild?  Is this something to be
> > backported to stable kernels?
> 
> Not that I know of. But nevertheless it might be worthwhile. Shall I
> send the patch again with Cc: stable@kernel.org?

Nope, I can add it.

But, if this isn't something that you have seen, why is it needed to be
checked for?  What is this making work properly that isn't working
properly now?

thanks,

greg k-h
