Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83BD528;
	Mon, 23 Sep 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084672; cv=none; b=rFWwIsLXK4c4zjN1+nHRzzS5kSqAQdfb/sfyA0p2EtbB3hDgNwjwt8hLgi8Pe5FCLxM16SHfxdl1Xe2xATH+ZvMIXQ64iZqkZx7nD9pf2KRJEkiOVN0OfsrmZRIx44UeU9/lGSbVrbv6QHhKc6xpmnLtFjyM71XK3UYAnEfakWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084672; c=relaxed/simple;
	bh=+L9zo0Y0IbRyVNmNctKrEvHN+xXePa5ffnG6jnguyMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tpa1Hyhee77UmSTrRxliH8eD6PSEM98FcCxe12QdSqu462qKr1cOqNtXlHOHWBNgMcHcuZf7ywEMK8En2EOHhdJplhFSiOEmrqA/OinUcd81ghKZxtWD/53p6FS1/mFnU5hTLyrw+azb8lSFlz7AHLSI/d3wo+mJAbeyQ2K4wNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so2941436f8f.1;
        Mon, 23 Sep 2024 02:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727084669; x=1727689469;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnFrKNjmvDN+T3qauVVSSpYxYgzs8YQCyhijAXVVj5A=;
        b=wV39isaM5jbODLUayzgetjtViypWDZFimDZK9ihBtezx7a6X6yKjkhX+RU4mfszvWP
         KklYoHoKrQhFI00XpAnMQiHW9blx/DS/1GbVGHRrejTCBkv+nT0JLlAqESFu4y1ttLTN
         juy8/gXU/8RaZhIasNulZiNQ2d6lv3WmneTv+AsFsvXZDrxE4W7NIEA40bYnjpNlxlBk
         WRG+6hqwKLUusRMSreYwZevYR6rmFvUSPlgOdenv8Tkjr0BIFK01xqXflYIC4Ck0hq1O
         nhyoMSnIgSoPOEstaJUlf0+pGocO3IHYGlUFg75fmQWlivs/EC5G5WnFD4+arsRf72iB
         gr3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHD7uRDqLmmsmVyDBM8IYWRPahO2R/KGME2ZBqTtxGLo1+vecoR4ajr8cqiz6NbUK27sMyX3ObEGo2Qcs=@vger.kernel.org, AJvYcCXfth5hrUXjB8SOLp3uRYAE2ZCz9bfs7MeJWmtoCB5vzhU0WyxOoxvN4mHWVTKXvQdvs8wmAVy7rRxkp2r9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ccwjLXF6w+cVSLsgCFv3LYtwcNNGyE2BTF1+JSd4blt9Jc0U
	hv2skm94dZdGMqwmAaQjby9FKDf84HlUeIdNTo5dIrRTcqqDWfuj
X-Google-Smtp-Source: AGHT+IFZflKHVwSuVXNsh12+3OVdGy3OAea/J9oU57PIfZALvwf+9JaosbjLZazYOktBIioKOuNh+w==
X-Received: by 2002:adf:f951:0:b0:374:d157:c019 with SMTP id ffacd0b85a97d-37a43147a81mr6934351f8f.12.1727084668448;
        Mon, 23 Sep 2024 02:44:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afd6c64sm96811055e9.27.2024.09.23.02.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 02:44:27 -0700 (PDT)
Message-ID: <051fdbe1-e5d9-4d5d-bc1a-921d8d3d4a9e@kernel.org>
Date: Mon, 23 Sep 2024 11:44:25 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: rp2: Fix reset with non forgiving PCIe host bridges
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-serial@vger.kernel.org
Cc: Jim Quinlan <james.quinlan@broadcom.com>,
 Kevin Cernekee <cernekee@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Ogness <john.ogness@linutronix.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
References: <20240906225435.707837-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240906225435.707837-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07. 09. 24, 0:54, Florian Fainelli wrote:
> The write to RP2_GLOBAL_CMD followed by an immediate read of
> RP2_GLOBAL_CMD in rp2_reset_asic() is intented to flush out the write,
> however by then the device is already in reset and cannot respond to a
> memory cycle access.
> 
> On platforms such as the Raspberry Pi 4 and others using the
> pcie-brcmstb.c driver, any memory access to a device that cannot respond
> is met with a fatal system error, rather than being substituted with all
> 1s as is usually the case on PC platforms.
> 
> Swapping the delay and the read ensures that the device has finished
> resetting before we attempt to read from it.
> 
> Fixes: 7d9f49afa451 ("serial: rp2: New driver for Comtrol RocketPort 2 cards")
> Suggested-by: Jim Quinlan <james.quinlan@broadcom.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>   drivers/tty/serial/rp2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
> index 4132fcff7d4e..8bab2aedc499 100644
> --- a/drivers/tty/serial/rp2.c
> +++ b/drivers/tty/serial/rp2.c
> @@ -577,8 +577,8 @@ static void rp2_reset_asic(struct rp2_card *card, unsigned int asic_id)
>   	u32 clk_cfg;
>   
>   	writew(1, base + RP2_GLOBAL_CMD);
> -	readw(base + RP2_GLOBAL_CMD);
>   	msleep(100);
> +	readw(base + RP2_GLOBAL_CMD);

The read was there to force PCI posting to really flush the write to the 
device before the sleep (and not to post). How is this ensured now? (In 
fact, instead of the move, you could have deleted it completely.)

Can you actually read another register which a resetting device would reply?

thanks,
-- 
js
suse labs

