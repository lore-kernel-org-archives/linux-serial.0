Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792847049;
	b=atgQdkkDNPqcis5eavnPt5fm0qoHCg4aEKqopHeTp+PI+RbxY3lXE8kzkw9yqLLzrsLH
	 8+Hc1MGZupAQbIIfyyx80p7TwvYTflw+ukKrC/2VgwBRQXFQyZaiwRRnXayYtvKNkgoaG
	 zcgGPwD86aIaQoutgBFTPUmGrAHRl8U9Q3c7fjqqr0kmvJTyWAHB2oq5et5k4HZLIl4PY
	 mhyhk3FGnOdlfg7wkdivel6RtzMUvSlOecs6klkjnwa2aC7O0eEGYtssUVB1k6PWdnqYq
	 vEWPcnfXAVWPy5DfNL4w9XSx/ni9GGwOba7QSEXcMAoereMZVun9QV3WsHKry0Qe65w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792847049;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=jweyIax9MrNM41Fr612IpxPDanPG1QtsYbhddNSLtBI=;
	b=Pj+XdXxiAub3mXv23+nSyhV8uqqmQQ7XPvLJKjmxRj9mc7/anpenubfL7lTdgRZMyfYl
	 8L1ysjlLevLpfQlQZSvW4aaB+dGzT/4XRAtQSa5+KPhAyIkNlyfKkxGpD/P9QufzDWgv9
	 IZ1MLyS8MH73GMYuFR1MgNRZyOcvkmSTdbYSKjgcfbhesraioKU436IvCVmTdVrI7DgXn
	 8LMb6ZSQIseKHbxTl3ViX1LJb+lGLPHC27mdxkhD/6oJl7CHkcHwZDxh94GflnBLJv48O
	 Psef+XN11tXIbBY70wXs4efrH8JbUJJExZwCZaLwjguipZ7AJpaoZSo7HyiO//PKnnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=J081P02C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68839606A31D
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68839606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=J081P02C
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6263C3F2CA
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792847041;
	bh=jweyIax9MrNM41Fr612IpxPDanPG1QtsYbhddNSLtBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=J081P02CAlTCiGfWPnPfcDM1cIpzn1i0Cpju0qGwil8Zkw7kBT9u7sOdT06rcw4Vz
	 amBjQ2YzLt5/s3ZTwKv+rtlfW9IjfXKS/z/FIsZkwfOfsTvzy7jAtDdUBzTinWnI0H
	 tiNHYF5cgk1nB+PhpV1RsmKKaIbzx/GfIx7PWFoJ9d26mTNnVmEpnRp7TGl96oJIHD
	 3ZJRRBnsTx89x05294tCzQfZzVxQQSzG+KqBZujLPlX7CDUmACkwbFnKr8CQ9/spZ7
	 gfipDEcx0Ha+Qrt6cWKT5jmV+3szXhaAnZ9I5X0gA1dJi1FLrPxAPgCaS8UGY0NMio
	 gjaAQLXer5qZEzOrc1KTGLv/0PgdIwkOgKaKB3KSi6hrcHWevw131PfquPo646N5Pt
	 hIStF4ff9Is2K9k1ATtBPO3fiFhlKCxnOetVXyXIADciwNQ6GYxSs92NC/FUAj3Jc6
	 RBvH64wzaBsxnYSEP+XxFLf831vVpmz8za+xv/o7fO6OY+peOot2ydHwXAfKu0Kis8
	 kGCov2R0oyzImlYw0t7dhk7akDLdeTKotKX8ZPXAnQ1FTDRX6wHq/uFP5rjFzteU9h
	 6WF5hHizgXzmS5T8P3Gre1JUa6wZK1zhNKtqP4ww/ToanF/ZIabONCSOD2SBj0HKpE
	 Krz2Rt6uCL1kwasQ++N+KWl4=
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-8003169e5c5so990214a34.0
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 06:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792847040; cv=none;
        d=google.com; s=arc-20260327;
        b=l1f4MLAAErnpJq5ySkqkwnicWbHAoPBLPKjmKjDkKu3LTjcyKqQTKXjawGlOa+tGds
         T1uw3eyBh3wbQMM3cPxj139Edi5xLgK15sIUX1ZvLjHopOEEFDvphYiKqoZukHzQHyoG
         lSPevzGvaDpH6TZq/CFG+OFo2H2AdjQODdaiBo7ifHAUHdsmtVK3vtxwWqW+Vv6RgOdh
         meraO8VV6g2VGMZD35Md3tbxkKI/QPmw2GClMFzlQlZTvMPho0ftIPxQl9CgD7zgTJhH
         rPzbBNiGCQcb4PioZDUjdY8QeJKTJ/xzDgjAbJxRnJu3ji8IBBQabydUoUAK+syFb24a
         44FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=jweyIax9MrNM41Fr612IpxPDanPG1QtsYbhddNSLtBI=;
        fh=i8k/WQmyUQqTE3XMrvklFnwS4lREq9vRtl7rqxDWsaI=;
        b=dJKjj5UXUysVWmjGQN4olPn2r+WVhGDuLXsWNpahHFaaGlIwe6VBrpDpChnL9Ea1Xe
         V4IjnZuxv9/R/gB0J02Ibu25nz+96PewYmCK7u0j0I4L19HLnGsJJRhQQXbf0L4pzpMD
         loeBIAvKJnroL2pd4vW16wnDjyrq7tWeF5SkKLf3DfzIhNDdIwgHt/fy267lyJDqy/Jy
         CtFZQ94rRLIXmDrT3qtwtlY1H364J+lO5iovtZSTUP1O38xkdE5+PL/4gyC1vwLXPpwW
         0JcVrdb9OZ/KpipELGZJ7VW40qWmQJ9apk5a+0b6VAaAxU7Q+E41pXUYIj+5ZF3MLS7q
         miHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792847040; x=1793451840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jweyIax9MrNM41Fr612IpxPDanPG1QtsYbhddNSLtBI=;
        b=O6XQBt8xFQo9dsioU0Cj4A/W8Eue1AuNwrlVMC9t/VUzE3L0Z3AUQoY1EqkJyl0kHi
         ych4Pg2MBHW3D1s2nRFvL6IYFNAXJtTl8QDB60JPXvMf/BIkKBmCQERcK3nNtWjtijO5
         0mH9/dSM+wcCW3kxfEpT2gRSS/ALR5ZLgdeZTSXiUynx2JAvhucacrvdtJaZgWkP8oLW
         Wb8IPSTpe8ZwJk10JDVgtKuwuH4xPpv0+TxFZ/UQmZVsqRY7MqTHWbx7R22+VuBzJbEA
         fhmaATPpAm+KyBucRy/3n9egj3wBeommcUVr70v+43z1P51L6Hf7Q1C56W8AoxM80E+o
         xrHw==
