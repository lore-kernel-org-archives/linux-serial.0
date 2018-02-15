From: Avi Fishman <avifishman70-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] serial: 8250: Add Nuvoton NPCM UART
Date: Thu, 15 Feb 2018 12:15:26 +0200
Message-ID: <CAKKbWA7FkFosy4aUyYXvOW8tYxsoPPYj6Z-=2A9i5o6zkkRupw@mail.gmail.com>
References: <20180212044810.23547-1-joel@jms.id.au> <CAHp75VcCj2PtPgMEb+9ZmO-1t_K16oyY97vn3FbHr=LkGvna-Q@mail.gmail.com>
 <CACPK8XeUWV7rngfBmKn9kEnhv=NFsNCNrJdZq3p9GRTcjGVhqA@mail.gmail.com> <11dff5a3498949118b883b39be028611@NTILML02.nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <11dff5a3498949118b883b39be028611-qcV2a/0u7bE377JQJD9m/laTQe2KTcn/@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, AP MS30 Linux Kernel community <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

> From: joel.stan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org [mailto:joel.stan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of Joel Stanley
> Sent: Thursday, February 15, 2018 4:00 AM
>
> On Wed, Feb 14, 2018 at 3:22 AM, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Mon, Feb 12, 2018 at 6:48 AM, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org> wrote:
>>> The Nuvoton UART is almost compatible with the 8250 driver when
>>> probed via the 8250_of driver, however it requires some extra
>>> configuration at startup.
>>
>>
>>> +       [PORT_NPCM] = {
>>> +               .name           = "Nuvoton 16550",
>>> +               .fifo_size      = 16,
>>> +               .tx_loadsz      = 16,
>>> +               .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
>>> +                                 UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
>>> +               .rxtrig_bytes   = {1, 4, 8, 14},
>>> +               .flags          = UART_CAP_FIFO,
>>
>>> +
>>
>> Redundant.
>
> You are referring to the extra whitespace?
>
>>> +       },
>>
>>> +               /*
>>> +                * Nuvoton calls the scratch register 'UART_TOR' (timeout
>>> +                * register). Enable it, and set TIOC (timeout interrupt
>>> +                * comparator) to be 0x20 for correct operation.
>>> +                */
>>> +               serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE |
>>> + 0x20);
>>
>>> +/* Nuvoton NPCM UARTs have a custom divisor calculation */
>>> +       return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
>>
>> Is there any link to datasheet?
>
> I have a copy of the datasheet under NDA. The Nuvoton guys might be able to help you out. Avi?

In the spec the calculation is as follows:
  BaudOut = Selected UART Clock Source / ( 16 * [Divisor + 2] )
To translate it to our code is:
  baud = port->uartclk / (16 * (Divisor + 2) )
So it should calculate without the "+ 2" inside as follow:
+       return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud) - 2;

In order to get the spec you can add somthing like that:
"For getting the NPCM7XX Data Sheet please contact bmc_marketing-KrzQf0k3Iz9BDgjK7y7TUQ@public.gmane.org".

BTW Andy, Intel has our Data Sheet under NDA, you can ask Mihm James
<james.mihm-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>.

>
>>
>>> +/* Nuvoton UART */
>>> +#define PORT_NPCM      118
>>
>> We have gaps there. #40 is perfect place for this one.
>
> Ok, I will move it up. Thanks for the review.
>
> Cheers,
>
> Joel
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
