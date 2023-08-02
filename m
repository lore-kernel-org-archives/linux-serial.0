Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58312C001E0
	for <linux-serial@archiver.kernel.org>; Wed,  2 Aug 2023 21:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjHBVqQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Aug 2023 17:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjHBVqB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Aug 2023 17:46:01 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8521930EF;
        Wed,  2 Aug 2023 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691012723; x=1722548723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MF0JI6IJD9FJEJNY9LMIWv3VjBsDKGG4DVNWrUEzWtE=;
  b=AvMbZ/RKyxZB9MwgcGHn0Y+63gfUUnkelEboRU0UMwAvONG4Y3+168su
   qmKZLJBttUJtrI2W3k8NRoLDmAZxIEJRJmNEGcivGIgDAAwfecH/bbs1G
   wPC5p2qH6cPz9lWfKnMfPY0DptlDuO334fY/LdKrOxNX4qWcZUuP4txeb
   2kuwQW9IwyvItdbfTEgXaatnZF8QcT7ZEPY1PfH1iaHEn2SzLj29QNeyh
   tIpucDcVyP28919SvlU2phHoPbkp+pcWDnX4f3QR5KwMJfC9BbiA0/UxT
   ZNzr9OFwmxbRl9y5qwJi5XEXm11Gw9GVUFIkkPn1frfMom4VPgClRunnB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="349304400"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="349304400"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 14:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="819388386"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="819388386"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2023 14:44:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRJdy-00HKzs-1m;
        Thu, 03 Aug 2023 00:44:34 +0300
Date:   Thu, 3 Aug 2023 00:44:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] serial: core: Fix serial_base_match() after fixing
 controller port name
Message-ID: <ZMrOQifgCZqu3YTh@smile.fi.intel.com>
References: <20230802114846.21899-1-tony@atomide.com>
 <2023080224-nutrient-regress-c95e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080224-nutrient-regress-c95e@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 02, 2023 at 03:48:26PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 02, 2023 at 02:48:43PM +0300, Tony Lindgren wrote:
> > While fixing DEVNAME to be more usable, I broke serial_base_match() as
> > the ctrl and port prefix for device seemed unnecessary.
> > 
> > Let's fix the issue by checking against dev->type and drv->name.

...

> > +	    !strncmp(SERIAL_BASE_CTRL_NAME, drv->name, 4))
> 
> maybe:
> 	    !strncmp(SERIAL_BASE_CTRL_NAME, drv->name, strlen(SERIAL_BASE_CTRL_NAME))
> 
> as "4" is a magic number :)

str_has_prefix() hides that.

-- 
With Best Regards,
Andy Shevchenko


