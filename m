Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449D45A2A8
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699207; cv=none; b=mypm2hYxzLVsebDVlS6fGtUiupcUHQ0DmNlbhH6bf+n2IHI6FL6QE3WLS4rdLwKrU0TZJv8g/09w+MSME2vbWzSekDhXnvDo+seF3ypDiTHLPpeYsVk4y0BfaeuMYF8d28x3Z5DU8AuS+pZ4v3as/1v+f9pK451Atv/guzIdDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699207; c=relaxed/simple;
	bh=7BtFn6FyDnHzVGZovCy5KcaiOnDY+M4o0HFfzl14hSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COMCVEAzh9x8/UMJf/vyGTjViUm5nzeapAN/F4Vd6tOOGQbMAvTQ1w/X0wxXEx8Pb5mnOUiXLK916HnO2txfHndu0r/wBLBcxAiESETTPxz+TApjtK/Nu0BPLiuCpJ60wbumqDpRZ07vRt/lrL57Bn/P6MPwobz3zOyIOiB3avg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lPoiOyu0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lPoiOyu0"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so10943935e9.2
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786699203; x=1787304003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yRCd4sQSxi4fAf0Ym6TjKMG0TipxAR6pT/43UC1Xlc0=;
        b=lPoiOyu0RMbyz5+Z2GjKKOEE9yJd4kKAzxDzNBJhHk9X089C9X/+vSBKJtt6JUVx3M
         QcMquu7nchpe0EanOVvD3XeybgjnXZ0HDrjuClBPLjOv3caoUaUamHnjJKveRoEsesBD
         iZtM/x1cSekBh4Wy6zBxrKpcMsTD18XCdzzyGpWFqt1de+00wZ4COTwm5TpVEAnQlPxi
         wJJ/hAsnhki2Um3OtHLUOz5usdSFfDnfpbb6/OL6j1u/oZHxogbIwTNjNVh0IHdEmVMR
         kDdMlLhIb/x6Bvfm8IdiDRvr8Dbs1kVtTngLJEyS/FDRMaROnh+4JvdYD3+wnh8FXJDD
         O4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786699203; x=1787304003;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yRCd4sQSxi4fAf0Ym6TjKMG0TipxAR6pT/43UC1Xlc0=;
        b=jd4OBo51j9sZv416MsPMvyfLc6GMh3MAF/liNGXOLGpnJ9CnbwLEIMGytd66N45XEe
         K+C+xEbv0CICLl5iighLZtaPYgCQnPnNRw/3DH7Zlvs4Y0jgygXuPTdxWCWX8FBNp/rC
         Ukqt8VU9L9gGw7s26pXG8zqRtbWwHQ6CPRY6kQ1ptntd+5qxYZLHKpCOwMLcwaYX7tKo
         Yq16Kx1fDO9asy9TmHo4i3EZw8//RQMKYo5qzCPPf3x6DeGDe8Y9QZgKaAmy1hzkuZGu
         j7DvkPJfvVIWougWvF5p1Bns/2epI74KmQV9W1a+5XM/MSBxXlxyXzfkUAi5qZIxOHNS
         Q/Gw==
X-Forwarded-Encrypted: i=1; AHgh+RpGEjPC9u3AVmPjPU1L9oPeZMoAhMkUFl/PMQGVBFFPDnk/9fpHr2Sk06DOMRhJZYJbYfJZbmoKtavRa44=@vger.kernel.org
X-Gm-Message-State: AOJu0YysF8zFh7u8jaELvltWryDQXh5cIDziIqIDP29rRgJqXTsTcqo3
	Mh7/e0AC67DATifaMa3EmA4j5JSjE85Ev7oRXyc+Vgc127pWtD414qbgFkm1lo+UPkI=
