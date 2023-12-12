Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1zpve6v"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F54EA
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 11:39:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c3f68b79aso39913555e9.0
        for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 11:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702409974; x=1703014774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIEVZua66dJf62hRcdu5gWR03a1O3YurjttfgMhD8K4=;
        b=V1zpve6vhNInQEmkwAp8jyE7+77uKkBicfKQyZCCxT1ZrmLtVi8f28G+isYuXeEnY4
         uYTiMOhJCoJfMYadxRpQbnWnu4/3psS/oTrIHb/Tx4yW6TdS7U9hrJjsZl3nAOZNNaIl
         tJHwClxqUdfy1uIfWHaGLBmf3RSHfhD8KMjL4sddOEjQz6KnqtUtbRj+vjHYS6jOAnGW
         AmRlPLbS1t0ip2c6v7WROjAlAXtcVfbyElCoSUUKqf2FiZz9T0BWSDwpIPKTkSqm0OTi
         Ovl+ECPniW/VlGKeBKlR9YOO6y1D4T5e6+iQR2A4YmUDTGrJsCu3XS4Zwd5T6ACbSJTl
         1Y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409974; x=1703014774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIEVZua66dJf62hRcdu5gWR03a1O3YurjttfgMhD8K4=;
        b=fA+GkIfxMLj0uC2prVdNpZ3VNaA80hL7QrbTSKGi2T4upFk0wpFDl5h1vqWq92zsV+
         k1bBciI7R1U1HAmBh22lN5c7w/PJEkKNrm1qBuDvQsulMAcx4BQsQ2V4l3D/dReQzS7D
         k4ekbVeabuQlmiW6xQp+oljySVH8Wc8mJmItcsIvf4XukAxG6Wl7fsqcXbQ695+RSWf2
         RL6rEgcNyirdoCxh9VzhlK27y0dtYPuMgAIikB016mn7mKN/y8CoGp92NT+YW3MBvIT7
         m3xg0nkc88MCWep/EBSWNCUU8H5zGmCp+xKZQ1DyJZR0m0lpzzPTSoeZmhCjLq1kOxG4
         HP1w==
X-Gm-Message-State: AOJu0YxFpUyJdue/tD4U1U/GV4cU4EvCSxfXfx1npGTM45GZt4QY1820
	DdTzF1SnJk05ycLkl1ERA7NT1g==
X-Google-Smtp-Source: AGHT+IGV2FkQnkPssClmhNRgr/I23fgepxPzCfthBrS9nBE6X3J9ouT2HGSEDP0oGjZiIEJ5kFG62Q==
X-Received: by 2002:a05:600c:9a3:b0:40b:5e59:ccd7 with SMTP id w35-20020a05600c09a300b0040b5e59ccd7mr3643839wmp.184.1702409973988;
        Tue, 12 Dec 2023 11:39:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b003fee6e170f9sm17345530wmq.45.2023.12.12.11.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:39:33 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	conor+dt@kernel.org,
	sboyd@kernel.org,
	tomasz.figa@gmail.com,
	s.nawrocki@samsung.com,
	linus.walleij@linaro.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	olof@lixom.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cw00.choi@samsung.com,
	alim.akhtar@samsung.com,
	Peter Griffin <peter.griffin@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	semen.protsenko@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	soc@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	kernel-team@android.com,
	linux-serial@vger.kernel.org
Subject: Re: (subset) [PATCH v7 06/16] dt-bindings: clock: google,gs101: fix incorrect numbering and DGB suffix
Date: Tue, 12 Dec 2023 20:39:15 +0100
Message-Id: <170240988142.242356.6771839605538323982.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211162331.435900-7-peter.griffin@linaro.org>
References: <20231211162331.435900-1-peter.griffin@linaro.org> <20231211162331.435900-7-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Dec 2023 16:23:21 +0000, Peter Griffin wrote:
> 166 was skipped by mistake and two clocks:
> * CLK_MOUT_CMU_HSI0_USBDPDGB
> * CLK_GOUT_HSI0_USBDPDGB
> 
> Have an incorrect DGB ending instead of DBG.
> 
> This is an ABI break, but as the patch was only applied yesterday this
> header has never been in an actual release so it seems better to fix
> this early than ignore it.
> 
> [...]

Applied, thanks!

[06/16] dt-bindings: clock: google,gs101: fix incorrect numbering and DGB suffix
        https://git.kernel.org/krzk/linux/c/5b02a863ba502482f25ae3a1bfa259838793785b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
