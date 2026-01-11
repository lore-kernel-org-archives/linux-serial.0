Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0E9345CA5
	for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142660; cv=none; b=O5wreOVfkAig8g9ZLzU/ObXVPNxQnqtvDJ7DnclmsSYjHYES43N98IDrm0hkTlOeU22FomrAkUbLN5+GCu4/FgDOJdk9lICJYZYH43A6Knqch9oZzTcDlIFDlMD7ogfxjS6gkDLIY5CtGG69ZAHJTYoWII9K+uBJTozKOeZk3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142660; c=relaxed/simple;
	bh=w4Acm3yPEzhNfgXHej8RhBm1qF1q4y2VgssP/5Zk1hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3JWS/DZXBW9SzfmiAaAUiBmhElrHp15ezr39SG24pHVi8GtW6LBJQzv4rKHNkkhQe62Uwm1cErmj1j97kto5snhmClZ2G3liFIbhDkEigk83nJR2jrhdsMEoIMNXRUbm+c3AzshXyeobAgJWWmv/QApO2TEBKGaO0KxQieWhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=isTsJ1t8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="isTsJ1t8"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b72b495aa81so1072717166b.2
        for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142657; x=1768747457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vh0+NaFNSqUUr0lRvi0qh/0gFpaLfgRir9e/Vu9U7W4=;
        b=isTsJ1t8ThUdJlPcckoMxmOQN5p6f/iPi1Qz4+ymaOaMGg0HLRsEsqSZm3KEyOWwaR
         ZyJVvDBUIjMFYRKBQWAAqUA2E8lh2ITkmYgecHewN41dPFpOps4j1iduS0RDablFZa6b
         HpMQqEuK2qHm4wLB8ElCKvNNwpBajX3awNIIukUBvuu/LJEu1PULd34b1y6SP3deF3w/
         ntQWAuPAxbyU1xlmVWz0zMWNGEeFBHz89/gZfq4/2h+F0xF4+AreQNuoFSvgXYEv2bpu
         Oy7HVBxdxvC5W0dQ4KZbQxmbi94FjFBo9OMaPT1Trz8YzH8aDwWO3B6X+slFxjvyAKcG
         eCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142657; x=1768747457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vh0+NaFNSqUUr0lRvi0qh/0gFpaLfgRir9e/Vu9U7W4=;
        b=CudUc7q24ePIHF3Jm/AhQcZ332hte8pkA8Wle6I/gvYZT8FoONQ6QOGaJwXAFaUfZ4
         hIWrdvOEWG0jW1IO4y5y12oJbr/pJtLFGZ+/rtIQ+sekngpxbhiANvASr6OFLSe6rSqP
         kT2eHTT0e7q9gFE8jE7w40IQ/T5GdrSZ9mUCeynEc3DwuuVCOVjba7UuPpM/bqj/iPiE
         KmzE6d7XPML7GvyIwcbcmyTkvd766/A5JDJYKcAXGl8r2nuVjh7K5SDCPtzRk3yhJ8Ed
         k2YoDtFKhBn674Xwmp8ThOXcB5Fnltb2SoFDFVZS30T+aliLRdf3FzDOPcbgp82YK18q
         Z+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXvmqsysLBmhs3GD3ZIzPzzuyjn2ENclSNQVddOScmBZv4qTgMMlH+VKdPPvUP8KvshquoxNk+thnxOzyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvRtaHYkI1jibj8gP0Oz3TUVQTafZc5njH3aQSZJg7CJ4TYaWE
	6X1FkaO+FnFnhx9pHZQRwpEWnkCY/PmUIeljcNaGSgWaTXj8+f32AXdIK/nYy3nWqkE=
X-Gm-Gg: AY/fxX50PO7iKYOlFBZgrCjXCyfOm2ginfktMHarciscg6Opm0Fa3veBm4ujYCNXnXa
	haUuNOTE/1WKCQEb3rnqj18nGbtEm9B3+ILgrIyDVmT/XJ+uHG4j5mIG3oThUZdPdA2LNDaifBI
	o+1hY5Dq7Yq/J81zRrpRBiu2TWa0YrzpCHt8n90PCqffeVOKvWK0KSNe1EBHyxMJa7/d87kLUwX
	weTsrGLL/czBvNNzQv3fJ5sJ0MKYw50fjJ2GvPLCe6v3TQyUu+8p1ptf0uZ4+/BJ4P3OKcmgnQJ
	t034QZvRWlxj0HUxL2fN0WV/MwzdksMLcGS6xjw7SjEjl3n0vvXBEA5MHoaVmQIL67owo7TZkMQ
	004lmlrwTHQUtqSCgO/ViUaJXAOFSIhOJ6Ywkj0t5rz0RJ0ZPVraoldenQnwAjS2CoU59gVprX4
	qcaSpvZbclnHeHXGLHAj72Rs0=
X-Google-Smtp-Source: AGHT+IGSkgRdvFAJszoEIUVPnmxFKxpG81LZeaQDTCtjgK8/9NBkGo4UJCrHj8/qs3u8e7/Yxpu5vQ==
X-Received: by 2002:a17:907:96a1:b0:b80:6ddc:7dcd with SMTP id a640c23a62f3a-b84453a123amr1485279866b.31.1768142656775;
        Sun, 11 Jan 2026 06:44:16 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d3831sm1727347466b.44.2026.01.11.06.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:44:16 -0800 (PST)
Message-ID: <bb0c473d-0a86-407b-9c4b-9a39f9985ab9@tuxon.dev>
Date: Sun, 11 Jan 2026 16:44:12 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] dt-bindings: serial: atmel,at91-usart: add
 microchip,lan9691-usart
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
 <20251229184004.571837-4-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-4-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x USART compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
