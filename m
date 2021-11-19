Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEECDC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 11:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C3D60F9B
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 11:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhKSLPM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 06:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhKSLPM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 06:15:12 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85896C061574
        for <linux-serial@vger.kernel.org>; Fri, 19 Nov 2021 03:12:10 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 32063103B1FD5;
        Fri, 19 Nov 2021 12:12:08 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0F87F30A457; Fri, 19 Nov 2021 12:12:08 +0100 (CET)
Date:   Fri, 19 Nov 2021 12:12:08 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Su Bao Cheng <baocheng_su@163.com>
Cc:     Su Bao Cheng <baocheng.su@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jan.kiszka@siemens.com, chao.zeng@siemens.com
Subject: Re: [PATCH] Revert "serial: 8250: Don't touch RTS modem control
 while in rs485 mode"
Message-ID: <20211119111208.GA9692@wunner.de>
References: <20211027111644.1996921-1-baocheng.su@siemens.com>
 <20211027113938.GA9373@wunner.de>
 <e1a9b9bf-45a4-6e71-09f4-1ae730284778@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1a9b9bf-45a4-6e71-09f4-1ae730284778@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 12, 2021 at 02:14:11PM +0800, Su Bao Cheng wrote:
> The issue is observed on omap8250 hardware (CPU: AM6548). the use case
> is RS485 half-duplex (2 wire mode), in this mode the RTS pin is used to
> control the direction and is software controller via the MCR[1]
> register. The problem is that the RS485 transmitting is OK, but the
> receiving is not working.

That means the RTS pin is always asserted and never deasserted.
I don't see how that could be related to the patch in question.
It's rather an indication that RS-485 is not enabled on the port.


> The MCR is set to 0 at this line within uart_port_startup():
> 	retval = uport->ops->startup(uport);
> 
> On omap8250, the startup() points to omap_8250_startup(), within it:
> 	up->mcr = 0;
> 
> For software controlled RTS pin of RS485 half-duplex, when not in the
> transmitting, the MCR[1] should be constant to indicate the current
> direction is receiving. This is set in serial8250_em485_stop_tx().
> 
> So after this point of setting the MCR to 0, this up->mcr register
> mirror does not reflect the actual desired value anymore. Further
> checking against it leads to false result.

And?  up->mcr is not used by the patch.  It retrieves the
current value of the RTS bit from the MCR register instead
of using the cached value in up->mcr.  And all it seeks to
achieve is *preserve* the current value of the RTS bit.
So I don't see why the cached value up->mcr is relevant here.

Thanks,

Lukas
