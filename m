Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6436C0015E
	for <linux-serial@archiver.kernel.org>; Thu, 13 Jul 2023 16:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjGMQvf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Jul 2023 12:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjGMQve (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Jul 2023 12:51:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C085426B1;
        Thu, 13 Jul 2023 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689267093; x=1720803093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NeS/7wjO+6YFPllvD48mAowelFtPp+/XWfqr/d+lNKo=;
  b=c85mKgIW4g3dx848npadeA2rLCPK6a2WMVaEFtT9OnqcSIXzkzJkCaX5
   nRWWRTMu7w7vKcXxqU5IcvmKnIjyTIpG6nJ23/wAAiAZg6jCW4RwZeCca
   eybJorvtmykbjEBjlSbjsv4mOXckr1N8HkJa8sLJj3loy2lC2r9XLvAX5
   fRMukRajpHmQOf4/o0YlLIEN5ko9IuofAGur1DVGvxx5ohYmyEoiClI3l
   60jCzuehGD6FYPeiiYL3vPHl2gM0RpK49E3TsHQH+mcimPWTl7F5wIbwy
   G3xzBtujtwJH8whKaedXDsX/2zlzfIQ5K4ieg9bG8osXkAz1/eS0w5ABw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345567996"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="345567996"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:51:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896090246"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="896090246"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2023 09:51:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJzX8-002RQl-2q;
        Thu, 13 Jul 2023 19:51:14 +0300
Date:   Thu, 13 Jul 2023 19:51:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ruihong Luo <colorsu1922@gmail.com>
Cc:     ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, stable@vger.kernel.org,
        luoruihong@xiaomi.com, weipengliang@xiaomi.com,
        wengjinfei@xiaomi.com
Subject: Re: [PATCH v4] serial: 8250_dw: Preserve original value of DLF
 register
Message-ID: <ZLArgoe3TXF27gsE@smile.fi.intel.com>
References: <20230713004235.35904-1-colorsu1922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713004235.35904-1-colorsu1922@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 13, 2023 at 08:42:36AM +0800, Ruihong Luo wrote:
> Preserve the original value of the Divisor Latch Fraction (DLF) register.
> When the DLF register is modified without preservation, it can disrupt
> the baudrate settings established by firmware or bootloader, leading to
> data corruption and the generation of unreadable or distorted characters.

You forgot to add my tag. Why? Do you think the name of variable warrants this?
Whatever,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Next time if you don't pick up somebody's tag, care to explain in the changelog
why.

> Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
> Signed-off-by: Ruihong Luo <colorsu1922@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


