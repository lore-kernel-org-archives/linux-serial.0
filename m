Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104AAC433FE
	for <linux-serial@archiver.kernel.org>; Mon,  3 Oct 2022 19:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJCTzS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Oct 2022 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJCTzM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Oct 2022 15:55:12 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3799FFB
        for <linux-serial@vger.kernel.org>; Mon,  3 Oct 2022 12:55:05 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0D4B03000034F;
        Mon,  3 Oct 2022 21:55:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E12D2517A8; Mon,  3 Oct 2022 21:54:59 +0200 (CEST)
Date:   Mon, 3 Oct 2022 21:54:59 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH] serial: 8250: 8250_omap: Support native RS485
Message-ID: <20221003195459.GA11858@wunner.de>
References: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de>
 <42986e92-d12e-bfde-2f5c-f580c113c3b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42986e92-d12e-bfde-2f5c-f580c113c3b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 28, 2022 at 02:38:40PM +0300, Ilpo Järvinen wrote:
> On Tue, 27 Sep 2022, Lukas Wunner wrote:
> > Recent TI Sitara SoCs such as AM64/AM65 have gained the ability to
> > automatically assert RTS when data is transmitted, obviating the need
> > to emulate this functionality in software.
> > 
> > The feature is controlled through new DIR_EN and DIR_POL bits in the
> > Mode Definition Register 3.  For details see page 8783 and 8890 of the
> > AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
[...]
> > @@ -1335,10 +1387,7 @@ static int omap8250_probe(struct platform_device *pdev)
> >  	up.port.shutdown = omap_8250_shutdown;
> >  	up.port.throttle = omap_8250_throttle;
> >  	up.port.unthrottle = omap_8250_unthrottle;
> > -	up.port.rs485_config = serial8250_em485_config;
> >  	up.port.rs485_supported = serial8250_em485_supported;
> > -	up.rs485_start_tx = serial8250_em485_start_tx;
> > -	up.rs485_stop_tx = serial8250_em485_stop_tx;
> >  	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
> >  
> >  	ret = of_alias_get_id(np, "serial");
> > @@ -1377,6 +1426,14 @@ static int omap8250_probe(struct platform_device *pdev)
> >  			 DEFAULT_CLK_SPEED);
> >  	}
> >  
> > +	if (priv->habit & UART_HAS_NATIVE_RS485) {
> > +		up.port.rs485_config = omap8250_rs485_config;
> > +	} else {
> > +		up.port.rs485_config = serial8250_em485_config;
> > +		up.rs485_start_tx = serial8250_em485_start_tx;
> > +		up.rs485_stop_tx = serial8250_em485_stop_tx;
> > +	}
> 
> I guess .rs485_supported shouldn't be equal in both cases?

I contemplated whether it should be different for hardware-assisted
RS485 but came to the conclusion that it shouldn't:

The polarity may be chosen both for hardware- and software-controlled RTS.

Whether RX_DURING_TX is possible depends on how the RS485 transceiver
is wired to the UART:  If RTS asserts !RE on the transceiver when sending,
the UART cannot receive data, regardless whether hardware- or software-
controlled RTS is used.

TERMINATE_BUS works independently from RTS control.

And ADDRB doesn't seem to be supported in either mode AFAICS.

Am I missing something?

Thanks,

Lukas
