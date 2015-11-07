From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v2 2/3] tty: Implement default fallback serial8250_rs485_config
Date: Sat, 7 Nov 2015 16:51:16 +0300
Message-ID: <CAJs94EbDREbfN8VcbDwgVd=SJWNgWg_Qe=633dG790WbFmwNCA@mail.gmail.com>
References: <1446890976-1817-1-git-send-email-matwey@sai.msu.ru>
 <1446890976-1817-2-git-send-email-matwey@sai.msu.ru> <563DEE8F.4050401@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <563DEE8F.4050401@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2015-11-07 15:29 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
> Hi Matwey,
>
> On 11/07/2015 05:09 AM, Matwey V. Kornilov wrote:
>> When 8250 driver doesn't have its own hardware RS485 support and doesn't
>> want to override rs485_config callback, then default
>> serial8250_rs485_config is used. It just stores supplied by user-space
>> config.
>>
>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>> ---
>>  drivers/tty/serial/8250/8250_core.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index 3912646..8f292da 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -395,6 +395,12 @@ static void serial8250_release_rsa_resource(struct uart_8250_port *up)
>>       }
>>  }
>>  #endif
>> +static int serial8250_rs485_config(struct uart_port *port,
>> +                             struct serial_rs485 *rs485)
>> +{
>> +     port->rs485 = *rs485;
>> +     return 0;
>> +}
>>
>>  static const struct uart_ops *base_ops;
>>  static struct uart_ops univ8250_port_ops;
>> @@ -990,6 +996,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>>               uart->port.rs485        = up->port.rs485;
>>               uart->dma               = up->dma;
>>
>> +             /* Use software RS485 support when hardware one is not available */
>> +             if (!(uart->capabilities & UART_CAP_HW485) && !uart->port.rs485_config)
>> +                     uart->port.rs485_config = serial8250_rs485_config;
>
> To setup a default 8250 port function,
> 1. define the default 8250 port function in 8250/8250_port.c
> 2. add the port function to the dispatch table (serial8250_pops)

rs485_config is not a member of struct uart_ops, should I add it there?

> 3. add a test for 8250 sub-driver override in serial8250_register_8250_port()
>    Eg.,
>
>                 if (up->port.rs485_config)
>                         uart->port.rs485_config = up->port.rs485_config;
>
> Regards,
> Peter Hurley
>
>>               /* Take tx_loadsz from fifosize if it wasn't set separately */
>>               if (uart->port.fifosize && !uart->tx_loadsz)
>>                       uart->tx_loadsz = uart->port.fifosize;
>>
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
