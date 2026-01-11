Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C891734A3D9
	for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142769; cv=none; b=efBCWqhOEgSZbZbZAfFyXnH2d4dh0PJXRKXPi+6Fisy259nfdrTnRNf0NkvDoDqU/gl/05FsR27zrHx00hntsucwpE/0SjDsifOkGSDrFv5kOsGmrzOl2HZFkaEIeVPVE44BKUoS2az7I0Hws5NgSnBXLgXUu1+q9iksgT9w5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142769; c=relaxed/simple;
	bh=E3fIUBLPFnEXAfwoSTB7dOLky4Cj+/epBMllkCL2GpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJyCma02K/uJNIdjhloUaE25xeERabXieNdRzbLSkZHLU3pjKYL/VFm0050ATEd0X+xFiaVUhEIszsecVnZYdRNtSnpC9Az7LuAYyCg430VLFauFMG26gr2AETFqUT8lLL6jjrsBv/QMLNCOxQ1POHUb9O91B949vnMkcScsewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZFz5/xt1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZFz5/xt1"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so7237623a12.0
        for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 06:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142765; x=1768747565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSh5A9C/ikcooPDg3GNmd0+fIcS/l8zoJ1QKaA55bnM=;
        b=ZFz5/xt1R3RPg0IfhqILS6DeIcAi+Q7dknvvl7zujx9QVOvzKxPv6PbFWkA+xsWdwy
         q4RvbDBtR/HjlASIiVjVE8AqQ+cFMmSpSmHz/9zLrH9twpLhuoDOp2ifbX2+2rz35r8W
         EZggkt2Z25Ce3wkYydKW1eTb6s6zNkVGI4+qfKwk56y0v5hgCqKDZMbRcQU8iiV6WcXD
         bNlH8BXPaurlSjuMuJ8jWyp7GKnMkFz+dHJmqtCjFfpct6Tch/J1+bYJfTm+imAjQNT4
         bYlIO26xS8CbA20ia+8l9ila1DeJP0BiFxQQHuZUchuSBxxfuj1eBGaY4zansROWmVws
         ybLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142765; x=1768747565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSh5A9C/ikcooPDg3GNmd0+fIcS/l8zoJ1QKaA55bnM=;
        b=rt9Z7r6QBvmpXT5NOAo+ecRmv+WmtpjEf9c5S+TGjBGiTVxytbxlRTEoK3Uabzm/IU
         DvcRXwVrj6q363Xz7vRDjcgXR7Z9wCUItmgDIPqR5sRwjGphTYjMaOLS16/dgy6kGQ/G
         xLA/oJoHUyDPu3nXwODWuqr9/IQ9gkLApokldQuHgaAcyeX2FEymTE6Hq6TCdxKT2O5h
         ErYeDetgZbMSPgLQEWUyN5GRzwTm7mjulxUK3eqTUGQyDP4/sRfq6tRRt6AlGo+lMSmz
         zN5697thHLM3ngrdRjE8/6mgTwD27RGVtdSHHAgsk9Oc0715MV8ieNHHzs95Iab5rXwh
         ktfg==
X-Forwarded-Encrypted: i=1; AJvYcCXvSoctZqPAb3wYjD1ELRPS6EMp5keougnUhnHU5xdBj9vVNyNmvJtiNHLHovg19dx4QX0FetQsDDozWF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXSpGxrevpsKu6dva4+suiGX6Eck4O8OZ9iHaSBL9KCRwmp+pi
	LOQDi10CENWcQofCxrk1TE3suMMbVsgtT0QkSmfz6a9JGddi6HVJoOxAVYkhbG1lkYk=
X-Gm-Gg: AY/fxX6vt2GQXprbvy8bmlrAm7wrOb+59tM3AkgIBP4KJKYECsjWnD3z2LOIJU2A/q2
	ZqoLbbTSOo+ExjSrWzA1s7OKDF63WXZeO/Mrcsi7xIy4unQZ4oEovRWr6waaMHjgRq6C32sPbfc
	Ph6cHNenhkoVW9OcPFd6NjVvFuRMgMH+JtynzA2bthcFBCWx5Ao2r59ySdINo+RyGBB/9WBux9B
	QrgaRPUZjfEY4p+5LxVDTz4w+cOG9yYCcDzlXdyoAeDeCUKrqSb+mj6GMYVHNUnqVBOTAyZjB1m
	s829OVwT1cqT5AfdWCeYbY424X33hxHZwX0dO12We4kStIt+TNXmdE/twI96RLKQFTbV9fhZo7/
	HFvlaLXBAhaDzCfW1oh10sT5Wag31/7duGPsxg8c4QPXHZ5CU07Y5V4ByN9ML65cu/4jg9RzT8H
	v5BkLfut0Wc/QiYLPuqouWbBU=
X-Google-Smtp-Source: AGHT+IHdSgN1j5CfCwzzuZuuUE6k4oOsy7A6FyHYN7fpU3s7QMByt1Yrcz5j8phSUL1uwYAKt/FfvA==
X-Received: by 2002:a17:907:3c8a:b0:b87:1b2b:32fc with SMTP id a640c23a62f3a-b871b2b3d67mr52172166b.0.1768142765029;
        Sun, 11 Jan 2026 06:46:05 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870b0dba4esm216046666b.17.2026.01.11.06.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:46:04 -0800 (PST)
Message-ID: <dd70bce6-77c5-4d73-96ae-6a0bd8ab7b22@tuxon.dev>
Date: Sun, 11 Jan 2026 16:46:00 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/15] dt-bindings: pinctrl: pinctrl-microchip-sgpio:
 add LAN969x
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
 <20251229184004.571837-12-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-12-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document LAN969x compatibles for SGPIO.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
