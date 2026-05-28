Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BB5409E16
	for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999190; cv=none; b=l5YZRUuKySlyYvsHihgIyNcPe0GB/v4GDKDLTiV96onlCV1dvJ8W6DVHc4A2BEwSNJvjUTAPthztqorSurROBGe+NPMk4UuZBMXocmWJ79Pd9hngVxukmLadQoAb3Ie0iRIgdyVpNFP3u3jI8zT3HxozNCFRr/0VP45sVngjbws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999190; c=relaxed/simple;
	bh=MW+T++PF99/Vjl4jrlZc3WclQejwtQesBgvBPrpVZV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeAWRT6WuADGeojnFqmDc4Si39QM4YKHHkJUL/FBfNupQLd0a4pQokEJTgwvgYyKjZ9kUGEp3K1ZZHuvs0VmnHnfqxdilN5cy9UNsu6Ihvrg7NOfC0eWwcPnMrebGwnMxCNBykunq2FpeamAxOfKVQarHcRylxB3QVxfnK+/vLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sXaB5pHb; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXaB5pHb"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8026aa4d53so9475545a12.3
        for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779999188; x=1780603988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9qJ8rpcsYRHuSOceWQ8qSKZ87Tyx2plk/734O2C4JM=;
        b=sXaB5pHbr0xAyX6tNORL1RBbeyKhHH2boX8Tnn41sipyEvHfr9vpVvqJ0yLitAohZ9
         7dxdt9WwvuGVzWBqGArtfkOqBmYOfT4SNW5ByZMlte3vKhdvCHnJxx/S/vpNni4bFYCX
         uJOhEBMQwI3AQPJjJ5t3nPojWfFnneQy7DS3v/NIqCW5t2+MKXb9qf57IjqQ+IdpYxdE
         kgmHcvSU3DM1pi/AzuTUEgpCIoHt1C8lSCZ0gpCvx3Y4e3eQK514Q5NDy69yBI9UBQdF
         2epmYEb6o4M3lpKHFvOsMyGWSMABpQsqLyd9wf1aQ2WsIcsj/Blwut+To7+3p4BIXN2L
         fKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999188; x=1780603988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9qJ8rpcsYRHuSOceWQ8qSKZ87Tyx2plk/734O2C4JM=;
        b=nHmKOe4lrfLg8iAdCwSiwnDcVsUvfQiHXuh4hT4mm6bCDj8JLSAa/KD9pJCIYg23MM
         86KFlLgxZnyi5v+7oTGUP85Q29fIBqKulLyQUo9xKD8utT3jRKzoszl2IyX7V7rn5Qh1
         CqcNZzFsEpT5edfM/NUD3uhrwYrq9KWi7BUZyqA53k0ML30YcLyy7P3eeEisuqVoRfRm
         JMLjKMMRORNdynF/py1FsUUXhciQO2aE+QCN8U5Pz/1/wjiZFLwciA8k9m1a/f8xLELH
         HCgWr3oFVoNMnq3NcviVx3R6u92YCCldub6askSD5guE1nD1Uo8ZDoMBKqfQ3e1Ilu+p
         kP6A==
X-Gm-Message-State: AOJu0YyOklQDjHZ8SjlgWzq9kiQka2tRxnqUZLLomLrGoG/8rKAJhxk6
	lv2PblstCSmuzyZNIxZKO20dnyiWRDNs/qiP8O0gvFYRfwZW1kLXtQTELIvWcXta
X-Gm-Gg: Acq92OHhuNLJnckJRZ8jdgGqgv3ZjAZEbHwqTbwW/juOrFvuVssLR10xE6njIwxevyQ
	gsEuML5uELIvtug7ghYIC5xexx1D16kSAW/JDfY+kk4Yo4c8hU46n47vD4w3hP9lJgYk1S/K49U
	J3UeWqSFAya/TiIcTYAFB+ks6rSWhf8/PK1avrF2r3eG2VdP1HRHpSgXKVNy3IQkogVpkY0HOUX
	uWgSlfWVQ1xi9PGTwMail1sZ0GbRasnrYacHT9nHtSr0f4TyjSgsCnwmprzJokyE2egWLnNg7CY
	ngUuYchi3dHsD1LomQgQ2kZDEoz0FTphDp3T/R7E4Ji+WCYOUDRHqyftw0gJJcIIQgXEdZvRjgB
	2PZxF9tqTOVh0Qa+JJceJylmAW+FHuCu3Sj6bGU1z3nUN/wfens6+En1j72nX4aCwbxencVhnTN
	CjwP/I11+z6O9nGyo32nNR8KHRxr4tiBDAzuVHzyHOFTnkBrPHWe1AesBBfRF0MBt968czXteAP
	mIS6FTx6xCg60qfOgEi+eEP92nMGXLX8qp8Amw050eeMg==
X-Received: by 2002:a05:6a00:6c99:b0:82d:603f:f3a with SMTP id d2e1a72fcca58-8420cb5b92bmr434239b3a.24.1779999188201;
        Thu, 28 May 2026 13:13:08 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6e80c2asm6628425b3a.6.2026.05.28.13.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:13:07 -0700 (PDT)
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
Date: Thu, 28 May 2026 13:12:50 -0700
Message-ID: <20260528201250.135691-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI_VDEVICE() expands to set .class=0 and .class_mask=0, but the Brainboxes
 UC-260/271/701/756 entries immediately override those fields. This causes
 a build error with clang -Werror,-Winitializer-overrides.

Fix by expanding PCI_VDEVICE() manually, omitting the trailing
 .class/.class_mask zeroes so each field is set exactly once.

Found with W=1

Assisted-by: Opencode:Big-pickle
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

