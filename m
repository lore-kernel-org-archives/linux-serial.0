From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/7] serial: exar: Fix feature control register constants
Date: Wed, 8 Feb 2017 00:44:52 +0200
Message-ID: <CAHp75Ve8JXbgD07v-AHYSGQ3TnkEYk6=Dmz3Br3a7FikHUApDA@mail.gmail.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com> <2d1b9f9a78033664ee1afcd55b708602bc262c2e.1486483803.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2d1b9f9a78033664ee1afcd55b708602bc262c2e.1486483803.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 7, 2017 at 6:10 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> According to the XR17V352 manual, bit 4 is IrDA control and bit 5 for
> 485. Fortunately, no driver used them so far.

RS-485

>

FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  include/uapi/linux/serial_reg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
> index 274d8fc..25b93a7 100644
> --- a/include/uapi/linux/serial_reg.h
> +++ b/include/uapi/linux/serial_reg.h
> @@ -374,8 +374,8 @@
>  #define UART_EXAR_DVID         0x8d    /* Device identification */
>
>  #define UART_EXAR_FCTR         0x08    /* Feature Control Register */
> -#define UART_FCTR_EXAR_IRDA    0x08    /* IrDa data encode select */
> -#define UART_FCTR_EXAR_485     0x10    /* Auto 485 half duplex dir ctl */
> +#define UART_FCTR_EXAR_IRDA    0x10    /* IrDa data encode select */
> +#define UART_FCTR_EXAR_485     0x20    /* Auto 485 half duplex dir ctl */
>  #define UART_FCTR_EXAR_TRGA    0x00    /* FIFO trigger table A */
>  #define UART_FCTR_EXAR_TRGB    0x60    /* FIFO trigger table B */
>  #define UART_FCTR_EXAR_TRGC    0x80    /* FIFO trigger table C */
> --
> 2.1.4
>



-- 
With Best Regards,
Andy Shevchenko
