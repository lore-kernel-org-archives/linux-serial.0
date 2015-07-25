From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH 1/1] serial: 8250_pci: add RS485 for F81504/508/512
Date: Sat, 25 Jul 2015 11:35:45 +0200
Message-ID: <20150725113545.6bce8038@north>
References: <1437717339-28881-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437717339-28881-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri, 24 Jul 2015 13:55:39 +0800, Peter Hung wrote:
> Add RS485 control for Fintek F81504/508/512
> 
> F81504/508/512 can control their RTS with H/W mode.
> PCI configuration space for each port is 0x40 + idx * 8 + 7.
> 
> When it set with 0x01, it's configured with RS232 mode.
> RTS is controlled by MCR.
> 
> When it set with 0x11, it's configured with RS485 mode.
> RTS is controlled by H/W, RTS high with idle & RX, low with TX.
> 
> When it set with 0x31, it's configured with RS485 mode.
> RTS is controlled by H/W, RTS low with idle & RX, high with TX.
> 
> We will force 0x01 on pci_fintek_setup().
> 
> Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 44 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index e55f18b..36280fa 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1685,11 +1685,43 @@ pci_brcm_trumanage_setup(struct serial_private *priv,
>  	return ret;
>  }
>  
> +static int pci_fintek_rs485_config(struct uart_port *port,
> +			       struct serial_rs485 *rs485)
> +{
> +	u8 setting;
> +	u8 *index = (u8 *) port->private_data;
> +	struct pci_dev *pci_dev = container_of(port->dev, struct pci_dev,
> +									dev);

This looks misaligned.  'dev' should be aligned with opening
parenthesis.

> +
> +	pci_read_config_byte(pci_dev, 0x40 + 8 * *index + 7, &setting);
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		/* Enable RTS H/W control mode */
> +		setting |= BIT(4);

Please add defines with the bit names.

> +
> +		if (rs485->flags & SER_RS485_RTS_ON_SEND) {
> +			/* RTS driving high on TX */
> +			setting |= BIT(5);
> +		} else {
> +			/* RTS driving low on TX */
> +			setting &= ~BIT(5);
> +		}
> +	} else {
> +		/* Disable RTS H/W control mode */
> +		setting &= ~(BIT(4) | BIT(5));
> +	}

Please make sure you correct the rs485 configuration with what you can
actually support.  Look at 8250_lpc18xx.c as an example.  In your case
when the function returns it should have SER_RS485_ENABLED and one of
SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND set and nothing else
(or be completely zeroed if SER_RS485_ENABLED was not set).
