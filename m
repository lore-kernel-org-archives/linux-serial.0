From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] tty/serial: atmel_serial: BUG: stop DMA from transmitting
 in stop_tx
Date: Mon, 2 Jan 2017 15:16:46 +0100
Message-ID: <CACQ1gAiVc56TosMLMB-GSYW9M5m3Zy04RoPr=raoW-PpYEkgXA@mail.gmail.com>
References: <20161213162756.16139-1-richard.genoud@gmail.com> <059a5366-c0d4-ab89-d64a-dcf007bc9e91@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <059a5366-c0d4-ab89-d64a-dcf007bc9e91@atmel.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "beware, this won't apply before 4.3" <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2017-01-02 12:13 GMT+01:00 Nicolas Ferre <nicolas.ferre@atmel.com>:
> Le 13/12/2016 =C3=A0 17:27, Richard Genoud a =C3=A9crit :
>> If we don't disable the transmitter in atmel_stop_tx, the DMA buffer
>> continues to send data until it is emptied.
>> This cause problems with the flow control (CTS is asserted and data are
>> still sent).
>>
>> So, disabling the transmitter in atmel_stop_tx is a sane thing to do.
>>
>> Tested on at91sam9g35-cm(DMA)
>> Tested for regressions on sama5d2-xplained(Fifo) and at91sam9g20ek(PDC)
>>
>> Cc: <stable@vger.kernel.org> (beware, this won't apply before 4.3)
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
>> ---
>>  drivers/tty/serial/atmel_serial.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> NB: this is not for the 4.10 merge window, I'm just sending it now to
>> have some comments if someone is againts it.
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atme=
l_serial.c
>> index 168b10cad47b..f9d42de5ab2d 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -481,6 +481,14 @@ static void atmel_stop_tx(struct uart_port *port)
>>               /* disable PDC transmit */
>>               atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
>>       }
>> +
>> +     /*
>> +      * Disable the transmitter.
>> +      * This is mandatory when DMA is used, otherwise the DMA buffer
>> +      * is fully transmitted.
>> +      */
>> +     atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS);
>> +
>>       /* Disable interrupts */
>>       atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
>>
>> @@ -513,6 +521,9 @@ static void atmel_start_tx(struct uart_port *port)
>>
>>       /* Enable interrupts */
>>       atmel_uart_writel(port, ATMEL_US_IER, atmel_port->tx_done_mask);
>> +
>> +     /* re-enable the transmitter */
>> +     atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN);
>>  }
>>
>>  /*
>>
>
>
> --
> Nicolas Ferre

Greg, could you also take this patch in your tree ?

Thanks !

Richard.
