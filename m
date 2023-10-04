Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69736E7B5FB
	for <linux-serial@archiver.kernel.org>; Wed,  4 Oct 2023 12:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242295AbjJDMNJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Oct 2023 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjJDMNI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Oct 2023 08:13:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5694AA9;
        Wed,  4 Oct 2023 05:13:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BF9C433C7;
        Wed,  4 Oct 2023 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696421585;
        bh=Kk4cv0xkH9oZilc86UHlE6Zvb/RSMcav/ebFcJBFk0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tr1fAs69JCHQL+EO6CQj06Lxavr7lTS0rTnd5CrdNMxnstw/2jnUO8E4o2urG0052
         YO/OUciFJ1Hz6GRoJ+3P3uK2nWjKI13mGUoVC03DxYT/wON7ik+yBSUy4FJm3UZn11
         ALolc2AWyGyrJSF8RZoTQfG8LcN6MEH8NLTPCBJk=
Date:   Wed, 4 Oct 2023 14:13:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Geurts <paul_geurts@live.nl>
Cc:     jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: imx: fix tx statemachine deadlock
Message-ID: <2023100450-charger-disregard-9683@gregkh>
References: <AM0PR09MB26750E782F81CD447058FE7D95CBA@AM0PR09MB2675.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR09MB26750E782F81CD447058FE7D95CBA@AM0PR09MB2675.eurprd09.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 04, 2023 at 11:57:22AM +0200, Paul Geurts wrote:
> When using the serial port as RS485 port, the tx statemachine is used to
> control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
> TTY port is closed in the middle of a transmission (for instance during
> userland application crash), imx_uart_shutdown disables the interface
> and disables the Transmission Complete interrupt. afer that,
> imx_uart_stop_tx bails on an incomplete transmission, to be retriggered
> by the TC interrupt. This interrupt is disabled and therefore the tx
> statemachine never transitions out of SEND. The statemachine is in
> deadlock now, and the TX_EN remains low, making the interface useless.
> 
> imx_uart_stop_tx now checks for incomplete transmission AND whether TC
> interrupts are enabled before bailing to be retriggered. This makes sure
> the state machine handling is reached, and is properly set to
> WAIT_AFTER_SEND.
> 
> Signed-off-by: Paul Geurts <paul_geurts@live.nl>
> ---
>  drivers/tty/serial/imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What commit id does this fix?

thanks,

greg k-h
