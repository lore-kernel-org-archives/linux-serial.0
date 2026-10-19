Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D73AA4E1
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392242; cv=pass; b=Fm+SBtplCnds+cCu96WCWOQXXk5zm22PM8iZWCvIejyvCOOAGEYw+yb9CC9UekceP7eoiE+eDCqukexHUirKt00jkXwOnEFLIBQn6BXTzwCzndqxFGq6H8dfYZRktUY3CsGry9swyKa78gmsxUl3RNMa+NCrDAI6sUYdzgb37HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392242; c=relaxed/simple;
	bh=MrucJgKnCH8Qe8dHK7tSfYbP1+rchG4+5cQ79srr4Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7s9edUO+NKG+eOVTu9eKwiOu0ui3+OGqSuWOspdD/hOqWtOKh+pJfuNGokJHAKKcQUXpGno2BtknTVDcYDgq+PwI/eUmKMNuFcyqgh3vQh1hQJtFEEnS9cJ0psi33Xq7js6Kba1RZ2lkXCg9SGhu3qAcUTilI8YpxR1lmYtcEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=CVbI0SSe; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="CVbI0SSe"
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D8163F342
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 06:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792392236;
	bh=fyMAES43nV/sif9SKzr97YR4lZsRCc81pqe+ceG8i9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=CVbI0SSeANErqYzIs7ahLEFKS+wEoCBMPvgba8wGlda5Cn+o/M0fQRKl0LNA+w5JG
	 CjJAqZovw1PFk2TPEk6jh2IPHY3KUdjBjsbh35Gl9VZLJBUC6t+M8QVp8LquacGKgA
	 +EVLqgiAkRd/VDdYHz30cWo+DDNBO6H0JnXUX1ArofBJJV4TfSiDKyx5AxrTIQ3ii7
	 PDkpQ6HmxOQYB1clikJs1HSLbH1cRZ5nISwwH0ClKxT2KswVkSoWesVe024FXzlfgm
	 exgExSrqG+yMaotCqOSUvaXrK5wQ45PXrlOzVIkVIr0kl4veVRsn5T85KWU9BxSIT/
	 G/dvVQWL0UM0X6rlyOEYY7KALFM3OBRseyMu9ozAC+wmvk5iq4/pdqE50YY3EC/2xo
	 j86y7GpPFzjqi1U7gxRNH1irIyt09HNUmnyMHs1R7Qyjz/cKvIy02L6Fo7406c6W1o
	 j2Fz4Ez15cc9kZ4/Mw9j27ld16sJjQ/LbB+wWkHLOikxOrc/XyjsYYOcFVBv9jFSlE
	 5n4ofnNNOHkpDejbkKzHTxDjX49ch29NRpaL/BZ7MIS8iLiocQn3ov+axkTX9tvttw
	 vzLAV5BVxkX4Hp6ClGECUUavsY78CDzu0bsFgUMq7KWlF1ifxWXsEmdUgiGOyT8NDe
	 IoLopCneDm2e5R7OKncJoDLw=
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-5437a1d6688so405799b6e.3
        for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 23:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792392235; cv=none;
        d=google.com; s=arc-20260327;
        b=sePvruCNC6+5fEj1uMXsBjXvDytS95NRwfnUrEKMSttNjxPYzMDMtB35cakZVgy8bG
         KvO8/HMDB36u5AlpWKJuLjcUe9EY5/sFZwG+Wg7E/BF7MymN/9Q1MEocFLMlzeTjIOI3
         kJZkxFtKmtq3wdmPZqcHxpUHLcfuCFEyq1u1JD51Z0yLqklV1kHxMmDYc9MFT3SSU8x7
         3lVH3Z1vvex9K9I5I34tf8Vow1p/U39tROa319chyjGlvK8+dWF6AxWfukANswEfAJYC
         NMo2QHG/3hqpt36xn3ayHAkUfXzSnOJV0Ukv9hscAfgZovFCEt9vwxogQJSmLOtlNqCf
         onrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=fyMAES43nV/sif9SKzr97YR4lZsRCc81pqe+ceG8i9Q=;
        fh=l/hBeNRXpopV8eOViCMD2HznICFLjYQrA5ioVJ3vhpM=;
        b=FtP2Mxi9C7zZTX4tiTeipd4ZwiYgWp9CUzLtF2owHcw3GyeUH3B1vtQ5bM0OqiwzLX
         ZbAhIz1TnRifOO41wTYKm0A3vV+0GRlbFUGRgrSVR4FDNtnG49Vi2c+mvKRzUBnO1o1z
         IuG1zbRQ5o+qhK+gFJeFYE26RZjQoewHj3FZ3Zn4lxR1Tv4qU2RslaMYEqojVnZ+LsH3
         GJ/FYjc6yM6WdtBBLzkzkshx1Ry/acYEnk7KSkRt4uvSiNUgL3Z657omdTs52kN6Fr1E
         RMSWGs3fOy4JftIgJIFpiQ98j43m7H6quGNgOgJPzeSm/IE+b/iQgLzD4/0jZyHRjsTN
         mhRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792392235; x=1792997035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fyMAES43nV/sif9SKzr97YR4lZsRCc81pqe+ceG8i9Q=;
        b=OfLA7ethL+ss/Qsg/XKmAV4fJvy4i5U5L8KxwldLcXhcvziU/EOWpD0hLGIULlTSRJ
         Bli+9gAGuPpQpO3vb2AUuj+M4AaubyQA9wWJhftzxIrfBB2tNZJFguLDenM7/iM0KLyz
         uHLnH4tX6NW2VvaoPpbbgK5m9J2bpudZllSvzhNlGB6UxYzwcwBYWTHlRoCbG81pcFqH
         8ijCwcFoGIzvN8QOCiTajjrfFh6qm8tqVjaI7lf4a4gt4SDGur6wuLrF9vhXbM+lyS3Z
         l52BgE+io9IOM4MfSkPV+5MCCFvW4U2AYI9YPxQql9IHb8hF0cIJ9BWZb3Bkk5RmRoYt
         hElQ==
