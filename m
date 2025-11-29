Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCDC30FC22
	for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764427891; cv=none; b=fj3oOInOxMgy91vUknNiJW6YKaJh/mxeB7LJNFoBQ3prScwA+AhsmkRwiyHRFrjjeCR638pTXijIDXTwLAAFbTx335DaH7TSR8xbSlzR5lUITT+19jdLDg3DTiYWJTLQkHpcvaYthWR0tFwMV+2XZmDN9uhdabTVscptt3BCw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764427891; c=relaxed/simple;
	bh=yXuzbB5K11aoAVf/PdUJHMtRCcNu/HBG6yFSLwI7cz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uW7GdbVPdRF6xOsg9UVL8JI8xy91UkV7e6e/mAYbh+Bcl2paVebbveiztKrOVUKQYJWuIUO+Ykl3N9OL2y5BHbj5ZYoS8byEbX1bC23jLUbX1v2UJdpmaYB5q3DL2d2/INmqtcaKtb+NaarV92OQnAbjf25tYLi+kTSYIfJPMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yI6hHpiD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yI6hHpiD"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so17017825e9.3
        for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 06:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764427888; x=1765032688; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQXSoEpDQmDeEVkRT8hWvYNMqUAKPz+YQ9lwivzZSic=;
        b=yI6hHpiDZYiY8sH9G6K4TD3LgzDVhEiRTQkDIlmGtfKljEOnrlmLGUcpyAhMttZqh5
         KMiL/V/kB/39iDelyQCgwBKp5USNS2/Y4dwKI0de6A/7ta6U7y8Q9WwVgdwHjEEN05bz
         +9jyyrodsrEvoyRrA+kR0q4edLVnNWti6KoHi/wu2K1o8N+44ZYCFZcJS8Z5kdG/fjxn
         6SxsEZy6SqUlA35ml+CX6seO6V6rLsOXspnH4WNTj9m/iSpwoh5wUSv4MDC3/9vLF8SF
         g80GLyA+3zW5UUAARk/eLT9y+32QM4uUgyxOUQIabIG1E15A/rZfSLXWKOjyD/63NISQ
         ydWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764427888; x=1765032688;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQXSoEpDQmDeEVkRT8hWvYNMqUAKPz+YQ9lwivzZSic=;
        b=rEPoAx7UBeV5lCMKVJrtJPjbMdond6tlC/KG1ruQVMKUn/vQ3wqhUN98FTxJcUwvMN
         qhUgQ+IDSr3flUWaX8MkEvUVvqbvDoHEF8Pk6GPMZMOkpbaq2ktQbzoSsh2JMqug9Eq7
         GfICjpxqVJPq+mFici+TCdpN4dGHfoFuNwisLeDoK3YXNk3EFL0RkuvZYIt+pHTRcj+I
         PuhW2e8895MXHerD2FaKZwmXGs9BojdsxLD2+L1GhhkP3sGCrqdmjVYUOHDjMTjHjsZo
         rZfen7BsdeB20L7UCI22qd5HeYBrwLCHXWBSYSxOOdgEAUnJeK4Aw49YNWbQYv2nvy4n
         ZlEg==
X-Forwarded-Encrypted: i=1; AJvYcCX2UJp9OgkmRiIDDnA8CgFJs2xpPGKjNVVFtabLRrvN30h18O2Ndrj3R8fLqYb9fE2MrEE407lNdElkMx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPpuER9rsPm6A959c105xmol7zGthKUPp8doFIKi4M98LQtye
	kaqHZrMUUK6MZf4xCRO1K/3ZkbW0TqBy/6jGUheF8OJ2yNZhG38Zn86cehIgT73ze7E=
X-Gm-Gg: ASbGncsh13hlzqFfi8WQiiuRG3j0jm3hKQ+ncmsOcKYoHMOElEmraxG831rM3ViCEB4
	fszhBMF0EY6l90qVB7s5GaY0o/+cTlqL/mRRRkE4cDhWG1CLWepiymF7XojBXfxWFHg6qZlK83W
	XNnm7zlnfuD4fYeCZGBMRc82Mhi5qUNqXUVWWWdEmYmimimtZLSLc6oXzWTz9pxFwyiP1y1AXQw
	39AwbION2BfSEfKdsHmKpTEMMmYAagA4gEvpwYSEY8H5JabwvGnMQEzi3eEy7j/NNrpXYqiBDx2
	53hGxSHm2D9WGYW+6/3S7pLgg5BzWRHIuYA/v06rTWnFIY1U0cw4ULQt0I2ZaEVnVG1DpZ3PMm2
	xPz+mP8WJzt49HvmZ49MapuKRVdfk5/s4qEUrhoLMWeb06Glb6wwpDNZFce3/wHMCPqmY1CACsL
	4uXq4/m2wwE1PmWu1R
X-Google-Smtp-Source: AGHT+IFCRIwwQjXEGnr5KMD8PEnIqaChZkTl9rQxhpXbO/SHWmtpUVHAMBf5uCzKP5Ao1WMgSwS/nA==
X-Received: by 2002:a05:600c:1c13:b0:471:786:94d3 with SMTP id 5b1f17b1804b1-477c01b201fmr310642095e9.22.1764427887618;
        Sat, 29 Nov 2025 06:51:27 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1ca4078csm15519763f8f.29.2025.11.29.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 06:51:27 -0800 (PST)
Date: Sat, 29 Nov 2025 17:51:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] serial: 8250: longson: Fix NULL vs IS_ERR() bug in probe
Message-ID: <aSsIa3KdAlXh5uQC@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_platform_get_and_ioremap_resource() function never returns
NULL, it returns error pointers.  Fix the error checking to match.

Fixes: 25e95d763176 ("serial: 8250: Add Loongson uart driver support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tty/serial/8250/8250_loongson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_loongson.c b/drivers/tty/serial/8250/8250_loongson.c
index 53153a116c01..47df3c4c9d21 100644
--- a/drivers/tty/serial/8250/8250_loongson.c
+++ b/drivers/tty/serial/8250/8250_loongson.c
@@ -128,8 +128,8 @@ static int loongson_uart_probe(struct platform_device *pdev)
 	port->private_data = priv;
 
 	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &priv->res);
-	if (!port->membase)
-		return -ENOMEM;
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
 
 	port->mapbase = priv->res->start;
 	port->mapsize = resource_size(priv->res);
-- 
2.51.0

