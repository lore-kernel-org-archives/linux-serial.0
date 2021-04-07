Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105A2C43460
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 13:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8A161260
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 13:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352616AbhDGNjZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 09:39:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:62455 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352628AbhDGNjQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 09:39:16 -0400
IronPort-SDR: qf2ehWiRWqQ5b1ouurAKUi+AU0hZxh59JhEYAURE10vqJjDc0MJwogQNgscJVm9UufwzzwFrlz
 TBCyN+zJUVqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193419886"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="193419886"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 06:39:06 -0700
IronPort-SDR: oGtJTC5Aw3mYa53Xfrm1IauqF79CxKFALgbkGBCrkY3n3SqjqF06SEgp2qRhejrerNbdlwBQnF
 lzQ9+ZlEuWIA==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="519439721"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 06:39:04 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lU8Ob-0021O4-Qr; Wed, 07 Apr 2021 16:39:01 +0300
Date:   Wed, 7 Apr 2021 16:39:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: sh-sci: Respect deferred probe when
 getting IRQ
Message-ID: <YG219ZnbCDZFmpiB@smile.fi.intel.com>
References: <20210407101713.8694-1-andriy.shevchenko@linux.intel.com>
 <33a5ee25-d4c9-b5c2-b5f9-05316b1139c0@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a5ee25-d4c9-b5c2-b5f9-05316b1139c0@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 07, 2021 at 06:11:46AM -0700, Guenter Roeck wrote:
> On 4/7/21 3:17 AM, Andy Shevchenko wrote:
> > With platform_get_irq() and its optional variant it's possible to get
> > a deferred probe error code. Since the commit ed7027fdf4ec ("driver core:
> > platform: Make platform_get_irq_optional() optional") the error code
> > can be distinguished from no IRQ case. With this, rewrite IRQ resource
> > handling in sh-sci driver to follow above and allow to respect deferred
> > probe.
> > 
> > Fixes: ed7027fdf4ec ("driver core: platform: Make platform_get_irq_optional() optional")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This patch alone causes a hard hang early during boot. It works if applied
> together with ed7027fdf4ec. Ultimately that means that ed7027fdf4ec introduces
> a functional change, and will need to be applied very carefully. A cursory
> glance through callers of platform_get_irq_optional() shows that many
> do not handle this correctly: various drivers handle a return value of 0
> as valid interrupt, and others treat errors other than -ENXIO as fatal.
> 
> Also, each patch on its own causes failures on sh, which is problematic
> when applying them even as series. See below for an idea how to
> address that.

Right, that's why I think I have to slow down with it (as I answered to Greg).

> Since sh never gets -EPROBE_DEFER, the following code can be applied
> on its own and does not depend on ed7027fdf4ec.
> 
> 	sci_port->irqs[i] = platform_get_irq_optional(dev, i);
> 	if (sci_port->irqs[i] <= 0)
> 		sci_port->irqs[i] = sci_port->irqs[0];
> 
> With this change, sh images boot in qemu both with and without ed7027fdf4ec.

Yeah, thanks! But I think we still can avoid double loops there.

-- 
With Best Regards,
Andy Shevchenko


