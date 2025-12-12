Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10C2836A0
	for <linux-serial@vger.kernel.org>; Fri, 12 Dec 2025 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765526976; cv=none; b=FCF46H7RhhYgSjcB/AY4X0s6J4svs1ziYw9O97cTd150MfVUVxyEOKtRRyEan/uGmc9yIECibKYoZ9ouSDoMty4hc5aj2EoQZsqceYWv+mAZXyqs1EwuUkQYjRAQIwdSkCZAnMakgEZzp+qKNs3Mh2OT3PsZuObYvbt5HZ9I1gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765526976; c=relaxed/simple;
	bh=vGCqn150HxJ8MtUS82THFrl3poKgmAltPNTl+cDcUXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJzW18exwOAmUeBaPw/OSjIRfUl3lDcfO4k1qZWfP29gJbrwqHpJ+dJe95fedcihHwE7cMzqcZHZorPbGIT15N8VNyAMEgwmUg/Pg0i53BFDupZxcbkSVe9VAJuJbkkddS76c9xVjIWewN6b5Dnj3ln4AT3lQhrFJ4Uj4gH8aGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R0hUYoJA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R0hUYoJA"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7636c96b9aso155837066b.2
        for <linux-serial@vger.kernel.org>; Fri, 12 Dec 2025 00:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765526972; x=1766131772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y/WEFvgJT6eEHgu+k37sR9i/F7SLQirVFkB830SU88=;
        b=R0hUYoJAVQB/gwRtuYrNlc52M9GwgKaKWUu5W6wngJjA2mlCirwQ7gZXbKGG8FH8uj
         wPe5yigR15O7qcEvaB109fMKlU8XdRPMQWx2y4O9rzzv6/csg0wu9JoC4SwwMSSVpKen
         AoP0owNeUelFOqlpytEgc9ux4heexokA8kRObfoJsIzv/6IB7cYVSSJTEXjrZ2ubXma0
         n4BekFOXY46m4H4iR2TZdkeOQRtn0l0f9gQoHwTl3nwJHgO1mlCmmyYfJjzc6CNjz+Of
         m1Vlo9vIJDUcHtS/LvlZeP/mWFq2ZQCeQOtgy12oF9htsQt5/RpW8BrL4mJmYM9dEx0p
         OD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765526972; x=1766131772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8y/WEFvgJT6eEHgu+k37sR9i/F7SLQirVFkB830SU88=;
        b=Q1zfdjtMF7T9WhWULdoPDqXfCLOlLqmv+3nSanevBdA5IDV4SAkfIjWuU+KX/JDJI4
         89RBhcOUpGHoynYdWn07FyJ57gZgt3ie7N9zxX1dKaORvZH/d0nuVb15qyLbeMIw4xUo
         MG0EtTpCmDMdfkSXE84dtBHg5YZChh/9SPk47FxWsDjo4L+2X1VrnmCOXbsP89tRoxUC
         sdDB0YN1X6+qOdIJoOY9kxqTeqj5HXbAVPs9S6geOJiJ+Z1iZn2c6AaYC4IOcSAL3SNJ
         ayWQWDHAPswNRukcsBsTzqn/iwW9Bb9LC/RIGyHepdTp4+UXmX9y7iGqubI83vOZzC8+
         FK3Q==
X-Gm-Message-State: AOJu0Yx1OfadPjOrFrwEb3xGXTTbXPrqxKRTixeeqNtCRWGOari1ntT8
	2HxLw/pOCZ7xItm/dH2f44N/HYm+0B8P/cfJB9O2AzyvSvplVGtb4G3VxsWOVvfmoZQ=
X-Gm-Gg: AY/fxX6sMBns6CkYHGhZFMVO79vhaEioKwqTVImbMx4j29dx06hXh+koEd4MChpOJN/
	TBAJKquCiZrcDynLcxrlU6Lr1jiCgzOhi1n20qS4gKSHdJaJJzx+HWmXQyMqAxHLQ5U2Kv93rrc
	v0xVcwsVVL9fkc+QUTLkQ5+rzFVLHe69rMuoW2sGG6Fsk+YnuLN/0oOn579Vx/+8XG9ubVy3p4H
	8uqEK9KyL1istbIW2QL3fbRNFPTuBSkCkZkQGGpe60hLdxJs02LnXExNE8BVIXLF+c3YKjwx9Oc
	mDgxM+N9g5dEQaInkMHXKJMOf59hm42+tD46MMBQKR6fbYTyYvWAGnCzgcgKwpG+quQHtv0pZQ0
	VCYXkE52hCKiqJ0G4U4q+ohxbjSzP7+tA/4GiGeK8hOJtcSA4kAeRA/sp5J8xkj9M+NEimAeayg
	biORHG7mEL0TrrJkAlROlvqN+UnQUCoXziNmj9GBJF/Xqv1jbAnJDzEhNeBzF6uyMd/ov5sahAs
	BE=
