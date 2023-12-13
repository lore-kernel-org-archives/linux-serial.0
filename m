Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulL4VgWH"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E05F2
	for <linux-serial@vger.kernel.org>; Wed, 13 Dec 2023 11:16:31 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so50878185e9.0
        for <linux-serial@vger.kernel.org>; Wed, 13 Dec 2023 11:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702494989; x=1703099789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVw2BVonf32KOGcKItT5pWUVEE4nDhvDMvdCf22c6bU=;
        b=ulL4VgWHFLoUZImYA8rZAF8Gw+FGHb0tHN1ks6I4d4WTMlseOwBYjoV269y0zOu6gz
         6jv3PAadH6b/BJs8rqB9QFH/VrO+HJUEln+o10MYSjMblVFrRQWKfB1QLGkALZ5wjU9n
         s6CIZjicKWAm/ZVf8jzfeHKL7huM8EvAwGJP5EqagbxxfNtIAebRTu50tqZmlo5gbnxM
         8+D1Xs/QK05M3Dg+SiLn+uQrEywklneUH09H1Tz7qt0zJR8gKPgL0zCTAC68GgQg4JqG
         97Nf06qFcB2J0Bq9m8jSKyxvGibDgOB3s1+jX1oSYC9Wko6QyeWvA9uMMdF/zI34nPm1
         D7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494989; x=1703099789;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVw2BVonf32KOGcKItT5pWUVEE4nDhvDMvdCf22c6bU=;
        b=R6/t8KCITdWpyi591cUT62cq0S2g6nk3uHfcsK9HAIDFVmJvDhboZURMMhhvX/BJ1v
         AT8rBIUR3nU+rjRz5iVnal0cS7/kx/o7apRqH/HcHkPfx0XYmDe2+OQzfAzA1UW0FdNa
         Ii5YYt+mFko3qKutBnEbU3AhDMZBHbwdiGcJpE1PYnNeQW/O4Vx8u0G5l3KGBHgsxUMu
         OV3CvDPNe60dlxUlMU+LtyDAst9JwUPrZa+4ZapY/nVwhHSvBZwV0kz5l60Ljv7lc5jW
         BqwXmmsFz9fBcxt5p3eD5BvVctMWCrUo0qBLr0jODywJN4F2a8EevaySF9jrxFZ3vliJ
         0DWw==
X-Gm-Message-State: AOJu0Yxh1EKoBGhFBHN9JLj4OQm55811bsKxEuyEiambEc0Akywxztsb
	Ki0xEqBi/bgiJOHNmobvApbH/w==
X-Google-Smtp-Source: AGHT+IGwAghg8wXV8vvka2M2jii5qfSHBwxTFPfU579NhU9vphZwOVpFyaOtF0ynqQAn5Xk3KhD18A==
X-Received: by 2002:a05:600c:19cb:b0:40c:30fb:60bd with SMTP id u11-20020a05600c19cb00b0040c30fb60bdmr4462530wmq.144.1702494989593;
        Wed, 13 Dec 2023 11:16:29 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b0040b37f107c4sm20190085wmo.16.2023.12.13.11.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:16:29 -0800 (PST)
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
In-Reply-To: <20231211162331.435900-16-peter.griffin@linaro.org>
References: <20231211162331.435900-1-peter.griffin@linaro.org>
 <20231211162331.435900-16-peter.griffin@linaro.org>
Subject: Re: (subset) [PATCH v7 15/16] arm64: dts: exynos: google: Add
 initial Oriole/pixel 6 board support
Message-Id: <170249498744.308886.17508790332822828341.b4-ty@linaro.org>
Date: Wed, 13 Dec 2023 20:16:27 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 11 Dec 2023 16:23:30 +0000, Peter Griffin wrote:
> Add initial board support for the Pixel 6 phone code named Oriole. This
> has been tested with a minimal busybox initramfs and boots to a shell.
> 
> 

Applied, thanks!

[15/16] arm64: dts: exynos: google: Add initial Oriole/pixel 6 board support
        https://git.kernel.org/krzk/linux/c/6a5713fc7853c3998c706cb809c5d9fd1c6acaa5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

