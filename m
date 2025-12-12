Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501F2836A0
	for <linux-serial@vger.kernel.org>; Fri, 12 Dec 2025 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765526978; cv=none; b=DW+khTIyyQA05fsOo3Ho8EurhAyy6S+Wo4ZFxQk2bzgZ692BFg/uisFiZDHvJvaBX2NCWx/WPum6mgRfVU0GETJ/EAaiw9NsUslLNTvJ/tXXeeYOeJZAFNVSh8vf5YOr1KV3riyi/xlQ1Sbud3imo1nSwSNyHy0asPz59iXeerA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765526978; c=relaxed/simple;
	bh=/7sjm8Q7YGQNrr3MXB7trnzKuxp3Tl+m5P4UFgGy1vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr8vMecSFMf/8O/FJt4eypVPayLrzBFzNQVxp9w5HgC7RN7nXYYFhsYElgpkpxXpcTxa77DxrLZ47kF0j8hOzqklhqB3zMEF2UVpslzYjNUDciS4Qtah1idOH6zA4uUbhLoUSPEFQdWi1RyTpGGnXSgBF3Jqt8WHREeDmooPl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rwfFh9J0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rwfFh9J0"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso1444026a12.1
        for <linux-serial@vger.kernel.org>; Fri, 12 Dec 2025 00:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765526975; x=1766131775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4Jg8UxPHFHcdnfExuoMtj57f/nwd0kAssY8YmZKc5g=;
        b=rwfFh9J01l0ilvxx98Din/LJhkp5i4wrciQIUuwrnbf8qI9CqHYeL2zQG/5HpC222U
         AIUj0EXbki3Jj+KxYrykVgtgh2IejE7Ye846uY5ybS7d5dK6PhNFAB7g+pMR16tFQgwz
         jr8SBbl9P0GiEqe9Y6Ua1FMNG67JxC5V0ppS3IZ5Wl929QrwIWpq2C5DCrsrRsE0Vn0+
         Np6st/W5gKxABFiuN0CX5kSNE9FkTdsgHyFKjX2pW10dtBPJFKXOT8aMiGJ8Qtv3v3tG
         Emv/MJO420MRtuZcsAs3vEVMMwd7x4DKpUNstgxV0ptXYQHEVWa1QRO8r3JbyBhDfWBH
         q2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765526975; x=1766131775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B4Jg8UxPHFHcdnfExuoMtj57f/nwd0kAssY8YmZKc5g=;
        b=G0VwJBZjjmZWFYIYiVcfm6JQDtpRLFchmy8jcJ7KxkPAXIpufX1zMtHDy4/4sPNpnq
         N0LSfOIf37C8EHoG35PGBM9wvAD+vkUxd1aCTBMsFb3fg1egEpurVIZ5Of3Juwm3jf1U
         QzjLrDIRP/zNLmo7SsfJ2uveL93SI8KO5KvUd1SI3MhajFTiG+c8cAr0GLTuvAHWwC/S
         c6T9YexF/AtRYLNkWFSC02DNOmFVsHU404TnQ8VT75mVWgf5pRGPG9MlkynRSBLtTPHq
         cMf5GWG5k7ghAJ/Ql8Yt85nVQb722PfLDACOjVdBI1ZpE/u4OfsAc6amUWZv29jTebSN
         ITFw==
X-Gm-Message-State: AOJu0YzsJJVFudE/dIwr5uQToNVvX0RRoVswEMBs60/ncEjTncm4meEK
	0aT3sRxm47zeKimgg/Nk+CM0lMcnBRwSCvNMkoV4thDCEOMop0Y46yiPUEuGTjMEG/4=
X-Gm-Gg: AY/fxX7P1WFHf+uuoiSqv75RkLF1qzAJFt0H452MRa4IYM8pGj2xeGucLNkvdjf4fo0
	WMC3LOlNHbpvHEQIWIvVCWv8I/LaHzY9LoUs7Cs2OwNG+swF/6KDVOqjQi7J4C1lETEO67l7BeX
	t75sdPXSGw8U1qGjeffzCCVhYhgMNyC3JhbFkUPkUc4zLd0oWKmnLW5sTvsihPJVMI3rheMJnT7
	knsDVGI2XOsphOY4IEY0+y8J7+EvOA2ElWmkYax0Ucx566h7DauQxP0hcO7BEEqibRngyogGKvv
	a8wSWMNZ4Gjb6wUp/uLwC7GLqbE+tJ/UVfRO3owwyD4x3AMQOo2vxMsdH9mhsrDiSnD79N6anvN
	VFEA2FvRDV6ZYDik4P17Ckl58B7woEZ5BN6S1wRgnLQ24wypKArTY/L+84dpLvHx5bO56W0IZ4u
	NZJzWUWg32tvugug39GjNgOyOecrpVbaV8xtl7w5j7BfhGROWSHPbAWvPIsd2wrCME/t9WIJ1yp
	h396DDq1B/Xgw==
