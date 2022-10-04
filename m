Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E67C433FE
	for <linux-serial@archiver.kernel.org>; Tue,  4 Oct 2022 13:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiJDNqI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJDNqH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Oct 2022 09:46:07 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9B627FFC
        for <linux-serial@vger.kernel.org>; Tue,  4 Oct 2022 06:46:05 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 294DjfhD101902;
        Tue, 4 Oct 2022 08:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664891142;
        bh=qGEgLi8PAPicD/dFOB9lp0VwytmygF0zy1EMs1ZPHRU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jwXDUQ/EtdNRMA5WGZK9Tjk0ewxRtUaivjJnTZ1RUIF9ZzknmqaUpjtyviqhoMS0/
         VmHaDez0DDoMUxLEvJirt3Q/9bZbsCVyXKkdBHQJSVKmrNjP/cakGyfYkmZet7ZPQZ
         4gBGnyM2px3R5gmhiWpoLBK4xAS8WbL0qiHsCmQo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 294DjfVe067382
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Oct 2022 08:45:41 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 4 Oct
 2022 08:45:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 4 Oct 2022 08:45:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 294DjfGj022787;
        Tue, 4 Oct 2022 08:45:41 -0500
Date:   Tue, 4 Oct 2022 08:45:41 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] serial: 8250: 8250_omap: Support native RS485
Message-ID: <20221004134541.pnp6ts26p22rcwra@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
References: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de>
 <20221003151059.mypganj25awuxc2d@iaqt7>
 <20221003194224.GC12171@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221003194224.GC12171@wunner.de>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Mon, Oct 03, 2022 at 09:42:24PM +0200, Lukas Wunner wrote:
> On Mon, Oct 03, 2022 at 10:10:59AM -0500, Bin Liu wrote:
> > On Tue, Sep 27, 2022 at 02:10:01PM +0200, Lukas Wunner wrote:
> > > Recent TI Sitara SoCs such as AM64/AM65 have gained the ability to
> > > automatically assert RTS when data is transmitted, obviating the need
> > > to emulate this functionality in software.
> > > 
> > > The feature is controlled through new DIR_EN and DIR_POL bits in the
> > > Mode Definition Register 3.  For details see page 8783 and 8890 of the
> > > AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> [...]
> > > -	if (up->port.rs485.flags & SER_RS485_ENABLED)
> > > +	if (priv->habit & UART_HAS_NATIVE_RS485)
> > > +		serial_out(up, UART_OMAP_MDR3, priv->mdr3);
> > 
> > This makes the NATIVE_RS485 always used if the SoC supports it, but
> > 
> > > +	else if (up->port.rs485.flags & SER_RS485_ENABLED)
> > >  		serial8250_em485_stop_tx(up);
> > 
> > there are cases em485 should be used even if SoC supports NATIVE_RS485.
> > For example:
> > - the design has pinmux conflict and the RTS pin has to be used for
> >   something else. Then a GPIO pin would be used for RS485 DE control;
> > - the design requires customized delay_rts_before_send or
> >   delay_rts_after_send which NATIVE_RS485 doesn't support;
> > 
> > So we might need an option for such usecases. A device tree flag?
> 
> I expect those cases to be rare, hence do not see the need to

Maybe rare, but I know some projects use GPIO for DE control.

> address them right from the start.  Support for falling back

So I think missing it is a regression, because this patch forces to
use the RTS pin for DE control, this breaks the existing projects which
use GPIO for RTS/DE or have customized delay_rts_{before,after}_send.

-Bin.

> to software emulation can easily be added later.  Indeed a
> device tree property might be an appropriate way to trigger
> such a fallback.
> 
> Thanks,
> 
> Lukas
