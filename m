Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDB8C001B0
	for <linux-serial@archiver.kernel.org>; Thu, 10 Aug 2023 15:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjHJPZk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Aug 2023 11:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjHJPZk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Aug 2023 11:25:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4C02683;
        Thu, 10 Aug 2023 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691681140; x=1723217140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4a9klnTrtUQBj05PkmRlh+31S9CjMgtcmnPLbZ6ZpYo=;
  b=K9JTK5GjgZemVi2L3ZQTC4xc3+XnluKgRVJFDwgp6g5H8sfKVzymXSi4
   /e7ZNroFEFpP1Tc5t1KNHgpRAIEHWnYzHdrDqZ8vYZXhyvSbNQAz+Vjoa
   /sEDdGbrT8eACK79FNd9J178mmb1MCTogwAGWGlYUifuAD4Z98jSTmcj2
   lNJ1rLqKMoKNn/jEZQ7PAJ51yymIq/E3yhbj4aUMqdanq48+K/xcWVFdi
   DyZk5gT/jFuPrH0xmxWzc9Mk8Mm3U9XXLHcY94NEhaq3AoiBXICUglN3q
   +EmK28sg6d9ML+Io8FCm1oJAUO5Ayi9jr33DmZDp51NauH4YHQMfoYk3h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="437777082"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="437777082"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="906103182"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="906103182"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2023 08:25:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qU7XM-006liD-1u;
        Thu, 10 Aug 2023 18:25:20 +0300
Date:   Thu, 10 Aug 2023 18:25:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dhruva Gole <d-gole@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: core: Fix serial core port id, including
 multiport devices
Message-ID: <ZNUBYOFuWNmy1Icj@smile.fi.intel.com>
References: <20230810065737.47294-1-tony@atomide.com>
 <20230810083633.tu2na6fcbg2kv53s@dhruva>
 <20230810084933.GK11676@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810084933.GK11676@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 10, 2023 at 11:49:33AM +0300, Tony Lindgren wrote:
> * Dhruva Gole <d-gole@ti.com> [230810 08:36]:
> > Please can you provide the base commit? I am unable to cleanly apply
> > this patch on commit: 21ef7b1e17d0 (tag: next-20230809, linux-next/master) Add linux-next specific files for 20230809
> 
> This is against the current tty tree tty-linus branch, not yet in next.

What he is suggesting is you using --base when formatting your patch.
Then you don't need to repeat this to every reviewer/tester/etc :-)

-- 
With Best Regards,
Andy Shevchenko


