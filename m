Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67731327A
	for <linux-serial@vger.kernel.org>; Mon, 15 Dec 2025 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765783791; cv=none; b=mrxDrQA0UGtSm71u1UyAT87qDNRj8/UlL3/awd5l7oZ+JFgNCa40zF3EkgR63YGk/CyDmvTCuHRPYXKWhUbGeC4bFjz0AYt+VY3CsRn6OtgOPx1jek6ZPdPK4mZwtX4rFkdDwdDVmvr8aF433/njyyDSq1EN9Hm0ekjBw5sTbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765783791; c=relaxed/simple;
	bh=Ti126A8phEH19vnYpIQ1yhDEhoiqNJa7dIgJWsEGgvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ptlpi7cf7yJFrvXQKW8SkJR3p6F9247FxUwl5QeLtLHad4USbC5qCKm+DJD1uuHLhk1LUhP0DTKmNHjh/4uWC+xxs9W74VHnyFFd7yV+rhjtmYbCbsx0EctGMBptzN7DDjQ7cCM5ym710+7Y0f2I3fcndGMeYW96scHDe9S1VY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfbIwoTq; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfbIwoTq"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3ec5df386acso2215223fac.1
        for <linux-serial@vger.kernel.org>; Sun, 14 Dec 2025 23:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765783789; x=1766388589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nL3AN3G7DYAXkc+5aAzLFKJQfSpHiNXG5fjAAH4wGZ4=;
        b=UfbIwoTqpuQD80ASe8DneNugGbTizwfrNBNhhiWkhWqlHLKdGHeayE3gyv4Oxca4d+
         8xHgFApOYKeZF5zDRox8fBZfy01PoGhifDXERRPwN4D0sTe6HdKBUtQ8Syq/9tRMy7Dk
         vC/eNiC7CI+gSPphBIG+lfrettgYTmLgP99XVQW7s5HQQyrUgMwkE6iJ6iz5dTrf7t+6
         qKBAScbZMkJSjCDMX6CNhaMtEsE7cUReAZPGKpdm8yD+fmtQxRb+G8tA2Gu5Q+OrrNIJ
         kd/MyFjQ9TrFya1izLbTTWWnmj7xlU+co48EcdUi4c5fBmWdFW9cba8eX6KyYD7kvYYt
         w+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765783789; x=1766388589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL3AN3G7DYAXkc+5aAzLFKJQfSpHiNXG5fjAAH4wGZ4=;
        b=VZe07gL/dwDBP51lHlC4QHQrXeTHlz7pM71AVf2D+lmg1XksNLWQEM6ThZu2m84QeK
         IrW0qLSSSa2wCBLn06pItGZEPSinBdKtvSxe4QJg+Vjc1XY80kEd35+NVw95FCzaaNVP
         Qz2Oww1H82X3Mx+mGP1FJvStAo8VN7n4XSeZuhU/J/USoLDL3eT/LnMWjDVpv/AIN9bL
         DARdJoj3qB/FoWc3sWi2eaqSa/T31pUxEkFGKpe08IQcNRJCJgovUe3r4/VsUG8rBi2x
         JoyqE8PugA85IHXEOKuhn79ao3GOAwJyKIktP2hvwQOtbkIsNuaVdFEccNKyWLAen5Og
         WuPg==
X-Forwarded-Encrypted: i=1; AJvYcCX3OXrBJP2zYstnCLNSb8U/OgRRnqevvTVjTAo/jkeC2be6BrOJnI/hkY/OkHrNBXSW/+xvGjF/89kySMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WGMgdnoBVVGmvufEjaKh2PQsp9yhtgDdhpTlSBLakPlV9pjY
	drvz3jkMgzOVCnfH/o7rRM0tClhjScSt+2t/w4QhMZ2Ukq7XGMCI/34E
X-Gm-Gg: AY/fxX7iftPzbSynjS10aZKFafYY978tq2sOICTinePAI3uH8j1ZU192ANM5ze/8u29
	HrcMGcq2eGGWVJoicHYwec2IfmNBnhGbJyz6t5lu08Ge7NoaV6c0T1dFahEalGXmVLRS8daaniR
	mOHIc3/eZg5KVAumL2W+G/9V+3g9CGeETIS3Veb6glhIgbTcZWJtoxL3YeQGefZQzJXpiO8NIuD
	nAg6LnfXo3K0StAwQf6KUbMLv6ArRLcRl9SeicioKIyxgHzyz8IMe80ZUvFnTjjhL8yj9pAxWz3
	8Br9GBSIRmUGCBGwoEdj7zlmmpDxSYBZMSIYjtmuWzFgLJv+TGFphd73uX6l3sVBhY8PM0jx8W7
	ZXInRpbrZ127TTQ0T8BN6a4aVxpkOVD/ZmPPmf048uZJMqbBI37kXzoWwekkpln2qB7+Bt2YXzE
	SI0fbg4tKCfTvMEesXhjqTiYEKuDxa3sift9s1T9ln/ulGMQUV0/M/wwMqJie9PIv6gQ==
X-Google-Smtp-Source: AGHT+IE9ByRSYwQAT/t5PqdA2hnfarOr7LJRblwEvGcmudAPA+W14aPrxI02obHJGezTmT75aSb1Ig==
X-Received: by 2002:a05:6870:649f:b0:3ec:71d3:66ae with SMTP id 586e51a60fabf-3f5f8cbd34emr5821496fac.44.1765783788849;
        Sun, 14 Dec 2025 23:29:48 -0800 (PST)
Received: from localhost.localdomain (c-24-9-224-2.hsd1.co.comcast.net. [24.9.224.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614be6be3sm4158605fac.7.2025.12.14.23.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 23:29:48 -0800 (PST)
From: Harikrishna Srinivasan <harikrs0905@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Harikrishna Srinivasan <harikrs0905@gmail.com>
Subject: [PATCH v2 2/2] serial: pxa: Fix comment typo
Date: Mon, 15 Dec 2025 00:28:46 -0700
Message-ID: <20251215072846.11603-1-harikrs0905@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a spelling mistake in a driver comment.

Signed-off-by: Harikrishna Srinivasan <harikrs0905@gmail.com>
---
 drivers/tty/serial/pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index e395ff29c1a2..19d85398e394 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -99,7 +99,7 @@ static inline void receive_chars(struct uart_pxa_port *up, int *status)
 		 * Specification Update (May 2005)
 		 *
 		 * Step 2
-		 * Disable the Reciever Time Out Interrupt via IER[RTOEI]
+		 * Disable the receiver timeout interrupt via IER[RTOEI]
 		 */
 		up->ier &= ~UART_IER_RTOIE;
 		serial_out(up, UART_IER, up->ier);
-- 
2.43.0

