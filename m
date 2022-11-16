Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE2C4332F
	for <linux-serial@archiver.kernel.org>; Wed, 16 Nov 2022 14:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiKPOsn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Nov 2022 09:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiKPOsm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Nov 2022 09:48:42 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F71A218
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 06:48:39 -0800 (PST)
Received: from [192.168.1.107] (82-131-200-171.pool.digikabel.hu [82.131.200.171])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hs@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C2DB784A14;
        Wed, 16 Nov 2022 15:48:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1668610117;
        bh=KWzY50RVH+2ZYGUjmf0Y7ybA/7x2fGxBya4vWUbTqlQ=;
        h=Subject:To:Cc:References:Reply-To:From:Date:In-Reply-To:From;
        b=GEkLLImLur4/2j6JbeOLH2BaEgv/H1axTazcAS23db7yr3MdFlXwzOgtEjlGT/wOv
         xqVwN7lVR/toBF8mLHO8h/SX6XqWDphsw3bPcqQuT/umFnM26eetSfv2tB0ccgkRUd
         LUCfGGoxX9Pfn5TULxv+zVB8/mpO1L4P3vY8hzONwkno5Nv2miaZMKSCrBj8rhUzFq
         OEm8tOahmmmwRfNUvItbbmsYBU/FYCtoVPDmRM76tGQskKs4+MfGT13Ja+f+8GOCNH
         imcLCsvGHVl3ND2UxoDjTEl/WkqOfvKp8XBFWeqI7QmL3Dv5Ni/xTSjIWBYcowwgcP
         4dToXdwNDRKwA==
Subject: Re: [PATCH v2] tty: serial: imx: Handle RS485 DE signal active high
To:     Marek Vasut <marex@denx.de>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        kernel@dh-electronics.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
References: <20220929144400.13571-1-marex@denx.de>
Reply-To: hs@denx.de
From:   Heiko Schocher <hs@denx.de>
Message-ID: <122dadc4-a1e2-a102-e0a9-fd3d4da45c48@denx.de>
Date:   Wed, 16 Nov 2022 15:48:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220929144400.13571-1-marex@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Marek,

On 29.09.22 16:44, Marek Vasut wrote:
> The default polarity of RS485 DE signal is active high. This driver does
> not handle such case properly. Currently, when a pin is multiplexed as a
> UART CTS_B on boot, this pin is pulled HIGH by the i.MX UART CTS circuit,
> which activates DE signal on the RS485 transceiver and thus behave as if
> the RS485 was transmitting data, so the system blocks the RS485 bus when
> it starts and until user application takes over. This behavior is not OK.
> The problem consists of two separate parts.
> 
> First, the i.MX UART IP requires UCR1 UARTEN and UCR2 RXEN to be set for
> UCR2 CTSC and CTS bits to have any effect. The UCR2 CTSC bit permits the
> driver to set CTS (RTS_B or RS485 DE signal) to either level sychronous
> to the internal UART IP clock. Compared to other options, like GPIO CTS
> control, this has the benefit of being synchronous to the UART IP clock
> and thus without glitches or bus delays. The reason for the CTS design
> is likely because when the Receiver is disabled, the UART IP can never
> indicate that it is ready to receive data by assering CTS signal, so
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
> Note that in case of RS485 DE signal active low, there is no problem and
> no special handling is necessary. The CTS signal defaults to HIGH, thus
> the RS485 is by default set to Receive and the bus is not blocked.
> 
> Note that while there is the possibility to control CTS using GPIO with
> either CTS polarity, this has the downside of not being synchronous to
> the UART IP clock and thus glitchy and susceptible to slow DE switching.
> 
> Second, on boot, before the UART driver probe callback is called, the
> driver core triggers pinctrl_init_done() and configures the IOMUXC to
> default state. At this point, UCR1 UARTEN and UCR2 RXEN are both still
> cleared, but UART CTS_B (RS485 DE) is configured as CTS function, thus
> the RTS signal is pulled HIGH by the UART IP CTS circuit.
> 
> One part of the solution here is to enable UCR1 UARTEN and UCR2 RXEN and
> UTS loopback in this driver probe callback, thus unblocking the CTSC and
> CTS control early on. But this is still too late, since the pin control
> is already configured and CTS has been pulled HIGH for a short period
> of time.
> 
> When Linux kernel boots and this driver is bound, the pin control is set
> to special "init" state if the state is available, and driver can switch
> the "default" state afterward when ready. This state can be used to set
> the CTS line as a GPIO in DT temporarily, and a GPIO hog can force such
> GPIO to LOW, thus keeping the RS485 DE line LOW early on boot. Once the
> driver takes over and UCR1 UARTEN and UCR2 RXEN and UTS loopback are all
> enabled, the driver can switch to "default" pin control state and control
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
> Reviewed-by: Fabio Estevam <festevam@denx.de>
> ---
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: kernel@dh-electronics.com
> Cc: kernel@pengutronix.de
> Cc: linux-arm-kernel@lists.infradead.org
> To: linux-serial@vger.kernel.org
> ---
> V2: - Add code comments per input from Uwe
>     - Add TB from Christoph
> ---
>  drivers/tty/serial/imx.c | 64 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 6 deletions(-)

Thank! Successfully tested on an imx8mp based board.

Tested-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
