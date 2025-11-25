Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC90329C74
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083211; cv=none; b=ultlFLNU5S0WOyJ950xXR0DGYgtcT4RK++x2lgfgV669Wn9Mvs8Ohabfp4mGRPAeo9PnH07ZMMML/zkas7nJ7TKLwqXJezZcN+Ph+MQ34x/O1Ygat8WgFL96D/WucmLiLdtiSZX5SJoYFze9oI8ab0lYZylWVqKb8zqJ+XQspp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083211; c=relaxed/simple;
	bh=GR7AQUFCcqvPF/xmvO64o5WNJi1uyjJFb8FwxFAhp1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jkmq9anpCLgrhLve9/xNNDGw96mZk0W+WpLcr2OEzLFtQlJ5KycgG/7UAmC9eYTqpleC9qv1ZkCuYJJAvvv5QlZO4m0C7Vpvy3ZdQd3UVyACj32dCz9ncd1JSTWT3nbSI3ZyrfTr9X6t+3crok/MSavHtRHDyUR/ow8HcUnfmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJhQh+PK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJhQh+PK"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b31507ed8so4770928f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083206; x=1764688006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMdMTt+JFYnpGbbPIGHe+o50cDdqqdMvbBY5niAClpg=;
        b=IJhQh+PKAQVk2UZj0tVZJtV7EIedRqB6V2K0f11CfavvxedcfOUCM4vMjDjeKMdHA5
         wg5gjWtOgCgRpKNdVCp7gYWVRpXN0fdBsAwff2Ddhd8YNxt++w25j2rs8dnR/OYByWA6
         BCrtDwMLXrEe6pVrInos5ruHmTtNyXx2cWL5GL3IOz9BRWpUu0qaZ5RRpIax3TTRO+rs
         q0ayWyjcLcJlRRpWFvT3HsnijUGVOMv3W2eZ5Nup+sWEMq7mPWhg+mRVJGOBvz3I8f/+
         N9svwtKji7GE7nCAZOdEJ+EWe04ubPgPChNuGD+ChsIpaHjVvM+n/R/JVfD/fsjuhsmR
         ha2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083206; x=1764688006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PMdMTt+JFYnpGbbPIGHe+o50cDdqqdMvbBY5niAClpg=;
        b=FxdMviaCL1q3D20yumkyu08NnpGSzPCo6OkZa2yUF1omi+JSaMP/VXILDr6e9R1b/q
         QMfX10OKG+9z/TKG9vyNC3YeMU6R6Mw22YRjhnf+hUS7OGGd7KvpSntfNyySK5VcAoOD
         KnHZ4HxUN0RjHmxUS8OGrkv9h2GzCVbFoUQ9tfdeWv3gskiEbZmB8uQ4yP5ow7Rdyp++
         Yucn4ABJa2O6PRzo75+l+TRyWYzsPuYM/5RNHQdPuYfbaEZhHeW//gKFZyhc5ZMtApSX
         hYX0uZSvQuH2AfOTdT95pDpWYKaXYDqbLItt2CyyiHj4s1v9+C/gkkxbMS1BR+rl78QZ
         QAkw==
X-Forwarded-Encrypted: i=1; AJvYcCVfr3LOAiaksLOEZgCFz5ZT30+yJBhVlBqGXHcmwaAa9iTA6RD6Qwz6tjXbG5l2EPjiBajDmVSLIOCJhCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Ffy9rZn6yf3RNnVmXbUOnsKLFu0EfgJegXRciH6zBFUbVWC0
	gNgVV6lndH4KngC5rTh9IrZnUMKE2373wgDNKEW/RhV316XonTljb4rw