X-Gm-Message-State: AFq9FYJVXSZjuKBJsCTsFdIz1r5bMIoiX3e0XwCmuVhU0fMMj43mqJZU
	hwUU8h0OGq9f4Oi1C84/ohfysrOLkudHj+fbdVNRWlKg5CxIwBdK6w01lXkTXRGS8A0ASlq6cwv
	mnW1gyxkIjyCLg3SBjAZ8mtk6nIEWmN4QPpyYOqFZxjUTB0mKaDlxxrQ092FL1Bqtu9+xmOU7wk
	fqn/ZhdIWXsqj2JJy6XXoReiE+DR8KkhABVYEcMN2sRziRWIwJ1Lpl4xHr
X-Gm-Gg: AYBFou3T71lzawZ1OS7kobRLwqAnZPy6xAPCvvpFMEgHndiLt2qb5r9iZZS6SjvjYQs
	l6Ii5R7fMSPlozJOsIqjmw9daUK4DpZd70hVSWyjyF7Hder2lGT99hd3vvGi/MP4gqurWTWuHx6
	tV1Sh4OGdVIyrybWLsxd3/YVzZnBKnBNTTVDo/4vGdrrfxZ8etsPMLXZkzYb95iQlQzN1hwxSgP
	K8zvgTDMQKfX7pme5A1cN7Y8qb4iZCBEPayyGMAY70kFgMPcD6+w12LHLgIQkO6YyeZFeDbIgGE
	vOTfggc9f+TkDRc=
X-Received: by 2002:a05:6808:1b10:b0:4c5:90f1:b9c3 with SMTP id 5614622812f47-55bffffe000mr1773833b6e.2.1792847039677;
        Sat, 24 Oct 2026 06:03:59 -0700 (PDT)
X-Received: by 2002:a05:6808:1b10:b0:4c5:90f1:b9c3 with SMTP id
 5614622812f47-55bffffe000mr1773809b6e.2.1792847039227; Sat, 24 Oct 2026
 06:03:59 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792831564.git.an.wu@canonical.com> <f3ec60d4e68819c994a0d4c6d44eb5cf8d511ddb.1792831564.git.an.wu@canonical.com>
 <b66d47a456bddb23deaf1c4c625b0029dde0e9a5.camel@posteo.de>
