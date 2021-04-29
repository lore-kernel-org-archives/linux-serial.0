Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B9C43461
	for <linux-serial@archiver.kernel.org>; Thu, 29 Apr 2021 11:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE8E613D9
	for <linux-serial@archiver.kernel.org>; Thu, 29 Apr 2021 11:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbhD2LJm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Apr 2021 07:09:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:58300 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240612AbhD2LJi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Apr 2021 07:09:38 -0400
IronPort-SDR: c5ZJ3jlIbBso/knz/92XJyIUqt5r6UWOe1dAUVU4zgk9tUO7dL3JYgOGwkCx1a6KUUE8BCUHX0
 E2fAjxwCCsgw==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="282320673"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="282320673"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 04:08:51 -0700
IronPort-SDR: KXF/RIwNFNGDcj7F4weVdiEXXUT5Yc+kodrt/VUDiHGgrbai55I7Q8iydYkOXtossH/jizxn8e
 03aDlM+Pl8VQ==
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="386901888"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 04:08:48 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lc4XF-0087LE-IJ; Thu, 29 Apr 2021 14:08:45 +0300
Date:   Thu, 29 Apr 2021 14:08:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: fix a timeout loop condition
Message-ID: <YIqTvcZ6ZrAEL7WE@smile.fi.intel.com>
References: <YIpd+kOpXKMpEXPf@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIpd+kOpXKMpEXPf@mwanda>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 29, 2021 at 10:19:22AM +0300, Dan Carpenter wrote:
> This loop ends on -1 so the error message will never be printed.
> 
> Fixes: 4bcf59a5dea0 ("serial: 8250: 8250_omap: Account for data in flight during DMA teardown")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

...

>  			       poll_count--)
>  				cpu_relax();
>  
> -			if (!poll_count)
> +			if (poll_count == -1)

Why not to change poll_count-- to --poll_count?

I would even prefer to replace entire loop with read_poll_timeout_atomic(). But
do we even need atomic here?

-- 
With Best Regards,
Andy Shevchenko


