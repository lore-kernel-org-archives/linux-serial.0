Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE033BBD4
	for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140300; cv=none; b=Bds3kR8JsMWt8PX3dxfSjeoWP+bYFj/m6+jcZbIw8suoShtO85y7TBYlBQ5EEDmclSsf8bbKTTETa2MLDdZLUrjR4JGTmJU7zMs1gUpt+alBgHwEt19cNjZ0/Hi3llXfV8y/WAIPuyR1+YzMQhQW/HjX5RnrVX6UtboVsrRnv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140300; c=relaxed/simple;
	bh=btyv13yF1O8eLHTxPRhdfp8TKAEfJvTKBJK1fYmI6Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kk5IluQ2pJzfQPHSOfZZCERQZoC7wGt9hsIjkK90ZBtdE97q6eXuVsK3ADKNPMss3t5qF2SrrqqCKay8sVUm9yudh+aYvaaJAN+1AkgmbN5TMxRPdZmGfKcpWlx4CKNCLvobYF+/VV9o0mowY/GX7kaLwhI2HwY7lSsSZpFpm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QExsiGGl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QExsiGGl"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8719ac9af7so19340366b.0
        for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 06:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768140296; x=1768745096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XwABaHQba0TZXE5KSskxvkqQOly72ac18mmHR+qtCY=;
        b=QExsiGGlElrMbdLuVLF3vOqHwCf+WCT61him0YoQoIEWfiO4yNLyd4VPBUAKN40Gej
         x+S845X0jv6JN0VBlI7arOrMRZmUjNjdywGxqg5AZeDp411nr7Ct3jMkAyw9oGfZ80tp
         9peF5Nu7BK/4h9jjmebrpbIuSLELKFU7zvnFZqdA2gopeWLxeGHjMxwhymx3RIJ7uMfB
         hpCmIW4/qAYok/gFj8dEiDrfBxbl4cYeMBaBpOEfsfmWLMvsLKPHH+jcF56wU5GfMxNT
         Fk83jkyDvYSwRUyk76cF/DEUlxrfU34/Cp8JPQf9+99HmKUb0Ee91SKnRcSXxBM8h+ZI
         d3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140296; x=1768745096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XwABaHQba0TZXE5KSskxvkqQOly72ac18mmHR+qtCY=;
        b=L0aYHsTOxNzFZJ6QS4bmLgz6fHfodqkQlBY+x3q2aLP4pReBLPM/sw/vPnZQCBnc0e
         PjfqWtuMVMEeRSHn4fNkxg9gNpS+7vDreRtyxoxJBMnMohJ8jlIW0q2y3zFqRXv9JEan
         jXZkTG+exFLxaC8coz+z9pJGNxti1qg3OaFn+iDFFmteYB2bItz8+niAkj/fwk9Wwtvz
         qtSYtcJjA5v37tCtJokNxAaIriBuWs1Q92mr/1i62hoaOCyeJkkWGsb/ooCe/XMIBabW
         5t+aJp+71863ql7LHBssO5g0TVsAEfpy76LGGK2oWdygJHUoIV08AJftL/hIleWlbNv6
         jfcw==
X-Forwarded-Encrypted: i=1; AJvYcCWQjZ98DB3QFV1alkfb5W60ySe+tVnrNUH37XCyt3eoneEhwKg1Ku7hYt0UIbSIA03Sjl/1F4r/rbds5ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHP15Rbde2dwUCy/sJpQ0J10JH85DHJBcOgXb0r+p7YYBv+KV
	RONgDwO7NUAzY6c/jpvOJ2p+kh/PRTLsRwP5KtHzoEVK+FhgQutFtyWC66VW8S38Wws=
X-Gm-Gg: AY/fxX7WlrVwapXQEP1KOe+nMJaXZkThkAwRz4e5bTPIFaAgAgl8bPkybEv7EK2A9Oi
	Qqb0xYa1898K2D4ibD/KwVcOq437hxsVmlzjpzKNKyekmjh4SswQ/5PtOQndlmrPNPs5oC2dMLY
	HcfshE9H68bvSLvZVoXrXUYr5rp0mjgHWt7qTu6UjB2jyCZauu5qrqzYO3lhLNh7Ls4CsVCcCJM
	Ba1wOl61cv3hyedtm86ogr6ThsS40eh3se6aLZfdfGSVYerL724rQlPViXjhgM2idLM90ifYCWL
	ozQCwg24aY8W4bDA1BmCgyWmynnnaqGOJOw4D8XDB1DoUIvaYGmP0ZiS+TPUIRDkfz4HOkBq9f6
	s0Uc6Z2Jz2RwlPNaKiNThhxHteUn/k5JX0uc1bfR5jEn4UqKWCE4unB/G7XnUxtlu+lhsqUnZ1H
	fzeYJsGWSw1qKhdo/1On1JkAc=
X-Google-Smtp-Source: AGHT+IFH0IHMLB/e9VMPw+PNQvxklsKe4TmQmjkQDY/3vRiOU9XAUjD+Bmvv1dPy8Ir0WmHAJUU9Lg==
X-Received: by 2002:a17:907:a08:b0:b07:87f1:fc42 with SMTP id a640c23a62f3a-b8444f488f0mr1766243166b.16.1768140295378;
        Sun, 11 Jan 2026 06:04:55 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f0d6d7c6sm455055266b.42.2026.01.11.06.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:04:54 -0800 (PST)
Message-ID: <3f82d755-552a-4074-bee4-b2660eb6a979@tuxon.dev>
Date: Sun, 11 Jan 2026 16:04:47 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] dt-bindings: usb: Add Microchip LAN969x support
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
 <20251229184004.571837-2-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Microchip LAN969x has DWC3 compatible controller, though limited to 2.0(HS)
> speed, so document it.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
