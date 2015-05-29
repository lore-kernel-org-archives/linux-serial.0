From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] tty: serial: fsl_lpuart: Add support for RS-485
Date: Fri, 29 May 2015 16:12:13 +0530
Message-ID: <55684285.4000004@toradex.com>
References: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>	<1432886754-30115-4-git-send-email-bhuvanchandra.dv@toradex.com> <20150529121808.27346afc@north>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150529121808.27346afc@north>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?SmFrdWIgS2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhuvanchandra.dv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 05/29/2015 03:48 PM, Jakub Kici=C5=84ski wrote:
> On Fri, 29 May 2015 13:35:54 +0530, Bhuvanchandra DV wrote:
>> Enable Vybrid's build-in support for RS-485 auto RTS for
>> controlling line direction of RS-485 transceiver driver.
>>
>> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
>> ---
>>   drivers/tty/serial/fsl_lpuart.c | 60 +++++++++++++++++++++++++++++=
++++++++++++
>>   1 file changed, 60 insertions(+)
>>
>> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fs=
l_lpuart.c
>> index 357f623..c553b14 100644
>> --- a/drivers/tty/serial/fsl_lpuart.c
>> +++ b/drivers/tty/serial/fsl_lpuart.c
>> @@ -820,6 +820,50 @@ static unsigned int lpuart32_tx_empty(struct ua=
rt_port *port)
>>   		TIOCSER_TEMT : 0;
>>   }
>>
>> +static int lpuart_config_rs485(struct uart_port *port,
>> +			struct serial_rs485 *rs485)
>> +{
>> +	struct lpuart_port *sport =3D container_of(port,
>> +			struct lpuart_port, port);
>> +	u8 modem =3D readb(sport->port.membase + UARTMODEM) &
>> +		~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
>
> Please put empty line between variables and code.
Ok
>
>> +	writeb(modem, sport->port.membase + UARTMODEM);
>> +
>> +	if (rs485->flags & SER_RS485_ENABLED) {
>> +		/* Enable auto RS-485 RTS mode */
>> +		modem |=3D UARTMODEM_TXRTSE;
>> +
>> +		/*
>> +		* RTS needs to be logic HIGH either during transer _or_ after
>> +		* transfer, other variants are not supported by the hardware.
>> +		*/
>
> Indentation is off here.  '*' should be aligned.
Ok
>
>> +		if (!(rs485->flags & (SER_RS485_RTS_ON_SEND |
>> +				SER_RS485_RTS_AFTER_SEND)))
>
> and here - things should be aligned on the containing bracket (SER_
> under SER_ here).
Ok
>
>> +			rs485->flags |=3D SER_RS485_RTS_ON_SEND;
>> +
>> +		if (rs485->flags & SER_RS485_RTS_ON_SEND &&
>> +				rs485->flags & SER_RS485_RTS_AFTER_SEND)
>
> and here - same bracket rule (rs485-> under rs485->)
Ok
>
>> +			rs485->flags &=3D ~SER_RS485_RTS_AFTER_SEND;
>> +
>> +		/*
>> +		* The hardware defaults to RTS logic HIGH while transfer.
>> +		* Switch polarity in case RTS shall be logic HIGH
>> +		* after transfer.
>> +		* Note: UART is assumed to be active high.
>> +		*/
>> +		if (rs485->flags & SER_RS485_RTS_ON_SEND)
>> +			modem &=3D ~UARTMODEM_TXRTSPOL;
>
> UARTMODEM_TXRTSPOL was already clear when you read modem.
Ok
>
>> +		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
>> +			modem |=3D UARTMODEM_TXRTSPOL;
>> +	}
>> +
>> +	/* Store the new configuration */
>> +	sport->port.rs485 =3D *rs485;
>> +
>> +	writeb(modem, sport->port.membase + UARTMODEM);
>> +	return 0;
>> +}
>> +
>>   static unsigned int lpuart_get_mctrl(struct uart_port *port)
>>   {
>>   	return TIOCM_CAR | TIOCM_CTS | TIOCM_DSR;
> [...]
>> @@ -1802,6 +1854,14 @@ static int lpuart_probe(struct platform_devic=
e *pdev)
>>   		dev_info(sport->port.dev, "DMA rx channel request failed, "
>>   				"operating without rx DMA\n");
>>
>> +	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time"))=
 {
>> +		sport->port.rs485.flags |=3D SER_RS485_ENABLED;
>> +		sport->port.rs485.flags |=3D SER_RS485_RTS_ON_SEND;
>> +		writeb(UARTMODEM_TXRTSE, sport->port.membase + UARTMODEM);
>> +	} else {
>> +		sport->port.rs485.flags &=3D ~SER_RS485_ENABLED;
>
> Why the need to clear the flag?  sport was kzalloc'ed.
Will remove it.
>

Best Regards,
Bhuvan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
