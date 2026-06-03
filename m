Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABC34D90D2
	for <linux-serial@vger.kernel.org>; Wed,  3 Jun 2026 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780529231; cv=none; b=s5W6ZbSV/ZSNqIc9kaUeOOK4CjrvRJS0+l7M2l7Bw7fNCLU6klHrE8etOK0EtBscCQaIlH/6MhP/biKjaUWlxxvs/sBmeLFFnHFNtUOFKH54hwfZymfwtfKJPwAIf3hbAx1bQOYDbSEC97jIgVvzGtguHfn7XyYCH7i84OmHDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780529231; c=relaxed/simple;
	bh=41RLXGxxCkF6evkmiuQBXUvrmZEV/tP+nyRrVDCrsLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5XkL6AsewLhWczsEuFmsDEGl+1TpkvcxwSl/N4150wS/guwGXQGTjQdY6py8ZX/zB36fG6ImI++kRGktz+DDnu/Bpd5gxsEOdrrQdgab7cdw4MLkdkf+WyGurer4/k2dRzsYuZb+Ne9+1pKPGgqP1iTUelvyIBFIZEvdzIMu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ1PMRpw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ1PMRpw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf125989f2so519975ad.3
        for <linux-serial@vger.kernel.org>; Wed, 03 Jun 2026 16:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780529229; x=1781134029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ7Whjf9rGOihI7ocMNjiwJGEh3geoh5OMV09wppzAY=;
        b=iZ1PMRpwDlark7ivsv5Ey5egPuqBjWy2QeOZI5aPP6jOmJhuGqe2ezWmHzjpty+UI+
         Qefmzc0vgeMy8tejybhgCVVJ27iFA5js1ojh7Mqa1Z/u3aBhCwGU1qivpWzXn6hpx2AZ
         CBRfKHGp8Ihj2OgLylIECc/4A/7sf2mE7aLr0/mecigstC6X/D8tvc767NTIT5jhP7Og
         kKlvsoeVQEB24PqzE+GRCP0D8hjPgEajERddQcMf0JTNl76DqYo3xBYxmN+sD1arkf5y
         jimTGWXfBNa+EhoCUS6DtarkVTYDB8sS02TJ5UySXsNOeDp7ghBW5we8swasFBRD9RTM
         9XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780529229; x=1781134029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ7Whjf9rGOihI7ocMNjiwJGEh3geoh5OMV09wppzAY=;
        b=clQPxFO+J09bbLCdsOCwUysOwjuBIB+Wp++TGv8kSGIDs7xKujol/HcrsN+mhP4v9x
         e+OHkrS+sxwZpdaImfhYwLjXpnRbgcUJbnTZLHd3SyWMxQskzIsuhSHQc0aGsS58MioN
         AFa/WxfP4GJaEj870fqGR2NAA6wR8dC+Ynk1Z619OdgAISi3a/PlUg1f1atky6MGyUgj
         uUob4MgW9Y0EsKPoHFr3V7khHg6sOX6lDsXs++oAd6Klb0zvZfdxgic7WHuqhWb/P852
         ugzgJzTMBOkcEyJzUqpI7+HekYdWwS00G58hjEGKS6GpKKKMQvWvIWrqLv/LfnjImBDz
         G3EQ==
X-Gm-Message-State: AOJu0Yz35I6u/6mUMxuvAqbmqJn0+8RSZkYiEJfiZEGdnhISKKG1EhmP
	aCETAgpQm+NUXzF4z74vg2di+Q24lkuhQ+YVBc85aOQIVA2JUIXVPv8d2brFtSwt
X-Gm-Gg: Acq92OH3xibKFwOvB2FJjTOfRjrxzivSRghJHvUwxxcURlVVYcdG3zpC/s357guQjce
	uWd9Tkihddx/HpXgc6iEtU5LGViMZ6Ghl+H7csL5rhGlnLQiBNlTWiT5XIZ5Bf2DeAXKQly9j6k
	Q0Aol1+qzOGvN408lZCfrUCgwcn6ARP6Wn6jvVke2QltH4YBNLZCZeKrCNVl8vVw5JqFc8kz4D8
	8cJUWsWNeatWd+2PJR0nS8xfX1DGtzt6MaogS9pqwzJUpmqga3hjQYNhFR0evR5CrXf9n0Yz7Is
	5PULstfNPfeIj8LNB8sZugBWNoeQbA+XvQZJdajKfHt+4aDVh4YXUK1wsrtnLA2UU+GlLeHf4lR
	GeeTD2tNrIac2pMfUB5LDSYzKPvO7nrlSOOVse8CrUqXNdZ/Fp56H9w7G9CktYsM2rjfYI+YTTK
	2W3ovLgpfJWvHHDkqnBXz9V/KzO9dW5mELVIErA/rsyddK5B7+UuGQ3AGsrNss5NZ8yLfzYMIuM
	vnI8EVZCFcD8hlFh33eLRs2qEJfgA7AHvsMjGcJLJ4Yng==
X-Received: by 2002:a17:902:f60b:b0:2bd:9803:9308 with SMTP id d9443c01a7336-2c1644b827amr62195945ad.36.1780529229363;
        Wed, 03 Jun 2026 16:27:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649bde7sm37462955ad.72.2026.06.03.16.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:27:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] serial: 8250_pci: fix -Winitializer-overrides for Brainboxes UC-260/271/701/756 entries
Date: Wed,  3 Jun 2026 16:26:51 -0700
Message-ID: <20260603232651.8580-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI_VDEVICE() expands to set .class=0 and .class_mask=0, but the Brainboxes UC-260/271/701/756 entries immediately override those fields. This causes a build error with clang -Werror,-Winitializer-overrides.

Fix by expanding PCI_VDEVICE() manually, omitting the trailing .class/.class_mask zeroes so each field is set exactly once.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 3e5bc9e8d269..0513f4b3c093 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5394,12 +5394,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 * Brainboxes UC-260/271/701/756
 	 */
 	{
-		PCI_VDEVICE(INTASHIELD, 0x0D21),
+		.vendor = PCI_VENDOR_ID_INTASHIELD, .device = 0x0D21,
+		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
 		.class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
 		.class_mask = 0xffff00,
 		.driver_data = pbn_b2_4_115200,
 	}, {
-		PCI_VDEVICE(INTASHIELD, 0x0E34),
+		.vendor = PCI_VENDOR_ID_INTASHIELD, .device = 0x0E34,
+		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
 		.class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
 		.class_mask = 0xffff00,
 		.driver_data = pbn_b2_4_115200,
-- 
2.54.0

