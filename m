From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCHv2 2/3] tty/serial: at91: fix hardware handshake with GPIOs
Date: Tue, 27 Sep 2016 09:45:28 +0200
Message-ID: <CACQ1gAjPfM9pN5Y88rum=0a8nfp7VL=FoJCz3bhHxkJj7JdHpw@mail.gmail.com>
References: <20160912094733.21501-1-richard.genoud@gmail.com>
 <20160912094733.21501-3-richard.genoud@gmail.com> <20160922132045.tbrd5u56qasaf7gn@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160922132045.tbrd5u56qasaf7gn@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2016-09-22 15:20 GMT+02:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>:
> On Mon, Sep 12, 2016 at 11:47:32AM +0200, Richard Genoud wrote:
>> Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
>> hardware handshake is enabled") broke the hardware handshake when GPIOs
>> where used.
>
> s/where/were/
ok.

>> Hardware handshake with GPIOs used to work before this commit because
>> the CRTSCTS flag (termios->c_cflag) was set, but not the
>> ATMEL_US_USMODE_HWHS flag (controller register) ; so hardware handshake
>> enabled, but not handled by the controller.
>>
>> This commit restores this behaviour.
>>
>> NB: -stable is not Cced because it doesn't cleanly apply on 4.1+
>> and it will also need previous commit:
>> "serial: mctrl_gpio: implement mctrl_gpio_use_rtscts"
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Fixes: 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when har=
dware handshake is enabled")
>> ---
>>  drivers/tty/serial/atmel_serial.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atme=
l_serial.c
>> index 2eaa18ddef61..e9b4fbf88c2d 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -2025,6 +2025,7 @@ static void atmel_serial_pm(struct uart_port *port=
, unsigned int state,
>>  static void atmel_set_termios(struct uart_port *port, struct ktermios *=
termios,
>>                             struct ktermios *old)
>>  {
>> +     struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
>>       unsigned long flags;
>>       unsigned int old_mode, mode, imr, quot, baud;
>>
>> @@ -2126,8 +2127,12 @@ static void atmel_set_termios(struct uart_port *p=
ort, struct ktermios *termios,
>>               atmel_uart_writel(port, ATMEL_US_TTGR,
>>                                 port->rs485.delay_rts_after_send);
>>               mode |=3D ATMEL_US_USMODE_RS485;
>> -     } else if (termios->c_cflag & CRTSCTS) {
>> -             /* RS232 with hardware handshake (RTS/CTS) */
>> +     } else if ((termios->c_cflag & CRTSCTS) &&
>> +                !mctrl_gpio_use_rtscts(atmel_port->gpios)) {
>
> IMHO the behaviour of the hw controlled pins shouldn't change when
> mctrl_gpio is in use (if possible). But I don't understand the issue so
> I guess you need a better changelog.
Yes, the behavior of the CTS/RTS pins should the same whenever they
are GPIOs or not.
That was the case before commit 1cf6e8fc8341 ("tty/serial: at91: fix
RTS line management when
hardware handshake is enabled")
BUT, this commit (1cf6e8fc834) introduced the actual use of the
ATMEL_US_USMODE_HWHS flag.
This flags changes the way RTS/CTS pins are driven, and that's the
discussion we are having in patch 3/3.

>> +             /*
>> +              * RS232 with hardware handshake (RTS/CTS)
>> +              * handled by the controller.
>> +              */
>>               if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
>>                       dev_info(port->dev, "not enabling hardware flow co=
ntrol because DMA is used");
>>                       termios->c_cflag &=3D ~CRTSCTS;
>> @@ -2135,7 +2140,7 @@ static void atmel_set_termios(struct uart_port *po=
rt, struct ktermios *termios,
>>                       mode |=3D ATMEL_US_USMODE_HWHS;
>>               }
>>       } else {
>> -             /* RS232 without hadware handshake */
>> +             /* RS232 without hadware handshake or controlled by GPIOs =
*/
>
> When touching this line, please also do s/hadware/hardware/.
ok.
>
>>               mode |=3D ATMEL_US_USMODE_NORMAL;
>>       }
>
> Best regards
> Uwe

Thanks.
