Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCD04657DA
	for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2026 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752664; cv=none; b=eL/Ef0RQdTy90aNhrUUs/eBzyAI5LdULVzb09eOEvzaWxlcUVgH3hrl/gA3B2xYHQXa4oHm+g6qEuj0EA/Nw9Bbh8qep+LLOSVTtW10VH5w1DAw4jhYgjTnEP4bOVQvQdi0EFMD/S82DCRYAyIzjZdIzG4qCQD3h19+bWLHaByk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752664; c=relaxed/simple;
	bh=c0LXT1jbUwFn5tec3T76uB6ZT9Qexr6ffFztfvcgPAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DYNnTmi4v+GDyEe4Aqs1quttkZDRMxPuWYyQ1W5EnV0oKCkVtwmc+NRFyVjCPP8bjnI1Nv0q6uJUe8cBI3ejdzc5t1S9HFedOGdQC+D2olHyXEBL6JhOBY/ITZI65XcGDNALZq7YF9Wsm0Ad/Zo2z14AODAwAOYjqH/lPzCpc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fKPS+Rnm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fKPS+Rnm"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493a613571eso14120665e9.3
        for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2026 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782752658; x=1783357458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjseQQgmUTZ/UZj8f9N2a7PmqUaxNH9VLhKJXQxl5aU=;
        b=fKPS+Rnm9URf6tkO5QfVWsJsIVMW5wIyEVneB8j6UxLJPbFhHCwnd/cH3MGoA/fbom
         OymtBOUSUQJ7lMGiuU/B09I+UU+pIZZ68H2l52B/Yvap3XP14FaW0lVFAYlt9Esu6qzn
         +2EpIsHDr57FiT/9B4Dm2OmgDRkI4Y7lvUDfmntmBX1V/ecmyTS0KOUvFEeoe/QuRdXM
         AVsVfwZQhbkkMDR0zbNz2IbP/kFJd85b6qj+APS2/VjQQkJs1H2+cIOHsGqYwrZfgaRc
         5yGqKaGPzI8PwrZUkKx5/B7nmqt1BPVxm7nzT12mD92iZrn6c4XnYVqpKRVW5qGqjCYp
         v1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782752658; x=1783357458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjseQQgmUTZ/UZj8f9N2a7PmqUaxNH9VLhKJXQxl5aU=;
        b=RmOpES8M1ImSyTSUEpezDcEg48vKdcAvTlcYFy8Op9QRWYP95zrXSfZFTeOZ23ucJC
         +h0H6LRhRhxX+M/6x/BS/Z3IPnQ3CiWZfjBFa4PieUfe4274GcekIFol2usOncRRTSVf
         Zk5fheKP5tm5gXbqHyQsYMHiDSJKSKzYF4EFpZjvjVLCaVuUljuiaz/fe+wv6tkWTE10
         S+6VJMbzr7mqAN8/XGYgUBkQdB2rDEZGlw4VWqa3tghpHps+hy4O1CuGh8QKatNB+JmK
         IOxh6d5HoDIy3c/EKm2tLHuHh+P/uBv+UEW/JDLywnCWpM1OQsROfEPGzDR0WE1JYMYc
         HMPQ==
X-Forwarded-Encrypted: i=1; AFNElJ81BQMmbJRZ2QK1gtoWKWT0fkseROgZt5TNj3fmr3W1GicIlFAG21o5ecWXzTy+NpYG4TMwGl8FQS/hAk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUBp7XU+lxxlK732wbQ3Youakk7oc8MmG8B6IzG6KxHs6BUSj7
	ECmOOOe7b63O7NIyJCX2Nig30ih5Eo253FwuKPwFa1O6Hv40O1gYstSUsPjKCtSmnAU=
X-Gm-Gg: AfdE7ckeOEPgS/HN22thfVs1pc/GHTy2ulQpDak4GPIdQdgNoYe5Ti9rFoD/I4IAA5X
	hsf3IKI4CI8CYf4GhN9YJhPOV60XsRUdqL0QfKNZO0UxRc/UcRldPVlt+fxECBCtN0OY0RAtX8m
	ZSUoJidRnyfN+58DpL8Z22+Z9R8SxmAsQbl38XbGExK0WTUNcSkKmyM63nPL0QwTu+BqeymEi2/
	ccYB8ylW07QIzeXtmdu3uOVZ+48bpmTIWVqH2rqosJLDc06O+4fKfp9ncujbfPY4Dly3oGIsDPS
	PIV4MCRS39mkGnl7RLs/5r/6sjqz5JLSYEtwKRzpfcsGwtdGX4pGc5yCuqDM4m6EWsWvvg7ns9b
	uzSg6xeg0pcgGiAxDZGgnxr7TRXpyurQRp5xP5dszxppgW1Ceo4PT11YRv5ahvsh0ydcTvLx2oz
	XQtlC34RAD4JF8c255b2Q6sU5UvUlYQja0iTj6Plvnz+wJMluwN6zgMKj1vs3n0PgE34eiaB3zM
	Yni
X-Received: by 2002:a05:600c:a403:b0:490:b2c9:e284 with SMTP id 5b1f17b1804b1-493b82b910amr6874655e9.30.1782752657418;
        Mon, 29 Jun 2026 10:04:17 -0700 (PDT)
Received: from localhost (p200300f65f47db04294e5bd34a12a699.dip0.t-ipconnect.de. [2003:f6:5f47:db04:294e:5bd3:4a12:a699])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493b8c238fasm3447065e9.0.2026.06.29.10.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:04:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2] serial: 8250_pnp: Use named initializers for pnp_device_id array
Date: Mon, 29 Jun 2026 19:04:09 +0200
Message-ID: <20260629170409.3412413-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=19057; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=c0LXT1jbUwFn5tec3T76uB6ZT9Qexr6ffFztfvcgPAU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqQqWJ8ngv+ERpiB0sRfzjxxeArG/xrjTFfchpu rqpFmj+RiuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakKliQAKCRCPgPtYfRL+ TkuFCAClreHWX68Fc1hSTZAau0WQPs/LNdJxpBoUO6ci3jk6GUMW1SJ9kwc7xpuH9ftALAlfxIZ 4euxjY8Ui6B3UwvPYwg1ktveNLJIioFJdGr9KsxO4DpshAtXXJDNFUaeVMaHKPHTLmPBBuJYFTz Mdd4CzilVMrlESX3TYI3i8ZLQq5E0B8+xmDclgqULDzJUkgZHshqjFRp3hrV6POSB9r2BHd2hEg CCvhRH1eTD/5Gf+xpPSpF9HjhBAiXffd7poG7QjdSpeDDe4zTswMMQMKuJhlFu0b0HtPVvRCq4V ZSWhvFHZfj/VyoItqLuRYH+c+rLObQw5yEHVTJVoy+ZgUg3b
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
pnp_device_id that replaces .driver_data by an anonymous union.

This patch doesn't modify the compiled array, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Also simplify the list terminator and use a consistent and more common
indention.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

(implicit) v1 can be found at
https://lore.kernel.org/linux-serial/dfc218a0e9265e9459df1c5bf621db12be5c551e.1780937987.git.ukleinek@kernel.org

Since then I updated the commit log as discussed in that v1 thread.

Best regards
Uwe

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

base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
-- 
2.47.3

