Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBA50EC11
	for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752831; cv=none; b=SCesvk6XikC6mV5Sa1zvlS+gelNWgwjk+dRWc0Uh+tAIIxvNaQn0gGbVzFVA63HFCzHD8/BuzBPEyHNLE3G4mmRZgEgTrWvzxs7EdkGDDQtdC3Aj04DY2yB9PRwxX+qToG2Pn59tl+Qe6iIsMc9nJTCdz64S8dXE7XjlFC3ZkkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752831; c=relaxed/simple;
	bh=BbX8RY98cbW2glkwb44ypYKnRm3un42mGYq+Qy76YHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=erUbrb4O80ePBA3/HvmNIIbDNqGWVouKUVqT5ZKaxRtHhcJLG1Pxl1LJJOM8tgCX2k3i+3MhnD5QMRxXv5fovy8kqXW78eQaC5gViSWaafO24ychlDocaN7Yipi0FviPinsQvJW7hVbmhObUM4rT3rNzM4nztDuuAUyK492weiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qmKOTGld; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmKOTGld"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f13d76so1156723e87.3
        for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789752823; x=1790357623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=huJxWlT708nmfTDdQjHUmTyeWJoEnSNCINl2pfaGmoo=;
        b=qmKOTGldGCs90hDD9GQF84M22bYOLE8I3b4zEA9T5UqJBWRcOrx+UKnn1uKJcTxBre
         XBEbcfFYWeS2QGORwFmllQkv1PFK6eOQ5Ln6rMRJ2Smf6GyEKnsakxiqj/C7sysxo5eY
         DbeOPRPaGjjjk34TIqr0Rt8WH498byM6N/6bnly048CspboPM1+d85xIR7ZgUJWe1f6j
         K5oCcPTWSIAzWv14j96b3Av415a6Ea3b77B7p8arolh4UK6OqVyMlZtmGtUjPWTmm8jZ
         WWKbNMmXolncqDEn+UwZeAle5geU8FYW70fAWMYwKUw7gkaiN0QYWa4ySn9f8uZhX/ob
         wQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752823; x=1790357623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=huJxWlT708nmfTDdQjHUmTyeWJoEnSNCINl2pfaGmoo=;
        b=qxR2GzuhFywuD+yz349Mtx6YOzmCXgIzD7wqoohyEUnJ+Sr5zd21Wq/gdZDEDB8CmT
         kvKGc25oB1QRDVJP8a1qryn1tepiJX7i4MifkRrM52KhJ0JpKVHDF9xVrgvA57bYJ6d7
         9wGm3B0ynVw32PYBALZU2ircK5g2TQp/fZ6XyHOemT0Urtj0Xe5vaAo7MzEMySdFMoqh
         BjD0onYJ30Jq/nTnI6e6+zPJvBlafrolJOA3XIyjBmimaFPFlmG29B3lBPn3AfA+CQlk
         e7CBcjk+GTjPV3nqkx8AwnTU02q07Dom8/JyC08c16NOzgCGwaPu+YCcevujT545fhxB
         A2Hg==
X-Forwarded-Encrypted: i=1; AKwUvBxs8QrOYvkUj+x/RaX+pZwD5pai89pKZLN5XmS8P41atEO086T8l3DjopAAWBYwZGgTxLSYSI8JUsyT2DY=@vger.kernel.org
X-Gm-Message-State: AFuF++lEuL5nJdBFLYxzdWzR35GUbfHHb9RcJAsb4KQNqQYDi5y0GeOd
	kyynIpHXv44rPVxDHtnRSr4THD1akiN3mbmfUGtmVJUZAm0aitjtzaz1VSkeYwp91H0FFsiDqtP
	WazX0Qt0=
X-Gm-Gg: AYBFou2oeqqqESlVyPelK+UCpN0RiqKrkSWufk5xnQruFue7+hx0qFNCiiCymgLPXJS
	45d/OAim3PHcrr5SUTqUIwRbMZtryxWlKSS5SIEU8zzxQREza6ykhWvmjdS5qhxvVmTXUrx4CsA
	Iz+ZCtctKR7oAiA9idwXpZ9NasGVaKOt0PVx7NRQO0KpA9Ezc1nK4hoKXqwhGVKcPjFxKt5bGI8
	lY7G7/uC1cKTFss07veVj6y3OodE2gB3UE8AeaY9H89C/zieSNjK7EE0duVG5k1m8Dbi8O5bttf
	h5UDzsRP/oEEpctWrSa+8SxzN0hXqzFeqAmAdIh8Av1wixxhdJbJTeXjTC4NL6GjuJl9by47/fS
	kEiHu3OR/8M2OCteWimfey73J5zvUlhvf/qK7faWRhmwUBrduzgiJhjYcTCONIW3vVYSMkdSzL7
	jX3DDc9ei0hg4VFOzhJ+mj9anGbZw/BbZFpHQgi+8Y+OKIgjTKV40f6379gTxc/O3GEIqvl56fr
	EO458ARsJqJM3O6e25voe2CSsB0+ieUOPrXU3xdist4soZXRmULzqRbp50kfLnBLa0dbz7Qidmx
