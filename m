Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794519558;
	b=KlnWoF6G09UTNCgdAm/qtFcv0xhQGr4jGJv6/aEeXVjAf/bXzh0wzPhyyfc4qzblhjRu
	 U/kHUO3l7ySt5z5hd6Anl+iBVlFnCQoLXKGuCQTAzuLwhVBtLLRjLaG+RAaDwl05Q/yK+
	 pOKNNfAxL3cN2NP6D7KOgq+hd8gjK0usxOa8rBrX3wcockSDOwQHb6O6NMFMe6ak7oaHg
	 Zp1yTAB0AzmSi2kRjBa99r91Jl4npxLCuTw4DBpYyA8AzTv9/FrmXtbTWoGmKzkAN+Bek
	 WSLK/sakB8cKN0Ubmqam3Hz2MDflw+5kHG0CkNqnksFSvM1hkU+rq4ZYRTA//iBikEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519558;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=0l4Ddv0Qq4PeCpDiN8HnNb7+aLcX9n7N17yHgGZ7be4=;
	b=jW0sEDW7D7MkV6m9XuFlN9af1hyGg4fHmhs2FByxYUnBhs1W1QtOyuj0JQiwchOcyP9M
	 kLtdtc+SuVnJw5aM31zsHIXgS2eKPY0PbFQTYXEGLrMASuxxhhk03+GLiYWT/hoLp8Q6e
	 CtTbKwnt/6f2C8uGWFQafQSvDFVbrwj0P3wW3HnZfCTJSe3o8VK/R34tLnTBwbXS+sHn9
	 JvlXg7WLaEtb/XsCMdfTxDa8b4ZKLiLGJTPSGmFJR0Vq5G8sCgMKwMyNJpd65UF/m8eln
	 HWBgi2P6drpgVeadOj7Fsf9kXn34N7kFQoXMfCkuSXUhdQMN9J2dGbA7idIXLDopBzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=sKplMN7T;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970E606A31C;
	Thu, 12 Nov 2026 21:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3970E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=sKplMN7T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=0l4Ddv0Qq4PeCpDiN8HnNb7+aLcX9n7N17yHgGZ7be4=; b=sKplMN7TIyeyvJOliWjD0kDj6n
	6czfO7PCdga1MNo4ymteZmZa1kuii9VYr/R7X3vaHtHsNxUT9BIbwbvdMahDKGuYQ0X+4W+Hl+ZI9
	ckulUkSpNY+1RK9e3gSCY+YxOsxcYmjYEEeeVVEQQ/dG78Talc237wm6uTuKqFnTNrpk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xRcVo-000000001Xr-23tP;
	Thu, 12 Nov 2026 16:39:16 -0500
Date: Thu, 12 Nov 2026 16:39:16 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: laixiangwu <laixiangwu@cmss.chinamobile.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: Fix clock leak on invalid clock
 frequency
Message-Id: <20261112163916.00d07adafb3caad1d83a2d1c@hugovil.com>
In-Reply-To: <20261030085508.1882-1-laixiangwu@cmss.chinamobile.com>
References: <20261030085508.1882-1-laixiangwu@cmss.chinamobile.com>
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

On Fri, 30 Oct 2026 16:55:07 +0800
laixiangwu <laixiangwu@cmss.chinamobile.com> wrote:

> sc16is7xx_probe() enables the clock with clk_prepare_enable() early in
> the probe path. If the resulting clock frequency cannot be determined
> (neither from the clock itself, nor from the "clock-frequency" property
> or platform data), the driver bails out with -EINVAL, but it does so
> with a plain return, leaving the clock prepared and enabled.
> 
> All the later error paths of the probe already jump to the out_clk
> label to disable the clock. Do the same here.
> 
> Fixes: cb1b206cff46 ("serial: sc16is7xx: Use devm_clk_get_optional()")
> Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index fba588559..e464c6d72 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1619,10 +1619,12 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  			freq = uartclk;
>  		if (pfreq)
>  			freq = *pfreq;
> -		if (freq)
> +		if (freq) {
>  			dev_dbg(dev, "Clock frequency: %luHz\n", freq);
> -		else
> -			return -EINVAL;
> +		} else {
> +			ret = -EINVAL;
> +			goto out_clk;
> +		}
>  	}
>  
>  	s->devtype = devtype;
> -- 

You can probably switch to using devm_clk_get_optional_enabled(),
to simplify and completely get rid of the goto and out_clk label?

Something along:


-       s->clk = devm_clk_get_optional(dev, NULL);
+       s->clk = devm_clk_get_optional_enabled(dev, NULL);
        if (IS_ERR(s->clk))
                return PTR_ERR(s->clk);
 
-       ret = clk_prepare_enable(s->clk);
-       if (ret)
-               return ret;
-
        freq = clk_get_rate(s->clk);
        if (freq == 0) {
                if (uartclk)
@@ -1631,10 +1627,8 @@ int sc16is7xx_probe(struct device *dev, const
struct sc16is7xx_devtype *devtype, kthread_init_worker(&s->kworker);
        s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
                                      "sc16is7xx");
-       if (IS_ERR(s->kworker_task)) {
-               ret = PTR_ERR(s->kworker_task);
-               goto out_clk;
-       }
+       if (IS_ERR(s->kworker_task))
+               return PTR_ERR(s->kworker_task);
+
        sched_set_fifo(s->kworker_task);
 
        ret = sc16is7xx_reset(dev, regmaps[0]);
@@ -1711,9 +1705,6 @@ int sc16is7xx_probe(struct device *dev, const
struct sc16is7xx_devtype *devtype, out_kthread:
        kthread_stop(s->kworker_task);
 
-out_clk:
-       clk_disable_unprepare(s->clk);
-
        return ret;
 }
 EXPORT_SYMBOL_GPL(sc16is7xx_probe);
@@ -1740,8 +1731,6 @@ void sc16is7xx_remove(struct device *dev)
 
        kthread_flush_worker(&s->kworker);
        kthread_stop(s->kworker_task);
-
-       clk_disable_unprepare(s->clk);
 }
 EXPORT_SYMBOL_GPL(sc16is7xx_remove);
 
-- 
Hugo Villeneuve
