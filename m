Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E237156884
	for <linux-serial@vger.kernel.org>; Wed, 24 Apr 2024 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713938300; cv=none; b=nGyPcU+5Qicw+TISr6UUT7ohP7QU2NrE0rwiOjaur3BanShs28ckOA2uTQjt1+7g3MNzWKIQwL93K+uTd282+NUw77U80GhK/4qdhgL1q8xdgtDQg2h5909LuwoQgWjMXe0GzEvzjETvcJrV5ald2p8Gyo1BBhWmG4eWUwuwnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713938300; c=relaxed/simple;
	bh=ukWXJGkwDRwc3UcBBER5J5oFKEGGzue+iwnJ1u/Jr7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIYNQ0KxYKJNSRHmzLmieMEBWhdG2vIIKfFKHlTuPapq0ISWv7m+OmUk+UwA5UFaE0Ftz+vgjx3Aiv6mMR65/Kv13UbGpDj2dHFn4cRZGOMbZ+xBQG/vt1QQQOUjMgMz2d7AP9mVnLnQg1Xer8ODjqmxH/R5sibCPjWf/JDDSr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AeQfblBI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AeQfblBI"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-434ffc2b520so122561cf.0
        for <linux-serial@vger.kernel.org>; Tue, 23 Apr 2024 22:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713938298; x=1714543098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/W5HSMGzNKRFvroL7XEIB583TE1U/at3BEuUXdJmYE=;
        b=AeQfblBIYDNskyZoINXVuzyw1cDfCp5Ul1CEWRhAk7HhtMpFeqAPZ5YETS7XNZALgj
         p0KKkpaLRMJPQYK8KDoldGgklt5qesLTh2sE5r8zfeZxvnY2nY2cwYS5HspFiFtlMLmY
         OdY6tg1RwbsqEFt4TqrY8UVHS22GfO11PqIM/e4HV2sQrL9v9FX5lJGLbOJ9tgScFhAH
         +GKNrjCUPaSgraWb+EIpAeZ7M2RBhHCX10ETvmMO8tcTn/edvhUH3eDQg6EN3JtRzqgR
         V/nqggQfsLk2e3z1xXvhn5Z0+jVYLRj91Jd6U6YPluiayupZPG4JAtllDfcsqUvj9JPc
         lcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713938298; x=1714543098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/W5HSMGzNKRFvroL7XEIB583TE1U/at3BEuUXdJmYE=;
        b=QJz1kOV3QVW52UDdeMseYcxbqvWapCnTmAapc9FLDDIlJciZ0zVQctk7dvZLwruZfA
         ZZP4dYVgzYmasl9mbV+wAE0B/c9BsOzHOZ6N4a5jDQzDVPs77mw4XKQqt4nBz1oxl4ve
         hgz2EehND5+Ia/jPf00d2zdm53Qtg2jyJ4INiQ1ZinbzK0KQtM5LITkW8NtiTdIbGlbs
         S8f2uca5JBhBHpuiAwrzpsJy11zwzvAU765JrcQbWsj0hNWOdidBahCHpTyAZYkhgqbj
         C1nlOGz8mp76KI1U2sjx6GleT4seEpMmBLNesHcCsy79LSzPA2YtW1DBeh6fMdPeZBlU
         a0fA==
X-Forwarded-Encrypted: i=1; AJvYcCVgM5G3BO1mAADH0C1FK3gaO2wIsS+Vv92xAzvHgaNGUFvAu4w+EsBCBjVArOKW6iWKp+cjvk60rnLvbCt5h80K8Dj/9Z8q1VHCUtrY
X-Gm-Message-State: AOJu0YycuVnZBQnU/ATF91MPbsLKefO8lTmTQvmFM5lo10icKxYWCFP7
	81oK8EBXWm/aFB6l0a72C/0+CFRRatqPDMSzA1sciNoVmnSUFuliTb8lfpLT7dP4HrV9rvbds/V
	IQ8iUUApHPg8Bh7DT5hcaViqVBByH/xkB2elP
X-Google-Smtp-Source: AGHT+IFtH+TdYnY/R2NkKd7EY8OhaQPa4uA2hOiV9IhRrDt+9zqEvKh32061ELbCkTI4QNocIDZCt4lHutO/oQbF8iw=
X-Received: by 2002:ac8:6e81:0:b0:437:c89e:245b with SMTP id
 c1-20020ac86e81000000b00437c89e245bmr130751qtv.15.1713938297863; Tue, 23 Apr
 2024 22:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105130404.301172-1-gatien.chevallier@foss.st.com> <20240105130404.301172-7-gatien.chevallier@foss.st.com>
In-Reply-To: <20240105130404.301172-7-gatien.chevallier@foss.st.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 23 Apr 2024 22:57:40 -0700
Message-ID: <CAGETcx8HdnspNfDEJP+cqShJPsDryzGkOVq6B99cFQzkZi3dMg@mail.gmail.com>
Subject: Re: [PATCH v9 06/13] of: property: fw_devlink: Add support for "access-controller"
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Oleksii_Moisieiev@epam.com, gregkh@linuxfoundation.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alexandre.torgue@foss.st.com, vkoul@kernel.org, jic23@kernel.org, 
	olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com, mchehab@kernel.org, 
	fabrice.gasnier@foss.st.com, andi.shyti@kernel.org, ulf.hansson@linaro.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	hugues.fruchet@foss.st.com, lee@kernel.org, will@kernel.org, 
	catalin.marinas@arm.com, arnd@kernel.org, richardcochran@gmail.com, 
	Frank Rowand <frowand.list@gmail.com>, peng.fan@oss.nxp.com, lars@metafoo.de, 
	rcsekar@samsung.com, wg@grandegger.com, mkl@pengutronix.de, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-usb@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 5:03=E2=80=AFAM Gatien Chevallier
<gatien.chevallier@foss.st.com> wrote:
>
> Allows tracking dependencies between devices and their access
> controller.
>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Acked-by: Rob Herring <robh@kernel.org>

Please cc me on fw_devlink patches. Also, this patch is breaking the
norm below. Please send a fix up patch.

> ---
> Changes in V9:
>         - Added Rob's review tag
>
> Changes in V6:
>         - Renamed access-controller to access-controllers
>
> Changes in V5:
>         - Rename feature-domain* to access-control*
>
> Patch not present in V1
>
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index afdaefbd03f6..7f737eac91b2 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1268,6 +1268,7 @@ DEFINE_SIMPLE_PROP(leds, "leds", NULL)
>  DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
>  DEFINE_SIMPLE_PROP(panel, "panel", NULL)
>  DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
> +DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-co=
ntroller-cells")
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>
> @@ -1363,6 +1364,7 @@ static const struct supplier_bindings of_supplier_b=
indings[] =3D {
>         { .parse_prop =3D parse_regulators, },
>         { .parse_prop =3D parse_gpio, },
>         { .parse_prop =3D parse_gpios, },
> +       { .parse_prop =3D parse_access_controllers, },

All the simple properties are listed before the suffix ones as the
suffix checks are more expensive. So, you should have inserted this
right before the suffix properties. Also, there's a merge conflict in
linux-next. So make sure you take that into account when sending the
fix up and picking the order.

-Saravana

>         {}
>  };

>
> --
> 2.35.3
>
