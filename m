Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C382172791;
	Tue, 11 Jun 2024 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091761; cv=none; b=pNx4NFny9lTlbNBtV2QrF3WFSiT4XymK1mZAHMAB7XYVRugukVtX9FaudQDuRcwdM+t1f1Wni+FhUxDY4EiUmVu5z4v1OGXMTBRDF05MVKMXeoHfOk5gJQ0CvHUV5CirhpHmJGQefwrIu8gnDfVwiovWRFKGAEwUqcml97UkSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091761; c=relaxed/simple;
	bh=o1zahQxIWD+/98sedHnveo2KBjxi7jCNvDC5mVk0MfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVZaNO0nZdloCG60psyZBP9vDK9M+teBeoCrwRDjl4y0ojO03aAS/Ave8rB4h6tnh+bk8JPJeGgdFCxHmo8SqLypyV6eazgXxGprp0nHuy6jdii33Y43KhKm0bbAxHPj2z/cXQjLMY5Jxde0k6nLCmPYbKdAenclqh8FkNm/q80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c681dd692so3833556a12.3;
        Tue, 11 Jun 2024 00:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718091758; x=1718696558;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsQWNnrH8jmRHztYPzNkoqj4xc0t7XwdNHf/EVwsa/8=;
        b=NQ3K/J35ZHbajSYPjT0AfiJ8aYGg/PgEhz82xgc2uSmuE3kSGhuV+03v4ApBN5HqKC
         YzJhyJyx+Ehxoc99qBaUE0EzJ6yftMzIPo2XX9PcIgiePGE4xJWoV9jzHTZGKuChk/Oj
         NHatuksVl+oWirHNygcTCUCPBW0wkxxXene10W0VutQ5p+hbVrfQdb06Gjj3h8ZbJV1D
         Uf/XDJtYXF93Nz+ehvFVEW7EyfTCT2uMfTt/wprLN+s6inNJcTdpmE9sN1QbMilm7uKb
         BBc2z0dLDTU31CzSZpUgfvJDZqIMub0r6BvhvWqnEHYat5zujJvrtD0hxuVuTUVoAgH+
         UhNg==
X-Forwarded-Encrypted: i=1; AJvYcCVi6X7Qp5i6A2dXsns76YLD4lHKDZP8f6+b0JPQP6B1ObtAL+tYodwAQuo9N98eGEUaPd5ufX2F9sfmzxZ2oDTr+tjRbEJB5h1SsBy4
X-Gm-Message-State: AOJu0YwoEkiMt36l6zA9Wh6/nGr9oWwR1654bejLCc77SdFqHv96rM+B
	t1BYPj2I/f0sW/svguiC5DnQSsta5X6qyCTEeP/Mx1teeCmjZOcHpPh1E+1FNgY=
X-Google-Smtp-Source: AGHT+IEf9G6NJ7DC44th3DnZlFQqr/OKhUOxs3hywcJPukJUxU+XaHYzyqOXwhNEIO6nlZViFMOwfA==
X-Received: by 2002:a17:906:fe49:b0:a68:fdfd:8041 with SMTP id a640c23a62f3a-a6cd7a843f0mr983795866b.42.1718091757537;
        Tue, 11 Jun 2024 00:42:37 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f01a060dcsm418635266b.182.2024.06.11.00.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 00:42:37 -0700 (PDT)
Message-ID: <0d8da651-4e41-4af2-81cc-732f17aab403@kernel.org>
Date: Tue, 11 Jun 2024 09:42:36 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] tty: mxser: serial: 8250: Relocate device IDs from
 mxser to 8250_pci
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
 <20240607114336.4496-4-crescentcy.hsieh@moxa.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240607114336.4496-4-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07. 06. 24, 13:43, Crescent Hsieh wrote:
