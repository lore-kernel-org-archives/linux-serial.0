Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109796;
	b=vSaTHyRMzzCjLX7dUGV2j+5rVagWyFK61v5cn2sokrTjXUiHlvRuZyGwH6N2iMwKClB7
	 PE19l3nSyFS/nPIFUA30atR9DmowUHKJM7SrkeLWEdcVqd+LULMxSnECwxO5R3QSdH9lZ
	 /b0PwQHlvXLmePGYFxLJ4lRkp4xfXOxAxRFYbwV+yAV04IxZXE9TvqQ71svecHF7gPkjv
	 doBTamZZgWHOQ3J+yua0+ujO8iAyUAAZD990PnmYPfdBftaY+AMf8KVOs/dZ679LgHMR6
	 awmmrXINK4hu/uFFKBa3LRRySP57t9zYXtjdTp4V/ie4Bpt9zze8oKXdsG3BvBLMs8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109796;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=NlAzr7fWQr1U0Gulks6WKzHQMsNptqrzzhjevUlp8lI=;
	b=LH5Kga2ggmn7Z83/R2oRAmXRtwQGMyFFiO0cl7jUDj2ReYkohTkiHtfeQnC96pH6jZow
	 6KCGQ1bNkkDQkuUa/8JIGaEwOENex1JrZ2VmAujEmLAmmNyF+wADnmkMz2GUHqmYMHs0u
	 KI68TdkHTXW3I84BIESNgyQ+NKz39zHTPaf2JsBXKOjKdQkCAAq5TNfcTdW7ArEvOYrzJ
	 bvtE97LOy9cAif01qe64d2nV5iJ6eoQ48IBgFcM8L0xgSeg1kinrj3MYMVZ3crbNwa1E/
	 IrQ+pWY7M6vECvp/FVFasq1pfEhqN3d72PREGfryinPlVx5tv/LvsNE4G/RHTi6QlCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=QxRzeFGH;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ED8606A320;
	Thu, 19 Nov 2026 17:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4ED8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=QxRzeFGH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=NlAzr7fWQr1U0Gulks6WKzHQMsNptqrzzhjevUlp8lI=; b=QxRzeFGH03QT8XbituAtp07GdR
	x2pyhJNY+Mfpcyeyuk0PgNNbizhSHidnvGrImQ5y0sP/Z7bFjbZGhDp3ZdfZepZTFI6IKdEZdEGOi
	v7eK9vWvsmv2gnBNTLjVI1skC9WNf5oqUCaVF63E00UoMNPtM7Is+M79yp1hBarhMLFk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xU63d-0000000030J-1iaR;
	Thu, 19 Nov 2026 12:36:25 -0500
Date: Thu, 19 Nov 2026 12:36:24 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Jiri Slaby <jirislaby@kernel.org>, Joachim Knorr
 <joachim.knorr@ziehl-abegg.de>, Luca Fresi <luca.fresi@bithiatec.com>,
 Martin Fuzzey <martin.fuzzey@flowbird.group>, Paul Mbewe
 <paultyson.mbewe@ziehl-abegg.de>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@baylibre.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: Use devm_clk_get_optional_enabled()
 in sc16is7xx_probe()
Message-Id: <20261119123624.500417c134528c090661efe1@hugovil.com>
In-Reply-To: <1333a82f-d074-487b-b3ad-c1a3496b312b@web.de>
References: <1333a82f-d074-487b-b3ad-c1a3496b312b@web.de>
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

Hi Markus,

On Thu, 19 Nov 2026 18:12:33 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 19 Nov 2026 18:04:56 +0100
> 
> Reuse existing functionality from devm_clk_get_optional_enabled()
> instead of keeping duplicate source code.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/tty/serial/sc16is7xx.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index dbf38825a78c..3af8ea93b34a 100644
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

Nak, your patch is incomplete and in fact just duplicates, in part,
what Xiangwu's patch does:

https://lore.kernel.org/all/20261113103855.2144-1-laixiangwu@cmss.chinamobile.com/


-- 
Hugo Villeneuve
