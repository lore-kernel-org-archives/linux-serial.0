Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B312C07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 12:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23AD613B6
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 12:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbhGNMjM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:39:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:27060 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhGNMjK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 08:39:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="190713942"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="190713942"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 05:36:18 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="571161912"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 05:36:16 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m3e7W-00DJfw-TX; Wed, 14 Jul 2021 15:36:10 +0300
Date:   Wed, 14 Jul 2021 15:36:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/4] serial: 8250_pci: Refactor the loop in
 pci_ite887x_init()
Message-ID: <YO7aOnACHsZOn2/H@smile.fi.intel.com>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <91d4f67011eb83c4e4b17c7cfb4f4b8aef190978.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91d4f67011eb83c4e4b17c7cfb4f4b8aef190978.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 14, 2021 at 03:44:31AM -0700, Joe Perches wrote:
> On Tue, 2021-07-13 at 13:40 +0300, Andy Shevchenko wrote:
> > The loop can be refactored by using ARRAY_SIZE() instead of NULL terminator.
> > This reduces code base and makes it easier to read and understand.

Thanks for review! My answers below.

> > +/* inta_addr are the configuration addresses of the ITE */
> > +static const short inta_addr[] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1e0, 0x200, 0x280, };
> 
> Why move this outside the only function it's used in?

Because it's a static one. I prefer to see global variables easily when reading
the code.

> The trailing comma isn't necessary/useful and possibly confusing too.

True, since it's one line.

> >  static int pci_ite887x_init(struct pci_dev *dev)
> >  {
> > -	/* inta_addr are the configuration addresses of the ITE */
> > -	static const short inta_addr[] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1e0,
> > -							0x200, 0x280, 0 };
> >  	int ret, i, type;
> >  	struct resource *iobase = NULL;
> >  	u32 miscr, uartbar, ioport;
> > 
> >  	/* search for the base-ioport */
> > -	i = 0;
> > -	while (inta_addr[i] && iobase == NULL) {
> > -		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE,
> > -								"ite887x");
> > +	for (i = 0; i < ARRAY_SIZE(inta_addr); i++) {
> > +		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE, "ite887x");
> >  		if (iobase != NULL) {
> 
> continue and unindent the block below?

As a separate patch perhaps?

-- 
With Best Regards,
Andy Shevchenko