X-Google-Smtp-Source: AGHT+IEohkTFv9UGpNtY2ozJvK2nVZCaxRUfnkar2d2p6ZOEFnhYgp34EQJbKoIx1beUIjQCif+2vg==
X-Received: by 2002:a17:906:c116:b0:b79:ff35:660d with SMTP id a640c23a62f3a-b7d2366fa8cmr104151166b.26.1765526972273;
        Fri, 12 Dec 2025 00:09:32 -0800 (PST)
Received: from localhost (p200300f65f0066082ad4229ee042f7ed.dip0.t-ipconnect.de. [2003:f6:5f00:6608:2ad4:229e:e042:f7ed])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa51701csm495212666b.39.2025.12.12.00.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:09:31 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-serial@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 3/4] Bluetooth: hci_qca: Migrate to serdev specific shutdown function
Date: Fri, 12 Dec 2025 09:09:08 +0100
Message-ID:  <261a3384e25c4837d4efee87958805f15d7d4e3c.1765526117.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765526117.git.u.kleine-koenig@baylibre.com>
References: <cover.1765526117.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vGCqn150HxJ8MtUS82THFrl3poKgmAltPNTl+cDcUXM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpO82sxCSR+zwaL8wDmy0pjGy+036YQlzwewAee +DNGGdXGWKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTvNrAAKCRCPgPtYfRL+ TsKtB/9EXul1lR98OzVC2zAr/SX+GDH8vkOKTQisjlrgA5rSXHSYHpcVKRVU/9TI9aLBqaXcFRb 61y68nDql3f4Enbd32XDWeAcVznqAVWmV5II4OzWWgbty2AxYtJ7h5FnhQVUFtCLEYhEj/n+Dc1 FtXygeQbTWZy4VTu7CkOZGHrQ9icdxPke57nWuuCsJ7rM6UVpOueeyoy0rXIFwSZoTQKXLuoZBh M13nOyd+FDb2FXWo4voHpGMHzZIfUlHMS05kJP1jYHbQyA4GdYVA0epVDvPhJg7oiVZcuJ/nS1+ gqi9HeXXW/dpxJSfwKt63ZDGK2QP3VfYdf2MX74n4n2LdYtm
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This saves a cast in the driver. The motivation is stop using the callback
.shutdown in qca_serdev_driver.driver to make it possible to drop that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/bluetooth/hci_qca.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 888176b0faa9..6d54f747fde4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2530,11 +2530,10 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	hci_uart_unregister_device(&qcadev->serdev_hu);
 }
 
-static void qca_serdev_shutdown(struct device *dev)
+static void qca_serdev_shutdown(struct serdev_device *serdev)
 {
 	int ret;
 	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
-	struct serdev_device *serdev = to_serdev_device(dev);
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct hci_uart *hu = &qcadev->serdev_hu;
 	struct hci_dev *hdev = hu->hdev;
@@ -2756,11 +2755,11 @@ static void hciqca_coredump(struct device *dev)
 static struct serdev_device_driver qca_serdev_driver = {
 	.probe = qca_serdev_probe,
 	.remove = qca_serdev_remove,
+	.shutdown = qca_serdev_shutdown,
 	.driver = {
 		.name = "hci_uart_qca",
 		.of_match_table = of_match_ptr(qca_bluetooth_of_match),
 		.acpi_match_table = ACPI_PTR(qca_bluetooth_acpi_match),
-		.shutdown = qca_serdev_shutdown,
 		.pm = &qca_pm_ops,
 #ifdef CONFIG_DEV_COREDUMP
 		.coredump = hciqca_coredump,
-- 
2.47.3

