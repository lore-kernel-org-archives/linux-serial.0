From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH -next] tty: of_serial: fix return value check in of_platform_serial_setup()
Date: Thu, 15 Nov 2012 12:08:11 +0000
Message-ID: <20121115120811.B9EB63E0B12@localhost>
References: <CAPgLHd--dWeXNH_QVU34afv5Q1ju2MZJcwLKwyRr89+RvOTOBw@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48664 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993257Ab2KOMIQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 07:08:16 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so776581wgb.1
        for <linux-serial@vger.kernel.org>; Thu, 15 Nov 2012 04:08:15 -0800 (PST)
In-Reply-To: <CAPgLHd--dWeXNH_QVU34afv5Q1ju2MZJcwLKwyRr89+RvOTOBw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, alan@linux.intel.com, gregkh@linuxfoundation.org, rob.herring@calxeda.com, seth.heasley@intel.com, stable@kernel.org
Cc: yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Thu, 1 Nov 2012 13:27:34 +0800, Wei Yongjun <weiyj.lk@gmail.com> wrote:
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

Looks correct to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Alan, which tree should this go through?

Wei, did you run into this causing a bug? Do you think it should go back
into linux-stable? It looks like it should to me.

g.

> ---
>  drivers/tty/serial/of_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> index 533ccfe..b9fdccb 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -66,10 +66,10 @@ static int __devinit of_platform_serial_setup(struct platform_device *ofdev,
>  
>  		/* Get clk rate through clk driver if present */
>  		info->clk = clk_get(&ofdev->dev, NULL);
> -		if (info->clk == NULL) {
> +		if (IS_ERR(info->clk)) {
>  			dev_warn(&ofdev->dev,
>  				"clk or clock-frequency not defined\n");
> -			return -ENODEV;
> +			return PTR_ERR(info->clk);
>  		}
>  
>  		clk_prepare_enable(info->clk);
> 
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
