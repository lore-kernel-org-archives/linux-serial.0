Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8E32549B
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083200; cv=none; b=u/Rj2rXlZDk7ntca3o8FPuIhQ4zsQqgTpO5JBtE7acGEGJ21KO0eTMR7nmE+zV9DiiUl2OycxjseEgTDkKbotrBppSplW8F21GrlizywxChkTG5JEJU0E43miD3bZpG+mzztam1ELar/K5+79FZSV+4bQjI6PNWQhUXmnUitHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083200; c=relaxed/simple;
	bh=0xS8K78DjTAzkXCfcjF18wm5OY2Tpz1uHDPV+jX+Zbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AS/p9g0maUp4A2z6wDO68C8YW7+6RrlgH2vkeX6s/0KweCrc9egHqpAjwFw02v1PGx5Uouyt4pqa2o5BplKhYDgZQjzqVCDSrFzmA7UdBb83B3MFlkhQIrpjVf/K/TOuMB9hCf73YwRwqsQ/5LpYAt7qifLXE6KS+JItYSt8qf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUcx4QPs; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUcx4QPs"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b387483bbso4269453f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083196; x=1764687996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JcCfv4Yq0kEBneZaO35f9OMACA2LwGKSwaRGO36V1TU=;
        b=NUcx4QPsH4760Lms5/eFDvxDYkJfQtNjUPrfXdiKk1YciNoyzy/avqrwvfZikAqBMp
         Ia/26ymhhVcqItoXfuZnrpNcOml3ObHIQr9qOhch845HCaqB7xZn1Zsu/RoUEfR/s2A+
         L4GnJvDTbqLH34S2LXuZASd3kDFOqrgXhDA/BAFNEUDReLcx8s9hrWl9ttjksqSeHIue
         mS7cxu9e5qASJeqgdM+B9ecfkBFngdTXeSKu8P20/fMEI9NR+NPxVXwwaOuL/ybYQgyQ
         uhE9GNQsmEHTPlpmaa2/gMttvXNOVrXlHzQefY5v35NRPHwl/0AyA0mw5HMSu1ns0P4Z
         Zd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083196; x=1764687996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcCfv4Yq0kEBneZaO35f9OMACA2LwGKSwaRGO36V1TU=;
        b=VsvcE4s95b+Jj8pyQHpHUMd+p5FSve4ixingyNIF5XsIEMgkDfQCb4X05+MQwxFn05
         kaR0k3mVq2TUjWAaQOtF46VFAu8zhMzNXKTpskUiz65J1f8o6lcc+kACpC5z2iinq5fy
         8v80cW2yJbzJ91qmXYVmDjphbUCwbGwN5ogVJezlehwDkmuMcRBn1LrM3DnDatT3tce+
         J8W4fS3uY9fVZNxpLwEaaC97Vc7wDb4IlP8iYFxmu6AiNWNv6DliZ+ThPe0ItiOypFoc
         TBkVq7wGOMjQa97KEO+brtsxdBusW21U8Y3xpP8c6HV0/n+scHmR4qti4ujpK9qYJvq6
         9dVA==
X-Forwarded-Encrypted: i=1; AJvYcCXhCnIUoertYR3fD8K68grTzGJ8fpwUrGQVSy1DzI7Uh6qtjUTGkuw4pkRi+jKqL3wifUQxyohfYtNwmyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyheEpYfKGbqL0Vevk+vzhubYjgvbxYUh8pWl6zrkgWWpwQepdI
	gusFeb00Qjs86fH+e+MujsbZQdxXO6ZTPyyemtaNgx4ZyIbDhIbMYsQR
X-Gm-Gg: ASbGncsGKXbdXJTqTDfkeM5JKH2ktMobgwi9TQUl+wRGRdGjh59IZJuMInF8I7LITvk
	p4sBnqlmfP0GphE8wJzimHl2NMCAUpB5d5KLasxLHr44KxdrdgcNVVp7NrepmcANBy+KCqM8VKa
	iqA98rEkgZ02z0g7Vu7qMLuvIMnPmKElQvPeWgCmRpxPwYXTpEqPjG1pj4d0vhihT5G6rey1psO
	44O1VoSIlALRqukX+vlIaiOdxlp8WyOzNUWisaCDIdfFQletGMMjButIcqtHiY3DlmdOrIkv5QJ
	E8yFS5eTCJcVoHfxuOSJkxt7h7sDeh7SBMZ8lCtzjnM7BpVq6xGeCaUJEDOThaVY/Z9Q9UnPt8Q
	DSuiVq+jQ+NeL5BgoNR0xs7oSv+KxKNcZ4nOgoqI0wgvoaokyikUimnFyeIMbpmdTsV3HUoUXNd
	mWg3akd1yAyM5auUaYsnjp8w5IZG4Seaz4eC+0oRw3/7vygrFHSIN7156IIWGrjaxtn19So4OK7
	ZB/QVa6c3tN4OOJ
