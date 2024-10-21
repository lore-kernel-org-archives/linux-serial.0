Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B141DD861;
	Mon, 21 Oct 2024 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495613; cv=none; b=p/MzLN10fvVvS9klifK99+c8LQS7VifGEBcabd6uiaqe8blz/YRQAsmmFFY/gQdcKKBsheTGxu2vRPTYUPWKwXuzphZxtWHDsV+B0+2OG0eKS3Are4ji9Ffxj0jPvznB4+nhnHdO6j7timJTMGsdb0RRynzOuoXKttm1IrA4OJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495613; c=relaxed/simple;
	bh=PzJNTdYSs0OAVQ8efdZZ/OKBDTgmDH8V79AciwReyus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5WSBZy0reZ1JdzZEBPO47YiSMNmr77IUQv2F9CDNVYIGig1o8sHgy1ubSnFCF+0/VmP7kNnpRtx/rsqybf5gtMqRPPU8KZ6WVf7CLxWiow86Qup4i49GXq+VBEDGGPiS5HQ7SId2lBNtsPLRkzIC8DkOjjMTFW/rzLpSi1TNtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdrZ2IPH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdrZ2IPH"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cb7139d9dso36462415ad.1;
        Mon, 21 Oct 2024 00:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729495611; x=1730100411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXvcCpfsJOPp154vFwKXQKRadddvDYDxZELGpa9JLd4=;
        b=AdrZ2IPHUWFAyDVf1QlXrMjygLInrrfBspJQ/uc0NP9ZM46qn2GKqhwMaNa/hqPU2l
         j0px/H773Nx5ILORvL1im4Wo85g4O5W4V+YvNhhhqHxFnTNL7kMgFQp52OYlCYxVYJUJ
         sz223zr/ytIO6fvboktqhd0WLC0JPcHU9plulQFi1mW7xOmSnJlgWWMeWER72bvgYN1L
         S82IqAYD/gQS0h2Yeo6SYds6OAt9LrgjEzDcmY1Sid4STTy/wFL2bhJdCtOVt1f7GYbU
         d9y+cwt14rQltVu/naV29e/PvzxOKCIvrWV7QH6IxyY+++P0yXEcT0eYLUIrB8Q/mN9d
         Un5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495611; x=1730100411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXvcCpfsJOPp154vFwKXQKRadddvDYDxZELGpa9JLd4=;
        b=KWJPRmBcYypfAAU8VKRPB1wg55t7nQXQrWUd1vha0MjriAqz7JxNN3RdvoSByJcCTh
         2j20ryuNoliS7E8rz3Lsi9DID7DSwyqd7vhK2wYBaih2SVsxj5SLXMjhVShYPhU6o8UP
         mdu5diPC6C48NB52Y8mhuUegJjmca4+3XwlyG3uS0oJVNi1cfI4l6o2MAjAsvodZCR2+
         5vfOAw6XbIS4Xp6qMCd7BCaU+npiuk0MjmyYBIem57LxWtUqPC7tn5RVd8M1Hs+1/r+v
         NLPmZOxo/aRFPNkWm3VPcPius4Uy9ZDKAmpEd7Empt3z96YgNQRCklWc0culbBSjrHqa
         +nPw==
X-Forwarded-Encrypted: i=1; AJvYcCVG6lDDTOd2lSUdfLO7ovyO0GlOER8OxWsUn+8eL96K80sh9pO2b2QKyNtTsijWBCHcehScVYSFd01KvGgS@vger.kernel.org, AJvYcCVzxjsp7hquYWFFDXMea8Z9nM5lbVaThf07bGEQ/k32N8sn3VnYInsOAkjB8e4zMbtLeuNIiMt+WOgP@vger.kernel.org, AJvYcCXq2YMYkPQoiXeh3iVQrfTmGQIGSwlUKL2uHI3ghC8YXEaRYfJYC2RJ2jQelOoLeRLZrsJz5Ejybh6mBA0Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxCOnPe/iT5gjRf3ip93gwPvLqr5W1u/UgvbZ1gYI+W6dArYVsE
	Ihk7cIrT5xTSJFxYCSKdk9T05nlOuHkf+xcTyuDS63uIqS0Lxael
X-Google-Smtp-Source: AGHT+IEsGe+lBz2zwyzbRMjnO083MGG92UylU4sVnq+SoC37wyN6vFExnIVCz0Vn/kD0D2CooUtaXQ==
X-Received: by 2002:a17:902:db04:b0:20e:5997:c107 with SMTP id d9443c01a7336-20e5a8fb320mr151344175ad.39.1729495610968;
        Mon, 21 Oct 2024 00:26:50 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee884dsm19919975ad.9.2024.10.21.00.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:26:50 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/2] serial: 8250_dw: Add Sophgo SG2044 quirk
Date: Mon, 21 Oct 2024 15:26:06 +0800
Message-ID: <20241021072606.585878-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021072606.585878-1-inochiama@gmail.com>
References: <20241021072606.585878-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SG2044 relys on an internal divisor when calculating bitrate, which
means a wrong clock for the most common bitrates. So add a quirk for
this uart device to skip the set rate call and only relys on the
internal UART divisor.

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