X-Google-Smtp-Source: AGHT+IEiGXZhFB6p+hyp0kBExAqETtdOPekyIxm30rTftshwJqapD+Yjv5LOv9ezn7zRvtiwwyzuQw==
X-Received: by 2002:a05:6402:40c2:b0:649:9e5e:1a02 with SMTP id 4fb4d7f45d1cf-6499e5e1b24mr701731a12.18.1765526974529;
        Fri, 12 Dec 2025 00:09:34 -0800 (PST)
Received: from localhost (p200300f65f0066082ad4229ee042f7ed.dip0.t-ipconnect.de. [2003:f6:5f00:6608:2ad4:229e:e042:f7ed])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-649820516d3sm4619343a12.9.2025.12.12.00.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:09:34 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 4/4] platform/surface: Migrate to serdev specific shutdown function
Date: Fri, 12 Dec 2025 09:09:09 +0100
Message-ID:  <9682d206a1f375cd98e7dbfce4f1a83b4b345178.1765526117.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765526117.git.u.kleine-koenig@baylibre.com>
References: <cover.1765526117.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=/7sjm8Q7YGQNrr3MXB7trnzKuxp3Tl+m5P4UFgGy1vw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpO82urC2XNh4xZfCpfb1ll6eKyqXlielR0jY1R aLnqkZBVLWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTvNrgAKCRCPgPtYfRL+ TgIkB/0YvzpHr9vh2KO2NhKhX21RYsOzg/BuPVlwbm4YeXPTuzuRNI1qlRCaq9B8Kk8LfJkke81 sPGmQPf4fn9AYZuAVeTh1xv9PBeY1uLS1VvcU0e/xLzykhAXr5cPHLebUbEVhRNhLvrHIYdXGjU CxCqLGm7iQ3jo8gzhhJsrKgYShbNX6Lg49tbeVwGvxxF+VrSf/d+U+UNyyONaoyRxZ0J1OTtDzE sYUIapiIxoseIPoEhQuWDASt8VYRTdn6mvGy0tX/V65+41NDPDWVJQ1otM31xY1NGVCl/HS0K2Q hBmtun5x9MN41AeQHgPU+1Aq8zmfHuYsQbgGN/2MJ8Oa/BiB
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The motivation is stop using the callback .shutdown in
qca_serdev_driver.driver to make it possible to drop that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/platform/surface/aggregator/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index c58e1fdd1a5f..860702c4266f 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -380,9 +380,9 @@ static int ssam_serdev_setup(struct acpi_device *ssh, struct serdev_device *serd
 
 /* -- Power management. ----------------------------------------------------- */
 
-static void ssam_serial_hub_shutdown(struct device *dev)
+static void ssam_serial_hub_shutdown(struct serdev_device *serdev)
 {
-	struct ssam_controller *c = dev_get_drvdata(dev);
+	struct ssam_controller *c = dev_get_drvdata(&serdev->dev);
 	int status;
 
 	/*
@@ -834,12 +834,12 @@ MODULE_DEVICE_TABLE(of, ssam_serial_hub_of_match);
 static struct serdev_device_driver ssam_serial_hub = {
 	.probe = ssam_serial_hub_probe,
 	.remove = ssam_serial_hub_remove,
+	.shutdown = ssam_serial_hub_shutdown,
 	.driver = {
 		.name = "surface_serial_hub",
 		.acpi_match_table = ACPI_PTR(ssam_serial_hub_acpi_match),
 		.of_match_table = of_match_ptr(ssam_serial_hub_of_match),
 		.pm = &ssam_serial_hub_pm_ops,
-		.shutdown = ssam_serial_hub_shutdown,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
-- 
2.47.3

