Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32ED1BFDEA
	for <linux-serial@vger.kernel.org>; Thu, 12 Sep 2024 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162753; cv=none; b=DhI1JTJnsMRvBCVA/SDI5oS4uJghNijBRoOojRTDRKIle0Vs3TnP/Xcg7nZOMPFSUzUJ/7t4yjfOdVPq//fKK2Iybr6PvagwvVKilSQLRmg3mcGLIljMZ257TjNuOKVjkr0Proko8Rn3H1OS0tlPs9CHfyyUBbEvXCl+7z7xgfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162753; c=relaxed/simple;
	bh=sdvuNJYXbnl+iyClqdVA5O83W4ftzy+TWXXAq64uN7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHVPNd7IeG20NNGBOQopXP6203m16AlQ3CmS9cXTRZtH203o/gxh1BDGD0qYg4Leczi2+ivzxIR8925NJZplSJ9WiNAOf0wMXwbVCdfxI5Mv/vE3YU0IwGWmUnt5Zupe6gHnQ4dKVM7E/3qbeDyO7fSvmRH/2LSIH9wMNm99SBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U1Y3vEOI; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U1Y3vEOI"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39d4a4e4931so4198905ab.2
        for <linux-serial@vger.kernel.org>; Thu, 12 Sep 2024 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726162750; x=1726767550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qECmHjc9dK1dFT5mGpczd6pcWBHqdXTgofYQGynhgPc=;
        b=U1Y3vEOItKe8tEuj3rwDpOKtrApa7FG5bxRYPzR0tof42evGHKbnPzFBXaUQsS6KTT
         znu39CIx0KyRHwig0KURQgTIhGoccC4LB8vDWMzuInXsTft2w3Ggc+qjLR+fzAwEQsgi
         pj+O5eR0jv35WqhXYJX0RAUKTjBJeN4f1nVCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162750; x=1726767550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qECmHjc9dK1dFT5mGpczd6pcWBHqdXTgofYQGynhgPc=;
        b=AgFlmNZA4xlbaUYCaHsZEf1j1kC0vl9OHE+gzKrnbxW1E2Er0ogCwFV19EHm5Gj+2U
         6ZfMIrbStZwegeeY2UsisX4cvgodKdBw8ZMasK9wClmyNfyCSb4zj3yF8Yjv/rZwQniR
         ahqKhc1e7F4m9avIhF8ab2jqBGfIG77Ixu/OqETJYhZLb+Hsp5xYHNKqv0UyLPCL5lq7
         Mq38Sb9T6tKH3lCkO4cfD8+3o7tC82tFcgzpW9273ki10dOoqNjzpEpibTJG/NwkWG/K
         9Pn44zEJq6SLqYNeU9wVmYGuIUP0IUAR8tpZZmIsLBJYz0Yhq0Yh6hHdKbz4O9Ld4VGP
         /Qzw==
X-Gm-Message-State: AOJu0Yz5cZT5K8dMLe4YfCc4Lp1nW1tZ1fhPFrorInwxwjLjCoKvxZve
	YiM28N98l+VFPKzudzBsjbsan1hhqI12YenECtH/j2/iGo/SaHO8ep1EnOMaVpL0Xds1fwqnjmA
	=
X-Google-Smtp-Source: AGHT+IHL4MH+QIKEB9bCMel4ROL7d0o5CwGYlEvbEC0U2AMuWF6C9AaGEEJwAGhel0XN8qNUrPvZtg==
X-Received: by 2002:a92:c24d:0:b0:39f:6fcc:fcc with SMTP id e9e14a558f8ab-3a0848ae8c0mr36173705ab.4.1726162750451;
        Thu, 12 Sep 2024 10:39:10 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-226.arvdco.broadband.dynamic.tds.net. [24.56.189.226])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a05900e618sm32570135ab.55.2024.09.12.10.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:39:09 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: linux-serial@vger.kernel.org
Cc: pmladek@suse.com,
	rafael.j.wysocki@intel.com,
	ribalda@chromium.org,
	Raul E Rangel <rrangel@chromium.org>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ACPI: SPCR: Add support for rev 3
Date: Thu, 12 Sep 2024 11:36:21 -0600
Message-ID: <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240912173901.3969597-1-rrangel@chromium.org>
References: <20240912173901.3969597-1-rrangel@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revision 3 supports specifying the UART input clock. This allows for
proper computation of the UART divisor when the baud rate is specified.

The earlycon code can accept the following format (See `parse_options`
in `earlycon.c`.):
* <name>,io|mmio|mmio32|mmio32be,<addr>,<baud>,<uartclk>,<options>

This change makes it so the uartclk is passed along if it's defined in
the SPCR table.

Booting with `earlycon` and a SPCR v3 table that has the uartclk and
baud defined:
[    0.028251] ACPI: SPCR: console: uart,mmio32,0xfedc9000,115200,48000000
[    0.028267] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '115200,48000000')
[    0.028272] printk: legacy bootconsole [uart0] enabled

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table

Signed-off-by: Raul E Rangel <rrangel@chromium.org>

---

 drivers/acpi/spcr.c   | 5 ++++-
 include/acpi/actbl3.h | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index cd36a97b0ea2c7..67ae42afcc59ef 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -209,9 +209,12 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	if (!baud_rate) {
 		snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, iotype,
 			 table->serial_port.address);
-	} else {
+	} else if (table->header.revision <= 2 || !table->uartclk) {
 		snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
 			 table->serial_port.address, baud_rate);
+	} else {
+		snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d,%d", uart, iotype,
+			 table->serial_port.address, baud_rate, table->uartclk);
 	}
 
 	pr_info("console: %s\n", opts);
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 8f775e3a08fdfb..afe45a2379866a 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -92,10 +92,10 @@ struct acpi_table_slit {
 /*******************************************************************************
  *
  * SPCR - Serial Port Console Redirection table
- *        Version 2
+ *        Version 3
  *
  * Conforms to "Serial Port Console Redirection Table",
- * Version 1.03, August 10, 2015
+ * Version 1.08, October 7, 2021
  *
  ******************************************************************************/
 
@@ -120,7 +120,7 @@ struct acpi_table_spcr {
 	u8 pci_function;
 	u32 pci_flags;
 	u8 pci_segment;
-	u32 reserved2;
+	u32 uartclk;
 };
 
 /* Masks for pci_flags field above */
-- 
2.46.0.662.g92d0881bb0-goog

