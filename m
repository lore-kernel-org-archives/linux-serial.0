Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935E2C04A6A
	for <linux-serial@archiver.kernel.org>; Thu, 10 Aug 2023 15:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjHJPYs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Aug 2023 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjHJPYr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Aug 2023 11:24:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E272683;
        Thu, 10 Aug 2023 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691681086; x=1723217086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UvECL82g+PkLxcGldtfaglAh0LDEQ3C40it1tafVwr0=;
  b=eO8vzJseppjN0KutLRnZqlazTyep338gumlfakgjZ8LsUk3r8+epsdbZ
   qsrLJAOwRdq+1AZbm/q8w1i1xfKbJO/K5p5wGIlPOo2K2XlWd6LmMHsSP
   WX7m9OCCBoYgxrSnlSxtoLHCfWHyfmAO90j6iMExc2/5VVrIh/y3RPkTU
   EzF4T65gaqM+CiBl9fhsLqUOFewzq2y0ih0cXRcbHtelCenotuPr+UZNA
   rHg4skLCsh7we2UVQVrt+8qCYedf7wNbJAMFZlj7XZE9NssOSF7F12ojE
   p/Vv8im8uQ4jnV0fIb/0xoUKh6+yhlyW9Su43RPn00KZOIcKfPhd2PqlZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="457804600"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="457804600"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="846438063"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="846438063"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2023 08:24:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qU7WH-006jHL-2E;
        Thu, 10 Aug 2023 18:24:13 +0300
Date:   Thu, 10 Aug 2023 18:24:13 +0300
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
Message-ID: <ZNUBHaDTsAXVNNLZ@smile.fi.intel.com>
References: <20230810065737.47294-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810065737.47294-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 10, 2023 at 09:57:34AM +0300, Tony Lindgren wrote:
> We want to fix the serial core port DEVNAME to use a port id of the
> hardware specific controller port instance instead of the port->line.
> 
> For example, the 8250 driver sets up a number of serial8250 ports
> initially that can be inherited by the hardware specific driver. At that
> the port->line no longer decribes the port's relation to the serial core
> controller instance.
> 
> Let's fix the issue by assigning port->port_id for each serial core
> controller port instance.

...

> +	unsigned int min = 0, max = ~0U;

Shouldn't this be int? The max IIRC will be INT_MAX with this anyway.

-- 
With Best Regards,
Andy Shevchenko


