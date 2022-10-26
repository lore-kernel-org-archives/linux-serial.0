Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7115C38A2D
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 08:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiJZIJe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiJZIJd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 04:09:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87C639F
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 01:09:29 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1onbTU-00034S-7v; Wed, 26 Oct 2022 10:09:20 +0200
Message-ID: <1c37cf9a17c1b28b4ae3301a6f8d40349d1b6deb.camel@pengutronix.de>
Subject: Re: imx serial chars lost issue
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Francesco Dolcini <francesco@dolcini.it>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Fugang Duan <fugang.duan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Johan Hovold <johan@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Wed, 26 Oct 2022 10:09:18 +0200
In-Reply-To: <Y1jihi+8L4ctFO9B@francesco-nb.int.toradex.com>
References: <20221003110850.GA28338@francesco-nb.int.toradex.com>
         <CAOMZO5BWUrFWyLFo8X=TfOBtoc6U0vNYR3k7wPNcVXd93q+Wjg@mail.gmail.com>
         <Y1jihi+8L4ctFO9B@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Francesco,

Am Mittwoch, dem 26.10.2022 um 09:32 +0200 schrieb Francesco Dolcini:
> On Wed, Oct 26, 2022 at 12:06:34AM -0300, Fabio Estevam wrote:
> > Hi Francesco,
> > 
> > On Mon, Oct 3, 2022 at 8:08 AM Francesco Dolcini
> > <francesco.dolcini@toradex.com> wrote:
> > > 
> > > Hello all,
> > > recently I have been experiencing an issue with the imx uart on i.MX6ULL
> > 
> > Does this also happen with other i.MX devices or only on i.MX6ULL?
> 
> I do not know for sure, I did not try to actively reproduce the issue on
> another SoC. On the other hand the issue with the i.MX6ULL was noticed
> during some testing, and we do exactly the same tests on other SoC and
> there the issue is either not present or just happening very
> infrequently.
> 
IRQ latency is influenced by lots of things like CPU frequency and idle
behavior and the involved drivers on a specific SoC, as they might
disable interrupt processing for too long.

To test the hypothesis you can enable CONFIG_IRQSOFF_TRACER and then
see if you find any smoking gun by running your testcase with this
tracer enabled.

Regards,
Lucas

> > > SoC, on the tty console (no flow control, 1152008n1), chars after the 32nd
> > > are lost when typing "fast" (copy/paste or writing to the uart using
> > > automated tools).
> > > 
> > > This was tested on Linux 6.0, however it does not look like a brand new
> > > regression, kernel 5.4 was somehow subject to the same issue, although
> > > it was way more difficult to trigger it.
> > > 
> > > While I do understand that without flow control this is something that
> > > cannot be prevented, it is pretty fishy that is always the chars after
> > > the 32nd.
> > > 
> > > I guess that might be happening is that the FIFO is emptied only by a
> > > timer or when it is full, instead of emptying it when half-full, and the
> > > CPU might not be fast enough leading to an overflow and the chars lost.
> > > 
> > > Any idea?
> > 
> > Can you share a reproducer?
> 
> Just open the uart console with a terminal application and copy/paste the
> following:
> 
>  echo -n "12345678901234567890123456789012345678901234567890123456789012345678901234567890" | wc
> 
> This is supposed to count 80 chars, you'll get less.
> 
> For doing that minicom is not a good choice since we noticed that it
> introduces quite some delay between each chars, while using `screen` I
> am able to reproduce the issue systematically. We initially reproduced
> the issue using `ser2net` with the exact same test.
> 
> Francesco
> 
> 


