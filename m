Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792843504;
	b=IYY5yXon9Dn35CHMT43ofGFdPpDa2rEg3pjPpk4996GdN0bbJxbnii97tQTQYXEAQ8dp
	 1SgBOi0OyEqkrSW8OWLuNXvWvtHvxgMkWWFNFxAvosFkhTnNHW0kJsJ5Z8eV+7d3GKWCd
	 pqRF+8XEGwdAZ2qbwTx/JSoQkeIecifwmvp665MkUVq9+wL/JhBC05GrE5mjHrcv049BX
	 LgtVWu+51m4NIJykSmKcOAN/AXiWxtWiDL+SRIV6Y4Ed+ugrgh6P4Sij40iakjatVtIrT
	 FK6DTexkS6S2tzBDzPexK9up9xuTuX4sSKI7w1f4OYKGDTJUrVzCReQUWZZziOEHhlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792843504;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XcXND02uVU9mligWZKre8PewcZOkoWJ0b9UoDwiNQPw=;
	b=GmD/HIdMpDUbF8LXR/X/Kck3l7aP9//c8C3iG3Tj25BkoJim1b1IV6X4OpY1utRajhO3
	 H65OPizvli9gxlNgJn2DW2kx7HvYF4oiAar6gmtLqiTEc6a+D1cfllYC6VaOSdHDGJGit
	 qVayMP0L0pJOY85vYH/rPRVAxTBrUKLkeFOuCrD7HRpjhu1QcctdMEdAHqSuJubXVshPp
	 C7DVKo8ixcCVxf+wAfugAzlAsQyX85xPR3IJHqilYfEJGHUfyBUpe3oTmcRSQlON7C7TA
	 DGqFSFP/MnTVUGdHSetKDgnm03bGZVSYumVLYrut2gTq+kv1vdwb3YjAkz4tjyLRr+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=I0sgSLyf;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F54E606A339
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 12:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F54E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=I0sgSLyf
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 53A4B3F185
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792843502;
	bh=XcXND02uVU9mligWZKre8PewcZOkoWJ0b9UoDwiNQPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=I0sgSLyfiwSxnbjIJjhfm6g1YLsCEnhfuW5WZ6ZjzjYCbx3orKIIuYV0pRq0DzXvN
	 lOwRVWd4ByYKijLzCzVEzxbJE6JwbqXUsAxzysrLt5AoRHDoa+/Uhxt6ihfbKGrCcL
	 K1yi1AizLgrkT1WTv5qLTqlGM/WvuX+LbcAlhBtdYvWmLUsjahmmupNPpfuZerN+DZ
	 ZCqwCwU5vB2flUXABFQcsAuq5xdoTsA3shFrtWRjK7wS0KCO/FmJfL5Zg16cHOCuLW
	 Wjz0qxej8y5ERq4A/3nrV9UauyRdkVrV4ZkptuaDuXG9qdISqfDJF7cj/ssjaaobub
	 Teq1YkIeUH8lA3SshGx0Rugt/shlpmQL2fHCpcKNvseg+IM8dEkKvOeFrVyYUjzWve
	 wTeQo9etPzdY9PML+ZSi3RAcYO1fvRW3QZ5lRmL8tfup6vwJFQb4vB6rIWzCY1j/bC
	 y8ks4b7rn+Hr6sU3L9/xdwIZMiz728A0W1dy+eodYMMTVw6lqK0rAbKy9Vac1UF08K
	 m+wyFIzpe8Gdpb0wcN49oZ7sekN9u6PPMe3Qi4tSMPPjpr8aoo6qe/VbpKCeyBbruW
	 EF2InAednb9OijiUIavZjUUJd278+6LkX9DpnxZMibY16GfawjrpXLNGpG8iWWboJE
	 kbLZb6nsgHhZ0cE+7Le61Sv8=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad94b96698so489267a91.1
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 05:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792843501; x=1793448301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XcXND02uVU9mligWZKre8PewcZOkoWJ0b9UoDwiNQPw=;
        b=UZRVth2lQrVAUkQh7Yerp5J740NPzyVrbT+sEZu2AsoDe+TDluuRykyeY+zkF5pxsX
         KLoqTgiS65IYqkP//yQqzvWRrJdGUCODF+3iUcB2N3jvbb9BiwGH1EPchUrj4U0nTwz0
         lvJmsfqvYULzhSFFjbH5q4rnKkAfZV9Rjer6gg5M5JcOC+i/59puvt+OwY51JL1ENDTh
         7OH7cxEDd3qwKy1wVi9/PBioJ0QSWPeCgQfWI8El1NWGTHIgAZIFQKj9t/XGZG+6BDN0
         uWHNEjLQDiiuN2X2snsQ/zFoN6I/6d/2TjG2vSQ1NOW/0Pu253ky4QERT5NKpYK7da8F
         aV0g==
