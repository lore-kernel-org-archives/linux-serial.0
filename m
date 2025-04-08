Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093E23E327
	for <linux-serial@vger.kernel.org>; Tue,  8 Apr 2025 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134716; cv=none; b=AvAUH2h1unl1ewoYMDrTpVBQTnBWwqryLaAg7ZBHT2ZscgGTd9ogznD2B/ve0GFFkpw6oP+yaUPerncxJZPT7pqhDDS3PUN6MEeTVpKlhf9Xg3mUvy8Ss+ffUrcut3K+XXz2lwfCOpD5OW7I73QZ/GPE7ZJtE5JBD/758cj+Cho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134716; c=relaxed/simple;
	bh=/sY8VZRyDUN73aeYaxmj2iwLb/0UKlQo0GxMqEzF4N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gK8emw/nCCUEMRsgWP9boMxrNAs/6rqVO7seK1GiZhITils6CXjJ6eqAAtbttGhZoThORHRe4cjVrWzl8soc21AHVjI4fk3OqQm2mHJPv3OBTGmpSD9sL0c1PHOaWiyDQSkCINdLu+TfPDl/A9+1vfF0G1Vg9onYQRjVQdnS8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=tKaZUpN2; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="tKaZUpN2"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85da5a3667bso143174339f.1
        for <linux-serial@vger.kernel.org>; Tue, 08 Apr 2025 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744134712; x=1744739512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yOB0UUwMV+WIYBnQK7bXplxqRapyFX4EtLHZKV6hlY=;
        b=tKaZUpN2WAtn7gcYVg2bsR3D4kgLXPzUbCnn6ulJzIaNC95y9gmd8vb3Pwhe3q4/hH
         zIaD3WC0KqPnhV7R1uHx/lO0EqMMuBJEC1Or2OH64EXXa777S+ou+qVryRlWciPYVE4v
         hHuIKYh6GncizFka3Md7tOIIT3j9SqYpFUas+klrsoCKa/kv48Vu3yVj5cWiYFc/X+3v
         50v0XCMEA8m+YviBH8Dco/BaT2NF8jGVWRNPeqsGkY+1YMSSLIxqrP+gEld1FTlt2OkX
         8DZS5Z5FJbgEnYq5IC43KBjOtTEVeMdwh0Cb/R0o3i5HX+f/8yHKvkTmI/weE2/x2Frc
         QE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744134712; x=1744739512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yOB0UUwMV+WIYBnQK7bXplxqRapyFX4EtLHZKV6hlY=;
        b=YSc7VStu9f6OxPoNvKHBWQbMVRFnlkUz/ZFvoP8CoI3Y4l0dX5WQFZiVg+dtRzZLZ9
         e8lcoEdlcMyn1YWAwVGzVmYO3RAmzI4QJHosiii49TKUplFrTYjjsp3hlSwtcdJA7tXo
         6t0WFmcVc9tAL0XNcXBxsJEQAWHPemdJGDUiy6rKRTvbG9lEWgTMa7582FjzIU6i2MMy
         bPyZS4wXUGqJXtVRXpPl8QietkW7Sj/IFGz2bnqST7deSZ1f9YiV8S4weEisijGUa/MT
         aFxgNfvZphmPTYBximSgnN1ATL1NKMtzYzGCwoc3PtAreVoUsKTBHjoH/ZqqXHZvg4U/
         y1uA==
X-Forwarded-Encrypted: i=1; AJvYcCWjomkksabstHU7wTtifo7DGASGw/L8KJ0kuIrIgAVpEPJGlzbNOqOAOLXDflSJM1NVYTAlbASEZA23XBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSMx6m1OiuWp6IU7UXgQaDOVXrFJSolD1ncWq7Ea06eeFrXv6q
	0uVIHqD8NPY897SqMHC16lvzRSqWhjkd/6BuRbjd8gaxkCPk9iUla16eHqZe95M=
