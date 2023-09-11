Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D206CA0EC0
	for <linux-serial@archiver.kernel.org>; Mon, 11 Sep 2023 21:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbjIKVaY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbjIKNhg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Sep 2023 09:37:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1C8CC3
        for <linux-serial@vger.kernel.org>; Mon, 11 Sep 2023 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694439451; x=1725975451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ykxXk5glEgQgkiggXtChsLxLQ4CU5vWW9/zGtV6DIcI=;
  b=DpAY43A7u2S5n5NdxXhF7gaxf7rZ3UeW/JIdxb2Y9hqgTn1IDS2b6r4R
   g72MiguWRFXoYGDTfa0Sl63RazNMs9PuH2T98RHJOcI4vDa8fvkFM2BaD
   gCabLQxvWA8Muh45Z5dcM1ZtagnhfgKHoKFC+AplK1hkFHz1yEYAAR1Bo
   u/639eGkkcEknkHwGmI7TZl4yJ29l8OABDV8EBuVE2ALgwcR2Ttmgpyd5
   06rtdp502KG9hYMy2JT2KIrToo9p1uQop+NY8zS8e1rlap7I59fwpMljB
   YbpB9IeFFKJ90ef363guCAYgkTKCavr0RklqwVAWMy/cU7UIoZJhaFrkx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="377995113"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="377995113"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 06:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="719987265"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="719987265"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 06:37:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qfh6G-008L3v-0K;
        Mon, 11 Sep 2023 16:37:12 +0300
Date:   Mon, 11 Sep 2023 16:37:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V4 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Message-ID: <ZP8YB9EI4ahhSySP@smile.fi.intel.com>
References: <e2564a57-128e-cd9c-9bae-23b155fd8ee9@sealevel.com>
 <ZPiCPJYfiR9ZfVJC@smile.fi.intel.com>
 <375eb5e0-27db-cadf-721e-2d5c0cd150f4@sealevel.com>
 <ZPiXLdATKs2pD20d@smile.fi.intel.com>
 <f9984ae7-354f-4c14-a62d-73e51cf3ba6e@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9984ae7-354f-4c14-a62d-73e51cf3ba6e@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 11, 2023 at 09:22:45AM -0400, Matthew Howell wrote:
> On Wed, 6 Sep 2023, Andy Shevchenko wrote:
> > On Wed, Sep 06, 2023 at 11:05:20AM -0400, Matthew Howell wrote:
> > > On Wed, 6 Sep 2023, Andy Shevchenko wrote:
> > > > On Tue, Sep 05, 2023 at 12:06:20PM -0400, Matthew Howell wrote:

...

> > > > > +     if (rs485->flags & SER_RS485_ENABLED) {
> > > >
> > > > What I meant is to have
> > > >
> > > >         if (!)rs485->flags & SER_RS485_ENABLED))
> > > >                 return 0;
> > > >
> > > > here, which allows you to reduce indentation level in the below block.
> > > >
> > > > > +             /* Set EFR[4]=1 to enable enhanced feature registers */
> > > > > +             writeb(readb(p + UART_XR_EFR) | UART_EFR_ECB, p + UART_XR_EFR);
> > > > > +
> > > > > +             /* Set MCR to use DTR as Auto-RS485 Enable signal */
> > > > > +             writeb(UART_MCR_OUT1, p + UART_MCR);
> > > > > +
> > > > > +             /* Store original LCR and set LCR[7]=1 to enable access to DLD register */
> > > > > +             old_lcr = readb(p + UART_LCR);
> > > > > +             writeb(old_lcr | UART_LCR_DLAB, p + UART_LCR);
> > > > > +
> > > > > +             /* Set DLD[7]=1 for inverted RS485 Enable logic */
> > > > > +             writeb(readb(p + UART_EXAR_DLD) | UART_EXAR_DLD_485_POLARITY, p + UART_EXAR_DLD);
> > > > > +
> > > > > +             writeb(old_lcr, p + UART_LCR);
> > > > > +    }
> > > > > +
> > > > > +     return 0;
> > >
> > > I see where you are coming from now, but I find that slightly less clear
> > > than having the 'main action' within the conditional statement. And since
> > > the code is not heavily indented I don't see much benefit of removing the
> > > indent.
> > 
> > In that case it might make sense to split to two functions:
> > 
> > func1()
> > {
> >         ...
> > }
> > 
> > func2()
> > {
> >         if (...)
> >                 return func1()
> > 
> >         return 0;
> > }
> 
> I will have to respectfully disagree on this. Splitting the function into 
> two still adds additional redirection, however small, to the function.

You mean in the C code? Because in assembly it will be the same (as long as
the compiler optimisation is on).

But besides that it's a common practice to split in case the function is long
enough to be on a single screen page (meaning the body of the conditional ~20
LoCs threshold).

> I would also like to point out that the level of indent I am using is not 
> uncommon in 8250_exar.c and as such I do not find the styling of the 
> function to be out of place. 

You are probably referring to actually two functions, i.e.
pci_fastcom335_setup() and xr17v35x_register_gpio(), right?

Each of these three cases (including yours) are different. I do not think
there is a common ground to support your way by pointing out on them.

> I will resubmit and try to address the other concerns raised by you and 
> Ilpo but unless Greg KH says otherwise I don't see any reason to change 
> the indent at this time.


-- 
With Best Regards,
Andy Shevchenko


