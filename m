Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE6B4654B
	for <linux-serial@vger.kernel.org>; Mon,  8 Jan 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxAv++Am"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-680b12e5d42so16390986d6.3
        for <linux-serial@vger.kernel.org>; Mon, 08 Jan 2024 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704723957; x=1705328757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9atKNkCY7lxaNFN54oiB03vJ0WvAQsiMxxbA3uOpJJo=;
        b=HxAv++AmFbl0uOddkisZqolW49+5/sYZDmLWn55JNbPR0+0BLwAvulL5LOLtXtDYtI
         ekgeHSgkn1R233Ht51bVb+yyaVPz+mCOvghU9jU7pNrABUDI/EDExdt6wub3q0D5N9zX
         Hab6FgMqgj+wpjAwT6kdhsHlsvU4N+JKrpqFC61rjLGFg0axJjgcwCL6oSENCElubm+h
         7dJEOvlaRHLLRYn48uO69/Heg/+PwbotxuxrD7Ape5MbtAihozkhxmLZC2Tw8ZNaykbQ
         CWFVO1BTWbqt9e37D3PSpOG7izWTQFvacx1LHyDFyHr3+aIhOYZpTQf7PJu1MNWO9oHv
         qowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723957; x=1705328757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9atKNkCY7lxaNFN54oiB03vJ0WvAQsiMxxbA3uOpJJo=;
        b=lhJUmxGiH82oaXDfplteDt4PCtb3hBZ037hbhw62OCqwa/gExvEQRmATrfj3xMbwWK
         E8qeetHT4WM8/SfWstIfVA9qXUyNnXr+o2+anf+TTdK0vK6lcIMBNNeOmE/Cfejso95f
         tiZ9B3oP3LKbgb8ceemC9MsZLMbWNQ78ba9DIVw6eGJu00cVIpQ8oeoUK1vjnC8EOdFY
         mi4Du+OTqoLsdGNF920dph+q4msM8ryHiLXTZoW/EsyF3UfMRRmKL4mDiY8XC9OC3Z4G
         Sifi8UTF00ZaYsfdrfvV46voi+lnU8WqzXosG3TINXgD0wY4ojosyMSDhx3M8KHeiXLP
         Slkg==
X-Gm-Message-State: AOJu0YxHaM6koLf97BWBz1WMszxASavBCfH9H7otSCH3p4SCCH+8mArq
	fVTsYC1a37gRINADTBK9S4pWtpdgWOjanDW1g9eCGRkukA37vw==
X-Google-Smtp-Source: AGHT+IGYBiojUjS9fJ10IBb9JbhjqsBHMSGrip1FcvfI6xmIy5S39asxIjjlSyHXTw4klyjrfzRzcW7TpJi92WQvvuI=
X-Received: by 2002:a05:6214:2683:b0:681:212:f9a9 with SMTP id
 gm3-20020a056214268300b006810212f9a9mr3329090qvb.34.1704723957739; Mon, 08
 Jan 2024 06:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228125805.661725-1-tudor.ambarus@linaro.org> <20231228125805.661725-4-tudor.ambarus@linaro.org>
In-Reply-To: <20231228125805.661725-4-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 8 Jan 2024 14:25:46 +0000
Message-ID: <CADrjBPrpooS=8WERcQ8zUJ=tDXtWncPpyxQL2ov4PEqQ0wmwYQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] dt-bindings: serial: samsung: do not allow
 reg-io-width for gs101
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org, 
	andi.shyti@kernel.org, alim.akhtar@samsung.com, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, kernel-team@android.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Tudor,

On Thu, 28 Dec 2023 at 12:58, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> All gs101 serial ports are restricted to 32-bit register accesses.
> This requirement will be inferred from the compatible. Do not allow
> the reg-io-width property for the google,gs101-uart compatible.
>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
