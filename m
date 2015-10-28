From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: serial: sa1100.c: use UPIO_MEM rather than
 SERIAL_IO_MEM
Date: Wed, 28 Oct 2015 09:45:14 -0400
Message-ID: <5630D16A.1020604@hurleysoftware.com>
References: <saurabh.truth@gmail.com>
 <1445932017-4136-1-git-send-email-saurabh.truth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445932017-4136-1-git-send-email-saurabh.truth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Saurabh Sengar <saurabh.truth@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Saurabh,

On 10/27/2015 03:46 AM, Saurabh Sengar wrote:
> use UPIO_MEM rather then SERIAL_IO_MEM.
> both have the same value
> 
> Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
> ---
>  drivers/tty/serial/sa1100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> index fd3d132..283c7e0 100644
> --- a/drivers/tty/serial/sa1100.c
> +++ b/drivers/tty/serial/sa1100.c
> @@ -579,7 +579,7 @@ sa1100_verify_port(struct uart_port *port, struct serial_struct *ser)
>  		ret = -EINVAL;
>  	if (sport->port.irq != ser->irq)
>  		ret = -EINVAL;
> -	if (ser->io_type != SERIAL_IO_MEM)
> +	if (ser->io_type != UPIO_MEM)

SERIAL_IO_* io_type defines are the appropriate constants for the
struct serial_struct::io_type field. Both are defined in the
uapi header, include/uapi/linux/serial.h

UPIO_* io_type defines are the appropriate constants for the
struct uart_port::io_type field. Both are defined in the kernel
header, include/kernel/serial_core.h

I defined the UPIO_* io_types in terms of SERIAL_IO_* because
userspace breakage was occurring as contributors were changing
the UPIO_* constant values.


Regards,
Peter Hurley


>  		ret = -EINVAL;
>  	if (sport->port.uartclk / 16 != ser->baud_base)
>  		ret = -EINVAL;
> 
