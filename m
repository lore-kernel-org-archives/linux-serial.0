Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792760548;
	b=fcrDhS+9SIHv7ZbjGkJp4oOJsFkxLBHb7gtiN6DW8UObuUb4dhSU8wJS1/6OOQYhCmU8
	 cfGfmguHtLsKr7yJP8KEpOEXHUoyixBVmGc/kt+C9KoS4zUTprB+Bu98b6mQEFTquZrt2
	 R1XHYZIB8I90Hiv/THNJmEvtc4SzeHoFSpl9aJ3gDdLXOsZP9dDBwuDajybSlf273R7mA
	 dI5ivhWhsgE2SOiA397wH67Hgw2IPFDIPB5kRthim1AHd2TPdcbcTFMbKGgnabWr+uPlF
	 EO0FMyuigF2REJrytR6WG0h2aEjgRH4Vjr1k0jV7kciQkSVwbZ625Bxlku+2Hg7ZvOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760548;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=+AuTATHXeKj9NqRJf0hVa3/vGiuR3FiHkiC9A4S8EeE=;
	b=e/9PoNY58qNbeEK2rMwFCrVpDY0eP564vDWTQzh8fog4NuBXRSq4qckB7h3059MN3qLM
	 XGNa7EqfZhTKacJmEQeNBAQJSJy4GjeBjgaVXU4On/gvuEkgZ35blpxWaDo4PNHrxVO5c
	 +eFYU2cytAR6GvQatDoDPzeTkG9eHK4hbogaIkQoGW4zdT6XIk7y01KqQEPCvFMoTWsN2
	 8YkyCI9O1hwC8LwfqWrBLNh8T12z73iqsMzZKQ5wPI0/4CmU+Ti7gK2akPOvLR7TJ89mD
	 JZ4eVyG/Q9oinMzO4QXrLprf550Ljh+tCcsC5fUvcz+1rMUZsSMNMoMQOI6YScR32ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=HcBh5odu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C432606A31B
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 13:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C432606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=HcBh5odu
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 23DA8402DC
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792760539;
	bh=+AuTATHXeKj9NqRJf0hVa3/vGiuR3FiHkiC9A4S8EeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HcBh5oduh7haQfUmViC1/nQeU/UqAScYyH9SMzHxUV/G/TEpS/4evD3F3leXfjtwR
	 jdY7vtwAtIHYVtpXEUe22ydUElQE8X3FFuHJUeqL4aMN03XhQuFIAdSNwVfWAQLjU0
	 DXumEC5lU2BYHB1LIE9MeeExldZ9kC4r6w2RoNMD9EBRLy9mQ54D+19o1XxHCNqPAc
	 9zO1SS3WMtxXbudEReiiQ6OXM4fcxTFKaF7hIFGTp9TpAGS5/P7BkRkCDBRVPEKcci
	 s9DiuLX1eqX1VI6IBysX3gmIlRK30uhJS9qQKSVUynFLpvkqudESnH7ZgAX54hDGI7
	 fVAroWBLIS/mp+leZTj1Y4XKOBJiKcDVydkzUk8L0LRVmrgWMCpTDldHXlixD9dWqU
	 S2inRUWInB+ngwazu1aRbwIsmw6S/5EJpioIRssHuMqg7Rb2sp6uH9+Z+Q0DpQi89i
	 fTqmiRjfXRaOQKeUxA8hF+aGCudeOvE4BYvdzzXxBqT7gjT2DX56am3ttlvnQyRoc2
	 Fhp7zHnb8rhowH6U1bTYU3yY8HNLkla7IXBTuEPWZ3sliDHKqP0quwoZcmdOste3f+
	 ZbyFSDZ5q2314Lj430pxHPxtAfDsyRnigpN0x+OnVh4K1EMRvwfC2fgG+0d9dIduCP
	 f/yNc15UuTCSFqoyL7vnxZj8=
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-555eaa3ff0dso232041b6e.3
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 06:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792760538; cv=none;
        d=google.com; s=arc-20260327;
        b=C1NL6lAUv43lHCc30TU0SDLYLPDq0vGDDxdFY8yl4yh0USM8EbiISawGXEt4b1j+Mk
         VActevUVXWxyUtxdyOQlhLK14esa1zN2zFj5BSkY1EI7/OMTusyEI4PncisYtS2LYzdi
         IRvGkR9om+UFwPDUtXh53dzXoQF0+OLix6x6l/dIlXGbxRhQ1E9O0IJ/mhNz0xg4Bgu1
         4mXldJy3trjKrgygz1VtjLRnx9jCIpzI9YN3AUuJwijAjnYO5ahCZjIJAeeRe0GuGonW
         7kwhk7UrIQ5dVW1WrIeqb7OT9GAKnRfPklRefeJaBHaneu0NJvvdvWrIWQikMCQ7HySG
         2mSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=+AuTATHXeKj9NqRJf0hVa3/vGiuR3FiHkiC9A4S8EeE=;
        fh=i8k/WQmyUQqTE3XMrvklFnwS4lREq9vRtl7rqxDWsaI=;
        b=X+8Ru2mn9jMWHeX+AR1cvVOTxGz6g4Qctshxbinzs0ifY17yLDi0Ez8FL63zIXEae7
         WFu3N2r0qFtsksHKImUGCjm9tGlY4rNPLux2fl01oxhP0P++h9Uojt8eCYz7YTn2fDC0
         U5clznjq6MvTfKzX1peJjjMM+XE8smngyQwfP9F3bMgZbW0FXhsLs291huqsVfRBovtb
         KezF2Q1KOCzRbSFCRL2/IhHD2vvfDoM0figbgPojA10ZL/wxpa43NcWr5BzwW6v6hx7h
         Y/A5tVoaieDyAVrPuN5vriQiJuxERRWPbLw1sw/oOAITXTX0BwS+yA1XF4qJli+uEc2S
         Z76g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792760538; x=1793365338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+AuTATHXeKj9NqRJf0hVa3/vGiuR3FiHkiC9A4S8EeE=;
        b=SXtE1r2mmGiIJuQSYCEEFXPW1TAQgUESiHshW87oXHpuwX4vQP0MqpuDaRl51xSrec
         CMwbS/BcoHL/jtYyikehQrY+MumlzYaWHAzfdCRxo3JLhjcnZBceQTm6cDdIKGeOgH9E
         6mAN3nOpEIKplIlwa1KP8Y0pxPPo7bgxlhGgvJ0O50dak683RkAygJMWRzDT86P70L1U
         8SjITX4AaDwbxSrtAvz1JzmBaT+p4VubI/fCsJocAm+hCvcu+mk8E52ZoZCeNNaLZt6d
         GmjxYc20thv6rtdDAYQubLg7OeUQUsixvsircJEYOXl5tAq2FxGfsdNegVnIu5vkjoMU
         OgMQ==
