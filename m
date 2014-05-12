From: Dean Jenkins <Dean_Jenkins@mentor.com>
Subject: Re: [PATCH 1/5] serial: imx: remove unneeded imx_transmit_buffer()
 from imx_start_tx()
Date: Mon, 12 May 2014 09:03:21 +0100
Message-ID: <53708049.8060108@mentor.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com> <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com> <537042B5.2040600@freescale.com> <53706014.8010203@de.bosch.com> <53706A9A.6060707@freescale.com> <53706CC3.4030907@de.bosch.com> <53706FD8.6090201@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:50845 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbaELID0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 May 2014 04:03:26 -0400
In-Reply-To: <53706FD8.6090201@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>, Dirk Behme <dirk.behme@de.bosch.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>

On 12/05/14 07:53, Huang Shijie wrote:
> =E4=BA=8E 2014=E5=B9=B405=E6=9C=8812=E6=97=A5 14:40, Dirk Behme =E5=86=
=99=E9=81=93:
>> On 12.05.2014 08:30, Huang Shijie wrote:
>>> =E4=BA=8E 2014=E5=B9=B405=E6=9C=8812=E6=97=A5 13:45, Dirk Behme =E5=
=86=99=E9=81=93:
>>>> On 12.05.2014 05:40, Huang Shijie wrote:
>>>>> =E4=BA=8E 2014=E5=B9=B405=E6=9C=8809=E6=97=A5 23:19, dean_jenkins=
@mentor.com =E5=86=99=E9=81=93:
>>>>>> Use imx_start_tx() just to enable the TX interrupt. It's the job=
=20
>>>>>> of the
>>>>>> TX interrupt ISR to fill the transmit buffer, then. If the trans=
mit
>>>>>> buffer
>>>   From the Documentation/serial/driver, we can see:
>>>     -----------------------------------------
>>>      start_tx(port)
>>>       Start transmitting characters.
>>>      -----------------------------------------
>>>
>>> It tells us we can transmit data in the imx_start_tx.
>>
>> Well, it depends how you read 'Start transmitting', no?
>>
>> It doesn't have to mean 'actually transmit data'. It talks about=20
>> 'start'. And this could also mean 'start the transmission (by=20
>> enabling the interrupt)'.
>>
> Ok :)
> I do not object this patch.
>
> My opinion is : If the third patch is redundant, could this patch=20
> still needed?
>
>
>>> But this patch moves it to the interrupt handler,
>>
>> It doesn't 'move' any code to the interrupt handler. The code in the=
=20
>> interrupt handler is already there.
>>
> i knew it.
>
>>> this patch makes the
>>> interrupt handler do more jobs.
>>
>> ... to get the locking in the correct order.
>>
> again, the third patch can be ignored.
> The locking is correct for the imx.c.
>
Well, the locking might now be OK but due to an existing issue the TX=20
will be woken up excessively with no new characters to transmit so ther=
e=20
will be excessive context switching with the new work queue that result=
s=20
in no useful work done. There is an API issue in HCI LDISC because=20
TTY_DO_WRITE_WAKEUP is set BEFORE checking whether any characters remai=
n=20
pending to be sent. This means most of the time hci_uart_tx_wakeup() is=
=20
unnecessarily called will no chance of seeing any remain pending=20
characters to be process. This weakness contributed to triggering locku=
p=20
issue.

In my opinion, TTY_DO_WRITE_WAKEUP should only be set when the UART=20
character circular holding buffer becomes full which for BCSP traffic i=
s=20
unlikely I think (4kB buffer versus traffic < 1kB BCSP frames in=20
length). The current API needs fixing so that TTY_DO_WRITE_WAKEUP is se=
t=20
after filling up the holding buffer but BEFORE enabling the TX=20
interrupts. I think TTY_DO_WRITE_WAKEUP needs to be set in a callback=20
function called from the bound layer below HCI LDISC.

Best regards,
Dean

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
