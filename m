Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A137646B
	for <linux-serial@vger.kernel.org>; Mon,  8 Jun 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938057; cv=none; b=rta+5uvOnYimV7RtamGJxIXvK3nfFVKZMQI8EvDAs3iMq0n3LIx5253LGULerLcEbM6KjfGnsuUXsnOa6uWo/Y4TmsWFek5Xpd15CVyfoen6+JQCWAGYRjy2hiOcgNAIJLi54OACAxtR2nXqc7r2omKspiU+1kTeq/HygfAu3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938057; c=relaxed/simple;
	bh=vH7oRE/xyr/DD3vMG6GIhHfyNPPu/4QWrh/k+cyoNaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nn/C1bx7qGLE1UbLZkMlbhi9rZNCph+PejJOoqKlMJMCsomerNPevButr2ZcBo8JEbuMpUoiQKxseXfUvJRQAx6GFVcSqj1F41H2Zu2hvKHVPfFVUyweDuCLsLvtvIM/JOjxZC3aDUOm8Phd8ff2lOfEDDJLbSMccwbjw4dPUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RGRFQNHq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RGRFQNHq"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4602e2a0372so3228236f8f.3
        for <linux-serial@vger.kernel.org>; Mon, 08 Jun 2026 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780938052; x=1781542852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=03XnFIQf6j3H+NegtfJePBsJTOqs5Ho9hPA61uYQ//A=;
        b=RGRFQNHqdFF2oQ5ICaznXYxBkJ+d2sU2So7OTUTBGgxNpv3j8qm+NeBZ4dUTEerphD
         0buIMlyfeTRn6v0XmuvBy7IOLAM7Y0eLL9tbniE/fjetqJjE+mjK/dw+z4gNIRtUB9EL
         Wft3cgy2/TElmjUfZ7xpfGa2We3WO9WEDIPMEzeogEm9I2BMw/5O2gC4h6bXVAqN5n/m
         1o1GpsI7mQdGX529dbRftawSCPDe9rEd37QlBCpQk+PrUDnjwOg9HrZz9ujwf9sAxQFX
         n3cIhJ8K45OxmnG+2sBIotmq3dGLdOG2pG/UElQ67iT8RfurEeBqefWImO0RK4rp2Vhf
         LoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780938052; x=1781542852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03XnFIQf6j3H+NegtfJePBsJTOqs5Ho9hPA61uYQ//A=;
        b=RkKF5eFvNr0b17bhnrmt5wyv/aaN1gFV2iZND/P44Y2Mb3Ve0XD6sucAafj9oYnJME
         Yh7jFdY5lmheMQjRrmNwQ8+qF68/wVCAfGdC+D/3KYzUPCyt4yPgujhH5JG5T4XWAwm8
         TaNYW7vf7sHjPwTKmRFDfjtPuN7Rtps48wmstRLVDJTufdrHY/Yg9rUlEtUFXFALX6L8
         2zNHcEonxWBvuVYvevYcFcQSB5exElkMPZTEqvU9uc5x/K0gvsUG1auho5o74Hranju4
         i61CdF/lvIBSpnUL6DhjOrKAKW28B/O+PdSv4ixOu0hjWawKimeixU1VYNwe4kq2BxGv
         F24g==
X-Forwarded-Encrypted: i=1; AFNElJ+M60TQ9ZFEXyL197C2fygagL7uNcxxhyoR/k0Xt6/HP+Eh/JjZTuL9qv5+0DDA3v9JO+8spb7WznTHKVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3KgtRaPkmfTGuEqQeOZTsFnWg3/QsEQa66m7001r/a16Ap3K
	B9XS6Vd0SfXASeudnhlUMVPfHEcVkkLVz7bk1BEUQfdRALnEDNtM8pojJrMnoP25jbc=
