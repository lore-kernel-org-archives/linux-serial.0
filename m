Return-Path: <SRS0=jHyV=6T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567C0C47254
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311EE206A4
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 16:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgEEQBW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 May 2020 12:01:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:39140 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbgEEQBW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 May 2020 12:01:22 -0400
IronPort-SDR: JqZgSMmuZuFUATufDhveyyPFrJOUisTJFcKwJbtVthSeBQ62MhtnmM+QjFrpeLL+xdg6UTDaDa
 Ei+j/A/iPx/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 09:01:00 -0700
IronPort-SDR: 9xOHo40R9REvcgbxn+Nr5wosgQR7+I1K2jVfQTB6QjjdVRPPTLMnD/bU+s+i0z6kGBsanBd7Nw
 6HM+Ym37rieA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="338699533"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 05 May 2020 09:00:58 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jW00D-004qJ2-C4; Tue, 05 May 2020 19:01:01 +0300
Date:   Tue, 5 May 2020 19:01:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/4] serial: 8250: Avoid error message on reprobe
Message-ID: <20200505160101.GV185537@smile.fi.intel.com>
References: <cover.1588505407.git.lukas@wunner.de>
 <b3fbbe8688d5e9d173168ae45295719ca4c9d35f.1588505407.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fbbe8688d5e9d173168ae45295719ca4c9d35f.1588505407.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 05, 2020 at 04:42:01PM +0200, Lukas Wunner wrote:
> If the call to uart_add_one_port() in serial8250_register_8250_port()
> fails, a half-initialized entry in the serial_8250ports[] array is left
> behind.
> 
> A subsequent reprobe of the same serial port causes that entry to be
> reused.  Because uart->port.dev is set, uart_remove_one_port() is called
> for the half-initialized entry and bails out with an error message:
> 
> bcm2835-aux-uart 3f215040.serial: Removing wrong port: (null) != (ptrval)
> 
> The same happens on failure of mctrl_gpio_init() since commit
> 4a96895f74c9 ("tty/serial/8250: use mctrl_gpio helpers").
> 
> Fix by zeroing the uart->port.dev pointer in the probe error path.

Fixes tag?

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v2.6.10+

...

>  			ret = uart_add_one_port(&serial8250_reg,
>  						&uart->port);
> -			if (ret == 0)
> +			if (ret)
> +				goto err;

> +			else

Redundant.

>  				ret = uart->port.line;

-- 
With Best Regards,
Andy Shevchenko


