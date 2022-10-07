Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91EFC433F5
	for <linux-serial@archiver.kernel.org>; Fri,  7 Oct 2022 12:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJGMCT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 Oct 2022 08:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGMCT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 Oct 2022 08:02:19 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B712D0CE1
        for <linux-serial@vger.kernel.org>; Fri,  7 Oct 2022 05:02:17 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9C597280015C2;
        Fri,  7 Oct 2022 14:02:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 89CE2210EC; Fri,  7 Oct 2022 14:02:14 +0200 (CEST)
Date:   Fri, 7 Oct 2022 14:02:14 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Roosen Henri <Henri.Roosen@ginzinger.com>,
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
        Vicente Bergas <vicencb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serial: Deassert Transmit Enable on probe in
 driver-specific way
Message-ID: <20221007120214.GA11466@wunner.de>
References: <e688f63bc28827b0e8c9d8e2319e688aee412d24.1663733425.git.lukas@wunner.de>
 <Yyx0p4d5vcjt2XNB@kroah.com>
 <20220922154353.GA3559@wunner.de>
 <YyyIIIpPZD1gOToi@kroah.com>
 <20220922163042.GA12887@wunner.de>
 <07a4612c38cc9ab1bcaf01e5daf0ec1c53db7755.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a4612c38cc9ab1bcaf01e5daf0ec1c53db7755.camel@ew.tq-group.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 07, 2022 at 01:34:19PM +0200, Matthias Schiffer wrote:
> On Thu, 2022-09-22 at 18:30 +0200, Lukas Wunner wrote:
> > Here's a v4 with full changelog:
> > 
> > https://lore.kernel.org/linux-serial/2de36eba3fbe11278d5002e4e501afe0ceaca039.1663863805.git.lukas@wunner.de/
> 
> I've noticed that this patch (well, the version that was applied to
> tty.git) also changed the setting of the DTR flag in the MCR register.
> Without your patch, I can see that the values passed to
> serial8250_out_MCR() alternate between 0x03 and 0x01 when switching
> between tx and rx, but with your patch, the values become 0x02 and
> 0x00.
> 
> I'm not sure if setups RS485 exist where the DTR flag is relevant, but
> as this was not mentioned in the commit message, I suspect that the
> change might have been unintended.

That's intentional and documented in the following paragraph of the
commit message:

  Skip any invocation of ->set_mctrl() if RS485 is enabled.  RS485 has no
  hardware flow control, so the modem control lines are irrelevant and
  need not be touched.  When leaving RS485 mode, reset the modem control
  lines to the state stored in port->mctrl.  That way, UARTs which are
  muxed between RS485 and RS232 transceivers drive the lines correctly
  when switched to RS232.  (serial8250_do_startup() historically raises
  the OUT1 modem signal because otherwise interrupts are not signaled on
  ancient PC UARTs, but I believe that no longer applies to modern,
  RS485-capable UARTs and is thus safe to be skipped.)

I think that the Siemens IOT20x0 series muxes the UART between RS232
and RS485 transceivers, though I'm not sure if that applies both to
the contemporary AM6548-based IOT2050 and to the older Intel-based
machines.

In RS485 mode, the DTR signal should be completely irrelevant as
the transceiver is only attached to RX, TX and RTS pins.

When switching from RS485 to RS232 mode, the patch ensures that the
modem signals are reset to what's been saved in port->mctrl.  So DTR
will be raised once the UART is switched to RS232.

Thanks,

Lukas
