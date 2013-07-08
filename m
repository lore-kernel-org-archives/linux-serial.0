From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v3 4/6] ARM: dts: imx6q{dl}: fix the wrong RTS/CTS pad
 name
Date: Mon, 8 Jul 2013 16:54:08 +0800
Message-ID: <51DA7E30.3040009@freescale.com>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com>	<1373004752-21302-5-git-send-email-b32955@freescale.com>	<20130706050803.GC30164@S2101-09.ap.freescale.net>	<20953.22066.706534.773272@ipc1.ka-ro>	<51DA5CA7.1050305@freescale.com> <20954
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:45936 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751728Ab3GHIuP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Jul 2013 04:50:15 -0400
In-Reply-To: <20954.27392.875173.755391@ipc1.ka-ro>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Frank LI <B20596@freescale.com>

=E4=BA=8E 2013=E5=B9=B407=E6=9C=8808=E6=97=A5 15:32, Lothar Wa=C3=9Fman=
n =E5=86=99=E9=81=93:
> Hi,
>
> Huang Shijie writes:
>> =E4=BA=8E 2013=E5=B9=B407=E6=9C=8807=E6=97=A5 19:51, Lothar Wa=C3=9F=
mann =E5=86=99=E9=81=93:
>>> Hi,
>>>
>>> Shawn Guo writes:
>>>> On Fri, Jul 05, 2013 at 02:12:30PM +0800, Huang Shijie wrote:
>>>>> There is something wrong with the RTS/CTS pads:
>>>>>     The RTS pad is assigned with the CTS's value;
>>>>>     while the CTS pad is assigned with the RTS's value.
>>>>>
>>>> So basically, you are saying that select_input should be set up fo=
r CTS
>>>> rather than RTS.  It seems that the people who generated the macro=
 got
>>>> the wrong input from developer.
>>>>
>>> programming 'select_input' only makes sense for inputs, not outputs=
=2E
>>> Since CTS is an output signal, select_input only makes sense for th=
e
>>> RTS function of the pads.
>> Hi Lothar:
>>
>> In our imx6 Soc, the CTS is used as a input signal, not as a output =
signal.
>>
>> I checked two boards, one is imx6q ARM2 armidillo board, one is
>> imx6-sabreauto board,
>> both the boards use the CTS as a input signal.
>>
> that's the problem with the DTE/DCE mode. Depending on the DCEDTE bit
> in the UARTx_UFCR we would need different pad configurations for
> RTS/CTS because in DCE mode CTS is an output and in DTE mode it's an

yes. thanks for explanation.


> input.
> Thus the correct pad config value would need the input_sel on the CTS
> pad definition for DTE mode and on the RTS pad definition for DCE
Since the default pad is used for DCE mode, what we need to do is
add two extra pads for the DTE mode.

thanks
Huang Shijie
> mode. Maybe something like:
> #define MX6Q_PAD_EIM_D19__UART1_DCE_CTS_B             0x09c 0x3b0 0x0=
00 0x4 0x0
> #define MX6Q_PAD_EIM_D19__UART1_DCE_RTS_B             0x09c 0x3b0 0x9=
1c 0x4 0x0
> #define MX6Q_PAD_EIM_D19__UART1_DTE_CTS_B             0x09c 0x3b0 0x9=
1c 0x4 0x0
> #define MX6Q_PAD_EIM_D19__UART1_DTE_RTS_B             0x09c 0x3b0 0x0=
00 0x4 0x0
>
>
> Lothar Wa=C3=9Fmann


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
