Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0815A0F0
	for <linux-serial@vger.kernel.org>; Tue, 20 Feb 2024 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412585; cv=none; b=sA65kBHqSTjnl0BtSuoO8fBnzoUrZY3k/Pg9m2Ne92ptZSnc2KGR62oAPm6VnqR9mOFfOvoAzBXnd6YNy1Zm1PVDYDZLrnWBV70s1koKlaR1pZphcpMvi2Ap203W7lnaqdZWgfnVOk4nST/rC7+KmL8RG/m+hqYQigXoH8A/pg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412585; c=relaxed/simple;
	bh=scRdbpTg2fpIvo3mQk/wJJ8czxAFOJcLV7Iim4DY4Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZ4IFO1W0jJM5/oOaYkwCotyUoag9L5XoqQQJ1mTk/fE+zpUpsvpbsI+IRxUbi5XYpsvFCABGZUTbp9GrA49XnbA144i1kIvqoDVfxjbZqH4ilQVXGL3PvlmyCbpjL9g2wGBrCaL7O/CtY/jQ7qMtZeXOytNpGo+rP/8N7twp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=QvW0ErCC; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="QvW0ErCC"
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B169D87F5D;
	Tue, 20 Feb 2024 08:03:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708412581;
	bh=O6ah2ePEc1h2Txx06JZF2e4vZJj2My4E8bRISCatWDM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QvW0ErCCCUeJsK1bn06qidoEfa9FL/oXDbZDA9yw35pea1B5FNghKr9+WSs/JceBe
	 yppmYSkY4DGL2enpfWJw90muY5TjcT97bxLHjSiILGcmRODXtTusa5AuYJ9PUEGAsR
	 V4a+fmAgyAve+l8Ecoq8zsE4jQHRQOc/WkHduQwQlFJIIvvf74HnqlM/rT4in0VH8d
	 uz7WS7+tBBBGw06je+dC/yc1DqGqNuBh1lALvM5EUtyMyKm7sRwyURXzDM0u0RdKhU
	 aQy1FKf7+s0JQ3aPoBvVDl9HHqVGnkzPsCjhkaUuXW+BoyxuLtOXxJzE4XgL5sj3xx
	 cSrq94WDvg3ng==
Message-ID: <a80aa560-1b1c-417b-9b23-1234bacfe6c9@denx.de>
Date: Tue, 20 Feb 2024 07:53:04 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: serial: imx: Fix broken RS485
To: Rickard Andersson <rickaran@axis.com>, linux-serial@vger.kernel.org,
 rickard314.andersson@gmail.com, gregkh@linuxfoundation.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, martin.fuzzey@flowbird.group
Cc: kernel@axis.com, Christoph Niedermaier <cniedermaier@dh-electronics.com>
References: <20240220061243.4169045-1-rickaran@axis.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240220061243.4169045-1-rickaran@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/20/24 07:12, Rickard Andersson wrote:
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
> Fixes: 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")
> Signed-off-by: Rickard x Andersson <rickaran@axis.com>
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
>   
>   			sport->tx_state = WAIT_AFTER_RTS;
>   

+CC Christoph, I suspect he will comment on this soon-ish, we had an 
off-list discussion about this yesterday.
