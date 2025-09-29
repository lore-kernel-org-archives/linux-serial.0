Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870534BA42;
	Mon, 29 Sep 2025 05:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125263; cv=none; b=X6yb3Bt1voewnhFLGDGW4yVgWYXS+6azBM46xfbx0w7KNv/mmjyFlg2pKPRBZbj6c0vpwGxRXYrWfxZ11ZqAIpYzsvWdt8BBg++r8KYUbHEgIowmIA6HH4Nt3blA1Idjrj9g/NAZCOlWi/D8K+FHENSvxgIVVq3rPIW1qk4X4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125263; c=relaxed/simple;
	bh=N5v74NFjIXjx1dRuy1O48U73EwpNUeMve4qTKRMd6H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgoMr1TTGVkvQ6zNmhJa2JdzFQ0KTyZXL0ouhAGHH6gi4ON480Pnn+Hi1jNkeULbNHh1rqDXiNVhfLjaNrBGWDHBeaU5/Z/rZ0hfQfL8dJGtp2gSmJEhgDSdh6iA0/IjrUrHLB2q50IHkwxA/CAITjrXVXVvGfHe+26kXHNg6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP2/wZT0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP2/wZT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC7FC4CEF4;
	Mon, 29 Sep 2025 05:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759125262;
	bh=N5v74NFjIXjx1dRuy1O48U73EwpNUeMve4qTKRMd6H0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LP2/wZT0WzI3vs+PlPl5MeZJtR+qSBRX+wQgK1+aQaDheb3xCLzt3tZCPBcntbmEQ
	 ETVyS7QRFoQ75A6AY4CH0N2eeD6RUP9RoHthh2+B7Szz8JCODFRfkHsDZXvU9BhHLJ
	 rSTZWM07opbVZt6T4lYdqaDq8WFbdbshnX/xN/IVmLz39ICP8bJ6cj7RPHkHxaCsWU
	 FNET8enD27Mnn7ms1vBEUScuMQC0b45n4tEzhi7JiffyZILB76+Z2MAufnFaZyxe/3
	 0E0QWx2Cdlt1sNW6EIrOqPdkkInpGVa8PBO+h0HtsfnR9Z2hS8xYUE99gTMiXk6/pn
	 dABGLg/UQ163Q==
Message-ID: <9b603e71-c0a1-46f3-93f2-dd31188dbeff@kernel.org>
Date: Mon, 29 Sep 2025 07:54:17 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] tty: serial: imx: Only configure the wake register
 when device is set as wakeup source
To: Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, shenwei.wang@nxp.com, peng.fan@nxp.com, frank.li@nxp.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20250925091132.2537430-1-sherry.sun@nxp.com>
 <20250925091132.2537430-2-sherry.sun@nxp.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250925091132.2537430-2-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25. 09. 25, 11:11, Sherry Sun wrote:
> Currently, the i.MX UART driver enables wake-related registers for all
> UART devices by default. However, this is unnecessary for devices that
> are not configured as wakeup sources. To address this, add a
> device_may_wakeup() check before configuring the UART wake-related
> registers.
> 
> Fixes: db1a9b55004c ("tty: serial: imx: Allow UART to be a source for wakeup")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/tty/serial/imx.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 500dfc009d03..87d841c0b22f 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2697,8 +2697,23 @@ static void imx_uart_save_context(struct imx_port *sport)
>   /* called with irq off */
>   static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>   {
> +	struct tty_port *port = &sport->port.state->port;
> +	struct tty_struct *tty;
> +	struct device *tty_dev;
> +	bool may_wake = false;
>   	u32 ucr3;
>   
> +	tty = tty_port_tty_get(port);
> +	if (tty) {

Use scoped_guard(tty_port_tty, port) instead.

> +		tty_dev = tty->dev;
> +		may_wake = tty_dev && device_may_wakeup(tty_dev);
> +		tty_kref_put(tty);
> +	}
> +
> +	/* only configure the wake register when device set as wakeup source */
> +	if (!may_wake)
> +		return;
> +
>   	uart_port_lock_irq(&sport->port);
>   
>   	ucr3 = imx_uart_readl(sport, UCR3);

thanks,
-- 
js
suse labs
