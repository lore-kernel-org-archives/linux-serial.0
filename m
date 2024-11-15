Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148201CD21C
	for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678254; cv=none; b=u/hWK4cnTp5lGvN4ZzLiaBQkYCu6DfuBHC55crDcemNB6Dv35hKwLD2esXE2GppRyi2BaJ1klrHWVeZlHeinwPjbdtO2TSPjrPRosN6Yx72wmzOKIu+hoaI8DhLSDGFB/1Z7fnMt23DyiwutpojwP0Yh8i+6JKaUlDl0TFEYokY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678254; c=relaxed/simple;
	bh=sc9CTLdGF8akXnnEYKS+FLO0ZLiAdZAgjw2Zn2YLkZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E96j/MSki3fPptxT+DCbQhO07PtRSpl/+ZHe+D8QnkwTQ9Z50Ftca80VImZTc52QxcQCi2FDZy7Bnpnay+LeCEOM5HfopvLBolRtDxeDEOyNMURoKeK8tY/IS0d+qhhq3vFUqVNq11m5dIFB+HpAQYOrwY8PqIiXL7ymPfNt/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cZ6QPHRw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cZ6QPHRw"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3822ec43fb0so165772f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 05:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731678250; x=1732283050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5y0VsPSk08U7p2tqXaJQIjq2ov8qkIzEO02XgcshlA=;
        b=cZ6QPHRw2v9fRpfq/O9//sWF/iUaj9Tg7mO9Ecb7J6ul5a5b+RXxskLp/OOidKjuxh
         lZnx4zRwmLEW8veeZ2koSbUbiP+PeGOVEWLSCT4wTUG+e4SJyy1IWTtJUA9AazGQvDnD
         qdfKQdU+iqrAaSsg4KljC+3bO2tyOFObyOMGEhbqjQNwssbumBtqa8YFi4U8Wovo7F8x
         EL5jhNDWgI06viNMpnXDvl2uXsAu2/bpUpyB884NPC2EAg1y7RYfTRHwNiaJf/ZiIAwn
         247fP8Ewh/Ehb+4p3noMczXFuwPmHPTsYhLVYuL4L9hQUvFNOZHVJoB8j2BeUFZsE1PX
         NyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678250; x=1732283050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5y0VsPSk08U7p2tqXaJQIjq2ov8qkIzEO02XgcshlA=;
        b=MOjuHBNRXCggKsktSOOSsbaXFKRa0lDGf48vLgoOBSAu0UMihRxxKpbosgUF3KUJKr
         1UO15wh5GxqD5jsZQAhZ++Jzzh48xE6uZfJtewNoPtFihFuoJEerrZhwEDfzRPc9pGnc
         P09+ViShFsEiyu9+B//5ndsc58+3ndIcN4rdtf/yDkvwZPgZvAM0By+Z6O7Dcby/bUzT
         9TuYfG886x+dVTFG2Iv1mpRWa7DEq/HDu+63/zYjn7kZrIs1kc6uurIsltlagSjAEsf+
         59kUHud5xFzOv2Sl/iVmvDpibJL0qutoanQMfUyQa9luGVj27NnDnTUy1KFKUSIaj26e
         xyZw==
X-Forwarded-Encrypted: i=1; AJvYcCW7z1iMOyVI3dYLvofhgv1IecWYngRM8tjosyRt5yN+IlUd3KtXxKVTlrAEFbHYSaPkNAa/2PQotbIGSbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxItQFV5gGyEfJ9KfZ6vv7WQQiHRdPp4Enl4tU4Kze5q0IOPoSg
	VOb+niFMv1NTyyzDP5KYyeSU7ENCprkj9Bib1iAPjUk6E603ka5pNZ7YoUhMcDg=
X-Google-Smtp-Source: AGHT+IGiHMG9rqSM5bsbyK7EYOKL8gBTuBz9Z6IzT33QoBCun/jgIVK6Zf54KY6LeEKMlhUGRk6A4g==
X-Received: by 2002:a05:6000:1866:b0:37d:4f1b:35a with SMTP id ffacd0b85a97d-382259020f2mr2182114f8f.3.1731678249494;
        Fri, 15 Nov 2024 05:44:09 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3fc9sm4378016f8f.20.2024.11.15.05.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:44:09 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 0/8] Add support for the rest of Renesas RZ/G3S serial interfaces
Date: Fri, 15 Nov 2024 15:43:53 +0200
Message-Id: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

The Renesas RZ/G3S SoC has 6 serial interfaces. One of them is used
as debug console (and it is already enabled in the current code base).
Series adds support for the remaining ones.

Patches:
-    01/08 - adds clock, reset and power domain support for the serial
             interfaces
-    02/08 - serial driver fix patch identified while adding RZ/G3S
             support
-    03/08 - extends suspend to RAM support on the serial driver for
             the RZ/G3S SoC
- 04-08/08 - add device tree support

Merge strategy, if any:
- patch 01/08 can go through Renesas tree
- patches 02-03/08 can go through serial tree
- patches 04-08/08 can go through Renesas tree

Thank you,
Claudiu Beznea

Changes in v3:
- in patch "serial: sh-sci: Check if TX data was written to device in
  .tx_empty()":
-- check the status of the DMA transaction in tx_empty()
-- changed the variable name that tracks if TX occurred

Changes in v2:
- drop patch "serial: sh-sci: Clean sci_ports[0] after at earlycon exit"
  from v1 as it was already applied
- used bool instead of atomic_t in patch
  "serial: sh-sci: Check if TX data was written to device in .tx_empty()"

Claudiu Beznea (8):
  clk: renesas: r9a08g045: Add clock, reset and power domain for the
    remaining SCIFs
  serial: sh-sci: Check if TX data was written to device in .tx_empty()
  serial: sh-sci: Update the suspend/resume support
  arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
  arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
  arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
    different switches
  arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
  arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1

 arch/arm64/boot/dts/renesas/Makefile          |  3 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90 +++++++++++++++++++
 .../dts/renesas/r9a08g045s33-smarc-pmod.dtso  | 48 ++++++++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 25 +-----
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 32 +++++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 25 +++++-
 drivers/clk/renesas/r9a08g045-cpg.c           | 20 +++++
 drivers/tty/serial/sh-sci.c                   | 79 ++++++++++++++--
 8 files changed, 288 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

-- 
2.39.2

