From: Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [PATCH v3 resubmit] Add support for new devices: Exar's XR17V35x
 family of multi-port PCIe UARTs
Date: Mon, 19 Nov 2012 08:52:51 -0800
Message-ID: <20121119165251.GA4393@kroah.com>
References: <CAJp1Oe4Xh6SDQc43hue5qanm7G5Lw9vMdv-+5nRQ_S+RPpRALQ@mail.gmail.com>
 <CAJp1Oe4vSwBgVe_bOV00ojvYy2fd7YWNfrEfJ+de_JSiyb7AHA@mail.gmail.com>
 <20121119152619.3752b591@pyramind.ukuu.org.uk>
 <CAJp1Oe4SKUh6w6q==pOZy-S3Xqd2LoE3jOi-3-MupxQwjOhuFg@mail.gmail.com>
 <20121119161305.GA1446@kroah.com>
 <CAJp1Oe4z5z8xfgUEBPkEsbc8PMZqwGPC-CY33kMvixnt8EMV0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38163 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753964Ab2KSQwx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Nov 2012 11:52:53 -0500
Content-Disposition: inline
In-Reply-To: <CAJp1Oe4z5z8xfgUEBPkEsbc8PMZqwGPC-CY33kMvixnt8EMV0g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Mon, Nov 19, 2012 at 10:27:19AM -0600, Matt Schulte wrote:
> On Mon, Nov 19, 2012 at 10:13 AM, Greg Kroah-Hartman <greg@kroah.com> wrote:
> > On Mon, Nov 19, 2012 at 09:34:36AM -0600, Matt Schulte wrote:
> >> On Mon, Nov 19, 2012 at 9:26 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >> > On Mon, 19 Nov 2012 09:12:04 -0600
> >> > Matt Schulte <matts@commtech-fastcom.com> wrote:
> >> >
> >> >> Add support for new devices: Exar's XR17V35x family of multi-port PCIe UARTs.
> >> >>
> >> >> Built against tty-next 54d5f88f25c38e5500a17b16240cb3775af00876
> >> >>
> >> >> Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
> >> >
> >> > Acked-by: Alan Cox <alan@linux.intel.com>
> >> >
> >> > Alan
> >>
> >> Now so that I am completely sure, because this has been Acked by Alan,
> >> this means that I can submit a patch that relies on this one?
> >
> > Yes, I'll queue this patch up in my tree in a bit, and you will get an
> > email saying where it is and what is going on with it.
> >
> 
> Does that mean that if all goes well the patch could find itself into
> the rc for 3.8?

Yes.

> Or does it take longer than that?

Nope.

See the email you get for when the patch is applied for more
information.  If you have questions about it after that, please let me
know.

thanks,

greg k-h
