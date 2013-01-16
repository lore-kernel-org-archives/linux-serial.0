From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -next] serial: xilinx_uartps: fix return value check in
 xuartps_probe()
Date: Tue, 15 Jan 2013 23:07:07 -0800
Message-ID: <20130116070707.GA18089@kroah.com>
References: <CAPgLHd-upT_0ThHxU9rXtsw6CP4vU8zvOnLp6u0ZC_2unpDbTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:36845 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932074Ab3APHGI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 02:06:08 -0500
Content-Disposition: inline
In-Reply-To: <CAPgLHd-upT_0ThHxU9rXtsw6CP4vU8zvOnLp6u0ZC_2unpDbTw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: alan@linux.intel.com, jslaby@suse.cz, grant.likely@secretlab.ca, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Sun, Dec 02, 2012 at 05:12:43AM -0500, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, function of_clk_get() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> 
> ---
>  drivers/tty/serial/xilinx_uartps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 2be22a2..1eb4657 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -948,9 +948,9 @@ static int xuartps_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  
>  	clk = of_clk_get(pdev->dev.of_node, 0);
> -	if (!clk) {
> +	if (IS_ERR(clk)) {
>  		dev_err(&pdev->dev, "no clock specified\n");
> -		return -ENODEV;
> +		return PTR_ERR(clk);
>  	}

This patch doesn't apply at all to my tree, what am I doing wrong?

greg k-h
