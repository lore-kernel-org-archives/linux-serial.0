Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CDF28FF;
	Thu,  3 Apr 2025 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743661700; cv=none; b=pCSmje+h0F2KXzDpacJNM/YPfZYTP9NsJKQU8M/nvUjRaMDH3Bng7Vx5eiBiNSirGcrLTY9qm9GgUbfGzG8tkck2Y8zbmuOt6HGdpuNWrtwYllilGISGUV70ArbWKv9i4InCD9+F7Ehv/CRWM0QfRIp5wZprFOBQyYodFjpIzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743661700; c=relaxed/simple;
	bh=x8cKCl7UMMbwrccfbeSRllIxdCYB9+ViYGvLRKmaVAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lVOxYtbvYlZDmh9dJ7Uax7NDS5g6IrdpZhMdJ6kHONG5GnQileEu8eb/fVDSdwphofGU0ahOe99+vScFr/PPLZrL3Y47WSkSyMMHN6EMkSGrwB2KgFBCjmEQ4ETO1/DyQV5CkvTHtNtcKUUqvHsQsjSk9KHMmfmV8/LBYSx3oEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMnQTYgx; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMnQTYgx"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso512254a91.3;
        Wed, 02 Apr 2025 23:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743661697; x=1744266497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zv2Eim6EJxK+6ui7lY93m7UU37Cs8RrVaOWKjl9KmMc=;
        b=SMnQTYgxz+BZ8jEv3v0sBuR9qT2AJGvYazfW70/pHreJ8hBPrRTKgxEujA7441E0T9
         16WMu7ea4kw69ckQh1yNhJ22sRyj7JPQM1sWc6bFan959fPAKL00wHRsrK1P7lLbYs2k
         b6Etzq1pPUvAUSopyWA+jUSz2lYv/F1CfNmIzvJhKjGmwGu6dvhnRvk6mZWVmuEbsWRE
         vMXjslq5wrmq+3HXa/BIdkQpqqtO6pewbpgEl/GBMXFISoO16S0kjv6cQz7UzvhIV+w7
         CInBeuIF2e4ql07NfvI2wp95MEfdGB2bnaJrn60PizgRqer/O+LjkTCqktoYwhi+FxSB
         JElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743661697; x=1744266497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zv2Eim6EJxK+6ui7lY93m7UU37Cs8RrVaOWKjl9KmMc=;
        b=gog6pzrHB4kiPb1Sh0PTu2RiqRnSJRbJepNho3zvJhy9rcTb+W7+Rlr6RQB3d7zbYW
         bMWs5fr1v4wShOYqAl2g8Ab0i8cRWtppaSbyK3mlywOzQg0BWL0CFQ1aDcx7/WZ7TQl0
         vm5A/xEMQW/akkYNjRqm769ZbffZy3bKNpSqvN1Kj5YsDGhR7t4gYmjd/SDJrySs3nru
         SV8tIwKw84wCnYEm8P3PbvD57t/jFzImEh7m6a6Pi9OPJDDsjmCYmLte1YVWaiNm4fDY
         7RSjNGsIoZmD0FMRf0KecgYPKXIY1xuGPiWbpv/fhnOkTcE/POpxfmFhNXAqQFhZ59tR
         5WYA==
X-Forwarded-Encrypted: i=1; AJvYcCXYlZq4AdiGXIehl6JQAcB8hN9SIV/Fv8Z/UW8y7oSG0P8YDN6uZk39Vke3sU7tvDSoOcmhoBBmg9qHGNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8C1Pi/CVwBXFfqpFhKRc3JmuGzPFmFz5hzmqffXXRLirPEH73
	+Q2rsu+Ovd+uuvaHIRGpQAOL6+ICwUxybCq2fRizo1NKZC2SAzov
X-Gm-Gg: ASbGncsjJF2S428Wp1fEe+Q20uSCtZDB4zsquJLl0Ry6889rcjjt5mHWc05U00Sgrvv
	1GvHhDI2qVBxepwRb/8PRp1WWDGImsozO4k4AyB1CqO1b1wcfVjuTalAMp6hJaEp0HsivfUKIcK
	XtrZNZsahf0EEg48pGq80WPX12h1LqFxS1/cs/U0BIikkRHJfQGtqo4jSeuR9XUDHr82LPmi+MZ
	yQJZXDu0/b5aeWt9ybor5bSDlM7W9fkU6zBCwwo+s1pU0FOgaENki/pRNurA58BbQwOJC5lofDv
	dZ8QZxi06AP4e9ZK/JHet5v2kQooL4jpZAMjHOPfgrmdQfn71mRhnV9sgx+T/2SurCyRtsA=
X-Google-Smtp-Source: AGHT+IH3/7oQDppEuWcYDFvnSNSVp2KWqayWvGz4NpuF6q5e1fxmt66vYC1luZBtdcGvzxbf+Tt5KA==
X-Received: by 2002:a17:90a:c88f:b0:2ff:5016:7fd2 with SMTP id 98e67ed59e1d1-3053215e085mr32933013a91.24.1743661696860;
        Wed, 02 Apr 2025 23:28:16 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca5163fsm926950a91.19.2025.04.02.23.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 23:28:16 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	sugaya.taichi@socionext.com,
	orito.takao@socionext.com,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v1] serial: Fix null-ptr-deref in mlb_usio_probe()
Date: Thu,  3 Apr 2025 14:28:08 +0800
Message-Id: <20250403062808.63428-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_ioremap() returns NULL on error. Currently, mlb_usio_probe() does
not check for this case, which results in a NULL pointer dereference.

Add NULL check after devm_ioremap() to prevent this issue.

Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/tty/serial/milbeaut_usio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index 059bea18dbab..4e47dca2c4ed 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -523,7 +523,10 @@ static int mlb_usio_probe(struct platform_device *pdev)
 	}
 	port->membase = devm_ioremap(&pdev->dev, res->start,
 				resource_size(res));
-
+	if (!port->membase) {
+		ret = -ENOMEM;
+		goto failed;
+	}
 	ret = platform_get_irq_byname(pdev, "rx");
 	mlb_usio_irq[index][RX] = ret;
 
-- 
2.34.1

