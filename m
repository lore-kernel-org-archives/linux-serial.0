Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCB1C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 25 Feb 2022 09:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbiBYJXm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbiBYJXj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Feb 2022 04:23:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C321A8C93
        for <linux-serial@vger.kernel.org>; Fri, 25 Feb 2022 01:23:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A61B9CE23A2
        for <linux-serial@vger.kernel.org>; Fri, 25 Feb 2022 09:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60335C340E7;
        Fri, 25 Feb 2022 09:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645780984;
        bh=x1zusGPNLMiEduz9rlbYE8iYbAncmgn82wdncOIk7S0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQy2or4YAV24LP7CGNM4IrE5jfWTPQPmwk0Ymu2HfRQkkxAQGyMralRzfmbM3pyQG
         W0NKty/7X5zKcOD20E4dStdfEPceKEk3OjBuG0mvCjO2vhqR1GE6rdc/ocdlbl9OmQ
         L3xf2aeRAZWUCsL6X+yo458aKEuZuuktn0p7aUpo=
Date:   Fri, 25 Feb 2022 10:23:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>
Subject: Re: [RFC PATCH] serial: core: fix tcdrain() with CTS enabled
Message-ID: <Yhif9owSsOnbe526@kroah.com>
References: <20220203142337.1993024-1-tomasz.mon@camlingroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220203142337.1993024-1-tomasz.mon@camlingroup.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 03, 2022 at 03:23:37PM +0100, Tomasz Moń wrote:
> Do not set timeout to twice the approximate amount of time to send the
> entire FIFO if CTS is enabled. If the caller requested no timeout, e.g.
> when userspace program called tcdrain(), then wait without any timeout.
> 
> Premature return from tcdrain() was observed on imx based system which
> has 32 character long transmitter FIFO with hardware CTS handling.
> 
> Simple userspace application that reproduces problem has to:
>   * Open tty device, enable hardware flow control (CRTSCTS)
>   * Write data, e.g. 26 bytes
>   * Call tcdrain() to wait for the transmitter
>   * Close tty device
> 
> The other side of serial connection has to:
>   * Receive some data, e.g. 10 bytes
>   * Set RTS output (CTS input from sender perspective) inactive for
>     at least twice the port timeout
>   * Try to receive remaining data
> 
> Without this patch, userspace application will finish without any error
> while the other side of connection will never receive remaining data.
> 
> Signed-off-by: Tomasz Moń <tomasz.mon@camlingroup.com>
> ---
>  drivers/tty/serial/serial_core.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)

Note, I do not apply "RFC" patches as obviously the submitter does not
think they are good enough to be merged :)

thanks,

greg k-h
