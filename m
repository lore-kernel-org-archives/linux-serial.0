Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N/qWSjbv"
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C705BF2
	for <linux-serial@vger.kernel.org>; Sun, 10 Dec 2023 06:01:49 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54dca2a3f16so6554753a12.0
        for <linux-serial@vger.kernel.org>; Sun, 10 Dec 2023 06:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702216908; x=1702821708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrhZNFmRkf5QkANQC+uz36bgjgb8UZO2KJuZBL7fznE=;
        b=N/qWSjbvFFjOENa3partdG9d5jVQF7dvvhnZDzjL67UimfXQJ/2i8ScxfNyKpZ40ZZ
         JKmzhCKpYn4h2ZvquOeqTb0ayH1CDRFlEkIPt9CjaxamnZ44zO6/gBPx8mNA9aAf15AX
         AShkYJTYoNGr0yQuMSv8yLVKH7OLfY2I+kOCq1lihpB82Sb32lUYT1yWcWO210HZ/Tc8
         w3bgJbXZMXbPyM2+O+Q1u47OVrpqRehc7KGNmcQTHNbPTG9Vi3aq2hVAOz/gWT9OhVvp
         ljGmAJYqT1UQrBWyPWGRTd7/P5KOvD6AGEtUs0R5T/BJ3ER7xFBpqw03lNMX3HdAp7Zt
         oqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702216908; x=1702821708;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrhZNFmRkf5QkANQC+uz36bgjgb8UZO2KJuZBL7fznE=;
        b=SVmQuF5Gt36TekMt6g7XFf9/rN4DkXZNF5h4+LB1+RNYeRWmxiuSNFmU/2G1KIUSE2
         FQ3BI6nQjRBHkg+le+/Mw/P9PCdJhKlY9DAHBcQSia97aibuEdKcHjtXv1h328rEyzCD
         W05EcvitythCPuQu4sksTn/9jKunxpbgz1ajCUMT30vLIyEgmN+V2bUTCgPAmANeeEvB
         KsN/Aeh2lYGNRXX1SuPR6m1WwfpcF/RxtYvPsGV3q76Q+hHv4TBu5Prc9BaZhoyePwR/
         bU4LColAbXujdiCoMiBKROK1qGfew2f65x3CkzAD/HGknp+JBmjZ2TcTzniAhYJlsxJz
         hUzQ==
X-Gm-Message-State: AOJu0YxOLP1OkyRc4Y1z9DhYZ+plT2LuxYgcfLj8pGQFthn7mDkBUjVV
	VxBgW5qsDrBuOapREzWgxtMN/w==
X-Google-Smtp-Source: AGHT+IGD245LrSk0xYctz3uy/kk2KvcUmnSUKmb1u8fAYEK0Zu2DWqkA0Pi8IyNUK3s5IFZQRvE6Bw==
X-Received: by 2002:a17:907:280f:b0:a1f:4d21:301a with SMTP id eb15-20020a170907280f00b00a1f4d21301amr3987023ejc.13.1702216908355;
        Sun, 10 Dec 2023 06:01:48 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tg10-20020a1709078dca00b00a178b965899sm3458691ejc.100.2023.12.10.06.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 06:01:48 -0800 (PST)
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
In-Reply-To: <20231209233106.147416-3-peter.griffin@linaro.org>
References: <20231209233106.147416-1-peter.griffin@linaro.org>
 <20231209233106.147416-3-peter.griffin@linaro.org>
Subject: Re: (subset) [PATCH v6 02/20] dt-bindings: clock: Add Google gs101
 clock management unit bindings
Message-Id: <170221690550.46013.13677086533521441233.b4-ty@linaro.org>
Date: Sun, 10 Dec 2023 15:01:45 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 09 Dec 2023 23:30:48 +0000, Peter Griffin wrote:
> Provide dt-schema documentation for Google gs101 SoC clock controller.
> Currently this adds support for cmu_top, cmu_misc and cmu_apm.
> 
> 

Applied, thanks!

[02/20] dt-bindings: clock: Add Google gs101 clock management unit bindings
        https://git.kernel.org/krzk/linux/c/0a910f1606384a5886a045e36b1fc80a7fa6706b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

