Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792831243;
	b=xpHBwESU34BztA2I+iQPGtARhuR7529mKr0dsrbIciEBlsquaYjRf0UTWUXZa5LNh5Fi
	 J9IzEmn0Z2UsbG+d915xccya2+c8IIC1l1Z9dP/2j3SZnUY4I5tyChwB/XIqM0DPN7EPn
	 61AMlSaElALT1PxeNmm0hjktur2bQM4zyPR41SbB8zq/56wyB/OfzHN5cOpMQCijuTfsO
	 rAWE/djfqDo+bR7RAZTB9c5SaBNIZTnIT0fhNCQJN13wY5ZsvZyplto7gJBW+s9993gZJ
	 pMV4fapn0Y+9qK1yUDuVacQOsyVmYrTeb6eT40pCvFTMAUMWLoT3df0+0+a7orWmX/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792831243;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=yXq52twcMI4Pp7oE3JQoJWzm+YSJCWMd6m0T6uz2FyY=;
	b=QTxm/jTYvesFc9ND6R1/UrzKKF9SROPja6Hg94cFQKvK3VB067+4uidM0LPjV4lWs0DW
	 /FvtOl0ZmrvcclcAtvZSTCplAHgVvhxr0PQg0gU+12wMXWkBsX81JrY6QjK1SmMbMXwZx
	 Nb4+lo2oTC0eqXVNjogqxwgtrqQICrKfFSTom//GTQfVtz0DGfdunUar4b6D8yrWlmo9Y
	 Z7n/750RoMmZY1XtywR9JD1l4j+pnj6Y6rVKnnhnBAdV7rKTx+Y4Mu8R6DmVBkSj0UTO0
	 7LNwVORX16ivz3+ffLjXafnqg0JwoTJbxSzhNqIdBQHBItGevbrlzgo6TFYTuEgHcwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=RWGzfM5E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5A606A31B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 08:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47F5A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=RWGzfM5E
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2AC15402D8
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 08:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792831239;
	bh=yXq52twcMI4Pp7oE3JQoJWzm+YSJCWMd6m0T6uz2FyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=RWGzfM5ErxOVLdI8XJpxlcLmXn8iUZXzY2VW2zIJgikQXCaPH/ITUBadQJS/HQBt9
	 50s4xhguHny6+B36AQUx4cXY0sxwvZEh70Wcrh1BrMwVo/U/5YTrdROLf4gRy2rQUE
	 d2m6gfSZGo6j/qNVznjSAfMNzqDk3rMb/1wvBfuQh6+/jJZ5JZjIdmR2Ayw9fAIA59
	 88KHXOP7Xlss3P/0FwlrKvGm+2zB2w+Vthx6j1vNjqhsiaRyIZC4fgGrL3Qsno3CEt
	 v70vtzef3j9+WWfpI8DrplobNtYX0j/abb4XyLcra6mjvl9XjMWWoCX3XMsVTK9MxD
	 KurQU6EQhCAMh3P/MmpFVQoVjb+zjItCjX8jrnHO/nVUQy01xQnpyDtAMGWYZQ2pU0
	 vXMEm2KaBf8FP93vBsqIcuwoJ3QyRSoEAuEtJeqznIlSizDhxySNdaUI4AWyPIvgtQ
	 o8k8rZ2gee5IfiXfYEloK8mrPOuWN+iYMZi0TqIZN1Wx+dhdmdg+KptcZu2xfeV0kX
	 lBIFXBCXraIXbBtJTu2sZytV00Md/Z0LduY4vjWUyhUYPjTqkGQU8b7uoiAiZsvnmS
	 MVZr1NTRti6GSTcqEt+nCeDfmLUsFjQXioNvMd+E3r8eUVQxhG+UZUglUH9pXj014Z
	 GQi75yZBJunvS1o2j81BM3NE=
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7ffe90b2cfdso813689a34.1
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 01:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792831238; cv=none;
        d=google.com; s=arc-20260327;
        b=g1Lp0J+xr+mdLpmtyHPv+cYblua4bB+MjqI/y7gcCzRooM4awdMDKCjDf16LNUTsTR
         sOKVOjXH/r7LRCoa1/RMdIZUWa59UHVRIc6+W/g880iPEvMWbK81lEjeBT8/rawRgU1j
         zILWPdLe+6xdfizKXO41ILNTeAjTPn1sKew67q4m/6AHpZDXsysAxCs3CvYBV4eGJvT1
         OsnRdseJMdYuZZGsw/2Wx+9FJDV6ckJgQWgJKsNsC5Bv7ozicB6j8mh0i02w+nHGbRd+
         JbhNMFMrwusi7N4PxAr6fmdCBd2DSd2M4LATOO5ULNFwCWdf6BHfGv405BgbTZ0uiEyp
         Njow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=yXq52twcMI4Pp7oE3JQoJWzm+YSJCWMd6m0T6uz2FyY=;
        fh=2uBPYL4qfXd7YxRhj70ax1je9Y3bi0NJwXAVPCYpjmE=;
        b=cQYMJI1tWkLM/giAkQAZ58yt6b96Wo0rI1z9HtTcrQ1gvWKmgDPzTG1eCAH0XkZjyT
         jFHYQLDDfhyhUhODvFMHYuo0KJEaUVKl8LBK4bFU5L8S3qOT4BOSIie86O7iKDi5czF8
         YBKOG7Es4aE8PVupdRK1cUQF0vqYPZWsb7RuMz9uwmmbfc40jRBxRsf3DDZey8S3IydY
         XZV5CL/uKiLJJMamlxoyLmQcPVB6UUuGVf7WyH2qaHw3UEdMt/LSq8VFH4+0oxNC+jx/
         p28MSaTOJoLUIkgOMTOHZom2udZUJ0J4uPxMsVCKJ4SzCXVsPaKzTh5NVBarbiDtF+y5
         zoAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792831238; x=1793436038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXq52twcMI4Pp7oE3JQoJWzm+YSJCWMd6m0T6uz2FyY=;
        b=Bnpe2uwRBgJa+hWEN81MEhm2lXb8LvU4rKkSMDNTB9S09DG+bhhgXwt8D26xQK9HdZ
         g0i72CFnIe+f7Gx0x1zX2IiErGtkedPrvVqod+N/jf3snbKMWGrIsQCV0hCX/Kok6kjr
         7NTqbFumUqQuvgJa3oi1Vm1xqallI/7DeALu3S7tjyWJzRuZZgeccJkbhTbpCQ5Z3P7C
         GU17ZTc9RQJ5SkTdLDVlxNHP+rmurTG5yuK84nknf5qXAkRszhQzkWIt7bGwrdjZfFlt
         efkGKJg4amTPlgnrWd5bMchCPw87D56VEG8V4kj22qpNQouzP1wj5joK7kINcHILv4r7
         85Fw==