X-Gm-Gg: Acq92OEdCfYZ3V3jfGjWzmxDV11n1NdUBBcsX57b7bf9vbyNu9UuIfHg3momT77UA1R
	qg1LxRNqpoaWywY3hbJHEqrI0lz9/mcZ9j+Dt+K1yInx0vw5B7EiZ8nqR7TpVySqwJ/z4D81KeI
	MA0G952AOLA0kSotl5yK40x1+99tEFP4pDEo/D35n45aD45pSV8Dzoqq4+FwHSv4ni5JL+K5Bd2
	NBWepX5dzaTJB523BEusPb9TdhrPrhCXmq8MpYM2Dq3iDD4od4K+hkifgail5LP51BTHNAHTXP5
	UEloHhQgR0iORoYYEDOu8PzMtlpM2MY+B0DgvolxSgU09yK+FPYtyUoMO1HM1AJ8qrLt+siXaY/
	GfKr5yB37VpaWLHANEgdj5rgCIo85YjUzE8n2SGccIZEiQrVCo8jvyZ0lW86ePOsh59qi5/ZYoy
	G7txpwq8dGxwQPc8lsp7TpHwTCOw3nPfvfVEnHcRHCTTKVLMhKPf8yZMQkGHR9kB1ZOfXL0Zutt
	cQotGM9S/M5+Vqc60g5Sf4=
X-Received: by 2002:a5d:4384:0:b0:45d:b14b:23fb with SMTP id ffacd0b85a97d-460304fd053mr18808768f8f.11.1780938051906;
        Mon, 08 Jun 2026 10:00:51 -0700 (PDT)
Received: from localhost (p200300f65f47db0401cbe8320d4b8cf2.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1cb:e832:d4b:8cf2])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2dcad5sm59252634f8f.5.2026.06.08.10.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:00:51 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_pnp: Drop unused assignments from pnp_device_id arrays
Date: Mon,  8 Jun 2026 19:00:43 +0200
Message-ID:  <dfc218a0e9265e9459df1c5bf621db12be5c551e.1780937987.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=18470; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vH7oRE/xyr/DD3vMG6GIhHfyNPPu/4QWrh/k+cyoNaE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqJvU8wENw/4rV6N7e/DXiCuvPeFQzNa6HLKT0E 9l+aYG2KMGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaib1PAAKCRCPgPtYfRL+ TrGUB/4o9umCRbWdZdb/sU/DbIw8e82rzPcXhKQ2hK6fWKi5F0cLQbN9yoNaaYOf8DEPsNy9NkN nswyjAzBUK+JH/TdOuaLpRbWcUK5wiGQ7x1ZY1oVR3ahZEW5VnTFgTo67r76+IXlk4sVysP7bzL I+NtN8Epzs7wjESbhSGvdTtUcCTWWvLRc31KPvaWxkN7LHmHcqhXPZe84sOwMVPqjsgVe8Y4Ft5 iU3zSZBZjm/gETq6uLjhdtrAWK0mUPxUJxsjpmiARfajODW2nB1iroTLlUzm+QHR6rDZ2q9XVDK q5QcQji/v5Bh0acFiEudQsVDcrDx80viaCDX3h/OHreiyHUc
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Explicitly assigning .driver_data in drivers that don't use this member
is silly and a bit irritating. Drop these. Also simplify the list
terminator entry to be just empty to match what most other device_id
tables do.

