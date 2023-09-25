Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B308CE7A89
	for <linux-serial@archiver.kernel.org>; Mon, 25 Sep 2023 08:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjIYIk7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Sep 2023 04:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjIYIk4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Sep 2023 04:40:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9FC1A6
        for <linux-serial@vger.kernel.org>; Mon, 25 Sep 2023 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695631250; x=1727167250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ev4kaOC17+JbTgxkvjK1FarmIKgy0esyIYa88N3PAfo=;
  b=QnEPPlzLYbENT1oXqdq1d8WEZ5tdG/AdcF8EIJJGVvcqi7Qo4heqfmEf
   9rs9ddxGtIw9LavseghG5Fq5/bg1r8dVWdk9iwu+ahbO5fKJiXtMVWM4a
   y1uteMxMZ+JiRyf5tGaMK5FIpRSd8sPAvhn50U2sjqnFdR4kdJWlva1Tf
   JtKn1BSSp/n2zmFZcfOa7gAIYWnif8MFAGJ5JRbsqBAzesmhacI/9WU58
   4GFW7/A5TuvMAj+6SSXhRBG1arTtD4cLXh6OzGcLbBNR3xu9p4Q7QHBwC
   zHKCN7C6/bVYFoHInL0sQCHV3OsmF/vvfbFReJx1cGUviVckEl+7TOOzi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378469544"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="378469544"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 01:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748285942"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="748285942"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 01:40:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qkh8z-00000000IKh-0dfc;
        Mon, 25 Sep 2023 11:40:41 +0300
Date:   Mon, 25 Sep 2023 11:40:40 +0300
From:   "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Darren Beeson <darren.beeson@sealevel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jeff Baldwin <jeff.baldwin@sealevel.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>,
        James Olson <james.olson@sealevel.com>
Subject: Re: [PATCH V8 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Message-ID: <ZRFHiDJW8Bf7JsKQ@smile.fi.intel.com>
References: <7f7016dbad5eb0770bf4653dcc87ae0f8963bf44.camel@sealevel.com>
 <4c6c4e3212a929822ec6a8ba09691b465541f648.camel@sealevel.com>
 <ZQ2pQS4q31t8aMBB@smile.fi.intel.com>
 <c48ef137af419953b6752ce31e9e82c701efffa3.camel@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c48ef137af419953b6752ce31e9e82c701efffa3.camel@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 22, 2023 at 03:33:05PM +0000, Matthew Howell wrote:
> On Fri, 2023-09-22 at 17:48 +0300, andriy.shevchenko@intel.com wrote:
> > On Fri, Sep 22, 2023 at 02:22:11PM +0000, Matthew Howell wrote:

...

> > > +static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> > > +                struct uart_8250_port *port, int idx)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     port->port.rs485_config = sealevel_rs485_config;
> > > +
> > > +     return 0;
> > > +}
> > 
> > This actually can be embedded into original pci_xr17v35x_setup() as
> > 
> >         if (pdev->subsystem_vendor == PCI_VENDOR_ID_SEALEVEL)
> >                 port->port.rs485_config = sealevel_rs485_config;
> 
> That was my original thought prior to the first submission, but I wasn't
> sure about adding vendor-specific changes into pci_xr17v35x_setup()
> since it appears that the convention in 8250_exar.c has been for vendors
> to have their own setup function when they needed to change the
> init/setup behaviour.
> 
> If that is not the case though and having this in pci_xr17v35x_setup()

Just use the common sense. The case you are now adding is using PCI IDs
(vendor and device) that are Exar's. So, I do not see any violation of
the above assumption. Checking for _sub_ IDs is fine, it's just a quirk
for the Exar based chips.

> is more appropriate I'll be happy to put it there instead of having yet
> another setup function.

...

> > > +     SEALEVEL_DEVICE(XR17V4358, pbn_sealevel_16),
> > 
> > This is kinda worries me. Original Exar card has 12 ports, why 16 is in use
> > for this one?
> 
> Ah, good catch. I had actually forgotten about the 12 port version. Will
> either fix or make redundant with move to pci_xr17v35x_setup() depending
> on feedback from my statement above about what is most appropriate.
> 
> > > +     SEALEVEL_DEVICE(XR17V8358, pbn_sealevel_16),
> > With the above suggestion this will be fixed automatically.

-- 
With Best Regards,
Andy Shevchenko


