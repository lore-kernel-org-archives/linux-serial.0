Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733258;
	b=mPwpcaXQojN+M8qKMe5JWm6WlKy9uDwzNWzy2C1IqEsp+mewNG9DBfsGBoxrU8rrAr3T
	 JNVU+cXtqDOO8Wmt2r5eY/J9hmH5/hRJmOfE8cWh2yBM+XCOsWfC3gYMruzRhZ7s+HKTi
	 JlAOuKJ3RPDIRdxhThanDz2CF05BAMvMetIiycMSOZ0HeR7kvv9KteQIN1rwI0rHW4us6
	 gKfVgMnuOud1hmqoxumi1UPdlBHe9E3NmTKfXvmB544avR1C6+/S4h39KL8ReiyKe7uVY
	 ckjO6+UAUAm/ekN17vUTMd0rCZjcA4dMKQGVVzamquiPIsIPjTHGJAWv7ple+6eq6mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733258;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IMwZb/VFaN95E89jP9ukm1SSK05tIJqySoFJB1gotfQ=;
	b=C7HqgWQ3JTjNrMUJuZyvmK+ZPM5LJUvHCxoGPmvH2Xzer9hJbtS3taojbPNBpIak/Luc
	 ciNUiY/lVWV3IU105/DYuMDWkhs9oWXSi+RAtsQJOWqfIrau6B5LsA1BBOJYnUWG1japL
	 jPuVga8iT44ZRN4ysZPoeeDPm3XYqsopkHc5z1Zi6EIPBn01xTaY0BeIGbSGeRknDAM6M
	 R+Hd+xDKcRWjIFp1gPxWOEYGHaOrlzGQxgOEepGtGRhIcg/tQHmCGc5GNbb18L+4ENsHB
	 LTgXu/wpGwTS2Dzg2JQLvldd2BrFQhLXJk6DNCrpophF6l92bE7b1U3PsjFR2S2L6Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=P8O01mz6;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF1606A333
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 05:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7EF1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=P8O01mz6
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8222040130
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 05:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792733256;
	bh=IMwZb/VFaN95E89jP9ukm1SSK05tIJqySoFJB1gotfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=P8O01mz6SO9B4BmONAdGWQqB1auURsK/bdp1Vo4IPl5at9Gh3c6XNnH7r5EzmmidK
	 46wMLeVg7bFfofbGPFk34BDtwi79L7D8T+pBviSUplZPwtVH/ALpqGENSeybb/6ucs
	 7Gn5biUDw0fp0sTtjY8JtUNKNYNytI3cgOWAxJqGpZVHSrFXiN7FQlRDTgXJpxWJxe
	 2M35YE7ViMaTfs2bPlKKlU5TfgU9P/0iJ1gOQ2qnbjo5qeYjl6rP+1IvbKrCnq4vHu
	 ime9ci7BzR3yxPF15fQDyah9PAccPnDiAH0ULV6a8Xqr5vfUsBSuq2QZ2BlR8vbnb0
	 MA4iFucwFpDCQZjkNP3B6hNnz0xi/IReu47jCYPvuvtexbVr1r39ubXnKyZa+kOAwa
	 00W3WXoCUrjeO4WfgHUg4emQuBOUVSkFrXRur0w5zZzix4QM9GHMDTPTjCb+pn7TVX
	 dY0koDcG6mDa7j2LBPyvHiEltn4iY29bue6MIRk4DsTXUcu/7Yht92guvmYyTLe3FI
	 +l2BvVa+Kx195L2VAFuflqMgXVwMwusWdEmuKDGZdgp/wgY6G9lREgzG1kenD9pbLt
	 mvGDxGcb8oVZ/R5wS8uUi7HkD5rPfoss7oyHWahQ4tjTBUqV1lK4dOd1Ps1xx5d3AL
	 TKhe4DWS26YmYirKss2RxukQ=
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-313b1501a0aso73585eec.0
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 22:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792733255; x=1793338055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IMwZb/VFaN95E89jP9ukm1SSK05tIJqySoFJB1gotfQ=;
        b=GSjcD3+S7K7LObqE2wka6HAoXdwB7cnBpmlX4Hg+TJj/onYWqPiooQvWlF3r+tN+X8
         WXc0Ee7lOpRuhbuoqyhyazKPXVe9Lm1N28f7cWn+h8/Ho7mURy2yqWxIVaXivmRB11vL
         S9Lu9Tth2CQ2psgTASl4DFGPzapPJKjq944wXDe2A0vKH19rBYOY31O361fUFBAKoeQ7
         JzLQgutSZsB82c4UW+OsMza/qGulZZ69teteu9wt/qEjTSN0JZGzyIUq7tSwDcAoek6N
         zt8S6/tuI6SnM1XCxcOEK5pm5TfenTW/pCYNq7HCIT/wTOO25UMfs4u/Ahy1P7+nkdn1
         k/0Q==
X-Gm-Message-State: AFq9FYLnLHd7FecOa8oh3l/ZEVJEAQxUM0qeZiu8lffsFI9Hnt7LR7lM
	UB7qBHARsBTo8SixjdHHIwpFvfVC9tTNvDBCCnx+hqAnrc466yXCePsyOdV/FHuuzxrgY9VRKuy
	AFaen29nHvNZdk3Pm7VM8G2jAajba9RJ1EONFB9St6JXLFS1ZawtAP70d3K065VSs/+9uykxGZo
	SIK5dW3lBcMWFbyQ==
