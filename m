Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC5BC2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 15:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7B86194C
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 15:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhFYPmQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 11:42:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:21257 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhFYPmQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 11:42:16 -0400
IronPort-SDR: 1bKgzYraEaYrZoVEGzhWT19sAILf2YUDrIw/3oAG7j1xzhot47fln9EBkUt0dPkbnHl0SWrLWy
 MzglMf60KTNg==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="205864808"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="205864808"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 08:39:55 -0700
IronPort-SDR: lIKHcr6YFJskOHbIwgnYoJCGrzS+Zzr1/tXKd5h6pwna5gZW3DHaR+N4ei3hX9aU7b2vEKWw8Q
 FniYLlEFc08Q==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="557731720"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 08:39:54 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lwnvq-005JWd-6X; Fri, 25 Jun 2021 18:39:50 +0300
Date:   Fri, 25 Jun 2021 18:39:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [tty:tty-testing 96/222] drivers/tty/serial/max310x.c:1430
 max310x_probe() warn: 's->clk' not released on lines: 1296.
Message-ID: <YNX4xmVFhLJ3Vw0i@smile.fi.intel.com>
References: <202106250724.d9BNqnQl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106250724.d9BNqnQl-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 25, 2021 at 03:11:35PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> head:   5607fa6c3da3189de1bac356c73bc4fcaf4c0234
> commit: d4d6f03c4fb3a91dadfe147b47edd40e4d7e4d36 [96/222] serial: max310x: Try to get crystal clock rate from property
> config: x86_64-randconfig-m001-20210622 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/tty/serial/max310x.c:1430 max310x_probe() warn: 's->clk' not released on lines: 1296.
> 
> vim +1430 drivers/tty/serial/max310x.c
>   1285          }
>   1286  
>   1287          ret = clk_prepare_enable(s->clk);
>   1288          if (ret)
>   1289                  return ret;
>   1290  
>   1291          freq = clk_get_rate(s->clk);
>   1292          if (freq == 0)
>   1293                  freq = uartclk;
>   1294          if (freq == 0) {
>   1295                  dev_err(dev, "Cannot get clock rate\n");
>   1296                  return -EINVAL;
> 
> goto out_clk?

Right. I moved the code after the clk_prepare_enable() call and forgot to
change the error path handling, thanks!

I have just sent a fix.

-- 
With Best Regards,
Andy Shevchenko


