Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AD0C43334
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jun 2022 17:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377238AbiFVRJ2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355951AbiFVRJM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jun 2022 13:09:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BCD3EF30;
        Wed, 22 Jun 2022 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655917663; x=1687453663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2GUfLn3Tz3WxjmHe+ZnGNWrA4D2qWYVVfvVgDLrL0IQ=;
  b=jPHKOqTR+Jra6Fa58yNrFvY8KnEZMZKWwqof2v8I0tQZo6yq56YiuKzl
   jgGh+cNfUQ/DO39Xm8zzg11i1+mCZ/2f6yUHFbw8KfG80Kiy1y6DzURE9
   m43AFqOBjTwbQVLwHLTi5Roya0OKlprKpRC/28SHfguvXERDN471uv31d
   QLOWr4TEE65ER7X8+I6N3RRTOb9LfFrcFfdtoNKZtAAxWuT6wpo4rfAE6
   KRFqde0IbcN2pOy4DC4v7E861Z7bbGqG9mTifuUWyiv7+kklJWwtIFkvK
   A1qVYfI7CSuSa9r1kJuAXSqom6ueFBlSvhQA8V4zwhNyaZ/9E9mf4MX/G
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="278025906"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="278025906"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:07:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="585805521"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:07:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o43of-000sUH-S5;
        Wed, 22 Jun 2022 20:06:57 +0300
Date:   Wed, 22 Jun 2022 20:06:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 2/8] serial: core, 8250: set RS485 termination gpio in
 serial core
Message-ID: <YrNMMQUYdgDz45Jc@smile.fi.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-3-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622154659.8710-3-LinoSanfilippo@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 22, 2022 at 05:46:53PM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In serial8250_em485_config() the termination GPIO is set with the uart_port
> spinlock held. This is an issue if setting the GPIO line can sleep (e.g.
> since the concerning GPIO expander is connected via SPI or I2C).
> 
> Fix this by setting the termination line outside of the uart_port spinlock
> in the serial core.

This doesn't describe that this patch is actually changing GPIO to support
sleep mode. So, it doesn't fix anything. Please rephrase the commit message
accordingly.

> This also makes setting the termination GPIO generic for all uart drivers.

UART

-- 
With Best Regards,
Andy Shevchenko


