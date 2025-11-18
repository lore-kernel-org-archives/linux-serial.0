Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD9321F51
	for <linux-serial@vger.kernel.org>; Tue, 18 Nov 2025 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434106; cv=none; b=I6CeenLHPvkjjKhcSZM7Wg6kkh2mnKEdnZg0YuvTklZ91vwdeY9wKkUBvTWhyBpcUHozbSw88lCzEnep0M1Cye6QVchK54SRDEE6wavyFcLr2IQnOl+epn3N1M0FAd7i+Ds5F04tkxoNFzfpQDzQLETkmCCVCgyFsDq4lmLRpj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434106; c=relaxed/simple;
	bh=0EsSRgGPdKQbPvgWVcWDyZRWeoYqgoHBnCEgKHLIRHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxl+wRHcaLybrM3oGn9DDpswD/Qe9r4m0Hh9/Nnq4LkwGtrfPvYxCMoS8Lkgt31W01xItx8bOiIFAtadvVSc7Cn35xAsy+yiFsmg/RlORNrHhWRJZ02zLpxNODqqJ5ZL67jWt/Ccnor7CsI5ct2dJPrKSWPkbjKn0ytGcCwqdvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XW35zg1i; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XW35zg1i"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6574d7e451dso964431eaf.0
        for <linux-serial@vger.kernel.org>; Mon, 17 Nov 2025 18:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763434104; x=1764038904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K5Hp059A5Uei2IffQzjxZlhfXpudEyod1/uzyZ2qBEI=;
        b=XW35zg1ivNVt37cuRebuiKOIA+C96ltuzB/B2SvSHTJuZLwH2VGKAgQbFaTEcHsI5i
         E/4z9BLptZ1+aNJDNv9JyJVS7F88LlnDUBZh93Lotj+mth8xG+41F4RHCrVzkZhJoHMI
         9IGpCkH7GFuo6OrqHF9/lco7XiJYF0YUdFNFn6HxAQHpZ4tSZGO+f9NLa5EuZkJ/l2Hn
         v+nDYWup5fSnKyWK5URFkRqEgJjo0AkBy/z40wZqQ0TMT9Y5/oVZwptsamjhhnuXfDVF
         6oe73iiuH/WVRQG+Ua3nqbKGn93FBnFJ+wD7rVxfsmzv5nQjLq2P9i7xqk5r6M4ZIg8o
         0bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763434104; x=1764038904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5Hp059A5Uei2IffQzjxZlhfXpudEyod1/uzyZ2qBEI=;
        b=LHkUs1rGczfgKMKcbK9qgfAygM6DCg/qqVpTCA36U2d/xEOZp9GJL9Q/3fvouW3W7M
         dxuDGWqKijF67sc/U/uFWUYIkD6NRcNFsmJZJYkAWJ/Ixz3L34Yrq7Fzze0xQKgC1Uh7
         a7fDZN82ziF3xx6IfywuKy7q9Bn8tHuJVha6Ov8ThxL0wUdmY9YTSUgqNl/hQYo6jmuv
         clXP77ch4kWYJJ+h0icym7JbTvIvB8Gd617CJyohEUndD3ZvTuP8NWx/LiVa0FiACwsI
         8p2jpv7kM1b9bXrgt9TMndIDVq/fPbtpnIRAjpPAf96LlYfnZeTPDchBYmQ1FtbKUYUK
         lZew==
X-Forwarded-Encrypted: i=1; AJvYcCXIaKlFYo9/VwV9+kKR2p1fd4sOzor95CdwKLvrjVMrDpjHYOcH19xG5xfiue4eFlQPKDM7DwXLwp2zB7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTddLhEED/dKz/LuXYo3ybmB0MtZjz8w3IlQn7g3V88Mg2ksz
	DZHdfeTV64KYi6QfKP7WcMn5Udax4HTyc5UvfG+aSHR/uAb4CQ45RZZ3ckA3i1QvaVc=
X-Gm-Gg: ASbGncvbxrmweRxkSKdGEdCiRTq/II5g7P4hYyh8Go1gomZus7oRR/UDvPikHpxS69W
	WSrxsLk1KAZ7Rbx+dnoLGx/9yQVAua9u046C0Fijn/MXCWO1udTVXClritpj/sVvpVhc5d7v10c
	O0WfUaV17u22xJ7SdyHMv0h/+Rpns1LWbAZTq0F8nO3Jt04dNBuYuYXk5F2XimmifZutspuM7zJ
	yw7QDP9z1/maFHV+mL6rBcoNZ6iZZjTP0FwaYzpjNhdUC2nyEFLpE3caZ+kgFD/EELwRmH7xAUf
	Ko9fr8s7jRiPF2j4BvmHTmw2qcKEjj/Gad4jXrZo5UtX8rotMfPM4q1/+kUeEqqzMku2+oUxvVr
	NOpxYdRLEl02VaAaKdaA7ksyo7qmUnQ4NA29D7A+IMeeU7zFJI0wGRRySYDzacdCUxL18kFFK4p
	48eCQ+g/dw2Q==
X-Google-Smtp-Source: AGHT+IFhHfyQKNAmkKCUvpiYWdk49opO+ptbcr+IJLwiDT8vc7L+R3s61PznZxMlKVdQi00cNS0QsQ==
X-Received: by 2002:a05:6808:2183:b0:450:45d3:a50d with SMTP id 5614622812f47-4509746132bmr7150898b6e.30.1763434104168;
        Mon, 17 Nov 2025 18:48:24 -0800 (PST)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-450aadd23ffsm2501610b6e.0.2025.11.17.18.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:48:23 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: samsung: Declare earlycon for Exynos850
Date: Mon, 17 Nov 2025 20:48:22 -0600
Message-ID: <20251118024822.28148-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It makes it possible to use just "earlycon" param in kernel cmdline
on Exynos850 based boards instead of "earlycon=exynos4210,0x13820000",
as described in [1]:

    When used with no options, the early console is determined by
    stdout-path property in device tree's chosen node

[1] Documentation/admin-guide/kernel-parameters.txt

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 2fb58c626daf..c1fabad6ba1f 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2830,6 +2830,8 @@ OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
 			s5pv210_early_console_setup);
 OF_EARLYCON_DECLARE(artpec8, "axis,artpec8-uart",
 			s5pv210_early_console_setup);
+OF_EARLYCON_DECLARE(exynos850, "samsung,exynos850-uart",
+			s5pv210_early_console_setup);
 
 static int __init gs101_early_console_setup(struct earlycon_device *device,
 					    const char *opt)

base-commit: e7c375b181600caf135cfd03eadbc45eb530f2cb
-- 
2.47.3

