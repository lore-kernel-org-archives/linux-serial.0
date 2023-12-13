Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/1u/9Xv"
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4D7A3
	for <linux-serial@vger.kernel.org>; Wed, 13 Dec 2023 11:16:30 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so31769265e9.3
        for <linux-serial@vger.kernel.org>; Wed, 13 Dec 2023 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702494989; x=1703099789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlTpAm/op63WnQxBaylZlpeqHoqAOxaydKFKKqlx8Ys=;
        b=K/1u/9XvSwFZjc4NizGQAtKgEewlWlN1eADznjStLjS4LPoosFSfBc4FopLoYpodgK
         SAbpdzUHOspufaY1UjIi297bDt+uFlQIiCYTSnR/XO8Y5x22IQTjnnqZ87gT8t6QSvj2
         9BMhZ4PDH87YnVOHnESMCh94B/gwfDxmuCyyjQBZAVyp2+DXfU8TyMDlaZDvs0B9LFu0
         I7eTbz00ASvJVYQ15SMan4p4fvfBgYGa6GlHY0bQyLOR1DZCIXgCBB6Mdq7KCHOdPEzH
         6N+yEgm3GOAERIDq27CedwnpLLn0woZUqn5EzYFO1QiYEmuywoS4SsPbvzb8jdDW1J7R
         ewKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494989; x=1703099789;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlTpAm/op63WnQxBaylZlpeqHoqAOxaydKFKKqlx8Ys=;
        b=W2PGdeNiC52rhf6iHSiV52MqUA8VZQY2aGXjgCP2q7sQg401Ar0ncPuhHBZrbF+DCn
         hVYccsbnt7WaWAaGPpwDz/mHJkK3teU4B7QLlSRcz0Ht0GnalkHe9wwibr9TmKHvWJW8
         1lhvt/VpCoSbI+aNpHhy+yi9hiWSM6nKfi4Ak3NwYqqyWCwAlSQhiQTcx5Xv3RnCpwwz
         zPrSxnS51g6ebDlrK+Qv06XwVQEy5cHjClY1ZqRXnaEiIyPrQjNrdDijSd1Jb3g10anX
         xWfX58L0U+lJgY7i8PBLxF0bBVDSoVX/MyTCQGZgTJQq4cBD0LilUlREEoujiJ9Gdi7e
         LAkA==
X-Gm-Message-State: AOJu0YwpjoVELgbB1s6/oiP+DvDATS246crZTPeaG7F0dnJy3SIcUhK4
	L8+A1WFNu2QjayD4XDf3PRH4xg==
X-Google-Smtp-Source: AGHT+IH1ybS2vp4ps4bx5XfivcvSrtfbsmpPh+9TZiuzBpYyh8K77ozNJBAjVyJ9cyE16seU6Xnbog==
X-Received: by 2002:a7b:c457:0:b0:40c:267f:6e79 with SMTP id l23-20020a7bc457000000b0040c267f6e79mr4619281wmi.4.1702494987371;
        Wed, 13 Dec 2023 11:16:27 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b0040b37f107c4sm20190085wmo.16.2023.12.13.11.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:16:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org, 
 tomasz.figa@gmail.com, s.nawrocki@samsung.com, linus.walleij@linaro.org, 
 wim@linux-watchdog.org, linux@roeck-us.net, catalin.marinas@arm.com, 
 will@kernel.org, arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
 semen.protsenko@linaro.org, saravanak@google.com, willmcvicker@google.com, 
 soc@kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, kernel-team@android.com, 
 linux-serial@vger.kernel.org
In-Reply-To: <20231211162331.435900-15-peter.griffin@linaro.org>
References: <20231211162331.435900-1-peter.griffin@linaro.org>
 <20231211162331.435900-15-peter.griffin@linaro.org>
Subject: Re: (subset) [PATCH v7 14/16] arm64: dts: exynos: google: Add
 initial Google gs101 SoC support
Message-Id: <170249498523.308886.9560205658028235022.b4-ty@linaro.org>
Date: Wed, 13 Dec 2023 20:16:25 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 11 Dec 2023 16:23:29 +0000, Peter Griffin wrote:
> Google gs101 SoC is a ARMv8 mobile SoC found in the Pixel 6
> (oriole), Pixel 6a (bluejay) and Pixel 6 pro (raven) mobile
> phones.
> 
> It features:
> * 4xA55 Little cluster
> * 2xA76 Mid cluster
> * 2xX1 Big cluster
> 
> [...]

Applied, thanks!

[14/16] arm64: dts: exynos: google: Add initial Google gs101 SoC support
        https://git.kernel.org/krzk/linux/c/ea89fdf24fd94cd37a7e2c51e09c39423ced7ccb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

