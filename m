Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D20CE92705
	for <linux-serial@archiver.kernel.org>; Thu,  5 Oct 2023 14:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjJEO1a (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjJEOZS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Oct 2023 10:25:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC8C28112;
        Thu,  5 Oct 2023 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513496; x=1728049496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aRAusKFOHxTcivReObj21Yhl56rRDgruWVPVeRzCnw8=;
  b=fH6mc/wpYzsAQCIfNimwZDO6ue3m4KHSpSNvoe7lt7S8G2drO2fFTu1p
   C8kY5oi8l/uJRq960pW+CCMaBo7kFmY7mhLXBRX69OV8L0LQHSvwsMVkN
   TjStILJKmA3BBt0Mx0lbhYQd9hAQ7vjvGG+B+t+qnD4if2tK3l7fenkge
   f0tsNX8wpMWYE9xWqJiBKgBEhztrgZpkJZpYM4xyrrNM+zMqHoG9+itQg
   EloQ8LlD8xumAbgRbB5UaSEeJzMHyOIogcZArl2imWp6y28CrTBD7I+wq
   PLir+AgQpX4j/uVIp6ZYGPYuqpS42LEcdF6SUM0h6vozsfDVJNm0L3koO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="447633641"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="447633641"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 02:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="867817764"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="867817764"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 02:08:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qoKLJ-00000002z0x-2FGX;
        Thu, 05 Oct 2023 12:08:25 +0300
Date:   Thu, 5 Oct 2023 12:08:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Check for valid console index
Message-ID: <ZR59CTEOdGYS+8lE@smile.fi.intel.com>
References: <20231004085511.42645-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004085511.42645-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 04, 2023 at 11:55:10AM +0300, Tony Lindgren wrote:
> Let's not allow negative numbers for console index.

...

> -	if (co->index >= UART_NR)
> +	if (co->index < 0 || co->index >= UART_NR)
>  		co->index = 0;

in_range() ?

-- 
With Best Regards,
Andy Shevchenko


