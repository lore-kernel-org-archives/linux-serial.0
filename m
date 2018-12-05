From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] tty: xilinx_uartps: Correct return value in probe
Date: Wed, 5 Dec 2018 13:53:57 +0100
Message-ID: <3245866d-d70b-5118-43c8-91811b1d3bbb@xilinx.com>
References: <1543927882-15091-1-git-send-email-rajan.vaja@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543927882-15091-1-git-send-email-rajan.vaja@xilinx.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rajan Vaja <rajan.vaja@xilinx.com>, gregkh@linuxfoundation.org, jslaby@suse.com, michal.simek@xilinx.com
Cc: linux-kernel@vger.kernel.org, jollys@xilinx.com, anirudh@xilinx.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 04. 12. 18 13:51, Rajan Vaja wrote:
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
>  drivers/tty/serial/xilinx_uartps.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 57c66d2..a23baa4 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1545,27 +1545,25 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  	}
>  
>  	cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (PTR_ERR(cdns_uart_data->pclk) == -EPROBE_DEFER)
> +		return PTR_ERR(cdns_uart_data->pclk);
> +
>  	if (IS_ERR(cdns_uart_data->pclk)) {
>  		cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "aper_clk");
> -		if (!IS_ERR(cdns_uart_data->pclk))
> -			dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
> -	}
> -	if (IS_ERR(cdns_uart_data->pclk)) {
> -		dev_err(&pdev->dev, "pclk clock not found.\n");
> -		rc = PTR_ERR(cdns_uart_data->pclk);
> -		goto err_out_unregister_driver;
> +		if (IS_ERR(cdns_uart_data->pclk))
> +			return PTR_ERR(cdns_uart_data->pclk);
> +		dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
>  	}
>  
>  	cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "uart_clk");
> +	if (PTR_ERR(cdns_uart_data->uartclk) == -EPROBE_DEFER)
> +		return PTR_ERR(cdns_uart_data->uartclk);
> +
>  	if (IS_ERR(cdns_uart_data->uartclk)) {
>  		cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "ref_clk");
> -		if (!IS_ERR(cdns_uart_data->uartclk))
> -			dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
> -	}
> -	if (IS_ERR(cdns_uart_data->uartclk)) {
> -		dev_err(&pdev->dev, "uart_clk clock not found.\n");
> -		rc = PTR_ERR(cdns_uart_data->uartclk);
> -		goto err_out_unregister_driver;
> +		if (IS_ERR(cdns_uart_data->uartclk))
> +			return PTR_ERR(cdns_uart_data->uartclk);
> +		dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
>  	}
>  
>  	rc = clk_prepare_enable(cdns_uart_data->pclk);
> 

Nack. This is the origin version before dynamic port allocation.
Please look at Xilinx version which has this feature already and it is
resolved there properly.

Thanks,
Michal