X-Gm-Message-State: AFq9FYKHZLIJK+lh+to+rVYC5PqDB+iXB/iE/USBsGXo6lTCb9+nsOvP
	JstTAAh8dz/tNwoJaMPgxCoe50ywq2zktd08nFdfExGqSsfrgJE7W0QJRaNT5Bcz512i3xeT5S6
	Xu5QqdtbtgxEnqM2YqKrP9WMvJfOpEJYWakzaWH2tWV9V2cumFMvYtZ3YVSKcTFeTnUykOU5zkO
	ytQHZybX+3hHGqMQPK9eShkVUVglE82XGRZ8BXPwR7DEN23Lz0KdoYdyem
X-Gm-Gg: AYBFou20HnGbmzH8T4qfjJHQ6UB1Js5QDRtudXTdY3omQFsbUFNKvFdeArBMXyZQO1A
	rAtb6vi1KubeMfPHVp96b/H1EnK9mldbni9RZWfss5fxRVXFGpMyUmsrLSj/izlfoyA8XQwBpcs
	keytn2birxccTpFbIa1MR9rG0oaN3JiNC4vW//oTrX/cDgflACVxUny7Top8hptiz5We3uoG/ql
	MXzVWzYcSaHwvrh+mHOdKY7dcFw5yRUUFKPcA/Gf2XZN/2PmetxDe6xD9fPd/XUuUerYrPTicnF
	ld7jsdWkwyIGeco=
X-Received: by 2002:a05:6808:50a8:b0:4c4:d241:d230 with SMTP id 5614622812f47-55be816a3d7mr2090216b6e.2.1792760536102;
        Fri, 23 Oct 2026 06:02:16 -0700 (PDT)
X-Received: by 2002:a05:6808:50a8:b0:4c4:d241:d230 with SMTP id
 5614622812f47-55be816a3d7mr2090139b6e.2.1792760535458; Fri, 23 Oct 2026
 06:02:15 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023052717.2577234-1-an.wu@canonical.com> <20261023052717.2577234-2-an.wu@canonical.com>
 <f985179ec5ffd2bd558f394c9af9070e8c1e2f75.camel@posteo.de>
