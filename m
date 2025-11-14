Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC531328F
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117529; cv=none; b=gF/4mXIiPhufYAmIE5jSoBZCaf+TI7mQ28Kuw7l5FWY5XfPPf5XawXAihoK4rRS9l+DWcX77Vj5TGKbXZMrZDVrLXTrQBPHWnP5gGcV3wyac5Vsqs7qlp45awY48zJ0Yxew0ceqf1vDHd4K4AM22SeUW0RXCocUAW2ZPkuz9LO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117529; c=relaxed/simple;
	bh=Zc48rn3Gh3wyXoGNOzH25ymkeF9Nxkl22AZ2QQZQW40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qWPUmkm8MnI8cS4Q1i13rn9Su2gEY4M+nHEB3vG1gnKPegQtE084jjidOEE6A7+LO3LFcy1G+afd3Vgtf4VV2H25EkwxvLlKm4RrMe3OxZYdV68TaNAEdBvzLbQDr7W+FVtTzO4COJWUGN1C1qufy+RH4l0I5eSe4CxmFFtYsr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrogVsBa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrogVsBa"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4777707a7c2so22620655e9.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763117524; x=1763722324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjwR6/kXVzZn7yjf+PWc3qHx8PvUc69d8LlxS1kTA+I=;
        b=WrogVsBayNd/jlC+2JkDdNeUYEIQotbpUNQQ5e/vSYKjSI0zuUj29wJyyH/K/VTV2B
         hmoF9AD1/LgXmbJgic1ntCsMbsC8TH8RUyUGg/iXRqpdoSirQaA+PNhbzihsD0AQ4IBF
         oiSDQWNQLXUphkupqS1mWorLuPr5y/vHq9KPw75CbHMLEK6OFJk45YkmyD1ng9b/wY3S
         RiF2XREq4G2jBmyOs2t4UcOfwkSUQ+JOHgv3esPTlvlb89ZqEsB+YzFlzC1jiSE7E9/0
         1jbECzGwjazdrmEYNHgi3isI/hnNhHCzgHQ0eaWLXEptdQkqXBG2qvdLvFbHXrxvdme9
         TsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763117524; x=1763722324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjwR6/kXVzZn7yjf+PWc3qHx8PvUc69d8LlxS1kTA+I=;
        b=l34+0opBKoamULjz0cLlrTx6xNV1SF21DguINQTBxcF1FvGMflE1GOuh4qxrZlnqPa
         oygFsl5b/CDYOXdHmT2I132p1tVApJs94Ien5A+gpSMWr6TfRmq3QP1CgMvncPHJQDzW
         QlSue8Zp852zeSrDLyQqep/7UK7NfP8PuCksYTG0S2SGOXx93/cgAZqFrpSGhr2AtjvL
         HMh6krAZCaS0csJDC0Kw7GReWGuf3Lyyu6SR52hAffuSYBqf1H3zla97Kbs9OtW6QP/V
         JmykVLAKE9CHfOP6aqkpUBO5sF7lEjQEExP7UPoPMEdUsU9DPoVgF3NgiMxssT3mCb0I
         kfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjs0Y8MG/uJydR3JqVPdEOHJETzMyjnnUBOk9dPbu0pfbJjNSKc/5ATJ47cWpR5cYEKMItNno5jiQaAUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzynrXqKRQVepzdXGn4i78MJTP5zB5e+CTUH5MTxgRRbG5WSTt6
	JgMzoj8hSO7MMh0gpHzE5lkEpPuFE0boAIo5Y/5MbIROcQozCWr1oSvU
