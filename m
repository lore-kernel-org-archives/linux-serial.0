Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31495C4332E
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 09:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D25F20781
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 09:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgCWJVA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:21:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:20348 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbgCWJVA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 05:21:00 -0400
IronPort-SDR: WEXzNihlEXtyDYoBPhEtrtRWaHqYjryxPhdw/OUSP4q3Hzgq0c3lOhzbPidJgRiUctiPyYoJor
 RuSNzm5jcx1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 02:20:58 -0700
IronPort-SDR: NXZmagiSdrqKSbmt0vSeK1caYhZUJdpRy1VNqw/fs6h11L6MFR3KCibk2GOh3bYY+mYvl5cexF
 nNhcReiFjm9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,295,1580803200"; 
   d="scan'208";a="239873817"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2020 02:20:50 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jGJGN-00CCZd-2B; Mon, 23 Mar 2020 11:20:51 +0200
Date:   Mon, 23 Mar 2020 11:20:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_dw: Fix common clocks usage race
 condition
Message-ID: <20200323092051.GB1922688@smile.fi.intel.com>
References: <20200306130231.05BBC8030795@mail.baikalelectronics.ru>
 <20200323024611.16039-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323024611.16039-1-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 23, 2020 at 05:46:09AM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

The question to CLK framework maintainers, is it correct approach in general
for this case?

> There are races possible in the dw8250_set_termios() callback method
> and while the device is in PM suspend state. A race condition may
> happen if the baudrate clock source device is shared with some other
> device (in our machine it's another DW UART port). In this case if that
> device changes the clock rate while serial console is using it the
> DW 8250 UART port might not only end up with an invalid uartclk value
> saved, but may also experience a distorted output data since baud-clock
> could have been changed. In order to fix this lets enable an exclusive
> reference clock rate access in case if "baudclk" device is specified.
> 
> So if some other device also acquires the rate exclusivity during the
> time of a DW UART 8250 port being opened, then DW UART 8250 driver
> won't be able to alter the baud-clock. It shall just use the available
> clock rate. Similarly another device also won't manage to change the
> rate at that time. If nothing else have the exclusive rate access
> acquired except DW UART 8250 driver, then the driver will be able to
> alter the rate as much as it needs to in accordance with the currently
> implemented logic.

Thank you for an update, my comments below.

...

> +static int dw8250_startup(struct uart_port *p)
> +{
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
> +
> +	/*
> +	 * Some platforms may provide a reference clock shared between several
> +	 * devices. In this case before using the serial port first we have to
> +	 * make sure nothing will change the rate behind our back and second
> +	 * the tty/serial subsystem knows the actual reference clock rate of
> +	 * the port.
> +	 */

> +	if (clk_rate_exclusive_get(d->clk)) {
> +		dev_warn(p->dev, "Couldn't lock the clock rate\n");

So, if this fails, in ->shutdown you will disbalance reference count, or did I
miss something?

> +	} else if (d->clk) {

> +		p->uartclk = clk_get_rate(d->clk);
> +		if (!p->uartclk) {
> +			clk_rate_exclusive_put(d->clk);
> +			dev_err(p->dev, "Clock rate not defined\n");
> +			return -EINVAL;
> +		}

This operations I didn't get. If we have d->clk and suddenly get 0 as a rate
(and note, that we still update uartclk member!), we try to put (why?) the
exclusiveness of rate.

> +	}
> +
> +	return serial8250_do_startup(p);
> +}
> +
> +static void dw8250_shutdown(struct uart_port *p)
> +{
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
> +
> +	serial8250_do_shutdown(p);
> +
> +	clk_rate_exclusive_put(d->clk);
> +}

-- 
With Best Regards,
Andy Shevchenko


