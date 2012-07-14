From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: of_serial: add no-loopback-test property
Date: Sat, 14 Jul 2012 07:04:57 -0700
Message-ID: <20120714140457.GA23878@kroah.com>
References: <1342267580-3672-1-git-send-email-juhosg@openwrt.org>
 <20120714150101.1810c829@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53343 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab2GNOFC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jul 2012 10:05:02 -0400
Received: by pbbrp8 with SMTP id rp8so7207325pbb.19
        for <linux-serial@vger.kernel.org>; Sat, 14 Jul 2012 07:05:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120714150101.1810c829@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gabor Juhos <juhosg@openwrt.org>, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-serial@vger.kernel.org

On Sat, Jul 14, 2012 at 03:01:01PM +0100, Alan Cox wrote:
> On Sat, 14 Jul 2012 14:06:20 +0200
> Gabor Juhos <juhosg@openwrt.org> wrote:
> 
> > The loopback test mode is not implemented in all
> > NS16550 compatible UARTs. The 8250 driver uses the
> > UPF_SKIP_TEST flag to indicate this, however it is
> > not possible to set this flag via device-tree.
> > 
> > Add a new 'no-loopback-test' property, and modify
> > the of_serial driver to set the UPF_SKIP_TEST flag
> > if the property is present.
> > 
> > Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> 
> Looks good to me but clashes with the sync of the termios changes, which
> we urgently need to get in first.
> 
> Greg - I'll add this to my patch stack with the relevant changes so that
> it doesn't get messed up.

Ok, thanks for doing that.

greg k-h
