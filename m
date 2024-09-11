Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0367DA68;
	Wed, 11 Sep 2024 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031308; cv=none; b=LXmnsJ1tPlUxsTYud2aKfjjV8tmVF1i3X39CpnrNHGIZ+3fWPnQZj1+BHjQMIUxaKcABUPK6uw71/4XJtV49rqXc1owyoBE31mJBJk9POivBbDCb4sqDcoZqMixW/4FN+Yu9cnOi9jpot7XDnE0rIwfa5pco3OjLwsJrehPgV44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031308; c=relaxed/simple;
	bh=vz7Fc6/D6FdYhQGU0yeXVF4Yg4bvyRPDYA9zka6qPpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O03tRLZfSE060xOFN8ezMQ8kW0UkfIRhNZ3T8PusoR/cB6BlyW9oQznAKuRLgnmGRMyyGfgWv/gxq7bdYG9YlL15O8mPhfti4K1HsobaFRtAjIsTg8E/NnNGPBKOKYinmWAbDmR6YeMl1OBjy2FQKYqBtvVp9F2SQjbMG6wlpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKB5dek4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKB5dek4"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71788bfe60eso1132251b3a.1;
        Tue, 10 Sep 2024 22:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726031307; x=1726636107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNdPAQz6FCH+x9os16nRs546qMZHgKNAK/Ypn6mSlDo=;
        b=eKB5dek4F+A8YENvL9y0l3DVM2bpf+SwbxttKoCrT5n0NXunnH2nJj3JyerKebuMw7
         vUQd8sMLTAYc14vVClaOweClGqXerxMYh6vkUreRjlcms0+bTVwjCPWwN2HOA+it9PRR
         RorR8TmtL3Afu8QEIq+/oRIIdlmTnANzNBg5wXm23ApgS8J6o22aH5gm07dbZ8QZh/qB
         vLiSXm06gWe4lRkbD6G5btGwhAYysB1yyrNGGZYcVwGRIaAAfL80KLLvwzM0o9e3N3lT
         9NRvHkjCkoP0+S9pugP/j8GGgzjujnKPGPdUm4m4byZh31U8c+upzHBOTsc3dx7+YiMZ
         V6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726031307; x=1726636107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNdPAQz6FCH+x9os16nRs546qMZHgKNAK/Ypn6mSlDo=;
        b=mEnJlZe42zMLUC1AbECh+Zcr/oj8P5u91+/IacOJN4Q0eRkT1ljRE+Zler146P7cbv
         wItEs+Cnoj0r7Im3J3l+OIflDriaMXIhLlrRcHyl8khoN8ElGs5kEiGwsV45S+ghkUOj
         AD+djYpHecMKnj4wXZbMmlZ0PyRLSARSCoA+kRCAoOpyFWv8Li+noJtrhGJyo1qNxhha
         RNOOfl62hPOPM8FCCMYSYR/sw0hmdY7iFSqpvLnIZbdqAx31ADb96UFzA+59cCYxhv5G
         NAn1WICImaZuQmEWHcwN4v35QJ13I2rb5iQaJ9HM7uQQUWcdPgXyT1UUYm2KwgZcfssH
         ofQg==
X-Forwarded-Encrypted: i=1; AJvYcCU+n1e9llMMDy2FosxZBPexj+ob0w+mRbdltjhNNdkUnjYXlm/q9Cri6+wTBX3AQubXZB64zJpbQUiaIn8=@vger.kernel.org, AJvYcCUZZSebQbPUWRF5l8UzPb4SMJlzulaSJ3TKLQxpBSEh4ZX2ZkVwfPdLX0KTkYW+AFDeKVVspiNR29uxZKPc@vger.kernel.org, AJvYcCW2CkQNgL4gCXQ6jVeT7xFxZNLYTVkYjTnyppYBt4sa2uS2j2W6Q9z2Iw1ygZvilkeVwa/NSBTE18RKqqLJeIr9qP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvv9iabK2IEtYxMPg5ktG5i4UL+upx7gxbN3vTwV+0U5yFjviP
	RVw/e3hsaYtpsGlXjQ7yq9y92O6yP3K1SwSw4g2Zb/VLZuUY/lpm
X-Google-Smtp-Source: AGHT+IGAjwPVwpMs2Tlzc+fCn6t25k5zV5S+6h2An1CKJfS27fXosKBLTBlxWiJ1EXeZU/4reI1Esg==
X-Received: by 2002:a05:6a00:66e1:b0:714:340c:b9ee with SMTP id d2e1a72fcca58-71916e193b1mr2217489b3a.1.1726031306631;
        Tue, 10 Sep 2024 22:08:26 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-719090d11e6sm2156984b3a.205.2024.09.10.22.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 22:08:26 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: asahi@lists.linux.dev,
	Nick Chan <towinchenmi@gmail.com>,
	Neal Gompa <neal@gompa.dev>,
	Janne Grunau <j@jannau.net>
Subject: [PATCH v5 2/3] tty: serial: samsung: Fix A7-A11 serial earlycon SError
Date: Wed, 11 Sep 2024 13:02:12 +0800
Message-ID: <20240911050741.14477-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911050741.14477-1-towinchenmi@gmail.com>
References: <20240911050741.14477-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apple's earlier SoCs, like A7-A11, requires 32-bit writes for the serial
port. Otherwise, a SError happens when writing to UTXH (+0x20). This only
manifested in earlycon as reg-io-width in the device tree is consulted
for normal serial writes.

Change the iotype of the port to UPIO_MEM32, to allow the serial port to
function on A7-A11 SoCs. This change does not appear to affect Apple M1 and
above.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Tested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/tty/serial/samsung_tty.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index c4f2ac9518aa..3fdec06322ac 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2536,7 +2536,7 @@ static const struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 		.name		= "Apple S5L UART",
 		.type		= TYPE_APPLE_S5L,
 		.port_type	= PORT_8250,
-		.iotype		= UPIO_MEM,
+		.iotype		= UPIO_MEM32,
 		.fifosize	= 16,
 		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
@@ -2822,6 +2822,9 @@ OF_EARLYCON_DECLARE(gs101, "google,gs101-uart", gs101_early_console_setup);
 static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
 						const char *opt)
 {
+	/* Apple A7-A11 requires MMIO32 register accesses. */
+	device->port.iotype = UPIO_MEM32;
+
 	/* Close enough to S3C2410 for earlycon... */
 	device->port.private_data = &s3c2410_early_console_data;
 
-- 
2.46.0

