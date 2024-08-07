Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D691E487B
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031902; cv=none; b=WuqEdsbVeVCM9/0khoqE1jirC22TP+yvs5/kphgq5jrn7+r+WZlFZ6EyZSh0L5HWp5YFwAdO3/65EYdrnMn19lcWzHVYmpVHYiwJUoJofilOKn77+mg1UIH7ALvu/XzS8cip5y5y1RDp+dimQHjtywwGOZ9FnEBhGdB7V6D8/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031902; c=relaxed/simple;
	bh=OFBYbEbxE7IS+Qv7SDH4FfPtfE7Rg5E1zGlU0PewGMg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VKPPBxujG2X/iXSTTUZ4DwKoTW5+Jf/5z9gDbGNeJBEFbpCDhbRN5yGi76gf49Hn8nhcS1Gjy6KPWIIKjJEYkHM9HqObBP/+aAxm+PSgEAxPjKqJQIvbkcr2WoD1IMLmoXwOPcRK52DwUC6204sAPQfYW6kxdMpQ0y795jhfvhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=blJDFxq/; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blJDFxq/"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso25516451fa.2
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723031899; x=1723636699; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QvuttAjkPLAVMHVOXYUgt5mVS3UMEYPJRu5N4V28dSg=;
        b=blJDFxq/ORTmJmQPqk1w9Avq2jTyUhku4gIdJJi+XXJxTE+WrkbqWk5m27q7bQa5Dt
         sqnkZyLiIHorhiCxkxlKytI8jaXyamYmpokBPlv5mefysHB3MFdD/w1sAjGl4tf3P/5m
         7jMMMP76TbGgqufgR1hkY3kmuA0HM4Fg6sF/R0i5sc8y/hNAmBBeg1NDFnFyKtbMEgBV
         DZLYtWbbX6gBsnF8V1eqxNqR22XcZm4bu2FoL7U61Ngt7sBWq6WD+TA3xNXDI3BWEpBs
         NdY+Lf8iXGRXQvQ0FMsmQvwO42bQBsRu2Tna+Y4Z2kVJGc148ngyrZzM37D/kgtK3QtQ
         maKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031899; x=1723636699;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvuttAjkPLAVMHVOXYUgt5mVS3UMEYPJRu5N4V28dSg=;
        b=dcT+pFbkcA3OomdsqNitWiJkQE5obZ8MozRkMdk4PYqKf7hbTYAktucJywhmcD5H2f
         ANFpS0w1u40b+jnUnZI3NQ9L4pNXjMtk5g6mKHPhkQz5WbrvX1wqblKGRMA76EivpITg
         uTsfa8WBMT4P2ICXhjOsERE+F/UVgWRFwnbzUBI6kRedILEsWWX/L4wwgvY/7N2tiZuq
         ThFavnSGvrkk3PGDLMgNR/LNQBJhMIZtX9dz80nYd46VvNgPZ5wrnmRairKjYvZ1Fp+b
         jC5a1MHWqUJPLeb99aWmIgssoRW2xMCBgUxMijBm5v2TQGmCMPfCovcD0wJcvptQ/YIs
         kzGw==
X-Forwarded-Encrypted: i=1; AJvYcCVlnykFE9ODDrtRSXVhhv+3mk9WPcocS0K9TLTu0Qnbo7jN4ZPhTG1KQTYbIziCzJC9Ao2ZaDEkkXnuRv/C0L9Aqi702HnjEnjomgQS
X-Gm-Message-State: AOJu0YwUO6cKBONDodhFRiiEUK5rS5dN+oug/wfVaIMqi6diVzKI2+Yc
	jBmckHbijtF+zyRA563KEAVeN4p6ceIo20MZMCtlzAW6X9fByvYuGo47BgT5KI4=
X-Google-Smtp-Source: AGHT+IFMahW1ZeQ+4SdbQZtKjEpytqYR6C40gi+5yPvZkfOWWpUhdF1d4i/TPsvRGYmNl8byMwOdqg==
X-Received: by 2002:a2e:b790:0:b0:2ef:2c3c:512a with SMTP id 38308e7fff4ca-2f15ab5cce3mr148444871fa.42.1723031898236;
        Wed, 07 Aug 2024 04:58:18 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d45239sm631017466b.119.2024.08.07.04.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:58:17 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/2] tty: serial: samsung_tty: simple cleanups
Date: Wed, 07 Aug 2024 12:58:17 +0100
Message-Id: <20240807-samsung-tty-cleanup-v2-0-1db5afc9d41b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFlhs2YC/32NTQqDMBBGryKz7pQk/iBd9R7iYqoTHbCJJCoV8
 e5NPUCX78H3vgMiB+EIj+yAwJtE8S6BuWXQjeQGRukTg1GmULWqMNI7rm7AZdmxm5jcOqO1xLr
 UJZm6gLScA1v5XNWmTTxKXHzYr5NN/+z/3qZRIVV1n9PL5trycxJHwd99GKA9z/ML995HELcAA
 AA=
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

While looking through the samsung tty driver, I've spotted a few things that
can be simplified by removing unused function arguments and by avoiding some
duplicated variables and casting.

There are no functional changes here.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- fix -Wdiscarded-qualifiers warnings
- collect tags
- Link to v1: https://lore.kernel.org/r/20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org

---
André Draszik (2):
      tty: serial: samsung_tty: drop unused argument to irq handlers
      tty: serial: samsung_tty: cast the interrupt's void *id just once

 drivers/tty/serial/samsung_tty.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)
---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240806-samsung-tty-cleanup-ffae1515a284

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