X-Gm-Gg: AYBFou3ARhZ/MP5hGeduo3gYnbHD/xMsldab5gGE5Ys3qBpH6Nj4EkdAO0cYZnXiRp7
	7tIXSc15+km9B6DzZfdhEDGdhqDx9P5LLhz2qKVa9sfrv3Pi/a0ZjCeQ2pJpQ+4PgQrMkhGnkut
	8jOsJlvuUrdHK6Xb/TjD2ADKsFw2+73hwoO0yEBklgQprKTh/cLafRUgpClIOVHtxINgwwghMOj
	EWllIZxuIK4/OFiatjjEnQWHRcW6iPOqMch1HPgIcgsrDaZzQFUE00pnHDnKnR/d48ptpcyNa1m
	3ch4z+4BP+UM+hJ+bjb1Abpdm/tRedmQ3KJsRefLXcznMu7Xf1SLMxoXUiNPgbx6pB17Qk+tDsG
	9w4PZRLFXkVj6Rxn5z42xuYMgPWz44KAwiHeTOUcQWWumX7Oy5jnWSZoPZGgQYbcPFFuOjQVeaA
	NqA9xtd/IvANfPXx1HevahyAsPw9NJHvSybp+4slRkFBCYdbsA5H42dPV7VEvhjPLrlJPgB/1nX
	jcWJrsvFmK82yDN1fsT4Lj2ly95FCtMGih1kyxTbGM=
X-Received: by 2002:a05:693c:87d1:10b0:367:2bed:e7a5 with SMTP id 5a478bee46e88-369d978c94dmr2892487eec.2.1792733254840;
        Thu, 22 Oct 2026 22:27:34 -0700 (PDT)
X-Received: by 2002:a05:693c:87d1:10b0:367:2bed:e7a5 with SMTP id 5a478bee46e88-369d978c94dmr2892448eec.2.1792733254322;
        Thu, 22 Oct 2026 22:27:34 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-b47a-213f-cf99-45b4.dynamic-ip6.hinet.net. [2001:b011:2008:445c:b47a:213f:cf99:45b4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9e1a085sm3590098eec.29.2026.10.22.22.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:27:33 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: linux-serial@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	markus.probst@posteo.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com
Subject: [PATCH v3 3/3] platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal serdev matching
Date: Fri, 23 Oct 2026 13:27:17 +0800
Message-Id: <20261023052717.2577234-4-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023052717.2577234-1-an.wu@canonical.com>
References: <20261023052717.2577234-1-an.wu@canonical.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The software-node-backed serdev client cannot be matched through ACPI or
device tree and is force-attached to its driver.

Set the modalias of the client before adding it and give the serdev
driver a matching id_table, so that the serdev core binds the two
through normal matching. Deferred probing is then handled by the driver
core, so the -EAGAIN translation is no longer needed.

A failing serdev probe no longer propagates out of the platform probe;
as for any other bus, the client is simply left unbound.

Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
Changes in v3:
- Use serdev_device_set_modalias() instead of ::name; add an id_table
  to the serdev driver

Changes in v2:
- New in v2

 .../lenovo/yoga-tab2-pro-1380-fastcharger.c   | 27 +++++++++----------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
index 8551ab4d2c7d..31780c4aebe0 100644
--- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
+++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
@@ -219,11 +219,17 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
 	return 0;
 }
 
+static const struct serdev_device_id yt2_1380_fc_serdev_id_table[] = {
+	{ KBUILD_MODNAME },
+	{ }
+};
+
 static struct serdev_device_driver yt2_1380_fc_serdev_driver = {
 	.probe = yt2_1380_fc_serdev_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
 	},
+	.id_table = yt2_1380_fc_serdev_id_table,
 };
 
 static const struct pinctrl_map yt2_1380_fc_pinctrl_map[] = {
@@ -260,25 +266,14 @@ static int yt2_1380_fc_pdev_probe(struct platform_device *pdev)
 	/* The fwnode is a managed node, so it will be auto-put on serdev_device_put() */
 	fwnode_handle_get(dev_fwnode(&serdev->dev));
 
+	serdev_device_set_modalias(serdev, KBUILD_MODNAME);
+
 	ret = serdev_device_add(serdev);
 	if (ret) {
 		serdev_device_put(serdev);
 		return dev_err_probe(&pdev->dev, ret, "adding serdev\n");
 	}
 
-	/*
-	 * serdev device <-> driver matching relies on OF or ACPI matches and
-	 * neither is available here, manually bind the driver.
-	 */
-	ret = device_driver_attach(&yt2_1380_fc_serdev_driver.driver, &serdev->dev);
-	if (ret) {
-		/* device_driver_attach() maps EPROBE_DEFER to EAGAIN, map it back */
-		serdev_device_remove(serdev);
-		return dev_err_probe(&pdev->dev,
-				     (ret == -EAGAIN) ? -EPROBE_DEFER : ret,
-				     "attaching serdev driver\n");
-	}
-
 	/* So that yt2_1380_fc_pdev_remove() can remove the serdev */
 	platform_set_drvdata(pdev, serdev);
 	return 0;
@@ -305,8 +300,10 @@ static int __init yt2_1380_fc_module_init(void)
 	int ret;
 
 	/*
-	 * serdev driver MUST be registered first because pdev driver calls
-	 * device_driver_attach() on the serdev, serdev-driver pair.
+	 * Register the serdev driver first, so that the serdev device which
+	 * the pdev driver's probe() adds is matched as soon as it is added.
+	 * Registering it afterwards would work as well, since driver_register()
+	 * also walks the devices which are already on the bus.
 	 */
 	ret = serdev_device_driver_register(&yt2_1380_fc_serdev_driver);
 	if (ret)
-- 
2.34.1

