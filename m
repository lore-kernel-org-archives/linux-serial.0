Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A939C07E9C
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 12:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA305613D9
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 12:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbhGNMkt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:40:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:6215 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239385AbhGNMkr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 08:40:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="208520952"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="208520952"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 05:37:54 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="630363863"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 05:37:53 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m3e94-00DJiN-SE; Wed, 14 Jul 2021 15:37:46 +0300
Date:   Wed, 14 Jul 2021 15:37:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/4] serial: 8250_pci: Refactor the loop in
 pci_ite887x_init()
Message-ID: <YO7ammJpiMvqwb/+@smile.fi.intel.com>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <136e3881-bff4-d1f0-e146-b5c0a58f2e80@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <136e3881-bff4-d1f0-e146-b5c0a58f2e80@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 14, 2021 at 08:57:06AM +0200, Jiri Slaby wrote:
> On 13. 07. 21, 12:40, Andy Shevchenko wrote:
> > The loop can be refactored by using ARRAY_SIZE() instead of NULL terminator.
> > This reduces code base and makes it easier to read and understand.

> > +		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE, "ite887x");
> 
> Irrelevant whitespace change.
> 
> >   		if (iobase != NULL) {
> >   			/* write POSIO0R - speed | size | ioport */
> >   			pci_write_config_dword(dev, ITE_887x_POSIO0,
> >   				ITE_887x_POSIO_ENABLE | ITE_887x_POSIO_SPEED |
> >   				ITE_887x_POSIO_IOSIZE_32 | inta_addr[i]);
> >   			/* write INTCBAR - ioport */
> > -			pci_write_config_dword(dev, ITE_887x_INTCBAR,
> > -								inta_addr[i]);
> > +			pci_write_config_dword(dev, ITE_887x_INTCBAR, inta_addr[i]);
> 
> detto
> 
> >   			ret = inb(inta_addr[i]);
> >   			if (ret != 0xff) {
> >   				/* ioport connected */
> >   				break;
> >   			}
> >   			release_region(iobase->start, ITE_887x_IOSIZE);
> > -			iobase = NULL;
> >   		}
> > -		i++;

I believe with Joe's suggestion I can improve entire body of this branch
perhaps in a separate patch. Do you prefer one or two patches?

> >   	if (!inta_addr[i]) {
> 
> OOB access?

Yep, Dan reported the same. Missed during conversion. Will fix.

-- 
With Best Regards,
Andy Shevchenko


