Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B006C54EE9
	for <linux-serial@archiver.kernel.org>; Sat, 17 Sep 2022 14:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiIQONU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Sep 2022 10:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIQONT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Sep 2022 10:13:19 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AED32BB1
        for <linux-serial@vger.kernel.org>; Sat, 17 Sep 2022 07:13:17 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D12D1280F59BF;
        Sat, 17 Sep 2022 16:13:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B62122A9C; Sat, 17 Sep 2022 16:13:15 +0200 (CEST)
Date:   Sat, 17 Sep 2022 16:13:15 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marex@denx.de>, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH] serial: stm32: Deassert Transmit Enable on
 ->rs485_config()
Message-ID: <20220917141315.GA1584@wunner.de>
References: <6059eab35dba394468335ef640df8b0050fd9dbd.1662886616.git.lukas@wunner.de>
 <774e5f24-c673-bbd2-08e-403987b63d1b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <774e5f24-c673-bbd2-08e-403987b63d1b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 13, 2022 at 11:24:01AM +0300, Ilpo Järvinen wrote:
> On Sun, 11 Sep 2022, Lukas Wunner wrote:
> > The STM32 USART can control RS-485 Transmit Enable in hardware.  Since
> > commit 7df5081cbf5e ("serial: stm32: Add RS485 RTS GPIO control"),
> > it can alternatively be controlled in software.  That was done to allow
> > RS-485 even if the RTS pin is unavailable because it's pinmuxed to a
> > different function.
> > 
> > However the commit neglected to deassert Transmit Enable upon invocation
> > of the ->rs485_config() callback.  Fix it.
> > 
> > Avoid forward declarations by moving stm32_usart_tx_empty(),
> > stm32_usart_rs485_rts_enable() and stm32_usart_rs485_rts_disable()
> > further up in the driver.
> > 
> > Fixes: 7df5081cbf5e ("serial: stm32: Add RS485 RTS GPIO control")
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: stable@vger.kernel.org # v5.9+
> > Cc: Marek Vasut <marex@denx.de>
> 
> I'd prefer to have those plain function moves to be in a separate patch.

Keeping that in a single patch eases backporting.
Let's see which way Greg prefers.


> Other than that,
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks a lot!

Lukas
