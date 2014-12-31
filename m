From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] tty: 8250: Add 64byte UART support for FSL platforms
Date: Wed, 31 Dec 2014 00:01:57 -0600
Message-ID: <1420005717.4961.9.camel@freescale.com>
References: <1419932288-17562-1-git-send-email-vijay.rai@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419932288-17562-1-git-send-email-vijay.rai@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Rai <vijay.rai@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Poonam Aggrwal <poonam.aggrwal@freescale.com>, Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 2014-12-30 at 15:08 +0530, Vijay Rai wrote:
> Some of FSL SoCs like T1040 has new version of UART controller which
> can support 64byte FiFo.
> To enable 64 byte support, following needs to be done:
> -FCR[EN64] needs to be programmed to 1 to enable it.
> -Also, when FCR[EN64]==1, RTL bits to be used as below
> to define various Receive Trigger Levels:
>         -FCR[RTL] = 00  1 byte
>         -FCR[RTL] = 01  16 bytes
>         -FCR[RTL] = 10  32 bytes
>         -FCR[RTL] = 11  56 bytes
> -tx_loadsz is set to 32-bytes instead of 64-bytes to implement
>  workaround of errata A-008006 which states that tx_loadsz should
>  be configured less than Maximum supported fifo bytes

Why 32 and not 63?

> Signed-off-by: Vijay Rai <vijay.rai@freescale.com>
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> ---
>  drivers/tty/serial/8250/8250_core.c |   20 +++++++++++++++++++-
>  include/uapi/linux/serial_core.h    |    3 ++-
>  include/uapi/linux/serial_reg.h     |    3 ++-
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 11c6685..565748c 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -329,6 +329,14 @@ static const struct serial8250_config uart_config[] = {
>  		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>  		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
>  	},
> +	[PORT_16550A_FSL64] = {
> +		.name		= "16550A_FSL64",
> +		.fifo_size	= 64,
> +		.tx_loadsz	= 32,

Put a comment here mentioning the erratum.

> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index c172180..a3b4491 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -55,7 +55,8 @@
>  #define PORT_ALTR_16550_F64 27	/* Altera 16550 UART with 64 FIFOs */
>  #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs */
>  #define PORT_RT2880	29	/* Ralink RT2880 internal UART */
> -#define PORT_MAX_8250	29	/* max port ID */
> +#define PORT_16550A_FSL64 30	/* Freescale 16550 UART with 64 FIFOs */
> +#define PORT_MAX_8250	31	/* max port ID */

Why are you adding 2 to PORT_MAX_8250 when you only add one new type?
 
-Scott