In-Reply-To: <f985179ec5ffd2bd558f394c9af9070e8c1e2f75.camel@posteo.de>
From: An Wu <an.wu@canonical.com>
Date: Fri, 23 Oct 2026 21:02:03 +0800
X-Gm-Features: AclHuK9-U3TrsJ_YTYQ3ey-26S-PPldzjI4VyJvpL9r8_VBsogTkWVj5Nz6jtRM
Message-ID: <CAO4Mv0aW4pRSi5kf8GjnORJMyx-VZhCtUk2AGiX-1TambzgQOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] serdev: handle devices without an ACPI or device
 tree node
To: Markus Probst <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus
    Thank you for your review.
For this,
```
#ifdef __KERNEL__
#include <linux/types.h>
typedef unsigned long kernel_ulong_t;
#endif
```

I originally implemented it this way, but checkpatch.pl reported a warning.
Since it's only a warning, I'll go ahead and update it accordingly.
I really appreciate your patience and guidance. Thank you!

BR
    An

On Fri, Oct 23, 2026 at 8:26=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> On Fri, 2026-10-23 at 13:27 +0800, ChunAn Wu wrote:
> > Serdev clients instantiated by a driver have no ACPI companion and no
> > device tree node. Their modalias read returns -ENODEV, their add uevent
> > is suppressed, and they cannot be driver-matched, so creators force a
> > bind with device_driver_attach().
> >
> > Resolve both TODOs in the serdev core by modelling matching on the SPI
> > bus: add a creator-set modalias to struct serdev_device and an id_table
> > to struct serdev_device_driver. ACPI and OF are still tried first;
> > clients without their own modalias keep returning -ENODEV. The device
> > name, derived from the controller, is unchanged.
> >
> > Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> > ---
> > Changes in v3:
> > - Rename struct serdev_device::name to ::modalias; dev_name() is unchan=
ged
> > - Model matching on the SPI bus: add struct serdev_device_id and
> >   id_table; drop driver->name matching
> > - Add serdev_device_set_modalias() helper and SERDEV_MODULE_PREFIX
> > - No MODULE_DEVICE_TABLE(serdev, ...) support: both in-tree firmware-le=
ss
> >   clients are created by the same module that provides their driver, so
> >   udev has nothing to autoload
> >
> > Changes in v2:
> > - Instead of silently returning success with no modalias, use a
> >   creator-supplied name as a "serial:<name>" modalias fallback and as
> >   the matching key, so clients can bind through normal serdev matching
> >
> Thats something I would expect on the cover letter.
> >  MAINTAINERS                      |  1 +
> >  drivers/tty/serdev/core.c        | 54 ++++++++++++++++++++++++++++----
> >  include/linux/device-id/serdev.h | 16 ++++++++++
> >  include/linux/serdev.h           | 34 ++++++++++++++++++++
> >  4 files changed, 99 insertions(+), 6 deletions(-)
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
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index 7500efcdfc21..e178dc57d31b 100644
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
> > @@ -86,16 +101,43 @@ static const struct device_type serdev_ctrl_type =
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
> > +
> >       if (!is_serdev_device(dev))
> >               return 0;
> >
> > -     /* TODO: platform matching */
> >       if (acpi_driver_match_device(dev, drv))
> >               return 1;
> >
> > -     return of_driver_match_device(dev, drv);
> > +     if (of_driver_match_device(dev, drv))
> > +             return 1;
> > +
> > +     /*
> > +      * Devices which are instantiated by a driver instead of by firmw=
are
> > +      * have no ACPI companion and no device tree node, match them by =
the
> > +      * modalias their creator gave them.
> > +      */
> Drop comment.
>
> > +     serdev =3D to_serdev_device(dev);
> > +
> > +     return !!serdev_match_id(to_serdev_device_driver(drv)->id_table,
> > +                              serdev->modalias);
> I think you can drop the `is_serdev_device` check and use
>
> ```
> const struct serdev_device *serdev =3D to_serdev_device(dev);
> const struct serdev_device_driver *sdrv =3D to_serdev_device_driver(drv);
> ```
>
> in the top.
>
> The function `serdev_device_match` is only used inside the match
> callback on the bus type definition. Other bus devices also do not have
> this check. It should be safe.
>
> Alternatively `to_serdev_device` in the same expression as the function
> call (like with `to_serdev_device_driver`). It should be consistent
> (either both as variables or none).
>
> >  }
> >
> >  /**
> > diff --git a/include/linux/device-id/serdev.h b/include/linux/device-id=
/serdev.h
> > new file mode 100644
> > index 000000000000..1c3b03b7d501
> > --- /dev/null
> > +++ b/include/linux/device-id/serdev.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef LINUX_DEVICE_ID_SERDEV_H
> > +#define LINUX_DEVICE_ID_SERDEV_H
> > +
> > +/* serdev */
> > +
> > +/* Large enough to hold the KBUILD_MODNAME of any serdev client driver=
 */
