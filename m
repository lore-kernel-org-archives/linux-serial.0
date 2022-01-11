Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC46C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 11 Jan 2022 18:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbiAKSbo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:31:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:18094 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344959AbiAKSbo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jan 2022 13:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641925904; x=1673461904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ryXGJRwIBDLNRLqkigeBrzSsrgWtrQ49r2/rTwopAjE=;
  b=mrtIyStHfgLLtlsHYZgwaa9uXQUfiUYUDoYEwuj4mjXhBjB17fN4qI2I
   1fDLP3wwJiFhBCOCjCYWAYSe7gT9J2GpAdNDVRY2k9X+ymKxUNhuuunZ3
   j6PHkWpny6Lkx/AF2Yqb6wfFMNPKHzQhDw+j2O3kPcMsMwWVPFfuhX2In
   xfKSi858IzF2+zX8eD7A/7dxmrRI93bZu9RrzGJ568H6yUzWfJzzGUc8n
   jfL9RcAjUEgtzJuksznbGkkI5/olMYYSyUoygkK5WDHdf5X20mpiMD6OC
   nShgipOVRRjkSctAvkyK6oNuplsYaCiwOgvdI5SU+xME3p1qrCwBJfc8j
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243511685"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243511685"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 10:31:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="472553684"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 10:31:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7Lue-009NwM-K1;
        Tue, 11 Jan 2022 20:30:28 +0200
Date:   Tue, 11 Jan 2022 20:30:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     asheplyakov@basealt.ru
Cc:     linux-serial@vger.kernel.org,
        "Vadim V . Vlasov" <vadim.vlasov@elpitech.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] serial: 8250_dw: verify clock rate in dw8250_set_termios
Message-ID: <Yd3MxFo/R4C/0uvg@smile.fi.intel.com>
References: <20220111132847.218193-1-asheplyakov@basealt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111132847.218193-1-asheplyakov@basealt.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 11, 2022 at 05:28:47PM +0400, asheplyakov@basealt.ru wrote:
> From: Alexey Sheplyakov <asheplyakov@basealt.ru>

Thanks for your patch, my comments below.

> Refuse to change the clock rate if clk_round_rate() returns
> a rate which is way too off (i.e. by more than 1/16 from the one
> necessary for a given baud rate). In particular this happens if
> the requested rate is below the minimum supported by the clock.
> 
> Fixes the UART console on BE-M1000 SoC. Without this patch the
> console gets garbled immediately after loading the driver.
> dw8250_set_termios tries to configure the baud rate (115200),
> and calls clk_round_rate to figure out the supported rate closest
> to 1843200 Hz (which is 115200 * 16). However the (SoC-specific)
> clock driver returns 4705882 Hz. This frequency is way too off,
> hence after setting it the console gets garbled.

So, the root cause is to understand _why_ the clock provider is uncapable
to fulfil the request. Any investigation has been conducted?

> Signed-off-by: Alexey Sheplyakov <asheplyakov@basealt.ru>
> Signed-off-by: Vadim V. Vlasov <vadim.vlasov@elpitech.ru>

> 

Should be no blank lines in the tag block, but...

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>

...I recommend to use --cc parameter to git send-email instead of polluting
commit message.

...

> -	if (rate > 0) {
> +	if (rate > 0 && rate >= baud * 15 && rate <= baud * 17) {

It doesn't fell like a correct fix.

-- 
With Best Regards,
Andy Shevchenko