X-Google-Smtp-Source: AGHT+IF4viHI0TJFa2C5jwvYIFiGsGwcUn6t+vH/eRa8epQGnhvHI+4IHs360MrFe1ff3k2apj9zEw==
X-Received: by 2002:a05:6000:401f:b0:42b:3d9d:c5f8 with SMTP id ffacd0b85a97d-42cc1cd8ee0mr17498582f8f.6.1764083195643;
        Tue, 25 Nov 2025 07:06:35 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:35 -0800 (PST)
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
Subject: [PATCH v4 00/16] Add RZ/G3E RSCI support
Date: Tue, 25 Nov 2025 15:06:02 +0000
Message-ID: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
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

v3->v4:
 * Collected tags.
 * Dropped separate compatible for non-FIFO mode and instead using single
   compatible "renesas,r9a09g047-rsci" as non-FIFO mode can be achieved
   by software configuration.
 * Dropped the non-FIFO mode support and will add this support later.
 * Renamed clock-names from bus->pclk
 * Rearranged the clock-names tclk{4, 16, 64}
 * Added separate patch for sci_is_fifo_type() covering all SoCs that has
   FIFO.
 * Updated commit header and description for patch#{3,9,16}
 * Dropped rsci_clear_SCxSR() instead of rsci_clear_CFC() as it clears the
   CFCLR register.
 * Added separate patch for updating t2h rx_trigger size from 15->16.
 * Added separate patch for renaming port SCI_PORT_RSCI->RSCI_PORT_SCIF16.
 * Dropped enum RSCI_PORT_SCI
 * Replaced the enum RSCI_PORT_SCIF->RSCI_PORT_SCIF32
 * Moved rx_trigger update to later patch#16.
 * Reduced the checks in sci_init_clocks() by avoid looking up clocks that
   are not relevant for the port.
 * Added separate patch for updating early_console data and callback()
   names.
 * Updated rsci_type() to drop "scif" type instead use "rsci"
 * Replaced the compatible "renesas,r9a09g047-rscif" with
   "renesas,r9a09g047-rsci"
 * Renamed the port enum from RSCI_PORT_SCIF->RSCI_PORT_SCIF32.
 * Renamed of_rsci_scif_data->of_rsci_rzg3e_data
 * Renamed the funvtion rsci_rzg3e_scif_early_console_setup() with
   rsci_rzg3e_early_console_setup().
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

Biju Das (16):
  dt-bindings: serial: renesas,rsci: Document RZ/G3E support
  serial: sh-sci: Add sci_is_fifo_type()
  serial: rsci: Drop rsci_clear_SCxSR()
  serial: sh-sci: Drop extra lines
  serial: rsci: Drop unused macro DCR
  serial: rsci: Drop unused TDR register
  serial: sh-sci: Use devm_reset_control_array_get_exclusive()
  serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
  serial: sh-sci: Add sci_is_rsci_type()
  serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16
  serial: sh-sci: Add RSCI_PORT_SCIF32 port ID
  serial: sh-sci: Add support for RZ/G3E RSCI clks
  serial: sh-sci: Make sci_scbrr_calc() public
  serial: sh-sci: Add finish_console_write() callback
  serial: rsci: Update early_console data and callback() names
  serial: sh-sci: Add support for RZ/G3E RSCI

 .../bindings/serial/renesas,rsci.yaml         |  82 ++++-
 drivers/tty/serial/rsci.c                     | 304 ++++++++++++++++--
 drivers/tty/serial/rsci.h                     |   3 +-
 drivers/tty/serial/sh-sci-common.h            |  10 +-
 drivers/tty/serial/sh-sci.c                   |  78 +++--
 5 files changed, 406 insertions(+), 71 deletions(-)

-- 
2.43.0