X-Gm-Gg: ASbGncsCT2HdZ7aQxt8JzlyRNWksszuftQnJGVfKrnANPa+8jAWl8ILR46isx7RtB9c
	ZTLGv9np8U1hel+qQpmlH/7y+5Rz7YEdnW4Mgf3UwhvjPlVxxTekJan1yr2SbRo6Y9tKB+otftW
	EUDvslNhUeOQ4kF1i2WyrEpH+64/PZl9He7N0bz0XyIc7Yy2F7AiFiOvMnxIQ+L3MCs+liIAz7J
	jlLR9vJDd0yxMSAWV7VihUXy+p3Qkt7T3c3Z3fQobyLZt2FCMC6tisWul5yLsCbFIRUI1H7VYNk
	QCkjHx7OwEfEMCwVZozeHg5RIX6TdQW9Bo/zIIUY7w4J9v+odCRDXUfX0xt8fsUDL2Jw7++mjUw
	LUgFMD/vM9e4Xa6CF+w==
X-Google-Smtp-Source: AGHT+IErYWFsepnZwUj7tm3UyMRvkOvbJ++wpmDSS1joM6vrWPeUFpUG7aRoEZk+WZVtDpCIid6RQg==
X-Received: by 2002:a05:6602:36c3:b0:85e:8c26:8e2d with SMTP id ca18e2360f4ac-861611a5b6amr10144839f.4.1744134712022;
        Tue, 08 Apr 2025 10:51:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44e26fcsm595914173.120.2025.04.08.10.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:51:51 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: benjamin.larsson@genexis.eu,
	bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] serial: 8250_of: add support for an optional bus clock
Date: Tue,  8 Apr 2025 12:51:43 -0500
Message-ID: <20250408175146.979557-3-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250408175146.979557-1-elder@riscstar.com>
References: <20250408175146.979557-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT UART requires a bus clock to be enabled, in addition to
it's "normal" core clock.  Look up the core clock by name, and if
that's found, look up the bus clock.  If named clocks are used, both
are required.

Supplying a bus clock is optional.  If no bus clock is needed, the clocks
aren't named and we only look up the first clock.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/tty/serial/8250/8250_of.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 11c860ea80f60..0ffb9f2727b92 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -24,6 +24,7 @@
 
 struct of_serial_info {
 	struct clk *clk;
+	struct clk *bus_clk;
 	struct reset_control *rst;
 	int type;
 	int line;
@@ -123,14 +124,34 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	/* Get clk rate through clk driver if present */
 	if (!port->uartclk) {
-		info->clk = devm_clk_get_enabled(dev, NULL);
+		info->clk = devm_clk_get_optional_enabled(dev, "core");
 		if (IS_ERR(info->clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
+			ret = dev_err_probe(dev, PTR_ERR(info->clk),
+					    "failed to get core clock\n");
 			goto err_pmruntime;
 		}
 
+		/* If we got the core clock, look for a bus clock */
+		if (info->clk) {
+			info->bus_clk = devm_clk_get_enabled(dev, "bus");
+			if (IS_ERR(info->bus_clk)) {
+				ret = dev_err_probe(dev, PTR_ERR(info->bus_clk),
+					    "failed to get bus clock\n");
+				goto err_pmruntime;
+			}
+		} else {
+			/* Fall back to getting the one unnamed clock */
+			info->clk = devm_clk_get_enabled(dev, NULL);
+			if (IS_ERR(info->clk)) {
+				ret = dev_err_probe(dev, PTR_ERR(info->clk),
+						"failed to get clock\n");
+				goto err_pmruntime;
+			}
+		}
+
 		port->uartclk = clk_get_rate(info->clk);
 	}
+
 	/* If current-speed was set, then try not to change it. */
 	if (of_property_read_u32(np, "current-speed", &spd) == 0)
 		port->custom_divisor = port->uartclk / (16 * spd);
-- 
2.45.2