X-Gm-Message-State: AFq9FYJYZEIRZTI2PPzhAgr9eSMaVe+gWFK5gfGnipKslI1cNKM+6OXm
	vVHpG7Qu0lY5fBOdC+NseiOfPdwQE98qlyQpzYhIv/XJeguVSl7zAvCz/NcFdIqHYkzwOGvv6Vc
	9hi2krnB/lx3TRFuG8JFzpLYsf2/n2CoOhESUZaW922FRzeZRH05i1BFpKlNlaMtJGeNl2l6X0w
	dAkAsN6t7FsB5VTQ==
X-Gm-Gg: AYBFou2D56+LzhzUbX0I3KlYifQ4qhJeAE+2z+06xJ779paSRkauOyjrfQ5xp7BWtnk
	aQoU9Zf4IqVAPjQGZYrFty4pT4o8ORMj+mYArfroOstxo97xo37otDanOWdzYTyPAluPGO8osPM
	fqS//ZlJUcCTNd88SgnelRwUs3+frIptveCITKuNYkMrWZq0NmH46jRIg3CYNxSWsTftmhFRvkf
	pZLrbNLLTDdys9a0dPxvdur+OoL64/wROV3w5p/GSRPMhP0jPDxjVu/r4DMsPHmz4HWcHlGvRIk
	2mx5D18dT/K4g68lRoooYOry+H+bqZo6pLlql2H1BQtn0I0i0NUKlICjwkQgrknOirefKwJ0zj6
	V5O7Eil0QZiZPKLxizPHufov0efu1REF/F4jYV956yi+QrkR9VYCH7u+GA+bZPJvCwsqRupH+4F
	6HXRFtcqMRpuRmxt0bRquPW2L8Qlbr2ie8R9Vk3NMFLkmnFc64GVLiGfKG6JepNDfzVgzUIFHP/
	y+2Sq8awsZSrAMC0lY16S6N5RvlrKZbi983AOimzg==
X-Received: by 2002:a17:90b:580c:b0:3ac:73c7:9c07 with SMTP id 98e67ed59e1d1-3ade953ea72mr2539072a91.0.1792843500792;
        Sat, 24 Oct 2026 05:05:00 -0700 (PDT)
X-Received: by 2002:a17:90b:580c:b0:3ac:73c7:9c07 with SMTP id 98e67ed59e1d1-3ade953ea72mr2539026a91.0.1792843500265;
        Sat, 24 Oct 2026 05:05:00 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-0e25-4b6d-1924-440d.dynamic-ip6.hinet.net. [2001:b011:2008:445c:e25:4b6d:1924:440d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb24a04sm2893409a91.16.2026.10.24.05.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:04:59 -0700 (PDT)
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
Subject: [PATCH v5 3/3] platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal serdev matching
Date: Sat, 24 Oct 2026 20:04:40 +0800
Message-Id: <5e70a181599ada304c6aa6589cc61662f1a8d710.1792831564.git.an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792831564.git.an.wu@canonical.com>
References: <cover.1792831564.git.an.wu@canonical.com>
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

Pass the modalias to serdev_device_add() and give the serdev driver a
matching id_table, so that the serdev core binds the two through normal
matching. Deferred probing is then handled by the driver core, so the
-EAGAIN translation is no longer needed.

A failing serdev probe no longer propagates out of the platform probe;
as for any other bus, the client is simply left unbound.

Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
 .../lenovo/yoga-tab2-pro-1380-fastcharger.c   | 25 +++++++------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
index 8551ab4d2c7d..d0bd9d4e3137 100644
--- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
+++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
@@ -219,11 +219,17 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
 	return 0;
 }
 
+static const struct serdev_device_id yt2_1380_fc_serdev_id[] = {
+	{ KBUILD_MODNAME },
+	{ }
+};
+
 static struct serdev_device_driver yt2_1380_fc_serdev_driver = {
 	.probe = yt2_1380_fc_serdev_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
 	},
+	.id_table = yt2_1380_fc_serdev_id,
 };
 
 static const struct pinctrl_map yt2_1380_fc_pinctrl_map[] = {
@@ -260,25 +266,12 @@ static int yt2_1380_fc_pdev_probe(struct platform_device *pdev)
 	/* The fwnode is a managed node, so it will be auto-put on serdev_device_put() */
 	fwnode_handle_get(dev_fwnode(&serdev->dev));
 
-	ret = serdev_device_add(serdev);
+	ret = serdev_device_add(serdev, KBUILD_MODNAME);
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
@@ -305,8 +298,8 @@ static int __init yt2_1380_fc_module_init(void)
 	int ret;
 
 	/*
-	 * serdev driver MUST be registered first because pdev driver calls
-	 * device_driver_attach() on the serdev, serdev-driver pair.
+	 * serdev driver MUST be registered first so that the serdev device
+	 * created by the pdev probe binds to it via the id_table match.
 	 */
 	ret = serdev_device_driver_register(&yt2_1380_fc_serdev_driver);
 	if (ret)
-- 
2.34.1

