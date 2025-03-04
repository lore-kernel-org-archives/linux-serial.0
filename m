Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0B18CBF2;
	Tue,  4 Mar 2025 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071764; cv=none; b=MNKdSHKbFOW/KwAqV0jfWAYY/2NP/ZhYSLZaQXriuqxWELXvpjsTs9jn5xmlzNZLSsmBb1+SEqovkdvox+Mc/SLgeBtAlW7ZvxkAq+P0M8b/bD7/wMRXz0WgMHN3TVT7F28xVmE+JO0HbqbE8C72qqGbJ9uAf7UvxKR6kNA3lFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071764; c=relaxed/simple;
	bh=bys9O0VcWA/Cebo+b4M8fexbIivFWzepcQOhdvMlll0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1Eng3QjOpDB1nX17LFpefnG8W9MPEJ9Se+LX87gY6WT+O8YrV5oIG3u11HIxvzvaRdMbDJxdBCRHP5q3syr/648aMJEBuIgtBFn6v3ueaJ2yWgOXr6bB2xm/sPhtmKUZegbgcG3wuwW7DmUAT7DK0a2SpUnxIiWKXGFvQWwcMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw2edoNH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw2edoNH"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0818add57so565700385a.3;
        Mon, 03 Mar 2025 23:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741071761; x=1741676561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbTcNkNHFzitY1YfkyytQj+zLC+mpMRQYQZjO6RgWnw=;
        b=Vw2edoNH5joaUfeKUNsP8sZN6k5pen7EpOq7LxL0SHFSVDcizec1MDDYcBUa4C/Xbg
         ohCf8WLJ0qvgPu/wXWaxTVhT3/3v/vxH8kYiw6Mm8BIffiLS6VBYO+F2rH3nGCUoKd+i
         lk7yH5hRu7ypzkqUyE5LwB4Pt1W3Z0+qaxGQVWclXGeTPpGX5cVU92rEZVutAQXTFdCv
         gr7ukd8QVytFRTAEIAFjZn5ZP9mJJ6ocZ5PQXT1OyyvKWF3CaWArnKHsZHKj2OeY2uk8
         oTkSDf0rpr+Nf6Yepy1K59/bx6ppzzPWiuzFYcE1NYY4qeFcPVOx2q+pnu72TfeszVF0
         N5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741071761; x=1741676561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbTcNkNHFzitY1YfkyytQj+zLC+mpMRQYQZjO6RgWnw=;
        b=EPbWC0FKHIC0tk10UZeqqifXTr5/ralKEixll0AqAh+D9r5E8EV6h5e24uDbE0nLLp
         CpoHGCfbNQBnsy5mSiTOtw5NNtPwIrtuf9wbfs8Ly3sKJUGpGBApbz3pMKvuhJ6VJaNh
         pFh5S8U1XRFC2tSUKB7Xj50xVbsxdq40t2fq5obb3bPXLTVnz1Dgw0MILN42qRiwNqWn
         HEDtG9YBzWMwfcZ1P1KMb+hVrV34+zr0Aaor3Pt0kw6u297ju6lBDZq1+jMYC8khWopb
         UHKFSglDzWTOT+rvw952HS3KGJEN9T43e/ri3o6OdPq4cUoF+opSdD7iif2+z+TRv1qB
         5/jA==
X-Forwarded-Encrypted: i=1; AJvYcCV8aoezgdtU0YkR5nuBSnxGD4RhFM6KK6LA9iQhE0ZgsDesaTT5BWvhkL0iMDcQylPRbUBlxjgxfsb1VAY=@vger.kernel.org, AJvYcCXxc5vLPa3neaNtymdM2RHsMEVzC7ZMeAzXLfzcAZOcGwNPaWpEnUK3uMprMiAWeXRcK2JCvhCcmK1diSp5@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVY3z/Q5P30mdN155iQF0EwAnlR1hbWwJonDAQ5NSj0mY4E05
	C7M0fp4jtTGZqknKnnxWq5Ew4ysjD4dwYTTSG66FyDoa8y80iKWQ
X-Gm-Gg: ASbGncuP//MR5nL2kDtTn21aJs5OeQJSMNrFsUmImeRq16/DKDM4MGv9BZwWfjVgqNJ
	NDj8uZygCtLc6dRA+Fm6rYMo96rKwtqsT7s5Jrk1J5Lz7QYy2WzyS8fIF2+U3WcFEMZ7MXMCCz5
	tviBvOWN7yjQk0nOHInnt7ofvZOIdsVa6uOjnXBv/tbaIRo7bpeZTEunyTZz+HgCgdbfPNnRj3H
	NlF8B11z+JiLAl9+27GBdzbUtkAK6PrrR7MK9ew6Moppw/C3CtNCnrGGf6RrwSpiybL76WnahgT
	8DAEtgpS8FC08nS4AqX0
X-Google-Smtp-Source: AGHT+IE09fMY4omeejvfEyxnEULpk+om4jmV6tCwrtaHykdqplRbip0TOEPcAVW+dipju2pX2FiV0A==
X-Received: by 2002:ad4:5f08:0:b0:6e6:6699:7e58 with SMTP id 6a1803df08f44-6e8a0c88f49mr216896046d6.1.1741071761619;
        Mon, 03 Mar 2025 23:02:41 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8976cc819sm63177146d6.86.2025.03.03.23.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:02:41 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] serial: 8250_dw: Add ACPI ID for Sophgo SG2044 UART
Date: Tue,  4 Mar 2025 15:02:09 +0800
Message-ID: <20250304070212.350155-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UART on Sophgo SG2044 can be enumerated via ACPI.
Add ACPI ID for it.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 6afcf27db3b8..031ca1a7155b 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -785,6 +785,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INTC10EE", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "SOPH0002", (kernel_ulong_t)&dw8250_skip_set_rate_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
2.48.1

