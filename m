Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457192010EE
	for <linux-serial@vger.kernel.org>; Mon, 13 Oct 2025 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317330; cv=none; b=jcFuafx/Osv/1Qy/juGPrF7zIrHVgi9vdW4+vkGp3X9iH6j3TPIWJc1VSpmMAFiEp2aNXynCosoo2Cn3UULDA1dkgg8eCGRGMYH9eSy9rjcp6ulv+2+C6/0daay5xTM37lwFvUBV4NVhELTCbEyaE0fQJnf2Og8FAZclSBUF58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317330; c=relaxed/simple;
	bh=6M7PF3xNLpktje0EOKWg4z9Nu9yKC8jqvoHS+dTKYjo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K6Bc+pWr+RCCLZni6DYJrJpQpYq6WmQIkuPYzH48vZ6ZRYbrDzncETqb/r/TQKRx2O8rQU8HswrkcKHZoF02WSbpZhf2J5C7RE1aB13U+hsldP7rnwBgvP/95FnC1XEKQaglMcZqNVFgBcyKMZGLQd7pMVWdp3WZBMWvu5h15Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pAPvZrGf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pAPvZrGf"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea21430so204069b3a.2
        for <linux-serial@vger.kernel.org>; Sun, 12 Oct 2025 18:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317327; x=1760922127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h7DDrA7j+9540Tqy/6NV+bqJw0DCMI3GYZXvoLWyYk=;
        b=pAPvZrGf06WxIkf+1gAxdUEmVjrAS2lXR5mK7jR+EGRi289foPcqoJ6GpuDLidDMKW
         wo2cF6M/mnn3kj9sEVwlNH7apR4oIf+Fg1gDr8WCPnpuPHiWZIIFd/eb84fTPMjDmR6z
         njyKzztl32ZwWymDbBzDtfe68aw3sCMVlV5NUJhTwp5sn/BQTgULijqNlAsVyo2L2ZhG
         UK+mFnW1go12VzJUFUpx1PjlyVqu8ckiQfT1wje+V6hThVOPbjiCYZ2/QFSYAUrktrgv
         kQqLy89UsSHcrQhE7o+gp8MkhcQjcCKumn/4U5NBasXwaEaqAtJY8z6acT/GFL+9HYK5
         P0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317327; x=1760922127;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8h7DDrA7j+9540Tqy/6NV+bqJw0DCMI3GYZXvoLWyYk=;
        b=Jb8jnqVdFGm+uz7uN7T4iovc0LcStg7FBXDG08NTMNRZaLP6ycqpAbzqNAnGafxEni
         kOhWnEy2ajKn8ngNDoLNUSRFUeYjYhZUyorSynZf5xOPo1CBup0qdg64LMTnyCTLJgj8
         /F9TCJlLVKzueM7x5lfPwDit+Tvwr9zTCxec8wYef7EdLKrR8lmESY8DVYSPm+uSZvQ9
         muLHy34Y8RU3jEFxUr/A2Z6afeJBWspQX639y1/HkAALy3OYIS3FEQV/lPJWX+D+pJnc
         RCGC3GSc6RJUAEGRNnmAex9AEFRWkICQMyHrLQIlqfazTwHb0/SJSl6Cx5SXp68hZe6r
         x90A==
X-Forwarded-Encrypted: i=1; AJvYcCW29mXnKqpByfQws1iFPVxZcSi+FrJWSz4oxuWmVPZGE9pnaNAq2j8BHpu7IxqcFCQ/EtMwNRcvxkv11r4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ipje4retLfVCdbzTXHuHyUjEZ9jA6zVCDy+4RUVXs8fPnf9Y
	Pnz+Iwv7buo2MuMG46lRyAhuFHaTKxNWZ17+2dhVzKF3WcubrtblBNNQJJUV6jth0zo=
X-Gm-Gg: ASbGncubPzoR9EPFuOp544DYha75gIc1WEXZ78ZLV8yXKSASKMqAw0HvrHPqjieHrKQ
	Ipez9UANANEgHzNP+cI1mSDKtqr3mUw8JRNQRnityiLcnIgtspD6ppyT33PQGHmbNIuOLKeSuf+
	wGthTKgZ+Xf5kWJg7/P9iDg/TgsUlEPZ7n1iwt/MUTA56Ykq6G7ql6ZRZeoWZtWxuvWArfSfXpM
	3nLbrDhYdZfBDsbrCao8LF9b4EYVhO98Yz9ecgDzsr2kW0AoI2PIib6bkyycnTgeYleTWG+KydL
	RckMT3Ab5nI+COl4NcsFZj5aEl9W3aRShM8ZS8yMBDhdpSZnRNhG9GrSEVRB1BzCtzldmyLhydT
	QS3On73rPWJV7o/pkjrwfmK7X3NBT44SumVghEbHXxPN27m4kAKf8Yl3fX0BbKa2QDrqsvPQ=
X-Google-Smtp-Source: AGHT+IGnD/2S9vnckWUYx+lQefO8k9+6JLQFNxeCb9U29jbHzHiJy1UtLcBAdXedqp1xT25g8Y9crw==
X-Received: by 2002:a05:6a00:1705:b0:781:229b:cf82 with SMTP id d2e1a72fcca58-7938762f1fdmr11941331b3a.3.1760317327480;
        Sun, 12 Oct 2025 18:02:07 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:02:07 -0700 (PDT)
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
In-Reply-To: <20250917-perics-add-usinodes-v3-1-a3629e4666ef@gmail.com>
References: <20250917-perics-add-usinodes-v3-0-a3629e4666ef@gmail.com>
 <20250917-perics-add-usinodes-v3-1-a3629e4666ef@gmail.com>
Subject: Re: (subset) [PATCH v3 1/7] dt-bindings: soc: samsung:
 exynos-sysreg: Add Exynos990 PERIC0/1 compatibles
Message-Id: <176031732291.32330.1246219208832468083.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:02:02 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 17 Sep 2025 21:04:21 +0000, Denzeel Oliva wrote:
> Add compatible strings for Exynos990 PERIC0 and PERIC1 system register
> controllers.
> 
> 

Applied, thanks!

[1/7] dt-bindings: soc: samsung: exynos-sysreg: Add Exynos990 PERIC0/1 compatibles
      https://git.kernel.org/krzk/linux/c/ca4bd675ec459bb7bb008f15f5d866c9ce35f4e2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

