Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A5DC433B4
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 11:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A0E26113D
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 11:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhDGLTb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 07:19:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:62659 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhDGLTb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 07:19:31 -0400
IronPort-SDR: LnDwtcIXP34NBKg7rxjbf2qwjZFd6cjIHooVRM7sOlw8MQ9WFGxWi0/u1AkRXSOIQPSDgI9CRT
 K2+tYaKnrhgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="278550636"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="278550636"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 04:19:21 -0700
IronPort-SDR: qYR2t//YJwbcp0lKzJncfVRzP3S5wXZFHiTrWjiYWOQsUhGqkrpC5BCvrwHXZDJFAf6fZDh2Js
 4DczEvaYOn5Q==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="519400884"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 04:19:20 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lU6DN-001zaq-VA; Wed, 07 Apr 2021 14:19:17 +0300
Date:   Wed, 7 Apr 2021 14:19:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/1] serial: sh-sci: Respect deferred probe when
 getting IRQ
Message-ID: <YG2VNSm8OHAT7/oF@smile.fi.intel.com>
References: <20210407101713.8694-1-andriy.shevchenko@linux.intel.com>
 <YG2IGQ8f0n+joxom@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG2IGQ8f0n+joxom@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 07, 2021 at 12:23:21PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 07, 2021 at 01:17:13PM +0300, Andy Shevchenko wrote:
> > With platform_get_irq() and its optional variant it's possible to get
> > a deferred probe error code. Since the commit ed7027fdf4ec ("driver core:
> > platform: Make platform_get_irq_optional() optional") the error code
> > can be distinguished from no IRQ case. With this, rewrite IRQ resource
> > handling in sh-sci driver to follow above and allow to respect deferred
> > probe.
> > 
> > Fixes: ed7027fdf4ec ("driver core: platform: Make platform_get_irq_optional() optional")
> 
> I've already reverted this commit, sorry.  Please feel free to resend
> this as a patch series.

Thanks!

I think I will not hurry in this cycle. Perhaps I have to check plenty of
places if they could have the same issue before resending. Sorry for the
troubles.


-- 
With Best Regards,
Andy Shevchenko


