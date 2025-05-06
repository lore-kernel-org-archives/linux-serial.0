Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44550280000;
	Tue,  6 May 2025 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746535910; cv=none; b=Ub5R6jAX0SUAVIazEz1LYyJR8ssRKFp5QfFsxC0m871I6rPrzOUwYIfsdApbvEXkPvXQ7OyhidWmKrwy4XuMolQ8R6xJk0ToRY+3lhwv2Uj2+dCWMWdo5yTPabSa25U2cdc6iWpVJMeh2THJ07V+wQ/dkMFoFsKVLqEaps8ZcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746535910; c=relaxed/simple;
	bh=XwcK4xNdJ5bqnZI9n1Ki4hOFLIohBhzddbgDl9oczSs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+MWdTSaakb9b8gjPQtFuDBnmSdZWkjKM7FfAUmEYjUAADNphSuV6NBziCALLlim7X+q1N9yGKpe+SkqF9BFACrTzfcfTPwseVGO/ptFiPKo44Irw7JRDhocDKzo61FG+W1VG0nfUR/Uy1oUV0JiSEPfGCR8pglU3bWo0lMrVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xriuQwmg; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xriuQwmg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1746535907; x=1746795107;
	bh=XwcK4xNdJ5bqnZI9n1Ki4hOFLIohBhzddbgDl9oczSs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=xriuQwmgfNo5DJYwsgvwXvgfFBiWmCAPaxQdVdukMugEO9rR5CTpY8eU3pRNj1f9x
	 naLNfbifRO65P3pmphcdCQfj01iN+4Nl0BzL3XCzMDveTZTTf2KiQ7WQAXfq6oeH0r
	 VW5A9adatchp3fDbcA59DQeQkLrWtaWzBcO1incMCbLxhDtvmopzRobokwGufC7sn+
	 W6SvnuXs0Nj4vGf78CECa5asUyKLXZri45ydxvnOeRdcVTvhLb6et67k4SsgqBimgl
	 aM8a2Wf0WxrrlKy35DnJCNnlzoM8M1qpgPDUhulOq36d6LRBRBUvdWA5gejYMuYv4G
	 CPwtRcrehi+fQ==
Date: Tue, 06 May 2025 12:51:42 +0000
To: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, jason.wessel@windriver.com, danielt@kernel.org, dianders@chromium.org, jirislaby@kernel.org
From: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: [RFC PATCH 1/2] driver core: faux: create the device if probe() is deferred too
Message-ID: <20250506125133.108786-2-nicolescu.roxana@protonmail.com>
In-Reply-To: <20250506125133.108786-1-nicolescu.roxana@protonmail.com>
References: <20250506125133.108786-1-nicolescu.roxana@protonmail.com>
Feedback-ID: 136600343:user:proton
X-Pm-Message-ID: 015bbc2fe70bde887f946c07da822d9b7a6c0ae5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

There are situations when the faux device is probed, it waits for the
availability for another piece of hardware. In case this dependency is not
available, it can return -EPROBE_DEFER and probe will be retried later.
But, with the current implementation, probe won't be retried at all
because we destroyed the faux device in case probe did not return 0 and
therefore the device is binded to the driver.

To solve this, the faux device creation fails only when probe failed with
something other than -EPROBE_DEFER. In order to achieve this, a boolean
var is used in struct faux_object.

Signed-off-by: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
---
 drivers/base/faux.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 407c1d1aad50..21e385631872 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -25,6 +25,7 @@
 struct faux_object {
 =09struct faux_device faux_dev;
 =09const struct faux_device_ops *faux_ops;
+=09bool probe_successed_or_deferred;
 };
 #define to_faux_object(dev) container_of_const(dev, struct faux_object, fa=
ux_dev.dev)
=20
@@ -48,6 +49,8 @@ static int faux_probe(struct device *dev)
 =09if (faux_ops && faux_ops->probe)
 =09=09ret =3D faux_ops->probe(faux_dev);
=20
+=09faux_obj->probe_successed_or_deferred =3D !ret || ret =3D=3D -EPROBE_DE=
FER;
+
 =09return ret;
 }
=20
@@ -150,12 +153,13 @@ struct faux_device *faux_device_create_with_groups(co=
nst char *name,
 =09}
=20
 =09/*
-=09 * Verify that we did bind the driver to the device (i.e. probe worked)=
,
+=09 * Verify that we either did bind the driver to the device (i.e. probe =
worked),
+=09 * or probe is deferred and tried later,
 =09 * if not, let's fail the creation as trying to guess if probe was
 =09 * successful is almost impossible to determine by the caller.
 =09 */
-=09if (!dev->driver) {
-=09=09dev_err(dev, "probe did not succeed, tearing down the device\n");
+=09if (!faux_obj->probe_successed_or_deferred) {
+=09=09dev_err(dev, "probe did not succeed and it's not deferred, tearing d=
own the device\n");
 =09=09faux_device_destroy(faux_dev);
 =09=09faux_dev =3D NULL;
 =09}
--=20
2.34.1


