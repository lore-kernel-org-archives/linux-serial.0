Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3D126C0A;
	Wed,  4 Sep 2024 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436778; cv=none; b=px1f3QQIN8PfbpQLXj4Uoyf0frZsKG4ZcbvW3yc9WpY4Z7eL6SOU4zXe+5t3qK9IeZyxkOZijEF8+uaw/UG9ldvvftibP07To1Yu5Aul+NTYK6EESBDFvxvPnck5QeGQ1ysb4ogOPuuiw73VMobCmkHY+LSAiraJbTKIIvvcIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436778; c=relaxed/simple;
	bh=BP0nCOgd1IejjSvX8ei9VkQzdvNCnlCxlwBOLy/HWnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJiPw5qCaFN4+d3Pkzxo6SzTBmwoc5yqOvJDiB/9EJQz52ArIcOmouLXpIHFxl/V5X6eMCOb5JadbfaD3WmZbF8sfpOGupB72jIXXW/yazBMwxHIUaoC9DoiFwVURZ/7qV4Nk99Jg9v3fcniwlSYuSQZDsi3IwIriw1bPmQM8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fexDbFpr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fexDbFpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4F9C4CEC2;
	Wed,  4 Sep 2024 07:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725436777;
	bh=BP0nCOgd1IejjSvX8ei9VkQzdvNCnlCxlwBOLy/HWnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fexDbFpruT+1rluc6aaUvEYYPIK0WfU0S2JmpaIqNW012zyL3TAg6jklKXERu0OLp
	 n/+kbjhSAWWFcaQ70rYnb9ICjN8AFc+UHzeXqiKCS3putEqRP7MDNH6kh1N4BvZv79
	 w5HAmJBk19C67cxRJVmUxsMCnr+0Vl7lsd2Ui0cE=
Date: Wed, 4 Sep 2024 09:59:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: pic32_uart: Use devm for kasprintf and
 request_irq
Message-ID: <2024090418-precook-fringe-c8b4@gregkh>
References: <20240904055353.102273-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904055353.102273-1-zhangjiao2@cmss.chinamobile.com>

On Wed, Sep 04, 2024 at 01:53:53PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Use devm_kasprintf and devm_request_irq to simplify code.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  drivers/tty/serial/pic32_uart.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
> index 261c8115a700..0119a4d81521 100644
> --- a/drivers/tty/serial/pic32_uart.c
> +++ b/drivers/tty/serial/pic32_uart.c
> @@ -484,7 +484,7 @@ static int pic32_uart_startup(struct uart_port *port)
>  	 */
>  	sport->enable_tx_irq = false;
>  
> -	sport->irq_fault_name = kasprintf(GFP_KERNEL, "%s%d-fault",
> +	sport->irq_fault_name = devm_kasprintf(port->dev, GFP_KERNEL, "%s%d-fault",
>  					  pic32_uart_type(port),
>  					  sport->idx);
>  	if (!sport->irq_fault_name) {
> @@ -493,49 +493,49 @@ static int pic32_uart_startup(struct uart_port *port)
>  		goto out_disable_clk;
>  	}
>  	irq_set_status_flags(sport->irq_fault, IRQ_NOAUTOEN);
> -	ret = request_irq(sport->irq_fault, pic32_uart_fault_interrupt,
> +	ret = devm_request_irq(port->dev, sport->irq_fault, pic32_uart_fault_interrupt,
>  			  IRQF_NO_THREAD, sport->irq_fault_name, port);
>  	if (ret) {
>  		dev_err(port->dev, "%s: request irq(%d) err! ret:%d name:%s\n",
>  			__func__, sport->irq_fault, ret,
>  			pic32_uart_type(port));
> -		goto out_f;
> +		goto out_disable_clk;
>  	}
>  
> -	sport->irq_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
> +	sport->irq_rx_name = devm_kasprintf(port->dev, GFP_KERNEL, "%s%d-rx",
>  				       pic32_uart_type(port),
>  				       sport->idx);
>  	if (!sport->irq_rx_name) {
>  		dev_err(port->dev, "%s: kasprintf err!", __func__);
>  		ret = -ENOMEM;
> -		goto out_f;
> +		goto out_disable_clk;
>  	}
>  	irq_set_status_flags(sport->irq_rx, IRQ_NOAUTOEN);
> -	ret = request_irq(sport->irq_rx, pic32_uart_rx_interrupt,
> +	ret = devm_request_irq(port->dev, sport->irq_rx, pic32_uart_rx_interrupt,
>  			  IRQF_NO_THREAD, sport->irq_rx_name, port);
>  	if (ret) {
>  		dev_err(port->dev, "%s: request irq(%d) err! ret:%d name:%s\n",
>  			__func__, sport->irq_rx, ret,
>  			pic32_uart_type(port));
> -		goto out_r;
> +		goto out_disable_clk;
>  	}
>  
> -	sport->irq_tx_name = kasprintf(GFP_KERNEL, "%s%d-tx",
> +	sport->irq_tx_name = devm_kasprintf(port->dev, GFP_KERNEL, "%s%d-tx",
>  				       pic32_uart_type(port),
>  				       sport->idx);
>  	if (!sport->irq_tx_name) {
>  		dev_err(port->dev, "%s: kasprintf err!", __func__);
>  		ret = -ENOMEM;
> -		goto out_r;
> +		goto out_disable_clk;
>  	}
>  	irq_set_status_flags(sport->irq_tx, IRQ_NOAUTOEN);
> -	ret = request_irq(sport->irq_tx, pic32_uart_tx_interrupt,
> +	ret = devm_request_irq(port->dev, sport->irq_tx, pic32_uart_tx_interrupt,
>  			  IRQF_NO_THREAD, sport->irq_tx_name, port);
>  	if (ret) {
>  		dev_err(port->dev, "%s: request irq(%d) err! ret:%d name:%s\n",
>  			__func__, sport->irq_tx, ret,
>  			pic32_uart_type(port));
> -		goto out_t;
> +		goto out_disable_clk;
>  	}
>  
>  	local_irq_save(flags);
> @@ -557,15 +557,6 @@ static int pic32_uart_startup(struct uart_port *port)
>  
>  	return 0;
>  
> -out_t:
> -	free_irq(sport->irq_tx, port);
> -	kfree(sport->irq_tx_name);
> -out_r:
> -	free_irq(sport->irq_rx, port);
> -	kfree(sport->irq_rx_name);
> -out_f:
> -	free_irq(sport->irq_fault, port);
> -	kfree(sport->irq_fault_name);
>  out_disable_clk:
>  	clk_disable_unprepare(sport->clk);
>  out_done:
> -- 
> 2.33.0
> 
> 
> 
> 

You obviously did not test this patch, why not?

If you really want to do conversions to use devm, PLEASE PLEASE PLEASE
understand the api and how it works.  As it is, this patch is totally
broken and will cause crashes if applied.

Please only submit changes that you have actually tested, otherwise
things like this will happen.

greg k-h
