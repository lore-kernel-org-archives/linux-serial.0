Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A0631A578;
	Mon, 15 Sep 2025 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943690; cv=none; b=n0uhwifUAsxd6igMLqZPSONCgOV25LedoZFNGfjM0k99zgpEHRcJ82iNRnPIYivUe3PvUFJcnerZpRqA6lZKpkfE0WGGdknPT95nj3f0wkEl5xEpF9YtRFcKDwMmO/9pq+nvsA7/2hZHT4O9xfMdyxew8SMcYqX7ErhMw8x/Ais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943690; c=relaxed/simple;
	bh=yxThJFjgk/onijRWZOMaM2BSfI+4eRYM4Vqmsvjq89Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V0tMQSbd9ZpQXIdwKl11WTp+zP7KZzAXAvlFDVqy3Wq64iKPgMpgodrxU3MHyxRmT1XK2/6k+0KvNK1YUnbS77Y43Z1DPZ+hqWBo5sLuh8TpLXbIt23h/wyBVgJ82KMZaNTCxrTNZURcLoOyo3aRaQjSjB58vSISHkJRj11z92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YegZ2WtT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YegZ2WtT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757943687;
	bh=yxThJFjgk/onijRWZOMaM2BSfI+4eRYM4Vqmsvjq89Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=YegZ2WtTwpGRE9vdewFKrn9fAnxENJApcYtpeJVlPUKl48EHfTejKzGcoy7IfKHSq
	 gSqdusiaSUTXqrKFZjqLYqggi3vjuHiFSLI7HzuGfU5MvG+wXVN/3rLs7rGAhBQPoF
	 EZw9Au7i5ZUsvh7S858i1ZUe6Vhj7EH8t6mlWNTVDhb0uL8zqwHu0bNWgCfGn0buX8
	 xqy4XeBN5e6SPq6+ox7nx1pZCqb2vYg622Gx56IfQWSgdMqY12GEvlCKegyiQ1xqrU
	 bs+UjakxTT/R1i76wEOet47SBBbtPicuhrxmwoFBXN7w29vPImDzBeHe/drIpnmo9Y
	 7lJKke7oypQTQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7FB0317E107A;
	Mon, 15 Sep 2025 15:41:26 +0200 (CEST)
Message-ID: <bf054186-17fb-4ea4-9d07-488b6792a437@collabora.com>
Date: Mon, 15 Sep 2025 15:41:25 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tty: serial: 8250_mtk: enable baud clock
To: Daniel Golle <daniel@makrotopia.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Yu Jiaoliang <yujiaoliang@vivo.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Changqi Hu <changqi.hu@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Steven Liu <steven.liu@mediatek.com>, John Crispin <john@phrozen.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <2de07b0a6d51d5d3bf3e55cd03cf75adfc91ee7d.1757941345.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2de07b0a6d51d5d3bf3e55cd03cf75adfc91ee7d.1757941345.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/09/25 15:06, Daniel Golle ha scritto:
> Some MediaTek SoCs got a gated UART baud clock, which currently gets
> disabled as the clk subsystem believes it would be unused. This results in
> the uart freezing right after "clk: Disabling unused clocks" on those
> platforms.
> 
> To fix this request the baud clock to be prepared and enabled during probe.
> 
> Fixes: e32a83c70cf9 ("serial: 8250-mtk: modify mtk uart power and clock management")
> Suggested-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Thanks for caring about power management. However, this and the addition in PM ops
should be a single commit. It's even using the same Fixes tag...! :-)

I've read both of the commits in this series and the code LGTM.


tty: serial: 8250_mtk: Enable baud clock and manage in runtime PM

Please, squash the two commits, after which...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

> ---
> v2: no changes
> 
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



