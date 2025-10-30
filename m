Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A6374AB3
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847097; cv=none; b=OyiBEtT3hJvNfUVB/az8hcCS37EHx2qlTgac/aLL39XJu2KlmbcQv4gAEtYVaE7hH4UxomzaiTKfMdydzbvxb0OlcVVgTaBo/4w0bmu7gNYFmuABoS6cv93cm6iqSlaoHI48ae4EZziNBGTeWjHxccndjte2ge8xnWEx4X0ukQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847097; c=relaxed/simple;
	bh=E38nvu7KZl9ndawJz1k+ZLfO2UIk6shCOOTboPNO/UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pTBC6DMdH7h8F30xiMBdKVgjKYbK6fmLnALkvsS/muKhyfQ2O94DNfthRMaIsJegG2Wt9DcctUCUbEVE+3T3X2XpqS3e9KcxGVl3XfO6i/vWIF1Frukk6YDYacOjERS4qxgu4c+EsFj8z/JTqWG99bKRvUeS388wTEQ900DnQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJGrP9PG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJGrP9PG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso9731985e9.0
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847094; x=1762451894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gzjCSWSDa5dSUjUZXovzi8Fx64Uy71ap0+jFlPPV2w=;
        b=mJGrP9PGkzlNtIXEiWsi+sxSdDg1ESINGqHdxXWAJ9jBz5H7QH+DCVNHuy42+dUrCv
         jTNAWxeGlHyDEbZPMcD+InDUAqzhYW5ZQS+cwnHOEDGE/+Y0QX0Ems/605ONS7nG0ssU
         EFg9u7hXhzN0IF3TlOeI6ZNJkbm7x82gLnwsTiM4/cNRD1ury9AZksWTrwJoRXYwsnTi
         wtu1X8CvQouyv3SJq/8kEP24PVbWb7CZ+3GHFojXYgC7rTxkdvEpfgZsTZePyGTFhpa0
         3fiSE3DanTE+GkCYGCSilW79kBdTwldKmDHNlU2fKMDEe6LdZjetQRWe86tfamR8hz7s
         oDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847094; x=1762451894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gzjCSWSDa5dSUjUZXovzi8Fx64Uy71ap0+jFlPPV2w=;
        b=Crqt7lrtclaKcVFqjNtuBtcMLVHYP6D5VD1DoXjISFgn3rKmNVkeCcHvC3ALf+pBAK
         LV4CrhhVFgJ8kl5efH+xkF8OtANE+WQ8DjAWf3KAvEw3KZzAlzOsvQWc8CrzkzJ+hw0o
         lzyzMa4DJKEkLrC/qARfMzj7hgZPFBIHwkYOAjT05ntaxxMD43FOLPJ5YU6sxyPlij5V
         BCJa1V86VMQqTYXOFzGzqNa5MlbXWCCUXjPhTHKiPtye848Fw09ajMxVPyIEb4mAwptp
         70UqAN8rVKgCVcfYt2znwKcBRFX559Uh0WXSx0/K7Pr4i2lwZM6vsWqAbwxGPbysUKAi
         xcAg==
X-Forwarded-Encrypted: i=1; AJvYcCWDBxKMAmjYIE9nwLvnr0S5DfkFiuGFmaMTm9uKGv2gF/3LriDPWjv8Vh36D1t0njsJA/E07Jcg6UjBes4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJgoz8l3RPwOjZabZ5/tdSFBNEzU33pRC8kTHq8BaNXQUkXbce
	XBoXWWJcp6tBLitShtuEIZGunjTrhC0neb0j+aDTdaqSD5hv2swuREpY
X-Gm-Gg: ASbGnct7s7ElJsQsYnSRJFhKeTIk2cMmC6c/ILBttdZEz4/RBCeH9TZx0PqHVE/jirA
	SREmxDyvDaQpBqyGBOOCOb3saxZj1a6mqoX6sM1RYfvCC6kREJ3M6TcWX4SCwiPAYfO64fqg8vX
	qh0sLI0xOOsHzUwbd8mUQWCAeP5/qeq0/0QrpcpusQ+ZFCX0a+IPi9etDeige0k0YdQXz6yKa9i
	zFy2UMRttvuL40W8pbwGZq8TZq+V41sFINnnvYv2d+KJduQNLU1wPLIeLQPQtm9dpIaE8IY1Gd2
	5rdqnsok66mQ2uZukm/StFq7MEmWrxoHK37XTk0cJUB2Uwd6CTPAef9kGDB8/4d/7CUjDi4PQoG
	fRKo79oEaxobucBuRa7WG+lmICV5oEZfWXlmhN1EJBsT8HqaRbr1aq+QiCU508oNQ1hGwJoX3G5
	VZ2Cb31v2wyPqBdtn0wWcDcZnVJry68w5OwPPjSPR8O2CvkGrCdqJFqSs4xLkvIpd/nnOPcqY=
X-Google-Smtp-Source: AGHT+IHdSgxpcXTfEej5U8BldtuGHfSvdPoMRqZKYxWXFAr619pzocHitxlzzBZZ5iYo55mAH9lB0Q==
X-Received: by 2002:a05:600c:3b2a:b0:475:dac3:69a2 with SMTP id 5b1f17b1804b1-477308b0611mr5390475e9.27.1761847093974;
        Thu, 30 Oct 2025 10:58:13 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:13 -0700 (PDT)
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
Subject: [PATCH v2 00/13] Add RZ/G3E RSCI support
Date: Thu, 30 Oct 2025 17:57:48 +0000
Message-ID: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
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
[1] https://lore.kernel.org/all/20251029082101.92156-1-biju.das.jz@bp.renesas.com/

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
 drivers/tty/serial/sh-sci.c                   |  67 ++-
 5 files changed, 492 insertions(+), 83 deletions(-)

-- 
2.43.0

