From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 0/4] OMAP: Serial: remove magic and diplicates
Date: Fri, 12 Nov 2010 09:01:01 -0800
Message-ID: <20101112170101.GC9264@atomide.com>
References: <1289567043-6213-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20101112150143.GA18096@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54776 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab0KLRBL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Nov 2010 12:01:11 -0500
Content-Disposition: inline
In-Reply-To: <20101112150143.GA18096@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.arm.linux.org.uk, linux-serial@vger.kernel.org

* Greg KH <greg@kroah.com> [101112 06:54]:
> On Fri, Nov 12, 2010 at 03:03:59PM +0200, Emeltchenko Andrei wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> > 
> > Add MDR1 Serial register definition to serial_reg and remove duplicated
> > code, remove magic MDR1 register numbers from serial drivers.
> > 
> > *v2 add OMAP keyword to MDR1 definition
> > *v3 remove magic from serial drivers
> > *v4 taking comments from Manjunath and Govindraj: typos, CC
> > 
> > Andrei Emeltchenko (4):
> >   OMAP: Serial: Define OMAP uart MDR1 register definitions
> >   OMAP1: Serial: remove magic numbers for MDR1 reg
> >   OMAP2: Serial: remove magic numbers for MDR1 reg
> >   OMAP: Serial: remove redefined MDR1 register definitions
> 
> Looks good, do you want these to go through the omap tree, or the serial
> tree?
> 
> If they go through the omap tree, feel free to add:
> 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Thanks, I can queue these. There will be some other platform level
serial changes done for wake-up events, so it's best to keep
them all together.

Regards,

Tony
