Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A552EC6FA8B
	for <linux-serial@archiver.kernel.org>; Tue, 20 Sep 2022 12:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiITMKk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Sep 2022 08:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiITMKi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Sep 2022 08:10:38 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A527CFD
        for <linux-serial@vger.kernel.org>; Tue, 20 Sep 2022 05:10:35 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9295F100DE9D0;
        Tue, 20 Sep 2022 14:10:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6CE8B1B54E; Tue, 20 Sep 2022 14:10:33 +0200 (CEST)
Date:   Tue, 20 Sep 2022 14:10:33 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        heiko@sntech.de, giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v4 04/13] serial: 8250_dwlib: RS485 HW half & full duplex
 support
Message-ID: <20220920121033.GA12065@wunner.de>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
 <20220425143410.12703-5-ilpo.jarvinen@linux.intel.com>
 <20220920113704.GA12014@wunner.de>
 <64fb5487-76c6-f6ed-d110-c98bde2f7917@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64fb5487-76c6-f6ed-d110-c98bde2f7917@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 20, 2022 at 03:01:52PM +0300, Ilpo Järvinen wrote:
> I don't think you can just move from one to another like that because DE 
> and RTS are not the same signal on these UARTs. So it's not going to be 
> compatible w/o additional effort anyway.
> 
> Initially, I tried to add a flag for selecting between the HW one and 
> emulation but got overruled (you were among the opposing people ;-)).
> ...IIRC, I tried to explain back then that those signals are not the
> same with this HW.

Right, I remember that discussion. :)

I guess we can always retrofit that selection option if anyone needs it.
Generally if hardware RS485 support is available, one doesn't want to
use software emulation.

stm32-usart.c originally only had hardware-driven Driver Enable and
software emulation was added afterwards because the RTS pin is
sometimes pinmuxed to some other function.  But such use cases are
probably rare.

Thanks,

Lukas
