Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D53491D3
	for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142729; cv=none; b=WwUDngMwtcOX1xHDZLyaF8dk7ah6NmAgqd7OLuPyeiGDnTjdJ8TfCZsxlnwVkcv9UdQTswwUBSTi5d7DHelXJUZRRtkYPxeeRb62IAHaNGfqd8Di+aqE+Ov2hmYdCskUiy3vSl3ebp1SoPxIjVPzUu4zG36tH+0hYSHyQqbt+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142729; c=relaxed/simple;
	bh=YDHNGLJfluFKzT2RaL2uk9Ugi0ok4Sk7jIeMDkApg6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWAFXtkdkh5IASH5RmQ/K7auc5c2pQmRQVxwRap8vtpNYepZfvLQgqEHVQdXBQqxt3BxzeuLZcHCPxfrMqwm1qinAaoYbkKhU6qZLwGwW52nkLzQ24NOD1UguGUPEpi8lmErkUoN8nhbwNSM6v6uTW+J/eMUtqr0eaDh5+vn2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=X9Wk2tta; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="X9Wk2tta"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b83949fdaso9278366a12.2
        for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 06:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142726; x=1768747526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6rwalswAWwTHAknUrP94zFyJo4NhuP+T6GegkCWM/M=;
        b=X9Wk2ttak/FxxYeh5WLK137PvXT2Bo+6f4tTd7DoZEvDfH1xyhWoL4n6yF/gvnCw8z
         z+h9Pq1VYPIop7EYoYHEF/ZvxNpxMSSGAdL55uhaBcqSfbLSS6+O0g3gtUKbcER1Z7IK
         s2S2cmElL/gpcQWFvwhm/u+qSVXzl+qK0VjAc1Dk2jlacBc88hyZK8whHoOR0r+uNnl3
         9BPa6sdp3h6wLWdtn2N8cV2+HuBUCgov4KQjwoG6XwRdQ8sxApffjIH+TQL/Pc4vRPxm
         y7mX4RoTw9OGMaAtnsluf6omcNfoTTI99nG19wYn4YbH2bFtmLM64ISHwLjSgcuMJIRj
         qGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142726; x=1768747526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6rwalswAWwTHAknUrP94zFyJo4NhuP+T6GegkCWM/M=;
        b=DJW/Fx3MWXFywv6cI6zjCcfV+3LlSBwyCzlUF5wQbUPM814PazQMnrXK1cEmyq4g1s
         EzRu7hyKCD6D2vH39qCAPG3uKvXHm4u5Mc17i4t9srjFlYLr5js/hRyb+ogA7xeu/TTX
         Nj/8PPr5+oN4IgnjKqTG5/kpXhXUqONbkPHOBIFtL38iTeSFswIzs6ItRfKgSdhIa0yL
         ugv8iwpPj6aldoBfgcEZTmh98HZeY51Q2rGT/KVb4X9KN+S7sydLZ/KPCmk+KmNphXjg
         /2PWG0EjtZgrk9en5ls67WuHgrSAJ3H8sC1aNOUCVrJpmUzgHeOx2BGJ9iyM6o/QC0p+
         sr5w==
X-Forwarded-Encrypted: i=1; AJvYcCW3eUggCng276c5flPHxR2qMXlwvVeMDje1hLbwC8PwtXCKOGjIQJhInvSJAFlA7b/heRjeGXoZw+8zJ94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUB7MbVfNgd4dqRM3upknGEEnmMmF32SiU3kfqg7WuAqQxrD51
	E/H7HNn8aiqX8/Qc48naYKm9vDDZS+F8GZx6f1u3m3zuKOy1vL6CdpX+y7Id2KJPAiA=
X-Gm-Gg: AY/fxX6VlrKNqEDk74S61qakgcbWXAgWdO9WNrJWrUNeNSSjmGt0j8cwIWAnmVaLfcZ
	eBijrFlTbHbjQqTDFpVY0qjaeb0H31DCYsz40w7O4LAssXoirVcDq3+19WalMm+ruCHPRI7RWKC
	TXAABjXfxS2cd9M8x1PFwa+GGa/RGc4iSdICd7kubpSVcX3lfN7sVQM83tufIkwXiObgLYw0U4e
	BD5wFxA6J/5x1zjTBOho1Gkj3xkJNTSBFmhrYwnfodVvdWNvsfvwvPh+OnLnYNN2RMw8Gb19DjW
	3TOLPdaCK3Iha+KvYX6yKZAKDslb5in20E9Qd788E7CakijaVBW+g+qV+32OUE2N4TD1JUrPODI
	POcWLr9te1E5nu4ntZzBee865UBBKAGSTYewrZKMgZbPdN6wInNwBMCLOSW6u6p6I552o7Dy1ss
	JlWoWoFRGOBNTyZJUvoYFR2Qg=
X-Google-Smtp-Source: AGHT+IGvS7IBApFn5Y6caZIpVWCcEKkW6+CPDWe6wxvm6P/BpWNKX4ZQoy1X15u9d+HjeZrWR8LDZA==
X-Received: by 2002:a17:907:6d10:b0:b84:40e1:c1c8 with SMTP id a640c23a62f3a-b8444f4afb5mr1764352266b.33.1768142726523;
        Sun, 11 Jan 2026 06:45:26 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56962esm1699865166b.66.2026.01.11.06.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:45:25 -0800 (PST)
Message-ID: <7081b61b-599d-4a59-8a27-291c55a0e52a@tuxon.dev>
Date: Sun, 11 Jan 2026 16:45:20 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] dt-bindings: dma: atmel: add
 microchip,lan9691-dma
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
 <20251229184004.571837-10-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-10-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x DMA compatible which is compatible to SAMA7G5.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