> Is this relevant for anyone reading the code? If not, drop the comment.
>
> > +#define SERDEV_NAME_SIZE     40
> > +#define SERDEV_MODULE_PREFIX "serial:"
> > +
> > +struct serdev_device_id {
> > +     char name[SERDEV_NAME_SIZE];
> > +     unsigned long driver_data;      /* Data private to the driver */
> > +};
> In almost any other include/linux/device-id/*.h file, there is a
>
> ```
> #ifdef __KERNEL__
> #include <linux/types.h>
> typedef unsigned long kernel_ulong_t;
> #endif
> ```
>
> statement and `kernel_ulong_t` is used.
>
> I don't know why, but there is likely a reason for it. Thus do it the
> same way, unless you can explain why this isn't needed here.
>
> > +
> > +#endif /* ifndef LINUX_DEVICE_ID_SERDEV_H */
> > diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> > index b6c3d957ec15..9f91aa3e875d 100644
> > --- a/include/linux/serdev.h
> > +++ b/include/linux/serdev.h
> > @@ -7,7 +7,9 @@
> >
> >  #include <linux/types.h>
> >  #include <linux/device.h>
> > +#include <linux/device-id/serdev.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/string.h>
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
> > + *           tree node instead. See serdev_device_set_modalias().
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
> > @@ -58,12 +65,15 @@ struct serdev_device {
> >   * @probe:   binds this driver to a serdev device.
> >   * @remove:  unbinds this driver from the serdev device.
> >   * @shutdown:        shut down this serdev device.
> > + * @id_table:        List of serdev devices supported by this driver, =
used to
> > + *           match devices which are not enumerated from firmware.
> >   */
> >  struct serdev_device_driver {
> >       struct device_driver driver;
> >       int     (*probe)(struct serdev_device *);
> >       void    (*remove)(struct serdev_device *);
> >       void    (*shutdown)(struct serdev_device *);
> > +     const struct serdev_device_id *id_table;
> Just a suggestion:
> Move it directly under driver, so the fields (driver->of_match_table,
> driver->acpi_match_table, id_table) are next to each other. It has no
> real runtime difference, so I won't complain if you leave it there.
>
> >  };
> >
> >  #define to_serdev_device_driver(d) container_of_const(d, struct serdev=
_device_driver, driver)
> > @@ -135,6 +145,30 @@ static inline void serdev_device_set_client_ops(st=
ruct serdev_device *serdev,
> >       serdev->ops =3D ops;
> >  }
> >
> > +/**
> > + * serdev_device_set_modalias() - set the modalias of a serdev device
> > + * @serdev:  serdev device.
> > + * @modalias:        non-empty modalias to use, typically KBUILD_MODNA=
ME of the
> > + *           client driver.
> > + *
> > + * A serdev device is identified by its ACPI companion, by its device =
tree
> > + * node, or by a modalias set by its creator. Serdev devices which are
> > + * instantiated by a driver rather than by firmware have neither of th=
e
> > + * former, so they must set a modalias before serdev_device_add() to b=
e
> > + * identifiable. Doing so reports a SERDEV_MODULE_PREFIX modalias to
> > + * userspace and makes the device match an id_table entry of a serdev
> > + * device driver.
> > + *
> > + * Devices enumerated from firmware have no modalias of their own and =
keep
> > + * deriving their modalias and their driver match from firmware only. =
The
> > + * device name is not affected either way.
> > + */
> > +static inline void serdev_device_set_modalias(struct serdev_device *se=
rdev,
> > +                                           const char *modalias)
> > +{
> > +     strscpy(serdev->modalias, modalias);
> > +}
> Drop the function.
> Add `const char *modalias` as parameter to `serdev_device_add`. It
> should be clear that any driver calling this function manually should
> provide a modalias. Also, keep documentation simple (unless there is
> need).
>
> Either you add `__serdev_device_add` for internal use (of or acpi), or
> it will use NULL. Your choice.
>
>
> Overall, looks pretty good so far.
>
> Thanks
> - Markus Probst
>
> > +
> >  static inline
> >  void *serdev_controller_get_drvdata(const struct serdev_controller *ct=
rl)
> >  {
