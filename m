Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A8CC04A95
	for <linux-serial@archiver.kernel.org>; Wed, 28 Sep 2022 16:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiI1Qwk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 28 Sep 2022 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiI1Qwj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Sep 2022 12:52:39 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FF44D80A
        for <linux-serial@vger.kernel.org>; Wed, 28 Sep 2022 09:52:37 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id DD84284B9E;
        Wed, 28 Sep 2022 18:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1664383954;
        bh=+wZAhP5c8isv0WYfr9M+iyuIVUZGEGN0oXgGXovSlUI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TpD/jCKBErbbtJvtlvPPM+vUvSKnucxMTmyq0/k5Y0tdKJ5L6ArJ4XyX78lOMceIJ
         jmKg+uvp2kGIsvepSHGD9HaDgGJJIoog3gzAWgs43V3NAqKTnku2BigCjXhdl2Pa6S
         y5ZTfu5ZCRSOJbQD4C/BQITTd2L6u1rHoFqCib58RuBdkoxR8wQq/mqJhHAOz60c0K
         O7VgrsRjXk95zPCFiKnxFWM/wynSBBZoMo5AEpeio9/tsbsvjzY0e5UShB/GHIOh38
         B6Uwt5jrJp9KSmZyLcswMQelWcErJFimvb0m3ikm+FxJn1nlpis1d+gHbYzA1pKchv
         zUJjVguumXQyw==
Message-ID: <e579cdf0-33f3-d107-3f60-43b0f205861f@denx.de>
Date:   Wed, 28 Sep 2022 18:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] tty: serial: imx: Handle RS485 DE signal active high
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-serial@vger.kernel.org,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@dh-electronics.com, NXP Linux Team <linux-imx@nxp.com>,
        kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220928044037.605217-1-marex@denx.de>
 <20220928074338.4myghfoyxb2mmywo@pengutronix.de>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220928074338.4myghfoyxb2mmywo@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 9/28/22 09:43, Uwe Kleine-König wrote:
