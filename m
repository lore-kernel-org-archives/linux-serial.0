Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45DC2E92B7;
	Tue, 22 Jul 2025 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186146; cv=none; b=REXBQT8/Y4uP+ofZvg/JGwxZMT0WGk9oaSC2m/pPvfvPmWbAnPWab1QmCJXK/D6GOqK1qeB3YlmePf6BTGYZjg8rOr26Jq8AMxg0l/czYAjTkncnUFwb4MtdyS4k2B3Q6nrbc/LKJxs+aD47Hy+7z2dmW7NDE1Ob9maSITgHwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186146; c=relaxed/simple;
	bh=/M6JFQ2h1CU2nv3SZRy8IgVgox5k7S4bcL/1CYucyUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4XVSBhsnzKdXfm7O7FXKxHIJhv6r0LLMXkPH66rpGfPgxuNSolOG8MbqrXfUeJH/mvDzv2syjPubEe5iR2WAh5r37NeciKZgM3w0+NhfOMAgQrRkY0J1gOuxyXMq2w4WNycl/q7EBRY8ZyNeuioaJiC68DcD07uYXL6BPrPdJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pw4EHjEq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw4EHjEq"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so810201666b.2;
        Tue, 22 Jul 2025 05:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753186143; x=1753790943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/zN+BCB9PDyNDE9R4NEw3s0veUZFcpZLCmrjf9UE/w=;
        b=Pw4EHjEqCdcmvmT59rEZfF77g75GBAa6Ha+o6BZ3gJiNE2BAJE41YxmtldrK9tB0Sx
         xP1yFamtX/+AIB9ob0FsWMu1avuWAWLVAz7V7Z2waW+X2NJQ9EcvYKZSMuR1nn3BLeO7
         di2aHYAgZuRfLJZQ1kBKTVL04bV5Fv7kEHdNnvk3UrN2CejEl5ZECj52yaYUgAJNgdeG
         SFCMPQZ4CZx+WAV425IIXtMQaCAcqllU2+bOfRjS2jHb0w9d2JebrSwDDdDHw+aAqA5f
         qrMo21zuF1h6DaJr1xZu2CSn+obQZU7dRk8hVUZQDQ36dM2zmqF2tUUE+k5N3X0TJ3HZ
         umxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753186143; x=1753790943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/zN+BCB9PDyNDE9R4NEw3s0veUZFcpZLCmrjf9UE/w=;
        b=QKLCxs+846FJhSuenNnGfDtYi/W48vBBcJh2fRdt1jcpqtbYKUKWfA1n+ChcXd3Pot
         azwQT+lAOCGLlLEK52tUCxUUY6pMe56uSa5x+fOoOIJVX0VlCWtEwf/56FL9nu1VmXFZ
         Qw5cTI/wUdDPLewA4xA5j5MnPXrBioMCe9EW4XV4/GS2aWAUXHFs/RKHfx/1abpVOrKl
         TkMBSXCUTQkMDdBGQWoRwh2ihSciAzj5rTRDSNuhzcS6WPAy5zwdt065uQuNq3QJZtYA
         uIjZW4p3UapP1PnlbektL25Eg1TQJRz20FyEnHuIYc0fQ5aVu8vcwvEoGEXVgsIKlExL
         TH0w==
X-Forwarded-Encrypted: i=1; AJvYcCUMrTxdIt8YZPfsOvlGS20XFprzAaUlQavXWcE6ZjXHaVDtbgM06NQMTl5ZhUz0ggsM3W/3KfOlrDkf@vger.kernel.org, AJvYcCV4t+Ayk5cbHb08T1GuhZS+QeK6X0rEo0CkFp+yx67Og9yeWyBrpIMHzdI8D1WnaAGdmAV1WbO/F73yxMiR@vger.kernel.org, AJvYcCXL7vsFO5Nn+mGkzI9CZHMHEHe4jcdp9/k3FtI2jDeN09a+wXabjh68PdZdStAhXnxPRhEPeXRMKuE897oY@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUoMuPsQTDmZgGs+gwrtWjRQZdhONmm0DDclwssHUdULXUKx8
	+/9EoDD2nbBdgs3S587FyF/wGdg6pVGSRUugdDO078S2fTI4l7FFvcOtcfkX+Q==
X-Gm-Gg: ASbGncup5KMzb/1JdB4wlXUr4hY1SH9qHuGfc8khgtjoE+15Wm3VkyNriUgFvE/BnyT
	M5pGlPtC0vAXVzS2Zh8E/Ry1NFNurWOGumIiZPH0haX3XYW0NvUJjs8/bYn9+Em/Xhbmfrx4vNa
	QAC/5iQm9fJ2JBpISg21tUD4DsF4fKMkvyHLzvVc/8gvCVnRcF8Ow4bg2Vp7nkhhBXwylcsFqsQ
	W4SsWM1f2bkUww0IarlKNZ9DjyDP7wt8ezU4A+oRGHj9rJIZ/l7dbRpi4+yDtacK3TlCrw5S1Zn
	BMyH2dcT2VA9zz8xhxsU6sVEJYGuD1sU91FG4+Opg/RwtCtS+9GYXIHqzEt0snDDmCgpf34xpvz
	XxU1Fha3kGJnbMh/uSZpNiahOtFYf9ItcQoG2vS9q1NgKM8Zr155YNwnRV77ZK531Is8SN5OmFQ
	==
X-Google-Smtp-Source: AGHT+IELdo3U27oOgtv6Kv6ED6xgavO/dGRHioarTGley0NsAKeI8rQbhsUM6DVDUWHgEzZ0n6rdvw==
X-Received: by 2002:a17:907:3e9f:b0:ae3:a812:a780 with SMTP id a640c23a62f3a-ae9c9ba7b98mr2301348066b.61.1753186142732;
        Tue, 22 Jul 2025 05:09:02 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79551esm850878566b.4.2025.07.22.05.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:09:02 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: serial: samsung: add samsung,exynos2200-uart compatible
Date: Tue, 22 Jul 2025 15:08:59 +0300
Message-ID: <20250722120859.443283-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated samsung,exynos2200-uart compatible to the dt-schema for
representing uart of the exynos2200.

Like GS101, it has a required DT property samsung,uart-fifosize and
exhibits the 32 bit register access limit, so reuse support for it.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 83d9986d8..1a1f991d5 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -28,6 +28,10 @@ properties:
           - samsung,exynos5433-uart
           - samsung,exynos850-uart
           - samsung,exynos8895-uart
+      - items:
+          - enum:
+              - samsung,exynos2200-uart
+          - const: google,gs101-uart
       - items:
           - enum:
               - samsung,exynos7-uart
-- 
2.43.0

