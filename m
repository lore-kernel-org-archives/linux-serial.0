Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE16EE14A5
	for <linux-serial@archiver.kernel.org>; Wed,  6 Sep 2023 15:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242180AbjIFPN7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjIFPN7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Sep 2023 11:13:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E392FE64
        for <linux-serial@vger.kernel.org>; Wed,  6 Sep 2023 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694013235; x=1725549235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rSEj+Pmvhe26xfdoZB07Xcv0LB53AdwXbkTfJa0/Amw=;
  b=bCgcZfKx8HT2HFZmYbJwN2ZpHTytSshX5LNmaUSToQl45/ohSxAaFwbU
   pCX/RVuZO9E01xVNFa/zl59En8FlJ8vNOTk1xUfYOwW/sLXqHgV/fKsuZ
   V34Zzbjs9PMLluFvL0pLLg7fA4prWhWfXafbb9Xzlj3GBOPoiEn1HTB+v
   dR+sk3Q3MnytkqsjZ8tYHjWPqvP7yZlg6RaoPLCsIRxO+z2wfSwsaJIZu
   99wy+PFCvW4MqDGnP8iMzS51PwUQNWbW7TYWgbSp/fPPexktZXwj5F6GA
   SEe9mO9eS/0iEhsKh0T8NN4E5TSfEWOcOaR0f0OKMinI6IoJHyOuO6j43
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="463468580"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="463468580"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="776648322"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="776648322"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:13:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qduE2-006yVb-0Z;
        Wed, 06 Sep 2023 18:13:50 +0300
Date:   Wed, 6 Sep 2023 18:13:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V4 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Message-ID: <ZPiXLdATKs2pD20d@smile.fi.intel.com>
References: <e2564a57-128e-cd9c-9bae-23b155fd8ee9@sealevel.com>
 <ZPiCPJYfiR9ZfVJC@smile.fi.intel.com>
 <375eb5e0-27db-cadf-721e-2d5c0cd150f4@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <375eb5e0-27db-cadf-721e-2d5c0cd150f4@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 06, 2023 at 11:05:20AM -0400, Matthew Howell wrote:
> On Wed, 6 Sep 2023, Andy Shevchenko wrote:
> > On Tue, Sep 05, 2023 at 12:06:20PM -0400, Matthew Howell wrote:

...

> > > +     generic_rs485_config(port, termios, rs485);
> > 
> > > +     if (rs485->flags & SER_RS485_ENABLED) {
> > 
> > What I meant is to have
> > 
> >         if (!)rs485->flags & SER_RS485_ENABLED))
> >                 return 0;
> > 
> > here, which allows you to reduce indentation level in the below block.
> > 
> > > +             /* Set EFR[4]=1 to enable enhanced feature registers */
> > > +             writeb(readb(p + UART_XR_EFR) | UART_EFR_ECB, p + UART_XR_EFR);
> > > +
> > > +             /* Set MCR to use DTR as Auto-RS485 Enable signal */
> > > +             writeb(UART_MCR_OUT1, p + UART_MCR);
> > > +
> > > +             /* Store original LCR and set LCR[7]=1 to enable access to DLD register */
> > > +             old_lcr = readb(p + UART_LCR);
> > > +             writeb(old_lcr | UART_LCR_DLAB, p + UART_LCR);
> > > +
> > > +             /* Set DLD[7]=1 for inverted RS485 Enable logic */
> > > +             writeb(readb(p + UART_EXAR_DLD) | UART_EXAR_DLD_485_POLARITY, p + UART_EXAR_DLD);
> > > +
> > > +             writeb(old_lcr, p + UART_LCR);
> > > +    }
> > > +
> > > +     return 0;
> 
> I see where you are coming from now, but I find that slightly less clear 
> than having the 'main action' within the conditional statement. And since 
> the code is not heavily indented I don't see much benefit of removing the 
> indent.

In that case it might make sense to split to two functions:

func1()
{
	...
}

func2()
{
	if (...)
		return func1()

	return 0;
}

-- 
With Best Regards,
Andy Shevchenko


