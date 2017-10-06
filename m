From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 12/16] serial: mvebu-uart: support extended port registers layout
Date: Fri, 06 Oct 2017 14:46:43 +0200
Message-ID: <87wp48e958.fsf@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
        <20171006101344.15590-13-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171006101344.15590-13-miquel.raynal@free-electrons.com>
        (Miquel Raynal's message of "Fri, 6 Oct 2017 12:13:40 +0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Wilson Ding <dingwei@marvell.com>
List-Id: linux-serial@vger.kernel.org

Hi Miquel,
 
 On ven., oct. 06 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Define the missing register offsets and bit fields for the extended
> UART port. Add a second driver data structure filled with its port data,
> selected with the right compatible (marvell,armada-3700-uart-ext).
>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> ---
>  drivers/tty/serial/mvebu-uart.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 3e46affa09a8..38b067e0ef0c 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -39,10 +39,13 @@
>  
>  /* Register Map */
>  #define UART_STD_RBR		0x00
> +#define UART_EXT_RBR		0x18
>  
>  #define UART_STD_TSH		0x04
> +#define UART_EXT_TSH		0x1C
>  
>  #define UART_STD_CTRL1		0x08
> +#define UART_EXT_CTRL1		0x04
>  #define  CTRL_SOFT_RST		BIT(31)
>  #define  CTRL_TXFIFO_RST	BIT(15)
>  #define  CTRL_RXFIFO_RST	BIT(14)
> @@ -55,15 +58,20 @@
>  				CTRL_PAR_ERR_INT | CTRL_OVR_ERR_INT)
>  
>  #define UART_STD_CTRL2		UART_STD_CTRL1
> +#define UART_EXT_CTRL2		0x20
>  #define  CTRL_STD_TX_RDY_INT	BIT(5)
> +#define  CTRL_EXT_TX_RDY_INT	BIT(6)
>  #define  CTRL_STD_RX_RDY_INT	BIT(4)
> +#define  CTRL_EXT_RX_RDY_INT	BIT(5)
>  
>  #define UART_STAT		0x0C
>  #define  STAT_TX_FIFO_EMP	BIT(13)
>  #define  STAT_TX_FIFO_FUL	BIT(11)
>  #define  STAT_TX_EMP		BIT(6)
>  #define  STAT_STD_TX_RDY	BIT(5)
> +#define  STAT_EXT_TX_RDY	BIT(15)
>  #define  STAT_STD_RX_RDY	BIT(4)
> +#define  STAT_EXT_RX_RDY	BIT(14)
>  #define  STAT_BRK_DET		BIT(3)
>  #define  STAT_FRM_ERR		BIT(2)
>  #define  STAT_PAR_ERR		BIT(1)
> @@ -858,12 +866,28 @@ static struct mvebu_uart_driver_data uart_std_driver_data = {
>  	.flags.stat_rx_rdy = STAT_STD_RX_RDY,
>  };
>  
> +static struct mvebu_uart_driver_data uart_ext_driver_data = {
> +	.is_ext = true,
> +	.regs.rbr = UART_EXT_RBR,
> +	.regs.tsh = UART_EXT_TSH,
> +	.regs.ctrl = UART_EXT_CTRL1,
> +	.regs.intr = UART_EXT_CTRL2,
> +	.flags.ctrl_tx_rdy_int = CTRL_EXT_TX_RDY_INT,
> +	.flags.ctrl_rx_rdy_int = CTRL_EXT_RX_RDY_INT,
> +	.flags.stat_tx_rdy = STAT_EXT_TX_RDY,
> +	.flags.stat_rx_rdy = STAT_EXT_RX_RDY,
> +};
> +
>  /* Match table for of_platform binding */
>  static const struct of_device_id mvebu_uart_of_match[] = {
>  	{
>  		.compatible = "marvell,armada-3700-uart",
>  		.data = (void *)&uart_std_driver_data,
>  	},
> +	{
> +		.compatible = "marvell,armada-3700-uart-ext",
> +		.data = (void *)&uart_ext_driver_data,
> +	},
>  	{}
>  };
>  
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
