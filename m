Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15163215192
	for <linux-serial@vger.kernel.org>; Thu,  9 Jan 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413675; cv=none; b=EYPL4pWpNO7Xoch1aST3LXj2D+cf2JtjhP6aH+HBWw+i8QC1bgCEAkwRrk/5eMqr4Rg9YlE+1DynKFZLOihRTepntAGiBU/CPrGWpLXJQ02/Wl1L4wettXhsKfcHLQxvZ/dOCseXN3JqWFu7uyI39JDdx7uFfu+NSB2k2w/xyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413675; c=relaxed/simple;
	bh=lfI1k0wMgFMfX2M7M5coh8Z+nbWNplNx04OURuDOF0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBP8niwawcK5I9KMhfRg4rFPMPpgW2leE52Vj4XRTWhI51Le8CEhUApVp09LIE1fz6R2Kbzekk6oXAF1ojweWHAjAOo4RJkfnvwmzx924oJFN7FQhIwFRm1yI5Jb7wM292JkBYuo6RvhwRtWh74xALWdWf9w6Xe0NLtW2Kowzv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PJOzQmLc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PJOzQmLc"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso11171375e9.0
        for <linux-serial@vger.kernel.org>; Thu, 09 Jan 2025 01:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1736413672; x=1737018472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0z9juEC+YEqySrxS6PPDAc02oimlrf77ef6rngsd1Bw=;
        b=PJOzQmLcrw2qBmXfxtTaBlY5iEHmNlqwQ55+1EYianRSakqvIy8tOfMxL3giXAgyMk
         J7B10ZJlAYWKYNIg2m6w9bGsfDqD2P9QAcceblrV4HN3NZAJ2urnDPkMkM74/2vSP5pQ
         iXBZsJtq6bMZ1k6sNCIq8WknC0sB4QkmfMSwxugEKYGFn5NwYcrnUl9UScFP8aHVoiX7
         LrJ+nDDAIe+EdvQYbIGMExPDyqplLTx3m9mB4TESdxBxD9iS8OpOS+SDPuInuEjQgSdS
         DIOlSzoacsbf+KeZFxLpImP1XwIldb5wYimNWwUXU9TKr0Lf1AXe6f699K5SBg4AToa/
         MOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736413672; x=1737018472;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0z9juEC+YEqySrxS6PPDAc02oimlrf77ef6rngsd1Bw=;
        b=qqJkkKFKgEXxdiswAQ/VelW6QUcqu6PCoEMp7WrqHjhc+TuPaGtpyaD1zqPZ1Q5Xp8
         b8476jlhq7+g9V7qhlOqasmihyWNo0ceyG1RYE2SAX7RTFAurbCseXiYPPpmdAtw+YIC
         C1/KvUKwYjnabjSfhyghYIzhbZebTDqavi8dN+lp2T2yNdyeodU2F5voVpYcKohaNwze
         vtMPDeyRarArMaMaVqAu+bLH7hX3s08KM7BAFiuEicSbWcsKcxAPN1FxfO0+bNj9NKs0
         Bbw7HM51Mm5sbBFiRL/+tNjRThxzF7mCytXxaNnqqLXe8bJtXXN/a+CR78sCC8k27bmm
         kewg==
X-Forwarded-Encrypted: i=1; AJvYcCUGki5XF/f8aYKV9FKy4aC7mCfXQod8U965V+xPQgkgq5KcPWGybV7gY/O/PlBV8IE6zhZqsm1FOr456e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrMU1WYaWD606EW6PLO0qy3sJnjaLW46WofSmQWAFJTPCv+CC9
	jtFX9nCKKjK/gBuugL8pR56JR3GdujMU/W+/m2aytK37cwHCRwIGruyKXfRdCN0=
X-Gm-Gg: ASbGncumvGOOK2NpxLEXMlgngIk9aixFnvzL8eWkQLRMk+igwn/9X0CbrHHEHNIwOpU
	9zhXSx762baXNzEgz0ORuqM+WMDYO1lfZ5N/jtklaS/UJ8s64ZTMCq4TVmEhFuAglApG8Ra5MNg
	ZSBm3RPXPgP3XwzXmWvnyfPhKxppjJ/XaqNPx53o86rX5AT/6BbPN5pc2J2Wnja9g0dkqEDFi+R
	5x1mc5fp4C9bRj/3vgLO6oXWXE4Etvk0BPRkjSd41mZWBi0ZlbuD3ZFsRpPvEmG5Q==
X-Google-Smtp-Source: AGHT+IFhZW5aT/6BOpkdWIdluaAhlNSbsykRP/2gidEWNKCALvd4CcTnaBDhpgLuYHgx1FqVxmhfAA==
X-Received: by 2002:a05:600c:444a:b0:434:fe3c:c662 with SMTP id 5b1f17b1804b1-436e9d7b99cmr10865985e9.12.1736413672521;
        Thu, 09 Jan 2025 01:07:52 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38f0eesm1242682f8f.61.2025.01.09.01.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 01:07:52 -0800 (PST)
Message-ID: <680b0818-5a0a-4a98-825e-3d4dff0244bf@tuxon.dev>
Date: Thu, 9 Jan 2025 11:07:50 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Add support for SAMA7D65
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250107160850.120537-1-Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250107160850.120537-1-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07.01.2025 18:07, Ryan.Wanner@microchip.com wrote:
> Romain Sioen (2):
>   dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity

It was already applied from the previous version.

>   ARM: dts: microchip: add support for sama7d65_curiosity board

Applied to at91-dt, thanks!

> 
> Ryan Wanner (1):
>   ARM: dts: microchip: add sama7d65 SoC DT

Applied to at91-dt, thanks!


BTW, if I'm not wrong you lost the MFD patch on this version.
