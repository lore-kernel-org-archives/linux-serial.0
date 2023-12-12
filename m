Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcVreaZH"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CB5E4
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 11:39:32 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso30126715e9.0
        for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 11:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702409971; x=1703014771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbsTXFKXTrY5tLa2ITZ+RhWD1cGIYo+QvwAZu2caETo=;
        b=AcVreaZHp4zOY1JXfxcrmD4ag+g8Io1IhgxSy8CGSzyuIy3824HR33vkfvvTct2NT6
         iC3x6VIyUnA2B1HZNvHP4qImnlz8ik88UfGqRB2RTY7ZsRHRQ8bLglpf++W3sTqhy5AK
         5bebs0FO+Z5tf+Xtw15wUp71WErbR6Ro2xYSNuRvzcMFQ2Wcv/ezt7ND5ooB4EMPJJYP
         DnOjYndae3HKyfypF2ruEZCHUp3oSEez04O/UMrA3OPn/1VXhnunbCGlrTT84th9Goiy
         Jcz5CNilwCMleMMr7NyF63P0FBC5OJxhap0StY6GDSes9C3IJ4XB504UdvrpBFYhHYzV
         Clog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409971; x=1703014771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbsTXFKXTrY5tLa2ITZ+RhWD1cGIYo+QvwAZu2caETo=;
        b=O9Wx0ychnkBx7IaQ64tn9AdvuIng8d0Ydn5qDGZJHJkkCukOTw9WegZllUyVrviRcU
         hbtjhUWjgDQXgxHyRXZ9Tn0Y2x+yEpd0wuS0GNUZCp5YnoqikIBX+/YkueWoY5FuDJc+
         lxLwdUftq3iPc6ZofX+AvBjqr1Ld26vFUiAV1P4Uo0uSYrQo4ovsY5jZbcXZXzpA+U3L
         Yvx6jeecCG3s1Tf8E9OxVqirtWU2mdq9OpcZ5qkcYyGY2844IqSjxZYcycu3vFUol00r
         X2A+jIOEVuHFXRhP4ZHeCMTUHW9y8XruUGzXSyeWGREFB4dqfHaY2yjInJX25WktUElt
         UiIA==
X-Gm-Message-State: AOJu0Yz2EE4RRCTSAzC2aNbSbO9RMKBo9nVcn2fCgTZeK9Xb5GhISyg2
	keEfmXWdHeDxXjj0lyAku1Klrg==
X-Google-Smtp-Source: AGHT+IECFv0mPrPqCAXunm7Vy99xWj4CTFmeC1IPksAqK1hsqYuerO0HXIHbmdgpTQzRxFSjYbcuEA==
X-Received: by 2002:a05:600c:1656:b0:40c:5822:133a with SMTP id o22-20020a05600c165600b0040c5822133amr254490wmn.69.1702409971213;
        Tue, 12 Dec 2023 11:39:31 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b003fee6e170f9sm17345530wmq.45.2023.12.12.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:39:30 -0800 (PST)
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
Subject: Re: (subset) [PATCH v7 05/16] dt-bindings: soc: samsung: usi: add google,gs101-usi compatible
Date: Tue, 12 Dec 2023 20:39:14 +0100
Message-Id: <170240988144.242356.15535258892382463057.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211162331.435900-6-peter.griffin@linaro.org>
References: <20231211162331.435900-1-peter.griffin@linaro.org> <20231211162331.435900-6-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Dec 2023 16:23:20 +0000, Peter Griffin wrote:
> Add google,gs101-usi dedicated compatible for representing USI of Google
> GS101 SoC.
> 
> 

Applied, thanks!

[05/16] dt-bindings: soc: samsung: usi: add google,gs101-usi compatible
        https://git.kernel.org/krzk/linux/c/d793f7c471fb1cc9b5cf5aee5484f4231ef48dc8

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
