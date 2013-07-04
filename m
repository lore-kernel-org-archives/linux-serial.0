From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v2 4/5] ARM: dts: imx6q: add dte pinctrl for uart2
Date: Thu, 4 Jul 2013 17:06:37 +0800
Message-ID: <51D53B1D.6000404@freescale.com>
References: <1372844557-3078-1-git-send-email-b32955@freescale.com> <1372844557-3078-5-git-send-email-b32955@freescale.com> <20130704072344.GB11046@S2101-09.ap.freescale.net> <51D5357F.8040609@freescale.com> <20130704085623.GA11209@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:56080 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751895Ab3GDJCv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Jul 2013 05:02:51 -0400
In-Reply-To: <20130704085623.GA11209@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

=E4=BA=8E 2013=E5=B9=B407=E6=9C=8804=E6=97=A5 16:56, Shawn Guo =E5=86=99=
=E9=81=93:
> On Thu, Jul 04, 2013 at 04:42:39PM +0800, Huang Shijie wrote:
>> But this pinctrl is only used in imx6q-arm2 board which uses a big
>> armdillo board,
>> so i did not add the same label to imx6dl.
>>
>> Do we have a imx6dl-arm2 board? if we have , i can add it.
> It does not matter whether or not the pin group is used on an imx6dl
> board.  We have to add it for both SoCs, because it's the only way to
> keep use same label for same pin group on two SoCs.
>
>>>> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6=
q.dtsi
>>>> index 9a69891..8a518c6 100644
>>>> --- a/arch/arm/boot/dts/imx6q.dtsi
>>>> +++ b/arch/arm/boot/dts/imx6q.dtsi
>>>> @@ -266,6 +266,15 @@
>>>>   							MX6Q_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
>>>>   						>;
>>>>   					};
>>>> +
>>>> +					pinctrl_uart2_dte: uart2grp-2 {
> Forgot mentioning that in imx dts we generally do not encode function
> name like "dte" in the label but just number.
>
>>>> +						fsl,pins =3D<
>>>> +							MX6Q_PAD_EIM_D26__UART2_RX_DATA 0x1b0b1
>>>> +							MX6Q_PAD_EIM_D27__UART2_TX_DATA 0x1b0b1
>>>> +							MX6Q_PAD_EIM_D28__UART2_CTS_B	0x1b0b1
>>>> +							MX6Q_PAD_EIM_D29__UART2_CTS_B	0x1b0b1
>>> Why do you have two pads mux-ed on one function?
>> I think the name of the PAD is wrong.
> Fix the name first, then.
ok.

i will fix them in the next version.


thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
