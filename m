Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5245D749
	for <linux-serial@vger.kernel.org>; Wed, 14 Feb 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925682; cv=none; b=fuKrYQRbylnJ3qS+Pbcls0svF5ulJHEJlZjOHDg+90q496p3r/Ak4bSjHN/TyzMPHFjVf+hYSXLlAp9Kj4O8EAVyM/sbxtYyYB2d8qCGFbLsFN1CpUxmdaA/HN8Nh4dwYYsWNYI9SVP4bBBDnBEYlkCC5dueZGYZWYfR8heGkF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925682; c=relaxed/simple;
	bh=OXo9CJObNilBsOGumalkvDIP0Qjf2R+AA2nb7vEMJFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dedNYVi1S0X5x9c69wDD3JE1M5nW5KnE2Kq3whU5Whoe2272zdkaxToxHTSU1pHYy8SgFYlUXp8ygZrNyCAsgdnaq9IP4oHKL4QeVVtf2vk+MQlq408IArRFH//aTkmKS43gKoidX9ugRmJoAqqb0SUXHqsUXphnqJyqStxFp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fJErqcrb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJErqcrb"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-562131bb958so1679285a12.2
        for <linux-serial@vger.kernel.org>; Wed, 14 Feb 2024 07:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707925679; x=1708530479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McuX+46GCJMWVVIeDmGS2EesDa+qgN6dZa0RniqPfYY=;
        b=fJErqcrbwLtPl4rojjxpSNTwlp5EjJvRQrN08CpPv1JBvWA2oanw+uDYAbgMX4ECAo
         C3OQNoLLD7D6q7TO6n37fxA3hMVT0djzuy8Mrf096l2/KCHRY5xXIaTb4PZkM3duU9Ur
         NTk/a61jafgQFUxwpuaP2Ha968HOpCgnJuSkF941+WGl/N/VT6qFCoI0rRVEgtdgtQAi
         ntBgREnSfRpjnMkO7id5IuMcwqm55ZTCCfuqDsyzfb6ddBKEHV3yrlAW/1e3jqYHBOyn
         x5odjTG+Jwtal1dHoHO+ZVdmE/MZJ8Nzc4AtQCEN3SvHS/hKagj6p+FXiCOlBZc3Hd2k
         R2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925679; x=1708530479;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McuX+46GCJMWVVIeDmGS2EesDa+qgN6dZa0RniqPfYY=;
        b=XsBjsmujE3M2zfqqPeJ3JSuTQYF8c6uUZQiUqi9T3E3k4QrgKCPJ/bKmsDGBdJeduD
         00FcG6D5yErlFSxcQURhp1Uu6FW6yw4EuQ22rE+E3dvqP42qhf7X/+HJxW/qqGNVSfQV
         aPu6qTjR9rW15HpdkDbz4mGtgHqFc2hHNEV9yYUSkmzS87V/G0QYCGfsUWa0u6hcGUxA
         x91w3wPIrK02sD+lk8vlkJmj+LQ+0ZXL+qbjJKJctIBrkRlqoP0CEjqteIq2TsZXF5q1
         JuEiN6q4toESR3sbb4vyb9MiFao5htkzvftuP7O3iCrX8KvrsKGvIzimDS3le1YcyMQK
         u+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWN22rYc8LOJnhzp5L3BSW9aVGHusHNbYReJtKm0wH0/qqMWUb8xrKIdVATvMqSbLRe3NNZF1/COkc8uz2Uxjn+ML94sxhnhevwGvXJ
X-Gm-Message-State: AOJu0YxQdfTp023eRTjmbzxXUKvrL5JWu6fg6ynfnAaVnxRmMIinzAHV
	Hbb8XoI9NCPkxckMTUcIRd0wLf6qYyosVYEzn2UX8mw8rKZiyelvPIg8pi9t3lU=
X-Google-Smtp-Source: AGHT+IGvFxgX5xtNHTBtY0C7eJHL1+eIyCwo+5PZLWqptHy/PaLq5avuplbL8is2vdZyJDDISqW3aw==
X-Received: by 2002:aa7:d752:0:b0:562:10a7:9ebc with SMTP id a18-20020aa7d752000000b0056210a79ebcmr2286734eds.18.1707925679279;
        Wed, 14 Feb 2024 07:47:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUz6FmQmF5wn3+zPS6iPau8SZ/a9b4GG47ZBDtTcZsdbARlczj3X3HDZ7VCr4lYdZgGmw0O3qjxKmLBU+SNQqg8cyJdgFpE0goL9yS3+Y/ch/8yobscE2JRBajb8iw24jXUFK9bhYBAdnPuNh9swYTi4+1tpo92mLZHrijTpWPJ08TKi7hOFrH0ZqpnQfJ/NdP7xUsW/VCJIuzQKq5zQk1jtQ2nrNmh7mgbD+jjI5bY3KC5AAlPttLPp9vcGJS7Sfcneb8xquWCn+DNrDMJm3QnmWo0secBSBTV7X29e25Otd4DfnXTlGt1JMjL0lTUGahkBeXTx5UjIOPiRCQsMhFM/VF31zzl5c31y48nNt1ocIGfTKGZgwM
Received: from [127.0.1.1] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id p2-20020a056402044200b0056200715130sm1424435edw.54.2024.02.14.07.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:47:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Christoph Winklhofer <cj.winklhofer@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20240214-w1-uart-v7-3-6e21fa24e066@gmail.com>
References: <20240214-w1-uart-v7-0-6e21fa24e066@gmail.com>
 <20240214-w1-uart-v7-3-6e21fa24e066@gmail.com>
Subject: Re: (subset) [PATCH v7 3/3] w1: add UART w1 bus driver
Message-Id: <170792567823.152954.6100416373090677412.b4-ty@linaro.org>
Date: Wed, 14 Feb 2024 16:47:58 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Wed, 14 Feb 2024 07:36:15 +0100, Christoph Winklhofer wrote:
> Add a UART 1-Wire bus driver. The driver utilizes the UART interface via
> the Serial Device Bus to create the 1-Wire timing patterns. The driver
> was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
> DART-6UL" with a DS18S20 temperature sensor.
> 
> The 1-Wire timing pattern and the corresponding UART baud-rate with the
> interpretation of the transferred bytes are described in the document:
> 
> [...]

Applied, thanks!

[3/3] w1: add UART w1 bus driver
      https://git.kernel.org/krzk/linux-w1/c/178cf9db9e6d8fb0c026098c8f2d1fd92ae3d79b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

