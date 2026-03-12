Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4E35836F
	for <linux-serial@vger.kernel.org>; Thu, 12 Mar 2026 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304036; cv=none; b=sfdT4o+fTy+Ka+Fq+wq2qeDPSYpy1YdAU5HHr+Ib7hgZt5jjXLEDX/Cv+4brrV4IUGhglikrqyprfhRua2Q20UJh8K3Q+EWcbsdwZ178DjqNkkUup18uELqVSeaWR+V/OAmzzpI5TlcaFqUWmxOlkbXOpHvKtwWHkuvsv9gtKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304036; c=relaxed/simple;
	bh=2s7KJHfCNTkqHvJe31CzyIYb79Txh6AnisrHsWvUMn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQRyfpRjUAROiJirRKaYSakXF6JIZNMI/OPSdDLtvOPkiG7Qz7ILitToOkIVVMJI7MamO0TNqhhl4Q1GsXzWkwNHfm6qY/7I3QGqcPeLv/aoPMcvteuJOn4nhBXEUh9Jq4+vRpjoJtjlTYcPtx/v9A6Gl2V+1qW6Oz6j9XF3b6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+ISZxFu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+ISZxFu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so8797065e9.0
        for <linux-serial@vger.kernel.org>; Thu, 12 Mar 2026 01:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773304033; x=1773908833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QdLoYf8XGVgA51ppjmyMKkwFN1LFowzvdfEVBXq+KOA=;
        b=Z+ISZxFuksn6zEhqdGu1YVw1nApjXkOw8MTk9TN321ECzzAjDEiTV0vC3jsZvrew4m
         uWQEzUTa6YaXixQG/Ab9SQviONhaCL2GCoUh21Z6l78adqCHYwoC/gEm5VcepafPgSHn
         Walgx4oZjxjodTzNjdOQYOfzJpJbF7oWLncC9rhMNegF3PTR/TtIqXJQ404qn2fzFhqT
         kt6Pplb4LUjILOX7wfaRI7vcufm6p9TmHWcsRqtdkfywZfLakHVTTNQsfWLkwCzOrmTg
         WVHRJXNpzR/Dbrve7H7N4yIaGS7AZC1SO6IPjqQbu1Oh3NliHftCoG/NquqPfqBDokVl
         anDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773304033; x=1773908833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdLoYf8XGVgA51ppjmyMKkwFN1LFowzvdfEVBXq+KOA=;
        b=hqFFvNGJfYeZsBNhneSUhk9XeYyvJZnimroZifI9HQtANdS6upviRvcGFEpD83bUvL
         mI5lJHX+Zr8qHbza8Tsq74CKDT0T6/6xSJg5eApPnckBNsIMAyfMGBHuvNpgy+jRRruD
         1IdlP24yCQW9VURfoykjZUru+VvynOzKvxFuL1ORUJW7rCClcScauY0b6rSeFll2Q2K5
         D1JnRdUzOcMI9OEpc8e7ihrUCo/OIqla481iLZ04Y85kpUmorQrknNW0EHJBgLZmz00U
         GDkov4KQpLG/jsjbg47atF9bXVt/i60yXOjG/E8JN7aDn+pxtGHvv07tXM7SmBCSgUjS
         UtgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw0t4Ogfqf1YcNXA5DeKVKU2DyLTOajRl0F8edqCl/GFN4NvHjZJxxSbdopunAcg24Slr8gDZbN/oEc6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywau9KFwOuh1hzz+guX53qsiRjEH57UZnhuNxXU945Ih08lxmCr
	CiQiDUGmatWXbFqevPeK3/gDjPMRV0BuFNnEo8v8Bxfo5AB9rdrJa8We
X-Gm-Gg: ATEYQzzezSFaRKsw3rmJEAndxuwi9FIqMZq9N1HLxgWYiK4Vc70Njc3EFUUvNZGT3ug
	KFD9jAbzHml7FLEicC9GaRf7zTDmIDeGmkDG6Qhk9a4VD0NxvCzKpbSxzGo35LbOulMo+nKC9Br
	r7ZtHGlqXW4EiMbTB2Qrh+x4QAFC65hqb3R6thCgAtYQ5+yG9kk3sHpBUWY+qaPmVA5bAYQtkwT
	BgypHUFMOaNEbnJMyPnR0VzxBo7wVLrCAJiDvLENLdbFBX61hxbzbi4TIkYznmgvvbuk2GDGyLB
	BlW59m+eEBWae66JnBcEQETSR/mtkm+PDAxM5fSLkFNBM4EqQxqneYFAVDdwEyapJh2HYsO2n9Q
	HobD4FYXD/Ut7/3B/L+N6C4HOAgi/+JQwGrFHVOttOXUAvn7BJC/8juJmziCBnTu7pLRSnL+EEh
	hPJTJ5Ao+2yJcJ09eowfxMyLfs7PXYm42259VNy+TmMNRK+hE=
X-Received: by 2002:a05:600c:4e43:b0:485:3fd1:992c with SMTP id 5b1f17b1804b1-4854b0a6a05mr83785605e9.1.1773304032389;
        Thu, 12 Mar 2026 01:27:12 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2eea84sm65925065e9.1.2026.03.12.01.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:27:12 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 0/2] Add support for RZ/G3L RSCI
Date: Thu, 12 Mar 2026 08:26:57 +0000
Message-ID: <20260312082708.98835-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for RZ/G3L RSCI. The RSCI IP found on the RZ/G3L SoC is
similar to RZ/G3E, but it has 3 clocks (2 module clocks + 1 external
clock) instead of 6 clocks (5 module clocks + 1 external clock) on the
RZ/G3E. Both RZ/G3L and RZ/G3E have a 32-bit FIFO, but RZ/G3L has a
single TCLK with internal dividers, whereas the RZ/G3E has explicit
clocks for TCLK and its dividers. Add a new port type
RSCI_PORT_SCIF32_SINGLE_TCLK to handle this clock difference.

Biju Das (2):
  dt-bindings: serial: renesas,rsci: Document RZ/G3L SoC
  serial: sh-sci: Add support for RZ/G3L RSCI

 .../bindings/serial/renesas,rsci.yaml         | 26 +++++++++++++++++++
 drivers/tty/serial/rsci.c                     | 13 ++++++++++
 drivers/tty/serial/rsci.h                     |  1 +
 drivers/tty/serial/sh-sci-common.h            |  1 +
 drivers/tty/serial/sh-sci.c                   | 14 +++++++---
 5 files changed, 52 insertions(+), 3 deletions(-)

-- 
2.43.0

