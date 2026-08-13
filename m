Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2E3EA66;
	Thu, 13 Aug 2026 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646333; cv=none; b=hvqLsA/sqSxtQ/brAXW8Xr3K1g23+XagdQC+NGjVtdXAqhuzQYawsIzjjIoDCHljVGt7MqUt0M5PXttIkH601Gpi2XgcsCUaryZjEUG6KxJHKw1GZi6cSg6XufX0HWrODEmauRnIQkOCF/7dZSmFiTvWYoSJoV7qpNqsunrryhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646333; c=relaxed/simple;
	bh=9mJaxGbz8SEtvlx2N4Fd85iYrFUMZ8aT9RjHqj/TvBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kQt3XWh4OzSjvCuSxLSslaKqMIEuEKCXDG+EWe+bccdSai4yRju+ZmpTzGFS3sE3fceWTHBKLFOCmm+vAJojPvco/t9pCOfMbrgAovAJZXGLW/11/O2hZhHj7K4aBys+GaGH3usN1oT3pidcuijrsqPLmpO/LrfGXrlZG75pHp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=J3xHLmsv; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="J3xHLmsv"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hLYzC566NzKrtJ;
	Thu, 13 Aug 2026 20:38:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1786646328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SRk/PQ/Cve5njj2W2D90/QdHFpg2KLeYNNFprJwYRVU=;
	b=J3xHLmsvG5i64x/lttwf7UpPaW7Q3C/NVo7gOawrmvBsP7Gz9aAzkvfnXzQ5WdysMEQwtR
	Yj78Vs1ZdOoDFKsoc6UikiG+crtNDCf586zfQN7d96hHruK52a2b4m0LGI69J/9og+qeYj
	UmJpESZ2jfCA2rBzoyk1oSfaZUDNLzXXWH2MbT6N4VAvz1AgK7AJ71LU9ubiQblZbRXN2G
	SHA5Ln1JWLXp4Yj7EEeeZKzimW/ma6tkOeQcxa8QbG2Ww43iCGpfa4CyIlxGyGpLavIsrZ
	9Aw4l9ScELwOq9GutzemfBCi4Vnuml37jY/BIrgwOiXgumSc1ZZRWKkVaYQG8w==
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Thu, 13 Aug 2026 20:37:05 +0200
Subject: [PATCH] serial: 8250_dw: Add device HID for AMDI0021 AMD UART
 controller
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-b4-raven-ridge-uart-v1-1-fae442416ba1@beckhoff.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqFMAxF0a1IxgZslSJuRRy0NdU4qJKqCOLer
 f8PD493b0gkTAm64gahkxOvMUOVBfjZxomQx2zQlTZVq2p0DYo9KaLwmNfDyo5GO0VBBa8bA/m
 5CQW+ftV++DsdbiG/fyl4nhcCjxPddwAAAA==
X-Change-ID: 20260813-b4-raven-ridge-uart-62b1ef1fc246
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786646322; l=1774;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=TwVe9q5jYPFqsnswjy0Kv9C5ghwBKK/NeVo5XaCg7CQ=;
 b=IlxQcr3ljAdgN0qICwLAAkBRWUVdyskrrm9VU1tn1OrUNoEab2xtkPRPHjJmdqqKWBJOm8F9h
 SBCUhKLYy5yDdtTEmGy7G+sWlf9jIBIupr8D0AeWY3dcJ8rpDPuWtK+
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

This ID is found on AMD V1202B.
Like the AMDI0022 [1] this one works with the same match and the existing driver.
Tested with a loopback cable.

[1] commit 3c35d2a960c0 ("serial: 8250_dw: Add device HID for new AMD UART controller")

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/acpi/acpi_apd.c           | 1 +
 drivers/tty/serial/8250/8250_dw.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 008bd0552cb7..562be86aa272 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -250,6 +250,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "AMDI0015", APD_ADDR(wt_i3c_desc) },
 	{ "AMDI0019", APD_ADDR(wt_i2c_desc) },
 	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
+	{ "AMDI0021", APD_ADDR(cz_uart_desc) },
 	{ "AMDI0022", APD_ADDR(cz_uart_desc) },
 	{ "HYGO0010", APD_ADDR(wt_i2c_desc) },
 #endif
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 5fba913f3301..214d3e7ae628 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -910,6 +910,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "8086228A", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "AMD0020", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "AMDI0020", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "AMDI0021", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "AMDI0022", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "APMC0D08", (kernel_ulong_t)&dw8250_apmc0d08 },
 	{ "BRCM2032", (kernel_ulong_t)&dw8250_dw_apb },

---
base-commit: 3aa1dcaa4f6f5ae08936491e08bd456f331f2d40
change-id: 20260813-b4-raven-ridge-uart-62b1ef1fc246

Best regards,
--  
Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

