Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74E14A4E4
	for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096646; cv=none; b=R2piV0UmdAp2awdzyLfjyJw1sp9ONIZ+Z7ZtRvDqUgckrQ8uariTpN6JeySf9MKknnhctt0beLLTUMrpg4gm2/h5KxUutnh+WAnB543eyJq9KohInoigrhLkXZevcHyyTZ+xbJyUW1ofrt4Uhx719z4dy9iCxb/1YlaJJE0fxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096646; c=relaxed/simple;
	bh=c4Y77DzsyfHsAl+4rUIG/hJ7l+2EAUKx/17Pw1Uty8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfJMVHAp3l2GitOBgDpcoHnII87QX6Yc5jNF1QExNWc3hAkyB1da9dFoGpBUAVueQABtd//oBTPd8bRV5E7doZK+SOX7/Vt0OLg8EyGOWrD3HUNDdF7qmBdP0tbjY4Blduk7xxYjfQAd0cfPlzEFbBA8sLcEhxOVfkN5Hl9KmJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=lqEdExUM; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="lqEdExUM"
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 8682E87D66;
	Fri, 16 Feb 2024 16:17:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708096637;
	bh=11JafvA4+uzRF7MXkajWwtpAxYSGJpcOWG7iwu4DdZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lqEdExUMYtCaklxOcvXX3kd/nwa0JUrWmQkltr7krIzGGgoAwsSTcXDe7JpCOJEgw
	 6uVXNCRcf+YwSZibptBn/dOJcbNLnI7gcfgFwBllM2a5asRCCKyOgyG8/pk297P0Nv
	 kpEH3+oqawaLE1y3+54r6HYd0HkKQNo5iTxdMMB1TqiZ2FJXXlhXXXNXRiqBhceUX+
	 XxDk4Bur1aVz4zAlAeC+W4vX9uR7vt1i0yCAms2kIgTu0/LmxfcnB/Kcr/gFZodiIW
	 P2Hs52vmzyFuHljOJcNrLr9YmZKiCQlebqX80oDUPw2a56/ZNUYEcT7Mrch7GZ9bYB
	 lxFOMJlTJ5TFQ==
Message-ID: <e39a6ecd-1250-4889-99aa-31a5a219f6a5@denx.de>
Date: Fri, 16 Feb 2024 16:17:15 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: imx: Fix broken RS485
Content-Language: en-US
To: Rickard Andersson <rickaran@axis.com>, linux-serial@vger.kernel.org,
 rickard314.andersson@gmail.com, gregkh@linuxfoundation.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, martin.fuzzey@flowbird.group,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: kernel@axis.com
References: <20240216124601.3752039-1-rickaran@axis.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240216124601.3752039-1-rickaran@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/16/24 13:46, Rickard Andersson wrote:
> From: Rickard x Andersson <rickaran@axis.com>
> 
> When about to transmit the function imx_uart_start_tx is called and in
> some RS485 configurations this function will call imx_uart_stop_rx. The
> problem is that imx_uart_stop_rx will enable loopback and when loopback
> is enabled transmitted data will just be looped to RX.
> 
> This patch fixes the above problem by explicitly disabling loopback in
> the case described above.
> 
> Signed-off-by: Rickard x Andersson <rickaran@axis.com>

Fixes: tag is missing.

> ---
>   drivers/tty/serial/imx.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 4aa72d5aeafb..899e331bdfc8 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -683,8 +683,15 @@ static void imx_uart_start_tx(struct uart_port *port)
>   			imx_uart_writel(sport, ucr2, UCR2);
>   
>   			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX) &&
> -			    !port->rs485_rx_during_tx_gpio)
> +			    !port->rs485_rx_during_tx_gpio) {
>   				imx_uart_stop_rx(port);
> +				/*
> +				 * The function imx_uart_stop_rx right above
> +				 * will enable loopback, but since we are just
> +				 * about to transmit then disable loopback.
> +				 */
> +				imx_uart_disable_loopback_rs485(sport);
> +			}

Maybe it would be better to update the stop_rx and add parameter, 
whether it should/shouldn't enable the loopback ?
