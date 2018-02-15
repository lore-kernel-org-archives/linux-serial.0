From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] serial: 8250: Add Nuvoton NPCM UART
Date: Thu, 15 Feb 2018 12:30:02 +1030
Message-ID: <CACPK8XeUWV7rngfBmKn9kEnhv=NFsNCNrJdZq3p9GRTcjGVhqA@mail.gmail.com>
References: <20180212044810.23547-1-joel@jms.id.au> <CAHp75VcCj2PtPgMEb+9ZmO-1t_K16oyY97vn3FbHr=LkGvna-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcCj2PtPgMEb+9ZmO-1t_K16oyY97vn3FbHr=LkGvna-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomer Maimon <tomer.maimon@nuvoton.com>, Avi Fishman <Avi.Fishman@nuvoton.com>, Jeremy Kerr <jk@ozlabs.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 14, 2018 at 3:22 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Feb 12, 2018 at 6:48 AM, Joel Stanley <joel@jms.id.au> wrote:
>> The Nuvoton UART is almost compatible with the 8250 driver when probed
>> via the 8250_of driver, however it requires some extra configuration
>> at startup.
>
>
>> +       [PORT_NPCM] = {
>> +               .name           = "Nuvoton 16550",
>> +               .fifo_size      = 16,
>> +               .tx_loadsz      = 16,
>> +               .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
>> +                                 UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
>> +               .rxtrig_bytes   = {1, 4, 8, 14},
>> +               .flags          = UART_CAP_FIFO,
>
>> +
>
> Redundant.

You are referring to the extra whitespace?

>> +       },
>
>> +               /*
>> +                * Nuvoton calls the scratch register 'UART_TOR' (timeout
>> +                * register). Enable it, and set TIOC (timeout interrupt
>> +                * comparator) to be 0x20 for correct operation.
>> +                */
>> +               serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
>
>> +/* Nuvoton NPCM UARTs have a custom divisor calculation */
>> +       return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
>
> Is there any link to datasheet?

I have a copy of the datasheet under NDA. The Nuvoton guys might be
able to help you out. Avi?

>
>> +/* Nuvoton UART */
>> +#define PORT_NPCM      118
>
> We have gaps there. #40 is perfect place for this one.

Ok, I will move it up. Thanks for the review.

Cheers,

Joel
