Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F62189F37;
	Thu, 24 Oct 2024 06:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750899; cv=none; b=TdSaqZoQiqPCcLFUR+hF5wtTKzkSMSGYZwXLT8iMHuiKhrcCuxewSDXTXDPoLovuGYG6cpyQcGIpIG/qoQhPiNSeaMlzuPQ34vZe8YWfAJVV/apNdhjZ1T5VXOUS97xymZEdkDUncWyLzIVjSBNLgo4cgluZC/mYUa+HEBL12ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750899; c=relaxed/simple;
	bh=iI5nkQmFPNTVCq3WuwaTAlHfF2QU05Bf836KcWoKuQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTIO9LKAPY/pexr1WqfD2/eUaec+uDDlCY5X8I/jFkgSdctcNPJMb0i/lCcUe3BOI943CsWzT5p3r5GEOO0m4fD5O49aLA0O9BXt8zkVjsIpNChHRcyNxRwcbTFTLjT+hsT/L3OHFrxDhuGKKJkQ2MB2LhBNWaErvAwW3EOmlGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnDxLW8B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnDxLW8B"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso3782175ad.2;
        Wed, 23 Oct 2024 23:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729750897; x=1730355697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfpDaZql27AGccBviF4LbpW7kCn39h7ydAfyImxmDQI=;
        b=YnDxLW8BHZUevJj+TMfsH4u97S8XgoWJDfBGYjjuw1giVqF70mKCBn3DChQQjZiHuU
         WtnSJXd/gV1X8S4jS7VprQ3oEDFE0fxGTCpgwqHCV0yF/m5qtKGwfTYNZpunss0bZ/Sp
         UniVoW7V5VFh05QRhfaIeHK22XTwHDjZWUJ5ZPp+Hzsu3t9OG9QkGYVux2vGkIb7SJJd
         W8YP0jak1lzCUuNXctnOFnc3MCwnHNd92T8hpDfnpfunGGemMmIHM0EgCRbH/rJwe8Gh
         fnaralQfpthJ0hESi8qCz0QjiiZwKqJkrfonJl6MKD9NF9OyIVq75+8cEvaSrWD5F1Pt
         crKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750897; x=1730355697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfpDaZql27AGccBviF4LbpW7kCn39h7ydAfyImxmDQI=;
        b=ayFxeBAkBw1h3dbl1M2I3GGsrr1m0Cq5JQvYQOyyyh2oZVWmyFJzwRyOrCfdqPjtiM
         sIOcbuxvHpPdRotGLpiXOjfcCE/2QyQhH2Qqqe+zYH/lzknKjGrDkPik/4ExILxbDYgM
         q0s6qJhxaW0+pLhd1o5/TFtMKTvzY+Ps2A1h8hTKIQ4vOZEfFTlSDI6hycB7KHb+bSIe
         pe92eWwEhnZw2fot3A54bZMB03xg7tzEzRjQrPRD0EGQ8WlQ6x61dnW05QyxjqROh/5r
         uJXXnv3UnY6XnVuqDrI5E0CbmWP1IRAfG9oYPpF3LRhamuhBXLarN/uyuj11bgvK1vQg
         PGUA==
X-Forwarded-Encrypted: i=1; AJvYcCUs0E+keMznSXx0wdGvyipAB2t8pTD5y2oTRX16NqoOBR1syEOFmL0RCg1T7AngWpuLhXtw2p1U5rLH@vger.kernel.org, AJvYcCUu+Wf3Ug0hQCyGHDvbbqxvWhkagu9wLItmmH1awjyRQjsOq+boT2+lhnbnvGUy8PIxUTmM05w4+QZpJEIO@vger.kernel.org, AJvYcCWdgsWBMIJ1d9kLzxmvd58Y6YzFxvgltJEN8uIK3I1mRbmKgHju/4FLGb6/hzTkCYQmGIiTyMYWhk/AKljU@vger.kernel.org
X-Gm-Message-State: AOJu0YwRwSD75aGH4NT/rHoAMXzIuole9S4CvefVha/w42HLlYDREXgg
	KZWnNstG7I59ttCYZ0NPsLAVmt1wwo95bQCJTaYtfqJFkU+kWRoO
X-Google-Smtp-Source: AGHT+IFEe0LJdyPOojWfTtduNmBAsBkACEzCV6t1zhevClnHjv0KDVQE2gwzvxTNQR7OwKc2ylsvtg==
X-Received: by 2002:a17:902:f54d:b0:20c:e65c:8c6c with SMTP id d9443c01a7336-20fb994ce6cmr7222015ad.19.1729750896687;
        Wed, 23 Oct 2024 23:21:36 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd480sm66219025ad.130.2024.10.23.23.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 23:21:36 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] serial: 8250_dw: Add Sophgo SG2044 quirk
Date: Thu, 24 Oct 2024 14:21:03 +0800
Message-ID: <20241024062105.782330-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024062105.782330-1-inochiama@gmail.com>
References: <20241024062105.782330-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SG2044 relys on an internal divisor when calculating bitrate, which
means a wrong clock for the most common bitrates. So add a quirk for
this uart device to skip the set rate call and only relys on the
internal UART divisor.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ab9e7f204260..51894c93c8a3 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -750,7 +750,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
 	.quirks = DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
 };
 
-static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
+static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
 	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
 };
@@ -760,7 +760,8 @@ static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
-	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
+	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
+	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dw8250_of_match);
-- 
2.47.0

