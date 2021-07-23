Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DA9C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 12:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA9F60E8C
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 12:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhGWLsV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 07:48:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:43477 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234750AbhGWLsP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 07:48:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="199131289"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="199131289"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 05:28:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="663257150"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 05:28:46 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m6uIC-00HMKm-SH; Fri, 23 Jul 2021 15:28:40 +0300
Date:   Fri, 23 Jul 2021 15:28:40 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Dennis Giaya <dgiaya@whoi.edu>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: max310x: Use clock-names property
 matching to recognize XTAL
Message-ID: <YPq1+NzJeqLZVctW@smile.fi.intel.com>
References: <20210722150233.30897-1-andriy.shevchenko@linux.intel.com>
 <YPmSpNZr/yQiPqsO@smile.fi.intel.com>
 <0acef8aa86d69cac0ea1a3dbdafc41625580e0eb.camel@whoi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0acef8aa86d69cac0ea1a3dbdafc41625580e0eb.camel@whoi.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 22, 2021 at 09:05:13PM +0000, Dennis Giaya wrote:
> Andy,
> 
> I've tested this out on my hardware that uses an external oscillator
> 'osc' (as opposed to external crystal 'xtal').
> 
> With the relevant asl
> 	Package () {"compatible", "maxim,max14830"},
> 	Package ()
> {"clock-frequency", 19200000},
> 	Package () {"clock-names", "osc"},
> 
> Previously, the driver logic would default to 'xtal' and then compare
> against the narrower frequency range and throw an error because 19.2MHz
> was not allowed. With your patch, it proceeds as 'osc' and appears to
> work as intended.

Thanks for testing!
I assume I may convert above to the Tested-by: or equivalent tag.

JFYI, in OSS mailing lists we do not top post.


-- 
With Best Regards,
Andy Shevchenko


