Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600215;
	b=CUhK4InLO5cBxIwiToS2zlwds/n+uUtMKigBD9MHCWc1KQtXD3t9Ecev7ubV8fcoeeog
	 Pdiwy+UnBszTpE6QukMuU5FkhDKhQY8sg8fpYyc80k80f9azt87mLpYInoevzWhBjWTa+
	 n7eBusRQdMLz3OvPuzFTFpfhAh0v8tw2PKRN9WK4pb/U/WuaM1B4SE51Uop3/ghQqx2GD
	 CJgS/EKX5+E512c3eSsiVzqXZlqBXC5bcseH7uf2Ajd67LFrO68F5DBwlAGNEwYCYZAnj
	 BtyNViSrI+2nuD0NboHwuE+nGvFT2BeorH1hcew2EZa5afqW5PeP/x/bK6vha0O4iGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600215;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=G2Z4BXXxGmGeisBjYmhaiDRUECEdjrVKtWcBVKsZ7eM=;
	b=T0Wqw2aK7xst0o1nzhXRGQL1ZZD9/Bvj19Zd8wxqyVUKt8hz9KIDVhyrIg37q/bWPIFL
	 ljBm2juOt6fsIA/HUr24X8e8dYiijzoJO1PTrBObuiWQdjcSZpq/KHj7EIqFmW1wShJK8
	 JS7RwNhNGbNXOf+nIXugigXEV73qQMcJKlBlXkozeVNSzqfO7hrkNAAVEZHOTLPoZil/Y
	 Q3q768uiAo1E7SrYOPZ9Gh9zKkXwt79hqddPBCyhc95kf3KE2Ldhjhop5I+/vHYk5hsP8
	 ASWvCzY8+ZZP57xC6twotkY5cw6hAWLRmV2mcCH6C1p1pyJPI9/anNt5EsE1RiKLj0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=DshtSLZq;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE59606A333;
	Fri, 13 Nov 2026 20:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EE59606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=DshtSLZq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=G2Z4BXXxGmGeisBjYmhaiDRUECEdjrVKtWcBVKsZ7eM=; b=DshtSLZqeDsgD8rAvcDqn3SMDt
	bSLeGYqi/x2sc0BKozFbASSrYtWQN38w1gKvQTQHK8ZqNbTPdDXTFP5DXV7wQL8NOa5BIgfq0UjS0
	+5tvHUT15o/aDtSN5IqNOuz9hHjvdS10ctqvcGHBJ07J+1+w4iYbRWkkvb0SUsVs3OLs=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xRxUi-000000002aq-1ZAC;
	Fri, 13 Nov 2026 15:03:32 -0500
Date: Fri, 13 Nov 2026 15:03:31 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: sc16is7xx: Fix clock leak on invalid clock
 frequency
Message-Id: <20261113150331.0133a3b8601bcb64b6536ef8@hugovil.com>
In-Reply-To: <20261113103855.2144-1-laixiangwu@cmss.chinamobile.com>
References: <20261113103855.2144-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi,

On Fri, 13 Nov 2026 18:38:54 +0800
Xiangwu Lai <laixiangwu@cmss.chinamobile.com> wrote:

> sc16is7xx_probe() enables the clock with clk_prepare_enable() early
> in the probe path.  If the resulting clock frequency cannot be
> determined (neither from the clock itself, nor from the
> "clock-frequency" property or platform data), the driver bails out
> with -EINVAL, but it does so with a plain return, leaving the clock
> prepared and enabled.
> 
> Switch to devm_clk_get_optional_enabled(), which drops the clock
> reference and disables the clock automatically when the probe fails
> and when the device is removed.  The manual clock management is no
> longer needed: drop clk_prepare_enable(), the out_clk label and the
> clk_disable_unprepare() call in sc16is7xx_remove().
> 
> Fixes: cb1b206cff46 ("serial: sc16is7xx: Use devm_clk_get_optional()")
> Suggested-by: Hugo Villeneuve <hugo@hugovil.com>
> Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>


> ---
> Changes in v2:
> 
> - Rework the patch following Hugo Villeneuve's suggestion: switch to
>   devm_clk_get_optional_enabled() so the clock is disabled
>   automatically on probe failure and on remove, and remove the now
>   unneeded manual clock management (clk_prepare_enable(), the
>   out_clk label and the clk_disable_unprepare() call in
>   sc16is7xx_remove()).  The -EINVAL path keeps its original plain
>   return since devm handles the cleanup.
> 
> Link: https://lore.kernel.org/all/20261030085508.1882-1-laixiangwu@cmss.chinamobile.com
>  drivers/tty/serial/sc16is7xx.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index fba588559..a69b71fb8 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1605,14 +1605,10 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  		dev_dbg(dev,
>  			"No interrupt pin definition, falling back to polling mode\n");
>  
> -	s->clk = devm_clk_get_optional(dev, NULL);
> +	s->clk = devm_clk_get_optional_enabled(dev, NULL);
>  	if (IS_ERR(s->clk))
>  		return PTR_ERR(s->clk);
>  
> -	ret = clk_prepare_enable(s->clk);
> -	if (ret)
> -		return ret;
> -
>  	freq = clk_get_rate(s->clk);
>  	if (freq == 0) {
>  		if (uartclk)
> @@ -1631,10 +1627,9 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  	kthread_init_worker(&s->kworker);
>  	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
>  				      "sc16is7xx");
> -	if (IS_ERR(s->kworker_task)) {
> -		ret = PTR_ERR(s->kworker_task);
> -		goto out_clk;
> -	}
> +	if (IS_ERR(s->kworker_task))
> +		return PTR_ERR(s->kworker_task);
> +
>  	sched_set_fifo(s->kworker_task);
>  
>  	ret = sc16is7xx_reset(dev, regmaps[0]);
> @@ -1711,9 +1706,6 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  out_kthread:
>  	kthread_stop(s->kworker_task);
>  
> -out_clk:
> -	clk_disable_unprepare(s->clk);
> -
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(sc16is7xx_probe);
> @@ -1740,8 +1732,6 @@ void sc16is7xx_remove(struct device *dev)
>  
>  	kthread_flush_worker(&s->kworker);
>  	kthread_stop(s->kworker_task);
> -
> -	clk_disable_unprepare(s->clk);
>  }
>  EXPORT_SYMBOL_GPL(sc16is7xx_remove);
>  
> -- 
> 2.50.1.windows.1
> 
> 
> 
> 


-- 
Hugo Villeneuve
