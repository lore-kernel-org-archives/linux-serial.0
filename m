Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9BDC74A5B
	for <linux-serial@archiver.kernel.org>; Sun, 26 Mar 2023 18:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCZSVe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Mar 2023 14:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCZSVd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Mar 2023 14:21:33 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A86580
        for <linux-serial@vger.kernel.org>; Sun, 26 Mar 2023 11:21:31 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 3970220618;
        Sun, 26 Mar 2023 20:21:28 +0200 (CEST)
Date:   Sun, 26 Mar 2023 20:21:24 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Message-ID: <ZCCNJNWYCbbIsnWR@francesco-nb.int.toradex.com>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
 <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
 <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
 <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
 <07d37e3e-dfe2-9e6e-a981-8d3c6a9fc5f5@i2se.com>
 <878rfk64hj.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rfk64hj.fsf@osv.gnss.ru>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Mar 25, 2023 at 10:00:24PM +0300, Sergey Organov wrote:
> In correctly working RT system this doesn't typically happen, as CPUs
> are way faster than typical UART speeds, and are able to handle the
> loads easily, provided UART has decent FIFO. It's disabling IRQs for
> prolonged times that makes shit happen.

The first time we were looking into this issue was before 7a637784d517
and with a PREEMPT-RT patched kernel (if I remember correctly it was a
v5.4).

The system was not loaded at all and it was pretty surprising the
behavior, because of the reasons you just wrote here.

Francesco