X-Gm-Message-State: AFq9FYIi6+BzBGwkULo6Qbvog+DLaplQzWwQTgHpBM5XjbR8tzLIYfcx
	AdylWbqmZDWk1++U6FTYubg0EuNPqxSebIyQhYRmHBPa/mVu6ePvFPFrOfrmZ6zIdgXQL4Dcpn8
	IChO8WTVHNhjwCObVi1Beve4rDqEJmi8RHXNTLI896pxojYT3r4drnCYKoldLddegJtUp0viqjM
	fYqmc2WLXly40aY8sMF1TelDtON40Qzq4S9a9iepqC/OwxaX8DTGfzgUNHuY7Yxa8k+Ss=
X-Gm-Gg: AYBFou04vJCpjAA4RYxJx9T5NI2v0+WvAOdKSv6xq+vWGqTcr1+KAR2qguKuDBTfJSi
	IXAHu7/ZzRjY4pcUeKU29dO48UqI6ZoYEGHN5UgIBXmhWEVKn/SQTJ6ErLRbsY1SYGwJ3n/IAXH
	SLF83iKUr4mAgCmHVbTAgkYT1DyuYELGGDH99oLkc7i3RLb/9zyEJfU6/FN8fSM273pk1V5hy5r
	4er97qTg1WL1jRvsedtDGuGby/uIEKpmRoOscGHhHBunDhoN51C8j8xZkBVKsJ84fBtwRR1yV3R
	/Yct64FzxHJ/0ds=
