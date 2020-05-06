Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE40C28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 10:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E87020714
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 10:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgEFKGS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 06:06:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:3649 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbgEFKGS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 06:06:18 -0400
IronPort-SDR: LvCUp3GI6Anddjxj7Mu7TnDSso6jqAZVDCJOX6QaSNArl0eOblQyEGpxpM5rN/tgtIxchDXgrd
 LjfCBkfh39Qg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 03:06:18 -0700
IronPort-SDR: r19fuwUAueJL4DFUdiljy6sVx5zQvf9+yQP4hJCUiZTP25VNaXqoNlQwTohkNsUKBARrVf06PO
 hhGE6YObO1rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,358,1583222400"; 
   d="scan'208";a="407189115"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 06 May 2020 03:06:15 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jWGwT-004zXQ-Lf; Wed, 06 May 2020 13:06:17 +0300
Date:   Wed, 6 May 2020 13:06:17 +0300
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
Message-ID: <20200506100617.GC185537@smile.fi.intel.com>
References: <cover.1588505407.git.lukas@wunner.de>
 <a91b9392e8e7914cae16f59beb1ffe6b335f81c9.1588505407.git.lukas@wunner.de>
 <20200505161035.GW185537@smile.fi.intel.com>
 <20200506062943.qugqwhnkismnnkrb@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506062943.qugqwhnkismnnkrb@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 06, 2020 at 08:29:43AM +0200, Lukas Wunner wrote:
> On Tue, May 05, 2020 at 07:10:35PM +0300, Andy Shevchenko wrote:
> > On Tue, May 05, 2020 at 04:42:04PM +0200, Lukas Wunner wrote:

...

> > > +		devm_gpiod_put(dev, port->rs485_term_gpio);
> > 
> > > +	port->rs485_term_gpio = devm_gpiod_get_optional(dev, "rs485-term",
> > 
> > Using devm_*() in uart_get_rs485_mode() seems not right.
> > Why do you need this?
> 
> uart_get_rs485_mode() is called from a driver's ->probe() hook and we
> do not have a corresponding function that is called from a ->remove()
> hook where we'd be able to relinquish rs485 resources we've acquired
> on probe.
> 
> Of course I could add that but it would be more heavy-weight compared
> to simply using devm_*().  Do you disagree?
> 
> devm_gpiod_put() isn't strictly necessary here.  It is only necessary
> if one of the drivers would invoke uart_get_rs485_mode() multiple
> times, which none of them does AFAICS.  It's just a safety measure.
> I can drop it if that is preferred.

I think putting and re-requesting here is also racy. Somebody can request the
very same GPIO in between (for example crazy user space tool).

Setting the same value many times won't hurt.

> > > +		GPIOD_FLAGS_BIT_DIR_SET | GPIOD_FLAGS_BIT_DIR_OUT);
> > 
> > Parameter has a specific macro GPIOD_OUT_HIGH.
> 
> Good point.  It's also occurred to me now that reading the GPIO's
> value after changing its direction to output is nonsense.  If anything
> it ought to be read *before* changing the direction to output.

It's not a complete nonsense, depends what you actually want to achieve here.

> That would make sense in case the board has a pullup or pulldown on
> the Termination Enable pin.  In other cases the pin may just float
> and the value will be unpredictable.  However if I do not read the
> pin, I'd have to choose either high or low as initial state.  Hm.
> Let me check back with our hardware engineers today and see what they
> recommend.

-- 
With Best Regards,
Andy Shevchenko


