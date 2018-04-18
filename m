From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2] serial: imx: warn user when using unsupported
 configuration
Date: Wed, 18 Apr 2018 17:30:42 +0200
Message-ID: <6cdfd27073006d0959c21eca23fa56e1@agner.ch>
References: <20180418140638.19331-1-stefan@agner.ch>
 <20180418145341.xwsah7spyfazcb63@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418145341.xwsah7spyfazcb63@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 18.04.2018 16:53, Uwe Kleine-König wrote:
> On Wed, Apr 18, 2018 at 04:06:38PM +0200, Stefan Agner wrote:
>> When using half-duplex mode (which disables receiver during txing)
>> the RTS signal cannot be driven low during transmission. This seems
>> to be a limitation of the i.MX UART IP: The RTS (CTS_B) signal is
>> controlled by the receiver. When the receiver is disabled, the
>> signal stays in UART logic idle state which is high...
>>
>> If SER_RS485_RTS_ON_SEND is used, RTS needs to be high active during
>> transmission. Since this is the default state of the RTS (CTS_B)
>> signal when the receiver is off, half-duplex mode in this
>> configuration works fine.
>>
>> However, a low-active RTS signal (flag SER_RS485_RTS_ON_SEND not set)
>> cannot be generated when the receiver is turned off.
>>
>> Print an error if the user selects this unsupported configuration
>> (both SER_RS485_RTS_ON_SEND and SER_RS485_RX_DURING_TX unset) and
>> configure the closest working configuration (set the
>> SER_RS485_RX_DURING_TX flag).
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Changes since v1:
>> - Consistently check for sport->have_rtscts && !(rs485conf->flags &
>>   SER_RS485_RTS_ON_SEND)
>> - Don't break printed message
>>
>>  drivers/tty/serial/imx.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 91f3a1a5cb7f..1c1080fc8084 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1833,6 +1833,11 @@ static int imx_uart_rs485_config(struct uart_port *port,
>>  		rs485conf->flags &= ~SER_RS485_ENABLED;
>>
>>  	if (rs485conf->flags & SER_RS485_ENABLED) {
>> +		/* Enable receiver if low-active RTS signal is requested */
>> +		if (sport->have_rtscts &&
>> +		    !(rs485conf->flags & SER_RS485_RTS_ON_SEND))
>> +			rs485conf->flags |= SER_RS485_RX_DURING_TX;
>> +
> 
> I wonder what should happen, if the device tree has both
> 
> 	uart-has-rtscts;
> 	rts-gpios = <...>;

Hm, it seems that the code controls both in that case.

> 
> . I think the right thing would be to check for
> 
> 	sport->have_rtscts && !sport->have_rtsgpio

I agree, since it controls both one can use the GPIO to have a working
half duplex with low-active RTS configuration.

Will send v3.

--
Stefan
