Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBC1C10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 15:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6304A20757
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 15:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCRPQR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:16:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:36665 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbgCRPQR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 11:16:17 -0400
IronPort-SDR: cbqnT/rACaqFqy0ES+xI4i9iYYiruOiZ1dDp2xQ3+VEXAK60AsEyMV3LF/8a83sZY5g2ZwGA8X
 Gyv8JtNrjtNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 08:16:15 -0700
IronPort-SDR: GNGinEfU1ok5IN17OYJLuCHgFTfl53CTUj2LT+l6y7P3BefCK52DcH8YMYNhOmFR9GtOlzPACq
 vfgjhR6NHx9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="238218790"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2020 08:16:13 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jEaQZ-00AnOT-St; Wed, 18 Mar 2020 17:16:15 +0200
Date:   Wed, 18 Mar 2020 17:16:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH 7/7] serial: 8250_dw: allow enable rs485 at boot time
Message-ID: <20200318151615.GP1922688@smile.fi.intel.com>
References: <20200318142640.982763-1-heiko@sntech.de>
 <20200318142640.982763-8-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318142640.982763-8-heiko@sntech.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 18, 2020 at 03:26:40PM +0100, Heiko Stuebner wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> If "linux,rs485-enabled-at-boot-time" is specified need to setup 485
> in probe function.
> 
> Call uart_get_rs485_mode() to get rs485 configuration, then call
> rs485_config() callback directly to setup port as rs485.

I think you really need to Cc the new version of this to Lukas.
Because I have a deja vu that I have seen half of this to be similar what he
had done in his work.

-- 
With Best Regards,
Andy Shevchenko


