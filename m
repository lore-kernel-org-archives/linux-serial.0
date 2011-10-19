From: Greg KH <gregkh@suse.de>
Subject: Re: patch "tty/serial: atmel_serial: auto-enumerate ports" added to
 tty tree
Date: Wed, 19 Oct 2011 08:35:44 -0700
Message-ID: <20111019153544.GB2289@suse.de>
References: <1318981651741@kroah.org>
 <4E9E9AF4.1050105@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44603 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782Ab1JSPgs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Oct 2011 11:36:48 -0400
Content-Disposition: inline
In-Reply-To: <4E9E9AF4.1050105@atmel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: grant.likely@secretlab.ca, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Wed, Oct 19, 2011 at 11:40:04AM +0200, Nicolas Ferre wrote:
> On 10/19/2011 01:47 AM, gregkh@suse.de :
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     tty/serial: atmel_serial: auto-enumerate ports
> > 
> > to my tty git tree which can be found at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> > in the tty-next branch.
> > 
> > The patch will show up in the next release of the linux-next tree
> > (usually sometime within the next 24 hours during the week.)
> > 
> > The patch will also will be merged in the next major kernel release
> > during the merge window.
> > 
> > If you have any questions about this process, please let me know.
> 
> Hi Greg,
> 
> Thanks for taking this series into your tree.
> 
> Can you please consider folding or adding the patch that I have just sent.
> It corrects this auto-enumerate implementation and its name is:
> "tty/serial: atmel_serial: bootconsole removed from auto-enumerates"

Now applied.

thanks,

greg k-h
