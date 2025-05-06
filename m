Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73A27FD5B
	for <linux-serial@vger.kernel.org>; Tue,  6 May 2025 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746535916; cv=none; b=AnHQBQv639E6OMELqDsfvXoV3gPIXOVy+sWl6FIfqzoFHhWLAvTRqLDJXQHUnTxqIlrhld39ZYY/CMRzO8MGp8x09G1PtAOnHxQNyMoD153k6rHfaWEOAZXqd30ZNmjtHYFLHWmT41jDe3WVdFyINMvmvwxvRndZOW+gpFzdQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746535916; c=relaxed/simple;
	bh=zK9w9rIJY/9mYRo0HXp9qe6o+/wCX4Pdi5dv42T1IzQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0+XUuqF03S8Q5xWKj2YanpZYNiwZK88E+cyFhqtzfJ1w61n6+nbhh2FTkriYL2WLiOp0X0NvCCzvU2peKcRF6EFfaBoa9PDKT9JJ8k4cnRBSj9UinnIgCY4596Mo8WoLIP1V5g2JGwPZYSo2OqAHHSiJT57d99Mko7Yz/maDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Kf3Te0Yh; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Kf3Te0Yh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1746535912; x=1746795112;
	bh=zzBJeXUf0V8P3H7TLaYvoaJ0zwNJmLoh71eDPNoDAJo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Kf3Te0YhCqJrqtUsS5gb51nXR8axsPP1nqL+iDY8TkMgQdzoCkx6O2c0UQU+0a+Jr
	 BHDQXEHA5FizNcgY8qlaulNEZ2XnQYRJSf4y6zfCu2/xeV2cjbT6eOg5+t+ww8NQ70
	 6ARuZu6ks9LXXszW5NUPrrnwa8AtbI4UxNoQDGj/UmWnq9ueKMvr6rHpD6RsgpvmCM
	 csM0jyxT3JMaWjMCYM6yXRrDR14iijkd8rQ8w+Bwi3gGvX6sBe6Nxpw+58KOxgz6Pz
	 +f3+32rXAd3cbOI9scolGovSLPCP93xmhxKq6FyjZM10Tx+Y8hPn3GkvRAqzrVKq6q
	 xLijbJzpPLOFw==
Date: Tue, 06 May 2025 12:51:48 +0000
To: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, jason.wessel@windriver.com, danielt@kernel.org, dianders@chromium.org, jirislaby@kernel.org
From: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: [RFC PATCH 2/2] serial: kgdboc: convert to use faux_device
Message-ID: <20250506125133.108786-3-nicolescu.roxana@protonmail.com>
In-Reply-To: <20250506125133.108786-1-nicolescu.roxana@protonmail.com>
References: <20250506125133.108786-1-nicolescu.roxana@protonmail.com>
Feedback-ID: 136600343:user:proton
X-Pm-Message-ID: fd5abac4492e3841c902f5b9b7f60d650c2de90c
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The kgdboc uses a "fake" platform device to handle tty drivers showing
up late. In case the tty device is not detected during probe, it will
return EPROBE_DEFER which means the probe will be called later when the
tty device might be there. Before this, the kgdboc driver
would be initialized early in the process (useful for early boot
debugging) but then the tty device wouldn't be there, and retry wouldn't be
done later. For a better explanation, see commit
'68e55f61c138: ("kgdboc: Use a platform device to handle tty drivers
showing up late")'.

This replaces the platform_device usage with faux_device which was
introduced recently for scenarios like this, where there is not real
platform device needed. Moreover, it makes the code cleaner than before.

Signed-off-by: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
---
 drivers/tty/serial/kgdboc.c | 50 +++++++++++--------------------------
 1 file changed, 14 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 85f6c5a76e0f..d1ffe6186685 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -21,7 +21,7 @@
 #include <linux/input.h>
 #include <linux/irq_work.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
+#include <linux/device/faux.h>
 #include <linux/serial_core.h>
=20
 #define MAX_CONFIG_LEN=09=0940
@@ -42,7 +42,7 @@ static int kgdboc_use_kms;  /* 1 if we use kernel mode sw=
itching */
 static struct tty_driver=09*kgdb_tty_driver;
 static int=09=09=09kgdb_tty_line;
=20
-static struct platform_device *kgdboc_pdev;
+static struct faux_device *kgdboc_fdev;
=20
 #if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
 static struct kgdb_io=09=09kgdboc_earlycon_io_ops;
@@ -259,7 +259,7 @@ static int configure_kgdboc(void)
 =09return err;
 }
=20
-static int kgdboc_probe(struct platform_device *pdev)
+static int kgdboc_probe(struct faux_device *fdev)
 {
 =09int ret =3D 0;
=20
@@ -276,47 +276,26 @@ static int kgdboc_probe(struct platform_device *pdev)
 =09return ret;
 }
=20
-static struct platform_driver kgdboc_platform_driver =3D {
+struct faux_device_ops kgdboc_driver =3D {
 =09.probe =3D kgdboc_probe,
-=09.driver =3D {
-=09=09.name =3D "kgdboc",
-=09=09.suppress_bind_attrs =3D true,
-=09},
 };
=20
 static int __init init_kgdboc(void)
 {
-=09int ret;
=20
 =09/*
-=09 * kgdboc is a little bit of an odd "platform_driver".  It can be
-=09 * up and running long before the platform_driver object is
-=09 * created and thus doesn't actually store anything in it.  There's
-=09 * only one instance of kgdb so anything is stored as global state.
-=09 * The platform_driver is only created so that we can leverage the
+=09 * There's only one instance of kgdb so anything is stored as global
+=09 * state.
+=09 * The faux_device is only created so that we can leverage the
 =09 * kernel's mechanisms (like -EPROBE_DEFER) to call us when our
-=09 * underlying tty is ready.  Here we init our platform driver and
-=09 * then create the single kgdboc instance.
+=09 * underlying tty is ready. Here we init our faux device kgdboc
+=09 * instance.
 =09 */
-=09ret =3D platform_driver_register(&kgdboc_platform_driver);
-=09if (ret)
-=09=09return ret;
-
-=09kgdboc_pdev =3D platform_device_alloc("kgdboc", PLATFORM_DEVID_NONE);
-=09if (!kgdboc_pdev) {
-=09=09ret =3D -ENOMEM;
-=09=09goto err_did_register;
-=09}
+=09kgdboc_fdev =3D faux_device_create("kgdboc", NULL, &kgdboc_driver);
+=09if (!kgdboc_fdev)
+=09=09return -ENOMEM;
=20
-=09ret =3D platform_device_add(kgdboc_pdev);
-=09if (!ret)
-=09=09return 0;
-
-=09platform_device_put(kgdboc_pdev);
-
-err_did_register:
-=09platform_driver_unregister(&kgdboc_platform_driver);
-=09return ret;
+=09return 0;
 }
=20
 static void exit_kgdboc(void)
@@ -325,8 +304,7 @@ static void exit_kgdboc(void)
 =09cleanup_kgdboc();
 =09mutex_unlock(&config_mutex);
=20
-=09platform_device_unregister(kgdboc_pdev);
-=09platform_driver_unregister(&kgdboc_platform_driver);
+=09faux_device_destroy(kgdboc_fdev);
 }
=20
 static int kgdboc_get_char(void)
--=20
2.34.1


