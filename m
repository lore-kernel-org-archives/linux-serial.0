Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792562750;
	b=SnPW63nDcS1famJkMspkGP8OWA1Mu9yjD045P8LSTqmcxV0d+1WlGq1zARTc/G5dNxsW
	 xcmraso9HW74OAlldauvTrIiM++jw44vXwKTx0nsP+vlEDnnCZytiWL0bUi2Q+ly6bDRY
	 AKa4hXSKRy2ux4rKMUuosVvp3wn2ySSK/zgtt+bXESXoVD3SRmlIggfWxZxKZ7hzQclg1
	 nok4hO5QA7IC9N9/RtCXoYuUwN42aYR105PkCQeOQHJ/ymkVroa7UvJILzOviuNCK8FzI
	 6/HU3AJVxw6xxQvbCGlgiEa1O//tH8QPjM8kicZhsVoWer0bYHEraAlUWrMvhZ/nEjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562750;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=NeAEPcOxK40T65rDMNePEAr3pakVYVs90Oj/HtwmwkM=;
	b=lTsJXOSY14zkmEllbbF5v7NAFt2HQ2nqgxkO3I3g4dgBY0zZPzjLbbBkPp33BKCvlwzZ
	 Z//s2DyqsvTF8ftfXwKH7yycjoUOD5FI6n2dyZFwqLjgmoA7Oet+kFcf0fDh4kzUoBEZH
	 VdLY1oI4NRnSdNnCIozMM1v4CMn4vgYVkqVhCVafoUv6mcIRm0wWGknzRUnDQwCCcHV+3
	 Nud6xFkppgvHJAtKqV9f/+pepOyKoiR9yc4VuGGYNQ4PUzFTukV0vKQmcqe0/mzoVI6Yt
	 hd5nh09/668b2MJeTV0Xf2eozVS5M+1tEGdtVN/z3ccGxiO99YERw7leacSs60K5oPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=qJr8260S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7860A2602
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 06:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88C7860A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=qJr8260S
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B9C5A3F98D
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 06:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792562740;
	bh=NeAEPcOxK40T65rDMNePEAr3pakVYVs90Oj/HtwmwkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=qJr8260SzRLr9eLbFeuEV+/2qt8abtp210vhqLA8JwLTq9X1VWOzfHtbnL/NlAeaj
	 OjpLrFF6PfJTDmhM4LqcCjL5ck+KNguaY/b0ObRbBPM3AGOKiaVH/cM1vuVpmKLpTN
	 /WJdcTKcHJhFXzKHY1GJuSba9oM8DfUrCvDhud3YC5rsVFkTcWJ2qTg+9vHGQHUg3s
	 37KsSmH71HC2ziK4U67V3cffNpA7mPEyLWjoqRjeFwBibojLKD2B+Msktqgf0KAljI
	 98d983Rm3WzJTDZezaJX5jvMSTM1w5ndYFF+9svtEc1WUc76KNdf9oFDrhqgrG0s3p
	 pT8EHftbrdP91PYNc7gEaiTxzOoQyq+Dq3aD7W1hu2/Po7dwd/sJNB9p+2Xa2YGd3i
	 oo3jBzOb/gdW09O8diMowZ/U4WUOgYUieCmretiA558fNOu8SlbKVUN/zXzl7ulTB6
	 r+EnE8smQUH2JgyAJIj9GmEFNkzQOKZKdWvSZ2BELE3hBI9gdvH9G9bdZYRZm4+kTc
	 4Umeiz/QE8WYRNs1VtrFinmfbv5VlcfWwmaQU4Emy5GHv5psAf1jX5W86TlCzBWeRJ
	 HUabrlmnDgm5J5lD9hs1NlOTwE9vh1kyMpT8CShxLlo8ybZP6liBxYjQh2YHlHhLj+
	 wsIlhK0pRGMKN+b/18uR6p2E=
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-5407322f927so57003b6e.3
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 23:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792562739; cv=none;
        d=google.com; s=arc-20260327;
        b=Y6Qfb5a/D+zZ04fEW6TVjg3MDwwbr7IYdumHvpJeceohTtznsPS7KPu4Vpuh8Lx4kc
         pvbrYXdeKBypp6jehyyn6M534azL5Ppm6Gn9UZFKQ1HfBKJ+Iu0Azic84srGvvZJGSWe
         n6ipF/UNu/jBE15DfiAv0BH9BFqk4FUvOT5eRfj2lH/xEFPjZlQgZdOwtb7zphFW/iUw
         5+UC594FIMC+e38qZMY8mU+2Z4D0g/E3mZZ8JZPUtMyJeDQJx27ThZpvBQP2SC75y8Xh
         J17qHq9dE8vF0246S8IRaJe2RZr0kV8tV3oNxNUaM3BWHCbobRVIEG0IkHnoQ3Br7pn0
         Ue7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=NeAEPcOxK40T65rDMNePEAr3pakVYVs90Oj/HtwmwkM=;
        fh=2sYPVCfnUihewLZ62ZT5uXqGFoRRvT2ZvcxEOElwOjg=;
        b=G1NOQj5tSQ2sc0aNHBphCxqNzeADhE3UHdWy5sxRtVOwWETVyxcueT7XG2tcZJYgSR
         6HwWsPcAHwCKI0BpoXR78DtTmBiMMoN0tfoQDdkhY5BjnWHvt3kjMX19qQPvtqafiA2B
         Obu7W3tZvlKkTIxYJALA3REjOL6XG4OyDyid2kLS1VRDBPy8eRUHpVZy0iR/qJc9cRid
         OIrur3uhwSZpv7IyP2cpYGNPVaWyl5xbbGVtlPtNGhKfS/2YicGxPUjPE+wUvnn9HV+m
         QtmjkPqpjY4LhNAJigjbpTrV5Q9f7WYp4niJiB7GhGEI6h1qLeQaRUrZscayZb/SH+CN
         5suA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792562739; x=1793167539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NeAEPcOxK40T65rDMNePEAr3pakVYVs90Oj/HtwmwkM=;
        b=gVjB4x/M8iIynERWx/yAajj0SnomvW9NNBBxns9IMwHHTWNT5ShXY7UKXuuOwCltpM
         SbR2fL06ed5nP8M2tarlPHnx8T9GSedwcBcfeEhedLk29eOnuG5Vry584K4FxyLJZapJ
         aJsdKgB9rZZ15F5dbktsgYOY0kL8QZs8Ho3gz1kLXJpStIB+A72xIIrAN/M+hcAZAtfn
         +FnLysBPsKr72MVLUJxgzJWgkx/nRBXfS2zKJ01hTOtBcqhxvt1sizxgz7/fYjzPmdmX
         vd8mR9iu98JTRFcGmlZ9wn38xQDwRxckSGCsDf7VnK6VzXMc36fG7VV5Ns0veRrhrtK2
         XSTQ==
