Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B5189531
	for <linux-serial@vger.kernel.org>; Thu,  8 Aug 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104715; cv=none; b=jZxXLJ4PnvdHAzi4CuxCoAFnumxC0WsfIGpl1K2BFg4mLvzuDoq0Eqp41LR6A52iQzzsHvRmdtF6y53SfRppp4lAr3IRZvSOEWduw2IygiOLWZ05Lfy6vjxo5LPHcE6p3+Ge27+ThRyIrYvGMD68MSa7x1fgj8h1+dc4Xvn3WXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104715; c=relaxed/simple;
	bh=yFsoJ9mu3l1qUsrZE7X9Q80arAgVjyJqIpjxngrCFmg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=twXsRrz19i+qj1Y1t1H0w2R8wt9KjAm7hGJqXvApCKq5uTN8vGHtYNtWOlicceFN5JmgeI0BraDQDYURA9sSCbgCYlFAwLWmzxqSv/k8C7SN69E/G8bDSJS3x3j8ONL/I/ov2yCIfU9nn+23bTD94eBleiHxqZeP0+Z8y5JhRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=spiRVyoL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spiRVyoL"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so723041a12.2
        for <linux-serial@vger.kernel.org>; Thu, 08 Aug 2024 01:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723104712; x=1723709512; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gFAHdHbSCvCmFdkOYebjZm00aZdGB/6GINbpF7hXjDk=;
        b=spiRVyoL/ErlczPt/AYCOjLeH/x9NjzO6GpXdLcnZjG54TZImphYZ/KU82+09OqaH+
         ld6wbTrnmJ6y+9iEU6hvKCBRr84mH1nSRFQlqaGZ+dOc1H072/KADVbl7F1btV4ne/yq
         iAQ3E7fLOCJ+Vc51nJIJKWrgJTxfTSc+E9sdZvLYnGH+BDJvYpoiVRUlDTragrD6c6fW
         UQ28M5+2vDWzeijN+3h/IcO76+XwjQgCGSQgCiaUpcQoOezMJUT8pXCI8F0WVYi7N+zz
         agfVt9oR2UJDe1TX0SPmb3W9uy/10Ibhxs/w+0lOvJUXrE4sZkgUZGEM+eiFs9uNQN0q
         Ey/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723104712; x=1723709512;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFAHdHbSCvCmFdkOYebjZm00aZdGB/6GINbpF7hXjDk=;
        b=qSC+gI1csxU7nscGhFdTnu/DmyhxTznYfXbj7QcUC7wH7Q4TayZkeSrHX4ezNL+iV7
         r/Xc4nxI0U4gDq3pyP0oYMcrGyWJSQyTBN0fsBeJ34wXBD5jhnndxIKuRMinMHc+YSLI
         PegWRP6eiAqawwDtmdWcJ18NiuEazO+dDcJT9b3jQw3COxpZoHHJ+20jeZZa9KsPgNJy
         Qjwh/V3Bh4SmC5p/DH9T/vTQhcHcpdXKHiQIEvlf82BItHFwFPn0BQ4oKu1Xn1UwRNfG
         ooPXhokuuzSL3kxM00toL1aL4whkGJg7TXlnkBCH7YBDVLwC5G11/UwxbgJGCb+IDVLc
         eWZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGBMfeBFXJc96CeFrnGh9k1PLfhFPYcKVt9o9tzk6+VPdgYBaC9AxFjNHM1r1f+G/Zzny612tzeMz5FzFcb7BiHUgcUYNCv1gEVPpD
X-Gm-Message-State: AOJu0YwclW124EBYgnsK2nCo+a2TE0qq46f/YatRqzEk1jpSerChPTAx
	Xg36jn6yDzcgSV3gOezXi2dWQ1k2Y1dTwaVr3HqM1cWxq0AcoZKdDjkKY4DRx50=
X-Google-Smtp-Source: AGHT+IFVHcQpOJ1IA30E9TCFE76Yp+RCOzBaCHLeFkPrR8+hAGw9wBBdmQAK0dZ+KGxkQvl/jx5+kg==
X-Received: by 2002:a17:907:970c:b0:a7d:cf4f:1817 with SMTP id a640c23a62f3a-a80907c9862mr69351666b.0.1723104711847;
        Thu, 08 Aug 2024 01:11:51 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c578sm716931166b.73.2024.08.08.01.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 01:11:51 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v3 0/2] tty: serial: samsung_tty: simple cleanups
Date: Thu, 08 Aug 2024 09:11:50 +0100
Message-Id: <20240808-samsung-tty-cleanup-v3-0-494412f49f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMZ9tGYC/33NTQ6CMBCG4auYrh3Tlh/RlfcwLgY6hSbYkhYaC
 eHuFlaaGJfvl8wzCwvkDQV2PSzMUzTBOJsiOx5Y06FtCYxKzSSXOa94CQGfYbItjOMMTU9opwG
 0RhKFKFBWOUuXgydtXrt6f6TuTBidn/cnUWzrfy8K4IBlpTKsdSY03Xpj0buT8y3bwCg/kfNvR
 CZEqLpA3VxULuovZF3XN5XmeiH8AAAA
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
Changes in v3:
- undo too eager removal of 'const' where unnecessary (Jiri)
- Link to v2: https://lore.kernel.org/r/20240807-samsung-tty-cleanup-v2-0-1db5afc9d41b@linaro.org

Changes in v2:
- fix -Wdiscarded-qualifiers warnings
- collect tags
- Link to v1: https://lore.kernel.org/r/20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org

---
André Draszik (2):
      tty: serial: samsung_tty: drop unused argument to irq handlers
      tty: serial: samsung_tty: cast the interrupt's void *id just once

 drivers/tty/serial/samsung_tty.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)
---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240806-samsung-tty-cleanup-ffae1515a284

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