X-Gm-Gg: ASbGncuamnYw17ZxNaNY57udeHsVr/lde54rhB/bhJEvrVR6OxPlQFLzNNeKNB9zxyQ
	RHfnpOouyzURA+tdcVGOAd6sDZ/D5elIuds6UJF8ZHsCgz2Ess3fNZWJkrxIkD4mBpFy169UZx+
	uGrKwQaWAyz8FYTVCs9ZxoGmOY5NNDhenIjfo5u+xtOLp71fpXGemlLzEdxrv21dkwC/quA21Gq
	7R/8QVOa5hhU3c9P7QhJo1+prALq71U+Bj3oQ6BO/9ovaWzFkebmG4lyDvTRY/mVE1eFx+GY6gD
	R8nR/ywacAPbPmwhNVH6peO5BU8ZaVhTEAosJqh7auK0/6EtGDwafHAFiIm3atYEYvb9QzLeGE6
	lL2+axo9Bi9fN9Ue3s89AWIvpXrQBZPov3HWe+nGEZtFIjqCEMSovIT3fTEPFR2maWAT/1RbLzs
	kIilG+IVBkPdfPPFjkufcGl/F/B5uK9Z/VNzz2ZFvDrtKR5PqNmyhruUIxZ6bhqWhmexPipG8FV
	Q==
X-Google-Smtp-Source: AGHT+IFuWiI66xvhdjHEr9Z1CmL3fFUvEFoM5WKfaDkk3t2aGCOFdyz4xMINOhVkrmyybZo0cqY9jg==
X-Received: by 2002:a05:6000:26c1:b0:42b:5592:ebd1 with SMTP id ffacd0b85a97d-42e0f133696mr3679548f8f.0.1764083206283;
        Tue, 25 Nov 2025 07:06:46 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:46 -0800 (PST)
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
Subject: [PATCH v4 15/16] serial: rsci: Update early_console data and callback() names
Date: Tue, 25 Nov 2025 15:06:17 +0000
Message-ID: <20251125150632.299890-16-biju.das.jz@bp.renesas.com>
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

Update early_console data of_sci_rsci_data->of_rsci_rzt2h_data and
rename rsci_early_console_setup()->rsci_rzt2h_early_console_setup()
to support RZ/G3E RSCI that uses different data and callback().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4:
 * New patch.
---
 drivers/tty/serial/rsci.c   | 10 +++++-----
 drivers/tty/serial/rsci.h   |  2 +-
 drivers/tty/serial/sh-sci.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index c5d373ee494f..f6b61f33358c 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -444,7 +444,7 @@ static const struct sci_port_ops rsci_port_ops = {
 	.shutdown_complete	= rsci_shutdown_complete,
 };
 
-struct sci_of_data of_sci_rsci_data = {
+struct sci_of_data of_rsci_rzt2h_data = {
 	.type = RSCI_PORT_SCIF16,
 	.ops = &rsci_port_ops,
 	.uart_ops = &rsci_uart_ops,
@@ -453,13 +453,13 @@ struct sci_of_data of_sci_rsci_data = {
 
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
 
-static int __init rsci_early_console_setup(struct earlycon_device *device,
-					   const char *opt)
+static int __init rsci_rzt2h_early_console_setup(struct earlycon_device *device,
+						 const char *opt)
 {
-	return scix_early_console_setup(device, &of_sci_rsci_data);
+	return scix_early_console_setup(device, &of_rsci_rzt2h_data);
 }
 
-OF_EARLYCON_DECLARE(rsci, "renesas,r9a09g077-rsci", rsci_early_console_setup);
+OF_EARLYCON_DECLARE(rsci, "renesas,r9a09g077-rsci", rsci_rzt2h_early_console_setup);
 
 #endif /* CONFIG_SERIAL_SH_SCI_EARLYCON */
 
diff --git a/drivers/tty/serial/rsci.h b/drivers/tty/serial/rsci.h
index 2af3f28b465a..9547148e8bd1 100644
--- a/drivers/tty/serial/rsci.h
+++ b/drivers/tty/serial/rsci.h
@@ -5,6 +5,6 @@
 
 #include "sh-sci-common.h"
 
-extern struct sci_of_data of_sci_rsci_data;
+extern struct sci_of_data of_rsci_rzt2h_data;
 
 #endif /* __RSCI_H__ */
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ee26ffc4632c..e7d4cac39906 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3672,7 +3672,7 @@ static const struct of_device_id of_sci_match[] __maybe_unused = {
 #ifdef CONFIG_SERIAL_RSCI
 	{
 		.compatible = "renesas,r9a09g077-rsci",
-		.data = &of_sci_rsci_data,
+		.data = &of_rsci_rzt2h_data,
 	},
 #endif	/* CONFIG_SERIAL_RSCI */
 	/* Family-specific types */
-- 
2.43.0

