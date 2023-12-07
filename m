Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d29IBFFj"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CC410CB
	for <linux-serial@vger.kernel.org>; Thu,  7 Dec 2023 05:33:45 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-33330a5617fso951147f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 07 Dec 2023 05:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701956024; x=1702560824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOjuvQ1knDsOf99mi3hFggOSmu3Whc7MN8Fp35NQ1P8=;
        b=d29IBFFja8GOlr7TD5iaQ1dAGpzoPVT7meFpiFFPx5MK6N0VwJIBYd7EB+PxJDc4pF
         KqAW9oPgnS5BRlOTVP6BpR9rDYzETzBB3J3qJdKM82fGOqjTg6fX7zYraeUaT7GxCQUa
         QK1y2zxxynWuBEXYANutgdLUoYXl/KudC4/RzdKEa0ogZcmlZgdVIoZxv4gfzunrl/8h
         6vKlMYQbYEhjdtxzAOT2c/KPpQSCytYetG7RIMk51cs+t55oMXUl3zMh+sBgkh2RwbpU
         tFxP3IuZ0GcxY8NvvPHpNzR1H60k1+enzOjvj7bpyz0E7P+SpI9fnZMxcE/1LMN/FFWD
         0xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956024; x=1702560824;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOjuvQ1knDsOf99mi3hFggOSmu3Whc7MN8Fp35NQ1P8=;
        b=dlVB2O7Ij/M1LgKs1HrP6KWF8ZuNDF7f5l5Punt4o4Um61fQMLjljG1H1R3UgZlI2X
         yJJk/wA450CABT2a2L9/UwK8Os8qX3vzvwiwF06GwDCMW4CRXt/7IajZZrwZ4x+mMsNA
         JIq0/Mp3FvdLxkwMNyegpO1o8UXKKo7IcrbL0vp2DbvbwD/P1X5KNb6GoWytH//FtHkJ
         eHavVeOzHCvFAClCTnWlhlod3WhlZlZnnWuQ5hOqXSoO5HiBzkHWyBBvlHQr6taUiDw+
         cKSJewnDxPDfx/lOC6OzkhRBlKrraN1v1buTmXAzLEshlCKfgV7hki3GFDPN39qsDFnl
         wHkg==
X-Gm-Message-State: AOJu0Yxjh7Jx3PjKFinAQ1iGt7jUPh51yt1o3CLo1AqSulfUggpjcsH4
	EuA1bN5Uwffi/gZCdnSEUXptOw==
X-Google-Smtp-Source: AGHT+IEl9KbxTbmb8n+WvISyxYm/HTeQm70dDUbz9cfV9RUKa1Wk27SjB9FMgD9xanu+1rN8Jo3LOw==
X-Received: by 2002:adf:ec0c:0:b0:333:2fd2:5d30 with SMTP id x12-20020adfec0c000000b003332fd25d30mr1678939wrn.98.1701956024085;
        Thu, 07 Dec 2023 05:33:44 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id p6-20020adfcc86000000b00333371c7382sm1471548wrj.72.2023.12.07.05.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:33:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, linux-fsd@tesla.com, 
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
References: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 0/6] dt-bindings: samsung: continued - add specific
 compatibles for Tesla FSD Hi,
Message-Id: <170195602173.92721.14927713507913101589.b4-ty@linaro.org>
Date: Thu, 07 Dec 2023 14:33:41 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 05 Dec 2023 10:22:23 +0100, Krzysztof Kozlowski wrote:
> Merging
> =======
> I propose to take entire patchset through my tree (Samsung SoC), because:
> 1. I already took similar work this cycle:
>    https://lore.kernel.org/all/169997520487.6747.17671551558724027958.b4-ty@linaro.org/
> 2. Two new SoCs are coming (Google GS101 and ExynosAutov920) and they might
>    touch the same lines.  It is reasonable for me to take the bindings for the new
>    SoCs, to have clean `make dtbs_check` on the new DTS.
> 3. Having it together helps me to have clean `make dtbs_check` within my tree
>    on the existing DTS.
> 4. No drivers are affected by this change.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: i2c: exynos5: add specific compatible for Tesla FSD
      https://git.kernel.org/krzk/linux/c/7677fdbc036b93a882f660ca2484a6807e72f0be
[2/6] dt-bindings: pwm: samsung: add specific compatible for Tesla FSD
      https://git.kernel.org/krzk/linux/c/edb32ec3cea79b518e6af841ecb01c839818f562
[3/6] dt-bindings: serial: samsung: add specific compatible for Tesla FSD
      https://git.kernel.org/krzk/linux/c/921f4f1db7f5bf6798349db8a4382c032f144b98
[4/6] dt-bindings: samsung: exynos-pmu: add specific compatible for Tesla FSD
      https://git.kernel.org/krzk/linux/c/54772f1d61cd99ea1ed0febd4187bf24ef63bccd
[5/6] dt-bindings: watchdog: samsung: add specific compatible for Tesla FSD
      https://git.kernel.org/krzk/linux/c/bf1e24c5330af06b2f7f1a166a1011d8d48e8651
[6/6] arm64: dts: fsd: add specific compatibles for Tesla FSD
      https://git.kernel.org/krzk/linux/c/5f257922c5948c58669346d5cda371632108f266

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

