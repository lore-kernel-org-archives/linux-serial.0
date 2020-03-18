Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5731EC10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 18:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCD32077E
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 18:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCRS2U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:28:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38898 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRS2U (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 14:28:20 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jEdQK-0005XX-W0; Wed, 18 Mar 2020 19:28:13 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 7/7] serial: 8250_dw: allow enable rs485 at boot time
Date:   Wed, 18 Mar 2020 19:28:12 +0100
Message-ID: <13430289.tR4kZXp1X6@diego>
In-Reply-To: <20200318151615.GP1922688@smile.fi.intel.com>
References: <20200318142640.982763-1-heiko@sntech.de> <20200318142640.982763-8-heiko@sntech.de> <20200318151615.GP1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am Mittwoch, 18. März 2020, 16:16:15 CET schrieb Andy Shevchenko:
> On Wed, Mar 18, 2020 at 03:26:40PM +0100, Heiko Stuebner wrote:
> > From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > 
> > If "linux,rs485-enabled-at-boot-time" is specified need to setup 485
> > in probe function.
> > 
> > Call uart_get_rs485_mode() to get rs485 configuration, then call
> > rs485_config() callback directly to setup port as rs485.
> 
> I think you really need to Cc the new version of this to Lukas.
> Because I have a deja vu that I have seen half of this to be similar what he
> had done in his work.

Could you give me a pointer to that work?

When I initially searched for previous rs485 on 8250_dw stuff I only
found the series from 2018 I linked to in the cover-letter, so if there
is other work somewhere else a pointer to it would be very helpful
for me.

Thanks
Heiko



