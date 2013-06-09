From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH] serial: imx: enable the clocks for console
Date: Sun, 9 Jun 2013 10:17:51 +0800
Message-ID: <51B3E5CF.4010202@freescale.com>
References: <20130608062307.GB22416@S2101-09.ap.freescale.net>	<1370678667-3514-1-git-send-email-b32955@freescale.com> <CAOMZO5A4SPFv1NopdGrN9nX-XSpZy5Cw1CLp3E95mRP8O=rhLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:39115
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751281Ab3FICOs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Jun 2013 22:14:48 -0400
In-Reply-To: <CAOMZO5A4SPFv1NopdGrN9nX-XSpZy5Cw1CLp3E95mRP8O=rhLQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

=E4=BA=8E 2013=E5=B9=B406=E6=9C=8808=E6=97=A5 21:11, Fabio Estevam =E5=86=
=99=E9=81=93:
> Hi Huang,
>
> On Sat, Jun 8, 2013 at 5:04 AM, Huang Shijie<b32955@freescale.com>  w=
rote:
>
>> +       if (!uart_console(port)) {
>> +               retval =3D clk_prepare_enable(sport->clk_per);
>> +               if (retval)
>> +                       goto error_out1;
>> +               retval =3D clk_prepare_enable(sport->clk_ipg);
>> +               if (retval)
>> +                       goto error_out1;
> Here you should not jump to "error_out1".
>
> You should jump to a different label and disable the sport->clk_per c=
lock.
yes. you are right.
I will fix it in the patch "serial: imx: enable the clocks for console"

thanks
Huang Shijie
> This was also wrong in your previous patch.
>


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
