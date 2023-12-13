Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJHOznsh"
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0465BD
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 23:50:03 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1915034144so860189966b.0
        for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 23:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702453802; x=1703058602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvtn/gz8YL6Ce3HXfGFLuvh0AJH+XzrObcFPY0JHO+Y=;
        b=nJHOznshjaKJK+XR2lW4Qm7ZmpyY/lOx6ahMPrNJaPkCfVAfr2TXMiFmtzro9vpPJ7
         aVwz1wfx5mMahUOV6vj34Svgl5THp7iQSSLcfP8xNpUy08FEHwub578kGf2RIQvQ09xY
         uGg5aikbKP++haZmKZ5nLOri09yLiIlbbZZJgS8Cld/Cgzdbg6cbg1N3knchu+epF9Ww
         NmZys7GfQHf7K3znSqW4PsvdGYArYBMkldUzUZjSha+NYeUJA0REvT5ZidADvLRAuteR
         unSf/QbJ8rzKPUpUYsoHp5j1n7cWGyvEL046iJSThpW2xTnSGKKGIFWCwoYJNaubdCcx
         Mm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702453802; x=1703058602;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvtn/gz8YL6Ce3HXfGFLuvh0AJH+XzrObcFPY0JHO+Y=;
        b=WcdVoww6yxY8hDZmpansHX18/UDfmN1nDw7H7eAeS4+qYbrsgKEj+lVh5NgEX4HF4P
         YgIGWZs2wVu5jp6341Bl/d0VKKHfopnSpZCxs6xNylClsknItXGnvEWJk+SZLZrzSGKy
         isMjSNL9s3ZgSmbFh9VKPtaN6r/e6gMtbJzhV7G4mlYXkYKnFAyqgzQYsIldeFqOL0mg
         WdvVpOdSo2iapKjPwZ6Dlw58cDHqOlV4DlLQqlyh2rJW6Lv4/hXIv8mZDqnbmjecnPHH
         EDKVRhROiYiGXKu2x6M9dapY/vxbTYw4WwbjevkS3EWWtKz3G8iIPtGkfo+wK3Xc+zY2
         IC2Q==
X-Gm-Message-State: AOJu0YzjKliD3EtZ1B7qOU+NtFd+3h83UFFhSmWCuxOjqxC2EPPPy8AJ
	VVYR6LhjgtljilHkf6pczf/HXg==
X-Google-Smtp-Source: AGHT+IEY8S5EAkfl0TgWnTfT9xclu2RZQfeyA+EIuy2UHvMlMrR/3Hv1WbUDbQq2o9H2HbQysVp8dQ==
X-Received: by 2002:a17:906:106:b0:9e3:fbab:e091 with SMTP id 6-20020a170906010600b009e3fbabe091mr5413257eje.15.1702453802327;
        Tue, 12 Dec 2023 23:50:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vt4-20020a170907a60400b00a1e1a1dd318sm7374141ejc.137.2023.12.12.23.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 23:50:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-serial@vger.kernel.org
In-Reply-To: <20231211114145.106255-1-jaewon02.kim@samsung.com>
References: <CGME20231211114215epcas2p226d66c6dd01a4414559272c648c3d464@epcas2p2.samsung.com>
 <20231211114145.106255-1-jaewon02.kim@samsung.com>
Subject: Re: [PATCH v4 0/2] Introduce ExynosAutov920 SoC and SADK board
Message-Id: <170245380069.18789.1595497375493388753.b4-ty@linaro.org>
Date: Wed, 13 Dec 2023 08:50:00 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 11 Dec 2023 20:41:43 +0900, Jaewon Kim wrote:
> ExynosAutov920[1] is ARMv8-based automotive-oriented SoC.
> This SoC is the next generation of exynosautov9 and AE(Automotive Enhanced)
> IPs are used for safety.
> 
> This patchset is the minimal set for ExynosAutov920 SoC and SADK board.
> Currently, ramdisk console is available and Clock, UFS, and USI will be
> added after this patchset.
> 
> [...]

Applied, thanks!

[1/2] pinctrl: samsung: support ExynosAuto GPIO structure
      https://git.kernel.org/pinctrl/samsung/c/884fdaa53b38921165cd9afdb230502b4e1690b0
[2/2] pinctrl: samsung: add exynosautov920 pinctrl
      https://git.kernel.org/pinctrl/samsung/c/6cf96df77338c6a7e753229fe6d330ab60e28cda

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

