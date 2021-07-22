Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C02C6377D
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 15:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD4C76128D
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 15:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhGVPFO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Jul 2021 11:05:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:57800 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhGVPFN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Jul 2021 11:05:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="209777051"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="209777051"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 08:45:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="462813165"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 08:45:46 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m6atI-00H1uh-7d; Thu, 22 Jul 2021 18:45:40 +0300
Date:   Thu, 22 Jul 2021 18:45:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>, Dennis Giaya <dgiaya@whoi.edu>
Subject: Re: [PATCH v1 1/1] serial: max310x: Use clock-names property
 matching to recognize XTAL
Message-ID: <YPmSpNZr/yQiPqsO@smile.fi.intel.com>
References: <20210722150233.30897-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722150233.30897-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 22, 2021 at 06:02:33PM +0300, Andy Shevchenko wrote:
> Dennis reported that on ACPI-based systems the clock frequency
> isn't enough to configure device properly. We have to respect
> the clock source as well. To achieve this match the clock-names
> property against "xtal" to recognize crystal connection.

Dennis, please test this.

...

> -	s->clk = devm_clk_get_optional(dev, "osc");
> +	xtal = device_property_match_string(dev, "clock-names", "xtal") >= 0;

Meanwhile I will change this (not affects the testing in your case) to actually
negative one as:

	..., "osc") < 0;

to be compatible with the original flow (in case there are two clock names, the
"osc" has a priority).


-- 
With Best Regards,
Andy Shevchenko