> On Wed, Sep 28, 2022 at 06:40:37AM +0200, Marek Vasut wrote:
>> The default polarity of RS485 DE signal is active high. This driver does
>> not handle such case properly. Currently, when a pin is multiplexed as a
>> UART CTS_B on boot, this pin is pulled HIGH by the i.MX UART CTS circuit,
>> which activates DE signal on the RS485 transceiver and thus behave as if
>> the RS485 was transmitting data, so the system blocks the RS485 bus when
>> it starts and until user application takes over. This behavior is not OK.
>> The problem consists of two separate parts.
>>
>> First, the i.MX UART IP requires UCR1 UARTEN and UCR2 RXEN to be set for
>> UCR2 CTSC and CTS bits to have any effect. The UCR2 CTSC bit permits the
>> driver to set CTS (RTS_B or RS485 DE signal) to either level sychronous
>> to the internal UART IP clock. Compared to other options, like GPIO CTS
>> control, this has the benefit of being synchronous to the UART IP clock
>> and thus without glitches or bus delays. The reason for the CTS design
>> is likely because when the Receiver is disabled, the UART IP can never
>> indicate that it is ready to receive data by assering CTS signal, so
>> the CTS is always pulled HIGH by default.
>>
>> When the port is closed by user space, imx_uart_stop_rx() clears UCR2
>> RXEN bit, and imx_uart_shutdown() clears UCR1 UARTEN bit. This disables
>> UART Receiver and UART itself, and forces CTS signal HIGH, which leads
>> to the RS485 bus being blocked because RS485 DE is incorrectly active.
>>
>> The proposed solution for this problem is to keep the Receiver running
>> even after the port is closed, but in loopback mode. This disconnects
>> the RX FIFO input from the RXD external signal, and since UCR2 TXEN is
>> cleared, the UART Transmitter is disabled, so nothing can feed data in
>> the RX FIFO. Because the Receiver is still enabled, the UCR2 CTSC and
>> CTS bits still have effect and the CTS (RS485 DE) control is retained.
>>
>> Note that in case of RS485 DE signal active low, there is no problem and
>> no special handling is necessary. The CTS signal defaults to HIGH, thus
>> the RS485 is by default set to Receive and the bus is not blocked.
>>
>> Note that while there is the possibility to control CTS using GPIO with
>> either CTS polarity, this has the downside of not being synchronous to
>> the UART IP clock and thus glitchy and susceptible to slow DE switching.
>>
>> Second, on boot, before the UART driver probe callback is called, the
>> driver core triggers pinctrl_init_done() and configures the IOMUXC to
>> default state. At this point, UCR1 UARTEN and UCR2 RXEN are both still
>> cleared, but UART CTS_B (RS485 DE) is configured as CTS function, thus
>> the RTS signal is pulled HIGH by the UART IP CTS circuit.
>>
>> One part of the solution here is to enable UCR1 UARTEN and UCR2 RXEN and
>> UTS loopback in this driver probe callback, thus unblocking the CTSC and
>> CTS control early on. But this is still too late, since the pin control
>> is already configured and CTS has been pulled HIGH for a short period
>> of time.
>>
>> When Linux kernel boots and this driver is bound, the pin control is set
>> to special "init" state if the state is available, and driver can switch
>> the "default" state afterward when ready. This state can be used to set
>> the CTS line as a GPIO in DT temporarily, and a GPIO hog can force such
>> GPIO to LOW, thus keeping the RS485 DE line LOW early on boot. Once the
>> driver takes over and UCR1 UARTEN and UCR2 RXEN and UTS loopback are all
>> enabled, the driver can switch to "default" pin control state and control
>> the CTS line as function instead. DT binding example is below:
>>
>> "
>> &gpio6 {
>>    rts-init-hog {
>>      gpio-hog;
>>      gpios = <5 0>;
>>      output-low;
>>      line-name = "rs485-de";
>>    };
>> };
>>
>> &uart5 { /* DHCOM UART2 */
>>    pinctrl-0 = <&pinctrl_uart5>;
>>    pinctrl-1 = <&pinctrl_uart5_init>;
>>    pinctrl-names = "default", "init";
>>    ...
>> };
>> pinctrl_uart5_init: uart5-init-grp {
>>    fsl,pins = <
>> ...
>>      MX6QDL_PAD_CSI0_DAT19__GPIO6_IO05       0x30b1
>>    >;
>> };
>>
>> pinctrl_uart5: uart5-grp {
>>    fsl,pins = <
>> ...
>>      MX6QDL_PAD_CSI0_DAT19__UART5_CTS_B      0x30b1
>>    >;
>> };
>> "
> 
> An alternative work around is to use the GPIO as RTS also in default,
> isn't it?

No, see paragraph 6 in the wall of text above. The CTSC/CTS is 
synchronous to the internal UART IP clock. The GPIO workaround has 
downsides due to switching lag which breaks various deployments. Here 
the GPIO is only used to keep the CTS line LOW on boot ; after the 
driver takes over, the driver controls the CTS line all the time.

>> @@ -489,7 +489,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
>>   static void imx_uart_stop_rx(struct uart_port *port)
>>   {
>>   	struct imx_port *sport = (struct imx_port *)port;
>> -	u32 ucr1, ucr2, ucr4;
>> +	u32 ucr1, ucr2, ucr4, uts;
>>   
>>   	ucr1 = imx_uart_readl(sport, UCR1);
>>   	ucr2 = imx_uart_readl(sport, UCR2);
>> @@ -505,7 +505,17 @@ static void imx_uart_stop_rx(struct uart_port *port)
>>   	imx_uart_writel(sport, ucr1, UCR1);
>>   	imx_uart_writel(sport, ucr4, UCR4);
>>   
>> -	ucr2 &= ~UCR2_RXEN;
>> +	if (port->rs485.flags & SER_RS485_ENABLED &&
>> +	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
>> +	    sport->have_rtscts && !sport->have_rtsgpio) {
> 
> IMHO this needs a comment. The later hunks might benefit from a comment
> two. I'd explain it once in more detail and refer to that description
> from the other relevant code sections.

Yes, I can add some abbreviated version of the commit message as a comment.
