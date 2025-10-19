Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9FF2E0934
	for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2025 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760867507; cv=none; b=oNevZvls5ey8an0iuOjbfykgL2D2sbVsCqN8ZsOARc+vKT5/rWB+kEoMswIoG7xEsU+445XnHnHN1YGsPIeihYSE3JQOfit5VZOIWPlyFIYuPvRUns6RyKBOBusYjv7SZwLK5vt6PRgsL8jP1wlLdzTV3mMFDLSp414poVaLHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760867507; c=relaxed/simple;
	bh=StQ6hiSS/ddwlsO576uA8gheOyDnzmZgNCzeCn8v2yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUEPd+zgDLb6POMn/ff+1D3FYAWGZddy5A7JDbJ96GAOaws2TGmOQxAQboQAiL7A3DCY+xncF4chMXJ28TrM8Omk9QexnP0nA+aKXZR3/VS5bTZMELTnUTQEXttkECPENlFgWdBHUXUTr/KzFPuitGOBBde+uQcAfdSDALxRm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM5Bfmmd; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM5Bfmmd"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-579363a4602so3427878e87.0
        for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2025 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760867504; x=1761472304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+DYglWBDI71zz/BrQNEMs/n8cMj7C4w9i31aDwg9uA=;
        b=YM5BfmmdTm2crHm8SpTJyauU9zRwRagmBQqLeWCceklsUcmzPE0Vr8Vc73lg9AFwNo
         pVwccn2jPjXAcWv+7hiZEbCsQ1yjk8WPGUROnB+wtjp4QSCDAwRR9x+Iw7gS6T+bpFC8
         9iFmRizSQFiA1ydoffF7E72BmmTEhlV8XeBGI6d6A35wSYGWIYuILCOe1/x8nH7cr8io
         UggGwrzmlCftW1nYXTuUp8z9opLhGwh6gJLVjYj7uAqHc7eCSFzX3GVE94+g4uyCUFrG
         XjsUOYh41RyNAVsulpIdALjzALEGGk7/fs9fm0ZPMGsR2G7apU3nzMw2bN+jf7zEew87
         wQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760867504; x=1761472304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+DYglWBDI71zz/BrQNEMs/n8cMj7C4w9i31aDwg9uA=;
        b=eSH7wl20XCE6PacoqpQLQiJ823eN4oNE32JZfQEuK/axD2XqDp2tXbZvH+DKyoFShq
         a0qnE2W9X20njNZXTZkVeCNZN446dreTrsBGFx3VBnv+TGoMWc/7bStcZ8GF36EELPnu
         cy0gir4TTAl54QDTYma4nxz6sPlchU+UP1xNfMOtTt7KHaS0vJJ6RI1BudSGV9KPXTZ6
         NunmNrCN4CY+kvq4lWsBMIUWomooJd4FDRvK7OLJrjYPKZIsugaBNt4M3ot7xXhkSl+t
         BLcOEkgjo6GdKtBvXSiyKl7B1KEbCpWjX7fZbm2XbJqvD5hsFqq/KAPizB4yI3gSOZQ9
         mB0A==
X-Forwarded-Encrypted: i=1; AJvYcCXLFheE+ct6aJsK6kbIZcxQxBRfgKB5jMwmRZ3X+f/qPWRAJGNZWUYfIk3coNKBBe/h3jOduPudr4tz4aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDkYSE5tX24jvLRG3uEXfXfnmWJPY040jb1XrLknAuS3Ga/gn
	RzfUfnKNzsU5xAPm7oVEYF8o3CmH7VGbHvbf7wDEuS5il7ZeLPZCMu6be4QOSA==
X-Gm-Gg: ASbGncvg+NjQww/kLC7DwSNKvoSnb2E/ek8l9mp9nej0cCoiCwtb9i0DO75ItKWxVJG
	lWF30SE8Lp8B7zxL541FxJJZ5TyyHM+Rkg1nOJoziAfpfdw12KGqc3Nb74BDpmGmxJI6SgSQbpr
	7VEiVHHDKd4sLh3+JUqwBv6+ujD6KcaW0BJkd3sUu62kzj6jgdsTutKfAZGMVB47RL/IYSJ12Kv
	EFySQuyF26WLqhfbU9tRkLLYYF/Z9ztRgZ3GkBaVirun8gM6cfXstisBNPZRnHYSnx1IyCWpoVy
	D1ibKasBhCMuPIhFEPZwuSBzYvfe6IyFHA6rLv8wxVVq856nvSE4Oe3SVKRxu20C+pWWMar1zFI
	lUSwTdQ9QPpSGeICBapKJI6CI9jOt3w9PUD8OhMT5src83dlp/9Pzc0tkENxIf33zDunutJjOfo
	i1
X-Google-Smtp-Source: AGHT+IEk7oK3CvYkCqvLOZMVwW2h+hwBO81K6lyYByY9eQ+fsQlUxRuRCe5/anMAeziBgkE5R5Avug==
X-Received: by 2002:a05:6512:39c2:b0:591:d120:1094 with SMTP id 2adb3069b0e04-591d8577799mr2641550e87.33.1760867503501;
        Sun, 19 Oct 2025 02:51:43 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deeaf49bsm1425739e87.28.2025.10.19.02.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 02:51:42 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: gregkh@linuxfoundation.org
Cc: a.shimko.dev@gmail.com,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	p.zabel@pengutronix.de,
	stable@vger.kernel.org
Subject: [PATCH v3] serial: 8250_dw: handle reset control deassert error
Date: Sun, 19 Oct 2025 12:51:31 +0300
Message-ID: <20251019095131.252848-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025101902-puritan-thrift-b2d4@gregkh>
References: <2025101902-puritan-thrift-b2d4@gregkh>
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
Cc: stable@vger.kernel.org
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hi,

Done.

Thank you!

Best regards,
Artem Shimko

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20251009081309.2021600-1-a.shimko.dev@gmail.com/T/#u
  v2:
    * https://lore.kernel.org/all/20251019085325.250657-1-a.shimko.dev@gmail.com/
  v3:
  	* Add Cc: stable@vger.kernel.org

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

