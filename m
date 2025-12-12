Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEC630E0C3
	for <linux-serial@vger.kernel.org>; Fri, 12 Dec 2025 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765526974; cv=none; b=upV2V2r74R8sSWro7Rmj9CLlkUc8I0ufNci7MERsC0unJ5Spl6jc9jXoUxEEVNG/6fMiR1aGwPe01oCifvVpLQlKaoAg07W8MSB2+i4lWwWbHBchNsYpkjefVrNYaSegiKTV0arFLJkKvFLu9LIqBQrd3nxnJwvKKbA84zA3/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765526974; c=relaxed/simple;
	bh=b3+1BSHKEriE+BOOjhyU+Q5HfXx5Jit8fTz6x7xXDrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ug3ot3cRkpXqTUcXzvfWWgQToMTKj9nm3pivs5IF+q6p/8pefSEsOgs/mTaszxoVPF2ED2G544YqLva6jLs61treNeyadEmgHm+YCjxA3qHKZWGCBtBPjpcQctHGIzHCdxWLztRLJEFRb4GPoZICprMX2rY49JP+osz90ppvngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XyZtPXYs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XyZtPXYs"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7277324204so154160766b.0
        for <linux-serial@vger.kernel.org>; Fri, 12 Dec 2025 00:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765526971; x=1766131771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDvoRPxfo0UTLmrRXNNxMV8vgJCyHqctKOanwR/car4=;
        b=XyZtPXYse1eMN0KSWaAZfoGQE3dDkt+gh2G4oaoot5GdsVECXtOX796AczaiHWD/1A
         m5SqP19L9dtRgH2jr1ncDN1s9n48By5oRBjeTVtYqVxG2LPbPMaHLy9+TUeP9VWl6+Wp
         wfk7jTDkPjSl4/BJ7MqiwmYu/ed7z7Mmv7TownGiCC9FD0pJnlDrFVMvMhktrRe1ZPA8
         zUn1GrhWUOYXfl6m/0ufYM0+mynh7Fnnklh6kwJFf075udBwGuNy7Ju7+z8foDF944um
         T2golp8ZMK4/dsQCCTlnFcQ5uhSOVTdAg4Ff0LJGsvvArgKwuGH3s1/9XB7Ul7ay7CwW
         IZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765526971; x=1766131771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IDvoRPxfo0UTLmrRXNNxMV8vgJCyHqctKOanwR/car4=;
        b=avZdn3nvcOnC1FqM/lrsSDtv57wsoffwVjQy6Z1/wzDqU0MrH9qZDn9LAi1ng1NXM7
         8Bw55x5bJB1xyZ+1oYacnysh5MFZ24R5/uIZCue71B1G3hQQT+lMSt6swzMmCulkegJ7
         J7OPnq3cMqhUxNa1wk5T3FarslG60stSiYGl0CFJbuOrM2Hpfp2tP28tjSY5fFf75CLI
         qpj6BN2ynNqoRkZ7EWkrocPCgLyOhBkSg+Bm2c4jkHXVnj1rL+p2xPJS2dL1XqxYOGwZ
         FfcgiIaBqvSik6aF77A9/2o/pfvApV1uZc/RgPzBmKseuaAdb5Rdh7Hhdvc2VJN4R2vU
         wp+Q==
X-Gm-Message-State: AOJu0YwKrVdQS/KaW1orRXQ+jmqWDLG8cTUPLQkJ+RhBrxZ9D4Q7mW07
	2YyEA7i0iyQsD0FLJ0EPw3fHahQG3rxxtOs3s9Zoqusxv3iwf+wI7pVgRbYRFie5AAo=
X-Gm-Gg: AY/fxX73hzu5FIL3qij5N5xiCUgLAu4JP4jWPPS7N+hFsceB8LOcuwSP4G+/8LG12UF
	pbf63uBQ6QlXt8Y14QdfiAZTFAuG/i6MvrWpAD6Zu0p7wbCUr5WPsnVqMZ6Mb3kATKr0A5mQSQd
	OXbqlsvGmnxe3Ygw7yrn4Qp8FCo5DMg4cE78yZ4vhNQyh0h+zofU/+KaXj2gIMSUnCvMUEQvdkm
	c85YPESerVYaj2eVG9JinFaJBhoEi0S2qnsXPvWe8Y1O7o2HscWurKNp9zh562aF6unsUT36phN
	ANj9HJ9R/d9J4SRer52b+2wozn2YDduWQXWWLb8iKMmzrCLfUOkanO07KLeqgnghdCbwxtn/ILC
	cOnx6f3jLy+/azeS99uKfmcgaSMK4LBaD6qYfxkPrWoNC9RQypLNEaqofXJlJg3DNxAPjpi+1ET
	eACjClbgg+mwCp7kdLL6uoS9V3KOqduign9cYNHdllfRzjgX7G8iEpifYAjdFYJJfs+NohQaTjN
	m4=