X-Received: by 2002:a17:907:1c91:b0:c29:386c:58f2 with SMTP id a640c23a62f3a-c2a15e1ff48mr321275466b.38.1789752412145;
        Fri, 18 Sep 2026 10:26:52 -0700 (PDT)
Received: from petegriffin.c.googlers.com (116.118.90.34.bc.googleusercontent.com. [34.90.118.116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a35701d8bsm902966b.27.2026.09.18.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:26:51 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 18 Sep 2026 17:26:37 +0000
Subject: [PATCH v3 4/4] arm64: defconfig: enable Tensor G5 SoC family
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-contrib-pg-pixel10-initial-dts-v3-4-c94e51140509@linaro.org>
References: <20260918-contrib-pg-pixel10-initial-dts-v3-0-c94e51140509@linaro.org>
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v3-0-c94e51140509@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 soc@lists.linux.dev, Douglas Anderson <dianders@chromium.org>, 
 Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
 Brian Norris <briannorris@google.com>, 
 William McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-serial@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, 
 Brian Norris <briannorris@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=787;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=BbX8RY98cbW2glkwb44ypYKnRm3un42mGYq+Qy76YHQ=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqrXRYGuQ5/L4khzKLHRvREUl1l+2lwJGoJSQiY
 SGyFcbuWBCJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaq10WAAKCRDO6LjWAjRy
 utArD/9uj3S4/40eqQyAQNg2mrd8YRRLVD2a+iFnXlDd04AKI6CyH9Aw39xkFrcjJfJ4hkBGr+C
 bq8pFZNwJu3DH6NN/ZgNqnsiuxemOfw/aUIO1dpSTeW6BvQla9JT3YBduKlaAStNeV9HLWE0cdK
 FGDB8mVSVVJ0j/jYlX3BOmNAium/Ewfw9PI0ALpuXmOJ60HZabfOMYnun2JV43MuRmmJx+smUde
 15IsHXU6GQ15cwQFp56h5tCUisTYD31g39lmK7iD0Qpwd6BC7U3SEFO1LiorExYEECyq9C7h+Mm
 ATP1VxNycE8kVWDXVD5BlcWBgeQeyqFLUcp0wexvmyoxLICWQGWrCCnipjciOVlKfY4Tc6OyEbG
 vrlzf1SPtQJMDhH9y26QfsrMaVvnVHHdMrhtrFblU/rHj/mP0MkdHSSktmN0M2Zw/iXgUpfbzBb
 Sgiz3ymLwkb57NgSqWh4ZEmseH5HGA1gI/D7/tMq3a35ZQZsASN2N8vyisAjaCNPSih+SmS0mfT
 RnVnZKuvriyPYy0oGMaosjltQVaBzFjx9Ok1WALSvawKVkVkIzo6Du0GkfXaO6QcdiwsAHRhkz8
 8q31d2t0PWWn05xdNQ7eM6h+2MYYbGKpYmzkwJcNXA6ObhSV2vGM73rn7RO/wrqM0hT1uhF5d2E
 A+fovbmpX/pet2g==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Enable the Google Tensor G5 (Laguna) SoC family in the arm64
defconfig. This SoC family is found in Pixel 10 and later phones.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 982ea1758eb66..75000c12ead03 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -51,6 +51,7 @@ CONFIG_ARCH_BLAIZE=y
 CONFIG_ARCH_BST=y
 CONFIG_ARCH_CIX=y
 CONFIG_ARCH_EXYNOS=y
+CONFIG_ARCH_GOOGLE=y
 CONFIG_ARCH_K3=y
 CONFIG_ARCH_LG1K=y
 CONFIG_ARCH_HISI=y

-- 
2.55.0.1082.g2b9226bbc0-goog

