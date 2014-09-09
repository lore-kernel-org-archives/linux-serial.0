From: Johannes Thumshirn <johannes.thumshirn@men.de>
Subject: Re: [PATCH] tty: serial: men_z135_uart: Fix driver for changes in
 hardware
Date: Tue, 9 Sep 2014 07:56:15 +0200
Message-ID: <20140909055615.GA10306@jtlinux>
References: <1409229140-14407-1-git-send-email-johannes.thumshirn@men.de>
 <20140908231733.GB23907@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.106]:24460 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755350AbaIIFwn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Sep 2014 01:52:43 -0400
Content-Disposition: inline
In-Reply-To: <20140908231733.GB23907@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Thumshirn <johannes.thumshirn@men.de>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 08, 2014 at 04:17:33PM -0700, Greg Kroah-Hartman wrote:
> >
> > @@ -118,6 +117,10 @@ static int align;
> >  module_param(align, int, S_IRUGO);
> >  MODULE_PARM_DESC(align, "Keep hardware FIFO write pointer aligned, default 0");
> >
> > +static int rx_timeout;
> > +module_param(rx_timeout, uint, S_IRUGO);
> > +MODULE_PARM_DESC(rx_timeout, "RX timeout");
>
> Why add a module parameter?  Who will know to set this?  And to what
> value?
>

There will be a user manual describing the parameter. It's like the rxlvl and
txlvl parameters, you'll have to read the manual if you need other values than
the default ones.


> And what about this driver working on old hardware, didn't you just
> break this?
>

No. Currently the hardware is in a testing stage at only one customer and it is
an IP-Core inside a FPGA, so it can be (and already is) updated. So we can be
save to assume this is O.K.

> thanks,
>
> greg k-h

Hope that helped.
Johannes
