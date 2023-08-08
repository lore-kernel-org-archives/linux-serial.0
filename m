Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70433C001DB
	for <linux-serial@archiver.kernel.org>; Tue,  8 Aug 2023 16:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjHHQqi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjHHQpq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Aug 2023 12:45:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C94519B0;
        Tue,  8 Aug 2023 08:56:27 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437152560"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="437152560"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:25:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766380704"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="766380704"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 08 Aug 2023 06:25:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qTMhr-009eNj-2l;
        Tue, 08 Aug 2023 16:25:03 +0300
Date:   Tue, 8 Aug 2023 16:25:03 +0300
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
Subject: Re: [PATCH 3/3] gpio: sprd: Add clear interrupt
Message-ID: <ZNJCLyWCdihyeC7a@smile.fi.intel.com>
References: <20230808033144.2276-1-Wenhua.Lin@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808033144.2276-1-Wenhua.Lin@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 08, 2023 at 11:31:44AM +0800, Wenhua Lin wrote:
> Clear interrupt after set the interrupt type.

Why?

Can't it be done in the ->init_hw() callback of GPIO IRQ chip?

-- 
With Best Regards,
Andy Shevchenko


