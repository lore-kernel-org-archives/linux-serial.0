Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03190349AEE
	for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142689; cv=none; b=fyWb7NMfykBMAR1ebrZW+bgoqnErSoy7rM2DY5ub3wJ7NF6vuWbi0QIFYZnb8NVqvDr5glIbC5194lkHnuy+jJ/9Vz7yGOw4F7HXy9NlJpA5n4rv7n4p9rsRyLkxxBH06YJP3cLxeE931eLNEf9vuCN/eOH9RAzqZDom65Rd6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142689; c=relaxed/simple;
	bh=6nDyEm7V4aXX61sF6eUN6LhYpH2LhvalQYGjX/umKoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8HmbMRggV0IxuzWpjjOZTL86bdkZG+qW2ol8UnZfIYU7lFCuCmkl/zosBeJDZqEP2c+H2cqA1MC9vriSElR3LuVVqeh+olNQVgUu5+agzH6u351t68vBdJ7QuggssjFAL6wGx4WXT4FLOvtnNG2LY5VTJ8lN+KXsIGARwnjAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ookWjjOm; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ookWjjOm"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b8b5410a1so8273177a12.2
        for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 06:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142685; x=1768747485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5bvCXfrw0wJAyvC451z7sPKX85y6guKkf78mDKwHw0=;
        b=ookWjjOmWIYoGV8NQWvwlqznn4j8X/9cIu1N+sDUGIRZyYgwPku/XDBbuWd6K70V+Z
         P7HY/w/F6flzBr5IXDYHVEB3ltopxlY2WHQAhLaOCeZR/Hrc1OWjU/V0asR/RmmmcEc3
         tbjCh+t/BspEkplUHtFz+y05jDP3wSvjg3CpDLl8Q1Bh5+kq3Y2fFlpvC/a4tjSPRZgV
         /s9DK4NFB7cEl6zQXNMcpwOkQ/LYani5uYAJvLM+ZJjDPhc1ZKQqnqz5mjqsBNhxaSmo
         d4j1Vc6VbI8lJrz1ATl82rXlA+iKCYIQCQ//J+lmO8a7bTRC9QTjtYFdAUSJ22DHDbQg
         LgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142685; x=1768747485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5bvCXfrw0wJAyvC451z7sPKX85y6guKkf78mDKwHw0=;
        b=TooAHcGNE99U/3GyMFIuQUVp6byCnnbA4OgTlYmsTXW6X6UTtllB/pkfLgrTyv+sHl
         7gDImTEx4HEknZrsw4lMyEgn+tLd9b29NiQKb1M3W/P9UtfkZZSWPdHEg0+RaCZB0CL8
         vmlOYWPdL287Q+12Qtlf1XSnFO9TVt1nbCF26a+HfdHfBg6K/hCTWJwiwc8M2GGi17QC
         /zSd7mzbGO4H0R7VsKbXvetMAWBV67Bwu8BkTpPj3gNmfKsdnIq2u7J2u6psE9GhJlIf
         8CirVGLsYRV426toCBwTNc7UP5s7t97kAF9FOWIbLoGezxyCOXQXwhWmsS+9WLZXJemS
         A+/A==
X-Forwarded-Encrypted: i=1; AJvYcCU4/sMGmzXbS/tvGwyY+opGr7ubUM2VhI7ynx3qrVTBHMocTKj2B+gbsVXvBTaztY8ifmt/ZbPXq+krVes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAbwiNLfZ+Xyf43QJ34cBQHS9SXz08JeL3dCN/a8bgkAH5hNk
	rIxeJcFuW+IFEqG3zi1aW2WkQG2CcbcXT2wjX5dMCUhWW6FYurP6VKYhQLmrCM3lYLc=
X-Gm-Gg: AY/fxX7ZKozUeLx7jA2IoFv1xVScMCwHsT6cfLDCfead1SJzer9WZeXLz1wftfqtZkk
	r+uHSljz5AvktXxxoBwUfnrbVx9Y58pkIXgOZtRbLRDPp5uwMs2mPEYfAT0oUM5ZZiicQHEzAAa
	SyyeQ0Co3dLvVdHkGgouo0DRmVgDPLWR3UjTPbui11/oVKEteueYwaArw3/tiJX5Z4unvIbFjIy
	XYyWSaapDvRADNXd8Lzb+vC2nrXwlCLeWxJnM7GFpygsh/5m5nfyBQ+WL4P47WsrhyNtFH5hOa3
	zIzNz8+N81a867CWfO1wUnf+8N57jsBxX1v7y3HXGDSyHCpeLKkQgoIr5As6k4tUUUBLyXHY12e
	5fQuX8mK3to1fyd0CNONhW4rzm9e06ShTEz3QmpwCUXMPyPbXzZxibISC65ueQL0ltOiAH3/+4t
	d/q+BIZsK/R0OLP75u3mJh1UA=
X-Google-Smtp-Source: AGHT+IHGUu5OYQ17yt0Sks10puH6ECXvHmROUNTsHAGUEt843jNznhl0Fa7GBLD0pgo1znXFARhYGw==
X-Received: by 2002:a05:6402:146d:b0:64b:4540:6edb with SMTP id 4fb4d7f45d1cf-65097e4ce77mr13908239a12.22.1768142685334;
        Sun, 11 Jan 2026 06:44:45 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d44bfsm15272072a12.8.2026.01.11.06.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:44:44 -0800 (PST)
Message-ID: <ff941a66-cc09-4f57-a511-d253f48d7137@tuxon.dev>
Date: Sun, 11 Jan 2026 16:44:39 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] dt-bindings: crypto: atmel,at91sam9g46-aes: add
 microchip,lan9691-aes
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
 <20251229184004.571837-8-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-8-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x AES compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