In-Reply-To: <b66d47a456bddb23deaf1c4c625b0029dde0e9a5.camel@posteo.de>
From: An Wu <an.wu@canonical.com>
Date: Sat, 24 Oct 2026 21:03:46 +0800
X-Gm-Features: AclHuK-sOOwDGwCHCZV4lIH3ZMIPSiDEfECwrddSaz0IwKRR3_H4sc8awgXIGFc
Message-ID: <CAO4Mv0aE5MeoKGcWpvWvWis-A8pD6UpE8m_-VFF2EK+VP0uoYg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] serdev: handle devices without an ACPI or device
 tree node
To: Markus Probst <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus
    Working on it,
Thank you~

BR
    An

On Sat, Oct 24, 2026 at 8:58=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> On Sat, 2026-10-24 at 20:04 +0800, ChunAn Wu wrote:
> > Serdev clients instantiated by a driver have no ACPI companion and no
> > device tree node. Their modalias read returns -ENODEV, their add uevent
> > is suppressed, and they cannot be driver-matched, so creators force a
> > bind with device_driver_attach().
> >
> > Resolve both TODOs in the serdev core by modelling matching on the SPI
> > bus: let the creator pass a modalias to serdev_device_add() and give
> > struct serdev_device_driver an id_table. ACPI and OF are still tried
> > first; clients without their own modalias keep returning -ENODEV. The
> > device name, derived from the controller, is unchanged.
> >
> > Split struct serdev_device_id and its defines into a new
> > include/linux/device-id/serdev.h, following the pattern already used by
> > the SPI and I2C buses.
> >
> > Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> > ---
> >  MAINTAINERS                                   |  1 +
> >  .../platform/x86/x86-android-tablets/core.c   |  2 +-
> >  drivers/power/sequencing/pwrseq-pcie-m2.c     |  2 +-
> >  drivers/tty/serdev/core.c                     | 62 ++++++++++++++++---
> >  include/linux/device-id/serdev.h              | 19 ++++++
> >  include/linux/serdev.h                        | 12 +++-
> >  6 files changed, 86 insertions(+), 12 deletions(-)
> >  create mode 100644 include/linux/device-id/serdev.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 917f3f72e31b..06e67aa5d9b0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -24905,6 +24905,7 @@ L:    linux-serial@vger.kernel.org
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/serial/serial.yaml
> >  F:   drivers/tty/serdev/
> > +F:   include/linux/device-id/serdev.h
> >  F:   include/linux/serdev.h
> >  F:   rust/helpers/serdev.c
> >  F:   rust/kernel/serdev.rs
> > diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/=
platform/x86/x86-android-tablets/core.c
> > index cfff7f5eac5d..853aa6ff5d50 100644
> > --- a/drivers/platform/x86/x86-android-tablets/core.c
> > +++ b/drivers/platform/x86/x86-android-tablets/core.c
> > @@ -317,7 +317,7 @@ static __init int x86_instantiate_serdev(const stru=
ct x86_dev_info *dev_info, in
> >       ACPI_COMPANION_SET(&serdev->dev, serdev_adev);
> >       acpi_device_set_enumerated(serdev_adev);
> >
> > -     ret =3D serdev_device_add(serdev);
> > +     ret =3D serdev_device_add(serdev, NULL);
> >       if (ret) {
> >               dev_err(&serdev->dev, "error %d adding serdev\n", ret);
> >               serdev_device_put(serdev);
> > diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/=
sequencing/pwrseq-pcie-m2.c
> > index e42e85f47629..e0482f2ef39f 100644
> > --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> > +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > @@ -309,7 +309,7 @@ static int pwrseq_pcie_m2_create_serdev_one(struct =
pwrseq_pcie_m2_ctx *ctx,
> >       if (ret)
> >               goto err_free_serdev;
> >
> > -     ret =3D serdev_device_add(pci_dev->serdev);
> > +     ret =3D serdev_device_add(pci_dev->serdev, NULL);
> >       if (ret) {
> >               dev_err(dev, "Failed to add serdev for PCI device (%s): %=
d\n",
> >                       pci_name(pdev), ret);
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index 7500efcdfc21..e0517d5a48da 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -29,13 +29,21 @@ static DEFINE_IDA(ctrl_ida);
> >  static ssize_t modalias_show(struct device *dev,
> >                            struct device_attribute *attr, char *buf)
> >  {
> > +     const struct serdev_device *serdev =3D to_serdev_device(dev);
> >       int len;
> >
> >       len =3D acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
> >       if (len !=3D -ENODEV)
> >               return len;
> >
> > -     return of_device_modalias(dev, buf, PAGE_SIZE);
> > +     len =3D of_device_modalias(dev, buf, PAGE_SIZE);
> > +     if (len !=3D -ENODEV)
> > +             return len;
> > +
> > +     if (!serdev->modalias[0])
> > +             return -ENODEV;
> > +
> > +     return sysfs_emit(buf, "%s%s\n", SERDEV_MODULE_PREFIX, serdev->mo=
dalias);
> >  }
> >  static DEVICE_ATTR_RO(modalias);
> >
> > @@ -47,15 +55,22 @@ ATTRIBUTE_GROUPS(serdev_device);
> >
> >  static int serdev_device_uevent(const struct device *dev, struct kobj_=
uevent_env *env)
> >  {
> > +     const struct serdev_device *serdev =3D to_serdev_device(dev);
> >       int rc;
> >
> > -     /* TODO: platform modalias */
> > -
> >       rc =3D acpi_device_uevent_modalias(dev, env);
> >       if (rc !=3D -ENODEV)
> >               return rc;
> >
> > -     return of_device_uevent_modalias(dev, env);
> > +     rc =3D of_device_uevent_modalias(dev, env);
> > +     if (rc !=3D -ENODEV)
> > +             return rc;
> > +
> > +     if (!serdev->modalias[0])
> > +             return -ENODEV;
> > +
> > +     return add_uevent_var(env, "MODALIAS=3D%s%s", SERDEV_MODULE_PREFI=
X,
> > +                           serdev->modalias);
> >  }
> >
> >  static void serdev_device_release(struct device *dev)
> > @@ -86,28 +101,57 @@ static const struct device_type serdev_ctrl_type =
=3D {
> >       .release        =3D serdev_ctrl_release,
> >  };
> >
> > +static const struct serdev_device_id *serdev_match_id(const struct ser=
dev_device_id *id,
> > +                                                   const char *modalia=
s)
> > +{
> > +     if (!id || !modalias[0])
> > +             return NULL;
> > +
> > +     while (id->name[0]) {
> > +             if (!strcmp(modalias, id->name))
> > +                     return id;
> > +             id++;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> >  static int serdev_device_match(struct device *dev, const struct device=
_driver *drv)
> >  {
> > +     const struct serdev_device *serdev;
> > +     const struct serdev_device_driver *sdrv;
> > +
> >       if (!is_serdev_device(dev))
> >               return 0;
> >
> > -     /* TODO: platform matching */
> > +     serdev =3D to_serdev_device(dev);
> > +     sdrv =3D to_serdev_device_driver(drv);
> > +
> >       if (acpi_driver_match_device(dev, drv))
> >               return 1;
> >
> > -     return of_driver_match_device(dev, drv);
> > +     if (of_driver_match_device(dev, drv))
> > +             return 1;
> > +
> > +     return !!serdev_match_id(sdrv->id_table, serdev->modalias);
> >  }
> >
> >  /**
> >   * serdev_device_add() - add a device previously constructed via serde=
v_device_alloc()
> >   * @serdev:  serdev_device to be added
> > + * @modalias:        Driver name or alias, used to match devices which=
 have neither
> > + *           an ACPI companion nor a device tree node. NULL for device=
s
> > + *           enumerated from firmware.
> >   */
> > -int serdev_device_add(struct serdev_device *serdev)
> > +int serdev_device_add(struct serdev_device *serdev, const char *modali=
as)
> >  {
> >       struct serdev_controller *ctrl =3D serdev->ctrl;
> >       struct device *parent =3D serdev->dev.parent;
> >       int err;
> >
> > +     if (modalias)
> > +             strscpy(serdev->modalias, modalias);
> > +
> >       dev_set_name(&serdev->dev, "%s-%d", dev_name(parent), serdev->nr)=
;
> >
> >       /* Only a single slave device is currently supported. */
> > @@ -553,7 +597,7 @@ static int of_serdev_register_devices(struct serdev=
_controller *ctrl)
> >
> >               device_set_node(&serdev->dev, of_fwnode_handle(node));
> >
> > -             err =3D serdev_device_add(serdev);
> > +             err =3D serdev_device_add(serdev, NULL);
> >               if (err) {
> >                       dev_err(&serdev->dev,
> >                               "failure adding device. status %pe\n",
> > @@ -707,7 +751,7 @@ static acpi_status acpi_serdev_register_device(stru=
ct serdev_controller *ctrl,
> >       ACPI_COMPANION_SET(&serdev->dev, adev);
> >       acpi_device_set_enumerated(adev);
> >
> > -     err =3D serdev_device_add(serdev);
> > +     err =3D serdev_device_add(serdev, NULL);
> >       if (err) {
> >               dev_err(&serdev->dev,
> >                       "failure adding ACPI serdev device. status %pe\n"=
,
> > diff --git a/include/linux/device-id/serdev.h b/include/linux/device-id=
/serdev.h
> > new file mode 100644
> > index 000000000000..96644953cece
> > --- /dev/null
> > +++ b/include/linux/device-id/serdev.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef LINUX_DEVICE_ID_SERDEV_H
> > +#define LINUX_DEVICE_ID_SERDEV_H
> > +
> > +#ifdef __KERNEL__
> > +typedef unsigned long kernel_ulong_t;
> > +#endif
> > +
> > +/* serdev */
> > +
> > +#define SERDEV_NAME_SIZE     40
> > +#define SERDEV_MODULE_PREFIX "serial:"
> > +
> > +struct serdev_device_id {
> > +     char name[SERDEV_NAME_SIZE];
> > +     kernel_ulong_t driver_data;     /* Data private to the driver */
> > +};
> > +
> > +#endif /* ifndef LINUX_DEVICE_ID_SERDEV_H */
> > diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> > index b6c3d957ec15..96a441abc1ac 100644
> > --- a/include/linux/serdev.h
> > +++ b/include/linux/serdev.h
> > @@ -7,7 +7,9 @@
> >
> >  #include <linux/types.h>
> >  #include <linux/device.h>
> > +#include <linux/device-id/serdev.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/string.h>
> Unused include.
>
> >  #include <linux/uaccess.h>
> >  #include <linux/termios.h>
> >  #include <linux/delay.h>
> > @@ -35,6 +37,10 @@ struct serdev_device_ops {
> >   * struct serdev_device - Basic representation of an serdev device
> >   * @dev:     Driver model representation of the device.
> >   * @nr:              Device number on serdev bus.
> > + * @modalias:        Name of the driver to use with this device, or th=
e alias
> > + *           for it. Empty for devices enumerated from firmware, which
> > + *           are identified through their ACPI companion or their devi=
ce
> > + *           tree node instead. See serdev_device_add().
> >   * @ctrl:    serdev controller managing this device.
> >   * @ops:     Device operations.
> >   * @write_comp:      Completion used by serdev_device_write() internal=
ly
> > @@ -43,6 +49,7 @@ struct serdev_device_ops {
> >  struct serdev_device {
> >       struct device dev;
> >       int nr;
> > +     char modalias[SERDEV_NAME_SIZE];
> >       struct serdev_controller *ctrl;
> >       const struct serdev_device_ops *ops;
> >       struct completion write_comp;
> > @@ -55,12 +62,15 @@ struct serdev_device {
> >   * struct serdev_device_driver - serdev slave device driver
> >   * @driver:  serdev device drivers should initialize name field of thi=
s
> >   *           structure.
> > + * @id_table:        List of serdev devices supported by this driver, =
used to
> > + *           match devices which are not enumerated from firmware.
> >   * @probe:   binds this driver to a serdev device.
> >   * @remove:  unbinds this driver from the serdev device.
> >   * @shutdown:        shut down this serdev device.
> >   */
> >  struct serdev_device_driver {
> >       struct device_driver driver;
> > +     const struct serdev_device_id *id_table;
> >       int     (*probe)(struct serdev_device *);
> >       void    (*remove)(struct serdev_device *);
> >       void    (*shutdown)(struct serdev_device *);
> > @@ -158,7 +168,7 @@ static inline void serdev_controller_put(struct ser=
dev_controller *ctrl)
> >  }
> >
> >  struct serdev_device *serdev_device_alloc(struct serdev_controller *);
> > -int serdev_device_add(struct serdev_device *);
> > +int serdev_device_add(struct serdev_device *serdev, const char *modali=
as);
> >  void serdev_device_remove(struct serdev_device *);
> >
> >  struct serdev_controller *serdev_controller_alloc(struct device *host,
>
> You will need to address the sashiko report (both are true positives).
>
> In the scripts/mod/file2alias.c file, you can copy the spi entry.
> scripts/mod/devicetable-offsets.{h,c,s} and
> include/linux/mod_devicetable.h are also relevant for this.
> (Didn't know myself those files existed, so thx Sashiko)
>
> Also add serdev_device_id to scripts/coccinelle/misc/of_table.cocci .
>
>
> With that fixed,
>
> Reviewed-by: Markus Probst <markus.probst@posteo.de>
>
>
> Thanks
> - Markus Probst
