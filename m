Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F295C433FE
	for <linux-serial@archiver.kernel.org>; Thu,  6 Oct 2022 06:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJFGVb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Oct 2022 02:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJFGVa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Oct 2022 02:21:30 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A5E89AE5
        for <linux-serial@vger.kernel.org>; Wed,  5 Oct 2022 23:21:28 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id F1B4A30002227;
        Thu,  6 Oct 2022 08:21:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E721A2F5E4; Thu,  6 Oct 2022 08:21:26 +0200 (CEST)
Date:   Thu, 6 Oct 2022 08:21:26 +0200
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
Message-ID: <20221006062126.GA26272@wunner.de>
References: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de>
 <42986e92-d12e-bfde-2f5c-f580c113c3b@linux.intel.com>
 <20221003195459.GA11858@wunner.de>
 <89a1308-d325-ba17-7e8c-5a7f4a38f58d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89a1308-d325-ba17-7e8c-5a7f4a38f58d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 04, 2022 at 12:06:21PM +0300, Ilpo Järvinen wrote:
> On Mon, 3 Oct 2022, Lukas Wunner wrote:
> > On Wed, Sep 28, 2022 at 02:38:40PM +0300, Ilpo Järvinen wrote:
> > > On Tue, 27 Sep 2022, Lukas Wunner wrote:
> > > > @@ -1377,6 +1426,14 @@ static int omap8250_probe(struct platform_device *pdev)
> > > >  			 DEFAULT_CLK_SPEED);
> > > >  	}
> > > >  
> > > > +	if (priv->habit & UART_HAS_NATIVE_RS485) {
> > > > +		up.port.rs485_config = omap8250_rs485_config;
> > > > +	} else {
> > > > +		up.port.rs485_config = serial8250_em485_config;
> > > > +		up.rs485_start_tx = serial8250_em485_start_tx;
> > > > +		up.rs485_stop_tx = serial8250_em485_stop_tx;
> > > > +	}
> > > 
> > > I guess .rs485_supported shouldn't be equal in both cases?
> > 
> > I contemplated whether it should be different for hardware-assisted
> > RS485 but came to the conclusion that it shouldn't:
[...]
> Core is not handling just flags but also delay_rts_before_send and 
> delay_rts_after_send sanitization. See 
> uart_sanitize_serial_rs485_delays().
> 
> Btw, you can also get rid of this line once you provide separate 
> rs485_supported:
> 	rs485->delay_rts_before_send = 0;
> 
> What to do with delay_rts_after_send seems bit trickier though. Looking 
> the code, it cannot be configured to arbitrary values by the user but it 
> might not be zero either after the driver touches it. Maybe it safer to 
> have it supported (set to 1) to avoid spuriously triggering the warning in 
> uart_sanitize_serial_rs485_delays() (e.g., during init if non-zero delay 
> is provided).

If I understand Figure 12-276 on page 8783 of the AM65 TRM correctly,
there appears to be a 1 bit clock delay between writing to the THR register
and transmission of the start bit:

  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

I intend to respin the patch with the following addition:

  fixed_delay_rts_before_send = 1 * MSEC_PER_SEC / baud;

As a result, both delay_rts_before_send and delay_rts_after_send should be
set to 1 in the rs485_supported struct for hardware-controlled RTS.

The resulting struct is identical to serial8250_em485_supported.

Thanks,

Lukas