X-Gm-Message-State: AFq9FYI7oCB3YaBoSYIIj90DgpHffBc9pF6mGmOQ/CXdgfr/OnNfCa8F
	wN8K63frGO2cq1Q6mSUxbHKveoG3g5xle77U+eLjjYo9z9AnzWDKcZFRiV8BOfU8VM06CKqL3yn
	wu1sVgYlJq+y2C2/LPYy47qDtU1KmxlcDJ50YHeoEziHbm2+Gvnr2P9fsBCR9THl9FhZxFVzIuF
	nhjCfqN/+u3CMcb4Knni4lQC54hISmaCb//Tz+atjsCEWyX/mRTTfGo1A4CF+4ufVHIPE=
X-Gm-Gg: AYBFou3jXrEVwJ2qk/pukuEAbPXs+rJu2Jic5fnm7ih3xNs9dCqiYMRgTWKuy2crkva
	kobvi3Kv+e+b5aoiq5cGCCQpfFbKgt+qULtmiQC1x9PeD9/gOCNTTkmhhrlOq6l/KcIpsghsYiY
	aIsOhpFXnQtPlfpsFYli1lJNqNkZ+78ASGvzz/c8b3OQmDp/sCXrsIqiLdW6KDXWhmRNPpL1EOL
	WxQtNa0XpGdZPRVa08qsDJ4Ne4oUXL4Rlz47ht2fmUYJ4x7jPe0am18ta8cbQcUkbemsnE8SRkI
	KngUSi2hW2J3gg==
X-Received: by 2002:a05:6808:2206:b0:539:dfe8:995d with SMTP id 5614622812f47-53cd247b946mr6699893b6e.5.1792392235094;
        Sun, 18 Oct 2026 23:43:55 -0700 (PDT)
X-Received: by 2002:a05:6808:2206:b0:539:dfe8:995d with SMTP id
 5614622812f47-53cd247b946mr6699883b6e.5.1792392234737; Sun, 18 Oct 2026
 23:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261019054513.1966382-1-an.wu@canonical.com>
In-Reply-To: <20261019054513.1966382-1-an.wu@canonical.com>
From: An Wu <an.wu@canonical.com>
Date: Mon, 19 Oct 2026 14:43:42 +0800
X-Gm-Features: AclHuK9fLzpi3LcS19a0dEgUumb8qZ0o-YCt3vpFNf4IyTCGvz5E2WK8J3ChTIc
Message-ID: <CAO4Mv0aNe=Rms2=C5pbB3SEDRJmNKW86P+wzdMa-dtfUK522Vg@mail.gmail.com>
Subject: Re: [PATCH] serdev: handle devices without an ACPI or device tree node
To: linux-serial@vger.kernel.org
Cc: markus.probst@posteo.de, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, jirislaby@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cc linux-kernel@vger.kernel.org and jirislaby@kernel.org

On Mon, Oct 19, 2026 at 1:45=E2=80=AFPM ChunAn Wu <an.wu@canonical.com> wro=
te:
>
> Some drivers, such as dell-uart-backlight, manually instantiate serdev
> clients without an ACPI companion or device tree node.
>
> For these devices, both modalias helpers return -ENODEV. This makes the
> modalias sysfs read fail and suppresses the device add uevent, even
> though the device is registered and bound to its driver.
>
> Return success with no modalias when neither metadata source exists.
> Devices with ACPI or device tree metadata keep their existing alias
> generation and error handling.
>
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> ---
>  drivers/tty/serdev/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc21..366c6d906233 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -26,11 +26,26 @@
>  static bool is_registered;
>  static DEFINE_IDA(ctrl_ida);
>
> +static bool serdev_device_has_modalias_node(const struct device *dev)
> +{
> +       if (ACPI_COMPANION(dev))
> +               return true;
> +
> +       return dev->of_node && !dev_of_node_reused(dev);
> +}
> +
>  static ssize_t modalias_show(struct device *dev,
>                              struct device_attribute *attr, char *buf)
>  {
>         int len;
>
> +       /*
> +        * Serdev devices instantiated by a driver instead of by firmware=
 have
> +        * no node to derive a modalias from, which is not an error.
> +        */
> +       if (!serdev_device_has_modalias_node(dev))
> +               return 0;
> +
>         len =3D acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
>         if (len !=3D -ENODEV)
>                 return len;
> @@ -51,6 +66,9 @@ static int serdev_device_uevent(const struct device *de=
v, struct kobj_uevent_env
>
>         /* TODO: platform modalias */
>
> +       if (!serdev_device_has_modalias_node(dev))
> +               return 0;
> +
>         rc =3D acpi_device_uevent_modalias(dev, env);
>         if (rc !=3D -ENODEV)
>                 return rc;
>
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> --
> 2.34.1
>
