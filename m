Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9D1DE4E7
	for <linux-serial@vger.kernel.org>; Thu, 16 Jan 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051785; cv=none; b=eIVNpcOgRSGyhEq0X6CA2s9DXGAtP7uPHl4gKTvzxb61t76kmMSOeXFdCiWFIK39AnuXvaxuA1iklTlgCcyx+w3Nz7YHXpOJlrZOHC3KiUyfbZQdLc0qd0DC9nDcJfqlrwek6/Djs08ZQTAdFV6SUGzA8zsCGp9fdudVwE9qkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051785; c=relaxed/simple;
	bh=OwX0MEmBGHpg5bhCw6tUfaBb3F/xkJXnfYSkUVfbveM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qWh+DwgHLH0opaEV2OXv+EVU/Cjt/C0ndkm6XtNQ60bl4WsfTu6a+c8NTCdfYqbwvj7GYcuA8ryyrhW/CIl9FUIq9VBPSXdT9yxFeeoYZTLKyrI2I6+kuiTh7GkXU4UM4mqDTQRbohgdlmiVUCGVw0/ngOUEsqBMLQt6ew/LVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Z0Rz5TdH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Z0Rz5TdH"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862d6d5765so778348f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 16 Jan 2025 10:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737051782; x=1737656582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aAPRbHfyxaeTRN6at4Eq4c1feMoRRI7T6P9QuC4/ttU=;
        b=Z0Rz5TdHRKGhTLOAJxn/42V3gN1gcLgEwff+vtouyV68DqVH0k5w/grIT5dY2QiU1H
         DZf/iqghLqhvuIJhpQhvqX34Fln2AnJUdVLHo4LDyojTtFiQZk2eoSKL7PnDNbcVB9si
         FvtUzuKfh37fvnoxl0XL3kc/qgG1fPovr8Md32JlOFGassSwt1yhyPKZEZ4XenqcqlbQ
         JRlz7c4lInolx5uJ9xgNtmK8ozr3dgJy3uXsxCvoaOjrvjAoG2M7ckJfgEmDObepDWLB
         3jupFTK4khVlHoS5imaSZrsZhZSG3tm9hdEcie/ihpKJyBaSvDGJ9OUccgM5jWPz0X+I
         71Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737051782; x=1737656582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAPRbHfyxaeTRN6at4Eq4c1feMoRRI7T6P9QuC4/ttU=;
        b=He9mokNptDoQeGMOV8vYIr35sJ+W2ichACQyTL0NRwayHt0sSIrPQyv+R6QPwRaBnp
         zkvWCiKwxBqQGotVlk+x/nFWvtIenqQU4zApNONYIZAgyQoKkNBF3MG0KQymX0Irn4Fu
         QK7mLHSm964jVY8nUHA9UMcUnhEgHTeUnAGh5ZaCp8wsaI+t8lv16sjQs2LQFxeQwsg3
         P4pqVK6HoKS9TvixXHWk/gFwoOfM7QrAWJJ2fv5+CufzQcNpPTcHqFXrPMtqGUw9LjYX
         N3xEIvym22/KLQCRIcc6WL7k47+wdF5lyUb8IkxVp6gasrirvS1OdO0gPPdrV/gb6IPN
         pxkw==
X-Forwarded-Encrypted: i=1; AJvYcCUcLnaF9ugYxiWvn7KoHIAa4mvLzo2w/ob3Kpy2UGzSDcINgkwCUT3e6UkLQ2LYhgnCWMlD4VfDN9A3jCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnzhzRRsDHdmprhw6gWwwWsAW9ylqfUKrgm+QPodLxiD86Sji0
	aMeVeIQNwkfSUKGlbh38H0hFf12CPJniA+TLlTdDOhMERoFhUuNmlyTudNyYJos=
X-Gm-Gg: ASbGncsCJCFoSuk4i5Nyym5qYJsKlLa1Q72tL4Nsz3++lOxtB0WCdB/fGkBsHGLDAkR
	/QEB5IrfOyMhsPqzV0o82PExEJyHoVSGOu6jT/CnrGH1m+rP89ryNk+vYPk11dupSSe1Mu7YSpD
	iYtH9L6pL3EAYAGZc5aq8b48CNVbIu30HCMnEL3t0B0pZqFEIWc1OEKoJ0MVIgeTvSYpSlQupTp
	xZNc+tglLRwUltDEglShfllGuhI0lZN6oZbUh8w9xeEej6hrRZLT3WbbMW3INZDnO4gl5ZGcMDE
	F0/d1t4bEg8=
X-Google-Smtp-Source: AGHT+IEbbWS+5FcmutXAoXuYh25F/7EUf2rywm4G8Zg7Ww6kMySq2k45dMXvPOz2eIXImkYcoRwoOA==
X-Received: by 2002:a5d:6489:0:b0:38b:da32:4f40 with SMTP id ffacd0b85a97d-38bda325049mr15381555f8f.2.1737051781547;
        Thu, 16 Jan 2025 10:23:01 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322a838sm495942f8f.48.2025.01.16.10.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 10:23:01 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert+renesas@glider.be,
	wsa+renesas@sang-engineering.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ysato@users.sourceforge.jp,
	ulrich.hecht+renesas@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/5] serial: sh-sci: Fixes for earlycon and keep_bootcon
Date: Thu, 16 Jan 2025 20:22:44 +0200
Message-ID: <20250116182249.3828577-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series adds fixes for earlycon and keep_bootcon on sh-sci driver.
All these fixes are prerequisites for the Renesas RZ/G3S SCI support.

Series was tested on the boards with the following device trees binaries:
- r8a7742-iwg21d-q7.dtb
- r8a7743-iwg20d-q7.dtb
- r8a7745-iwg22d-sodimm.dtb
- r8a77470-iwg23s-sbc.dtb
- r8a774a1-hihope-rzg2m-ex.dtb
- r8a774b1-hihope-rzg2n-ex.dtb
- r8a774e1-hihope-rzg2h-ex.dtb
- r9a07g043u11-smarc.dtb
- r9a07g044c2-smarc.dtb
- r9a07g044l2-smarc.dtb
- r9a07g054l2-smarc.dtb
- r9a08g045s33-smarc.dtb
- r9a08g045s33-smarc-pmod.dtb (not integrated in the latest kernel tree,
  but the device tree was posted at [1])

in the following scenarios:

1/ "earlycon keep_bootcon" were present in bootargs
2/ only "earlycon" was present in bootargs
3/ none of the "earlycon" or "earlycon keep_bootcon" were present in
   bootargs

1, 2, 3 were tested also with renesas_defconfig on
r9a08g045s33-smarc-pmod.dtb.

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/all/20241115134401.3893008-9-claudiu.beznea.uj@bp.renesas.com/

Changes since RFT:
- dropped patch 1/6 as it was applied
- dropped RFT tag
- updated cover letter
- collected tags
- addressed review comments
- the changelog for each patch is detailed within the individual
  patches

Claudiu Beznea (5):
  serial: sh-sci: Drop __initdata macro for port_cfg
  serial: sh-sci: Move runtime PM enable to sci_probe_single()
  serial: sh-sci: Do not probe the serial port if its slot in
    sci_ports[] is in use
  serial: sh-sci: Clean sci_ports[0] after at earlycon exit
  serial: sh-sci: Increment the runtime usage counter for the earlycon
    device

 drivers/tty/serial/sh-sci.c | 93 +++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 19 deletions(-)

-- 
2.43.0

