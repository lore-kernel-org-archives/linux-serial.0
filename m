Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A673B297;
	Mon,  3 Jun 2024 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717398632; cv=none; b=X8dWNl0bnnSj5XaalN7dbHeg0Sm+pevinTu+4i+QdC02ylJLJK3POfIr44o7SpSQkm1z8zEySnDEKfwAl/gwriQy3zmBKAaPZZQDj2bGWrq+FWQr6kEE2/xNCSexcs1hO2XOQz5VRqw5or6ibX9+yjm99ABf3tfbX45VYlAPxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717398632; c=relaxed/simple;
	bh=j9aXwTELLGPGbXulQxflPG1rJKnbAbvE3K4OP3C8uys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CP3uOx5rtQkD9vYg+hNKcsfte4KzddO7cBsCE+al1iZa3nfZ7e2ouwqN8PXRUGbb8M1w5l6uPh+H2DX4cGkvm0/2SD40HscZtoY937OEORn4whoztuYXht/CDiOmWdNqbqCE5DrGuHF+7yruykvSm5qgnLdkY+ypSSzs1mi6m9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so138370466b.1;
        Mon, 03 Jun 2024 00:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717398629; x=1718003429;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa1bPa/u5cBszkr5yIv73pVk7NzZmNC6oGrBpLcxj3k=;
        b=FrwT4ezqkXeCskdtTyWM0K6ZjvAaRhodNdJPFbKSzVw8Lium7svuf4uxhgRT8sydVX
         aV4kHTzlWQ4qI/YiLfFxr1Y+mJtMq73MoKnREq9sbtm4ecxxw5MXatCVKyr3DAVoSneu
         G1rNMUUm7HRKy/QY/GEi5nYJFhaglR6AxRPT2P+Eaj/TXlm2fMFc1Eapi/73Lyr7JjsX
         VzN5WIyXZJoADQglOtfgNsdtsOto6wst2USqWR7pCc4sYjHCoZD4kX9ULwG02PraQyJb
         ek6LlsBXZeIq+n74/3LzP2VdmxZZEXeL5IQG5igKbfBNS3z8KfeM9lFIrA4K5flYlafv
         pfQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM47SHPqRmO1JQipvWY7/+0+ya7ks5BOb8EsuG7aRCWDYBxzc/UXuV4+ta1ItwOjffRgE0WxgT4c3Xn2mI9q/07dZVwiWo5xu4gdC1
X-Gm-Message-State: AOJu0Ywaylav4n7zrtnYN56Jmv+c97HADYpH/VPKd4Uw4ffDVW6LqVts
	mWpKxBNTHbA/iUk9lD4f6DTz10qnOh7F2GzTSRIWb4RjMF+8lZhS
X-Google-Smtp-Source: AGHT+IE9W+zhfs5b5nRKuPziS7SDcEIYahat/kFCGBPuODYsf/pve7LGQq43aQQf7nxbzSMM2Vts2A==
X-Received: by 2002:a17:906:6894:b0:a69:ceb:587 with SMTP id a640c23a62f3a-a690ceb06e2mr98898666b.11.1717398628585;
        Mon, 03 Jun 2024 00:10:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68efe2f1easm205289766b.85.2024.06.03.00.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 00:10:27 -0700 (PDT)
Message-ID: <acfef6bc-08eb-4ab6-b6d4-9ad03c714517@kernel.org>
Date: Mon, 3 Jun 2024 09:10:26 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: drop debugging WARN_ON_ONCE() from uart_write()
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Al Cooper <alcooperx@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
 Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
 Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>,
 Richard Genoud <richard.genoud@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Alexander Shiyan <shc_work@mail.ru>, Baruch Siach <baruch@tkos.co.il>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Neil Armstrong <neil.armstrong@linar>
References: <20240405060826.2521-1-jirislaby@kernel.org>
 <20240405060826.2521-13-jirislaby@kernel.org>
 <d775ae2d-a2ac-439e-8e2b-134749f60f30@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <d775ae2d-a2ac-439e-8e2b-134749f60f30@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28. 05. 24, 17:05, Tetsuo Handa wrote:
> syzbot is reporting lockdep warning upon
> 
>    int disc = 7;
>    ioctl(open("/dev/ttyS3", O_RDONLY), TIOCSETD, &disc);
> 
> sequence. Do like what commit 5f1149d2f4bf ("serial: drop debugging
> WARN_ON_ONCE() from uart_put_char()") does.
> 
> Reported-by: syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Ugh, definitely:

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
> Example is https://syzkaller.appspot.com/text?tag=CrashReport&x=100271ec980000 .
> But not using this example, for this link will disappear eventually.
> 
> By the way, do we want to also guard uart_port_lock'ed section using
> printk_deferred_enter()/printk_deferred_exit(), for trying to use e.g.
> WARN_ON() inside such section will result in the same lockdep warning?
At this point, I don't know the answer.

> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -622,7 +622,7 @@ static ssize_t uart_write(struct tty_struct *tty, const u8 *buf, size_t count)
>   		return -EL3HLT;
>   
>   	port = uart_port_lock(state, flags);
> -	if (WARN_ON_ONCE(!state->port.xmit_buf)) {
> +	if (!state->port.xmit_buf) {
>   		uart_port_unlock(port, flags);
>   		return 0;
>   	}

-- 
js
suse labs