X-Received: by 2002:a05:6808:180f:b0:4e8:9e40:a0dc with SMTP id 5614622812f47-55bfff897a6mr1484029b6e.1.1792831237658;
        Sat, 24 Oct 2026 01:40:37 -0700 (PDT)
X-Received: by 2002:a05:6808:180f:b0:4e8:9e40:a0dc with SMTP id
 5614622812f47-55bfff897a6mr1484014b6e.1.1792831237305; Sat, 24 Oct 2026
 01:40:37 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024022930.2704030-1-an.wu@canonical.com>
In-Reply-To: <20261024022930.2704030-1-an.wu@canonical.com>
From: An Wu <an.wu@canonical.com>
Date: Sat, 24 Oct 2026 16:40:26 +0800
X-Gm-Features: AclHuK_lw0KrbOay5TaRrHza0ih03wUncsXLxEBm0ja6_fb_XrMQvlNi_qhwGNo
Message-ID: <CAO4Mv0bkBSHHXo=_0SyCAN54Jb76fy34ba1hFVPVkFfs6ufoqA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] serdev: handle devices without an ACPI or device
 tree node
To: linux-serial@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, markus.probst@posteo.de, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, mpearson-lenovo@squebb.ca, 
	derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Makus
    According to sashiko:
'''
In drivers/tty/serdev/core.c, serdev_controller_alloc() places controller
devices on serdev_bus_type:

    device_initialize(&ctrl->dev);
    ctrl->dev.type =3D &serdev_ctrl_type;
    ctrl->dev.bus =3D &serdev_bus_type;

When yt2_1380_fc_module_init() calls serdev_device_driver_register() for
yt2_1380_fc_serdev_driver (or when a new serdev_controller is added), the
driver core runs serdev_device_match() against every device on
serdev_bus_type, including struct serdev_controller instances:

static int serdev_device_match(struct device *dev, const struct
device_driver *drv)
{
        const struct serdev_device *serdev =3D to_serdev_device(dev);
        const struct serdev_device_driver *sdrv =3D to_serdev_device_driver=
(drv);

        if (acpi_driver_match_device(dev, drv))
                return 1;

        if (of_driver_match_device(dev, drv))
                return 1;

        return !!serdev_match_id(sdrv->id_table, serdev->modalias);
}

Because serdev_device_match() does not check is_serdev_device(dev) before
casting dev with to_serdev_device(dev), and yt2_1380_fc_serdev_driver has n=
o
ACPI or OF match table, serdev_device_match() falls through to
serdev_match_id(sdrv->id_table, serdev->modalias) on struct serdev_controll=
er
devices.

In struct serdev_device, modalias[SERDEV_NAME_SIZE] starts at offset
sizeof(struct device) + 4, which in struct serdev_controller overlaps the
struct device *host pointer, ctrl->nr, ctrl->serdev, ctrl->ops, and extends=
 12
bytes past sizeof(struct serdev_controller). When the overlapping byte at
modalias[0] is non-zero, serdev_match_id() passes that non-string memory an=
d
trailing out-of-bounds bytes to strcmp().

Should serdev_device_match() verify is_serdev_device(dev) before casting de=
v
to struct serdev_device?
'''

If we remove is_serdev_device could cause some problem due to the
serdev_controller could also
run into this function and "serdev_match_id(sdrv->id_table,
serdev->modalias);" can be a potential risk.

