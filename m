Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD81E500C;
	Wed,  9 Oct 2024 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517163; cv=none; b=SPJWdquP6VjC682zp84vufTesmB8AVevp27e8kkUKwo9Ot1zD6XC4hMLxz6HrX/MSBz3XNW0YoYGvvVFCvUPF0j/eGWkyJXhHtMn/qJ7RXrjlmufG3N78KPeLK4XMuVsRxF5nWtaRkbLzyv349/vUG3QiXlA7vMX/sDSw3XGGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517163; c=relaxed/simple;
	bh=SqHKUX3ni+UCyG6SrWvipnX5MBaFvPn/3CS1v1vVSuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQOyxXJ0Ekx3SllG3nkEj3S5SjQLTiQIScYwtru5oH8wGKhXzZlZooiefL1gyEffSjGA5icjGmchqbZ6IHFR2Z5V1Ok+KU0D+O2MFP0DCbVBhfzXFeIgwFyv6s1esq+8DqmOjR5ibukpqyCT3EO03jELg1Pc5m8JLs86jLJk8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luyYqsnj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luyYqsnj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b64584fd4so2863195ad.1;
        Wed, 09 Oct 2024 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728517161; x=1729121961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbJmDiU6TlWSPoOSKzFRLYQw2IfiIt/YPYRBKDoA7jk=;
        b=luyYqsnjG5awMcI/MIHZ8zkvxthKzxw60KwaDHnFN6iqj/CX3Z9aCoqa3SS/Nq/KSE
         l9yg1EgoD+PFv4tWofC2+pTh0ZT1pVy6L+UiB+rPwoQ2OCMSOMLws9XfWZG3UJw5fcr+
         9B20VkhslQNG6DM/4BEu+Ee4TEe8twhvvMYFsWfKUE3FqY0zxu0d0um1vemlRJgfVM9z
         1T6zUEitYyG9aiR0JR1BYCOZZtIWJDs+C9c0WRyfYlP+hKHwYzk996mzKlCC76woab6S
         SeIs4544ug4FD6aaMPq6WWuBH4BxTPn+NasHt4DzfXGpI761rhY93s3SNaVZec8zGdXK
         r5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728517161; x=1729121961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbJmDiU6TlWSPoOSKzFRLYQw2IfiIt/YPYRBKDoA7jk=;
        b=ih/L26mMJpKE2G/KGPh0HZo6+1XjLpGZtSByKEINsBK2Fgq/7XH3rkQ92IccvLs1C9
         jQC2PQ38D5IsXYBXt9WL7x5PwZnNDqTAd0nBOjx/g2ZkjVTRPlLb/SN92e6iksSChfu2
         itinD+gOhqXzUI8WD/OzmCCct0BU+wf6ynNEtqhp0X4GXV99Pl0/ahWETBslMEmfQ/i4
         eW29E9XkjG0SvmRJgI8xca3igXWpJo5QeZF9NmZZalldL1BcXFFdouUKJbWnyZAPRBnm
         qurGX7Kwrkrgd9speacFNkBGPBIEIRv3/+Z9qIxTb214TVkU5m/ZluUsI1oqZxvLKlkM
         RNFg==
X-Forwarded-Encrypted: i=1; AJvYcCUAx0DGdBtPJWTP8aaX0GuDzC0hG/I3mgTyTeBYeI/D3fTtf5Bu7LA2ADtMoFNAT7yU0T2c+qHRPpZK9z+/@vger.kernel.org, AJvYcCW86dCbf+whomcW0kTNe0clC/4MgfK8fvf4SaWLaKPRT/IW5XeBLCHsVv2nOSYbHLQGmmMtzkziYgA2QIj3@vger.kernel.org, AJvYcCWJ0VsVhEGAKXHcSvFPPYPw/H7T68PWjSs/8knlqBOFfsZCDh2/jmI62p6RdoaN7m5jUpwnyFt2m5qb@vger.kernel.org
X-Gm-Message-State: AOJu0YzafjuYs9erhThXSTU+UQj81v9Q/csqwK8PHXF2BJ7F0vvgqorw
	0zKtS+KbCXYGEgH1a07O/8J5Q//8Vw3NApLHlwfyHmyLUkSDDx/U
X-Google-Smtp-Source: AGHT+IEAlPWlQdhTKe4dwmryZ7XBwMKUfZUGGHcTXo9YAHd0e88UPVlFRQlqG8m8GpbXl+Jr74IIlg==
X-Received: by 2002:a17:903:185:b0:207:c38:9fd7 with SMTP id d9443c01a7336-20c7ec9fe31mr25346995ad.22.1728517161541;
        Wed, 09 Oct 2024 16:39:21 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138ced26sm75786245ad.74.2024.10.09.16.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 16:39:21 -0700 (PDT)
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
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] serial: 8250_dw: Add Sophgo SG2044 quirk
Date: Thu, 10 Oct 2024 07:39:06 +0800
Message-ID: <20241009233908.153188-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241009233908.153188-1-inochiama@gmail.com>
References: <20241009233908.153188-1-inochiama@gmail.com>
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
 drivers/tty/serial/8250/8250_dw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ab9e7f204260..6b7c75670f29 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -750,6 +750,11 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
 	.quirks = DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
 };
 
+static const struct dw8250_platform_data dw8250_sophgo_sg2044_data = {
+	.usr_reg = DW_UART_USR,
+	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
+};
+
 static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
 	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
@@ -760,6 +765,7 @@ static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
+	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_sophgo_sg2044_data },
 	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
 	{ /* Sentinel */ }
 };
-- 
2.47.0

