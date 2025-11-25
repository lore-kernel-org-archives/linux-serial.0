Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95011328260
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083210; cv=none; b=R0POXz1IpJcIi3iyIZzt8YMenqRDimwxc5UbZRQufOj6HIedyksKJpJjqtkF22MYkOWruKubkWgPtbO2KI9//N6D2SfTtdy2056F6DlhKySnTauVkTFrCixVgyHaYKwvbpW9K47/QJHh4ZZC56LR9HsjteM/zFzbLcvqHDLw7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083210; c=relaxed/simple;
	bh=Et690Nyk+pHGvb5l80zTzY2XD8G7Ab7SHaBdICOlCHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MP+7E+izXibtqHMmtlCfiHdhVDKNXUd7IF4+ych9MFfDuSnyqOXF363aIIo7R1/jzNVoQRZ+/RxGbv5qxwx/w2WgBeAjsEb87dTRtn5S4AaHW2NiX8kSfKXuBMHslZWrzyceHpf2FbQ5KB2JNSgjjHTb4kFMGqPRtsNdpUI8RjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQWPqBOo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQWPqBOo"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c82bf86bso3305626f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083204; x=1764688004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uBC2MlE1HUaPDZb990/KasBIbCj5RriVOgSLly0aqY=;
        b=DQWPqBOoJqbCl4InN4YsYk4GG0gcpbFXaVbWrzpY70oq9QWn6AC9I4FcdYmSQ+PHUI
         TVHbi+1DzZVhuSyo1p+fg3ft6Bd3YeTyB2LadK1U/LFnRYIh17RhQbBHujgpRwiEIi1Y
         grzcuPydxVzW/1dsBBSIQbSjmzOMCL8PbTvwbuyrPnC2GRTY4wCJI9XYO8qnn/AlXIG4
         8moDXTCUvyZYGmlboBT1Bi5rTSLqDVw7N4JlZviAGQIPHb1AtLP9NkWkOJdUN9P8m9/4
         eJZzGCS7vhz9IBkMx4/z6dP4X+8PTHs9XpHDiu0HM+dzyZGnp/XsGndA/Brdd523hi1m
         SX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083204; x=1764688004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7uBC2MlE1HUaPDZb990/KasBIbCj5RriVOgSLly0aqY=;
        b=nch+LyQg2XaWSAVgcJG7Oe7BLr1lCofnAC5lDQbscB74HNJxA9uJR8wJDyjXexOrj2
         0MC/RklZzkMKfNoMyKJlnUadiweT/8neok3QikcWPCI46op7AkqirZru3xEE0lTdmBdT
         avAbqErwiA4PZybz2AoUyLgGA69PRVnLRwveuJ3EzJjo492xshMX4w2NgrifiLRToWf5
         YZKxN/+cnMRpDfyQSPFdRfdNYg3GZ96ksBzVgaGMxN29J7cLc2nfT+uZPlKjv3It+D+C
         VTkWFQoLEih8qScfOsNk5W7VDvVlU+MVqjxB/jktaWgMDMbVN52uhEVs4iS9s5N584lu
         q8Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWIKgqJhznsOdQZnY6QRpSkMcax4wajzT5OUoicBVU5brzmCo2bSfvkeom1eW8TSJALA9M4XxNwjWFeTbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEN2O9raX2grvLtIoi/5eucO0BdZ3neA8kGypA9TLCbKYGE8Vi
	JNHMhokHVhB/uDAnO8gXJdodcWe1rta5e8I9jVcG+r6PZ+j8xYBHxYHE
X-Gm-Gg: ASbGncsHNh1IdDh5BF8UozewuXlfIFRqMnQTpSTkPbofKLyXgyryG0vxS6IkcBzepcV
	aIHqnx7NudU6qIfgOHWP5LEx2lh2/aw+2Vv6eV8UWvrXu+wLIS7QWxi1r+QqS1pBVm5+16h4hT1
	3rO1JONLRIkmfG4FbkqGzFJnfOUXVWdaXvyV513nu3EfljvfXdd4u+CwUYUWaKbOfP79LtdBTMr
	CxEjNeqq/80HBEnCRRS01G68SP2GhYxP1GY9v7SJ3KuXF/aCkABRCLvCtmJI/g4+/vBgM6C+Rqm
	xUrsm+YskLslbO0Lsd+vyOWHERaTKEQ4Tj0UFhDH0v1xKegPmKond6pIuor6x41vhWuxAkIKhqc
	CGtg0Z4S/06owOCV7fCfXzyNAbGf1hywDdeQFtGE/SJEKDP8bCRSdRYq0WRxRqHc3a+Yyjg9FDp
	s/ON8W7g3bJzjbmzWkgvpgd0J4NvKbdYQd82VV9Ogt1TLlQDwSfro7DJHEnkufBBnVEosUKFjNA
	ypNBXl0XdV/WWS2Nd1jsqBf5To=
X-Google-Smtp-Source: AGHT+IGhwA2qdHgjK6YzJJeEkagwt4swWh4uBsW/k/KPMyocV9syebEZD5VRePRYGEoDb7M2JT1+hg==
X-Received: by 2002:a05:6000:1866:b0:427:580:998c with SMTP id ffacd0b85a97d-42cc1d0cf60mr16904982f8f.43.1764083203740;
        Tue, 25 Nov 2025 07:06:43 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:43 -0800 (PST)
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
Subject: [PATCH v4 11/16] serial: sh-sci: Add RSCI_PORT_SCIF32 port ID
Date: Tue, 25 Nov 2025 15:06:13 +0000
Message-ID: <20251125150632.299890-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
References: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G3E RSCI IP has 32-stage FIFO compared to 16-stage FIFO on RZ/T2H.
Add RSCI_PORT_SCIF32 port ID to differentiate it from RZ/T2H RSCI and
update sci_is_rsci_type() and sci_is_fifo_type()

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Dropped enum RSCI_PORT_SCI
 * Replaced the enum RSCI_PORT_SCIF->RSCI_PORT_SCIF32
 * Moved rx_trigger update to later patch.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 1 +
 drivers/tty/serial/sh-sci.c        | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 1b9480c7f4cb..abcd5bcc7c36 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -8,6 +8,7 @@
 /* Private port IDs */
 enum SCI_PORT_TYPE {
 	RSCI_PORT_SCIF16 = BIT(7) | 0,
+	RSCI_PORT_SCIF32 = BIT(7) | 1,
 };
 
 enum SCI_CLKS {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 08a1898f14ea..9afc3b8aae91 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1184,7 +1184,7 @@ static int sci_handle_errors(struct uart_port *port)
 
 static bool sci_is_rsci_type(u8 type)
 {
-	return (type == RSCI_PORT_SCIF16);
+	return (type == RSCI_PORT_SCIF16 || type == RSCI_PORT_SCIF32);
 }
 
 static int sci_handle_fifo_overrun(struct uart_port *port)
@@ -3548,7 +3548,8 @@ static struct uart_driver sci_uart_driver = {
 static bool sci_is_fifo_type(u8 type)
 {
 	return (type == PORT_SCIFA || type == PORT_SCIFB ||
-		type == PORT_HSCIF || type == RSCI_PORT_SCIF16);
+		type == PORT_HSCIF || type == RSCI_PORT_SCIF16 ||
+		type == RSCI_PORT_SCIF32);
 }
 
 static void sci_remove(struct platform_device *dev)
-- 
2.43.0