I will add the "is_serdev_device" back and send v5 out.

BR
    An


On Sat, Oct 24, 2026 at 10:29=E2=80=AFAM ChunAn Wu <an.wu@canonical.com> wr=
ote:
>
> Driver-created serdev clients without an ACPI companion or device tree
> node currently have no modalias and cannot be matched to a driver:
> their modalias sysfs read returns -ENODEV and their creators force a
> bind with device_driver_attach().
>
> Backlight function on dell-uart-backlight is not affected: that class
> device is registered independently and gets its own add uevent. The
> user-visible breakage is the failing modalias read on an existing
> serdev child -- Checkbox dkms_info_attachment aborts with
> "OSError: [Errno 19] No such device".
>
> Resolve the two long-standing serdev-core TODOs by letting the creator
> pass a modalias to serdev_device_add() and giving the serdev driver an
> id_table, modelled on the SPI bus. ACPI and OF match first and are
> unchanged. Convert dell-uart-backlight and the Lenovo Yoga Tab 2 Pro
> fastcharger to this path and drop their force-attach workarounds.
>
> Changes in v4:
> - Patch 1: drop the dead is_serdev_device() guard from the match
>   callback, and dereference serdev once at the top
> - Patch 1: drop the "large enough" comment on SERDEV_NAME_SIZE
> - Patch 1: in struct serdev_device_driver, place id_table right under
>   driver, next to driver->of_match_table and driver->acpi_match_table
> - Patch 1: merge serdev_device_set_modalias() into serdev_device_add()
>   so the modalias is set at the only point where forgetting it would
>   matter; internal firmware callers pass NULL
> - All three patches: tightened commit messages and moved the v2/v3
>   changelog narrative out of Patch 1 into this cover letter
>
> Changes in v3:
> - Rename struct serdev_device::name to ::modalias; dev_name() is
>   unchanged
> - Model matching on the SPI bus: add struct serdev_device_id and
>   id_table; drop driver->name matching
> - Add serdev_device_set_modalias() helper and SERDEV_MODULE_PREFIX
> - No MODULE_DEVICE_TABLE(serdev, ...) support: both in-tree
>   firmware-less clients are created by the same module that provides
>   their driver, so udev has nothing to autoload
>
> Changes in v2:
> - Instead of silently returning success with no modalias, use a
>   creator-supplied name as a "serial:<name>" modalias fallback and as
>   the matching key, so clients can bind through normal serdev matching
>
> v3: https://lore.kernel.org/lkml/20261023052717.2577234-1-an.wu@canonical=
.com/
> v2: https://lore.kernel.org/lkml/20261022032842.2492572-1-an.wu@canonical=
.com/
> v1: https://lore.kernel.org/lkml/20261021092124.2306053-1-an.wu@canonical=
.com/
>
> ChunAn Wu (3):
>   serdev: handle devices without an ACPI or device tree node
>   platform/x86: dell-uart-backlight: Bind through normal serdev matching
>   platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Bind through
>     normal serdev matching
>
>  MAINTAINERS                                   |  1 +
>  .../platform/x86/dell/dell-uart-backlight.c   | 33 ++++------
>  .../lenovo/yoga-tab2-pro-1380-fastcharger.c   | 25 +++----
>  .../platform/x86/x86-android-tablets/core.c   |  2 +-
>  drivers/power/sequencing/pwrseq-pcie-m2.c     |  2 +-
>  drivers/tty/serdev/core.c                     | 65 ++++++++++++++-----
>  include/linux/device-id/serdev.h              | 19 ++++++
>  include/linux/serdev.h                        | 12 +++-
>  8 files changed, 105 insertions(+), 54 deletions(-)
>  create mode 100644 include/linux/device-id/serdev.h
>
>
> base-commit: 9e947d96915af63e28896caae85a81b74855621b
> --
> 2.34.1
>