X-Gm-Message-State: AFq9FYIGKag9G1cIJptooKSInS2YIVH0DrUxpUBZRklxzCRBqmzGNLuX
	Wx7M6PY9EKOqgAv7eodW1QiZOZLvbp3fdKCHoFtAjogrWC0NBtBZl6ni38FsUSiwOtME9ooYQLV
	gD/oMRWTF9Arv5SAcyskQ8Ghv6ZE2xDwiF+S+VC0zUEhn8ObNxHpYeEaaz7IZTfF5E9m45y7p3X
	fo3js2gMO5wGIIfmjuPTbtBr1D6XMpYQMqAYEo5UbA/uN6WJ6t1xX5glNo
X-Gm-Gg: AYBFou0gq393QD+EOmIwawRUbLSE1FkUj/nCR5wDujpcf3Fe4WpXDo/lxTUbvi/vTqg
	LeGHsgOgAyNb8TtzgG9HeQ2Msz36ctyuc4CIf3wlRYih+NUQCYe/fM/0XO2VynGmgaEMbD1Kp/S
	qboe7JTZuQFF7aXWmxyGmf6pe7ZrtneTjF6VyBlQqfcQZ9lNcU0aeVO52nzhAl0jrF+zd/EIqR4
	Si/2zBJTOo+b1k47SbkAyuXuQ1LiyqgvNQrtrV8VSiRxQgB0yZJCofyRI6k5odLmVD77gLd4Rw8
	GSzIvQ5IFsB1pA==