> The devices in mxser could be supported by 8250_pci, so this patch
> relocates these device IDs from mxser into 8250_pci.
> 
> Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> ---
>   drivers/tty/mxser.c                | 50 ------------------------------
>   drivers/tty/serial/8250/8250_pci.c | 50 ++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
> index 458bb1280ebf..b0e7ea6611bf 100644
> --- a/drivers/tty/mxser.c
> +++ b/drivers/tty/mxser.c
> @@ -160,31 +160,6 @@
>   #define MXSER_CUSTOM_DIVISOR	(MXSER_BAUD_BASE * 16)
>   
>   #define PCI_DEVICE_ID_MOXA_RC7000	0x0001
> -#define PCI_DEVICE_ID_MOXA_CP102	0x1020
> -#define PCI_DEVICE_ID_MOXA_CP102UL	0x1021
> -#define PCI_DEVICE_ID_MOXA_CP102U	0x1022
> -#define PCI_DEVICE_ID_MOXA_CP102UF	0x1023
> -#define PCI_DEVICE_ID_MOXA_C104		0x1040
> -#define PCI_DEVICE_ID_MOXA_CP104U	0x1041
> -#define PCI_DEVICE_ID_MOXA_CP104JU	0x1042
> -#define PCI_DEVICE_ID_MOXA_CP104EL	0x1043
> -#define PCI_DEVICE_ID_MOXA_POS104UL	0x1044
> -#define PCI_DEVICE_ID_MOXA_CB108	0x1080
> -#define PCI_DEVICE_ID_MOXA_CP112UL	0x1120
> -#define PCI_DEVICE_ID_MOXA_CT114	0x1140
> -#define PCI_DEVICE_ID_MOXA_CP114	0x1141
> -#define PCI_DEVICE_ID_MOXA_CB114	0x1142
> -#define PCI_DEVICE_ID_MOXA_CP114UL	0x1143
> -#define PCI_DEVICE_ID_MOXA_CP118U	0x1180
> -#define PCI_DEVICE_ID_MOXA_CP118EL	0x1181
> -#define PCI_DEVICE_ID_MOXA_CP132	0x1320
> -#define PCI_DEVICE_ID_MOXA_CP132U	0x1321
> -#define PCI_DEVICE_ID_MOXA_CP134U	0x1340
> -#define PCI_DEVICE_ID_MOXA_CB134I	0x1341
> -#define PCI_DEVICE_ID_MOXA_CP138U	0x1380
> -#define PCI_DEVICE_ID_MOXA_C168		0x1680
> -#define PCI_DEVICE_ID_MOXA_CP168U	0x1681
> -#define PCI_DEVICE_ID_MOXA_CP168EL	0x1682
>   
>   #define MXSER_NPORTS(ddata)		((ddata) & 0xffU)
>   #define MXSER_HIGHBAUD			0x0100
> @@ -212,32 +187,7 @@ static const struct {
>   /* driver_data correspond to the lines in the structure above
>      see also ISA probe function before you change something */
>   static const struct pci_device_id mxser_pcibrds[] = {
> -	{ PCI_DEVICE_DATA(MOXA, C168,		8) },
> -	{ PCI_DEVICE_DATA(MOXA, C104,		4) },
> -	{ PCI_DEVICE_DATA(MOXA, CP132,		2) },
> -	{ PCI_DEVICE_DATA(MOXA, CP114,		4) },
> -	{ PCI_DEVICE_DATA(MOXA, CT114,		4) },
> -	{ PCI_DEVICE_DATA(MOXA, CP102,		2 | MXSER_HIGHBAUD) },

How is this MXSER_HIGHBAUD handled in 8250_pci?

> -	{ PCI_DEVICE_DATA(MOXA, CP104U,		4) },
> -	{ PCI_DEVICE_DATA(MOXA, CP168U,		8) },
> -	{ PCI_DEVICE_DATA(MOXA, CP132U,		2) },
> -	{ PCI_DEVICE_DATA(MOXA, CP134U,		4) },
> -	{ PCI_DEVICE_DATA(MOXA, CP104JU,	4) },
>   	{ PCI_DEVICE_DATA(MOXA, RC7000,		8) }, /* RC7000 */

Can you simply add this exception to mxser_get_nports() I suggested in 
1/6 and drop the whole mxser then \o/?

I had a long-term plan to mount mxser onto serial-core (or 8250). I 
haven't managed the conversion yet. So I am glad to see this.

> -	{ PCI_DEVICE_DATA(MOXA, CP118U,		8) },
> -	{ PCI_DEVICE_DATA(MOXA, CP102UL,	2) },
> -	{ PCI_DEVICE_DATA(MOXA, CP102U,		2) },
> -	{ PCI_DEVICE_DATA(MOXA, CP118EL,	8) },
> -	{ PCI_DEVICE_DATA(MOXA, CP168EL,	8) },
> -	{ PCI_DEVICE_DATA(MOXA, CP104EL,	4) },
> -	{ PCI_DEVICE_DATA(MOXA, CB108,		8) },
> -	{ PCI_DEVICE_DATA(MOXA, CB114,		4) },
> -	{ PCI_DEVICE_DATA(MOXA, CB134I,		4) },
> -	{ PCI_DEVICE_DATA(MOXA, CP138U,		8) },
> -	{ PCI_DEVICE_DATA(MOXA, POS104UL,	4) },
> -	{ PCI_DEVICE_DATA(MOXA, CP114UL,	4) },
> -	{ PCI_DEVICE_DATA(MOXA, CP102UF,	2) },
> -	{ PCI_DEVICE_DATA(MOXA, CP112UL,	2) },
>   	{ }
>   };
-- 
js

