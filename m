Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED31FBC90
	for <linux-serial@vger.kernel.org>; Wed, 14 May 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244147; cv=none; b=Umx85CYiZp4J1VC1gSVCFDSuu3AGbsI7bP/Hz38s8j+Lry87GiC3harRA28l0ByllXfzKhnFfXq0cSkjg6B7KlzozQkUAgvSEV2/vPA9OSD5+wRmY0/v74jdCp2S+RIjUMx9MA1N1b79c7icsy/42Emnpk9NlAOscbd2iLkcNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244147; c=relaxed/simple;
	bh=kMBY4DAxKvuFctemKJL4Ctp21hgckmde+lZe/CUax1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=busY2QDJjsg8uEP2bFlQULmvM3wWIsyZXcKHlMMdjnhWd6QCPgOCKnWwjf+fjOE2hmyTRm/7r8w1MBhT2RF2sl0NLq7IYcRJBVsASqV9YEzv644cqdrAwBXvghbx7LHZbSmKv3YodoYVmysM0DtEPjVnW9ZpG9Cl5WMNoSlpBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=UmSmmUQg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="UmSmmUQg"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a0af41faa5so18042f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 14 May 2025 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1747244144; x=1747848944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iryv4SqUahL04Hy2MEDivx9DggZegup6t3O9tkyFXE4=;
        b=UmSmmUQgTmyxjl+oUI0S/6EBA95OtXTpC9KiZjbK7INcOA8E4u6cDuo6cUr12hPHc0
         PjPI2S1BjIn0nW45prx12WFgLX2bqMPK7AVMJn4gCuMFd0AFH2MqlBxD99w8aMh3x4EU
         d0CxrvYa8/oyWIJcUQICpohFEZHU2HObYScD7iud3SY53dCWujYVG4nxXib74IAuHRI4
         yIOnZOoAzWsP7KZfy3/gGy7lpO4SMMNkI1Yys6gi8CrAtv7oA7ij1lwbzxyjzDq6B/oO
         CFivQrt/bSt5dtWeLipMLWcTSoYff+EQxPnOyTpdIzXtK6dgsbV1b1bLAURjI+MMHMw1
         mn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244144; x=1747848944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iryv4SqUahL04Hy2MEDivx9DggZegup6t3O9tkyFXE4=;
        b=kGkHk/4U7L81K9q8wYcRhzhuDakNG6gl5iWinMbnZWqtLGqadSCFWK9TcvHADM/nWQ
         62uJgq/vbgjQTjShGuGltOp2c7gFc9x9xuwqE5T+wj5sX8i8KCTZobgT6V5F76Zjrxnd
         niApaDbin/JmrZ7kn24TuYI34Khu2DwgyQWwzuGO5i9/bQVuLO5Wiu245beBVPLPhZKD
         HVtrOd5UhrSA34exwJvgC2DozquhJ4cgtvZi0wqoY7whM+oI8o11LtcIN/oz2mQBXzSK
         fNkYfGxb5RuJnTR5rh8AL8oarc6nyzPf24fCKTtGk1m70MKkSgqFcOUz5yn4v4Uxlwow
         v2DQ==
X-Gm-Message-State: AOJu0YwkWq8FccCpf80ObmBcTovpqzuw16s9QfAeRKaSCl2rtHn1BKDZ
	qQufjY/C1DaUephF5XIqC1BPQJUecAnjUY/EvBgwMSs3q0nbP/PXiAcmGP9PBluWnvDItWnL9hT
	X9nVvCQ==
X-Gm-Gg: ASbGncuqmjgEJ1uVnuIzWrJgVd/ENKd08xcNY5FC1ryBlnUx2duXQG5kkKxEfGC3V9J
	VnPN//vMk5oU8lAR+6Nf1wbL0gIM2stHJnnRBCs7MskyRPmN1xwO7KtY4K1RVFZOox/KE9KzGKe
	QzunXtpEQo55kifq3bigwyN9Dr2KEFfT0A42mCgr/nXI2DB7Ed7U32gVM5OEyMqF3GOrqHQVVKP
	PKI5AHb6FSAi6YP5eHLjgZfmrY4HMPcrcfwXYxSRcG7N3x3p8AC3DvVXTmTOexY1W2ygO6AVIoj
	abPx81MryehlDoPHCfVLP/7NN0Zn5na2Wob0J1ympz+AmAOIB6dECAgoMpuh0i9T7ZBBi5M1gU4
	wD659XFYguHZk3IXQwGvhMZtG2VDkhZ6MXK+pey3DJmuP7xEux3oS+QfEP8xEoZpOUaFE
X-Google-Smtp-Source: AGHT+IHUv4jARGxW3qtgvssA53x7FJ/OZD9I9OXVQCX+COA2sU1gdnZCkgzcpQpJ2CExOreiXYUL5g==
X-Received: by 2002:a05:6000:18a2:b0:38f:4f60:e669 with SMTP id ffacd0b85a97d-3a3496cf729mr3666481f8f.29.1747244143883;
        Wed, 14 May 2025 10:35:43 -0700 (PDT)
Received: from ubuntu-dell-xps.thegp.cloud (shef-16-b2-v4wan-169484-cust3641.vm3.cable.virginm.net. [92.236.206.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2a79sm20058436f8f.48.2025.05.14.10.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 10:35:43 -0700 (PDT)
From: Michael Cobb <mcobb@thegoodpenguin.co.uk>
To: pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org
Cc: linux-serial@vger.kernel.org,
	Michael Cobb <mcobb@thegoodpenguin.co.uk>
Subject: [PATCH RFC 3/3] Reapply "serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()""
Date: Wed, 14 May 2025 18:35:14 +0100
Message-ID: <20250514173514.2117832-4-mcobb@thegoodpenguin.co.uk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
References: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 244eb5c6ec62ccab59ecac1f4815bb33130c423a.
---
 drivers/tty/serial/8250/8250_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ef7dfab908d8..af77fd966d6c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -724,6 +724,9 @@ static void __serial8250_clear_IER(struct uart_8250_port *up)
 
 static inline void serial8250_clear_IER(struct uart_8250_port *up)
 {
+	/* Port locked to synchronize UART_IER access against the console */
+	lockdep_assert_held_once(&up->port.lock);
+
 	__serial8250_clear_IER(up);
 }
 
-- 
2.45.2

