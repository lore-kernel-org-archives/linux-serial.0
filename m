From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] tty: serial: 8250_mtk: Use PTR_ERR_OR_ZERO
Date: Sun, 27 Aug 2017 21:49:38 +0300
Message-ID: <a9a1bd05-cdcf-1273-9229-20b963a97128@gmail.com>
References: <1503815501-9205-1-git-send-email-himanshujha199640@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503815501-9205-1-git-send-email-himanshujha199640@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Himanshu Jha <himanshujha199640@gmail.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 08/27/2017 09:31 AM, Himanshu Jha wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>   drivers/tty/serial/8250/8250_mtk.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index ce0cc47..fb45770 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -171,10 +171,7 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
>   	}
>   
>   	data->bus_clk = devm_clk_get(&pdev->dev, "bus");
> -	if (IS_ERR(data->bus_clk))
> -		return PTR_ERR(data->bus_clk);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(data->bus_clk);
>   }
>   

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
