Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B63348880
	for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142745; cv=none; b=CADdKTXnrC7YFfgbUTWT0MVyEvNae0Zaw/40rZOA2PsVGLTaVZ4QvE/ycpUtmyRrW2Ea+so1oVCOvgy5msruxmfZ5jeioI2wuJWaKw6Ecf2LOxbsCOgr27qtnukuFxDKTmDXe4n1TjDX5edIF3waFzkyJofjnMYZ3JsaH+W243w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142745; c=relaxed/simple;
	bh=8+o9CrQDP9rR7vhYrkmBD4TEK1Ah1Um118V33OBjIn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lu0a0WjYjVYLfZqSSAK0xesUC1ihYDusWrQ5db3FcBGYYD8s8Vd7kJuP0DXXd8ApLsjD6uiEb8XZcojBU2M88S0PaU58GEe4JRmjgce4FGAC+QWTzJ9VYjyo8sSJhY2kfEZ4QOo7EmeiKD/1YzMw2Bj0KWiA8n3ZMUND3lucgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=g58+wShN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="g58+wShN"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso8879916a12.1
        for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 06:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142741; x=1768747541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfDtjbPnZQpFER+nbClQWcn44IBaDvTgM6H9iNz+Pz0=;
        b=g58+wShNUGm4cSq/cIFs5BcjtBtziWlVwOnRIYJ0JBVThU79/8vxkDEUyOzt7AzJBB
         cTZ9e0Q9nDikPkEBLmzCCkAYBMC9A64/OO6AU4Ed+EOGygTBTQEKuknv7Bvpc0Hq4pfW
         tWuCEazhna5tzsEGgmV/QS1mDV7AI8F7irWQCIvLFAdd6UBceXKAjkUon+m8Sp9IuWPs
         p2XYZJYaezhBjl4awlNqxLX5lYDftU2jHR0SSz7JmKdP4CM//mkBYchNBUXZFooCPe+6
         dp21GWl3JMqXh5qWiJlPzG2nBfXylKpA9kssFDHJxDnXDPKiHgK0Z6Kpaw+F7SivT7OY
         h9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142741; x=1768747541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfDtjbPnZQpFER+nbClQWcn44IBaDvTgM6H9iNz+Pz0=;
        b=gGOduQnZ1Eq9O2jfB9cVfRD/FRA/+quXhRHvi96sphfsd56PlXgw0G+/obF/yZ/nlO
         Mll+k9RDhwgh4z5wvBfjlOSGUXBynu7Ob7ZvRnJOIm2SbGacOuqHDHLauvfixQ9GNkze
         AXrbnZF+PNJ4z+3+VcvQ2OlKfFip8zMADTdFEd0Ue1luwc+r9zqWhs5egdMxatl5HO7k
         q+QfGmSKeuCysUgH0u+2d6DV3yecDMU1AoFX9SinhJ6y/GW9WpAPh4Rdx94xMOeC5nr+
         49B35CHIgGDRS4P4bljDVtBgHiaNV1+6OBR6H4DkhqFbZvMPeeZlsK+ZyB6C32wM3ojS
         1zuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAVrsiN2NdD/xI8r7EXGc4h8RVn8GO0I2UqAGCYY+fbZ8t/zRca4Hqfu29vVzY75v5OalIJKohU4ouBws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydj3yhc0q0yo6ppqinMSC6e+S7WiVNPcEb4t1SO6vn93pvPYfC
	MOGGU588EIAm9uy8vTaguzfQaDYL7ztE2PixI8q8MHRBNC6uCztJLGjxbeIqpun/8LY=
X-Gm-Gg: AY/fxX5uTklX1/PZpj0nm8/NiDJYZ8aX8+N6/wueA9V6kDddVVvgVNASU0c+G1gZIFO
	dO6fMNZbclorb3+JGZ7+aMW+ah8kynJa3l3SaWPPgw44GrQvVwGrLSsB5TaF4fm5XbLhjnhoZhr
	2YHZgADS9xtI+sqzaXnS+ttKG7BlMiY5QolMwplSd/foyEWXEeZYP94k5zumI/sQD28eGGPsXU/
	nHloxusPVHcyUfhaQb6ucb94KAko0w4i6jxRgrCbA4nh3je6snTh/iWGSPeOBIMhZ0wLbKRI3E+
	dTLRkPiBkd3yqrtsLtnLe402eHO3s95oOGKGnps8210KzCPQ9vfUq1JqOeVG8QbP9A/R9v2yLsU
	yQZTGJpfcIV60HKaMRLkkvDvLzYgvmDeHp9gAVSNhJBnUvRcajMNGkofzykUfAX/vxAaCEphLvx
	fZg0Xi6nBlppcNYkSQZawtv9Y=
X-Google-Smtp-Source: AGHT+IGzzRSG9JPiSsYLBto386guzGNBLdjrzZm8+JQDEKUQ0tWs5J3FidjE880cd/bBYxLZJrvW2A==
X-Received: by 2002:a17:907:9455:b0:b3b:5fe6:577a with SMTP id a640c23a62f3a-b8445169517mr1585237766b.8.1768142741298;
        Sun, 11 Jan 2026 06:45:41 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm260020066b.16.2026.01.11.06.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:45:40 -0800 (PST)
Message-ID: <555883af-66da-43a0-a4d6-bd3bc52581b6@tuxon.dev>
Date: Sun, 11 Jan 2026 16:45:36 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] dt-bindings: net: mscc-miim: add
 microchip,lan9691-miim
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
 <20251229184004.571837-11-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-11-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x MIIM compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
