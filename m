Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD66C54EE9
	for <linux-serial@archiver.kernel.org>; Thu, 22 Sep 2022 16:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiIVQHC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Sep 2022 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiIVQHB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Sep 2022 12:07:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31D7DCCF2
        for <linux-serial@vger.kernel.org>; Thu, 22 Sep 2022 09:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D306366C
        for <linux-serial@vger.kernel.org>; Thu, 22 Sep 2022 16:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D175C433B5;
        Thu, 22 Sep 2022 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663862819;
        bh=3O93M/c8f2HeWZjud93eHpdJL/MrKSr5BCzGV4gBQuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xtnl8j/vASkHfcxOEeCMFynLlS64ZghVk2GIV1b90DAuOk41YkwvFtUfTY+NzOXLc
         sxODbCvVf6bkdCnbpmfROvskZKXxPMOCWXt3vsSuXKKtXPb/ffJN3LyldlThN6BAW0
         L4PprQ9qt4BQXmK39sS/1a9IzcnWz4pdEGzN11Z4=
Date:   Thu, 22 Sep 2022 18:06:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Roosen Henri <Henri.Roosen@ginzinger.com>,
        linux-serial@vger.kernel.org,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        David Laight <David.Laight@aculab.com>,
        Maarten Brock <m.brock@vanmierlo.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        Peter Hung <hpeter+linux_kernel@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        "Codrin.Ciubotariu@microchip.com" <Codrin.Ciubotariu@microchip.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dario Binacchi <dariobin@libero.it>,
        Bich Hemon <bich.hemon@st.com>, Marek Vasut <marex@denx.de>,
        Vicente Bergas <vicencb@gmail.com>
Subject: Re: [PATCH v2] serial: Deassert Transmit Enable on probe in
 driver-specific way
Message-ID: <YyyIIIpPZD1gOToi@kroah.com>
References: <e688f63bc28827b0e8c9d8e2319e688aee412d24.1663733425.git.lukas@wunner.de>
 <Yyx0p4d5vcjt2XNB@kroah.com>
 <20220922154353.GA3559@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922154353.GA3559@wunner.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 22, 2022 at 05:43:53PM +0200, Lukas Wunner wrote:
> On Thu, Sep 22, 2022 at 04:43:51PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 21, 2022 at 06:39:33AM +0200, Lukas Wunner wrote:
> > > When a UART port is newly registered, uart_configure_port() seeks to
> > > deassert RS485 Transmit Enable by setting the RTS bit in port->mctrl.
> > > However a number of UART drivers interpret a set RTS bit as *assertion*
> > > instead of deassertion:  Affected drivers include those using
> > > serial8250_em485_config() (except 8250_bcm2835aux.c) and some using
> > > mctrl_gpio (e.g. imx.c).
> > > 
> > > Since the interpretation of the RTS bit is driver-specific, it is not
> > > suitable as a means to centrally deassert Transmit Enable in the serial
> > > core.  Instead, the serial core must call on drivers to deassert it in
> > > their driver-specific way.  One way to achieve that is to call
> > > ->rs485_config().  It implicitly deasserts Transmit Enable.
> > > 
> > > So amend uart_configure_port() and uart_resume_port() to invoke
> > > uart_rs485_config().  That allows removing calls to uart_rs485_config()
> > > from drivers' ->probe() hooks and declaring the function static.
> [...]
> > 
> > This message never made it to lore.kernel.org, so I can't seem to apply
> > it using `b4`.
> > 
> > Can you resend it so that it does make it to the public archives?
> 
> Yes, both v1 and v2 didn't make it to the mailing list archive.
> My suspicion is that the Cc: line was probably too long.
> 
> I resent as v3 with only you in To: and the mailing list in Cc: and
> this time it went through:
> 
> https://lore.kernel.org/linux-serial/2de36eba3fbe11278d5002e4e501afe0ceaca039.1663860626.git.lukas@wunner.de/
> 
> On the bright side, v2 contained an embarrassing checkpatch issue
> (superfluous newline) and resending as v3 provided a welcome
> opportunity to fix that. :)

v3 did not have a changelog :(

v4?
