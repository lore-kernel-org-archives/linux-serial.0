Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC31B253F;
	Mon,  9 Sep 2024 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871380; cv=none; b=uw6pR8iqulo80NAyGOvh/Q5KruIU4BGK9892gnQ8rMm+vicIsuXJPhXhm2rW962n35a9z7tJhBkJz8gHzKmyb/sLjowxkBY5Y8bJMTy7xAfBPvOHZYsfiNb3SIxsGwHrNTKpYquDtmvwlSp4fYhfjOiUUACTgqLgoanBtAobVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871380; c=relaxed/simple;
	bh=mapt5MFKq+QW9FLF0HkigQF3cCnBrZGhZO0+2qfCsgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SU8Zrms1yy5lBZpMYJ/fqHNFq+tP5317fDYT01Z9LnJ9Y04K2CHCOrH15QUdn5O5B9qjh/T0tfoC1x/fc4p5hHcn/78b/Zr7Y4N3sdm99G7E/cpFqWBk+pHAwSpCyMLSow6J8Rb/K/NsuWD2xv9mJLsZXoYYaLMY8wtlKYPbhOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euH1PtTd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euH1PtTd"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2068acc8b98so36693415ad.3;
        Mon, 09 Sep 2024 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725871379; x=1726476179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ime9++9V4dMSnALios3NYyCHO13/6swkeU9Ozoi9OGk=;
        b=euH1PtTdn+crm5xDlQUppCMwUBgTs7s3VjmYpcDFdD9QHJTDtHDjBRdVgq9oOK52Po
         52aWwhwiz4mQGEi4yzK6GJLC2434XnusMAREITxny/AtV7UmSKx4p8flitaBOlexq19j
         nHERSlXTm5y2TwoBkJXNe8oS4/eC2jdIR6Db6W/RBKDd2rAA2884sV2Kj1mmPsJnibPb
         UPxWU2ELWEktyBMND5rl9JDcBjsmAA5O1Ty4GwSPnZvc816dfz/MZphUk+e05/du5e5o
         82ZNZwiwMavFQL2VpKKPMDgRVS7iLfHSXnDDICPcFzHcvrEkla/Kl7PQWlm7McZMvz+V
         66Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725871379; x=1726476179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ime9++9V4dMSnALios3NYyCHO13/6swkeU9Ozoi9OGk=;
        b=Qj6CcrC7oDHFO4VRzj6TIocLG/JFHHAWuZmv2Z/fGUyR0ZdSnDNewu6aNYjdK86XUn
         5Kx/iAUAHHGpdF1wTB25u9Ii/vpxlgxFumVmif4CHjpReS+wz2iRXtyPkO97h/HiABVm
         HcWf+aQ9aGnnba5iC693SVviJhBxLLl/w4HXKl/e1O3GA0HZd9nBBYnCpvba1eemHGTH
         V1S8haVWQAQBEe3HK+5ZUvSUanOj1DOlRulm6pNC2o41vdtHFvgtd+rzBHRwdAOaRtc7
         wTXIARS+Qnt/kiNp1Wn/eTZdQeYGdIKWhsOI3sGktR6ZweF9JCGHMyL1n/aBPXryd7h/
         46Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUONB3ZaXTJoCk7z8zvuY96oJrfsSQOG5NllLX7Dp6VsjCVydL8BHLmxLepNIhVVrhO9EFwDJfiSH8Xb9lR0bt9O/Y=@vger.kernel.org, AJvYcCUyu7KfKuIYDEd0iUQjbcZUgVCLtxTabui+vNLpYfOCgWtUKmZn3YNWvFpAQcGK9LGU8qOuXmpTqTtS4Cc=@vger.kernel.org, AJvYcCWgZNUhNLiyV1Y121pk8vXbXoaPDDur0UgVTWEsNBIQeBzYHG8vwx3QGMA6YDSuldg+OLQ54Mu5KdyWqegx@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtNO+rhjC6HHwJCAZtJWuiJeHfKzKOm3KkK9VVQ8erYDGdxi/
	kt3LbFG+X8/zjqNz7v8pS6Rh36mmGOzIGiyYZimPT/bCzAuXCcS2
X-Google-Smtp-Source: AGHT+IHf2rGkS0joRjpvnV/EQc6r/nFx+luAU70uoQR21TpftM5FoMHszKqU8pZjc+MZSnAAlsiOeA==
X-Received: by 2002:a17:902:d491:b0:206:ca91:1df8 with SMTP id d9443c01a7336-2070c1c7184mr87144285ad.53.1725871378748;
        Mon, 09 Sep 2024 01:42:58 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710f1d663sm29678675ad.188.2024.09.09.01.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:42:58 -0700 (PDT)
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
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v4 2/3] tty: serial: samsung: Fix A7-A11 serial earlycon SError
Date: Mon,  9 Sep 2024 16:37:26 +0800
Message-ID: <20240909084222.3209-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909084222.3209-1-towinchenmi@gmail.com>
References: <20240909084222.3209-1-towinchenmi@gmail.com>
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

