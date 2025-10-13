Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB6D223DF0
	for <linux-serial@vger.kernel.org>; Mon, 13 Oct 2025 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317334; cv=none; b=uIJ6+/YsurcC0kNyAquPos4sfg9WGcyMP8Nue9OPvbZrTbiWK+0YbnLgHqMpZnSw9bCg0D13XLqYrxyvNjz9+Anl0WfMBMBeF1tM4rY/VtTEnfM/BbHBAQJrVv56F8OsvKHLADTRWBJtXUR6zHdRDEmCWpAHsUx5Z4hKA3IW0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317334; c=relaxed/simple;
	bh=hPO3fb9A5GUMjlwesrVBFk2doqpjzcMDbOWwmKe2wnI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eBnM8Mj5BnMLfnVdeO7x6IMlr/rw1sQJwfYAfY7f+PDMQ2nftDXJVjubpwDgO5S6dVteG6qMrYvs/k+jc20StvLo/wsknhwXp0kWHD6iNgo9q4pR3Ed/hWGoek1wsyqO7Is7vsQZveGh63lAhqswNin+rlhg0A2+uTaJZA2S8Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v0k1PdCc; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v0k1PdCc"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5538e4343fso87768a12.2
        for <linux-serial@vger.kernel.org>; Sun, 12 Oct 2025 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317332; x=1760922132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10a4vKq6IEmQUW56jJWKaFLXuKf0sl8IrALpzNZuGbU=;
        b=v0k1PdCcMHpIJAj+EkMYnEy7cH0xMYWMKeWr5Gu30AL0CUYnG6OzFlIgGi1v/C4so9
         kGNta/zreolQcmUr6TdorZWBctyCclXRKnzW5y5RrGfgVxWsjuJFnj00jRbKTlABScTA
         DxZchP+CiwdCzYdijY5NJL7t7De8anxvxJSiYsPBLOZeCfrtwzqa2hc9dHep663OBJXU
         EO+7TCTBOj9FUcMHPnm1uN2QZV/X2InUp1+vbL8NsDy7DK8Y8C/jfXYVmCtXost56Neu
         GodZ4oRlNPkKmXa5CtA4uIdeJILbfnTHihnaYdFdRdNLfxjVvk3SZRATSbsA+iH6Bycc
         Gplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317332; x=1760922132;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10a4vKq6IEmQUW56jJWKaFLXuKf0sl8IrALpzNZuGbU=;
        b=n0hbm8Pvhw1DI5lf0axXXIYHhn9CQYcMd8kGEfE2B1W5856j9bOt+UHNoDdvlzCYcV
         xx6XhOAy68El2pn89HAXRCb1XsoJVP3khcUyDr4/i3mdjJlDPm5N56I/yLRSpKzhfbdJ
         SfgOFFdAP54xLQAWsqz0ZeciC8+MLAvvYqOcPaykvbsFj0OJ0mKfoF1zPnURYYXUp/+/
         is2183KiHpVCFTdeEzvBeSpdqoCznsX8dtcxm9ykELKMIwrBnWbf7Eqav+76syKvHINu
         L0hSJ8h2yI6BVmB+JWLJF4V7uaWpa15qU0mC66GRAIgWpdKk4bOS4GnCipoantkozR7N
         K+LA==
X-Forwarded-Encrypted: i=1; AJvYcCXeTayVL4ZbHP/JraKy6ncE/0Nzql+9d6QR551hV7zkndhpLM3kbCPnKUruSJzJUbn5SbnJPUFzUCW9xag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf45JCYnFylMzuLK6Q/jr77zPzoixIaPBNwEx4/awvZTe0eck1
	aUDdC8YMMTxX09BPY+5+hdrx06MZr9MHTVTGD//mNF5PPd5GCoSyBdIe8l07ILnqYBo=
X-Gm-Gg: ASbGncvifjvjiAHjdHvi8ubeYjO4fsr4mQ887hi/V2bjhRWgEC7531UqlBKCU95qMo2
	85PM/5/vkQQVVOPR5UtM41TVG+G5CDCINJxSh/m5vIXq8LR1yOo1LrwliJuxJ/HqaM6DgXXt+9a
	mEaaTpXZD7BmQnYTvLDa25YW1DITak9G+hSs+3GJbZ+sSYluMt1CWl3iZia+C5crekFg1TiVHQA
	kgJkvXUi+XHaH35GZlVdCAIicna6EkI4a51SXVNCZmg/ztkWsg1oUjuCXgjVKIe+kEp6JFXf0du
	OD5xzjtzTyHbpw6vXNoJXbsWFloLL+DMfZdDxNgRDsOzL3cz5kQM5gAh5Zkmu19pfyiwiw+ED/F
	tjtrD1z+uXJsjoHTa7VKcMyXP6LykqxIvltuUXqaUPAQaT2w6P1tQVL1NtlGB
X-Google-Smtp-Source: AGHT+IEt21JJ0GbW52Ae6IIeXGAxkDnv8PoqVX129SAInTnAX3MkkPG+Hi8yBSex+9tD040Mp73hFw==
X-Received: by 2002:a05:6a20:d526:b0:2f9:74d6:440e with SMTP id adf61e73a8af0-32da8508ec1mr13363457637.8.1760317332410;
        Sun, 12 Oct 2025 18:02:12 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:02:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-serial@vger.kernel.org, 
 linux-i2c@vger.kernel.org
In-Reply-To: <20250917-perics-add-usinodes-v3-2-a3629e4666ef@gmail.com>
References: <20250917-perics-add-usinodes-v3-0-a3629e4666ef@gmail.com>
 <20250917-perics-add-usinodes-v3-2-a3629e4666ef@gmail.com>
Subject: Re: (subset) [PATCH v3 2/7] arm64: dts: exynos990: Add sysreg
 nodes for PERIC0 and PERIC1
Message-Id: <176031732773.32330.8134222095806318376.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:02:07 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 17 Sep 2025 21:04:22 +0000, Denzeel Oliva wrote:
> Add syscon nodes for PERIC0 and PERIC1 blocks.
> These are required for configuring the USI, SPI and I2C controllers.
> 
> 

Applied, thanks!

[2/7] arm64: dts: exynos990: Add sysreg nodes for PERIC0 and PERIC1
      https://git.kernel.org/krzk/linux/c/1e6daba7a3c05af0f8b02cb59e71ce18fb913aa6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

