Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2A8C48BCF
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 17:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC562613C7
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 17:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFIREk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:04:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:47988 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhFIREj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Jun 2021 13:04:39 -0400
IronPort-SDR: H2UIBIJzElUxNLA3vsfq6qJ6aZ8Z6LW9ASlG0Q98Y+s/ISmH+3iP+FioDxoPYmmMLaiCkqdd2L
 baq8YQDupt+g==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="226489061"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="226489061"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 10:02:22 -0700
IronPort-SDR: 5fyRoLzc2uv6n6hr50Cup3ww997RaijPGa0L9t6/pZ4fv1OZeW+exB1+4Y0HnoYZxC6ZK4O85R
 Cung1lU7MNVg==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="448353825"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 10:02:20 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lr1ar-000tm1-Ty; Wed, 09 Jun 2021 20:02:17 +0300
Date:   Wed, 9 Jun 2021 20:02:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 2/3] serial: 8250_exar: Extract exar_get_platform()
 helper
Message-ID: <YMD0GZdbwICgmSmA@smile.fi.intel.com>
References: <20210608144239.12697-1-andriy.shevchenko@linux.intel.com>
 <20210608144239.12697-2-andriy.shevchenko@linux.intel.com>
 <YMC3AhYbxA0Nbp8q@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMC3AhYbxA0Nbp8q@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 09, 2021 at 02:41:38PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 08, 2021 at 05:42:38PM +0300, Andy Shevchenko wrote:
> > We would like to use DMI matching in other functions as well.
> > Hence, extract it as exar_get_platform() helper function.

> Do not mix "fixes with features" in a single series, as I now have to
> pick it apart and apply it to different branches by hand :(
> 
> Please do different series for the two different things if at all
> possible.

I see. Thank  you for pointing out, I will keep in mind for the future submissions.

-- 
With Best Regards,
Andy Shevchenko


