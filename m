Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5C1C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 10:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E422C20787
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 10:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389836AbgEYKi3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 06:38:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:57012 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389812AbgEYKi3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 06:38:29 -0400
IronPort-SDR: V84zDChHw/HhRXReTv+jGecjkBcFqi7pE9rhzk9lqIjnq9d0rNzcpCEdwVYsXOjy3JXHowKVoW
 FeZsNd6nOJoA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 03:38:28 -0700
IronPort-SDR: FzHnUj38vD7uccRSr5qhqk8pi9HmSPCEnWEKEvjuwlIcsw7jPsFSubKLshQSzMLIK/g7eD9Uob
 +EuV92xH0TEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="468017629"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 25 May 2020 03:38:27 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdAV4-008loA-2L; Mon, 25 May 2020 13:38:30 +0300
Date:   Mon, 25 May 2020 13:38:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/6] serial: core: Allow detach and attach serial
 device for console
Message-ID: <20200525103830.GO1634618@smile.fi.intel.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
 <20200217114016.49856-3-andriy.shevchenko@linux.intel.com>
 <20200524171032.GA218301@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524171032.GA218301@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 24, 2020 at 10:10:32AM -0700, Guenter Roeck wrote:
> On Mon, Feb 17, 2020 at 01:40:12PM +0200, Andy Shevchenko wrote:

> > -	if (uart_console_enabled(port))
> > +	if (uart_console(port))
> 
> This results in lockdep splashes such as the one attached below. Is there
> any special reason for this change ? It is not really explained in the
> commit description.

Thanks for the report.

Yes, because imx_uart_init() doesn't properly register a console.
I'll send a quick fix for that soon.

> [   15.439094] INFO: trying to register non-static key.
> [   15.439146] the code is fine but needs lockdep annotation.
> [   15.439196] turning off the locking correctness validator.
> [   15.439392] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc6-00244-gcaffb99b6929 #1
> [   15.439469] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> [   15.439887] [<c0112578>] (unwind_backtrace) from [<c010c4f4>] (show_stack+0x10/0x14)
> [   15.439982] [<c010c4f4>] (show_stack) from [<c06dfcb0>] (dump_stack+0xe4/0x11c)
> [   15.440053] [<c06dfcb0>] (dump_stack) from [<c01883e4>] (register_lock_class+0x8a0/0x924)
> [   15.440127] [<c01883e4>] (register_lock_class) from [<c01884d4>] (__lock_acquire+0x6c/0x2e80)
> [   15.440202] [<c01884d4>] (__lock_acquire) from [<c018756c>] (lock_acquire+0xf8/0x4f4)
> [   15.440274] [<c018756c>] (lock_acquire) from [<c0ddf02c>] (_raw_spin_lock_irqsave+0x50/0x64)
> [   15.440350] [<c0ddf02c>] (_raw_spin_lock_irqsave) from [<c07af5d8>] (uart_add_one_port+0x3a4/0x504)
> [   15.440431] [<c07af5d8>] (uart_add_one_port) from [<c089c990>] (platform_drv_probe+0x48/0x98)
> [   15.440506] [<c089c990>] (platform_drv_probe) from [<c089a708>] (really_probe+0x214/0x344)
> [   15.440578] [<c089a708>] (really_probe) from [<c089a948>] (driver_probe_device+0x5c/0x16c)
> [   15.440650] [<c089a948>] (driver_probe_device) from [<c089ac00>] (device_driver_attach+0x58/0x60)
> [   15.440727] [<c089ac00>] (device_driver_attach) from [<c089ac8c>] (__driver_attach+0x84/0xc0)
> [   15.440800] [<c089ac8c>] (__driver_attach) from [<c08987e8>] (bus_for_each_dev+0x70/0xb4)
> [   15.440874] [<c08987e8>] (bus_for_each_dev) from [<c08999a4>] (bus_add_driver+0x154/0x1e0)
> [   15.440946] [<c08999a4>] (bus_add_driver) from [<c089ba38>] (driver_register+0x74/0x108)
> [   15.441020] [<c089ba38>] (driver_register) from [<c144edb8>] (imx_uart_init+0x20/0x40)
> [   15.441090] [<c144edb8>] (imx_uart_init) from [<c010232c>] (do_one_initcall+0x80/0x3ac)
> [   15.441162] [<c010232c>] (do_one_initcall) from [<c1400ff0>] (kernel_init_freeable+0x170/0x204)
> [   15.441241] [<c1400ff0>] (kernel_init_freeable) from [<c0dd5c48>] (kernel_init+0x8/0x118)
> [   15.441313] [<c0dd5c48>] (kernel_init) from [<c0100134>] (ret_from_fork+0x14/0x20)
> [   15.441414] Exception stack(0xc609ffb0 to 0xc609fff8)
> [   15.441571] ffa0:                                     00000000 00000000 00000000 00000000
> [   15.441738] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   15.441872] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000

-- 
With Best Regards,
Andy Shevchenko


