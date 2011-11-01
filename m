From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 02/14] ARM : SAMSUNG : Add RS485 support.
Date: Tue, 1 Nov 2011 12:18:51 +0000
Message-ID: <20111101121851.7d393277@bob.linux.org.uk>
References: <samsung_rs485>
	<1319255194-4799-1-git-send-email-paul.s.schilling@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8020 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942Ab1KAMIJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Nov 2011 08:08:09 -0400
In-Reply-To: <1319255194-4799-1-git-send-email-paul.s.schilling@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Schilling <paul.s.schilling@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>, Boojin Kim <boojin.kim@samsung.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> +config SAMSUNG_HAS_RS485
> +	bool "Enable RS485 support for Samsung"
> +	depends on SERIAL_SAMSUNG && (MACH_CONDOR2440 ||
> MACH_CONDOR2416 || MACH_MINI2440)
> +	default y if (MACH_CONDOR2440 || MACH_CONDOR2416)
> +	default n if (MACH_MINI2440)

There really needs to be more ARM thinking about doing this sort of
stuff at runtime. If you can detect the board type at runtime then you
need to be moving towards kicking board specifics out of the depends,
and treating it as an "include support for this, if the board has it"
so you can move towards less build time only configuration.

> +/* FIXME */
> +	#if 0
> +	if (last_state != en) {
> +

So this doesn't look ready to submit either...


> +		if ((utrstat & S3C2410_UTRSTAT_TXE) ? 1 : 0) {
> +			if (cfg->gpio_transmit_en > -1) {
> +
> gpio_set_value(cfg->gpio_transmit_en, 0);
> +			}

Lots of excess brackets (see CodingStyle) - removing a few of the
excess ones would make it easier to read later.

The later bits become a real mess of ifdefs - much not your fault, the
combination of your ifdefs and existing lack of design push it beyond
ugly and really want addressing.

