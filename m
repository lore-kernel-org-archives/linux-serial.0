Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D33C04A94
	for <linux-serial@archiver.kernel.org>; Tue,  8 Aug 2023 18:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjHHSow (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjHHSoT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Aug 2023 14:44:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8951C527E;
        Tue,  8 Aug 2023 09:41:36 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374493766"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="374493766"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="796727907"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="796727907"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 08 Aug 2023 06:22:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qTMey-009XtH-0U;
        Tue, 08 Aug 2023 16:22:04 +0300
Date:   Tue, 8 Aug 2023 16:22:03 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH 1/3] gpio: sprd: Modify the calculation method of eic
 number
Message-ID: <ZNJBe3wcTc8dA4JC@smile.fi.intel.com>
References: <20230808033106.2174-1-Wenhua.Lin@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808033106.2174-1-Wenhua.Lin@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 08, 2023 at 11:31:06AM +0800, Wenhua Lin wrote:
> Automatic calculation through matching nodes,
> subsequent projects can avoid modifying driver files.

You sent three patches which has to be meant a series in three independent
(unlinked) messages. Do not forget to use --thread so it become a such.

...

>  	struct sprd_eic *sprd_eic;
>  	struct resource *res;
>  	int ret, i;
> +	u16 num_banks = 0;

Preserve reversed xmas tree ordering.

...

> @@ -630,10 +631,12 @@ static int sprd_eic_probe(struct platform_device *pdev)
>  		sprd_eic->chip.set = sprd_eic_set;
>  		fallthrough;
>  	case SPRD_EIC_ASYNC:
> +		fallthrough;
>  	case SPRD_EIC_SYNC:
>  		sprd_eic->chip.get = sprd_eic_get;
>  		break;
>  	case SPRD_EIC_LATCH:
> +		fallthrough;
>  	default:
>  		break;

Pointless changes. And actually create the code less maintainable.

-- 
With Best Regards,
Andy Shevchenko


