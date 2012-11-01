From: Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH -next] tty: of_serial: fix return value check in of_platform_serial_setup()
Date: Thu, 1 Nov 2012 10:00:00 -0400
Message-ID: <50928060.3010806@ti.com>
References: <CAPgLHd--dWeXNH_QVU34afv5Q1ju2MZJcwLKwyRr89+RvOTOBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56015 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756011Ab2KAOAV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Nov 2012 10:00:21 -0400
In-Reply-To: <CAPgLHd--dWeXNH_QVU34afv5Q1ju2MZJcwLKwyRr89+RvOTOBw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, seth.heasley@intel.com, yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On 11/01/2012 01:27 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function clk_get() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().
>
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>   drivers/tty/serial/of_serial.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> index 533ccfe..b9fdccb 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -66,10 +66,10 @@ static int __devinit of_platform_serial_setup(struct platform_device *ofdev,
>   
>   		/* Get clk rate through clk driver if present */
>   		info->clk = clk_get(&ofdev->dev, NULL);
> -		if (info->clk == NULL) {
> +		if (IS_ERR(info->clk)) {
>   			dev_warn(&ofdev->dev,
>   				"clk or clock-frequency not defined\n");
> -			return -ENODEV;
> +			return PTR_ERR(info->clk);
I think this is wrong. it should return -ENODEV;
Murali
>   		}
>   
>   		clk_prepare_enable(info->clk);
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

