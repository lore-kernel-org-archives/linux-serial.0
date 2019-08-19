From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 10/14] serial: tegra: add support to use 8 bytes trigger
Date: Mon, 19 Aug 2019 21:29:15 +0100
Message-ID: <dda0d866-ae7a-8655-7b26-4c28249c0be8@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-11-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565609303-27000-11-git-send-email-kyarlagadda@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krishna Yarlagadda <kyarlagadda@nvidia.com>, gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, ldewangan@nvidia.com, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Shardar Shariff Md <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org


On 12/08/2019 12:28, Krishna Yarlagadda wrote:
> From: Shardar Shariff Md <smohammed@nvidia.com>
> 
> Add support to use 8 bytes trigger for Tegra186 SOC.
> 
> Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index 329923c..03d1d20 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -88,6 +88,7 @@ struct tegra_uart_chip_data {
>  	bool	support_clk_src_div;
>  	bool	fifo_mode_enable_status;
>  	int	uart_max_port;
> +	int	dma_burst_bytes;

I assume that this is a maximum, so why not say max_dma_burst_bytes?

>  };
>  
>  struct tegra_uart_port {
> @@ -933,7 +934,12 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
>  	 * programmed in the DMA registers.
>  	 */
>  	tup->fcr_shadow = UART_FCR_ENABLE_FIFO;
> -	tup->fcr_shadow |= UART_FCR_R_TRIG_01;
> +
> +	if (tup->cdata->dma_burst_bytes == 8)
> +		tup->fcr_shadow |= UART_FCR_R_TRIG_10;
> +	else
> +		tup->fcr_shadow |= UART_FCR_R_TRIG_01;
> +
>  	tup->fcr_shadow |= TEGRA_UART_TX_TRIG_16B;
>  	tegra_uart_write(tup, tup->fcr_shadow, UART_FCR);
>  
> @@ -1046,7 +1052,7 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
>  		}
>  		dma_sconfig.src_addr = tup->uport.mapbase;
>  		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> -		dma_sconfig.src_maxburst = 4;
> +		dma_sconfig.src_maxburst = tup->cdata->dma_burst_bytes;
>  		tup->rx_dma_chan = dma_chan;
>  		tup->rx_dma_buf_virt = dma_buf;
>  		tup->rx_dma_buf_phys = dma_phys;
> @@ -1325,6 +1331,7 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
>  	.support_clk_src_div		= false,
>  	.fifo_mode_enable_status	= false,
>  	.uart_max_port			= 5,
> +	.dma_burst_bytes		= 4,

Isn't it simpler to store the TRIG value here?

Jon

-- 
nvpublic
