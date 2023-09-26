Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A9AE7E62D
	for <linux-serial@archiver.kernel.org>; Tue, 26 Sep 2023 11:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjIZL7J (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Sep 2023 07:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIZL7J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Sep 2023 07:59:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D7E4;
        Tue, 26 Sep 2023 04:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695729542; x=1727265542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X6Ezl3igJyj5iL9SCOzpBy1pkFBQKSIdF3T21PwY86I=;
  b=UEcECKgkUinxgDpTl4QvB/HsLgo8gI2rcLaxNxj6fCph/TbFEDD0j8Fc
   Lk1QQsbH1j27vgZKhsaL3/bSo41tKk1uEx37Ur/LFjJuSiSsAP8ji32/1
   vJWgetqNGCkmuvlmCE5gKChaclCNJyK8HhrnBXJuO/VLTME/T/4y0/+CZ
   HYfmHgABxI/YmBP/Q9q2Ajh/hYB7t9rcwq98tSXtrMOvTa8vJiaY0OJXR
   AATM3x2y+Gz61/vBLij0HJveZiCdErWHQaUCSVVnxnQwQPZc7unwY1SMC
   JVSO9e7if9t/zUjmRueWsL27Lj0hVx/PlvxXGaEu0jUy/ZaaF37GOU2Ve
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467831929"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467831929"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 04:59:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="922395903"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="922395903"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 04:58:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ql6J0-00000000ac3-1qon;
        Tue, 26 Sep 2023 14:32:42 +0300
Date:   Tue, 26 Sep 2023 14:32:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Udit Kumar <u-kumar1@ti.com>,
        Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH] serial: 8250_omap: Fix errors with no_console_suspend
Message-ID: <ZRLBWrjUadvGCs/y@smile.fi.intel.com>
References: <20230926061319.15140-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926061319.15140-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 26, 2023 at 09:13:17AM +0300, Tony Lindgren wrote:
> We now get errors on system suspend if no_console_suspend is set as
> reported by Thomas. The errors started with commit 20a41a62618d ("serial:
> 8250_omap: Use force_suspend and resume for system suspend").
> 
> Let's fix the issue by checking for console_suspend_enabled in the system
> suspend and resume path.
> 
> Note that with this fix the checks for console_suspend_enabled in
> omap8250_runtime_suspend() become useless. We now keep runtime PM usage
> count for an attached kernel console starting with commit bedb404e91bb
> ("serial: 8250_port: Don't use power management for kernel console").

...

Btw, how close are we to getting rid the pm_runtime_irq_safe() call?

-- 
With Best Regards,
Andy Shevchenko


