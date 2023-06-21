Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA721EB64DC
	for <linux-serial@archiver.kernel.org>; Wed, 21 Jun 2023 08:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjFUIns (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Jun 2023 04:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjFUInq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Jun 2023 04:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A91981
        for <linux-serial@vger.kernel.org>; Wed, 21 Jun 2023 01:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 577CC61474
        for <linux-serial@vger.kernel.org>; Wed, 21 Jun 2023 08:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A255C433C0;
        Wed, 21 Jun 2023 08:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687337024;
        bh=jPh+cWIIzkVcOdfCDcCnL3RUU3xzOmiv/mpSQR1lbjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMcCXp74OoMp9wF9KLI+/cK7HLw2b+mp6smTvz5M36Lwm2Ko0h/jUkjgzsWzZEFEx
         +v+yjwLIRhUolwuAhljVhXXNmXZit3cU3moVCtkVSbz7286kacn4p9GkS4oC8jWPRZ
         xR9GQyGXvXOU1Hu5kIIxY4r1Ea7Hk7IE8mtoXRbs=
Date:   Wed, 21 Jun 2023 10:43:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Message-ID: <2023062116-skintight-royal-39d8@gregkh>
References: <87mt3ynsa7.fsf@osv.gnss.ru>
 <d5009984-d2eb-0343-5bb4-df8a7f526121@i2se.com>
 <87sfcy8ncu.fsf@osv.gnss.ru>
 <534ac8db-ae8f-1ea3-9aa9-2105db7f7a52@i2se.com>
 <203ce87f-2898-eb10-2f8c-f237859d75e6@leemhuis.info>
 <87ttw2vnn0.fsf@osv.gnss.ru>
 <d1b6209d-a174-406a-cc81-86b391940c0c@i2se.com>
 <3853881c-976f-dadc-b64b-4ffd8cc88cf0@leemhuis.info>
 <2023062046-jersey-facecloth-7a5d@gregkh>
 <20230620192748.ey4oah22resbblej@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620192748.ey4oah22resbblej@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 20, 2023 at 09:27:48PM +0200, Uwe Kleine-König wrote:
> Hello Greg,
> 
> On Tue, Jun 20, 2023 at 04:59:18PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 20, 2023 at 04:47:10PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > On 24.05.23 15:07, Stefan Wahren wrote:
> > > > 
> > > > Am 23.05.23 um 21:44 schrieb Sergey Organov:
> > > >> "Linux regression tracking (Thorsten Leemhuis)"
> > > >> <regressions@leemhuis.info> writes:
> > > >>
> > > >> Solving this would need to identify the cause of interrupts being
> > > >> disabled for prolonged times, and nobody volunteered to investigate this
> > > >> further. One suspect, the Linux serial console, has been likely excluded
> > > >> already though, as not actually being in use for printk() output.
> > > >>
> > > > 
> > > > I don't think that we can exclude the serial console as a whole, i never
> > > > made such a observation. But at least we can exclude kernel logging on
> > > > the debug UART.
> > > 
> > > Stefan, just wondering: was this ever addressed upstream? I assume it's
> > > not, just wanted to be sure.
> > > 
> > > I'm a bit unsure what to do with this and consider asking Greg for
> > > advice, as he applied the patch. On one hand it's *IMHO* clearly a
> > > regression (but for the record,  some people involved in the discussion
> > > claim it's not). OTOH the culprit was applied more than a year ago now,
> > > so reverting it might cause more trouble than it's worth at this point,
> > > as that could lead to regressions for other users.
> > 
> > I'll be glad to revert this, but for some reason I thought that someone
> > was working on a "real fix" here.  Stefan, is that not the case?
> 
> Sergey Organov already said something similar, but not very explicit:
> With the current understanding reverting said commit is wrong. It is
> expected that the commit increases irq latency for imx-serial a bit for
> the benefit of less interrupts and so serves the overall system
> performance. That this poses a problem only means that on the reporter's
> machine there is already an issue that results in a longer period with
> disabled irqs. While reverting the imx-serial commit would (maybe) solve
> that, the actual problem is the other issue that disables preemption for
> a longer timespan.
> 
> So TL;DR: Please don't revert the imx-serial patch.

Ok, will leave this alone, it shouldn't be marked as a regression.

greg k-h
