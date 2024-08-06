Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FA1799B
	for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958201; cv=none; b=dAOlgGb5ZGlX/ord1oAEBfkSkClpJKkKcMMURBtyCtBE1B2fQNO0Oy2WXB8Jr372lBxk674BxjHPjos741UqHjSjPrW57xMtBjUW4DxZQqWkgh98XxLqhVv8N3wCOQeN1ZgCWkn35RmNd1yMyaDPXxrOvZnmgA/5zkEtnmw1bnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958201; c=relaxed/simple;
	bh=fv3k8stKYzTS9UIEU0lpQcQQUZi9Zykq6iQUOmCKotg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cBO8HRbtG5bk4PAog/OThnRyWWLlG3cfiqY91Ej81kp/qZoYxsFzS2htPLf10mFh5oDFef/lU3k+0xhhxLdl4BM0+VN9AWMQdg+EbmvFddIe5a4pdTM/ItFvae2Ya6Sdw+nbyX6ji9wTfJ7WNPFdvmZvZv8TucUZTws3xIJQHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOENyDJQ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOENyDJQ"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso12908411fa.0
        for <linux-serial@vger.kernel.org>; Tue, 06 Aug 2024 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722958196; x=1723562996; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tprBLK1iiveUCYg/AarvtiLLOVA4FPbpWQNyejze9a8=;
        b=AOENyDJQT9RsnmqkYhSmNjqbmoIPl2GreifPvxDRVZqWItvYwuvAFg5azGunEwqyva
         FozNoYBlhoQYmPVKOq/eVmqP0fzqbmV++lcjBCu6kbU14P5yFNK1jwfF+w8AGJ8QG6DW
         cKkbJjbe4WNrFFps3peFbI8L3B2zfGlN5kKfTB7Q8Z0WLvDo0m0AEasN5Nkl3DgooB+4
         m9sOolWq21P/FeT61GBme75ZmvQ58+w5hRGSvPrZUrlbVavVecO88uYujGZTeJJCJPzJ
         sF1fj9a3PRaUVmOQRMJxU0ji08IKvpOMbMP9mEhvqjLpJd9RW4EeRJmw0GKZeI7vbj1f
         vXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958196; x=1723562996;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tprBLK1iiveUCYg/AarvtiLLOVA4FPbpWQNyejze9a8=;
        b=WGq/ZGVwIJVhiyPN7CyaxrygR1JbMsewPZVNHlNpDGTd1//aDpSkVsm9Y7HECBOyxB
         2nM1tAuSjOKVirIzUM8MwZZVVCqNpmt/AxRJDAd02jc5Z/ryacKXNG7HZNm9EvN2gxgZ
         ikw4xgcQIyVvvuRO/Ta8QAz709Ltctow2NJvTnhgpM4MlLtgGB0pIwX8lzZKdFtXgB55
         6m+pKNvN5jhsA4z+Oe2yDA7luh7cSfYSIKzjVjRuNGuVNhQBjNWY/s6P61bZrgcC9dvP
         e6Yia1zdURkoO4qpsmcOpho2CMu0p+Fc4nXavLUDPRUDw/RpUrbfICsqLBUAwQjRfVMc
         hZRA==
X-Forwarded-Encrypted: i=1; AJvYcCVIoZB3vRW0BIHNRlOkA82l8Ba34y96qQLDGOQ2INdZ03yzgc5nhQ4jiyQgQwzkau/7Ng1hZeDcLt1L2GjSqjUW0VoEAS4YfaenuH0p
X-Gm-Message-State: AOJu0Yx8T91587AqrvKQYp+7X2iXidV5Z36ObLb/rwW3aDH0yAhUY7Hq
	V5sGr9W2Q1IbVkw0YPz8Wabmw6YQOk7Uil0bajs2Cg2AHGyXCdCwX8QZ9mrjs6s=
X-Google-Smtp-Source: AGHT+IHRZmLaStmO8UYKkVKFqiPyc0B8sPefyyWX408Vg/RWnhXs/VBIaM9S0t9/2UoAAbzROa8OcA==
X-Received: by 2002:a2e:9cc9:0:b0:2ef:1c0f:a0f3 with SMTP id 38308e7fff4ca-2f15aa88b76mr125008231fa.6.1722958195923;
        Tue, 06 Aug 2024 08:29:55 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4294fsm555274266b.103.2024.08.06.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:29:55 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/2] tty: serial: samsung_tty: simple cleanups
Date: Tue, 06 Aug 2024 16:29:44 +0100
Message-Id: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGlBsmYC/x3MwQpAQBCA4VfRnE3tbkheRQ4Ts0yxtINI3t3m+
 B3+/wHlKKzQZA9EPkVlDQk2z6CfKIyMMiSDM64wtalQadEjjLjvN/YzUzg29J7YlrYkVxeQyi2
 yl+u/tt37fnhqy7ZlAAAA
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
André Draszik (2):
      tty: serial: samsung_tty: drop unused argument to irq handlers
      tty: serial: samsung_tty: cast the interrupt's void *id just once

 drivers/tty/serial/samsung_tty.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)
---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240806-samsung-tty-cleanup-ffae1515a284

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

