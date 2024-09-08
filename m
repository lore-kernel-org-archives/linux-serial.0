Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33EA145B21;
	Sun,  8 Sep 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725786599; cv=none; b=R+3zuP0RDCS4GNBwjOZaxjm499BHCpryl1QLi2YItduvmsOUDvb7ZyJnzT4L30gm6criZmSNnon5JwDe3R0LL2CUQKYV+mBPxwMikHzSTG/BI3Z8XDf+yDL+KlPnIQGlJ2R2sUc+cu8fDzmyd2cxlziCkyDysnXKI/8Gvbd+fjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725786599; c=relaxed/simple;
	bh=VWXmO1RyWUyhWh2dn59RYX/QZ88zhjH3WSnJNNQVVnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnxRsjBdwrLkooG2BZ0Scic+kKm4Tbh400K8xx4ZPuDUiHvrUlQhYeOZ/vO5Ec4D7Vm6BTfD89AEBE73IZsyp0BxXNDDF/yOZA9G7l/nEFJ0zHwQSR6HZpUCYi1FmbSAo/4WP7J6ak7/tAxlZAc5bKx5pgecJPr3ZWQtTPNsTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGetYu6a; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGetYu6a"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39fdd5c44d3so14945695ab.3;
        Sun, 08 Sep 2024 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725786596; x=1726391396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSAWxbt/KB3N4v3rcDblPZmbY76AbUJCwly8u6qq48k=;
        b=NGetYu6aRbl0mAAgeGbtJ3muz6+jm3Uj4PyFjODQ995WhbsBBQODiSS5rXzlRYWf4K
         d+GQmX+CSA16FFRI5KHR5ZanvmZm5yDZLdn9ZXPYQ3yNR2CNO8gUS1vyopsIDFA5OVlw
         22DAXIEc6wALpYV8j/zS8pVm+BGEsaHCWMzxkZ/uPR9VT8udMgvKCFUoZD7n/h2vTfua
         NEX9EI1kIADz0plfewl8DcWkYWkgmUX/W5Xq6mMPyTYStUL/yyTCyIIH1RSsAk3CjdjU
         /NTMrgrhmFmdfg1T1BGYQuAAhrn80vz466FevgN/wrfNOROEMxy1/S8xX3/s1ongUNR5
         od0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725786596; x=1726391396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSAWxbt/KB3N4v3rcDblPZmbY76AbUJCwly8u6qq48k=;
        b=JbB0i+MAlvVnbJjhCw0IRckSE1mupaSS3ZhTd5OngfFOtMtIEAdqAhdz4HlBrGtfkM
         eQwIW6S9HVm5BkJUeYKKbzQgsqi8Nv4dmsk9X2oOcBsHOK3mnshKFlDgLlZXPKgewxC2
         bHO1lxOO5JdALU2E+V+wQw7OuSSdyvEdPYdmimlmoLqV/z0yKOLPiDhrap5/9ms2N1NH
         fqESGPaHTcs4vMGM7KkS+0I5qDX9u2sKNBtdaKLWmEcO3ndGfv/sOjvvY/rSvuLcVTon
         EzCo9VsnAiifFG+q2XxrS7IC6slXgSS/lYlQNr+zD6XmLDMOliuBFUdxex3q/xzxQ/RS
         MF7w==
X-Forwarded-Encrypted: i=1; AJvYcCUOXRgIT+1HmbqsBR0a5kwRxTJrJNgPO5ixJv5k1rw2pu0MDbkKDY7RrRiOz/j0N0U3Ocaerm9PsxPZQYY=@vger.kernel.org, AJvYcCV+CRz2AwjropS1bSHiuKytOFHG/Aw8PplAXNiLZ2XNTk8X4LPp6KnlFwnMh2qmK/Ry8emsfAVebZGNbXkfhQ+vcgk=@vger.kernel.org, AJvYcCX7f/BQCZyluz0OMcq6MNiZz3hBze4Yvm/d0dD1yJMUxzmr4KlONYKJe45i2zyJeim+68olNdoWflNxN6ia@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6uYgKUppkOV8lBv7dErQH6rPpTXhsDU8CFlMUG4xrkiPTC5c2
	4rlGaHVlM1YkAAT4X4EUHFUOx/JWxinRhBedEhLp7nhW+LH4Qsri
X-Google-Smtp-Source: AGHT+IFJnCdJXCpTXb1e+steOSyM20HciaPvsoOArOX2sAu8pdaVRbLHI57gIDA3RXUNGnGBax7WMQ==
X-Received: by 2002:a05:6e02:1e03:b0:39b:4ec0:645c with SMTP id e9e14a558f8ab-3a04f069c70mr98216235ab.4.1725786595755;
        Sun, 08 Sep 2024 02:09:55 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e5896e10sm1821439b3a.31.2024.09.08.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 02:09:55 -0700 (PDT)
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
Subject: [PATCH v3 1/3] tty: serial: samsung: Use BIT() macro for APPLE_S5L_*
Date: Sun,  8 Sep 2024 17:05:10 +0800
Message-ID: <20240908090939.2745-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908090939.2745-1-towinchenmi@gmail.com>
References: <20240908090939.2745-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New entries using BIT() will be added soon, so change the existing ones
for consistency.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 include/linux/serial_s3c.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index 1672cf0810ef..1e8686695487 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -249,9 +249,9 @@
 #define APPLE_S5L_UCON_RXTO_ENA		9
 #define APPLE_S5L_UCON_RXTHRESH_ENA	12
 #define APPLE_S5L_UCON_TXTHRESH_ENA	13
-#define APPLE_S5L_UCON_RXTO_ENA_MSK	(1 << APPLE_S5L_UCON_RXTO_ENA)
-#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_RXTHRESH_ENA)
-#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_TXTHRESH_ENA)
+#define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_ENA)
+#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
+#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXTHRESH_ENA)
 
 #define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE | \
 					 S3C2410_UCON_RXIRQMODE | \
@@ -260,9 +260,9 @@
 					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK | \
 					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
 
-#define APPLE_S5L_UTRSTAT_RXTHRESH	(1<<4)
-#define APPLE_S5L_UTRSTAT_TXTHRESH	(1<<5)
-#define APPLE_S5L_UTRSTAT_RXTO		(1<<9)
+#define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
+#define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
+#define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
 #define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
 
 #ifndef __ASSEMBLY__
-- 
2.46.0

