From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v3 5/5] tty: Add software emulated RS485 support for 8250
Date: Tue, 17 Nov 2015 13:25:36 +0300
Message-ID: <CAJs94Eb=ioh4fFiU41LfaN1jhq8fWwDA9-cV=pvpOcVC65vdFw@mail.gmail.com>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
 <1447338836-8785-6-git-send-email-matwey@sai.msu.ru> <20151117092442.GL22022@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151117092442.GL22022@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, Peter Hurley <peter@hurleysoftware.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2015-11-17 12:24 GMT+03:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengu=
tronix.de>:
> Hello,
>
> On Thu, Nov 12, 2015 at 05:33:56PM +0300, Matwey V. Kornilov wrote:
>> +static void serial8250_start_tx(struct uart_port *port)
>> +{
>> +     struct uart_8250_port *up =3D up_to_u8250p(port);
>> +     __u32 delay;
>> +
>> +     serial8250_rpm_get_tx(up);
>> +
>> +     if (timer_pending(&up->rs485_start_tx_timer))
>> +             return;
>
> I think this is wrong (or at least suboptimal). The .start_tx callbac=
k
> can be called even if transmission is already ongoing. In this case y=
ou
> don't want to restart the rs485_start_tx_timer.

If I understand you correctly, this maybe suboptimal but not wrong.
Calling .start_tx during transmission will lead to call
serial8250_rs485_start_tx which will return 0 because RTS is already
in proper state, and then __start_tx will be called immediately. Just
as it happens now.

>
>> +     if ((delay =3D serial8250_rs485_start_tx(up))) {
>> +             mod_timer(&up->rs485_start_tx_timer, jiffies + delay *=
 HZ / 1000);
>> +     } else {
>> +             __start_tx(port);
>> +     }
>> +}
>> +
>> [...]
>> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250=
=2Eh
>> index faa0e03..c4905e7 100644
>> --- a/include/linux/serial_8250.h
>> +++ b/include/linux/serial_8250.h
>> @@ -86,6 +86,8 @@ struct uart_8250_ops {
>>  struct uart_8250_port {
>>       struct uart_port        port;
>>       struct timer_list       timer;          /* "no irq" timer */
>> +     struct timer_list       rs485_start_tx_timer; /* "rs485 start =
tx" timer */
>> +     struct timer_list       rs485_stop_tx_timer; /* "rs485 stop tx=
" timer */
>
> Do you really need two timers here? At each point in time there shoul=
d
> only be at most one of them active.

You are right, only one is active. Having two timers is implicit way
to store the state ('starting' or 'stopping'). I don't think that this
is the worst way.

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig   =
         |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |
>



--=20
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Ru=
ssia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
