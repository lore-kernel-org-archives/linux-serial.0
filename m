Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0921DF96B
	for <linux-serial@vger.kernel.org>; Wed, 29 Jan 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168058; cv=none; b=mcn2UgtV/NTri6Wod24Lh2VolQ44M9F7X5V9PA5YbKrsq0AtH/Z1Bkkp8Wadckvp0VYSuDBagP3k/Uv0WVCZoqG2D2j9FVWplGMChS1hqvxljS6kBgsnHvvb8lQATIqLakQVmXty26aa9Q0rf/v2nKjlXzUo191QQtGwlO/0TkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168058; c=relaxed/simple;
	bh=xC0xL3xkUrJX5BUOGfgoFPaOTr3+cZj7iUN6rx1TtGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4LeAA090wpZIr8ueiv5wLm0ashcyAfW9L4VECuVrFHYsfQvItUR1awhjMb3BKsRZqJ1ffXNaHwL+VOORaicCBOVpgifyoOFnh71vp0gqma+EOPvDaRmpmIbKrsHUBCC695zKcpWDHz8wJ63teW63jveTQ/AcLXRgLf0C48mOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dsMSUfXJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dsMSUfXJ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166f1e589cso10455075ad.3
        for <linux-serial@vger.kernel.org>; Wed, 29 Jan 2025 08:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738168055; x=1738772855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlqbrB8qvt9xCnWbF/o5yExRVumEzsDKl37nom5IOEo=;
        b=dsMSUfXJNi8LYLrdK12UKImSskE5VUlStvYcvDuBEmGM5MvFGMeNoKni7tLBBM/6IT
         voZX0Q5YcBojiYLHcM08qJJ6tMrHXmI8b7eGVENzLWV/yFWNtQec0sWNq7iNQ/YhseiG
         SbMhUAp+v8d61BaEkC2nWE6o2b3g7F+crW5Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738168055; x=1738772855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlqbrB8qvt9xCnWbF/o5yExRVumEzsDKl37nom5IOEo=;
        b=XKj4ql5vlOAiNY/B/ZUaKoRam+EPA2OxhiNdaHTnFUIVlH3Aoy+Ed1DM54TLQHrrCE
         WOJ0zUZ9OFbRJxCrBFTdxjboS22SvsPA0TIE1v+9WVCx+kaXg9/lDln2BeSDRj10jfaa
         o5ydxHz2WQp0RKl4P/Vas21nfqbP6Jj7Ng8PbWR9vqvYwlzp1TlQQpXb+hvMHygxRYba
         vJSrrBTpqh9qOh3Ul8UsF7seKlwqGqIc2qhdIMCtEvt4FAwfi56SWcsZxQ0qS3ESiOC7
         P0X4oUURY4WBnpGh5oEgrYWKBos27G4jy/MjsUSUXt8AJHRAtxzwjyvrZFXQ4/S1IEGV
         /6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy7bCgj1AP781p0FltnzQ56vL3hzk+/ZgAUeUMcdZWFnoU2Wj+JBOnu/Dxwm2lZsF4ojj08BkZuAu+OKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7iRcvmR8j6GRlMTO2MBqywtJe8ozGR/EaMmJFW/smBlH6az9
	53ms1oVPGDGxnzsRNGyoyOD29xw/5Z80Qb5IHkiQ7I9nYe5+fTJPLhkmU5ogiw==
X-Gm-Gg: ASbGncvZUoL4HVgA6ESX9ew7/DRP+6GIRRWrNqa1dHOKd4uRxSx4px8/VIER6fVFgas
	OdKhH8PN+DC53wPjj/kTkTFsdxl/QgFZeN8p2WRALQZNpzHL8DtGOKF7X/3VdBnnkooy3mqSX2F
	fYLX8a5i1yxjoND/4b8xyMMtHwmGJr3QNGFD0HS8MAxuUdh5bWYQBgILpIxlTWza+P8hU5E8ANb
	6U8AtIR0vB/jTCspc6YiIe0i+M2cUZ6EJ2DQce1oXo2Uj2cU65wVwKfXcsbeIYip5hg6TMcL4r9
	P3s5lVYQMd7ORy4pXYztx0i3g+GJq8iEgf9UhNbwEPVY+Q==
