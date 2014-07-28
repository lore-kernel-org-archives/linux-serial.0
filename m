From: Bill Pringlemeir <bpringlemeir@nbsps.com>
Subject: Re: fsl_lpuart/VF610: Division by zero.
Date: Mon, 28 Jul 2014 18:38:39 -0400
Message-ID: <87zjftaz2o.fsf@nbsps.com>
References: <87ha256q8l.fsf@nbsps.com> <87d2ct6p77.fsf@nbsps.com>
	<1aa4c71fa7441f217f33e7be9a8fa1b9@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 71-19-161-253.dedicated.allstream.net ([71.19.161.253]:51715
	"EHLO nsa.nbspaymentsolutions.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751425AbaG1WvB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Jul 2014 18:51:01 -0400
In-Reply-To: <1aa4c71fa7441f217f33e7be9a8fa1b9@agner.ch> (Stefan Agner's
	message of "Sat, 26 Jul 2014 14:08:38 +0200")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Yuan Yao <yao.yuan@freescale.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org

On 26 Jul 2014, stefan@agner.ch wrote:

> Hi Bill,
>
> Am 2014-07-26 00:36, schrieb Bill Pringlemeir:
>> On 25 Jul 2014, bpringlemeir@nbsps.com wrote:
>
>>> I looked at the vmlinux objdump and it is here,
>>>
>>> static int lpuart_dma_rx_request(struct uart_port *port)
>>> {
>>> ...
>>> 	sport->dma_rx_timeout = (sport->port.timeout - HZ / 50) *
>>> 				FSL_UART_RX_DMA_BUFFER_SIZE * 3 /
>>> 				sport->rxfifo_size / 2;
>>>
>>> The variable 'sport->rxfifo_size' is set in lpuart_setup_watermark()
>>> and this is called after lpuart_dma_rx_request() in
>>> lpuart_startup().

> I observed this division by zero too, I recently sent a patch for
> that.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/268772.html

> Greg already added that to his tty-next tree:
> https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/tree/drivers/tty/serial/fsl_lpuart.c?h=tty-next#n1309

> I also observed that DMA did not work yet, hence I a created a second
> patch:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/268773.html
>
> But eDMA in general was broken too, this patch solved that, hence you
> might want apply that patch too:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/268199.html
>
> All patches are lined up for 3.17, so things should be smooth from
> that release on.

Thanks, I applied all three patches to the arm-soc 'for-next' and now
the serial ports seems to be working.  I am using the Tower board and
they have a 'TWR-SER2' card.

http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=TWR-SER2

Unfortunately, the IOMUX conflicts with the Audio daughter-board in
vf610-twr.dts.   The I/O conflicts are,

	VF610_PAD_PTB6__FTM0_CH6
	VF610_PAD_PTB7__FTM0_CH7
versus
        VF610_PAD_PTB6__UART2_TX
        VF610_PAD_PTB7__UART2_RX

Below are the DT changes to get two 'ttyLP' working with the Tower
System which probably will never apply cleanly, but are just meant for
reference.

--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -58,7 +59,7 @@
                        regulator-max-microvolt = <3300000>;
                };
        };
-
+/*
        sound {
                compatible = "simple-audio-card";
                simple-audio-card,format = "i2s";
@@ -87,6 +88,7 @@
                        bitclock-master;
                };
        };
+*/
 };
 
 &adc0 {
@@ -241,7 +243,7 @@
                };
-
+/*
                pinctrl_pwm0: pwm0grp {
                        fsl,pins = <
                                VF610_PAD_PTB0__FTM0_CH0                0x1582
@@ -252,7 +254,7 @@
                                VF610_PAD_PTB7__FTM0_CH7                0x1582
                        >;
                };
-
+*/
                pinctrl_sai2: sai2grp {
                        fsl,pins = <
                                VF610_PAD_PTA16__SAI2_TX_BCLK           0x02ed
@@ -271,6 +273,13 @@
                                VF610_PAD_PTB5__UART1_RX                0x21a1
                        >;
                };
+
+               pinctrl_uart2: uart2grp {
+                       fsl,pins = <
+                                VF610_PAD_PTB6__UART2_TX                0x21a2
+                                VF610_PAD_PTB7__UART2_RX                0x21a1
+                       >;
+               };
        };
 };
 
@@ -284,21 +293,31 @@
        status = "okay";
 };
 
+/*
 &pwm0 {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_pwm0>;
        status = "okay";
 };
-
 &sai2 {
        #sound-dai-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_sai2>;
        status = "okay";
 };
-
+*/
+&uart2 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_uart2>;
+       status = "okay";
+};

The standard jumpers on the Tower will either route ttyLP1 to the 'USB'
or to the 'serial board'; ttyLP2 will be the opposite with the 'serial
board' or the 'USB'.

Thanks again.  I should have read the linux-arm list more diligently.

Bill Pringlemeir.
