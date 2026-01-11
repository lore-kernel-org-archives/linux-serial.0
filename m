Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85F38D
	for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142550; cv=none; b=lAFn91JvCPUIDEU9wsB+SdJwgwk8d+Lr/7DJffPB8CqkpU3ud2am12A6+Y0OGw5mVoArul/AXSm6u3YF7JLORa/JoZSZZgx1zGJJzxYVKQaoN23rvvtpBQ0/I/tRpRjl+HD+6KlCW0Qy/eJXtvd8fvorjLwrUM9TN3IpObqMDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142550; c=relaxed/simple;
	bh=nwibogWEaRHQR0G0uXO7BApOaM+RxcF4pitpiLWDTZg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q/b/qv0SLwjTh/YvVN4yH6yWAQ8hAVe8F1QjmAbECCqDSLPZ0xfqdaTzP0BjtJvUTK1cigdSpqj0uGeiYZ29BUwVYXHKvaBy/gVdFlMuLO57QSDO/zXEDDsasCn8XpEcpjCrnhRAnHhZ1Gira68DO4FhqADxZWa0hLqVq0XaEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=c77L/krc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="c77L/krc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64d4d8b3ad7so9253245a12.2
        for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 06:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142546; x=1768747346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MkabSAxRfLn0dHpHfPolIqVil9ZYQkOUo+uqCMKmtA0=;
        b=c77L/krcX+Mfr24+FUl4++gD6P5i5AGxy0m+b1eI91GhsDm0sayjulKachXmaIlYnj
         wCOILRVKwoNMqwNVxiWqRG/2EpusMOG+6mI5UGjqQhrvQX/0x8TiI6/sD/LxA6Hib49A
         w1bH1nFUZyZHE7gn2ZaU+W23FBJAHpOkkENkXq3dyjTbNfVtcnT0ibchItmEiZ1Np1qd
         rc0qk+dTF5Uvu980fQlLsCVoritMg6f6VP48BGlFIXsO11MCq0nYJAdrEc8pu+EFAWms
         a9jgZUFbr9W0Mz4E+TgG2PBR7kf7gSyNi/WRoJKvSsndQ8k0T0kWq1Tnsly+JbkLGMdO
         RD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142546; x=1768747346;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkabSAxRfLn0dHpHfPolIqVil9ZYQkOUo+uqCMKmtA0=;
        b=Uf+/p7UWeSO+PaSU7NAVDu3x4RCO3R+qQCL7kJqRVCxIAIWkkdkDvtJ55Uj2Pysg8D
         bjmDtGuFyTbV45vyZxHAzHnZJv10EfbDNHTcFsZg8P1hzyutloQYqXnZCsvJ4RgQz0EN
         pWivFn9AB1s9eN4rThQKry2amFROrR/jEE4UUEKCsM6wioMIvsNDbp15/XIA7zLKANXq
         9AnSyQSMFknq++FpVBtFmIxWgtT3hGwg03B5UZKRiuGBKQpog4U+mva96v4B3SvnOjxk
         jZlXihV2lY0F53a+tu76adwPXSDtTXjsm10qG+DfPH2Z/cUUhBb+us6C4J7B4wcGjhnF
         QjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxxVbA54pWfBJno+73Pja4ColZBAwmQQwrtcGObggPiRhvoJnWuoVaF0XjtzQUk5BoaP92yDampTIXZU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypws4qYLYy3zX+esRiPE8py6yNYOYXC2J38Vhdbyu1I6BG6D8p
	891yUjZnpQ9b0PTCSqqfCTSAJFErGH3G1DmkCOJQkCy48FlrarZ+BYB6c2rwKXKFLMU=
X-Gm-Gg: AY/fxX4WJSYFeIsy+fNzT8LwvX7x7WEPgM0mRKHVfbbtemk6ySnlWh5DRL075lfD9yQ
	iPrf8SJEYxSmxowGm7D8wsZgdWaTI6MJGKZcxo5LXU9FS2XKC4xCi0zG4fpoDPrDaHwmQFk8Jhg
	tayGYgvVtp0AthZoLE8UKF+JgnzsUNS8i8LD5NCd6+dHxCJG2mOeXKM0XRxYHG2UiURzYaQd5/B
	7+Qvq1YsIDo5fT8gEHeAG8BgAYnyxyWrJZOMbAsZaCfkgz7+Mxpcs8v+SUhUYlSozuPoW7xoPjF
	WrS/Kjdek1crNL/pJEpMU8VEA54ITxiQoS65h4nyP+1l+y9QLi0sQAJ1CXM1QBu9EdF7qYdTlb/
	4gzYijbqnIOBcvOmaA9QTSpUcBRsbE4gNNyYTLTz6kzu/hfdevZzqiiRljXWHWVw73vD7svM90H
	vEnHnP3U85s8p7PBiTM8M6RF9usq2DJDMdDg==
X-Google-Smtp-Source: AGHT+IFonU/ClDvId9huEtx8OVZbpqDSrZa3cVBTJbulbnKxAZxCbWxaUM02TgbsxBJ1Mah6guhUAA==
X-Received: by 2002:a05:6402:1469:b0:641:8a92:9334 with SMTP id 4fb4d7f45d1cf-65097dceb25mr14589135a12.6.1768142545311;
        Sun, 11 Jan 2026 06:42:25 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be658b3sm14914417a12.18.2026.01.11.06.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:42:24 -0800 (PST)
Message-ID: <2cdac084-4924-4ca2-85d6-2e6d9bf284aa@tuxon.dev>
Date: Sun, 11 Jan 2026 16:42:18 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v4 12/15] arm64: dts: microchip: add LAN969x clock header
 file
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, vkoul@kernel.org, andi.shyti@kernel.org,
 lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 olivia@selenic.com, radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-13-robert.marko@sartura.hr>
Content-Language: en-US
In-Reply-To: <20251229184004.571837-13-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> LAN969x uses hardware clock indexes, so document theses in a header to make
> them humanly readable.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v4:
> * Move clock indexes from dt-bindings to a DTS header
> 
> Changes in v2:
> * Rename file to microchip,lan9691.h
> 
>   arch/arm64/boot/dts/microchip/clk-lan9691.h | 24 +++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/microchip/clk-lan9691.h
> 
> diff --git a/arch/arm64/boot/dts/microchip/clk-lan9691.h b/arch/arm64/boot/dts/microchip/clk-lan9691.h
> new file mode 100644
> index 000000000000..f0006a603747
> --- /dev/null
> +++ b/arch/arm64/boot/dts/microchip/clk-lan9691.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */

Shouldn't this use the same license as the dtsi including it?

> +
> +#ifndef _DTS_CLK_LAN9691_H
> +#define _DTS_CLK_LAN9691_H
> +
> +#define GCK_ID_QSPI0		0
> +#define GCK_ID_QSPI2		1
> +#define GCK_ID_SDMMC0		2
> +#define GCK_ID_SDMMC1		3
> +#define GCK_ID_MCAN0		4
> +#define GCK_ID_MCAN1		5
> +#define GCK_ID_FLEXCOM0		6
> +#define GCK_ID_FLEXCOM1		7
> +#define GCK_ID_FLEXCOM2		8
> +#define GCK_ID_FLEXCOM3		9
> +#define GCK_ID_TIMER		10
> +#define GCK_ID_USB_REFCLK	11
> +
> +/* Gate clocks */
> +#define GCK_GATE_USB_DRD	12
> +#define GCK_GATE_MCRAMC		13
> +#define GCK_GATE_HMATRIX	14
> +
> +#endif

