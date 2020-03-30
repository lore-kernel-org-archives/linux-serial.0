Return-Path: <SRS0=m2iq=5P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935B6C43331
	for <linux-serial@archiver.kernel.org>; Mon, 30 Mar 2020 14:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6853E2072E
	for <linux-serial@archiver.kernel.org>; Mon, 30 Mar 2020 14:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgC3O4q (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:56:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:7882 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgC3O4q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Mar 2020 10:56:46 -0400
IronPort-SDR: rkZn9l1//fdEx+uNXJoiJ0ZFrdEk6SkG9Q/CyFSV0SvvvBIepSMWzHrxuYJcyePM8jasVza/23
 knMwkfiol0GA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 07:56:45 -0700
IronPort-SDR: edpFT0HIsEHMg/tLPRba1KhN2kNU/6sO0pnJBSTuDdi1YcvX5l4mugCCOZrI3uXuNCbo0U31Kp
 kNFvCspetNdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; 
   d="scan'208";a="239833481"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 30 Mar 2020 07:56:43 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jIvqH-00EEa1-Gd; Mon, 30 Mar 2020 17:56:45 +0300
Date:   Mon, 30 Mar 2020 17:56:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v2 6/7] serial: 8250: Support separate rs485 rx-enable
 GPIO
Message-ID: <20200330145645.GX1922688@smile.fi.intel.com>
References: <20200325231422.1502366-1-heiko@sntech.de>
 <20200325231422.1502366-7-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325231422.1502366-7-heiko@sntech.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 26, 2020 at 12:14:21AM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The RE signal is used to control the duplex mode of transmissions,
> aka receiving data while sending in full duplex mode, while stopping
> receiving data in half-duplex mode.
> 
> On a number of boards the !RE signal is tied to ground so reception
> is always enabled except if the UART allows disabling the receiver.
> This can be taken advantage of to implement half-duplex mode - like
> done on 8250_bcm2835aux.
> 
> Another solution is to tie !RE to RTS always forcing half-duplex mode.
> 
> And finally there is the option to control the RE signal separately,
> like done here by introducing a new rs485-specifc gpio that can be
> set depending on the RX_DURING_TX setting in the common em485 callbacks.


> +		if (port->rs485_re_gpio)

Redundant. Same for all other cases.

> +			gpiod_set_value(port->rs485_re_gpio, 1);


> +	port->rs485_re_gpio = devm_gpiod_get(dev, "rs485-rx-enable",
> +					       GPIOD_FLAGS_BIT_DIR_OUT);
> +	if (IS_ERR(port->rs485_re_gpio)) {
> +		ret = PTR_ERR(port->rs485_re_gpio);
> +		port->rs485_re_gpio = NULL;
> +		if (ret != -ENOENT) {
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "Cannot get rs485-rx-enable-gpios\n");
> +			return ret;
> +		}
> +	}

NIH of gpiod_get_optional().

-- 
With Best Regards,
Andy Shevchenko


