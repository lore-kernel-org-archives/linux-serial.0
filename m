Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33750C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 10:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbiKRKn5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 05:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbiKRKny (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 05:43:54 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BF825CD;
        Fri, 18 Nov 2022 02:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668768234; x=1700304234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DHRMI6V+sgPcLuSWMPQRiljM1njAubVpXALqbHLr3x4=;
  b=JQpp1WFBleX2ZtDbqmDb32Dplq+9buhKwIt2QS6xQxWBEXQXSnRTg2P8
   4r1QUvYsIntT8dIJJctLtNMuS/OHCUMgSReVj7hfJ40jd0ouvcxxJKT1g
   Z7kMdsb0igwXhb855TYdjYZcq/rhKvWrWSm1PPEwStiMrmdwfPr7pdt7T
   C9JxTbalmaT3m6LgH2kTMcpKrswmei7LR6Qv1rPi7QODL22trMdvqLfBq
   YCqDJ9T6sCtU58dd+MP9q3iCgRVveKKZeAviOe3WvVPwBjLrYsKTvPmz4
   JyyK5cUkOshVsFOTFNEV+FKyR3pSB6EsKwXYHvoVgj3TovEohMNR1XT5Q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="300645903"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="300645903"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 02:43:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="814874069"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="814874069"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2022 02:43:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovyqX-00E03u-2C;
        Fri, 18 Nov 2022 12:43:45 +0200
Date:   Fri, 18 Nov 2022 12:43:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     Kumaravel.Thiagarajan@microchip.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        macro@orcam.me.uk, jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com
Subject: Re: [PATCH v5 tty-next 2/4] 8250: microchip: pci1xxxx: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Message-ID: <Y3dh4UlWKP2FzTpq@smile.fi.intel.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
 <20221117050126.2966714-3-kumaravel.thiagarajan@microchip.com>
 <Y3Xa9fRP3GGygiVj@smile.fi.intel.com>
 <PH7PR11MB59582CE57CE17F20A041157F9B099@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB59582CE57CE17F20A041157F9B099@PH7PR11MB5958.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 18, 2022 at 09:40:37AM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > Sent: Thursday, November 17, 2022 12:26 PM
> > To: Kumaravel Thiagarajan - I21417
> > <Kumaravel.Thiagarajan@microchip.com>
> > Subject: Re: [PATCH v5 tty-next 2/4] 8250: microchip: pci1xxxx: Add
> > serial8250_pci_setup_port definition in 8250_pcilib.c
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> > 
> > On Thu, Nov 17, 2022 at 10:31:24AM +0530, Kumaravel Thiagarajan wrote:
> > > Move implementation of setup_port API to serial8250_pci_setup_port
> > 
> > Don't you have a dependency issue here?
> 
> Okay, I will explain the need for the changes done in commit description.

What I meant is that the 8250_pci patch should be _prerequisite_ to your stuff
and not otherwise.

-- 
With Best Regards,
Andy Shevchenko


