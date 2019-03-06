From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2] tty: xilinx_uartps: Correct return value in probe
Date: Wed, 6 Mar 2019 13:34:46 +0100
Message-ID: <0755f963-5f02-d5c7-57e8-d19e3dd2be7f@xilinx.com>
References: <1543927882-15091-1-git-send-email-rajan.vaja@xilinx.com>
 <1551433028-25207-1-git-send-email-rajan.vaja@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551433028-25207-1-git-send-email-rajan.vaja@xilinx.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rajan Vaja <rajan.vaja@xilinx.com>, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-kernel@vger.kernel.org, JOLLYS@xilinx.com, anirudh@xilinx.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 01. 03. 19 10:37, Rajan Vaja wrote:
> Existing driver checks for alternate clock if devm_clk_get() fails
> and returns error code for last clock failure. If xilinx_uartps is
> called before clock driver, devm_clk_get() returns -EPROBE_DEFER.
> In this case, probe should not check for alternate clock as main
> clock is already present in DTS and return -EPROBE_DEFER only.
> 
> This patch fixes it by not checking for alternate clock when main
> clock get returns -EPROBE_DEFER.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
> Changes in v2:
>   * Handle dynamic port allocation error cases
> ---
>  drivers/tty/serial/xilinx_uartps.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 094f295..f7ae73e 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1547,27 +1547,33 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  	}
>  
>  	cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (PTR_ERR(cdns_uart_data->pclk) == -EPROBE_DEFER) {
> +		rc = PTR_ERR(cdns_uart_data->pclk);
> +		goto err_out_unregister_driver;
> +	}
> +
>  	if (IS_ERR(cdns_uart_data->pclk)) {
>  		cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "aper_clk");
> -		if (!IS_ERR(cdns_uart_data->pclk))
> -			dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
> +		if (IS_ERR(cdns_uart_data->pclk)) {
> +			rc = PTR_ERR(cdns_uart_data->pclk);
> +			goto err_out_unregister_driver;
> +		}
> +		dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
>  	}
> -	if (IS_ERR(cdns_uart_data->pclk)) {
> -		dev_err(&pdev->dev, "pclk clock not found.\n");
> -		rc = PTR_ERR(cdns_uart_data->pclk);
> +
> +	cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "uart_clk");
> +	if (PTR_ERR(cdns_uart_data->uartclk) == -EPROBE_DEFER) {
> +		rc = PTR_ERR(cdns_uart_data->uartclk);
>  		goto err_out_unregister_driver;
>  	}
>  
> -	cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "uart_clk");
>  	if (IS_ERR(cdns_uart_data->uartclk)) {
>  		cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "ref_clk");
> -		if (!IS_ERR(cdns_uart_data->uartclk))
> -			dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
> -	}
> -	if (IS_ERR(cdns_uart_data->uartclk)) {
> -		dev_err(&pdev->dev, "uart_clk clock not found.\n");
> -		rc = PTR_ERR(cdns_uart_data->uartclk);
> -		goto err_out_unregister_driver;
> +		if (IS_ERR(cdns_uart_data->uartclk)) {
> +			rc = PTR_ERR(cdns_uart_data->uartclk);
> +			goto err_out_unregister_driver;
> +		}
> +		dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
>  	}
>  
>  	rc = clk_prepare_enable(cdns_uart_data->pclk);
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
