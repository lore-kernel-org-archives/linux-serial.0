Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9314964E;
	Sun,  8 Sep 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725786595; cv=none; b=RVxsQWiu0Ijy2AxJVefsn0FGM3WSCSmkIvmq/YcKetXmDQXJvW7WrHOUGWq9RZZhthGfj5+7B47/rhq0OQqb6aNcJ3GFA+2/G/+BCUpUBslCoVEXcJqy8XkFMeNNIPUZhIHHSk8MNDZiI9XcFt5fd1nouzLpeuv68W2zXZNuTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725786595; c=relaxed/simple;
	bh=svCxVGsa/8PNo8WhxAO+A8Py+MLSAKYV/i4L8dFxmVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJYGVTx7Kf7yu8DH55VarSy0jXnMcgZIokHpg4KLqi9G8QZT74eOdYOkeF47k5hueS6YtUG7a+eas/cujvncxEpm0wEQ3wAEgWLYMZHr3EFZzMSmJj4babauBAMFzpqp+8A+CF97DeF3zXOsAISqZaAICg0j4J0ZKTdpkEdH0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF/gAt7x; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF/gAt7x"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so351179b3a.1;
        Sun, 08 Sep 2024 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725786592; x=1726391392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/gNzw4sLO5OwQYehDseOZcIx2jfb86y7Omm19QJL7xY=;
        b=cF/gAt7xPCKdmsnh4NyepA/GcCHMN1n9/TfToCXErM3+D33OnTBtZSG0q3DEIxET3X
         tXiw10Q0s3+UYrtiRgRr3RQDCK24C5T0GfJbpZwi4ayu63QRKS+TOe3izmgYIDsDb8wy
         fOaP/38+DE528zBZ8I4LZiCegQsGz8EGm9Btue0YEbvUbvW6Y57YjGpOA/aNNJ6vGA9s
         CkttVA15tZuQbAvtufXN930JWpARgRBvJVsWYJR7SVSwELaL6yhQDScvGk4hvytHrRAp
         1vcDaCbNU4BfemtPvMe5RTzUFGF5Jigxw0Ntp+hPEW2Gh9AG1pE25KUnhThtb3eMvV/Y
         itiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725786592; x=1726391392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gNzw4sLO5OwQYehDseOZcIx2jfb86y7Omm19QJL7xY=;
        b=AMUb5/I78GdCZG3el+BL/fElf0YUOCfboq64YsEGLnbaw2YcBm7cAmhLyDR4ywVwav
         L8ocAywY7KbWGLEbODjhMucEvq8myhLC96Apfuqu8kMDlNOTpJaMxmXFuXr2Ugtv6JHF
         dA28OEOXLxAMT93HhFnfI+Zj9KIDqpZqJF+YzZwGkcO1hRXf1BI2FP444eiWHtXAr0bX
         5rSN2pwTJHLNTmlqv6GDirw5OQrfUtwRBpP/rFfT8fvhBXUC+urPNV439iHphcKRi+7l
         4V6EcWQqYYER0eV0z553sQt+/4/0RQ8hZJ2cS7unfm9Is0T8BnFUHyn51M52MsRiPqIC
         rLaA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ39j6/aZkavxt+WFNJBCvEl6jfO3/fYZshpno6D/+YBmzZEk7ToDEAi5jPeYngelNmB6txRoDEKAACZGIT/tho28=@vger.kernel.org, AJvYcCWohUk4DqfNRgE7KNo0tIV5YlXBrO27e/xPIPw682adOIzcVJrU/W/LmnQgBNijkwOT0jg/T+n7/yh21cGs@vger.kernel.org, AJvYcCX2CsrIGHzBhMRq+KlKNy77zZCnL5Ew0pSqqiIz8H23ZVa9mu10LGTbxZTzeNxGWf2hqMl3LvUBZLFVUEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZOaiI3/rv8Chwd9FuoHsjGH187M6YuQR0kQMsNXgYdetuSL7B
	L7IrEFdmr3O+FKcFT4o3Ep1jpMDNpxjkCxfXzpwwyJ/T3Z3/k1kz
X-Google-Smtp-Source: AGHT+IHx8m5Rh7j/5EvSb8iyw4iqFyvGjBYIsaCoOfj5/TDhu7GqeDaaSEwRT+ZXgw+5d4BzV8yi4Q==
X-Received: by 2002:a05:6a21:31c7:b0:1cf:351c:ff8b with SMTP id adf61e73a8af0-1cf351d000dmr3644660637.21.1725786592145;
        Sun, 08 Sep 2024 02:09:52 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e5896e10sm1821439b3a.31.2024.09.08.02.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 02:09:51 -0700 (PDT)
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
Subject: [PATCH v3 0/3] tty: serial: samsung: Serial fixes for Apple A7-A11 SoCs
Date: Sun,  8 Sep 2024 17:05:09 +0800
Message-ID: <20240908090939.2745-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes issues with serial on A7-A11 SoCs. The changes do not
seem to affect existing M1 and up users so they can be applied
unconditionally.

Firstly, these SoCs require 32-bit writes on the serial port. This only
manifested in earlycon as reg-io-width in device tree is consulted for
normal serial writes.

Secondly, A7-A9 SoCs seems to use different bits for RXTO and RXTO
enable. Accessing these bits in addition to the original RXTO and RXTO
enable bits will allow serial rx to work correctly on those SoCs.

Changes in v3:
  - v2 did not declare itself as v2 in subject line... resend as v3.

Changes in v2:
  - Mention A7-A11 in the comment about changing register accesses to
    MMIO32.

  - Use BIT() macro for new entries, and change the existing APPLE_S5L_*
    entries for consistency.

v1: https://lore.kernel.org/linux-samsung-soc/20240907111431.2970-1-towinchenmi@gmail.com
v2: https://lore.kernel.org/linux-samsung-soc/20240908075904.12133-1-towinchenmi@gmail.com

Nick Chan

---

Nick Chan (3):
  tty: serial: samsung: Use BIT() macro for APPLE_S5L_*
  tty: serial: samsung: Fix A7-A11 serial earlycon SError
  tty: serial: samsung: Fix serial rx on Apple A7-A9

 drivers/tty/serial/samsung_tty.c | 22 ++++++++++++++++------
 include/linux/serial_s3c.h       | 24 ++++++++++++++----------
 2 files changed, 30 insertions(+), 16 deletions(-)


base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
-- 
2.46.0

