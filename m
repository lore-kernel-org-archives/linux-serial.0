Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72637C6FA82
	for <linux-serial@archiver.kernel.org>; Thu, 22 Sep 2022 16:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiIVQbo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Sep 2022 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiIVQbT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Sep 2022 12:31:19 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A90BE7C27
        for <linux-serial@vger.kernel.org>; Thu, 22 Sep 2022 09:30:48 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id CAEEA3004D796;
        Thu, 22 Sep 2022 18:30:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B0BDEBB; Thu, 22 Sep 2022 18:30:42 +0200 (CEST)
Date:   Thu, 22 Sep 2022 18:30:42 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20220922163042.GA12887@wunner.de>
References: <e688f63bc28827b0e8c9d8e2319e688aee412d24.1663733425.git.lukas@wunner.de>
 <Yyx0p4d5vcjt2XNB@kroah.com>
 <20220922154353.GA3559@wunner.de>
 <YyyIIIpPZD1gOToi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyyIIIpPZD1gOToi@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 22, 2022 at 06:06:56PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 22, 2022 at 05:43:53PM +0200, Lukas Wunner wrote:
> > On Thu, Sep 22, 2022 at 04:43:51PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Sep 21, 2022 at 06:39:33AM +0200, Lukas Wunner wrote:
> > > > When a UART port is newly registered, uart_configure_port() seeks to
> > > > deassert RS485 Transmit Enable by setting the RTS bit in port->mctrl.
> > > > However a number of UART drivers interpret a set RTS bit as *assertion*
> > > > instead of deassertion:  Affected drivers include those using
> > > > serial8250_em485_config() (except 8250_bcm2835aux.c) and some using
> > > > mctrl_gpio (e.g. imx.c).
> > > > 
> > > > Since the interpretation of the RTS bit is driver-specific, it is not
> > > > suitable as a means to centrally deassert Transmit Enable in the serial
> > > > core.  Instead, the serial core must call on drivers to deassert it in
> > > > their driver-specific way.  One way to achieve that is to call
> > > > ->rs485_config().  It implicitly deasserts Transmit Enable.
> > > > 
> > > > So amend uart_configure_port() and uart_resume_port() to invoke
> > > > uart_rs485_config().  That allows removing calls to uart_rs485_config()
> > > > from drivers' ->probe() hooks and declaring the function static.
> > [...]
> > > 
> > > This message never made it to lore.kernel.org, so I can't seem to apply
> > > it using `b4`.
> > > 
> > > Can you resend it so that it does make it to the public archives?
> > 
> > Yes, both v1 and v2 didn't make it to the mailing list archive.
> > My suspicion is that the Cc: line was probably too long.
> > 
> > I resent as v3 with only you in To: and the mailing list in Cc: and
> > this time it went through:
> > 
> > https://lore.kernel.org/linux-serial/2de36eba3fbe11278d5002e4e501afe0ceaca039.1663860626.git.lukas@wunner.de/
> > 
> > On the bright side, v2 contained an embarrassing checkpatch issue
> > (superfluous newline) and resending as v3 provided a welcome
> > opportunity to fix that. :)
> 
> v3 did not have a changelog :(
> 
> v4?

Well, the changelog is above.  (Only the superfluous newline was removed
in v3 vis-à-vis v2.)

Here's a v4 with full changelog:

https://lore.kernel.org/linux-serial/2de36eba3fbe11278d5002e4e501afe0ceaca039.1663863805.git.lukas@wunner.de/
