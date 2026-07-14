Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16BF417BDE
	for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055209; cv=none; b=qqC8QAsslZk7NnRRERC8MUGWEYaWDwBTTzE+bVeZy8S0skjvjKS+vuJEjz6VjXA5IedoTzzwUOlxCuvUiQZi4DOueffkYd4qdztUZVKY3isbeZ42mXqH9XYe5nNnAmQ7/R15nJ0Nuc4r0RnUtkAmJA4KRw4Y8bDQSBM8CPaGFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055209; c=relaxed/simple;
	bh=cSCbnH1xPXdFvXoeIkjlw6q74tyyx6jthYZF2YqxS6Q=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Zdkw6N7Zee+R1DISfhfRQPy3Xl/mWztXeoV3piK9GvnEWjYNIUPSwTUfsMJ7cOZDKvyrTv3a2/z53JDPuN1Z+PAhKRXumee1Fvrrc1wLKP2hrHOHeCrbv1L4aP8JHbOavrSfO7bY7FXrEJNYCI6umVo5HRissNBmNYnqGDRry/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=em8vHOVO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="em8vHOVO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso31953475e9.2
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784055190; x=1784659990; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oeiC8iwmB/ylmI7BL0w8nOLqlIUesF4NQaKuVPlJTmQ=;
        b=em8vHOVOMz3MokgSycMztY44Spmj4Eox5mpku18Bdb/1X1yFwWqgcbOMM6i0RWyxzk
         ZI1TJKKa1gr7y4aKWqpD7KMpk52tB26sQsVmgpECaq458NCty+I6DeIdEkSrHjQxlvd5
         kYmwodxkUsfaByr+h8pGOkZ28BiS2UHCDxGdBWQ7rdlFb6Y9qC1+iLpi4rceWKVDv4yX
         YtU8T0E+zevB/DzVDEgX8Hm++XBwZw63vlWYL5csywbN5VcqC2hj21BqREh09Mr7vz1u
         zoV/jQLTfk/ys7sWCM95r0nNdYNLLWgmvvmc8bhRMOH6Oa/jtUiijA+BWuXdp/uDtiyy
         wrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784055190; x=1784659990;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oeiC8iwmB/ylmI7BL0w8nOLqlIUesF4NQaKuVPlJTmQ=;
        b=ZPtM1n/8xFtG9nXmM5N4NCjb+EFXxYt76I2Co6s7r6BY143R6wlUW0GWc1jylfWXMs
         M/qhaR3JxY7Caa/h4fv3sPyEtzDZEj8iV7okToJxXUlOZZaRPULDZ1EZqT2oq2+HYtFQ
         2DK8b8n7pompNNnJGpLEAeHoYjrRzbuRN1A1OmS3GEFEJIQUWnY9Vfqag18yNjPL2Rky
         PuiiEW35MxIijGKLKTOOyKoPnNiqoxBEFhmUtsYr5RkdzqoD/KoAVxlAUWH+DpnYl/tf
         Ctupofslhd9ly0FUcZMrokYKSe+6LuKqK9/lmsvUZYMmMr9+2QPNPxkXOjwLG1nIwqHN
         4f7Q==
X-Forwarded-Encrypted: i=1; AHgh+RptiZhTMfqKW7LmG5+VXsab73s5/1Zd79aYL9nJfJE2cmXokzlQzupTSr9nErJ4YMjfXnSYyJOnjxucRb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8x0xBGJDEYfI0N776wfyDS3Rrv74E2wX9tai0S1b8QWYnELHw
	OOhHNe8OnAqyjxPMWcC83CUoR81PLDrkIrRuYbFYliaKa68B/ugPEjEUx56bP6R6FKU=
X-Gm-Gg: AfdE7cmSEdFZ02em0o61rT/AL2YK/U7pftbmBurTKZVZzBMzCN9hM0p0uUj4x2KxtVK
	h+dcd8Rk0zbzk9ktW8qlcLkINWhb0ldkuek5p/MFXOhTlxaKgKYpTOCR/nhKUtorlfBLyKxKh6W
	t2X1w+ZqGycBEQfpjPWsshimGg21quRb6sLHl50NunCOsF6CdS63Pif+rr3nAbj8vAmQmcJyv8W
	uS3sA0DsHCavBKCnlGIyx1FFaXi1HrRnl7/yFwNzK4qC9JI5ue8UFT5J2oGRk9PL3ha9Ll/rFH1
	B9shNogqvgDLLdWAQBvgDtd09g2AiVoHW4Cyv3uSuCr/JcrGQyRtNyOvcasc6iPHZBIAISZx7qZ
	IER1GvEZpCuCc7yze7f74DQa8XjWIx1b7QeKEK+t61e7HzZSOr5KayIxeZmXwKGjLa4Xm5+GbJ3
	dGzi2d9XwO3Y0K/qOozqeDjZiHHEdBzg==
X-Received: by 2002:a05:600c:6048:b0:493:e404:3727 with SMTP id 5b1f17b1804b1-4953c27b338mr384505e9.23.1784055190102;
        Tue, 14 Jul 2026 11:53:10 -0700 (PDT)
Received: from [192.168.254.124] ([2001:9e8:2fb:8201:c26a:83ef:161a:409b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508725c0bsm94908715e9.2.2026.07.14.11.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 6/7] ARM: dts: aspeed: g6: Change vuart compatible
 string for ast2600
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 linux-serial@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <5875623c1b20cf5a1abc980eab4c31a47cc58468.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <5875623c1b20cf5a1abc980eab4c31a47cc58468.1783524645.git.gregoire.layet@9elements.com>
Date: Tue, 14 Jul 2026 20:53:03 +0200
Message-Id: <178405518338.194693.4399160180155776340.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784055186; l=799;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=cSCbnH1xPXdFvXoeIkjlw6q74tyyx6jthYZF2YqxS6Q=;
 b=mkm+x2rfwdRTX6T+kPimO0xGU4ZCOBNQdoZdkNzfY3dX6Gjkg11WJUNKDAuKCKrynIBxtwo9X
 8eCoafR4SqRDuGXcQsnzwqL52BuI0qAQ9N5syq7ajzX3e5IrjjdojFC
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

> Use the ast2600 compatible string.
> Make it more precise and enable specific ast2600 properties.
> Still use the ast2500 compatible string as a fallback.
> 
> Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index 56bb3b0444f7..7c02633f2bd6 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -707,7 +707,7 @@ emmc: sdhci@1e750100 {
>  			};
>  
>  			vuart1: serial@1e787000 {
> -				compatible = "aspeed,ast2500-vuart";
> +				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";

compatible = "aspeed,ast2500-vuart", "aspeed,ast2600-vuart";

	Tan

-- 
Tan Siewert <tan.siewert@9elements.com>
