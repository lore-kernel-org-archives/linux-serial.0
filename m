Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4243A6B82
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970882; cv=none; b=M1Ri7p2FlukBXqKydIZ+E4ii6syEKkcaK+v8Y74jez1m41YOb9++Qfh0nmXzZ7cHcfb90KVBHef0FE85D3Re0otFClT71U1q05Usf4OHsWW+Ff3QqKMvgpdR0YxjxiaJzhNAmrCla2+d5Dei0KuSbNWcgb1rYWI/s0Y5T6YOkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970882; c=relaxed/simple;
	bh=1NVEGhQHLQ24V5uO8GejoHvvDxyflIwwSUWdcZiGgDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D9KDTaLuXsxs9qMl6Aj9ncyw6d5AztHW+kN2uZKTw+vQc/Ht5K1NjYUemEvCQto9N+s5pu4r6zOPYKVKJbudWHB6lz1hXdNtVAc83z7UtIojYyg5SlrU67PpFWiqYR+RfJBsLIT/XZl1gl9UfDSKYHYAqmh1i2Hrw59+VIai8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=TZt+O7HY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="TZt+O7HY"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso47464185e9.2
        for <linux-serial@vger.kernel.org>; Tue, 05 May 2026 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777970875; x=1778575675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/HV+PJyPvR5SXo7b65roOSJJNehPyaCGIWDGwqA+Qc=;
        b=TZt+O7HYVZZ+1SOL+96OskdaHTnAJXlzLOUA881W4IPzwMZceuiv5ctymGRiayo1b4
         EFA52PDbtclGgIrKPM/D4pi8ccxQ5Q7SvUvhpnun1vjz5jsWFh0ySGrQMIkgAsELs7is
         zW8pmYFdgrs9MSzHWgJ8XCwwM0F8Sr/Vamt0JVnEopbd6QOqT2qf4n5ZU5XpTILb2X9y
         JAAHiNhT/qH7KiBOCt/1KQ7eq0TKKYe0pK5B8r36XHd3Rv6PAE2DFmxuV2niQLoFbSAn
         NAOXB6710D0quqfpwUf0J7K21QkwIUyidLcSbMP7Jq4im4J+ms44fhvTwVPfyuFtcJA8
         AFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777970875; x=1778575675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/HV+PJyPvR5SXo7b65roOSJJNehPyaCGIWDGwqA+Qc=;
        b=rGAQ3u68p60P/ATRlkQucKKNa5A8JRCFA6HyUtzILN3adasApsKsQok7fn+f16sbYD
         hDExmyfFtVlUKAJM/HqgQdytKZBS+Hut0Mj7d6s90ectiqAKqWn4FUoWKEwiVGRmsGPK
         76xtPt5KL7UgjhJ9jYWD9soeU1yErXQmRT7Nn6c8LfhjHz/0Mp+no/HzWIbrIFSYj8A8
         /2kuxekDLbpV4+ARAk0t6NWF1d8DtDfWRqvkOQQrC++NJBu6WmbozIX0LoJbl6pAFD9B
         8UU9CaxnMrYVIR92JRCxB5GCi2Rw7ejUGw9eMSiQZmp+I289va3fNxtM+N/eBCCSIMlk
         G5zg==
X-Gm-Message-State: AOJu0Yw/0XY6DRetmsT1qKc3Zf3NfAVE7Q+8IWuOQeUpBDsvPjqnc9oq
	bMBdhP2Rmcb4YE3lyNpiYCq0t17myVWxKzBaukmYC9vkT0OwS+QJDl4SZWy4b5NW9m4=
X-Gm-Gg: AeBDies/qb6wbquDjcQiTFSwY7eNNaB/894sdO8PHr5QpKEkL/wl6xpr2Jbbu/yUT0m
	dkHGJwu/wc6LpiIpjY3GpLZAvUW2eO1jUlND9gQ7KdveUWhCD7huhkaJ4gIFM0JxIVYh/7eIcaH
	SJl8vnKDGvsgym4wClRTk30rJGvAh5S0l3ZGewhcesFDIZ0QqK4RNWhs4ShGcgOEQSXEdfbq7t5
	JRnOn1DgfH+VgJ0US0LtWPE2MovdKgbR4yi89CVOrkRJ2JORfHiaFC9yAnvnp1a3Dh7HLDOe293
	Ywer+Xrg0wV0KfkuyJ0BEqY/Uq7QnJK9Lp/lnJNi1nGW5ulETnaQ/stLeRwlM+ZEU98vOnLFc5T
	95+T8DgEQV6H/iN93Yn6SKTIcxuT7+ccZGQKXRhsyCYEz7CSg5kKIJD6pGLbEQNpD0fIFD9+X1j
	nkHC26wg3iUs2dmMWvCGDq4JWYMzOi3YyboLOxNi1gNtHKd4NSAX8nC+BiLlhH9I9onSp+78Eio
	zYyQ7u7DyL2K9KJ4jo4Wv1Z59H+SwiXqPdc
