Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9D1C43334
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jun 2022 17:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359727AbiFVRFF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358953AbiFVRFF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jun 2022 13:05:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBBD3ED37;
        Wed, 22 Jun 2022 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655917503; x=1687453503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ruRy4f9EvQNfXtXFVy/TM7+tPV8XW6BRuYpvrsY5Ws=;
  b=VwG/VIW21YUvoT2UqK38rg7DdX/YQYy/iewuph5SDdmjPuVf2kwRh5WI
   MGSgYAZyErw1w+OhKcsi5Kuo1nTlb0lyO137vTBvFvFwhn/2+aA7V9h8+
   Yz8wIinSqcy/Qbk9zO2NYkOOr79/1kMVpF2wxHMQlwAX7+eNQD5XZGHb4
   c0ERYdoqYtH910aEidPXzC6O32qPOlY3YOz4Nhr7TAhwP1YiOpUzdiO6Z
   UznLAKfeEmOpCqrvsEXLjALyENeGYSZhdHEvocxx2TzpN1vwZHThz0MWU
   +xXrMjua9aKyNmaE+80GedYImT35A4mLnBiiHuNiCL4Tk4TnI9S/tw0Wd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260297722"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260297722"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:05:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644294273"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:05:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o43mg-000sUA-HH;
        Wed, 22 Jun 2022 20:04:54 +0300
Date:   Wed, 22 Jun 2022 20:04:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 1/8] serial: core: only get RS485 termination gpio if
 supported
Message-ID: <YrNLtg+BZlwKsBbF@smile.fi.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622154659.8710-2-LinoSanfilippo@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 22, 2022 at 05:46:52PM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In uart_get_rs485_mode() only try to get a termination GPIO if RS485 bus
> termination is supported by the driver.

I'm not sure I got the usefulness of this change.
We request GPIO line as optional, so if one is defined it in the DT/ACPI, then
they probably want to (opportunistically) have it.

The certain driver may or may not utilize this GPIO.

With your change it's possible to have a DTS where GPIO line defined in a
broken way and user won't ever know about it, if they are using platforms
without termination support.

-- 
With Best Regards,
Andy Shevchenko


