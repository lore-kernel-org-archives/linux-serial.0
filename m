Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BCAC001E0
	for <linux-serial@archiver.kernel.org>; Thu, 10 Aug 2023 15:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjHJP1A (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Aug 2023 11:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbjHJP07 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Aug 2023 11:26:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEA32683;
        Thu, 10 Aug 2023 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691681218; x=1723217218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vItw+p71ekRR6tJeARewzkH/w4ZrU+DYKsLqvhy5igA=;
  b=euSPaAUPakUNPt5OGERePHoJcZ3oLQiKL9T8oUcndTIr2I1G9C4uk6vH
   C/J9JIVo9wsDmPRJZ44aW3Q4t/fCFOtWeIzunUnqhjcxCPGFxtw4xwucu
   HL+NZNL0YDEzRtGxmvlyXrarq2AfTSLWthiEJg/n9whuE9s748VQZ66AP
   6tg2SeK84bYj/cP54fQq3CK7Gg/npn16tdo/i9ArigNDW1w6gL2sFh7N+
   f7xjGIypgquKSgco3oesHvO8dWUP9QlIH2aB5ISOMC++osAO77/8ARapR
   x40NhzFkerJvEtbZIHDlKiqTMjb+hEC7iK+vkUjc5v4vSvljZILuS51zL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="457805201"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="457805201"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="846438500"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="846438500"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2023 08:26:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qU7Yr-006p5v-2o;
        Thu, 10 Aug 2023 18:26:53 +0300
Date:   Thu, 10 Aug 2023 18:26:53 +0300
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
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: core: Fix serial core port id, including
 multiport devices
Message-ID: <ZNUBvZQcbBbCziXU@smile.fi.intel.com>
References: <20230810065737.47294-1-tony@atomide.com>
 <ZNUBHaDTsAXVNNLZ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNUBHaDTsAXVNNLZ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 10, 2023 at 06:24:13PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 10, 2023 at 09:57:34AM +0300, Tony Lindgren wrote:

...

> > +	unsigned int min = 0, max = ~0U;
> 
> Shouldn't this be int? The max IIRC will be INT_MAX with this anyway.

Ah, and then you can supply is as 0 (IIRC).

-- 
With Best Regards,
Andy Shevchenko