X-Gm-Gg: AR+sD12tPhY4as2y7SGysOid3YpnQRhjwcqZROLpVmrK5bVg1YqYrtAtDmpoW1gRdRl
	7vbub/lwMN4lgPaWdWHeWTIssUUBkrMAbM5jlNBGEI6nrN4nHEnMC0K0Hd6lrLfwuRRAX3kgIF/
	5tt3fdnlub4URT0O2Z+E7OwzDD2xa318oWs46pvvHz+8xH809EhTjmIN9SO/hmVSsWOCC/oMPE/
	eW0De5K+k4gn99ZTdgKCne+WRTD8kFkVkmBtkpGpMR2eP8k5jwqG7VTbUX1qy5diJrZJ2KpYSP0
	QAGsLyHSqiLckur9C6O8QIOKqVi8Ve+mmn4X7EEpovFRMD2joAtUs9o1IQsGAGcxR0U2J9OOwK/
	ytIfWlIEy5YiMCTJGceyjAkPGRDb/3ZnmBMgN8GG3zNmLzPkayoWYOtBe/r2usRKQRb9KLpl1JH
	9mobeLy99Q48oPTD1P0sTNpXtpmzNb1q4KT/X3J4JAIyMPLAbDYC3htkOmhvmfziHjxFsBqp5cg
	YUVc0LVsjwC4RoqfljYd27N1ginRlKe1pLoLXGvu5CiT5nQZ/NZ
X-Received: by 2002:a05:600c:364a:b0:499:8156:cd3f with SMTP id 5b1f17b1804b1-499879533dcmr42073375e9.8.1786699202739;
        Fri, 14 Aug 2026 02:20:02 -0700 (PDT)
Received: from localhost (p200300f65f017104e65cfeae4f257a65.dip0.t-ipconnect.de. [2003:f6:5f01:7104:e65c:feae:4f25:7a65])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49989af26eesm14204495e9.15.2026.08.14.02.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:20:02 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rahul Bukte <rahul.bukte@sony.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 7/7] serial: 8250: pnp: Annotate init and exit functions for conditional discarding
Date: Fri, 14 Aug 2026 11:19:33 +0200
Message-ID:  <15308b3e517a9d7894d1dd1a1ad7163e78bb5929.1786697789.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1786697789.git.u.kleine-koenig@baylibre.com>
References: <cover.1786697789.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=7BtFn6FyDnHzVGZovCy5KcaiOnDY+M4o0HFfzl14hSk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqft2yS57GZTnG04Lm83pscpEo0KMl6Tvh2h99h gB4A5VLEKSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCan7dsgAKCRCPgPtYfRL+ TrO5B/4kc0QRP287fyEHUG/Gcu2BmYwwkXtqTwbPsWdEylGXwozSdPgiv5Zzn2NvuDDAmTJXeaE docfQtkW5J9P02lWuejIiQkLZQr9OVEZ7ZvqBbUDz9N0SXB1aye34siHguN+0LU62rnLIgXCG80 1vBSd9S0AV74MklekyK4RQD5JIDc/K4EV9guopVzdscy31klgwW1hZZ+bKmi2QmrGTCAX1ivQ2m 8jBkP7ecDrKR/SEZFqNWr9VjOKj4fGiHt0+VYOq9v6LPc7YbdXS4DE7hq7wjQXLauxCO2UwAESo gSKqq6llsDARSJp30QR+8YGpe/P1f8yyOzdWfg8sZxCAY9j/
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

serial8250_pnp_init() is only called from serial8250_init() which is
marked with __init, so the pnp init function can also get the same
marking. serial8250_pnp_exit() is only called from __init and __exit
code, so __init_or_module is appropriate for that.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 6bfdeff5fe22..7decf62400ab 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -526,12 +526,12 @@ static struct pnp_driver serial_pnp_driver = {
 	.id_table	= pnp_dev_table,
 };
 
-int serial8250_pnp_init(void)
+int __init serial8250_pnp_init(void)
 {
 	return pnp_register_driver(&serial_pnp_driver);
 }
 
-void serial8250_pnp_exit(void)
+void __init_or_module serial8250_pnp_exit(void)
 {
 	pnp_unregister_driver(&serial_pnp_driver);
 }
-- 
2.55.0.11.g153666a7d9bb

