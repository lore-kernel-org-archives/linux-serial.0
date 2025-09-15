Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2792D46AF;
	Mon, 15 Sep 2025 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921631; cv=none; b=EndEcJwCXLQC0liAvZd28DPQHi3DiaL6WrMrY+PJy82u2xg/fUPCoDh2Y5yyWW8k09R+z1cgxmQSWBSRPzMvlEGCQrMlZ4SkcqORqk4qswi9rOFzCLbqu97qjZTynudQroLosS4zI9YJt0R0/gNZ5nO2pnFq2EjDFggZvEkCWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921631; c=relaxed/simple;
	bh=CvSpZpuhDtzZdxfbopkSom4BlyFhn0H99cY81Z+ClJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iCZz2avD6lbekSACZe2v9BwQxj0sxGCXjh7guKMZf3MRj2PlxR0idNajCSFIoO56w0Su9C9dKI8rdzfYH7LqRKf9ZmP+qvMJOHkIRIVQBIgyJwnaoHCRdi3MLUraYFcLH4s/qkJRDS/Lw9THxRzPgCmnAXu8tE9jb5j5wcMvtgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PpNo0Gm0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PpNo0Gm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757921627;
	bh=CvSpZpuhDtzZdxfbopkSom4BlyFhn0H99cY81Z+ClJ4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PpNo0Gm0NGeq8BUqPEaE3VEteESp1T51bYoPqaOnH7v0WlIn2RZNrOED5yoZLgRWS
	 e1TFKJSQT5faQR8H3/9zZUn9MAypxIdcoqz4J+JPljcpa5IcQ9WOpYZTHYj9eIR6rk
	 yvitPSU5wIU9kNIrlI9EMBUsCqbpmxp0BLsCyOOVcEpKkhe6Ay2wVB7sox7L+EpBx8
	 jTsXFoH68PEU7dja1RyyC1g63aE+Po3RfQnADOAYE0hY/YXvfN1h/rmVxjtDE8Or7D
	 bnavYcMIvsHSxO1+qdnHpvZ5A+kCIg5tEOlgQt+wLJoKkMagR9yj1fHSYC4v6idDJb
	 wpCkaCbCfybyQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CD81C17E0AC3;
	Mon, 15 Sep 2025 09:33:46 +0200 (CEST)
Message-ID: <8b1c1796-6de2-4526-9a29-d8649141b878@collabora.com>
Date: Mon, 15 Sep 2025 09:33:46 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: 8250_mtk: enable baud clock
To: Daniel Golle <daniel@makrotopia.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Yu Jiaoliang <yujiaoliang@vivo.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Changqi Hu <changqi.hu@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Steven Liu <steven.liu@mediatek.com>, John Crispin <john@phrozen.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <5d6acd2273e3c98a5cbc685ad94eff19c6b6d044.1757807642.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <5d6acd2273e3c98a5cbc685ad94eff19c6b6d044.1757807642.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/09/25 01:59, Daniel Golle ha scritto:
> Some MediaTek SoCs got a gated UART baud clock, which currently gets
> disabled as the clk subsystem believes it would be unused. This results in
> the uart freezing right after "clk: Disabling unused clocks" on those
> platforms.
> 
> To fix this request the "baud" clock as enabled to prevent disabling it
> among with the unused clocks.
> Runtime power management can probably also be restored to the state before
> commit e32a83c70cf9 ("serial: 8250-mtk: modify mtk uart power and clock
> management"), but that isn't strictly needed to fix the regression
> introduced by that commit.
> 
> Fixes: e32a83c70cf9 ("serial: 8250-mtk: modify mtk uart power and clock management")
> Suggested-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Is there any particular reason why you didn't en/disable the uart_clk in
runtime PM ops?

Cheers,
Angelo

> ---
>   drivers/tty/serial/8250/8250_mtk.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index b44de2ed7413..9329ed1f759d 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -475,13 +475,13 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
>   	int dmacnt;
>   #endif
>   
> -	data->uart_clk = devm_clk_get(&pdev->dev, "baud");
> +	data->uart_clk = devm_clk_get_enabled(&pdev->dev, "baud");
>   	if (IS_ERR(data->uart_clk)) {
>   		/*
>   		 * For compatibility with older device trees try unnamed
>   		 * clk when no baud clk can be found.
>   		 */
> -		data->uart_clk = devm_clk_get(&pdev->dev, NULL);
> +		data->uart_clk = devm_clk_get_enabled(&pdev->dev, NULL);
>   		if (IS_ERR(data->uart_clk)) {
>   			dev_warn(&pdev->dev, "Can't get uart clock\n");
>   			return PTR_ERR(data->uart_clk);


