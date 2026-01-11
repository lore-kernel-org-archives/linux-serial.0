Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772F349AEE
	for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142636; cv=none; b=L13/josK0CdokWYJdSJpRuUp6H0vtntNoYzNuUekASzJiq1DL0tMDIBUXxUFFe1b8ib1Ym30SDG8c0akExSkRGyNvJ9XuosdNIWpVMwxpGrmzVWHIq4T8MV7f/2LlsD6j289xmRZpTTFX7NuFDlI00QAuDvFAIGE3ILrNDo5TJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142636; c=relaxed/simple;
	bh=PnoQRnuiOPkoaR4OWKdkvM54htM4YQiVOhdkWK0qg5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbPa9/IGBaM0h3I50EqETvRmq2T1panpWJVdZzRu3FfuKKKah/48ET1rs2dh1U6YwbYuwVsb5fSm/WnA8rE2/AkpScEZXR3w9G3x5IV3LxSl77KUcbFYHw/U21RqMJN8HBpydG3iJ/yd+ZlNvrTj3H4E+xFw4CDRsp6uEnxaZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NoTM+k2S; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NoTM+k2S"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8052725de4so786115866b.0
        for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 06:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142633; x=1768747433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8ivZWfcmepYc5T+3Up0ol6uJ6XFnUAYmd34ka9AIUo=;
        b=NoTM+k2SO5HylCVHcHNqCec7b7gBIoX2QQd6dHlIYohJij5ffigE1XqVlvs93gRqWu
         zSIkpxTis8OI66sDUEw9DNOr0vv38lEu0MABsxGfO4mb7PU0O/BAenxo8CfbBvrIUjvJ
         LRD7tBDt5dQcbYHF3oqbQYYGIp7uzpqccEsipOONv2jXTM+d2xEwUlLYcgjMnPd3UHaG
         v1LNXlJiyOp211uIT/EXTZAXo6ZwY2pa/ypM6jMTRJzxVWBG9VG0jzGXdKX5J6OsbGrT
         +1rzoSd6z1syRrs42BwDqXaqn95JEU2D+Qx2+rM7+dRq6TJYCADcu6Rbo1rrtVkRqMN4
         drtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142633; x=1768747433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8ivZWfcmepYc5T+3Up0ol6uJ6XFnUAYmd34ka9AIUo=;
        b=rv2RzcLh+cVAiJ6QxbMMV9Wpy9kzPtQ5FjCg48UahggQTqjL6zQMvqyLb32coFfpcU
         S4aduhc5TpRVfKT0uasa5eftqtw/QYapjLK+eD2IwzMaR/T7hsM3zMeSbOU0vI64lJJb
         p9e5gvyyWmTEap5ILsuRs3Kb+acpidQQs7qbeClfUUS27OHA3HVUG3JZ40IM5YXpCP7z
         FUAoDxjTN4E+Yd60y8GS41BwvoeTs5JiU0gXyfrlpscd2B+9wFluOTn8Ubtx5w0MJGTG
         sX+xAg1uO0RtWRFzu4Dz+RHUU4D48+fhIyp4IZP0OftdMpOX1G2VplPrr9/9ZOcG9/ic
         Q8bg==
X-Forwarded-Encrypted: i=1; AJvYcCUgp3HrQj+crpEr9rQRNfRdTf0HmzDNMMIcJztgRreE3+ZZIUNp32yQqOyTQUMOR1CNogHD0XZyz43GfRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLjqGgW9ivQjrWq1HvfCJxAitYFssgEJ7PM8nqh0uDbTn+2z1
	2xo9pPNxKs2jX8PV4eba+A9TM1qCktT1ycOBudsee+PnsY1/LJbmS3FOxOjD8gNavGs=
X-Gm-Gg: AY/fxX6iy68XUDmyUTuxmuGWdQbMxcnB3HfAxPAMm3JzQkU7wQck02pf+YMTlNPkXVo
	hajZIehIZ/jhIgnuFpwwmAgyZipJuYG4n9z9cjk25gj+TgiiJ/VNurMWnz1bc/us3nW732Nb8Vr
	+EKRVXhhqhZaVoE6BtJqV0uwzVQzjRHWn4pPCG1tkgac0RpolInnFQmPwsPoGf8LEsPCSQLHRy2
	8lhXjOOge4nD/r0YWajnMcBgTU+P3YjujCltDdwbkZMs/jmeTPLxBsjArgBkQ+FWB4IKvARcWLu
	/sjbJrGmBN0AmIg0OzlovEiW7E5y6mbOarW1gyAQcCVzMF8X2QVZcbfqtBsQae0nVk8RsvXZKru
	PH2E4nKILNwnMuFxtud0CFiLwS/im5ffdKPpuIfv/NLORkv+ozsYuSZYuSpo2yuMhiAZxoOAM4Z
	YCihC4Lnfg0Vd6aQmK909X5F0=
X-Google-Smtp-Source: AGHT+IEIDu7YG5XG/nu65TCe1ZGy2PfVFAGljLAgOLVEydIa/k97PZQn/n1VHfMaw/abNX/NIg40nQ==
X-Received: by 2002:a17:907:980e:b0:b72:5d9c:b47b with SMTP id a640c23a62f3a-b8444f6f7dcmr1568524366b.36.1768142632630;
        Sun, 11 Jan 2026 06:43:52 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd007fsm491365166b.31.2026.01.11.06.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:43:52 -0800 (PST)
Message-ID: <d97c48eb-ebbe-4742-a4f6-220d4515a65f@tuxon.dev>
Date: Sun, 11 Jan 2026 16:43:47 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add
 microchip,lan9691-flexcom
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
Cc: luka.perkov@sartura.hr, Conor Dooley <conor.dooley@microchip.com>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-3-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-3-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Add binding documentation for Microchip LAN969x.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