X-Google-Smtp-Source: AGHT+IHeyrUIhI68db/u51fxRe26pbqUxpR5tNRuOVM2VMrH9A3LQUK+QM6QK97/qCgE0PIxKDZHdQ==
X-Received: by 2002:a17:907:3da8:b0:b70:b93c:26cf with SMTP id a640c23a62f3a-b7d236f77f7mr104437466b.6.1765526970683;
        Fri, 12 Dec 2025 00:09:30 -0800 (PST)
Received: from localhost (p200300f65f0066082ad4229ee042f7ed.dip0.t-ipconnect.de. [2003:f6:5f00:6608:2ad4:229e:e042:f7ed])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa5d0b2csm498924166b.66.2025.12.12.00.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:09:30 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Li <yang.li@amlogic.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-serial@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/4] Bluetooth: hci_aml: Migrate to serdev specific shutdown function
Date: Fri, 12 Dec 2025 09:09:07 +0100
Message-ID:  <42ae20ba70ff6fbbbd9b846ac9acd0f7d58451b0.1765526117.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=b3+1BSHKEriE+BOOjhyU+Q5HfXx5Jit8fTz6x7xXDrM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpO82oZ0+ufEWq9BUz7hwiwmpxKZNjR7wVzyr4h ZGJh85xmXiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTvNqAAKCRCPgPtYfRL+ TtERB/42rvY7gjHYPHZyLWJgAXlhqzGYAqtP+GP+5kdzrAbEsNDdSD23dV+619mDjcSsuap4ZqC LgVdWJ7lQ5o6mxtwhCc0nkvtvyUYbhe16QCyId97/3m7B+KHLrmPM8jFeJ0B4h+sh/kEHJsCPAZ H0NeXrZ2JXziLZkzwpxskyMzx3MzasvNzSX85x+OYrcv7w6LI5Hq9Xz1KWTR32pWaE/ZEixvpsA s7bzY/Pl0FyrBdAyiIiz0z/c+gEUSjsTjLnQODOM7BuCPjaBkor4uSY28m28d2xoJH0e5NSJt3t 3BHh/mNxXp/8eKmZ2+cseQb13X+WmULqSPJnjsJLvgO20ZJQ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This saves a cast in the driver. The motivation is stop using the callback
.shutdown in qca_serdev_driver.driver to make it possible to drop that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/bluetooth/hci_aml.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
index b1f32c5a8a3f..4981c82d634d 100644
--- a/drivers/bluetooth/hci_aml.c
+++ b/drivers/bluetooth/hci_aml.c
@@ -677,13 +677,6 @@ static const struct hci_uart_proto aml_hci_proto = {
 	.dequeue	= aml_dequeue,
 };
 
-static void aml_device_driver_shutdown(struct device *dev)
-{
-	struct aml_serdev *amldev = dev_get_drvdata(dev);
-
-	aml_power_off(amldev);
-}
-
 static int aml_serdev_probe(struct serdev_device *serdev)
 {
 	struct aml_serdev *amldev;
@@ -714,6 +707,13 @@ static void aml_serdev_remove(struct serdev_device *serdev)
 	hci_uart_unregister_device(&amldev->serdev_hu);
 }
 
+static void aml_serdev_shutdown(struct serdev_device *serdev)
+{
+	struct aml_serdev *amldev = serdev_device_get_drvdata(serdev);
+
+	aml_power_off(amldev);
+}
+
 static const struct aml_device_data data_w155s2 = {
 	.iccm_offset = 256 * 1024,
 };
@@ -732,10 +732,10 @@ MODULE_DEVICE_TABLE(of, aml_bluetooth_of_match);
 static struct serdev_device_driver aml_serdev_driver = {
 	.probe = aml_serdev_probe,
 	.remove = aml_serdev_remove,
+	.shutdown = aml_serdev_shutdown,
 	.driver = {
 		.name = "hci_uart_aml",
 		.of_match_table = aml_bluetooth_of_match,
-		.shutdown = aml_device_driver_shutdown,
 	},
 };
 
-- 
2.47.3

