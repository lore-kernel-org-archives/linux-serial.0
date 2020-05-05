Return-Path: <SRS0=jHyV=6T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67ECC47247
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 16:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914C7206A4
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 16:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgEEQKh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 May 2020 12:10:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:18014 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbgEEQKh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 May 2020 12:10:37 -0400
IronPort-SDR: UpDI8n0BOGV6lGmcZD+nNjutQ09fhSb9TKWhtcDpHYarbVe+fT57rGzS+nFMmKiv5VzsLFRPQD
 4iEEnzsHcOdg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 09:10:36 -0700
IronPort-SDR: WWEw3Nh9BAn11LiQN0IQebCZMd4vt8vcGrtZuO44a3tC1g04rjtUuaZf83rBi3ZWUh2DsIjMCZ
 vlsZvNPrvzUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="248611950"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 05 May 2020 09:10:32 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jW09T-004qNH-Fm; Tue, 05 May 2020 19:10:35 +0300
Date:   Tue, 5 May 2020 19:10:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/4] serial: 8250: Support rs485 bus termination GPIO
Message-ID: <20200505161035.GW185537@smile.fi.intel.com>
References: <cover.1588505407.git.lukas@wunner.de>
 <a91b9392e8e7914cae16f59beb1ffe6b335f81c9.1588505407.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a91b9392e8e7914cae16f59beb1ffe6b335f81c9.1588505407.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 05, 2020 at 04:42:04PM +0200, Lukas Wunner wrote:
> Commit e8759ad17d41 ("serial: uapi: Add support for bus termination")
> introduced the ability to enable rs485 bus termination from user space.
> So far the feature is only used by a single driver, 8250_exar.c, using a
> hardcoded GPIO pin specific to Siemens IOT2040 products.
> 
> Provide for a more generic solution by allowing specification of an
> rs485 bus termination GPIO pin in the device tree:  Amend the serial
> core to retrieve the GPIO from the device tree (or ACPI table) and amend
> the default ->rs485_config() callback for 8250 drivers to change the
> GPIO on request from user space.

...

> @@ -3331,6 +3332,29 @@ int uart_get_rs485_mode(struct uart_port *port)

> +		devm_gpiod_put(dev, port->rs485_term_gpio);

> +	port->rs485_term_gpio = devm_gpiod_get_optional(dev, "rs485-term",

Using devm_*() in uart_get_rs485_mode() seems not right.
Why do you need this?

> +		GPIOD_FLAGS_BIT_DIR_SET | GPIOD_FLAGS_BIT_DIR_OUT);

Parameter has a specific macro GPIOD_OUT_HIGH.

-- 
With Best Regards,
Andy Shevchenko


