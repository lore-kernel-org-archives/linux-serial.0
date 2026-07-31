Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD43101D8
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514703; cv=none; b=PdSI60IGL4Mlx/g+EcbtAe2k4kID6YVrzNDllqGHOTSlmwG3P8aCji9UFTSx2te31hDUi3Z/Vo8BQA/4Be67wlLp0S/ScP3ezF0ZKL6vmr6rn+5wHWj+uOJm9NQiYdK+ZmTDO0b+mHQVBNYlr4OTMnU6D0mBg+xn4ISMUPPi2v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514703; c=relaxed/simple;
	bh=9Yzh38GRiodpjie4zcPRooc5jBJTJ/dzig1dvhms+IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CR6b8UkBSygYAB0ytzn9twUmbjKmlTZGs5PajgNfC95U5Cd63aD7kGZhe8/okeZqd6ZQCrPDrjiExaU3gSLL0o46hRJZc1gXLpNrgn4Queu0XyNB88hwUofRYM3QOM9pnL3rRyd//Nd/q4fwUQ9i72hoWQpOH60fKnM4LwlyYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA3kFAUf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA3kFAUf"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8486ac3f347so2291625b3a.1
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785514700; x=1786119500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TKjEK1gC87c9kIwXqKCw727kvsVZgAnx7reueDbTuj0=;
        b=nA3kFAUfNnWsWvjABU3qAPTa2LJKAgkKSsu6xI0ZOYvcntzGZ81szLCwl51kWs7uxl
         YwFO3cUVROsezXWdKL+9Fw30h+e6QgLl+lWb5R70DcWUD3X6QH5INo4AcOVXjkTUQBQT
         Wwr5kgaa9kWCEunaNoM6DGtwemBeMgQDw6UFVQPGDs9d8N11UIxHkCCzIZnRFoPQGWnh
         E5UpLt0RobFeAH/6QAxowKliQVUfd5wS7uevI9Aj124OpqDU7Nu0sn9xwYWOSonRbGDz
         gWP3EsYLKJOCCXYMWKAhvuL4/KbpWZZ3KjYNFyLrKrD/YBJjeRQbPFyX72zP2QLwtfsT
         6u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514700; x=1786119500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TKjEK1gC87c9kIwXqKCw727kvsVZgAnx7reueDbTuj0=;
        b=Trmp1xaVH5rWXLkOjVyNcr4Lh6GfeTsdf4RxrHzdN3TlV7XBO0Q+WmQUKvAL2Gv0tk
         7fUYaNj95h0eMnMa3qOScW5Bs8Zf7SaOCwiQ/j4APJOkcCCASEuxjiN42CtolnTR20W9
         72aKDRlk5cvgVsyDSxrNqYuv3nCl60x7jYSuBoa2pASPoPUV0Cgtv7xJ+Vp3xL9J0RbS
         29Fff20BpmMs5JuQPhfucg8p19gE4jwgAMV/+CkrLNtD1GnXbx4B83jZ1l+pd9SSxJHs
         /kP7RTS20prcLH/NsCs+FNRDUVwn+63VuLHy0Q4bBO06grEELyCI7mow3h6YpQ23LCKw
         2xfA==
X-Gm-Message-State: AOJu0Yy7CSvCjgbdtlGluZlIH45xktv9TtdSA7CVNSHYSc7GBdOKhYZx
	4wumGGA0QF7jjAfug1f9YWHl9ANAnBDbKry83srE1cVAJjsuqLQSYFw=
X-Gm-Gg: AR+sD12+uXzDcm1D0XwwqeTR/lrlMb9CcaSjpZOdeEKZmWQi43DWahhDIT8iirzdLFC
	nCUi7sINXKnPr6FtVpIrVUSaXW8OiQUFW4FVkdlgWJNmcl8lRjLmxzB6oz+/gaOUwxTjUU6Ukg6
	if8bPY6na+kPftl18B5CqOVpuXZIiHyiD8vkOTDXz5SebrA92mnC96Sv741edScMFBM4gLmujtc
	g9DN988L5kLX5NCrUHix4oaVxhIdXmDaFBUnPLOiaWd5oiVDYZ28T9LPmaV8TSRV1O1I4HY0BSp
	Pb4LfATQhKXXlbv8HJ0olPwz/cBnBibA67iOpSzgqiQY39VRSE964YB8Livu/w5pE0PQrZInzDN
	oFLogo8IoRe83TlimZ9J5lI3b3P5J0BuuXaiY6o3AectvGVybtRKCQFyEbHVdmc7MxnIjOvad6F
	+zhIvSYMr44K2GwZgOcliawxuOE6M4bV1XSNAeCmNfF81s6uKndv7fiuisETuczBp9uW3sCTx+o
	eHxyGVe1cLYZS6cidt0/Y9g/DwezuFBoEpZg7UOkJLltwrurlh9ot+yN6tiw5tXtfIUBcnMP9Q/
	Q3KW7g5DgCk+kMiF0jtQa2c=
X-Received: by 2002:a05:6a00:4b02:b0:84e:cd14:aeba with SMTP id d2e1a72fcca58-84ee48123a3mr269712b3a.6.1785514699546;
        Fri, 31 Jul 2026 09:18:19 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29e6f0sm647072b3a.39.2026.07.31.09.18.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 09:18:18 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 1/2] tty: moxa: unwind tty driver if PCI registration fails
Date: Sat,  1 Aug 2026 01:18:08 +0900
Message-ID: <20260731161809.45066-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

moxa_init() registers the tty driver before registering the PCI driver.
If pci_register_driver() fails, module initialization returns without
unregistering the tty driver or dropping its reference. moxa_exit() is
not called after a failed module initialization.

Unregister the tty driver and drop its reference before returning the
PCI registration error.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: a784bf7c195f ("[PATCH] Char: moxa, pci probing")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/tty/moxa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 1bb2376af85c..680b2dd65462 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1172,8 +1172,11 @@ static int __init moxa_init(void)
 	}
 
 	retval = pci_register_driver(&moxa_pci_driver);
-	if (retval)
+	if (retval) {
 		printk(KERN_ERR "Can't register MOXA pci driver!\n");
+		tty_unregister_driver(moxaDriver);
+		tty_driver_kref_put(moxaDriver);
+	}
 
 	return retval;
 }
-- 
2.47.1