X-Gm-Gg: ASbGncuHnG0bc8Th44f1ioeB2sCYktfLHpU6OEuPGlWBHZNvGVFiI1EM8Nkzd7liLnJ
	gFb5/BNwb5OWNAIoKoIvgZWLOwlu1b2/j9wiwWEgDlEcFhvttH0t5zXGR21zqnbDjFNV6mApa0A
	OrFWdy2fGCiVVfzD5pC1SU7UTVWUzIh4rgSYt17/pGAtNEWuQrHtxNS78/fTy8aBq9L4fd3JmAr
	6CizyiuwETE3TjG0JPqpcvtZ6/QuU7S52Uh1A5N4k+Y/XcMABaULeU6fJqbL3TTFR25CmUjhMp7
	rSe8H2pR25aXeCa2EAOVhKEOLWHHSwJZAR8dGeP4YpQjglNTiuaWa86sW3gAS23WuL+xhICmZZ8
	VdORG2hCQs4WDwoKY+/rcvEXyC939H/AWHK3GMYqPSWwaGt7RmL9P9BmdyU/yNoipa6lBmmQtaC
	r10szrUpQPj8xjzNjFejB5nuVXlTBJLfS0HI29pnOo8t03CcIZdt0CmuAx9rP5mgB1bLCN3OkvR
	inlTszqqJozKipDk0NOMWTq1wc=
X-Google-Smtp-Source: AGHT+IFGMe+dE5yo8EXauIb30wbc6Mj9yI1wBet8gXWiAgeJIUmxWa5RddlufYT6TUnAfj2nfMN9Ug==
X-Received: by 2002:a05:6000:2911:b0:42b:32d1:28ae with SMTP id ffacd0b85a97d-42b5282262bmr6112243f8f.22.1763117524062;
        Fri, 14 Nov 2025 02:52:04 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm9031255f8f.35.2025.11.14.02.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:52:03 -0800 (PST)
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 00/13] Add RZ/G3E RSCI support
Date: Fri, 14 Nov 2025 10:51:09 +0000
Message-ID: <20251114105201.107406-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E RSCI support for FIFO and non-FIFO mode. RSCI IP found on
RZ/G3E SoC is similar to one on RZ/T2H, but has 32-stage fifo. RZ/G3E has
6 clocks (5 module clocks + 1 external clock) compared to 3 clocks
(2 module clocks + 1 external clock) on RZ/T2H, and it has multiple
resets. Add support for the hardware flow control.

This patch series depend upon [1]
[1] https://lore.kernel.org/all/20251114101350.106699-1-biju.das.jz@bp.renesas.com/

v2->v3:
 * Dropped 1st and 3rd items from clk-names and added minItems for the
   range for the binding patch.
 * Added minItems for clk and clk-names for RZ/T2H as the range is 2-3
 * Added maxItems for clk and clk-names for RZ/G3E as the range is 5-6
 * Retained the tag as it is trivial change.
 * Updated dev_err_probe() in sci_init_clocks() as it fits in 100-column
   limit.
 * Dropped cpu_relax() from rsci_finish_console_write() and added a
   comment.
 * Added sci_is_rsci_fifo_type() helper for reuse in probe() and remove().
v1->v2:
 * Updated commit message for patch#1,#3,#9
 * Added resets:false for non RZ/G3E SoCs in bindings.
 * Increased line limit for error messages to 100-column limit for patch#3
 * Updated multiline comment to fit into single line.
 * Updated set_termios() for getting baud_rate()

Biju Das (13):
  dt-bindings: serial: renesas,rsci: Document RZ/G3E support
  serial: rsci: Drop rsci_clear_CFC()
  serial: sh-sci: Drop extra lines
  serial: rsci: Drop unused macro DCR
  serial: rsci: Drop unused TDR register
  serial: sh-sci: Use devm_reset_control_array_get_exclusive()
  serial: sh-sci: Add RSCI_PORT_{SCI,SCIF} port IDs
  serial: sh-sci: Add sci_is_rsci_type()
  serial: sh-sci: Add support for RZ/G3E RSCI clks
  serial: sh-sci: Make sci_scbrr_calc() public
  serial: sh-sci: Add finish_console_write() callback
  serial: sh-sci: Add support for RZ/G3E RSCI SCIF
  serial: sh-sci: Add support for RZ/G3E RSCI SCI

 .../bindings/serial/renesas,rsci.yaml         |  85 +++-
 drivers/tty/serial/rsci.c                     | 412 +++++++++++++++---
 drivers/tty/serial/rsci.h                     |   2 +
 drivers/tty/serial/sh-sci-common.h            |   9 +
 drivers/tty/serial/sh-sci.c                   |  72 ++-
 5 files changed, 496 insertions(+), 84 deletions(-)

-- 
2.43.0

