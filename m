Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775758;
	b=at/Er8WvM/6YZDa7dNsWfWgncQ6qYMv5dA/Bc2ciZtVxPpNynlMW1uNnJZ6xLiFbIP8a
	 ym6+yCv63qKIUKQW8tnrRjoyW1d5P7Hr3VZOb6uti/HFs2DOmFPJqR5PQzbm1HV9N8NYO
	 IMtFc29guTuPk9I+IQ1Nq41LnxuNFyr/fcT6UxUOovWs0AqDKvnkvNLsAxvgjiRUH0WMw
	 LJHPvOUf6z9+ZV+tNaFAdgoodKxbvNGZnU/M22q615wYU3/4TRvFm7PIbX3ULANGfGRxX
	 3QvAJlf9vVPSHL0TmK8OPtQX9KeIvGPuThU9BcY2uChaIcRmf+spSa6LGqmFfU4gncQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775758;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=K6s4lOO67MxeZ2kZUNjXsFE143gts4Ntp0bKcxeuWXY=;
	b=VtVhrXrrLWK7l4lmdyj+FP16BwOoei4L8YDDmsIIW+rtNqmNrJSpEgttqtlQIkiZVA3s
	 bouIoX8jpXkInCjSt/slNmUkP0Px5HgHwAEpqbO5FjGsJeOxaHiavXlAJ1CFc6ihLdbmF
	 z+n7NZIyxLc5xJtAfT7Whi41p1MrUhYddPTZj6Kj0fX4FQEP/7WMRjKgC8keF9vCOMAUB
	 pHlhW9CMg5JVH/bKcj/sE50LUZ3d1TkcAtc7W8E/TQAeMr3tGcl1UPtxJGOxAQG0I2xa5
	 yWR5tiQ6Xfop+CqIosKHPvBjd99eMt6A0V0yf6psaf7y/GzmrYc5798rtB9Oqp+OzAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AG1CIAct;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD85F606A31B
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AG1CIAct
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE0E1F000C1;
	Wed,  4 Nov 2026 07:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793775757;
	bh=K6s4lOO67MxeZ2kZUNjXsFE143gts4Ntp0bKcxeuWXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AG1CIActR9mqZ3w7p9KYrxKCyFEr07K9s8Tg1edd/dvBLQUpgRWNwIDLZmHr8hA0J
	 youonnsgIg2Jkkzj0hrbrDzKYT2+i6+gDyEu+m9rEUipKE2RyuG9YOoPrAkQoY48xM
	 SpjYSFIHsTahiE3pY7cu6jozUJdocbhKpPFpkwJ3WlG1QJgqXA1fzgKlgq4b6Xwlfq
	 lZN35CWk/yWdzf8Ny9E9agNJNcwRm5t4leHbXG822DMkmdWsmrQZ+rVCQFkB5Hp/2K
	 EpLOT2V5KDUGE0unr/Kl/ojYujSFTm6ZwD7BNBGyFobdEAKUh6W2PS8OeXbTTrJSyX
	 k8ZTksvnEurCw==
Message-ID: <5b741c90-4e57-425e-b3ef-b8d10eac1f33@kernel.org>
Date: Wed, 4 Nov 2026 08:02:33 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: meson: unregister the UART driver if port
 registration fails
To: Wentao Liang <vulab@iscas.ac.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20261104021501.1468500-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20261104021501.1468500-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04. 11. 26, 3:15, Wentao Liang wrote:
> meson_uart_probe() registers the shared uart_driver on the first port and
> relies on meson_uart_remove() to unregister it once the last port is
> removed.  If uart_add_one_port() fails, probe returns an error, so remove
> is never called and the driver stays registered, leaking its tty driver
> and per-port state.
> 
> Remember whether this probe registered the driver and unregister it again
> when adding the port fails.
> 
> Fixes: e71aab9d6132 ("tty: serial: meson: apply ttyS devname instead of ttyAML for new SoCs")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

makes sense to me:
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


> ---
>   drivers/tty/serial/meson_uart.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index a6cb2a535f9d..a51362f73dee 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -702,6 +702,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	int ret = 0;
>   	int irq;
>   	bool has_rtscts;
> +	bool registered = false;
>   
>   	if (pdev->dev.of_node)
>   		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
> @@ -753,6 +754,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>   		if (ret)
>   			return dev_err_probe(&pdev->dev, ret,
>   					     "can't register uart driver\n");
> +		registered = true;
>   	}
>   
>   	port->iotype = UPIO_MEM;
> @@ -781,8 +783,11 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	}
>   
>   	ret = uart_add_one_port(uart_driver, port);
> -	if (ret)
> +	if (ret) {
>   		meson_ports[pdev->id] = NULL;
> +		if (registered)
> +			uart_unregister_driver(uart_driver);
> +	}
>   
>   	return ret;
>   }


-- 
js
suse labs
