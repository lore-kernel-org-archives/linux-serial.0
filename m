From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] tty/serial: atmel: increase ATMEL_MAX_UART
Date: Tue, 21 Feb 2017 13:46:26 +0100
Message-ID: <CACQ1gAgkqRPdVCU+cmUdaANVXygB4pC40+u1pPwpervAJ4+Q8g@mail.gmail.com>
References: <20170221120357.13623-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170221120357.13623-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2017-02-21 13:03 GMT+01:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> The samx7 family uses the same UART/USART IP as the at91/sama5 families b=
ut
> has 8 of those.
>
> Suggested-by: Szemz=C5=91 Andr=C3=A1s <sza@esh.hu>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>  drivers/tty/serial/atmel_serial.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel=
_serial.c
> index f0d4894267c2..8cc152e67bfb 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -119,8 +119,9 @@ struct atmel_uart_char {
>  /*
>   * at91: 6 USARTs and one DBGU port (SAM9260)
>   * avr32: 4
> + * samx7: 3 USARTs and 5 UARTs
>   */
> -#define ATMEL_MAX_UART         7
> +#define ATMEL_MAX_UART         8
>
>  /*
>   * We wrap our port structure around the generic uart_port.
> --
> 2.11.0
>

Thanks !
