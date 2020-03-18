Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144B0C5AD43
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FB620777
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 15:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgCRPJm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:09:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:4178 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbgCRPJ0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 11:09:26 -0400
IronPort-SDR: SRvoJ1UsaE9GPxsLflTWZEOK7mXfbPjTBADyX4MPs/YO4UwiiFjzwhjSOzkja69d/jHYRx3ae3
 qain5uuH8cYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 08:09:25 -0700
IronPort-SDR: QgXPe2zraTvcFJFPzJA53gRwWZDVVY7j8aM1EGopf5bVV+x4ePads7C5BXxBUX3mXm1k6cNcMu
 iS+7+VqwQqPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="263410997"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 18 Mar 2020 08:09:23 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jEaJx-00AnHz-KV; Wed, 18 Mar 2020 17:09:25 +0200
Date:   Wed, 18 Mar 2020 17:09:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH 2/7] serial: 8250: add serial_in_poll_timeout helper
Message-ID: <20200318150925.GM1922688@smile.fi.intel.com>
References: <20200318142640.982763-1-heiko@sntech.de>
 <20200318142640.982763-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318142640.982763-3-heiko@sntech.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 18, 2020 at 03:26:35PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> In cases where a serial register needs to be polled until a specific
> state, this should have a timeout as noted in the thread bringing em485
> support to 8250_dw.
> 
> To not re-implement timeout handling in each case, add a helper modelled
> after readx_poll_timeout / regmap_read_poll_timeout to facilitate this.

> +#define serial_in_poll_timeout(port, offs, val, cond, timeout_us) \

This can (re-)use readx_poll_timeout().

Example:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?h=testing&id=b0415c224926c6d94c778d72f3d44c83862eb214

-- 
With Best Regards,
Andy Shevchenko


