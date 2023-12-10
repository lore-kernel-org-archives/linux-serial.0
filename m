Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Glt93t2i"
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508A0106
	for <linux-serial@vger.kernel.org>; Sun, 10 Dec 2023 06:01:47 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ca0f21e48cso45150931fa.2
        for <linux-serial@vger.kernel.org>; Sun, 10 Dec 2023 06:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702216905; x=1702821705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=509ouQXj36I5/HmX907dzCDtwty3xLRM03HHWK4ixvQ=;
        b=Glt93t2iUOJW1gB7zGNRZwZbsx6UlKNwW9zM/VbtaJxPqKQUElAMx1dn8ZwlizR1ed
         tBpxGCtHWk9CM2EQU2HX9EXuwtea9ASyK0gtgBYgpTDiR6TLSPmYTuxzUZEdgHd5sTXr
         kzJjOSHhrlb2JCAKQiSHp6LjdznYhCoS5+VlizqXhHWyUVP23LAwiLwz93cRCiZpZpg5
         AyPBkdkbvfEwA2magQtBdGgMF2tlqvoGqWhqKwLngWYFb4L4N6+Jvjh++PceTP7V+q/X
         QYbo0/FdT0m9rXYJmazkSQZLsq/TyU2sYQ3OcYBE8l/ADi+7i5kN7res7/u3s2YncoC6
         7DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702216905; x=1702821705;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=509ouQXj36I5/HmX907dzCDtwty3xLRM03HHWK4ixvQ=;
        b=G9ma5FUawhP7xxYwlRAyVXeRx+qnEtTbFz8j0//WLn6cIGg9ZKR5ru0onHKOTVSb0K
         pwJuGe+aYdyM2/FOnjmheP9idzkCR4nNNodgxbPFlfezjSFZhggvLzSkH/AeoWYIl5Nm
         2YyCV6DmopGHHOVW9qtcmQ++IZ88l8CYDHF4a2+6FHbN190SvWCITOv68sUmLiSbEz4u
         VlphZCdIQH4pyOUwvFRuMQseSax6HyDAtGki7Rfei4BXHAQiCuk+0QNYzgdK0/z2fe03
         RPP8JeLfLnjcT/DtlpuGvN2dULpOUXINwHtSP5y3fGa4A1Nkzcf0gr96kIeehXQBUO99
         ZMsg==
X-Gm-Message-State: AOJu0YyUPPeVH/AA5ZgM3W/BHy8ES9fPKXMBaeNVDYpXsZXL+9kZMjRJ
	iuXkwllRUAdVqeyONKhcdu+XGg==
X-Google-Smtp-Source: AGHT+IEZmhO9bfzbn9JehG5hOmeoOZbTHQz/rhyB/WkPhsdghbEEi7AQ8p1xd7LZWL25BdUtRojVkA==
X-Received: by 2002:a05:651c:10b6:b0:2cc:2189:7f5a with SMTP id k22-20020a05651c10b600b002cc21897f5amr36215ljn.93.1702216905124;
        Sun, 10 Dec 2023 06:01:45 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tg10-20020a1709078dca00b00a178b965899sm3458691ejc.100.2023.12.10.06.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 06:01:44 -0800 (PST)
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
In-Reply-To: <20231209233106.147416-2-peter.griffin@linaro.org>
References: <20231209233106.147416-1-peter.griffin@linaro.org>
 <20231209233106.147416-2-peter.griffin@linaro.org>
Subject: Re: (subset) [PATCH v6 01/20] dt-bindings: soc: samsung:
 exynos-pmu: Add gs101 compatible
Message-Id: <170221690211.46013.5711996168125251211.b4-ty@linaro.org>
Date: Sun, 10 Dec 2023 15:01:42 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 09 Dec 2023 23:30:47 +0000, Peter Griffin wrote:
> Add gs101-pmu compatible to the bindings documentation.
> 
> 

Applied, thanks!

[01/20] dt-bindings: soc: samsung: exynos-pmu: Add gs101 compatible
        https://git.kernel.org/krzk/linux/c/fdd78ff04ccc96f628c2f93e0d48ab0a74bf34ef

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

