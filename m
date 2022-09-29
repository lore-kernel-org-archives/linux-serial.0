Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C99C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 29 Sep 2022 16:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiI2QYe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Sep 2022 12:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiI2QYL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Sep 2022 12:24:11 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037E91EE74E
        for <linux-serial@vger.kernel.org>; Thu, 29 Sep 2022 09:21:43 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4B9FF84485;
        Thu, 29 Sep 2022 18:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1664468500;
        bh=am9/DLviXGj5Tz+rwUJPsf89iw0VVLpFwECeElqmyCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GScvb2nkIij+Qi3f7ubT5MN/unHGDth2hAiA/mOmQSqAdOzAUOach04iC1caWE/vN
         vCW0YS5YGhhBOMSm18RFLEQZ6MDIYzPLaEfEKooJnOd/5kj5NAK/H3CgKkm1QwyC/t
         ZXC03Y/TvYg20Ei7bzLNmiqJjt1DCkuUy1nXSpuPu2D5dDkwFdrTTx1+Jk2fDlyx6R
         BhUpsq4ID5qDWxKu+BU4Zmp6TmkxxZq495WEK9XoBVk3FUrFvXo3OcAopeI/RgZFM1
         UKhap9zo8dbHCvGZoIkEfdOAGRN4oEzfOG0+8wMlEOc6QLg02ycx2TU2wLBpBQcj3H
         qGxy0XHwTVH6g==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Sep 2022 13:21:40 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-serial@vger.kernel.org,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?U?= =?UTF-8?Q?we_Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, kernel@dh-electronics.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] tty: serial: imx: Handle RS485 DE signal active high
In-Reply-To: <20220929144400.13571-1-marex@denx.de>
References: <20220929144400.13571-1-marex@denx.de>
Message-ID: <cb1a237f6c8067023ce351f09ebb454c@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Marek,

Thanks for the detailed commit log.

Only some nits below:

On 29/09/2022 11:44, Marek Vasut wrote:
> The default polarity of RS485 DE signal is active high. This driver 
> does
> not handle such case properly. Currently, when a pin is multiplexed as 
> a
> UART CTS_B on boot, this pin is pulled HIGH by the i.MX UART CTS 
> circuit,
> which activates DE signal on the RS485 transceiver and thus behave as 
> if

s/behave/behaves

> the RS485 was transmitting data, so the system blocks the RS485 bus 
> when
> it starts and until user application takes over. This behavior is not 
> OK.
> The problem consists of two separate parts.
> 
> First, the i.MX UART IP requires UCR1 UARTEN and UCR2 RXEN to be set 
> for
> UCR2 CTSC and CTS bits to have any effect. The UCR2 CTSC bit permits 
> the
> driver to set CTS (RTS_B or RS485 DE signal) to either level sychronous
> to the internal UART IP clock. Compared to other options, like GPIO CTS
> control, this has the benefit of being synchronous to the UART IP clock
> and thus without glitches or bus delays. The reason for the CTS design
> is likely because when the Receiver is disabled, the UART IP can never
> indicate that it is ready to receive data by assering CTS signal, so

s/assering/asserting

> the CTS is always pulled HIGH by default.
> 
> When the port is closed by user space, imx_uart_stop_rx() clears UCR2
> RXEN bit, and imx_uart_shutdown() clears UCR1 UARTEN bit. This disables
> UART Receiver and UART itself, and forces CTS signal HIGH, which leads
> to the RS485 bus being blocked because RS485 DE is incorrectly active.
> 
> The proposed solution for this problem is to keep the Receiver running
> even after the port is closed, but in loopback mode. This disconnects
> the RX FIFO input from the RXD external signal, and since UCR2 TXEN is
> cleared, the UART Transmitter is disabled, so nothing can feed data in
> the RX FIFO. Because the Receiver is still enabled, the UCR2 CTSC and
> CTS bits still have effect and the CTS (RS485 DE) control is retained.
> 
> Note that in case of RS485 DE signal active low, there is no problem 
> and
> no special handling is necessary. The CTS signal defaults to HIGH, thus
> the RS485 is by default set to Receive and the bus is not blocked.
> 
> Note that while there is the possibility to control CTS using GPIO with
> either CTS polarity, this has the downside of not being synchronous to
> the UART IP clock and thus glitchy and susceptible to slow DE 
> switching.
> 
> Second, on boot, before the UART driver probe callback is called, the
> driver core triggers pinctrl_init_done() and configures the IOMUXC to
> default state. At this point, UCR1 UARTEN and UCR2 RXEN are both still
> cleared, but UART CTS_B (RS485 DE) is configured as CTS function, thus
> the RTS signal is pulled HIGH by the UART IP CTS circuit.
> 
> One part of the solution here is to enable UCR1 UARTEN and UCR2 RXEN 
> and
> UTS loopback in this driver probe callback, thus unblocking the CTSC 
> and
> CTS control early on. But this is still too late, since the pin control
> is already configured and CTS has been pulled HIGH for a short period
> of time.
> 
> When Linux kernel boots and this driver is bound, the pin control is 
> set
> to special "init" state if the state is available, and driver can 
> switch
> the "default" state afterward when ready. This state can be used to set
> the CTS line as a GPIO in DT temporarily, and a GPIO hog can force such
> GPIO to LOW, thus keeping the RS485 DE line LOW early on boot. Once the
> driver takes over and UCR1 UARTEN and UCR2 RXEN and UTS loopback are 
> all
> enabled, the driver can switch to "default" pin control state and 
> control
> the CTS line as function instead. DT binding example is below:
> 
> "
> &gpio6 {
>   rts-init-hog {
>     gpio-hog;
>     gpios = <5 0>;
>     output-low;
>     line-name = "rs485-de";
>   };
> };
> 
> &uart5 { /* DHCOM UART2 */
>   pinctrl-0 = <&pinctrl_uart5>;
>   pinctrl-1 = <&pinctrl_uart5_init>;
>   pinctrl-names = "default", "init";
>   ...
> };
> pinctrl_uart5_init: uart5-init-grp {
>   fsl,pins = <
> ...
>     MX6QDL_PAD_CSI0_DAT19__GPIO6_IO05       0x30b1
>   >;
> };
> 
> pinctrl_uart5: uart5-grp {
>   fsl,pins = <
> ...
>     MX6QDL_PAD_CSI0_DAT19__UART5_CTS_B      0x30b1
>   >;
> };
> "
> 
> Tested-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@denx.de>
