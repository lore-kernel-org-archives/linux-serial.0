Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46679C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 11 Jan 2022 20:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiAKUiC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:38:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:21751 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233821AbiAKUiA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jan 2022 15:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641933480; x=1673469480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFRPJoHTfoEZX+82+SqdM5VQ+epTLmVaHhIvJhwv3NI=;
  b=IUBdsYO9/3jRVcIhorz8O5D4iAhIrmVSjWNmMAeBTHFuXe39Pl+WP6KV
   E4+crndm+9n+LgeGtEebU7wMMD7+QNCJ3ZyYuvlQO6dV2n53Z8otOGlII
   sIR8kE9nIoR3lCnjWP0D1k3egaQ0oZJtEIAt2u/xA8YuJfMFv1mxbfzvT
   5Ft5FpO+ZVnWwxKABIxWzdnzCB4KGqJxDvnjHq7Ydjml81PPvdzrc0nEA
   sykyUmCw0nVWWN/7OziW7e2286u3TgeZ12yQVwKpWCdGjSBDOh82umzP8
   kyZbs07biVzujI055cYtZd8CwBWqaG4kQGL8eHttVNYx7Q61lrRp12NEW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="242395037"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="242395037"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 12:37:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="474664815"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 12:37:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7Nsh-009RAC-6R;
        Tue, 11 Jan 2022 22:36:35 +0200
Date:   Tue, 11 Jan 2022 22:36:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexey Sheplyakov <asheplyakov@basealt.ru>
Cc:     linux-serial@vger.kernel.org,
        "Vadim V . Vlasov" <vadim.vlasov@elpitech.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] serial: 8250_dw: verify clock rate in dw8250_set_termios
Message-ID: <Yd3qUhgLAIJjScMm@smile.fi.intel.com>
References: <20220111132847.218193-1-asheplyakov@basealt.ru>
 <Yd3MxFo/R4C/0uvg@smile.fi.intel.com>
 <Yd3kyuBf680xvHMR@asheplyakov-rocket>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd3kyuBf680xvHMR@asheplyakov-rocket>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 12, 2022 at 12:12:58AM +0400, Alexey Sheplyakov wrote:
> On Tue, Jan 11, 2022 at 08:30:28PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 11, 2022 at 05:28:47PM +0400, asheplyakov@basealt.ru wrote:

> > > Refuse to change the clock rate if clk_round_rate() returns
> > > a rate which is way too off (i.e. by more than 1/16 from the one
> > > necessary for a given baud rate). In particular this happens if
> > > the requested rate is below the minimum supported by the clock.
> > > 
> > > Fixes the UART console on BE-M1000 SoC. Without this patch the
> > > console gets garbled immediately after loading the driver.
> > > dw8250_set_termios tries to configure the baud rate (115200),
> > > and calls clk_round_rate to figure out the supported rate closest
> > > to 1843200 Hz (which is 115200 * 16). However the (SoC-specific)
> > > clock driver returns 4705882 Hz. This frequency is way too off,
> > > hence after setting it the console gets garbled.
> > 
> > So, the root cause is to understand _why_ the clock provider is uncapable
> > to fulfil the request. Any investigation has been conducted?
> 
> Yes. On BE-M1000 SoC Linux has no direct control over (most) clocks.
> The registers of CMU (clock management unit) are accessible only from
> the secure world, therefore clocks are managed by the firmware (ARM-TF).
> Linux' driver is a shim which calls into the firmware. And that
> 4705882 Hz is exactly what is returned by firmware.

> > > -	if (rate > 0) {
> > > +	if (rate > 0 && rate >= baud * 15 && rate <= baud * 17) {
> > 
> > It doesn't fell like a correct fix.
> 
> What is the correct way to check if the rate returned by clk_round_rate
> makes sense for the (new) baud rate? See, clk_round_rate is supposed to
> give a supported rate which is closest to the requested one. Usually it
> appears to be "close enough" to the requested rate (or an error), however
> (as far as I understand) there is no a formal requirement (and it's up
> to the driver to decide how close is "close enough").
> 
> Or should we just hope that the clock provider does the right thing?

Does this hardware even work? I mean is it possible to change baud rate?

To me the proper solution sounds like the driver on this hardware should
not use CCF approach, i.e. use only DLAB for baud rate and fixed rate clock
of the bus or so.

-- 
With Best Regards,
Andy Shevchenko


