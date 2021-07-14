Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC409C07E9C
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9F161396
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbhGNJeY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:34:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:56074 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238189AbhGNJeY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 05:34:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="271427886"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="271427886"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 02:31:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="571116917"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 02:31:31 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m3bEj-00DFzz-E3; Wed, 14 Jul 2021 12:31:25 +0300
Date:   Wed, 14 Jul 2021 12:31:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: Re: [PATCH v1 3/4] serial: 8250_pci: Always try MSI/MSI-X
Message-ID: <YO6u7YkgUYFph5tL@smile.fi.intel.com>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <20210713104026.58560-3-andriy.shevchenko@linux.intel.com>
 <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org>
 <33767cf0-2104-d7aa-2da8-5a3f5f20a654@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33767cf0-2104-d7aa-2da8-5a3f5f20a654@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 14, 2021 at 09:58:52AM +0200, Jiri Slaby wrote:
> On 14. 07. 21, 8:54, Jiri Slaby wrote:
> > > @@ -3994,14 +3982,9 @@ pciserial_init_ports(struct pci_dev *dev,
> > > const struct pciserial_board *board)
> > >       if (board->flags & FL_NOIRQ) {
> > >           uart.port.irq = 0;
> > >       } else {
> > > -        if (pci_match_id(pci_use_msi, dev)) {
> > > -            dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
> > > -            pci_set_master(dev);
> > > -            rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
> > > -        } else {
> > > -            dev_dbg(&dev->dev, "Using legacy interrupts\n");
> > > -            rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
> > > -        }
> > > +        pci_set_master(dev);
> > 
> > But bus mastering is not about MSIs. I *think* it's still OK, but you
> > need to document that in the commit log too.
> > 
> > Actually, why the commit which added this code turns on bus mastering?
> 
> Forget about this line, I wasn't woken enough. Of course, MSI (writes) to
> bus need bus mastering.

Yes.

> In any case, I'm still not sure what happens to devices which do not support
> MSI if we enable mastering on them?

If they support bus mastering, it means that device may be an arbiter on the
bus and initiate messages over it by its own. I'm not sure any of the existing
UARTs take advantage of bus mastering for anything than MSI delivery.

-- 
With Best Regards,
Andy Shevchenko


