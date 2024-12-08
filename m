Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC116F858
	for <linux-serial@vger.kernel.org>; Sun,  8 Dec 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675620; cv=none; b=asi55CjzFUFaZFyb42HsgN/c5nDYvMIPpYYcHk08EDF1UXrcV65D7WPJqMomMcV9uhyZ9+whS0chQ04SHkwFrK4p5y2e9tyaE6xD1Fq9RCpWbUcDvGFkcd154XNhfVKbQ/ipb7+eRXiAK/eB9LeOP/7mhcGA70E/3n0PKrWrcXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675620; c=relaxed/simple;
	bh=/35qo1NSaXfj274xmXlQdRGosPADR6c0eJgSNOG7OjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMM71KSxwb6GabvH9L+2XNEJXfid1cooHq3zMNafUFr84OetphQrASflSnVlJ/1FldGUR/g8+zxJqRztTAJ7DDTKObaGtLsr5lumiT1NfY+OGpgGiqx4YPH0+VRTzmjlA290gw+WeFajJI0czkMWNOlNsBcdokvMFq5liZ4ZTFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cPog8pRH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cPog8pRH"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa64f3c5a05so229647566b.3
        for <linux-serial@vger.kernel.org>; Sun, 08 Dec 2024 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675617; x=1734280417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAZgKK7Ob7dVD/6GRHg29F0t0wRjMiOSNr01J0LKftk=;
        b=cPog8pRHKdk/okPkIRve2/Z9TqHy/oP114O8aBGG/kgUGYAE8asM9POL/3cEmVGaF0
         4vlINOjfpBaA1uuQPyfq9va3Yrx659D+R6aQvXT91LkfdtCU1c3kN3+VkCAyT4YAAq1n
         BITjI4hTOx+pLsPZaeGg5Szkc/ZuOwLnb5ZuKeP6fOZ0KheqI4w2EV6hJnOy6TXkdaz9
         sfPrh7ENqzhadDvR2i5Behk+dh6H0IEBqviSUMtSh0+RRjtJdhiP6JO1XDaFy1AhzA/S
         2KGvNsXXtzcyW8mjNiynTjWK7hlIxNdwMsQLHagGVTPDzocYYhVmVBHwuW60FaKncFr9
         NASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675617; x=1734280417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAZgKK7Ob7dVD/6GRHg29F0t0wRjMiOSNr01J0LKftk=;
        b=HzVfSGaTsVhmqBP+nYatqcqud0P/iCaWO40cKe1GFUVRkxyCYmpeJb9KwY6NROmDmC
         PFK1rIhn+7nwkcwVsfDod4Y6tuCltZu+flcF0D1reaq+7klhb0EGPOTTvI6Pqe50OddV
         LOGswzhUFalI+loy561o39wnlvJNiIhps4L8hVJcjTiL4Lmcks4KDALVBoR0X4yiIhbp
         31DUnd8sUq3QXPo8BuALGYsjwmLWXWBh4nVxROe6toxcOKXpnPAGGm/j5R5m4tn9YVgM
         TL3NMgrbC8sT2bbx2yrKYgUuKlnH+bO0LI70bqjrn1fRJ9o/mkVig82r8sORARZhK9mf
         eWvg==
X-Forwarded-Encrypted: i=1; AJvYcCXidNQInrstpim+sxDKj9LQA02k9rdN4GAwURKouwv1vamIbJW2y1FQB6fR/KHDKIrfRg/KmWk7yJRmEjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVFujmAvUOe/rs6YRcqWMmlJS65SMMzkLghzt29IzvOTFDuMWD
	fv8AylRYO4dT/Irja3Y4chnUZtSGsbPyO4cueVfCx6ucRfVQt/6SIBvBSVSXy+w=
X-Gm-Gg: ASbGncvu4vS85mU0loyjk7A/dMRty7wm7GEjaB0M3VN5dJcfAIlncMK42izvwMGjQGj
	Z8FUqL1mqHhoUNcuXG44Qik2TLNYy517ifoyos9OXFQUJERyGwap4KRC/OWlG7JeRCUoFIRnRy4
	YDEfUazL0ES9/dzkpkT5Fja1UFh6fmPzAZISeFvHWFe/ErTiItgfjdD88Z4KN/7xPjshS8Vp/Vw
	wSFbSPk2SdWkjmMkQMY7/APdlQbqHUeqonl9lLJea5wrAMfCD3NknLnrGM=
X-Google-Smtp-Source: AGHT+IEG5BzdBKSU5T5ma5GlgSE9+K05duEqvgjt64DfRU1QPy3ISe7GWbOxCcAy7BgfRsflElX9gA==
X-Received: by 2002:a17:906:32d0:b0:aa6:7027:7b01 with SMTP id a640c23a62f3a-aa670277bf0mr300268066b.20.1733675616848;
        Sun, 08 Dec 2024 08:33:36 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67a4f8dc2sm113804466b.179.2024.12.08.08.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:33:36 -0800 (PST)
Message-ID: <6ea8fa5a-78e4-46d3-8e20-c2a723bb7e86@tuxon.dev>
Date: Sun, 8 Dec 2024 18:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] ARM: configs: at91: sama7: add new SoC config
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <e5a1311100a4f05fdc44107e124129d2d93df2e0.1733505542.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <e5a1311100a4f05fdc44107e124129d2d93df2e0.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add sama7d65 to the sama7_defconfig.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
