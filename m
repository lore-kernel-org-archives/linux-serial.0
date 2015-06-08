From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH V2 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control
 from set/get_mctrl
Date: Mon, 8 Jun 2015 12:55:45 +0530
Message-ID: <55754379.90804@toradex.com>
References: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com> <1433136067-20644-3-git-send-email-bhuvanchandra.dv@toradex.com> <20150608064113.GX18985@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150608064113.GX18985@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, moorray3@wp.pl, linux-kernel@vger.kernel.org, stefan@agner.ch, bhuvanchandra.dv@gmail.com, kernel@pengutronix.de, shawn.guo@linaro.org, jslaby@suse.cz, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello,

On 06/08/2015 12:11 PM, Uwe Kleine-K=F6nig wrote:
> Hello,
>
> On Mon, Jun 01, 2015 at 10:51:06AM +0530, Bhuvanchandra DV wrote:
>> The LPUART does not provide manual control of RTS/CTS signals,
>> those can only be controlled by the hardware directly. Therefore
>> manual control of those signals through mctrl can not be provided.
>> The current implementation enables/disables the automatic control,
>> which is not what mctrl should do, hence remove the incorrect
>> implementation.
>>
>> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
>> ---
>>   drivers/tty/serial/fsl_lpuart.c | 63 +++++------------------------=
------------
>>   1 file changed, 7 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fs=
l_lpuart.c
>> index 08ce76f..532cfb7 100644
>> --- a/drivers/tty/serial/fsl_lpuart.c
>> +++ b/drivers/tty/serial/fsl_lpuart.c
>> @@ -822,64 +822,15 @@ static unsigned int lpuart32_tx_empty(struct u=
art_port *port)
>>
>>   static unsigned int lpuart_get_mctrl(struct uart_port *port)
>>   {
>> -	unsigned int temp =3D 0;
>> -	unsigned char reg;
>> -
>> -	reg =3D readb(port->membase + UARTMODEM);
>> -	if (reg & UARTMODEM_TXCTSE)
>> -		temp |=3D TIOCM_CTS;
>> -
>> -	if (reg & UARTMODEM_RXRTSE)
>> -		temp |=3D TIOCM_RTS;
>> -
>> -	return temp;
>  From reading the commit log I would expect that you only touch the
> set_mctrl function, but not get_mctrl. Assuming your code change is
> right, can you mention this in the commit log please? The bits
> UARTMODEM_TXCTSE and UARTMODEM_RXRTSE only control the automatic mode=
?
OK, will use 'get/set_mctrl' instead of 'mctrl' in the commit log.
Yes, those bits are only responsible for enabling/disabling the auto=20
hardware flow control, not for controlling the RTS/CTS signals directly=
=2E
>
> What is the problem you're fixing here? I'm not sure how such an UART
> should be handled, but I imagine that you want to make use of automat=
ic
> mode in some cases. Greg?
>
=46ixing the implementation of hardware flow control wrt LPUART hardwar=
e.
> Best regards
> Uwe
>

Best regards,
Bhuvan
