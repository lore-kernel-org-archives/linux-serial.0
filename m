Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7115990C
	for <linux-serial@vger.kernel.org>; Sun,  8 Dec 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675433; cv=none; b=q0Et0OKA8ztA+7Y8c1LTiLx5i5gLsby3y6FZzkoaM0zPa+VPEHDUt+Qlv5aHOS/ANQar6y4TQQsHI/P/qczYPVL9qC8ax79utCH0FDLqKNqAKYbuH0FReOl55hHWl/KdnNSetrkgCDmrTwYKUkZOMzXpulwKnF9VuuTCfcEVgLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675433; c=relaxed/simple;
	bh=OFDmGehoK600SvToI+7RLgjBAFQXs+mVcolPpCj+dNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9RCb3B9x+gSfi2nnbQkW/16Fg3BlsEPcwVFAHhoAZA0Oo+cIzGFNfidIEovM36owsc18P/6yQs0RpMdhUqdJjwKynwkYKsIqPgxH3EhhREUdn0GdCD55hjH6S8m4kRdx67f2F+dXYfIsVQI/nL94imdZWUO8Tg5Im9A7oGE0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OS7lJW0K; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OS7lJW0K"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa67333f7d2so84141266b.0
        for <linux-serial@vger.kernel.org>; Sun, 08 Dec 2024 08:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675429; x=1734280229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qhusLfuIgsMbQqxPaQUwX3ow4Gf24/DeZxPYGalAiY=;
        b=OS7lJW0KQwPj/dpK1GsZlGQK16iHFjm/dbXHlyMetzafz2DYnsdy8vBj9qCJJT9MQL
         r1Qco8HEW68kiTVWGTw7+gOrzyMzM/kgyHS/vOZmr5cLxLilwaEQzIoR5WM5qsezSQCC
         defBDd+FhjdybNql+C6qk13L6f0giVSdbO1vvDEWFNpf/OCbPFHBUO6xneIbOe0ygXUt
         csd+/DAlQcm2rB5QCjNcMwtBV0AapOSgwDrV78pVpwyjKoRWFWTyP0mZ6Z2kDZj4O2Sn
         8QzRiQ+4qM8dxfwLD+7KMaMSgiafwcEIBO0IvDJgEnw/Pi3p/aXvmEj7pS0feJAzcSaS
         dKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675429; x=1734280229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qhusLfuIgsMbQqxPaQUwX3ow4Gf24/DeZxPYGalAiY=;
        b=BqaKd38NuUXgx4xlgKySzY5zLWjyVZd/dSxslwPtE3u8qh/GhiiC48UZNdMIhqbrUU
         0ODVNzSWx+if3HvaxtzZQHAOz0ZbX0VdTgyu/CBPPtOUrg/XjvBp+9aKgHk51hrgeVVf
         iDCI1/c20tP4Q6rHADi9e0iyXs9CBDQaZlYlQcQGAcFKWJAS4IfNx0Hbvrc6D1lOBe36
         pyL6bpMtdklQh2pauEHDLqqgaGkZr+kjerDM3qor5Hr9tXhechGZ85JYIu2KJMyrVLjT
         i+qUs/Sl6XRGi5DnyZTtg+kkdMhrijfzZFEQhJcjWmX/04f0i0QvnbL4gXzDD2KCsB0z
         u+ng==
X-Forwarded-Encrypted: i=1; AJvYcCVgyTb9uwg/y9erRL39DY4CNPDXdqWzK/+GSEHUNapVIGZVXFSI1WQAMlbKZsoYtLfICyXEFgEFCpwLkZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+Bq+/5Dsv4+eig5IYQthv0+WhgRK28bQfnNjOF8cKHQUndOI
	fYfk6NCP8aaM0fHWwODzNWiFjittaX4i30JNPfgE7FfPlwcln2SA1h0QxhQQYpY=
X-Gm-Gg: ASbGncumdin1/vBs2DGRVZyvyvccsAuSttwEl7TsAktuThgNaMZFcjA2dVEJOfJK2cb
	F5nmsn6ivuYsJB7dOWtThzhr5DxASuxuB4Y4rMmLoGYonFp0E2UB0WJEzaZ9CUUKzNyKDPReWmL
	/+Tsb3/cX6ldD4cE34rIiHWCGmBUgwvHnLdq2bI3gtw3HY//nUx/zG0zgbUeH/6g4mXn/28Y73/
	rrovGDePDUgaEAoFIHmRBvdoGx7QcWytJV9MAhRTzG8WYo7kBdBDu5opjE=
X-Google-Smtp-Source: AGHT+IE7YDoN13k+KH8JOtiRLrAMtuSmlPV0i3qWniWezo/cHtHK2Sxr/2xiHf8TyJV2wCkaLPDXWg==
X-Received: by 2002:a17:907:8315:b0:aa6:7148:91f8 with SMTP id a640c23a62f3a-aa67148942dmr286404966b.4.1733675427547;
        Sun, 08 Dec 2024 08:30:27 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68a97498dsm5949966b.99.2024.12.08.08.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:30:27 -0800 (PST)
Message-ID: <022a34e4-2a9e-4cb8-8998-d5decc4d9fdb@tuxon.dev>
Date: Sun, 8 Dec 2024 18:30:25 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] ARM: dts: at91: Add sama7d65 pinmux
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <a8f880b89cd4470526a2955a0b6aaaaa24ba65b8.1733505542.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <a8f880b89cd4470526a2955a0b6aaaaa24ba65b8.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add sama7d65 pin descriptions.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
