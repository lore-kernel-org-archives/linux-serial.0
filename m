From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 11/16] serial: mvebu-uart: augment the maximum number of ports
Date: Fri, 06 Oct 2017 14:45:26 +0200
Message-ID: <871smgfnrt.fsf@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
        <20171006101344.15590-12-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171006101344.15590-12-miquel.raynal@free-electrons.com>
        (Miquel Raynal's message of "Fri, 6 Oct 2017 12:13:39 +0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Wilson Ding <dingwei@marvell.com>
List-Id: linux-serial@vger.kernel.org

Hi Miquel,
 
 On ven., oct. 06 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> A3700 boards may have up to two UART ports. Set the new limit to two
> maximum UART ports.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> ---
>  drivers/tty/serial/mvebu-uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index b52cbe8c0558..3e46affa09a8 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -74,7 +74,7 @@
>  #define UART_BRDV		0x10
>  #define  BRDV_BAUD_MASK         0x3FF
>  
> -#define MVEBU_NR_UARTS		1
> +#define MVEBU_NR_UARTS		2
>  
>  #define MVEBU_UART_TYPE		"mvebu-uart"
>  #define DRIVER_NAME		"mvebu_serial"
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
