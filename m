Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB4264A97
	for <linux-serial@vger.kernel.org>; Thu,  7 Aug 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582085; cv=none; b=ZuNNg2oG/mmJ5M79mTKXGiUFpPX0BDdlyi96nLvvKpY3QmHu7wmOsjJHMjwWcNW9P+xn71soCncPYxTdqHD0Lv7Fug+0KEfyd1c7waCX15Ym971GUPVcpnlvI/WFwvmwRVpUBd9ymlWHYz/qDD8A3Am9dnMjdJCyAH0DbkevePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582085; c=relaxed/simple;
	bh=dQnC/rev4tac0Ts401jwqrEOatxbEZjF8FGi4DM7cuE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S3sq4cEXq3uxFBVLBEc3fSlqm80WK6reAK4YJPdK7ERbbjXTaFLVtbzaP/axDbKgmu9lrgW7sxKN/DaqdrcF92Tz1u9pPbon9EbZz4/yOIDW3ISLfYNbKyP2Bzhz0c1XNDIapsDcp6W/qsKOFGDLaPirSHyaLZVzi4m5IXlvSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pDhSkzzw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDhSkzzw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459ddada9b1so11174145e9.0
        for <linux-serial@vger.kernel.org>; Thu, 07 Aug 2025 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754582082; x=1755186882; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ueKHvcoj//pcE68ugp7qzX4T0VIpPeXJwA1UBSmhQZM=;
        b=pDhSkzzwsUQOUR01OauCzE+IMQQRfBYHOiGyhqD9G9K4zHjwihWk7kgvgNnp5AZb2f
         mLbQ8hTSe1TN4ZoE+NdwzQ0U8roQeam3U5gTnv+yfdx+G27kNNMnkcWq/vB6viZ9H0WF
         /I3eABW8I5UO8zswUYxbSFU0zo8d1hHIVJa5eGD3MfFM65lgYLJRXr85qbkfb/3UmgFn
         86zKt8Ox/KFit+ZsShPaynooikEJEKjRAbwtxSxEtYRFeRptp7mhM0X4wECqpMaRfHYX
         5j2l45ACw05K73vaKVn9KGeFb8CKQDD5ClGrEnL9gHvCSf1zQDPy2Sjx6iyWKkoRy+Xc
         CjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582082; x=1755186882;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueKHvcoj//pcE68ugp7qzX4T0VIpPeXJwA1UBSmhQZM=;
        b=ia52MXBpt4Zpdo3KKT6ntghDSeu1U+JGQjtU0dI/lOpBMB9jCKA/46klEww9SzL4kP
         dc0sUaL375A1HKxNMPlp39cFJYyYOt0sI4757Rt3EN+6HNsp6HlWjHlUE6T2TeOw9alQ
         aR2qKruKrb+/XtHVBiI08tZMfmDPZ6jqiSzSkGaHFjehp/y9KbNNLWoEaqydwE/3u+BQ
         akrr4iEL6dWmcLRGY5apT/OW+xMYIFjm6sNZqL2ssUDy9pyjO6PFqlge7tpFo5pKmm6k
         Xv/3zVa4vUaqiBd2iyiBmk9i8Z9C/vaO1/mdrjQpgjwkUfkql7gFH1jzP5eCTT2hdyTk
         tj3g==
X-Forwarded-Encrypted: i=1; AJvYcCWHowzeWtOG8OJBDadAulwLOSL/eCfIMctrDHEWqqy2551duPaqDQqr/gjAIrreS8hXGD6pBhSfQnCzCgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZKS9ic2hg6TI/4Jq/jzo2k1bvw/B8W01fwm6kpkczWTa0nWRt
	ROxAK1vupCprfyLFSx6Z68G5IrlEH6zvezcEFPvBpT9hA/Pa2jtctTog+mYm9zgQeyU=
X-Gm-Gg: ASbGncufG+elvptfUvPiMVZ9MTynIV89tj3xpX78Dt/EnnOMiWwj/Vo/MkLwSaKJBok
	VkUcgSlwLhNFmK9uwxGDJguDgmHY3Z6jBkYKm2mWFlGLgJPCLa6GtlRlLVggl3UENZIgjrAkpcg
	5fOK79nGxj8bb+kuLbwdQeWFaSvD7duh9v3YdROkM5IlP08jAEQD0XrdVSr1xtiUuLJLs9A6pYV
	73vRfqGG9PhwrEnzz5CcThaHfL9lJNg4vo8e+ievoHvG77MuudPisfSkorophD4CSmQX3PH/pqc
	Xta5oI2nxEtYGexdy6aZzaCyTvQ7Hkzo5cjZJzDFE7kJLW/SLwWdPK70tgYggHvna79XE11bcsY
	ySa9Ftxqs6JtvqKWbT6Wr8dS7qJU=
X-Google-Smtp-Source: AGHT+IFZ7tU4QT0M69GUy2O5NIPrZtS9sVVhdfW1gHaibbjzTCtPYoGYDhegeuvn9CZmTQptWfLgtA==
X-Received: by 2002:a05:600c:5254:b0:453:81a:2f3f with SMTP id 5b1f17b1804b1-459e74bc7a7mr74819405e9.30.1754582081709;
        Thu, 07 Aug 2025 08:54:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459dc900606sm162804165e9.15.2025.08.07.08.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:54:40 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:54:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] serial: max310x: Add error checking in probe()
Message-ID: <aJTMPZiKqeXSE-KM@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Check if devm_i2c_new_dummy_device() fails.

Fixes: 2e1f2d9a9bdb ("serial: max310x: implement I2C support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tty/serial/max310x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 541c790c0109..2b42a4c21a9b 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1644,6 +1644,8 @@ static int max310x_i2c_probe(struct i2c_client *client)
 		port_client = devm_i2c_new_dummy_device(&client->dev,
 							client->adapter,
 							port_addr);
+		if (IS_ERR(port_client))
+			return PTR_ERR(port_client);
 
 		regcfg_i2c.name = max310x_regmap_name(i);
 		regmaps[i] = devm_regmap_init_i2c(port_client, &regcfg_i2c);
-- 
2.47.2