X-Received: by 2002:a05:600c:628c:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-48d187d9124mr28927915e9.8.1777970875124;
        Tue, 05 May 2026 01:47:55 -0700 (PDT)
Received: from localhost (p200300f65f114e082236c6257eff72a1.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:2236:c625:7eff:72a1])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a81ed6b89sm382848935e9.1.2026.05.05.01.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 01:47:54 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dave Jiang <dave.jiang@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Kees Cook <kees@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2] serial: jsm: Drop unused driver_data assigment and redundant zeros
Date: Tue,  5 May 2026 10:47:49 +0200
Message-ID: <20260505084749.2304121-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3695; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=1NVEGhQHLQ24V5uO8GejoHvvDxyflIwwSUWdcZiGgDo=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBp+a612hlhLL87K3OgO/IqaweZZlZ3Hk2A7zSly FHA9cAMKseJATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafmutQAKCRCPgPtYfRL+ TjvVB/jjfy9eJ8XTEGBHR9fjAInnl16glODxzFfWdnvHayDw14zfWfaIjTqmWWIwI6CuFWZRVRh cDzceZifk2MiePxS9pcmGWuKnroqkvAeqs1us7lG/2t4UzRB0VS75IB8OysCyGJ8xdukAeoj33f Zifkk28V8OGfa0RsdhB4BTxtW+/uaF5TSKxVcaNfRJhcxIcovLLBMe7TdUDfEqGyJBW/eMhW4Ls iu+leaVMArQOfCPeUtDg06CPxy3a6rfmONbLAxxkVzCR7XDS2HOihMao1wKCOg0RFrt+7MfdaS6 D/adpRhEYZqdhkbfNCQFJyGbIuXsgyns9fPONvaXZLameJg=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver doesn't use the driver_data field, so drop the assigment
together with the then redundant zero assigment for .class and
.class_mask. Also drop the zero in the list terminator.

While at it also use PCI_VDEVICE() to allow dropping "PCI_VENDOR_ID_".

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

(implicit) v1 is available at
https://lore.kernel.org/linux-serial/20260505073044.2258674-2-u.kleine-koenig@baylibre.com
.

In the v1 discussion I mentioned that I don't spot a usage of
.driver_data and Jiri confirmed these are unused. So this v2 just drops
the respective assignments and thus circumvents the subjective
discussion if my v1 really made the array better readable. Also the
usage of PCI_VDEVICE() is new.

Best regards
Uwe

 drivers/tty/serial/jsm/jsm_driver.c | 38 ++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
index 4b73e51f83fb..8cd9b981bf20 100644
--- a/drivers/tty/serial/jsm/jsm_driver.c
+++ b/drivers/tty/serial/jsm/jsm_driver.c
@@ -296,25 +296,25 @@ static void jsm_remove_one(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id jsm_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9), 0, 0, 0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9PRI), 0, 0, 1 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45), 0, 0, 2 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45PRI), 0, 0, 3 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_4_IBM), 0, 0, 4 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_DIGI_NEO_8), 0, 0, 5 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_4), 0, 0, 6 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_1_422), 0, 0, 7 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_1_422_485), 0, 0, 8 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2_422_485), 0, 0, 9 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_8), 0, 0, 10 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_4), 0, 0, 11 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_4RJ45), 0, 0, 12 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_8RJ45), 0, 0, 13 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_4), 0, 0, 14 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_4_422), 0, 0, 15 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_8), 0, 0, 16 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_8_422), 0, 0, 17 },
-	{ 0, }
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_NEO_2DB9) },
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_NEO_2DB9PRI) },
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_NEO_2RJ45) },
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_NEO_2RJ45PRI) },
+	{ PCI_VDEVICE(DIGI, PCIE_DEVICE_ID_NEO_4_IBM) },
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_DIGI_NEO_8) },
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_NEO_4) },
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_NEO_1_422) },
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_NEO_1_422_485) },
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_NEO_2_422_485) },
+	{ PCI_VDEVICE(DIGI, PCIE_DEVICE_ID_NEO_8) },
+	{ PCI_VDEVICE(DIGI, PCIE_DEVICE_ID_NEO_4) },
+	{ PCI_VDEVICE(DIGI, PCIE_DEVICE_ID_NEO_4RJ45) },
+	{ PCI_VDEVICE(DIGI, PCIE_DEVICE_ID_NEO_8RJ45) },
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_CLASSIC_4) },
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_CLASSIC_4_422) },
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_CLASSIC_8) },
+	{ PCI_VDEVICE(DIGI, PCI_DEVICE_ID_CLASSIC_8_422) },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, jsm_pci_tbl);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

