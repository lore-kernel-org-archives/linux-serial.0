Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B336C257
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846933; cv=none; b=TNLSTB3PwJ4x0gOTFp/kMYu5e9DJZ8bDg/kNljN4p/ZL9T28EAHtnzW930ymmYRQWqNlNNyuYyQQg7UG1LOWq8OCrxPU0d+A8GBa6qrTAyx6iY8bzboSDLfH7QGcuUUn+bRk6CqRO4a5r+106przoGCGjyeh66r2IS/8adtcKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846933; c=relaxed/simple;
	bh=E38nvu7KZl9ndawJz1k+ZLfO2UIk6shCOOTboPNO/UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDxliWoZZXIRUschJRlAIWiUARjskU5ze61QFRelbx+oxw2wXnI8LRujvHStuj4Y9S9DWhC4BJUHmBd8spuosLnNuz1SxN5Z27/6ly0M39FQyVA+cXzyGm/zKh3wrQSLJLxwfD93Y7g77VG0njG07iLSFWznyoEUHGd0kXOvolY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRkeRV1T; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRkeRV1T"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee130237a8so915400f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846929; x=1762451729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gzjCSWSDa5dSUjUZXovzi8Fx64Uy71ap0+jFlPPV2w=;
        b=cRkeRV1T5aFp6KPNiZh69cIJ8Kc8DTiNNNAn+YjTJlvGD82sQCnWquAAqvJUhUSWeq
         /MPtMh+uCAzNi5lOgP3gwQMeXEX2tIb6u17t3a7iohPBJ2lsWPSBvqVpgAnV9jCDsOBI
         VP0l+T6/MGrA4X8WCjop1uv9hctGon1gcYFUc8C1eyCS57AHo7Ewb+mNmA7+g2qExbbn
         vcdI5wHLUtCd3Id1HvcXYB5As6or42bk57xIOjSPYoQdobpWiLmGNfq/gnQhlEis5NfO
         ByX+onyrwszfNHaG3RXHb/2gNMPdjd/zpg2tEPH0wQs65oLZCNGBpwF8+qhTfddhBWcL
         o7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846929; x=1762451729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gzjCSWSDa5dSUjUZXovzi8Fx64Uy71ap0+jFlPPV2w=;
        b=V+WLBCGY04BIVNGmZJgDR9Y92aYqrU8jri4MbdjHiUiWQn9rWnITHdovjaOeOBhwLd
         YWaW5PlnfjKR29hxn4D7GKDglboeZFttSFMchil8h/yky1hxidSe9OA0i+1bUmVrgXIt
         VHMfShEt3bjtprDOIzjE0DFZgcJgCxYeM2xxCNgwFmm+tmHNysVyrY7Z04c9ph6k776O
         ikbT/cLTB669PHzEOP9Yhu0EXjTL/SfcBUuZGLj1QWA5X4xRo1Pwhdt2hJJFTfqm7LrS
         sn6QmTKRARa0YpDxHrjUZ0GsasIxDW0VYAy0O2bxAu7WNSOhbUlf9iIApacxRYls7f23
         ylIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDy0IUPNpVWZBAwGP2V1Wra1YCbsPDfw595X3j5ghrlttp8wRbdeSOsGKv06XbZIa5GmWlkbMWifIRiw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+yUSc2i9WYu0LHhuE8pfW2WXsV++NhsuSIhKaPQjOHp5PJ/v
	fpnWeuKnIJRBS9gl209/wbUQ6qTDPSU9+rrIenrCUodhl2tDDTiY7x/G
X-Gm-Gg: ASbGncu0dY1jjEeo6x/ee2/cwuDeJxgfO8QHsqHK6xTmZ43O7MXG079fODHj9ahzezu
	KM9q9Ksuz5Q5SC7nO3Odua9fhPOFyv7qru0tdm4efoOv5A637fLVZm+XK0DWNC5uFggQWorDnTA
	w6y3IbIl1eH+497KtV94RW9fhN6Uxg1Bq0aO8vH6ezV+sYsBU1E2TNd4koHNgldF8sOUcHoP5m3
	9se51Iiz72j466Y6BT8oi7pI1kzJ1vt2asIJySavj+xG3oNBL/aFa90bNMnpd3MxIzDxQ10x2k6
	PriqzMWB+9e7xpNWZ7T02d5OJjaaZP16dwpiUIpdySdtEinD27ThtKFuKstYqOEEYYYourSBEmC
	QufvRSXhyQOBBsKrFimL4jjAtjNYJ6sjNGdUWBpHQl8xmWQyiW8BKqBR/hUKixMg4rcDVxXDZR9
	otPqqmXemMQQ7K08we0aCia6Stn/FJbHtN0FAXv+A0js3skzUyClI08hba98nM
X-Google-Smtp-Source: AGHT+IFvVMZpr26r2oMzIBqKA97uZXvamh5HEXytVmPS+yPwKWlEnWn5bt5lEiXlmDbS5Rh6odZSCA==
X-Received: by 2002:a05:6000:1a8e:b0:429:8cda:dd4e with SMTP id ffacd0b85a97d-429bd6ada5cmr389977f8f.32.1761846928726;
        Thu, 30 Oct 2025 10:55:28 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:28 -0700 (PDT)
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
Date: Thu, 30 Oct 2025 17:55:04 +0000
Message-ID: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
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

