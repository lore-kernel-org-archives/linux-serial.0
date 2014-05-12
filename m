From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 1/5] serial: imx: remove unneeded imx_transmit_buffer()
 from imx_start_tx()
Date: Mon, 12 May 2014 08:40:03 +0200
Message-ID: <53706CC3.4030907@de.bosch.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com> <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com> <537042B5.2040600@freescale.com> <53706014.8010203@de.bosch.com> <53706A9A.6060707@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:33660 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbaELGkO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 May 2014 02:40:14 -0400
In-Reply-To: <53706A9A.6060707@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: "dean_jenkins@mentor.com" <dean_jenkins@mentor.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>

On 12.05.2014 08:30, Huang Shijie wrote:
> =E4=BA=8E 2014=E5=B9=B405=E6=9C=8812=E6=97=A5 13:45, Dirk Behme =E5=86=
=99=E9=81=93:
>> On 12.05.2014 05:40, Huang Shijie wrote:
>>> =E4=BA=8E 2014=E5=B9=B405=E6=9C=8809=E6=97=A5 23:19, dean_jenkins@m=
entor.com =E5=86=99=E9=81=93:
>>>> Use imx_start_tx() just to enable the TX interrupt. It's the job o=
f the
>>>> TX interrupt ISR to fill the transmit buffer, then. If the transmi=
t
>>>> buffer
>   From the Documentation/serial/driver, we can see:
>     -----------------------------------------
>      start_tx(port)
>       Start transmitting characters.
>      -----------------------------------------
>
> It tells us we can transmit data in the imx_start_tx.

Well, it depends how you read 'Start transmitting', no?

It doesn't have to mean 'actually transmit data'. It talks about=20
'start'. And this could also mean 'start the transmission (by enabling=20
the interrupt)'.

> But this patch moves it to the interrupt handler,

It doesn't 'move' any code to the interrupt handler. The code in the=20
interrupt handler is already there.

> this patch makes the
> interrupt handler do more jobs.

=2E.. to get the locking in the correct order.

Best regards

Dirk

>>>> is empty, the TX interrupt should be executed as soon as the start=
_tx()
>>>> enables the interrupt, so there is no reason for the extra
>>>> imx_transmit_buffer() call, here. Remove it.
>>> I don't know why this patch needed?
>>> What problem this patch fix or improve?
>>
>> As stated in the commit message, the call of imx_transmit_buffer()
>> isn't needed there, so it can be removed. I.e. remove unneeded code.
>
>>
>> In the end, this cleans up the possible locking path, so that in the
>> third patch the locking issue can be easily fixed.
>>
> The lock issue had been fixed already. Please try the latest linux-ne=
xt.
> see my comment in the third patch.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
