Return-Path: <SRS0=m2iq=5P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6EDC43331
	for <linux-serial@archiver.kernel.org>; Mon, 30 Mar 2020 14:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9D82073B
	for <linux-serial@archiver.kernel.org>; Mon, 30 Mar 2020 14:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgC3OvE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:51:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:52891 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgC3OvE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Mar 2020 10:51:04 -0400
IronPort-SDR: l3JrtsUXSnzSRdg6MF1Bp1wGgCNNFVTet9jSc5fNfuvUmGYe5ZYKZciS83QDQlMFK6wCazi4x0
 kYU15aR2wtZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 07:51:02 -0700
IronPort-SDR: 8x6LKW1BZpgkOpaBsEsSTOpNcDwxG0kfXVvoTJrEUwHjmjGfJnE2D4EZ4Y5/3vq5ZmX6L4A6mV
 +zYipkg/sfOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; 
   d="scan'208";a="294602545"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2020 07:51:00 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jIvkk-00EEVe-Lc; Mon, 30 Mar 2020 17:51:02 +0300
Date:   Mon, 30 Mar 2020 17:51:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com
Subject: Re: [PATCH DON'T APPLY v2 3/7] serial: 8250: Support rs485 bus
 termination GPIO
Message-ID: <20200330145102.GU1922688@smile.fi.intel.com>
References: <20200325231422.1502366-1-heiko@sntech.de>
 <20200325231422.1502366-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325231422.1502366-4-heiko@sntech.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 26, 2020 at 12:14:18AM +0100, Heiko Stuebner wrote:
> From: Lukas Wunner <lukas@wunner.de>
> 
> Amend the serial core to retrieve the rs485 bus termination GPIO from
> the device tree (or ACPI table) and amend the default ->rs485_config()
> callback for 8250 drivers to change the GPIO on request from user space.

> +	port->rs485_term_gpio = devm_gpiod_get(dev, "rs485-term",
> +					       GPIOD_FLAGS_BIT_DIR_OUT);
> +	if (IS_ERR(port->rs485_term_gpio)) {
> +		ret = PTR_ERR(port->rs485_term_gpio);
> +		port->rs485_term_gpio = NULL;
> +		if (ret != -ENOENT) {
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "Cannot get rs485-term-gpios\n");
> +			return ret;
> +		}

NIH of gpiod_get_optional().

> +	} else {
> +		ret = gpiod_get_value(port->rs485_term_gpio);
> +		if (ret < 0) {
> +			dev_err(dev, "Cannot get rs485-term-gpios value\n");
> +			return ret;
> +		}
> +		if (ret)
> +			rs485conf->flags |= SER_RS485_TERMINATE_BUS;
> +	}

-- 
With Best Regards,
Andy Shevchenko