There is no changed semantic, not even a change in the compiled result.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 308 ++++++++++++++---------------
 1 file changed, 154 insertions(+), 154 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 7a837fdf9df1..850709bb4a73 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -28,351 +28,351 @@
 static const struct pnp_device_id pnp_dev_table[] = {
 	/* Archtek America Corp. */
 	/* Archtek SmartLink Modem 3334BT Plug & Play */
-	{	"AAC000F",		0	},
+	{ .id = "AAC000F", .driver_data = 0 },
 	/* Anchor Datacomm BV */
 	/* SXPro 144 External Data Fax Modem Plug & Play */
-	{	"ADC0001",		0	},
+	{ .id = "ADC0001", .driver_data = 0 },
 	/* SXPro 288 External Data Fax Modem Plug & Play */
-	{	"ADC0002",		0	},
+	{ .id = "ADC0002", .driver_data = 0 },
 	/* PROLiNK 1456VH ISA PnP K56flex Fax Modem */
-	{	"AEI0250",		0	},
+	{ .id = "AEI0250", .driver_data = 0 },
 	/* Actiontec ISA PNP 56K X2 Fax Modem */
-	{	"AEI1240",		0	},
+	{ .id = "AEI1240", .driver_data = 0 },
 	/* Rockwell 56K ACF II Fax+Data+Voice Modem */
-	{	"AKY1021",		0 /*SPCI_FL_NO_SHIRQ*/	},
+	{ .id ="AKY1021", .driver_data = 0 /*SPCI_FL_NO_SHIRQ*/ },
 	/*
 	 * ALi Fast Infrared Controller
 	 * Native driver (ali-ircc) is broken so at least
 	 * it can be used with irtty-sir.
 	 */
-	{	"ALI5123",		0	},
+	{ .id = "ALI5123", .driver_data = 0 },
 	/* AZT3005 PnP SOUND DEVICE */
-	{	"AZT4001",		0	},
+	{ .id = "AZT4001", .driver_data = 0 },
 	/* Best Data Products Inc. Smart One 336F PnP Modem */
-	{	"BDP3336",		0	},
+	{ .id = "BDP3336", .driver_data = 0 },
 	/*  Boca Research */
 	/* Boca Complete Ofc Communicator 14.4 Data-FAX */
-	{	"BRI0A49",		0	},
+	{ .id = "BRI0A49", .driver_data = 0 },
 	/* Boca Research 33,600 ACF Modem */
-	{	"BRI1400",		0	},
+	{ .id = "BRI1400", .driver_data = 0 },
 	/* Boca 33.6 Kbps Internal FD34FSVD */
-	{	"BRI3400",		0	},
+	{ .id = "BRI3400", .driver_data = 0 },
 	/* Computer Peripherals Inc */
 	/* EuroViVa CommCenter-33.6 SP PnP */
-	{	"CPI4050",		0	},
+	{ .id = "CPI4050", .driver_data = 0 },
 	/* Creative Labs */
 	/* Creative Labs Phone Blaster 28.8 DSVD PnP Voice */
-	{	"CTL3001",		0	},
+	{ .id = "CTL3001", .driver_data = 0 },
 	/* Creative Labs Modem Blaster 28.8 DSVD PnP Voice */
-	{	"CTL3011",		0	},
+	{ .id = "CTL3011", .driver_data = 0 },
 	/* Davicom ISA 33.6K Modem */
-	{	"DAV0336",		0	},
+	{ .id = "DAV0336", .driver_data = 0 },
 	/* Creative */
 	/* Creative Modem Blaster Flash56 DI5601-1 */
-	{	"DMB1032",		0	},
+	{ .id = "DMB1032", .driver_data = 0 },
 	/* Creative Modem Blaster V.90 DI5660 */
-	{	"DMB2001",		0	},
+	{ .id = "DMB2001", .driver_data = 0 },
 	/* E-Tech */
 	/* E-Tech CyberBULLET PC56RVP */
-	{	"ETT0002",		0	},
+	{ .id = "ETT0002", .driver_data = 0 },
 	/* FUJITSU */
 	/* Fujitsu 33600 PnP-I2 R Plug & Play */
-	{	"FUJ0202",		0	},
+	{ .id = "FUJ0202", .driver_data = 0 },
 	/* Fujitsu FMV-FX431 Plug & Play */
-	{	"FUJ0205",		0	},
+	{ .id = "FUJ0205", .driver_data = 0 },
 	/* Fujitsu 33600 PnP-I4 R Plug & Play */
-	{	"FUJ0206",		0	},
+	{ .id = "FUJ0206", .driver_data = 0 },
 	/* Fujitsu Fax Voice 33600 PNP-I5 R Plug & Play */
-	{	"FUJ0209",		0	},
+	{ .id = "FUJ0209", .driver_data = 0 },
 	/* Archtek America Corp. */
 	/* Archtek SmartLink Modem 3334BT Plug & Play */
-	{	"GVC000F",		0	},
+	{ .id = "GVC000F", .driver_data = 0 },
 	/* Archtek SmartLink Modem 3334BRV 33.6K Data Fax Voice */
-	{	"GVC0303",		0	},
+	{ .id = "GVC0303", .driver_data = 0 },
 	/* Hayes */
 	/* Hayes Optima 288 V.34-V.FC + FAX + Voice Plug & Play */
-	{	"HAY0001",		0	},
+	{ .id = "HAY0001", .driver_data = 0 },
 	/* Hayes Optima 336 V.34 + FAX + Voice PnP */
-	{	"HAY000C",		0	},
+	{ .id = "HAY000C", .driver_data = 0 },
 	/* Hayes Optima 336B V.34 + FAX + Voice PnP */
-	{	"HAY000D",		0	},
+	{ .id = "HAY000D", .driver_data = 0 },
 	/* Hayes Accura 56K Ext Fax Modem PnP */
-	{	"HAY5670",		0	},
+	{ .id = "HAY5670", .driver_data = 0 },
 	/* Hayes Accura 56K Ext Fax Modem PnP */
-	{	"HAY5674",		0	},
+	{ .id = "HAY5674", .driver_data = 0 },
 	/* Hayes Accura 56K Fax Modem PnP */
-	{	"HAY5675",		0	},
+	{ .id = "HAY5675", .driver_data = 0 },
 	/* Hayes 288, V.34 + FAX */
-	{	"HAYF000",		0	},
+	{ .id = "HAYF000", .driver_data = 0 },
 	/* Hayes Optima 288 V.34 + FAX + Voice, Plug & Play */
-	{	"HAYF001",		0	},
+	{ .id = "HAYF001", .driver_data = 0 },
 	/* IBM */
 	/* IBM Thinkpad 701 Internal Modem Voice */
-	{	"IBM0033",		0	},
+	{ .id = "IBM0033", .driver_data = 0 },
 	/* Intermec */
 	/* Intermec CV60 touchscreen port */
-	{	"PNP4972",		0	},
+	{ .id = "PNP4972", .driver_data = 0 },
 	/* Intertex */
 	/* Intertex 28k8 33k6 Voice EXT PnP */
-	{	"IXDC801",		0	},
+	{ .id = "IXDC801", .driver_data = 0 },
 	/* Intertex 33k6 56k Voice EXT PnP */
-	{	"IXDC901",		0	},
+	{ .id = "IXDC901", .driver_data = 0 },
 	/* Intertex 28k8 33k6 Voice SP EXT PnP */
-	{	"IXDD801",		0	},
+	{ .id = "IXDD801", .driver_data = 0 },
 	/* Intertex 33k6 56k Voice SP EXT PnP */
-	{	"IXDD901",		0	},
+	{ .id = "IXDD901", .driver_data = 0 },
 	/* Intertex 28k8 33k6 Voice SP INT PnP */
-	{	"IXDF401",		0	},
+	{ .id = "IXDF401", .driver_data = 0 },
 	/* Intertex 28k8 33k6 Voice SP EXT PnP */
-	{	"IXDF801",		0	},
+	{ .id = "IXDF801", .driver_data = 0 },
 	/* Intertex 33k6 56k Voice SP EXT PnP */
-	{	"IXDF901",		0	},
+	{ .id = "IXDF901", .driver_data = 0 },
 	/* Kortex International */
 	/* KORTEX 28800 Externe PnP */
-	{	"KOR4522",		0	},
+	{ .id = "KOR4522", .driver_data = 0 },
 	/* KXPro 33.6 Vocal ASVD PnP */
-	{	"KORF661",		0	},
+	{ .id = "KORF661", .driver_data = 0 },
 	/* Lasat */
 	/* LASAT Internet 33600 PnP */
-	{	"LAS4040",		0	},
+	{ .id = "LAS4040", .driver_data = 0 },
 	/* Lasat Safire 560 PnP */
-	{	"LAS4540",		0	},
+	{ .id = "LAS4540", .driver_data = 0 },
 	/* Lasat Safire 336  PnP */
-	{	"LAS5440",		0	},
+	{ .id = "LAS5440", .driver_data = 0 },
 	/* Microcom, Inc. */
 	/* Microcom TravelPorte FAST V.34 Plug & Play */
-	{	"MNP0281",		0	},
+	{ .id = "MNP0281", .driver_data = 0 },
 	/* Microcom DeskPorte V.34 FAST or FAST+ Plug & Play */
-	{	"MNP0336",		0	},
+	{ .id = "MNP0336", .driver_data = 0 },
 	/* Microcom DeskPorte FAST EP 28.8 Plug & Play */
-	{	"MNP0339",		0	},
+	{ .id = "MNP0339", .driver_data = 0 },
 	/* Microcom DeskPorte 28.8P Plug & Play */
-	{	"MNP0342",		0	},
+	{ .id = "MNP0342", .driver_data = 0 },
 	/* Microcom DeskPorte FAST ES 28.8 Plug & Play */
-	{	"MNP0500",		0	},
+	{ .id = "MNP0500", .driver_data = 0 },
 	/* Microcom DeskPorte FAST ES 28.8 Plug & Play */
-	{	"MNP0501",		0	},
+	{ .id = "MNP0501", .driver_data = 0 },
 	/* Microcom DeskPorte 28.8S Internal Plug & Play */
-	{	"MNP0502",		0	},
+	{ .id = "MNP0502", .driver_data = 0 },
 	/* Motorola */
 	/* Motorola BitSURFR Plug & Play */
-	{	"MOT1105",		0	},
+	{ .id = "MOT1105", .driver_data = 0 },
 	/* Motorola TA210 Plug & Play */
-	{	"MOT1111",		0	},
+	{ .id = "MOT1111", .driver_data = 0 },
 	/* Motorola HMTA 200 (ISDN) Plug & Play */
-	{	"MOT1114",		0	},
+	{ .id = "MOT1114", .driver_data = 0 },
 	/* Motorola BitSURFR Plug & Play */
-	{	"MOT1115",		0	},
+	{ .id = "MOT1115", .driver_data = 0 },
 	/* Motorola Lifestyle 28.8 Internal */
-	{	"MOT1190",		0	},
+	{ .id = "MOT1190", .driver_data = 0 },
 	/* Motorola V.3400 Plug & Play */
-	{	"MOT1501",		0	},
+	{ .id = "MOT1501", .driver_data = 0 },
 	/* Motorola Lifestyle 28.8 V.34 Plug & Play */
-	{	"MOT1502",		0	},
+	{ .id = "MOT1502", .driver_data = 0 },
 	/* Motorola Power 28.8 V.34 Plug & Play */
-	{	"MOT1505",		0	},
+	{ .id = "MOT1505", .driver_data = 0 },
 	/* Motorola ModemSURFR External 28.8 Plug & Play */
-	{	"MOT1509",		0	},
+	{ .id = "MOT1509", .driver_data = 0 },
 	/* Motorola Premier 33.6 Desktop Plug & Play */
-	{	"MOT150A",		0	},
+	{ .id = "MOT150A", .driver_data = 0 },
 	/* Motorola VoiceSURFR 56K External PnP */
-	{	"MOT150F",		0	},
+	{ .id = "MOT150F", .driver_data = 0 },
 	/* Motorola ModemSURFR 56K External PnP */
-	{	"MOT1510",		0	},
+	{ .id = "MOT1510", .driver_data = 0 },
 	/* Motorola ModemSURFR 56K Internal PnP */
-	{	"MOT1550",		0	},
+	{ .id = "MOT1550", .driver_data = 0 },
 	/* Motorola ModemSURFR Internal 28.8 Plug & Play */
-	{	"MOT1560",		0	},
+	{ .id = "MOT1560", .driver_data = 0 },
 	/* Motorola Premier 33.6 Internal Plug & Play */
-	{	"MOT1580",		0	},
+	{ .id = "MOT1580", .driver_data = 0 },
 	/* Motorola OnlineSURFR 28.8 Internal Plug & Play */
-	{	"MOT15B0",		0	},
+	{ .id = "MOT15B0", .driver_data = 0 },
 	/* Motorola VoiceSURFR 56K Internal PnP */
-	{	"MOT15F0",		0	},
+	{ .id = "MOT15F0", .driver_data = 0 },
 	/* Com 1 */
 	/*  Deskline K56 Phone System PnP */
-	{	"MVX00A1",		0	},
+	{ .id = "MVX00A1", .driver_data = 0 },
 	/* PC Rider K56 Phone System PnP */
-	{	"MVX00F2",		0	},
+	{ .id = "MVX00F2", .driver_data = 0 },
 	/* NEC 98NOTE SPEAKER PHONE FAX MODEM(33600bps) */
-	{	"nEC8241",		0	},
+	{ .id = "nEC8241", .driver_data = 0 },
 	/* Pace 56 Voice Internal Plug & Play Modem */
-	{	"PMC2430",		0	},
+	{ .id = "PMC2430", .driver_data = 0 },
 	/* Generic */
 	/* Generic standard PC COM port	 */
-	{	"PNP0500",		0	},
+	{ .id = "PNP0500", .driver_data = 0 },
 	/* Generic 16550A-compatible COM port */
-	{	"PNP0501",		0	},
+	{ .id = "PNP0501", .driver_data = 0 },
 	/* Compaq 14400 Modem */
-	{	"PNPC000",		0	},
+	{ .id = "PNPC000", .driver_data = 0 },
 	/* Compaq 2400/9600 Modem */
-	{	"PNPC001",		0	},
+	{ .id = "PNPC001", .driver_data = 0 },
 	/* Dial-Up Networking Serial Cable between 2 PCs */
-	{	"PNPC031",		0	},
+	{ .id = "PNPC031", .driver_data = 0 },
 	/* Dial-Up Networking Parallel Cable between 2 PCs */
-	{	"PNPC032",		0	},
+	{ .id = "PNPC032", .driver_data = 0 },
 	/* Standard 9600 bps Modem */
-	{	"PNPC100",		0	},
+	{ .id = "PNPC100", .driver_data = 0 },
 	/* Standard 14400 bps Modem */
-	{	"PNPC101",		0	},
+	{ .id = "PNPC101", .driver_data = 0 },
 	/*  Standard 28800 bps Modem*/
-	{	"PNPC102",		0	},
+	{ .id = "PNPC102", .driver_data = 0 },
 	/*  Standard Modem*/
-	{	"PNPC103",		0	},
+	{ .id = "PNPC103", .driver_data = 0 },
 	/*  Standard 9600 bps Modem*/
-	{	"PNPC104",		0	},
+	{ .id = "PNPC104", .driver_data = 0 },
 	/*  Standard 14400 bps Modem*/
-	{	"PNPC105",		0	},
+	{ .id = "PNPC105", .driver_data = 0 },
 	/*  Standard 28800 bps Modem*/
-	{	"PNPC106",		0	},
+	{ .id = "PNPC106", .driver_data = 0 },
 	/*  Standard Modem */
-	{	"PNPC107",		0	},
+	{ .id = "PNPC107", .driver_data = 0 },
 	/* Standard 9600 bps Modem */
-	{	"PNPC108",		0	},
+	{ .id = "PNPC108", .driver_data = 0 },
 	/* Standard 14400 bps Modem */
-	{	"PNPC109",		0	},
+	{ .id = "PNPC109", .driver_data = 0 },
 	/* Standard 28800 bps Modem */
-	{	"PNPC10A",		0	},
+	{ .id = "PNPC10A", .driver_data = 0 },
 	/* Standard Modem */
-	{	"PNPC10B",		0	},
+	{ .id = "PNPC10B", .driver_data = 0 },
 	/* Standard 9600 bps Modem */
-	{	"PNPC10C",		0	},
+	{ .id = "PNPC10C", .driver_data = 0 },
 	/* Standard 14400 bps Modem */
-	{	"PNPC10D",		0	},
+	{ .id = "PNPC10D", .driver_data = 0 },
 	/* Standard 28800 bps Modem */
-	{	"PNPC10E",		0	},
+	{ .id = "PNPC10E", .driver_data = 0 },
 	/* Standard Modem */
-	{	"PNPC10F",		0	},
+	{ .id = "PNPC10F", .driver_data = 0 },
 	/* Standard PCMCIA Card Modem */
-	{	"PNP2000",		0	},
+	{ .id = "PNP2000", .driver_data = 0 },
 	/* Rockwell */
 	/* Modular Technology */
 	/* Rockwell 33.6 DPF Internal PnP */
 	/* Modular Technology 33.6 Internal PnP */
-	{	"ROK0030",		0	},
+	{ .id = "ROK0030", .driver_data = 0 },
 	/* Kortex International */
 	/* KORTEX 14400 Externe PnP */
-	{	"ROK0100",		0	},
+	{ .id = "ROK0100", .driver_data = 0 },
 	/* Rockwell 28.8 */
-	{	"ROK4120",		0	},
+	{ .id = "ROK4120", .driver_data = 0 },
 	/* Viking Components, Inc */
 	/* Viking 28.8 INTERNAL Fax+Data+Voice PnP */
-	{	"ROK4920",		0	},
+	{ .id = "ROK4920", .driver_data = 0 },
 	/* Rockwell */
 	/* British Telecom */
 	/* Modular Technology */
 	/* Rockwell 33.6 DPF External PnP */
 	/* BT Prologue 33.6 External PnP */
 	/* Modular Technology 33.6 External PnP */
-	{	"RSS00A0",		0	},
+	{ .id = "RSS00A0", .driver_data = 0 },
 	/* Viking 56K FAX INT */
-	{	"RSS0262",		0	},
+	{ .id = "RSS0262", .driver_data = 0 },
 	/* K56 par,VV,Voice,Speakphone,AudioSpan,PnP */
-	{       "RSS0250",              0       },
+	{ .id = "RSS0250", .driver_data = 0 },
 	/* SupraExpress 28.8 Data/Fax PnP modem */
-	{	"SUP1310",		0	},
+	{ .id = "SUP1310", .driver_data = 0 },
 	/* SupraExpress 336i PnP Voice Modem */
-	{	"SUP1381",		0	},
+	{ .id = "SUP1381", .driver_data = 0 },
 	/* SupraExpress 33.6 Data/Fax PnP modem */
-	{	"SUP1421",		0	},
+	{ .id = "SUP1421", .driver_data = 0 },
 	/* SupraExpress 33.6 Data/Fax PnP modem */
-	{	"SUP1590",		0	},
+	{ .id = "SUP1590", .driver_data = 0 },
 	/* SupraExpress 336i Sp ASVD */
-	{	"SUP1620",		0	},
+	{ .id = "SUP1620", .driver_data = 0 },
 	/* SupraExpress 33.6 Data/Fax PnP modem */
-	{	"SUP1760",		0	},
+	{ .id = "SUP1760", .driver_data = 0 },
 	/* SupraExpress 56i Sp Intl */
-	{	"SUP2171",		0	},
+	{ .id = "SUP2171", .driver_data = 0 },
 	/* Phoebe Micro */
 	/* Phoebe Micro 33.6 Data Fax 1433VQH Plug & Play */
-	{	"TEX0011",		0	},
+	{ .id = "TEX0011", .driver_data = 0 },
 	/* Archtek America Corp. */
 	/* Archtek SmartLink Modem 3334BT Plug & Play */
-	{	"UAC000F",		0	},
+	{ .id = "UAC000F", .driver_data = 0 },
 	/* 3Com Corp. */
 	/* Gateway Telepath IIvi 33.6 */
-	{	"USR0000",		0	},
+	{ .id = "USR0000", .driver_data = 0 },
 	/* U.S. Robotics Sporster 33.6K Fax INT PnP */
-	{	"USR0002",		0	},
+	{ .id = "USR0002", .driver_data = 0 },
 	/*  Sportster Vi 14.4 PnP FAX Voicemail */
-	{	"USR0004",		0	},
+	{ .id = "USR0004", .driver_data = 0 },
 	/* U.S. Robotics 33.6K Voice INT PnP */
-	{	"USR0006",		0	},
+	{ .id = "USR0006", .driver_data = 0 },
 	/* U.S. Robotics 33.6K Voice EXT PnP */
-	{	"USR0007",		0	},
+	{ .id = "USR0007", .driver_data = 0 },
 	/* U.S. Robotics Courier V.Everything INT PnP */
-	{	"USR0009",		0	},
+	{ .id = "USR0009", .driver_data = 0 },
 	/* U.S. Robotics 33.6K Voice INT PnP */
-	{	"USR2002",		0	},
+	{ .id = "USR2002", .driver_data = 0 },
 	/* U.S. Robotics 56K Voice INT PnP */
-	{	"USR2070",		0	},
+	{ .id = "USR2070", .driver_data = 0 },
 	/* U.S. Robotics 56K Voice EXT PnP */
-	{	"USR2080",		0	},
+	{ .id = "USR2080", .driver_data = 0 },
 	/* U.S. Robotics 56K FAX INT */
-	{	"USR3031",		0	},
+	{ .id = "USR3031", .driver_data = 0 },
 	/* U.S. Robotics 56K FAX INT */
-	{	"USR3050",		0	},
+	{ .id = "USR3050", .driver_data = 0 },
 	/* U.S. Robotics 56K Voice INT PnP */
-	{	"USR3070",		0	},
+	{ .id = "USR3070", .driver_data = 0 },
 	/* U.S. Robotics 56K Voice EXT PnP */
-	{	"USR3080",		0	},
+	{ .id = "USR3080", .driver_data = 0 },
 	/* U.S. Robotics 56K Voice INT PnP */
-	{	"USR3090",		0	},
+	{ .id = "USR3090", .driver_data = 0 },
 	/* U.S. Robotics 56K Message  */
-	{	"USR9100",		0	},
+	{ .id = "USR9100", .driver_data = 0 },
 	/* U.S. Robotics 56K FAX EXT PnP*/
-	{	"USR9160",		0	},
+	{ .id = "USR9160", .driver_data = 0 },
 	/* U.S. Robotics 56K FAX INT PnP*/
-	{	"USR9170",		0	},
+	{ .id = "USR9170", .driver_data = 0 },
 	/* U.S. Robotics 56K Voice EXT PnP*/
-	{	"USR9180",		0	},
+	{ .id = "USR9180", .driver_data = 0 },
 	/* U.S. Robotics 56K Voice INT PnP*/
-	{	"USR9190",		0	},
+	{ .id = "USR9190", .driver_data = 0 },
 	/* Wacom tablets */
-	{	"WACFXXX",		0	},
+	{ .id = "WACFXXX", .driver_data = 0 },
 	/* Compaq touchscreen */
-	{       "FPI2002",              0 },
+	{ .id = "FPI2002", .driver_data = 0 },
 	/* Fujitsu Stylistic touchscreens */
-	{       "FUJ02B2",              0 },
-	{       "FUJ02B3",              0 },
+	{ .id = "FUJ02B2", .driver_data = 0 },
+	{ .id = "FUJ02B3", .driver_data = 0 },
 	/* Fujitsu Stylistic LT touchscreens */
-	{       "FUJ02B4",              0 },
+	{ .id = "FUJ02B4", .driver_data = 0 },
 	/* Passive Fujitsu Stylistic touchscreens */
-	{       "FUJ02B6",              0 },
-	{       "FUJ02B7",              0 },
-	{       "FUJ02B8",              0 },
-	{       "FUJ02B9",              0 },
-	{       "FUJ02BC",              0 },
+	{ .id = "FUJ02B6", .driver_data = 0 },
+	{ .id = "FUJ02B7", .driver_data = 0 },
+	{ .id = "FUJ02B8", .driver_data = 0 },
+	{ .id = "FUJ02B9", .driver_data = 0 },
+	{ .id = "FUJ02BC", .driver_data = 0 },
 	/* Fujitsu Wacom Tablet PC device */
-	{	"FUJ02E5",		0	},
+	{ .id = "FUJ02E5", .driver_data = 0 },
 	/* Fujitsu P-series tablet PC device */
-	{	"FUJ02E6",		0	},
+	{ .id = "FUJ02E6", .driver_data = 0 },
 	/* Fujitsu Wacom 2FGT Tablet PC device */
-	{	"FUJ02E7",		0	},
+	{ .id = "FUJ02E7", .driver_data = 0 },
 	/* Fujitsu Wacom 1FGT Tablet PC device */
-	{	"FUJ02E9",		0	},
+	{ .id = "FUJ02E9", .driver_data = 0 },
 	/*
 	 * LG C1 EXPRESS DUAL (C1-PB11A3) touch screen (actually a FUJ02E6
 	 * in disguise).
 	 */
-	{	"LTS0001",		0       },
+	{ .id = "LTS0001", .driver_data = 0 },
 	/* Rockwell's (PORALiNK) 33600 INT PNP */
-	{	"WCI0003",		0	},
+	{ .id = "WCI0003", .driver_data = 0 },
 	/* Unknown PnP modems */
-	{	"PNPCXXX",		UNKNOWN_DEV	},
+	{ .id = "PNPCXXX", .driver_data = UNKNOWN_DEV },
 	/* More unknown PnP modems */
-	{	"PNPDXXX",		UNKNOWN_DEV	},
+	{ .id = "PNPDXXX", .driver_data = UNKNOWN_DEV },
 	/*
 	 * Winbond CIR port, should not be probed. We should keep track of
 	 * it to prevent the legacy serial driver from probing it.
 	 */
-	{	"WEC1022",		CIR_PORT	},
+	{ .id = "WEC1022", .driver_data = CIR_PORT },
 	/*
 	 * SMSC IrCC SIR/FIR port, should not be probed by serial driver as
 	 * well so its own driver can bind to it.
 	 */
-	{	"SMCF010",		CIR_PORT	},
-	{	"",			0	}
+	{ .id = "SMCF010", .driver_data = CIR_PORT },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pnp, pnp_dev_table);

base-commit: 6e845bcb78c95af935094040bd4edc3c2b6dd784
-- 
2.47.3

