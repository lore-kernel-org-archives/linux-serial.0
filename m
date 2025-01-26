Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149C41EB3E;
	Sun, 26 Jan 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737909084; cv=none; b=LJ2SC65Vt2gK8h+l3Eot4CT2Vo+6c7I8u3pfkxcMCX2vBo4iNBLRQo6Ops+mIq9c4D58LpiAOECp8Gv6oJ02Zi6eL9b0t3WBSgp6ivJB6vW2Gl9Hd1tRvVU+Z8qSphT8rxZA5ZbeS+E/GbYmfyen0uUZz4fbAjbvu2XCAvcC06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737909084; c=relaxed/simple;
	bh=MmTk6CY7WX68WYwDcDkCtlPBYbvomNE3g2PxiPazUjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFR5G47Po5R0okk5j7djKiAlUulnYQrBAR/xdn5kcPHkS3imr5vhiCNETTI/B0HDM4o/QEpMkZzoz2aGbR+k33ShvVQ0UqOuTOsFtU9Lva3NGjHw8A/Lk3QNWSnnA3BE0MtIuTDRXYvq5tAjgAmYvB/i5QMZBVk0VKL4T/54hAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cmz/2p2e; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmz/2p2e"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef748105deso4849727a91.1;
        Sun, 26 Jan 2025 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737909082; x=1738513882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8SLVKoIqe4dHDzRpVZsy69EI97LlWER9HLoF3/I+daY=;
        b=Cmz/2p2eO2cOS7sUfK5GGWtx+XSK6oiP94sDkH79ZA/mxe1MImap00jM5SmkHKMYF2
         Q9tyGdT4yqxkle+/IfCDwsPFsBXAun5RcR1NAVLAlhi1YyL91wBmFQImXFz8sq4hszGm
         tsgNWnkdrmEGJkd7cqg94+6unxIYFV99MDUkFjMG/6eQ0MSFRjFvOa38A5JyMQM9HNFV
         EE4H9Sm08HNY4lzn58PV/6y+fqYKyZ/kkLSN/mWvg16mEc/m/QEe4IK2ZxZSiImKrjJI
         gh6/McaPwern24mzP6wfTjaSSfENcDpG5dYzR3DBuOfTefNtgzQrc5AEqBSspj9Qsfw5
         CsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737909082; x=1738513882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SLVKoIqe4dHDzRpVZsy69EI97LlWER9HLoF3/I+daY=;
        b=sOaLh/984SXWXMUn9IOq3LidsfZ/O4AcmIIBSOG/ORc3nDynKvPq3Wt7nIvwEuWjgc
         eyDAHqvj+Qc6svP+alAh6lHsItt4GaLnid7reC1qgQt4VfvgpCOVCHoBnx7hK+7rPsPx
         Hom/OzgOb4Hg1vdYGVGGiSkqvL2UZfArqDoRq52xOMYBdrmeMc+SH6oS86KkaPeHPJpt
         /NhKtBrDPOsZ2uqWFwH3pTzc2DwAUWEbfZDxFNWAFJtL/ve+Ya+ubNFX0uUqDASwE+ZY
         2fSvcXkRvNiBsX7cImT7NqplC31jwH/hNNph2GD0h96soWDJshBafLZxWeONRp0x6QQP
         kDcg==
X-Forwarded-Encrypted: i=1; AJvYcCWEhXCHWkpq+xxA0f/cZfSyXzO5MTEHPYfGgmbp/QBn5eito76f905FbNzXkXQoLNFEHgAFZTq2RozpOf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0izDyhLQqUUJ66CEawHkGp0yuD7xnc1dNt3IqlPwqi8ewADym
	U3FeR1lRo/vVluaICab8KcTHF5BX1CamrApgGTR+D7mh4wt88hru
X-Gm-Gg: ASbGncuPxDVSutNABr427W8lYg20iuqP7vU6v0ZKKO6c8mqRUa0kAWUewL7lfpnoC2P
	aupf7l2Kkj/UOeZ+PLjFxDXsNs+NpxMQm1GXzgvMq6UgVudRPMMv3cDt0ShuXlrZzZ1/FeNRXL7
	+WC5KXS9mojTmR2gWf+lnOZTBFo1RIe6aMT3QtbULVDDOudjE0JDYFCJqRQkThzm/u+cWDEg+fc
	bvWBGQs37g4UhK0C85h2sGfZjdmeHJaCZQPiXqmvlabbbTei9WKAJDNCyk7MpApPPA/EAaACWx+
	3uo+JUYvkw==
X-Google-Smtp-Source: AGHT+IHoU+HfW+j+JtXzjuKdopEjzhbQrDj4eZj5Hb8Dq3Uwzmlh7q5x1JD6m3o3TMMSuTkVvTntJA==
X-Received: by 2002:a17:90b:1909:b0:2f8:b2c:5ef3 with SMTP id 98e67ed59e1d1-2f80b2c609fmr9989183a91.14.1737909082242;
        Sun, 26 Jan 2025 08:31:22 -0800 (PST)
Received: from eleanor-wkdl.. ([140.116.96.205])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e45f7263sm6366343a91.2.2025.01.26.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 08:31:21 -0800 (PST)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] serial: pic32: Fix build warning when CONFIG_OF is disabled
Date: Mon, 27 Jan 2025 00:31:15 +0800
Message-ID: <20250126163115.3200308-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by the kernel test robot, the following warning occurs:

>> drivers/tty/serial/pic32_uart.c:904:34: warning: 'pic32_serial_dt_ids' defined but not used [-Wunused-const-variable=]
     904 | static const struct of_device_id pic32_serial_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~

The 'pic32_serial_dt_ids' array is only used when CONFIG_OF is enabled.
Wrapping its definition and 'MODULE_DEVICE_TABLE' in '#ifdef CONFIG_OF'
prevents a compiler warning when OF is disabled.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501260006.ecUsBidz-lkp@intel.com/
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 drivers/tty/serial/pic32_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 14d50bd7f1bd..a228a55102c6 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -948,11 +948,13 @@ static void pic32_uart_remove(struct platform_device *pdev)
 	pic32_sports[sport->idx] = NULL;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id pic32_serial_dt_ids[] = {
 	{ .compatible = "microchip,pic32mzda-uart" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, pic32_serial_dt_ids);
+#endif
 
 static struct platform_driver pic32_uart_platform_driver = {
 	.probe		= pic32_uart_probe,
-- 
2.43.0

