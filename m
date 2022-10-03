Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B16DC433FE
	for <linux-serial@archiver.kernel.org>; Mon,  3 Oct 2022 19:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJCTme (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Oct 2022 15:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJCTmb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Oct 2022 15:42:31 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B5548E84
        for <linux-serial@vger.kernel.org>; Mon,  3 Oct 2022 12:42:27 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id ABBAD100D941D;
        Mon,  3 Oct 2022 21:42:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7A18159769; Mon,  3 Oct 2022 21:42:24 +0200 (CEST)
Date:   Mon, 3 Oct 2022 21:42:24 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] serial: 8250: 8250_omap: Support native RS485
Message-ID: <20221003194224.GC12171@wunner.de>
References: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de>
 <20221003151059.mypganj25awuxc2d@iaqt7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003151059.mypganj25awuxc2d@iaqt7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 03, 2022 at 10:10:59AM -0500, Bin Liu wrote:
> On Tue, Sep 27, 2022 at 02:10:01PM +0200, Lukas Wunner wrote:
> > Recent TI Sitara SoCs such as AM64/AM65 have gained the ability to
> > automatically assert RTS when data is transmitted, obviating the need
> > to emulate this functionality in software.
> > 
> > The feature is controlled through new DIR_EN and DIR_POL bits in the
> > Mode Definition Register 3.  For details see page 8783 and 8890 of the
> > AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
[...]
> > -	if (up->port.rs485.flags & SER_RS485_ENABLED)
> > +	if (priv->habit & UART_HAS_NATIVE_RS485)
> > +		serial_out(up, UART_OMAP_MDR3, priv->mdr3);
> 
> This makes the NATIVE_RS485 always used if the SoC supports it, but
> 
> > +	else if (up->port.rs485.flags & SER_RS485_ENABLED)
> >  		serial8250_em485_stop_tx(up);
> 
> there are cases em485 should be used even if SoC supports NATIVE_RS485.
> For example:
> - the design has pinmux conflict and the RTS pin has to be used for
>   something else. Then a GPIO pin would be used for RS485 DE control;
> - the design requires customized delay_rts_before_send or
>   delay_rts_after_send which NATIVE_RS485 doesn't support;
> 
> So we might need an option for such usecases. A device tree flag?

I expect those cases to be rare, hence do not see the need to
address them right from the start.  Support for falling back
to software emulation can easily be added later.  Indeed a
device tree property might be an appropriate way to trigger
such a fallback.

Thanks,

Lukas
