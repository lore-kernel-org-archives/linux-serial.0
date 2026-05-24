Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9BB481B1
	for <linux-serial@vger.kernel.org>; Sun, 24 May 2026 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779628760; cv=none; b=GOqlp+cP9+SPABAsXF57a7oqVBLgPT3ZntF7UrnwPb2dcxsOQ4sC1qKU22NZjowRyE+3KSHaWSlStd9785+5brjKXPlHtrV/mtDiPHuwY5nAxprMThsA0ORJuV62Fd26t0uZHs93NavgoA964XPqyQdF7YeIw7n1Twb3DJNIZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779628760; c=relaxed/simple;
	bh=axSRCVq18VKWIMh72f2wdBX29zYFYXgTiaCYH7DwIUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EuAXd5hm887Onp1aZN9lp2ZffeEEMvrg8ksRB735ujP4TJph5CzdnlB/dWH6KdYkOh6/8ACGuQxK23JmYhLpAv4rTnPpVD6ig1HEwBGzios5hBRop5681KdaicAx1Ys+EkDWDLD2T4l4d4GfUE64rheL2rd7XlPC8xJKZFOCo+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KrnrqzKj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KrnrqzKj"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so6498067f8f.0
        for <linux-serial@vger.kernel.org>; Sun, 24 May 2026 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779628757; x=1780233557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idimiKIonfIQbKigvQUX6MkId+nxqolp1vsjE2JrpzU=;
        b=KrnrqzKj7CBEzwxz5wPQqo68R//rudjb6i5kWbIjNnYYn6Khg502HsHRjPUaDcSjBR
         yakIGml8Fnfuer6Bll5gORIQW7OKL5RXWIANDZo5aIn87PBN4bxdFJ3oQhQ8EdY4cWUw
         M0otnI1HdcIXr1QSqm99qStW14GReEZljPM4J6lGVpUtm/faJ2L5TO/w02Yedu4lrlFo
         VulGOQRwrwZ17oIUlKpx4Rf4luoexWDz7sp2DOcfgMWi1GidHVJruo+4t1WVEm7Nq9ov
         uyb6a63Pqn++g5TQ958VfikD7NNPwmdO8EW+k9o2APtL5rm9K2FlpyXW6oSPaUCIGy2v
         1zbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779628757; x=1780233557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idimiKIonfIQbKigvQUX6MkId+nxqolp1vsjE2JrpzU=;
        b=KwrDHruX9cmAFtpyf/IAczio9Y1SJ/Ubch2j1b3QG02+kcRaK7/PKdbep/NUO4zcoW
         8QUOxVPRAVhdyFVROssQIKPkPU3nyES+A6QBuPq9GQZ3kUn8Nhm4uFGU/itm1Lwlxo0s
         auxsyo8dyCoMRH0lj3lrKo0pYXfKpKh+oLxSgCOVIitO08gXc7HJE8zHxGBfv7PsxuH3
         Z8vKYkIFwup6nyqH4eMJZoQ4EV4S1Wh7mLfyV1XeUbEx0hi17sQzdh7WKOtl4ZTWNPrD
         7anfFBKFnx6VGNuLUXXRAbUNkBtji0/4WlQ4e+Q9qhBypvU6majS9Vg/itN+LmTaHitP
         8QyQ==
X-Gm-Message-State: AOJu0YzPZJa7ayt8hAFaVfwy0ZFb0tmPfF4QWu2POpgqIBG5k7FQoQ3m
	08DHIb50pTKWOalu2iATOTgJWxe5mQEBjfnhaTFbXwVgimqkwGRSCbyBrOsVHhNZ4hg=
X-Gm-Gg: Acq92OGOyTH70vgTZpOyV0sNHqCInJYyUu7I44r2ysqt9iMrJErTtZ30G/Pomdxe1YK
	cJTTnkpXcOJRtgTc/CFgiCkVN7umHiyPdsdN4f4JjF0IljzyrDpUMH1BvXyMjzKYWDT1S54gmax
	d9eKFsrp5ACqwvenqb9WtHDp5YKhViBrBoWL8JJQ+shC5Ltags5pPBFzsY5l9+EsdBjbmevSf5r
	uRl0xpnMnA68esRrsj+h3aDI3yzFENU9djRqpG6FUtYwexVqN8eRhYUYptPVZd4nQc8SO6UirWe
	z1eyVCLPdg4hKUoat9RYIAgOYzIE0U9/3K5xL6lQqeG9oa4xrnlJkNgu9iZupdprzT+UaPYZlyN
	eylQFDtjHTee12L/wWAKPdv82w42069uQvE2a1HQ+OS0muZOe+aIhBh9/aEp3doNxW3xJOczHiF
	0+7FvE43e7uJuw43LU5o3waKDRp1HG
X-Received: by 2002:a05:600c:46cb:b0:48f:e044:927d with SMTP id 5b1f17b1804b1-49042480f2dmr146393555e9.10.1779628756730;
        Sun, 24 May 2026 06:19:16 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4904561f682sm193150815e9.13.2026.05.24.06.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 06:19:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tty: serial: rp2: Use named initializer for pci_device_id::driver_data
Date: Sun, 24 May 2026 15:19:05 +0200
Message-ID: <20260524131905.871222-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=axSRCVq18VKWIMh72f2wdBX29zYFYXgTiaCYH7DwIUM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqEvrJFSgB+A5iqm+vKBecDqgP9GBV/LWdjaEtT Ijz40qRsv6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahL6yQAKCRCPgPtYfRL+ Tv7zCACcgqXFY86w5fdAK7BTIrKPMuIrdnAdjaSANYubbSsQx2CbzWJXU3JOny/yT5/T7mVvuZl VqJfg4b733G9jIjQJFbbQzbvS0nXgiNWVn/pmK3ynopqZNB9+rC+AaQCYyWrQaQiT89s6u3M1gO ZFVsXxxjKmcNoo2KduQkdLqVc34mOekjirabe0KBCjK4srCc8iw0DZaG/iMLmQcbMYIkutW91Tz YuYAAEdLwUvW+AmQujV9kWz4aMMOdgN8u3Eql0xLbvRYHXmY/HYq0Hz9tHTIMUkcaGlhHyL3Vhx YI+EXcegWAMyv4z9xchJco3ejheMxPagqUyeCqwUWXRfjELr
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .driver_data member of the struct pci_device_id array were
initialized by list expressions relying on hidden assignment of .class
and .class_mask in PCI_VDEVICE().

Make the initialization more robust by using a named initializer. This
robustness is relevant for a planned change to struct pci_device_id that
replaces .driver_data by an anonymous union.

This change doesn't introduce changes to the compiled pci_device_id
array. Tested on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/rp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 6d99a02dd439..51e81ec0ffdb 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -197,7 +197,7 @@ struct rp2_card {
 };
 
 #define RP_ID(prod) PCI_VDEVICE(RP, (prod))
-#define RP_CAP(ports, smpte) (((ports) << 8) | ((smpte) << 0))
+#define RP_CAP(ports, smpte) .driver_data = (((ports) << 8) | ((smpte) << 0))
 
 static inline void rp2_decode_cap(const struct pci_device_id *id,
 				  int *ports, int *smpte)

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