X-Received: by 2002:a05:6808:2220:b0:4f8:4a95:991d with SMTP id 5614622812f47-5534e97b346mr929757b6e.2.1792562738777;
        Tue, 20 Oct 2026 23:05:38 -0700 (PDT)
X-Received: by 2002:a05:6808:2220:b0:4f8:4a95:991d with SMTP id
 5614622812f47-5534e97b346mr929748b6e.2.1792562738360; Tue, 20 Oct 2026
 23:05:38 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019054513.1966382-1-an.wu@canonical.com> <8e4ca13d3e8acd5d649bd4c7357e5da0785ba6b3.camel@posteo.de>
In-Reply-To: <8e4ca13d3e8acd5d649bd4c7357e5da0785ba6b3.camel@posteo.de>
From: An Wu <an.wu@canonical.com>
Date: Wed, 21 Oct 2026 14:05:26 +0800
X-Gm-Features: AclHuK85Z4K9KYus1MecV1QLmAECfS38JxGPUGudcVKY7TXsOmoxb0qgKjK_XhY
Message-ID: <CAO4Mv0ZvktJxgkP_YHLXneH_dmg+bPP-A6xEgL8L0K_bJictxw@mail.gmail.com>
Subject: Re: [PATCH] serdev: handle devices without an ACPI or device tree node
To: Markus Probst <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus
    Thank you for your detailed guidance.

BR
    An

On Wed, Oct 21, 2026 at 12:42=E2=80=AFAM Markus Probst <markus.probst@poste=
o.de> wrote:
>
> On Mon, 2026-10-19 at 13:45 +0800, ChunAn Wu wrote:
> > Some drivers, such as dell-uart-backlight, manually instantiate serdev
> > clients without an ACPI companion or device tree node.
> >
> > For these devices, both modalias helpers return -ENODEV. This makes the
> > modalias sysfs read fail and suppresses the device add uevent, even
> > though the device is registered and bound to its driver.
> >
> > Return success with no modalias when neither metadata source exists.
> > Devices with ACPI or device tree metadata keep their existing alias
> > generation and error handling.
> >
> > Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> > ---
> >  drivers/tty/serdev/core.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index 7500efcdfc21..366c6d906233 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -26,11 +26,26 @@
> >  static bool is_registered;
> >  static DEFINE_IDA(ctrl_ida);
> >
> > +static bool serdev_device_has_modalias_node(const struct device *dev)
> > +{
> > +     if (ACPI_COMPANION(dev))
> > +             return true;
> > +
> > +     return dev->of_node && !dev_of_node_reused(dev);
> > +}
> > +
> >  static ssize_t modalias_show(struct device *dev,
> >                            struct device_attribute *attr, char *buf)
> >  {
> >       int len;
> >
> > +     /*
> > +      * Serdev devices instantiated by a driver instead of by firmware=
 have
> > +      * no node to derive a modalias from, which is not an error.
> > +      */
> > +     if (!serdev_device_has_modalias_node(dev))
> > +             return 0;
> > +
> >       len =3D acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
> >       if (len !=3D -ENODEV)
> >               return len;
> > @@ -51,6 +66,9 @@ static int serdev_device_uevent(const struct device *=
dev, struct kobj_uevent_env
> >
> >       /* TODO: platform modalias */
> >
> > +     if (!serdev_device_has_modalias_node(dev))
> > +             return 0;
> > +
> >       rc =3D acpi_device_uevent_modalias(dev, env);
> >       if (rc !=3D -ENODEV)
> >               return rc;
> >
> > base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
>
> There is a todo comment:
> /* TODO: platform modalias */
>
> Resolving this should also fix your issue.
>
> Also keep it closer to
> - platform_uevent in drivers/base/platform.c
> - modalias_show in drivers/base/platform.c
>
> and avoid the extra `serdev_device_has_modalias_node` function.
>
> Please also address the similar todo comment in `serdev_device_match`
> in the same process.
>
> Thanks
> - Markus Probst
>
