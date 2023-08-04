Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9245DC001DB
	for <linux-serial@archiver.kernel.org>; Fri,  4 Aug 2023 06:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjHDGgn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Aug 2023 02:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjHDGgb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Aug 2023 02:36:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407A24697
        for <linux-serial@vger.kernel.org>; Thu,  3 Aug 2023 23:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691130984; x=1722666984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1qVJjEqyJndq014L9hmn66YidHAx2bA+qLb5gcH6R0E=;
  b=dLPLainJYzYQtfKXDdsTIJutXjtB+e3YbKQeM6AwbApHzPLO61MTjBph
   dz36QYgRxQyvrVHvdmAL9jP6s6lZZe/d4BtXylf0qgiPfmMdN1b8jioK3
   Lqw8zDhVrdKsVsrq1SEHGtNP1w/k+AHCIQvYBAzqn7SoUNc3NImIkFFWn
   gD27aAcHu1VSgiMMCw4x2hP4Q6+ePyI8WeZLs18XNQcoUw2vUArZPkUrT
   ZYBEhl1cUa8G8RPZx/mph3nP2LLZhjPcTcpC2b3Sev55YaU8wBE7wSC1r
   RSbvAVI5rewIgcQvfEG2/6hZWGCaiyVyeNfo9iYtwXXOAxF8ndzZJeVWQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349674615"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="349674615"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:36:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="1060607594"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="1060607594"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2023 23:36:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRoQ2-00DrYQ-0l;
        Fri, 04 Aug 2023 09:36:14 +0300
Date:   Fri, 4 Aug 2023 09:36:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Li Zetao <lizetao1@huawei.com>, gregkh@linuxfoundation.org,
        jorge.sanjuangarcia@duagon.com, JoseJavier.Rodriguez@duagon.com,
        yangyingliang@huawei.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH -next] 8250_men_mcb: Fix unsigned expression compared
 with zero
Message-ID: <ZMycXdyHVtTq/QNG@smile.fi.intel.com>
References: <20230803142053.1308926-1-lizetao1@huawei.com>
 <19b30f4f-c4e4-f186-47ee-943d04219fd7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b30f4f-c4e4-f186-47ee-943d04219fd7@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 04, 2023 at 07:07:06AM +0200, Jiri Slaby wrote:
> On 03. 08. 23, 16:20, Li Zetao wrote:

...

> But I wonder why this didn't emit a warning:
>   dev_info(&mdev->dev, "found MCB UART: ttyS%d\n", data->line[i]);
> 
> I.e. %d for uint?

Do we have this anywhere enabled -Wformat-signedness?

-- 
With Best Regards,
Andy Shevchenko


