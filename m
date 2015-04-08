From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 1/2] tty: serial: msm: Add mask value for UART_DM registers
Date: Wed, 08 Apr 2015 16:31:52 -0700
Message-ID: <5525BA68.7060602@codeaurora.org>
References: <1428499733-21963-1-git-send-email-gpramod@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1428499733-21963-1-git-send-email-gpramod@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bryanh@codeaurora.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

On 04/08/15 06:28, Pramod Gurav wrote:
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index b73889c..4c1e9ea 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -432,8 +432,13 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud)
>  	/* RX stale watermark */
>  	rxstale = entry->rxstale;
>  	watermark = UART_IPR_STALE_LSB & rxstale;
> -	watermark |= UART_IPR_RXSTALE_LAST;
> -	watermark |= UART_IPR_STALE_TIMEOUT_MSB & (rxstale << 2);
> +	if (msm_port->is_uartdm)
> +		watermark |= UART_DM_IPR_STALE_TIMEOUT_MSB & (rxstale << 2);
> +	else {
> +		watermark |= UART_IPR_RXSTALE_LAST;
> +		watermark |= UART_IPR_STALE_TIMEOUT_MSB & (rxstale << 2);
> +	}
> +
>  	msm_write(port, watermark, UART_IPR);
>  

This could be written like so:

if (msm_port->is_uartdm) {
	mask = UART_DM_IPR_STALE_TIMEOUT_MSB;
} else {
	watermark |= UART_IPR_RXSTALE_LAST;
	mask = UART_IPR_STALE_TIMEOUT_MSB;
}

watermark |= mask & (rxstale << 2);

so that we don't duplicate the rfr_level << 2 part.

>  	/* set RX watermark */
> @@ -496,9 +501,15 @@ static int msm_startup(struct uart_port *port)
>  
>  	/* set automatic RFR level */
>  	data = msm_read(port, UART_MR1);
> -	data &= ~UART_MR1_AUTO_RFR_LEVEL1;
> +	if (msm_port->is_uartdm) {
> +		data &= ~UART_DM_MR1_AUTO_RFR_LEVEL1;
> +		data |= UART_DM_MR1_AUTO_RFR_LEVEL1 & (rfr_level << 2);
> +	} else {
> +		data &= ~UART_MR1_AUTO_RFR_LEVEL1;
> +		data |= UART_MR1_AUTO_RFR_LEVEL1 & (rfr_level << 2);
> +	}
> +
>  	data &= ~UART_MR1_AUTO_RFR_LEVEL0;
> -	data |= UART_MR1_AUTO_RFR_LEVEL1 & (rfr_level << 2);
>  	data |= UART_MR1_AUTO_RFR_LEVEL0 & rfr_level;
>  	msm_write(port, data, UART_MR1);
>  	return 0;

This could be written like so:

if (msm_port->is_uartdm)
	mask = UART_DM_MR1_AUTO_RFR_LEVEL1;
else
	mask = UART_MR1_AUTO_RFR_LEVE1;

data &= ~mask;
data &= ~UART_MR1_AUTO_RFR_LEVEL0;
data |= mask & (rfr_level << 2);
data |= UART_MR1_AUTO_RFR_LEVEL0 & rfr_level;

so that we don't duplicate the rfr_level << 2 part.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
