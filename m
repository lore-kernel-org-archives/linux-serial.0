Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADE6C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 16:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B7C20758
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 16:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgERQfZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 12:35:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:42489 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERQfZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 12:35:25 -0400
IronPort-SDR: KvElP5/2Y7fTqu6FoVpLkWWMKzv155dsgLkDqyBd+64stnJCSJUASKVMKbarWal+DJ48hSuGIk
 a993Qs2DqCAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:35:25 -0700
IronPort-SDR: Qj+WXnA/CMDKXyowwwN+TrZetsAKeFYv7fSU5HWhoEvvxAtdWiX7hFyI6kx6ruaLQ1/tRW2ve8
 xe+TfSNshqKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="465640555"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 18 May 2020 09:35:20 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jaija-007T56-Mt; Mon, 18 May 2020 19:35:22 +0300
Date:   Mon, 18 May 2020 19:35:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maarten Brock <m.brock@vanmierlo.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Heiko Stuebner <heiko@sntech.de>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH v3 3/5] serial: 8250: Support separate rs485 rx-enable
 GPIO
Message-ID: <20200518163522.GK1634618@smile.fi.intel.com>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-4-heiko@sntech.de>
 <20200518151241.GG1634618@smile.fi.intel.com>
 <20200518152247.slenjeiiplps7mcd@wunner.de>
 <33547f6a596df2ca2ee8e647111e5fa1@vanmierlo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33547f6a596df2ca2ee8e647111e5fa1@vanmierlo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 18, 2020 at 06:13:16PM +0200, Maarten Brock wrote:
> On 2020-05-18 17:22, Lukas Wunner wrote:
> > On Mon, May 18, 2020 at 06:12:41PM +0300, Andy Shevchenko wrote:
> > > On Sun, May 17, 2020 at 11:56:08PM +0200, Heiko Stuebner wrote:
> > > > From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > > >
> > > > The RE signal is used to control the duplex mode of transmissions,
> > > > aka receiving data while sending in full duplex mode, while stopping
> > > > receiving data in half-duplex mode.
> > > >
> > > > On a number of boards the !RE signal is tied to ground so reception
> > > > is always enabled except if the UART allows disabling the receiver.
> > > > This can be taken advantage of to implement half-duplex mode - like
> > > > done on 8250_bcm2835aux.
> > > >
> > > > Another solution is to tie !RE to RTS always forcing half-duplex mode.
> > > >
> > > > And finally there is the option to control the RE signal separately,
> > > > like done here by introducing a new rs485-specific gpio that can be
> > > > set depending on the RX_DURING_TX setting in the common em485 callbacks.
> > > 
> > > ...
> > > 
> > > > +	port->rs485_re_gpio = devm_gpiod_get_optional(dev, "rs485-rx-enable",
> > > > +						      GPIOD_OUT_HIGH);
> > > 
> > > While reviewing some other patch I realized that people are missing
> > > the
> > > point of these GPIO flags when pin is declared to be output.
> > > 
> > > HIGH here means "asserted" (consider active-high vs. active-low in
> > > general). Is that the intention here?
> > > 
> > > Lukas, same question to your patch.
> > 
> > Yes.  "High", i.e. asserted, means "termination enabled" in the case of
> > my patch and "receiver enabled" in the case of Heiko's patch.
> 
> But "High" on a gpio would disable the receiver when connected to !RE.

No, that's exactly the point of the terminology (asserted means active whatever
polarity it is). You need to define active-low in GPIO description.

-- 
With Best Regards,
Andy Shevchenko


