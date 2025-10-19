Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26ED11713
	for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760864038; cv=none; b=ah32apu12+lhQp4Ryuc7l2VaNci2fVoHl7p6QcIMMwfqqGNoevYaF563AXVyRCytnJl/dhYTVsccwTpToAQYToS089RmrxlvT2b/SJcV6qFDdkAbNrO9RtglhC8moKf6BzVRbdDQtOjY0HBxMGsTVN6udoQ09e8xMfgD2MGWmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760864038; c=relaxed/simple;
	bh=B7lK6WdEPVIV/jVwlFcbiH2rLakLIWiHaQY1KV2oU60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDRf0yrANP6iMNMeTStO1UGuclnk+SRpZkqJnYfnc1cx4mxVADV+OLpf6pvyzPT54ib4I6DOExn5VkpwSSGrUzgE6SB4goFbXJ4zR+l4pcv1mz/fGpSbus6jzaXjuq+rOobBEAWEoej0pkTuRtHR2UQRq+Qv0uTnA1CSJSvsUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcW4LW6Y; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcW4LW6Y"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-367444a3e2aso40360501fa.2
        for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2025 01:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760864034; x=1761468834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=savhjec6/koJGGQDuCRH0JcAzleQmiExHQobZiRYHTc=;
        b=ZcW4LW6YTWfiE10kDNbKgjmLfLS5XWieZFbcS8awJAi2QbkXSIgKij97na4yMd8l0x
         9yLEgSgiM/horbJBnQFPtd+zwEFzNXqUbQyRbVpk0kvd8ezOVu0Tt04RoAh1pIpMIxrL
         1LKRynENy0F5z4mWxe8WwA1GocotxDh1ZlhVg5WGjeav85BJCa4B0/x51K+lD6vb7hsA
         IBGzjQMgLMPxnbdAyooWy3zAXnMIWcr2AXiAdGkkkZiT7G9nPVZElas2RiEm8FxnN0b1
         TcyUTd8wJxzcEPDMfOt9Q+P4c1MY9rHAGJ50hV3MWM9nhgzgEJeXAS6M0D7odHQWGiAq
         KVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760864034; x=1761468834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=savhjec6/koJGGQDuCRH0JcAzleQmiExHQobZiRYHTc=;
        b=ciyyWH8KniHsKDLhgMzamZjQQgjI5bQ4GstwdKsDISncMe0wNGgZYePRSY2+2dImSs
         1kv9xF+M3hBbIlKbnCEwjmBWxnvl5iPXwke1qCVtrOiarhYPZUPXcAaCx260x/sstRWg
         HT09zTecgvmnWkUeBVBoumLinIvdGLpHsICaK8e1+a7xK5iNgMbOsid67eeoy+BA3QVP
         txcZ8a2j1t2Nt4IllEE4SrXPAM6mwdXYZyY/iVPhUNATY0xKoy+yIcoDJEhX8EsfFX1o
         m4G2yG0B3atY17e3wPzAjgbAdfq2e3xsMWZC4ut3xmxhhZ3bvuD3p470nHf7CmHkEzCG
         FDEw==
X-Forwarded-Encrypted: i=1; AJvYcCUOFUlBTN0hkngbhVRcTbPJ7vUMbyokXrDiQH9Idu75BOSgLC89kdT85H8AQoDZ3cy/NhWbpMqtndsjRaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyipBd6Nk5SA04peulegbSgxWX/6RA+Bm+wKBCGgMRHK3+Kifda
	V3U6HoxL5S23gmiwppCQ9856q0omdeSxowAkf6y7shEOjcgIqrNpCCQ/YdEYOg==
X-Gm-Gg: ASbGnct2lpiO3P1Yqt1KMLQ7xJcXeCw2YNWgEfKd0Moaxw8pth/GhUGfaTZPuqF5Fy4
	bkOnmKLnpojGpikv9fM6mIyrZbbN0AIH8nShgc2lVG61YLcOyWbrI1XLTSBRhCStu0QjF2dCGw2
	L3WI9YjL0oTKAqxMTpJHRQ4Y7ZlD6HB8XqjOlk3cjTH8oZPW4hVC1/KKgy4Ct2bbGAmO7gplyHT
	NJuu2QfPDur51d+zDc41h8jQhZQDdzw9HT+xxHIJmTqq/yHYOKIofMpTWUwMR6gIPitLYXEjCSZ
	M3B8wde5+mU4q+5JzaoIQKcon4UvUFtwueKg8ZgC0xx0xzsPg8CSI4vThVF4Pq7iMBDjGFyGphk
	4ihpXW3uKGdmOLlMInyRJVDm9vHs9dM8iTlRPkO9f9yULhEWryh0wkGTkT+vG8Bqe27tIPBv9YK
	DMzXEpE1a06/Y=
X-Google-Smtp-Source: AGHT+IEKPQuqSJ3g4pw+2iojsl9js/Y4J6ZPVEtChS4rkkTO+szOKn9vOGeS6hNXhnWp5Cbr/ZstzQ==
X-Received: by 2002:a05:651c:892:b0:371:fb14:39bb with SMTP id 38308e7fff4ca-37797912769mr28170581fa.16.1760864033626;
        Sun, 19 Oct 2025 01:53:53 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a91f49basm11972401fa.16.2025.10.19.01.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 01:53:53 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: a.shimko.dev@gmail.com,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	p.zabel@pengutronix.de
Subject: [PATCH v2] serial: 8250_dw: handle reset control deassert error
Date: Sun, 19 Oct 2025 11:53:25 +0300
Message-ID: <20251019085325.250657-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aO_NYGFCKb0J2uqK@smile.fi.intel.com>
References: <aO_NYGFCKb0J2uqK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of reset_control_deassert() in the probe
function to prevent continuing probe when reset deassertion fails.

Previously, reset_control_deassert() was called without checking its
return value, which could lead to probe continuing even when the
device reset wasn't properly deasserted.

The fix checks the return value and returns an error with dev_err_probe()
if reset deassertion fails, providing better error handling and
diagnostics.

Fixes: acbdad8dd1ab ("serial: 8250_dw: simplify optional reset handling")
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hi Andy,

Thank you for your review.

The v1 patch hasn't been applied.

I've addressed your comments in v2 - could you please take a look when you have time?

Best regards,
Artem Shimko

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20251009081309.2021600-1-a.shimko.dev@gmail.com/T/#u
  v2:
    * Add fix tag to commit description

 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a53ba04d9770..710ae4d40aec 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -635,7 +635,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)
-- 
2.43.0

