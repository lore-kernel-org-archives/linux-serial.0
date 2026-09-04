Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE01C4766A9
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524358; cv=none; b=ZpsXk0F2/H8JPoPichKSOQCUzSl8otXx7VifcdLmNw0Q3YTUvYLZLvDnmXIUQbXABfKMubOAoL0cifgUVFQTamd9pzHyKQRBW7y+eXcCaRxDrg1AxbDZ1tpzlA5szXvOEyGQX3sfL2gmcaWhLZoPPDK2lQ2WKRqnOvLGWOm0YkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524358; c=relaxed/simple;
	bh=vvS3Rv4YntYOjqCfj3skTyPfQt5gyWvTfvOz4/CYaAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSx5tiBEPVAyVT61Tfo+xepfxOlOPo8Q6W4xH+9v+xoKrsCKruXHvfyb64+vDKq/RJgBIpmrdZxf09bZlTjN1KAquVHeut+vUOGv7EaRC2ichTmGcu/KxWz5/Qi7XcdgEw97qcE2k88r+wEn66pXKWgySkdNGI9KJxbxZDt82Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQhyO4Ve; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQhyO4Ve"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b128dd0cb1so582474eaf.3
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788524355; x=1789129155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvBNjOwLcoWAJdkVEyBhPUyq+5YnsgxiEoVDt3HxEAE=;
        b=mQhyO4VeAmKeQnz4Dg+GZIVAKsxncr6ENUamcY/cxkuvrshaIjI5vx4RgjaxCZ4lzG
         CrAVXo8HEYbxddp1SjnFbOroFWJ3r1dX2+MK48jMxBNpHgg+2p7DnSBJ7mj2zm3t5dZl
         9rtuHaA/rFlsTQrrj9ExCSy8D1I0PlhBSNUEsE+yCsYLBFThLVVmq30yL3DcHcEFDyma
         PVFoUYk3PnwdQlMVH+dAPPXKC5tQT97Jgsc6Oa98T7/4kJ0p/enUtk3pasMOVjyU5AxK
         dvY7A/U9KQ95+VGmLugaX/RZQOgcr7op6Ch5ej8dGPG72RwZHO7tM4liR3gDRYlLEkPL
         HLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524355; x=1789129155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvBNjOwLcoWAJdkVEyBhPUyq+5YnsgxiEoVDt3HxEAE=;
        b=DlSQaujBLMFi1gBEsnsnSPfJHYvIbIzEYWgnb9gn3HlsILw0L/FT1MUH9lCf7v8sMX
         6TJG0b6Lin/qOGjL1m0j8P0b1X3x/N2077VZn0qg4vgCwwFjTdOLRdF2ZktwPG13/X/x
         LM5/KxLdVm008uFKf/jIknCO+zboQPk3n+qI24kP4vop74XilNrwuqEmM9ZPuu8qq0WM
         w8FB2H/xGShsfa1z3F0Z7GWXTYEGA3k9j4cqAj1n62dta44tPkp451sqYpgLjovlzc0D
         q8ORcOxVqjoylixWjDYMNvoMM1MJOdElZNs1jB/olY5u5ZOa3FIT507Hd0X05O5PdTEQ
         Njaw==
X-Forwarded-Encrypted: i=1; AKwUvBz/sMu5Ja1devAzpHmkVWs7GXv8N+vpa63rzeYiaKWunbqomhxa8v5E5fVaz2lg12Cd5/s38N/2SNFI1a8=@vger.kernel.org
X-Gm-Message-State: AFuF++l8f0s2dGfaHJk33oCWUUG36+tm2GLV6X94BCJmA3xv+J3u/oJG
	BkDiRhXela1K/eTjeocOELeFWC5PP4ZHhlrZDE2eWgHJOiEPdtYANePd
X-Gm-Gg: AYBFou08BwgaanTgHZpEaH7VtiACWITUveN+EtFlKl9ng5vRDi7AhF/aSNBvBEPoXeZ
	PeYDZMFTk4zm2DOBLDNZ+bc3V2GzX49HGcYG13z9OhMz0BavOCe4mMcXw2X8BTTXQyS4crLN76j
	5P5a8BtmGOM+tqBAT9a7CDH5AFHa4LVgh4tFJ2W9J8DEseSdotej0WEWvPAQWvSY1Xz0GWJxKeU
	DUK8LkRcJpTM5+c/31T81CKGox3p1xIa92OrK0rc1hl58aNgjfe6R6iqhwRmtgy+R8+b9Mh+GLJ
	n6Sh1aQEYnGi47CR++RzGjnOVW2eFGSqxOB3x16OEBcyLoz4qKm2onZxfD2JppYVvmLz6dwSO1p
	Y7bXlzZfnjgV1v+TmvI7k7YxKVSM6ejUeLkjJec94oRoGUumgW7Nq6dzwkqturJyHKRe5jvXLE4
	Hs8b+S2cFD3wpUZhS3iAoxz6oib8ldJWbH8ADYWl2VOZID5P4zs6IUNd8826rDLHsBzgFt871ZV
	GtkXQfG1caIutc=
X-Received: by 2002:a05:6820:4d09:b0:6b1:a667:f0f5 with SMTP id 006d021491bc7-6b6fcedc374mr3923445eaf.20.1788524355505;
        Fri, 04 Sep 2026 05:19:15 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a62be87sm5795672eec.6.2026.09.04.05.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:19:15 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: fix typo "inteface" in comment
Date: Fri,  4 Sep 2026 17:49:08 +0530
Message-ID: <20260904121909.27377-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "inteface" to "interface", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/tty/serial/kgdboc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 09648d643897..b4aa117f76d8 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Based on the same principle as kgdboe using the NETPOLL api, this
- * driver uses a console polling api to implement a gdb serial inteface
+ * driver uses a console polling api to implement a gdb serial interface
  * which is multiplexed on a console port.
  *
  * Maintainer: Jason Wessel <jason.wessel@windriver.com>
-- 
2.48.1

