Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609C33DED4
	for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140344; cv=none; b=oa1O2+WAUs2Z9wAiIMFAttK6r137rn5CgWG/3n/jjhjqWZD8b6+QQ+1ln+tC9+oX+PhJjOSUgcvBMk9LLs4waeF1vr5gGsJd7x1N10jEoSB/Z+Yi8dVLzBkwB7ZZQZ15n+UPIm6dAi19aaQ2D32W1jDEH4pJ5E7+zq9eiw8jbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140344; c=relaxed/simple;
	bh=La7kZA2oSwRqBuL7cT5ghruILrR4PN0GG8fEmUQohxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvtP5cEU6nDnTLkc7ZkPl0NLcMJFNJ3gOlKR31ad2YZkhBfHdbWNNhnjTFlPct8b22oIIE+BTLm4k273Bv1MmXP/9GP35EKLDULO02bBMXppuTHmHRylIq7mjds/+guwxF00aCaTcYUQ48f0s4hedHiaW6MehKiQXN0InF1KH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=A5h3J93L; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="A5h3J93L"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64ba74e6892so9280139a12.2
        for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 06:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768140340; x=1768745140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXunsOKck5NLaqPP1pj13fhYNQN15zYs+l2jwEoFO8U=;
        b=A5h3J93LIBKbImOKSk/PuMD1cA9Z5C6EZEowbXbuQQWRqoIAibYcsoDlQw3TBJfR+T
         u0BiOjCEJXktgpsZjOdLv3j4NKLAL6vWzf02hINhGw9gtNLdyMqKWd3DOyEcZSvo3jYX
         8ZK4HrP0vXDrFAoG6NVNSCZ3YaSVLqWlNr0VD2t95cLlw4Jh61dPCSWNeQ6oulesS2tN
         wj79fRG7ILgJ3A7li2jIzTbZtZZjrXs2jKlLHtMo0WNwEe++CfnFmumACmX2K4HiMsrY
         hZYR2bZ1STtKcGYBa3SuMqw2+bwsgdTMBUMyBFpULbdi1sES9VrFIvs1UBE/wqWbzzwP
         APAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140340; x=1768745140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXunsOKck5NLaqPP1pj13fhYNQN15zYs+l2jwEoFO8U=;
        b=JyYXOcppkUUzIM/YHARYtv1NG5I82kt11uQbyg2E4z2NExMGMS5jyomTGBtn6P4jwb
         0tIxKxGquWVM+qKXZc6TXfqiU/hr61ndJmdYTIUcDIm/HDBj5LwyYg4l5F93ANt2Iq3f
         Z1PowNR2Qps00ynvl25ffVxDKC77p85gI0+xsHAgkaT4Sj567IBrrefXCbIU16/GU2f3
         RwWdDGK7QWa60OH2lZAGmkdah1aHUMImwhapyXubschsMRPz+vY9NBsBuJFGWQBZkq0I
         389Dm6cMoaDwpz1bibzPl5ureZRF1eUDXhjakQQPm90NXCgp15+wbiXqkS9J7n//CAXA
         FRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc99s+TlNxErl/OZuyAXukFQJQPoIkn0KP84cpFLz8sJSrehL3TL1cRWgSoO10P3mLaJwZ1ulpP8pmI0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQhIuDSPMVtQOWFZ8ofE8f6CVcDNZSt4uMEzgyorZFdJjbnvmA
	xmPfBnJ8NBMJ7DBK4LDafSMw1GrhZVop8Mxmcar/GA07vo2DMxN2czYUA1YZv6EaEa4=
X-Gm-Gg: AY/fxX5Upe346oB42poJQOnDB9nZdB3mass2OWJNIx9S2MACvKY8NRP76O7OuzWhtcu
	sLcwH7kNWjM8nG2XThnPYsLM6h+eH8alQiC93gPE8V0ZvPTHUdG0Bo3maWyuWhdpDRZ91E3FuZ+
	IrkAWmdWkYKKkVfdXmQV7pxR/5SqLgZTR8iEVF/hOmdtmbJV1SdwjPFW+rvSzo2gvi738wT+8ml
	KZuAMZI9zJQyInYlaOyduyqLocUGu2EIL9LZeCIJvmUXdWecTx2xepXQNGUBThSbHK2W3S1ld2l
	kZrotn6oPjLy4N6a4We9NaI+cSkPnxVoalL8RrwNGf3mr1GgRHJT9Di4JniMcKJPSaClPQWSXRD
	lKQJwaG2dZQOszwzqFpum6JxfQbdV2ZVjmiSFbLP9FBlK8MjmkLBIQT54ik2EcMgBwsLeom9NQJ
	xxK55PZQxbnDc/huRveyLei0oDnF6eCxXyfA==
X-Google-Smtp-Source: AGHT+IGAomJOik8MqjiZHm7eirNShLlujIRGUrfTNhxgz3sez9ZGd+euk5Raj7DyHYRFF75x4SXADw==
X-Received: by 2002:a17:907:3fa1:b0:b87:908:9aca with SMTP id a640c23a62f3a-b870908b37bmr200612566b.9.1768140340256;
        Sun, 11 Jan 2026 06:05:40 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f1e95273sm439916866b.62.2026.01.11.06.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:05:39 -0800 (PST)
Message-ID: <05184245-9767-45ef-a4a6-d221f90fd20b@tuxon.dev>
Date: Sun, 11 Jan 2026 16:05:33 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] arm64: dts: microchip: add LAN969x support
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
 <20251229184004.571837-14-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-14-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Add support for Microchip LAN969x switch SoC series by adding the SoC DTSI.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
