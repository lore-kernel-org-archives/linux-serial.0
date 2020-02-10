Return-Path: <SRS0=+uUE=36=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FDDC352A3
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 10:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8924820842
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 10:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgBJKJp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:09:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:44107 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgBJKJo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Feb 2020 05:09:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 02:09:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,424,1574150400"; 
   d="scan'208";a="221504846"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2020 02:09:42 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j160d-000XHT-RW; Mon, 10 Feb 2020 12:09:43 +0200
Date:   Mon, 10 Feb 2020 12:09:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        haolee.swjtu@gmail.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pnp: pass IRQ shared flag to UART ports
Message-ID: <20200210100943.GR10400@smile.fi.intel.com>
References: <1581223347-31534-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581223347-31534-1-git-send-email-lirongqing@baidu.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Feb 09, 2020 at 12:42:27PM +0800, Li RongQing wrote:
> On some systems IRQ lines might be shared between multiple devices.
> If so, the irqflags have to be configured accordingly. The reason is:
> The 8250 port startup code performs IRQ tests *before* the IRQ handler
> for that particular port is registered.

Thanks for the report.

Before we proceed with it, can we have more information about the device in question?
How is it enumerated? What is in resources (ACPI / or ...?) for this device?
Also how IPMI is being involved to all this and why?

> This commit fixed the below issue:
> [  973.782131] 8250 request irq 00000000f5a0e2ae 00000000f5a0e2ae 0
> [  973.785414] genirq: Flags mismatch irq 16. 00000004 (ttyS0) vs. 00000084 (ipmi_si)
> [  973.788741] CPU: 0 PID: 1 Comm: systemd Tainted: G            E     4.19.0-1.0.0.1.rc2 #5
> [  973.792112] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 0.18 06/10/2019
> [  973.795577] Call trace:
> [  973.799018]  dump_backtrace+0x0/0x198
> [  973.802493]  show_stack+0x24/0x30
> [  973.805965]  dump_stack+0x9c/0xbc
> [  973.809357]  __setup_irq+0x150/0x6c0
> [  973.812663]  request_threaded_irq+0xe8/0x180
> [  973.815891]  univ8250_setup_irq+0x278/0x2a0
> [  973.819007]  serial8250_do_startup+0x468/0x818
> [  973.822060]  serial8250_startup+0x38/0x48

Nit: no need to put entire stack for this.

> --- a/drivers/tty/serial/8250/8250_pnp.c
> +++ b/drivers/tty/serial/8250/8250_pnp.c
> @@ -476,6 +476,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
>  		uart.port.flags |= UPF_SHARE_IRQ;
>  	uart.port.uartclk = 1843200;
>  	uart.port.dev = &dev->dev;
> +	uart.port.irqflags |= IRQF_SHARED;

Why not to use UPF_SHARE_IRQ flags instead?

-- 
With Best Regards,
Andy Shevchenko


