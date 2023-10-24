Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21849C25B48
	for <linux-serial@archiver.kernel.org>; Tue, 24 Oct 2023 12:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjJXMn6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Oct 2023 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjJXMn4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Oct 2023 08:43:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AA6D68;
        Tue, 24 Oct 2023 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698151434; x=1729687434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sj2WgR+4pTRXlzYC4Ru4dFUASn0Or7+vSFXwpHG0S74=;
  b=IaxaA+3FDnmwBxJx9GJpslnV5YnhPVoFB5dGECVN0cvoj4ELetwFcQ41
   PTwHU1hZJclF2ulHj45ndtIo8ypLiuimtMEZHMGFDLuGZPG4voIZRQcV/
   TRsx347eI7OKW8dPeYTELN3rVggwY7pZHnM69kxZOs6sAnNwvEc79k76E
   cBjMXDe6H2mqQMP5y2Q2Ky0KUGw5Gm2O/dRfqgGfb84NYeCRQ6TEfiGnF
   JFBr/ta6ZuelPsgIaNHURBpQFMyLwVe/nynNfcB51gQ41pNDIwQ5o7MKV
   sSelaQftyZTPPWB7pjorEbqQcrjONtSRsuU8jqObkYDLPG+QS63tvQuEy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="385940888"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="385940888"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="828814821"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="828814821"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:43:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qvGkw-00000008Hg8-08I8;
        Tue, 24 Oct 2023 15:43:34 +0300
Date:   Tue, 24 Oct 2023 15:43:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [RFC PATCH 1/2] serial: core: Move tty and serdev to be children
 of serial core port device
Message-ID: <ZTe79akvB0OYwG3a@smile.fi.intel.com>
References: <20231024113624.54364-1-tony@atomide.com>
 <ZTe11rbKgcusPRD/@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTe11rbKgcusPRD/@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 24, 2023 at 03:17:26PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 24, 2023 at 02:36:18PM +0300, Tony Lindgren wrote:

...

> > -	ctrl->dev.of_node = parent->of_node;
> > +	ctrl->dev.of_node = host->of_node;
> 
> Even above should have been using device_set_node(&ctrl->dev, dev_fwnode(host)).

...

> >  	/* Make sure controller and ResourceSource handle match */
> > -	if (ACPI_HANDLE(ctrl->dev.parent) != lookup.controller_handle)
> > +	if (ACPI_HANDLE(ctrl->host) != lookup.controller_handle)
> 
> This can be changed to use device_match_acpi_handle().
> 
> >  		return -ENODEV;

...

> > -	if (!has_acpi_companion(ctrl->dev.parent))
> > +	if (!has_acpi_companion(ctrl->host))
> 
> I prefer is_acpi_device_node(dev_fwnode(...)) check, but here seems no other
> use for fwnode (haven't checked the full context, though).
> 
> >  		return -ENODEV;

...

I have just sent a little series based on these comments.

-- 
With Best Regards,
Andy Shevchenko