X-Google-Smtp-Source: AGHT+IGwHJzqht4xgAE8aAHlAbgCQ+Cy1fdEcP9Joan7vjqiFIKdYsXcIDYJ2XLcGb2ysyVeLoX41A==
X-Received: by 2002:a05:6a20:12c1:b0:1db:e0d7:675c with SMTP id adf61e73a8af0-1ed7a4c9922mr7132442637.13.1738168054926;
        Wed, 29 Jan 2025 08:27:34 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fa8a:f68a:6cb9:40b2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac496cb4810sm10577009a12.66.2025.01.29.08.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:27:33 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Daniel Thompson <danielt@kernel.org>
Cc: "Dr . David Alan Gilbert" <linux@treblig.org>,
	kgdb-bugreport@lists.sourceforge.net,
	Anton Vorontsov <anton.vorontsov@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	linux-serial@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Nir Lichtman <nir@lichtman.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Revert "kdb: Implement disable_nmi command"
Date: Wed, 29 Jan 2025 08:25:51 -0800
Message-ID: <20250129082535.2.Ib91bfb95bdcf77591257a84063fdeb5b4dce65b1@changeid>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
In-Reply-To: <20250129162700.848018-1-dianders@chromium.org>
References: <20250129162700.848018-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ad394f66fa57ae66014cb74f337e2820bac4c417.

No architectures ever implemented `enable_nmi` since the later patches
in the series adding it never landed. It's been a long time. Drop it.

NOTE: this is not a clean revert due to changes in the file in the
meantime.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 5f4be507d79f..3a5408b54570 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -25,7 +25,6 @@
 #include <linux/smp.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
-#include <linux/atomic.h>
 #include <linux/moduleparam.h>
 #include <linux/mm.h>
 #include <linux/init.h>
@@ -2119,32 +2118,6 @@ static int kdb_dmesg(int argc, const char **argv)
 	return 0;
 }
 #endif /* CONFIG_PRINTK */
-
-/* Make sure we balance enable/disable calls, must disable first. */
-static atomic_t kdb_nmi_disabled;
-
-static int kdb_disable_nmi(int argc, const char *argv[])
-{
-	if (atomic_read(&kdb_nmi_disabled))
-		return 0;
-	atomic_set(&kdb_nmi_disabled, 1);
-	arch_kgdb_ops.enable_nmi(0);
-	return 0;
-}
-
-static int kdb_param_enable_nmi(const char *val, const struct kernel_param *kp)
-{
-	if (!atomic_add_unless(&kdb_nmi_disabled, -1, 0))
-		return -EINVAL;
-	arch_kgdb_ops.enable_nmi(1);
-	return 0;
-}
-
-static const struct kernel_param_ops kdb_param_ops_enable_nmi = {
-	.set = kdb_param_enable_nmi,
-};
-module_param_cb(enable_nmi, &kdb_param_ops_enable_nmi, NULL, 0600);
-
 /*
  * kdb_cpu - This function implements the 'cpu' command.
  *	cpu	[<cpunum>]
@@ -2836,20 +2809,10 @@ static kdbtab_t maintab[] = {
 	},
 };
 
-static kdbtab_t nmicmd = {
-	.name = "disable_nmi",
-	.func = kdb_disable_nmi,
-	.usage = "",
-	.help = "Disable NMI entry to KDB",
-	.flags = KDB_ENABLE_ALWAYS_SAFE,
-};
-
 /* Initialize the kdb command table. */
 static void __init kdb_inittab(void)
 {
 	kdb_register_table(maintab, ARRAY_SIZE(maintab));
-	if (arch_kgdb_ops.enable_nmi)
-		kdb_register_table(&nmicmd, 1);
 }
 
 /* Execute any commands defined in kdb_cmds.  */
-- 
2.48.1.262.g85cc9f2d1e-goog

