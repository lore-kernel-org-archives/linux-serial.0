Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB84FC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 27 Dec 2021 13:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhL0NRj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Dec 2021 08:17:39 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:56075 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhL0NRi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Dec 2021 08:17:38 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id E1CFB280067AF;
        Mon, 27 Dec 2021 14:17:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D11AE2F5D1A; Mon, 27 Dec 2021 14:17:34 +0100 (CET)
Date:   Mon, 27 Dec 2021 14:17:34 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Su Bao Cheng <baocheng.su@siemens.com>, baocheng_su@163.com,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        rafael.gago@gmail.com, rafael_gago_81@hotmail.com,
        rafael.gago@zenuity.com, rafael.gago@zenseact.com
Subject: Re: [PATCH] serial: Fix incorrect rs485 polarity on uart open
Message-ID: <20211227131734.GA32042@wunner.de>
References: <9395767847833f2f3193c49cde38501eeb3b5669.1639821059.git.lukas@wunner.de>
 <8a10bea0-fb8a-c25a-6828-ab907b336d0b@kernel.org>
 <510a7dcc-9025-d669-bea7-e772da3874a5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <510a7dcc-9025-d669-bea7-e772da3874a5@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 20, 2021 at 07:30:52AM +0100, Jiri Slaby wrote:
> On 20. 12. 21, 7:28, Jiri Slaby wrote:
> > On 18. 12. 21, 10:58, Lukas Wunner wrote:
> > > Commit a6845e1e1b78 ("serial: core: Consider rs485 settings to drive
> > > RTS") sought to deassert RTS when opening an rs485-enabled uart port.
> > > That way, the transceiver does not occupy the bus until it transmits
> > > data.
> > > 
> > > Unfortunately, the commit mixed up the logic and *asserted* RTS instead
> > > of *deasserting* it:
> > > 
> > > The commit amended uart_port_dtr_rts(), which raises DTR and RTS when
> > > opening an rs232 port. "Raising" actually means lowering the signal
> > > that's coming out of the uart, because an rs232 transceiver not only
> > > changes a signal's voltage level, it also *inverts* the signal. See
> > > the simplified schematic in the MAX232 datasheet for an example:
> > > https://www.ti.com/lit/ds/symlink/max232.pdf
> > > 
> > > So, to raise RTS on an rs232 port, TIOCM_RTS is *set* in port->mctrl
> > > and that results in the signal being driven low.
> > > 
> > > In contrast to rs232, the signal level for rs485 Transmit Enable is the
> > > identity, not the inversion: If the transceiver expects a "high" RTS
> > > signal for Transmit Enable, the signal coming out of the uart must also
> > > be high, so TIOCM_RTS must be *cleared* in port->mctrl.
> > > 
> > > The commit did the exact opposite, but it's easy to see why given the
> > > confusing semantics of rs232 and rs485. Fix it.
> > > 
> > > Fixes: a6845e1e1b78 ("serial: core: Consider rs485 settings to drive
> > > RTS")
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > Cc: stable@vger.kernel.org # v4.14+
> > > Cc: Rafael Gago Castano <rgc@hms.se>
> > 
> > Rafael, can you ack/test this, please?
> 
> Definitely on that e-mail:
>  550 5.4.1 Recipient address rejected: Access denied. AS(201806281)
> [DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com]
> 
> Trying rafael.gago@gmail.com from the Author field.

A bit of GitHub sleuthing turned up the following alternative addresses:

rafael_gago_81@hotmail.com
rafael.gago@zenuity.com
rafael.gago@zenseact.com

Unfortunately none of them is responsive.  I was hoping that the Siemens
folks might be willing to attest correctness of the patch.

Thanks,

Lukas
