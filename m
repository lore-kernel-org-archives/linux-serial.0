Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEA612E7F;
	Mon,  8 Jul 2024 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420096; cv=none; b=VohaHdI224q4sW+9xxIpD4Ue2u2tPQc97VDOl8FeyVf/cvdkrWSR3BaFB3F+84EJbgILwxEKbO3HKuBg+W490vugm+HzSPFRcnTql75r98M6HyxshOC19DgSUqgobkesIo2CyIcTu7ltsLwhvJW4iiZBDN8jx59cfYIO/jVmwXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420096; c=relaxed/simple;
	bh=r5FUaf28sD2ZSf0QfQ3bSq0xrDgrjT9z6W+Db3yQBPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9+cPw5XA4ttVf1p38nsQIKNhkBJ3LPvJpRFkuzmytDaamsqZIHDB2FHKOEa6TTg3j4LAjt1Rkd/Vta591SUJXnPzPhzdyoifB/ThYTfw1jplJdpAJNhlgxcGKfye2uzwNmeBeG5MFlrqee7rkYt3tNasg6Mn0haHKwGxWHp620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ee90f56e02so33409511fa.2;
        Sun, 07 Jul 2024 23:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720420093; x=1721024893;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok+70R6H0gvsb+eCECVSjDcVBE2i3W8XdPc2Q3RMI88=;
        b=je3RT60YGUWT+bTmX/dS8CR5Ptc+/oR72yFdTXkDTS1PYcBTcSOmtxDy+ZViTHu4Ti
         h5MHB4X962oUYligqh3nvU0+MOyE+UJ1d6BtmZb08u4A6GNoxoxozktDf5yvVQgO/ZMO
         9nQAArDJw0Z7VjAiMbO64tjtcmN9YMWKc4h9IN+fNR7l+agafW2c50aq0xUZpbBhB7tf
         qKvgCLxXWXf3MD/ZfHRVnOM9RqBK7kTQHq5wngBeP5MXiNc+uKWpXQ6D1XAOUnYZ2H4B
         xwJsHEoQ5+eHsB43XPQzI9Oyn4/OUEaMPxluR051TkyU9H9wbMS4ubgcXx5sAPVXMyeL
         PqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiFa+F2pDoCgOGPHj05WcC7PsOuUo7p4gB0GYGDapLlVzE2tusss488yzREhEUxAaT1CT93HXRm9wzYWGye6okaBHjQZj8labm7dYl
X-Gm-Message-State: AOJu0YwKCMril+yrhKk0LjPTlfkj7pif347YnXyPo9SCMSTALMBasJ8O
	8p0WU57rrQRlzzLgXjZfOFKwt4kEPwXwOHA4LxsbW6XJCI0UUF9s
X-Google-Smtp-Source: AGHT+IG/Ui90NkFiRI66KU8v/cqPZNeHv9qVGGtqj64ymkSSGi3x0x31uYgrHrVr/jftuZkCh++w8A==
X-Received: by 2002:a2e:9241:0:b0:2ee:8a92:d510 with SMTP id 38308e7fff4ca-2ee8eda7cabmr63949861fa.30.1720420092612;
        Sun, 07 Jul 2024 23:28:12 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42668b87496sm32296855e9.8.2024.07.07.23.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 23:28:12 -0700 (PDT)
Message-ID: <68b3481e-7a4d-4070-a711-709021154412@kernel.org>
Date: Mon, 8 Jul 2024 08:28:10 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: imx: only set receiver level if it is zero
To: Stefan Eichenberger <eichest@gmail.com>, gregkh@linuxfoundation.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, cniedermaier@dh-electronics.com,
 stefan.eichenberger@toradex.com, l.sanfilippo@kunbus.com,
 tglx@linutronix.de, rickaran@axis.com, francesco.dolcini@toradex.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240703112543.148304-1-eichest@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240703112543.148304-1-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03. 07. 24, 13:25, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> With commit a81dbd0463ec ("serial: imx: set receiver level before
> starting uart") we set the receiver level to its default value. This
> caused a regression when using SDMA, where the receiver level is 9
> instead of 8 (default). This change will first check if the receiver
> level is zero and only then set it to the default. This still avoids the
> interrupt storm when the receiver level is zero.
> 
> Fixes: a81dbd0463ec ("serial: imx: set receiver level before starting uart")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>   drivers/tty/serial/imx.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index f4f40c9373c2f..e22be8f45c93e 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -120,6 +120,7 @@
>   #define UCR4_OREN	(1<<1)	/* Receiver overrun interrupt enable */
>   #define UCR4_DREN	(1<<0)	/* Recv data ready interrupt enable */
>   #define UFCR_RXTL_SHF	0	/* Receiver trigger level shift */
> +#define UFCR_RXTL_MASK	0x3F	/* Receiver trigger 6 bits wide */
>   #define UFCR_DCEDTE	(1<<6)	/* DCE/DTE mode select */
>   #define UFCR_RFDIV	(7<<7)	/* Reference freq divider mask */

All these should be converted to BIT() and GENMASK(). Then, 
UFCR_RXTL_MASK should be obviously GENMASK(5, 0).

UFCR_RXTL_SHF is unused (and unneeded) BTW.

>   #define UFCR_RFDIV_REG(x)	(((x) < 7 ? 6 - (x) : 6) << 7)

thanks,
-- 
js

