Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042C5C19F2D
	for <linux-serial@archiver.kernel.org>; Thu, 11 Aug 2022 06:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiHKGSW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 11 Aug 2022 02:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHKGSW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 11 Aug 2022 02:18:22 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE5E83BE5
        for <linux-serial@vger.kernel.org>; Wed, 10 Aug 2022 23:18:19 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 0B6D010045BEA;
        Thu, 11 Aug 2022 08:18:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CA3016DC1E6; Thu, 11 Aug 2022 08:18:16 +0200 (CEST)
Date:   Thu, 11 Aug 2022 08:18:16 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Roosen Henri <Henri.Roosen@ginzinger.com>
Cc:     "chao.zeng@siemens.com" <chao.zeng@siemens.com>,
        "LinoSanfilippo@gmx.de" <LinoSanfilippo@gmx.de>,
        "baocheng_su@163.com" <baocheng_su@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "p.rosenberger@kunbus.com" <p.rosenberger@kunbus.com>,
        "baocheng.su@siemens.com" <baocheng.su@siemens.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "rgc@hms.se" <rgc@hms.se>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Re: [PATCH] serial: Fix incorrect rs485 polarity on uart open
Message-ID: <20220811061816.GA7472@wunner.de>
References: <9395767847833f2f3193c49cde38501eeb3b5669.1639821059.git.lukas@wunner.de>
 <8f538a8903795f22f9acc94a9a31b03c9c4ccacb.camel@ginzinger.com>
 <20220804155210.GA350@wunner.de>
 <72acc08080f3675f529160270be840b06629761c.camel@ginzinger.com>
 <20220805081851.GA21615@wunner.de>
 <33b4b797-cd4a-436e-8e03-4bc5d7dd69ff.d000f9d8-ed3e-456c-b23a-5a86eac57608.c023ef82-f7f7-4a43-92f1-8642a4f822e1@emailsignatures365.codetwo.com>
 <33b4b797-cd4a-436e-8e03-4bc5d7dd69ff.0668d69a-b7f6-4fc6-94cd-e3b904d4ce63.488ca449-4f1c-444b-8de0-1344d3aeb879@emailsignatures365.codetwo.com>
 <dae58f1aba37d89baa446f955db77cb4e557dcd0.camel@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dae58f1aba37d89baa446f955db77cb4e557dcd0.camel@ginzinger.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 05, 2022 at 11:20:24AM +0000, Roosen Henri wrote:
> On Fri, 2022-08-05 at 10:18 +0200, Lukas Wunner wrote:
> > On Thu, Aug 04, 2022 at 04:11:26PM +0000, Roosen Henri wrote:
> > > On Thu, 2022-08-04 at 17:52 +0200, Lukas Wunner wrote:
> > > > On Thu, Aug 04, 2022 at 02:38:23PM +0000, Roosen Henri wrote:
> > > > > unfortunately this commit, which has been backported to v5.4.x,
> > > > > seems
> > > > > to break RS485 functionality on our iMX boards.

Thanks for the report and sorry for the breakage.

I see what the problem is.  The serial core assumes that RTS in mctrl
has inverted semantics and that doesn't hold for mctrl_gpio.

I guess the takeaway is that deasserting RS485 Transmit Enable is
really driver-specific.  In particular, imx.c has support for using
CTS to drive Transmit Enable and the serial core can't deassert that
on probe because it doesn't know about this driver-specific feature.

In the case of imx.c, the driver already deasserts Transmit Enable via:
imx_uart_probe()
  uart_rs485_config()
    imx_uart_rs485_config()

(Those function names refer to current mainline, uart_rs485_config()
will be newly introduced in v6.0.)

Thus, just deleting deassertion from uart_configure_port() should fix
the issue for imx.c:

-		if (port->rs485.flags & SER_RS485_ENABLED &&
-		    !(port->rs485.flags & SER_RS485_RTS_AFTER_SEND))
-			port->mctrl |= TIOCM_RTS;

I need to go through all other rs485-capable drivers to check whether
the same is true for them or which ones need to be amended.  Please
stand by.

Thanks,

Lukas
