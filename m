Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30242F23;
	Thu,  8 Aug 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102290; cv=none; b=rb7pFXSlUxyD9X7TzXtu7s9bGDC8wCMrxSL73ON26zyyRsgsExvVD8cyK1Vv4AzZbXq/P7C26II833/5LZxcmVEqcsha+Vop3Mk6cw196a686jo6V2qDNNdJ0bQOHgEk7JkhL4C9QsA9NmxOwUKXmnta9qURrx0SuXKp5nNHYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102290; c=relaxed/simple;
	bh=bBIpJNc2pO4tu95IBDbY0/YhHLZIFPk+R8FGA5Hud68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9RSepotkXftCELvvZxBLyzyVFlkmFlxJ9FwY2HqnlkUZ6fbc/Drhoy4vofJmRF0+hpM4Y+8t+gD9r6LKMg8LgE5ewYFAgAmQLqQn4QduZVmrHIA5JfXZ7MmlaodUMYl5qSPLQPpL2z8BOooNcJROKDuBMocDZcLMoOBkxvp7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so1334655e87.0;
        Thu, 08 Aug 2024 00:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723102287; x=1723707087;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Gszn4bTEcR0D4FRrJZtWUth+w4ELc3I3pKmXqIK+nY=;
        b=kO3yRrTJm5ArKv+88Ggpc1GhtdGmRiWMPgUj0+pyO+kKLu6IsTNDqkMO8ciWF6OY7U
         ZWBnX4Ym5T3DQL55EZ5G64/FGcJr4MRm9OuOcyW7Z5YsC2wyfCSNgSe4rUrDYxgzHW8z
         qtugQK4XSkfKBashTIdl6/YllVS6ldTPw3VtYckhZxFStyMfi1T/klnt+YnPKbx1zV4v
         IgDfhRA7kQcGp3kx4HFkEv7QAYMnkVgVL+hKxqCsf6oXbVV3osJHU3n+YN2TYhu8s0I+
         YTJMPrDaAXa8+C5OtzTRXGeak8R7qrOjHFgt85dXnzM7HL0YVYF+yBEoG1jLKW5d0ifC
         lstQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2GBt2KYUQriYlRULVAXiDVi/SosxBKdKpnAxkNsdxKPAxLTNMi5HAMnERJjRKnWlW3ItVa/PE9ha/Alg9TqT7o1KOS/ZaijGhVp9ngtK4eXYeHKPp2UbyQ2k+6HZYxLgLrSHKjHdF01/as2gEFy0ZAXQjDvyciLyDkdMhS2jIulfEVgbGE0EZ0ta+YrI=
X-Gm-Message-State: AOJu0YztfGNTwKreto0sAHgeLRlLlwU+YtGzK1uZANg4n9UNkgTvTol3
	QosFIUA1KInSvrS24Lsd91wZbXLkjEIREU2wrf1Z/zbQ1I+0nryg
X-Google-Smtp-Source: AGHT+IEZy/a/MqdksQQcam9t4oDsMY2JYY1I1etnpQV8uVPdJTZsT4Uvwjk1xr7Td1B0Jh9dvLOFBQ==
X-Received: by 2002:a05:6512:3e1d:b0:52c:deb9:904b with SMTP id 2adb3069b0e04-530e58769c5mr882431e87.38.1723102286668;
        Thu, 08 Aug 2024 00:31:26 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec285bsm706758666b.188.2024.08.08.00.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 00:31:26 -0700 (PDT)
Message-ID: <65ce2214-dad5-4a73-8806-07aab5404cf8@kernel.org>
Date: Thu, 8 Aug 2024 09:31:24 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tty: serial: samsung_tty: cast the interrupt's
 void *id just once
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240807-samsung-tty-cleanup-v2-0-1db5afc9d41b@linaro.org>
 <20240807-samsung-tty-cleanup-v2-2-1db5afc9d41b@linaro.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240807-samsung-tty-cleanup-v2-2-1db5afc9d41b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07. 08. 24, 13:58, André Draszik wrote:
> The interrupt handler routines and helpers are casting the 'void *'
> pointer to 'struct exynos_uart_port *' all over the place.
> 
> There is no need for that, we can do the casting once and keep passing
> the 'struct exynos_uart_port *', simplifying the code and saving a few
> lines of code.
> 
> No functional changes.
...
> @@ -944,17 +939,17 @@ static irqreturn_t s3c24xx_serial_tx_irq(void *id)
>   /* interrupt handler for s3c64xx and later SoC's.*/
>   static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
>   {
> -	const struct s3c24xx_uart_port *ourport = id;
> -	const struct uart_port *port = &ourport->port;
> +	struct s3c24xx_uart_port *ourport = id;
> +	struct uart_port *port = &ourport->port;
>   	u32 pend = rd_regl(port, S3C64XX_UINTP);
>   	irqreturn_t ret = IRQ_HANDLED;
>   
>   	if (pend & S3C64XX_UINTM_RXD_MSK) {
> -		ret = s3c24xx_serial_rx_irq(id);
> +		ret = s3c24xx_serial_rx_irq(ourport);
>   		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_RXD_MSK);
>   	}
>   	if (pend & S3C64XX_UINTM_TXD_MSK) {
> -		ret = s3c24xx_serial_tx_irq(id);
> +		ret = s3c24xx_serial_tx_irq(ourport);
>   		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_TXD_MSK);
>   	}
>   	return ret;
> @@ -963,19 +958,19 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
>   /* interrupt handler for Apple SoC's.*/
>   static irqreturn_t apple_serial_handle_irq(int irq, void *id)
>   {
> -	const struct s3c24xx_uart_port *ourport = id;
> -	const struct uart_port *port = &ourport->port;
> +	struct s3c24xx_uart_port *ourport = id;
> +	struct uart_port *port = &ourport->port;

No need to remove const from port here and above, right? (Only from 
ourport.)

Other than that, LGTM.

thanks,
-- 
js
suse labs

