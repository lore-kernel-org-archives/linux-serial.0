Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5F188008
	for <linux-serial@vger.kernel.org>; Wed,  9 Oct 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479912; cv=none; b=a7rWzhOnLN13XabM7G35vYEtLSxQwSkE3S7OHdaxO7uBAIOoUtTh++HUdIk7MW3RoLMpkV9UHlFnJn6RamRkERrwVzM/evkgrFn54D91uSpUsVYEo7fN3Ihnd7b3WJvxoAHoQvfD0GLdx7jfjfsYO/1FZsPauL2QvTT3zwagDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479912; c=relaxed/simple;
	bh=DEs/d30A6OdgSded7yLq86hpsqBzL2gpxnYKoRS9vWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUm7xszj533zLv9ccoAeXzdMAPknIGPnTXbVDclMFdGNrSO3nmwt2wr75sTZ0/x73BkJoRp2utnlqgHtPFus9P0mrU8IZZBlxta5TmUe/nFpXPoy/1JiKJa0Ad7mU9Uh7YXi59UjqWdFQuTqEg8JaMMdH/tbovUPnvWJ4sml4Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mM1J/c1T; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mM1J/c1T"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e28ff55468dso767930276.2
        for <linux-serial@vger.kernel.org>; Wed, 09 Oct 2024 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728479909; x=1729084709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fahjuP5GSwT5SXM4x2ztwRN877oqyqnMQjfzefZnQm4=;
        b=mM1J/c1TOedfqGlDpF0hjCdX9OAj4kbWxx/1tPRvUwuBGhrW2eUkuSiZQg153bzkhU
         BHfoJyHgDBOSwoK72YQkDuYLe/Er+Yqn/9e3MBggW5vuWJJwx+C6k7dBaSLAIAZ56EoD
         yntdjkpFgk85kXnZS8nnO5nBx8JDrT6eP9VlDp4swJ+jMAC7QaZXCnXw0vDU6lPUDkUs
         IFQhPg66TUT2HTQfXB3fqYBt0ghDgC2hkfZwZxGV6CY/SL3wXd6hF55/HfSB47+AFUJG
         WAcdiSylD4pXC3PsjOHXnr22d9GCrWKrvy/hssW16NbWI7l9VsCDPLUORqk0mFFGyQv9
         sbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728479909; x=1729084709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fahjuP5GSwT5SXM4x2ztwRN877oqyqnMQjfzefZnQm4=;
        b=mZwAJdzO8wbP5Qfq2Nf4sJ6zoHQ1giCBzOqMrX506vHZ0SLoMvnSPp0sz1HlXp8YXz
         OlY3QNrXsW2XqQfYPCs3SZcN9Y58086WE+zmXi0UIB7exBcFk1bylEuNNtDulWASw3xJ
         vzi+9ILV4sO1nmmFQ3NFAjLlDJXgycsj27SMDWHBHcwPidUHAzQsD1upNbVLPX1T/E5P
         SophAD2beTQ6JOqrq5DJuGVVvHHVCaF+WKRwCRBA0LRigKUPvEfyPOoiJ/PblbXf73TU
         QuTv0z4s8pKbSuq49JWOCGbbGqJnJTqYjbE101waSxAixRhY+cQfQPu53zAHdKJFuWlx
         fhnw==
X-Forwarded-Encrypted: i=1; AJvYcCWi5+eIu5YDajsMdkEm9N09ficsKKSL3i5q341ZXNC2mLn+zImg1iKzlkMrin8d/bo6nNAgY7kD+k9TzxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtOKLOFBXVuUOPgZrnr6wGonc9fGxHAFgxU0Qvd+O8Y1gVc07r
	7Px4CZyouZRW4kKJYw/ZKdKP3p8HhX7dkoMwkRmFTEwZh4T6T5UGq/FCvY/i2AuNGSAYqWykNOX
	HxK+iZf8/SaUO8sIUn7SZebSRMSZb8dIeAg6g8A==
X-Google-Smtp-Source: AGHT+IGdMVfirN3r2XR9CcAsjc7P63ptNZgOVR3DTBZovGzj3+iT9kj28KuHzCMjhXPK3VMUIZsVtd+U5lqO0q997qI=
X-Received: by 2002:a05:6902:124f:b0:e28:e605:2dd4 with SMTP id
 3f1490d57ef6-e2909c1b69bmr146400276.17.1728479909496; Wed, 09 Oct 2024
 06:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
 <20241008-8250-omap-no-console-suspend-v1-1-e7f0365c02f0@bootlin.com>
In-Reply-To: <20241008-8250-omap-no-console-suspend-v1-1-e7f0365c02f0@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 15:17:53 +0200
Message-ID: <CAPDyKFroumouYavhaHp=aSh=0WsDO=_4kbVgS-+Y7CADyO-Kmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: ti-sci: set the GENPD_FLAG_ACTIVE_WAKEUP
 flag for all PM domains
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, u-kumar1@ti.com, tony@atomide.com, 
	khilman@kernel.org, gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com, 
	theo.lebrun@bootlin.com, richard.genoud@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 11:34, Thomas Richard <thomas.richard@bootlin.com> wr=
ote:
>
> With this flag, if a device is marked on the wakeup path, the correspondi=
ng
> PM domain is kept powered on.

Perhaps extend this with some more information that it fixes a problem
for the uart console too?

>
> Suggested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Should we add a stable/fixes tag?

Kind regards
Uffe

> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/t=
i/ti_sci_pm_domains.c
> index 1510d5ddae3d..38448b4a035a 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -186,6 +186,7 @@ static int ti_sci_pm_domain_probe(struct platform_dev=
ice *pdev)
>
>                                 pd->pd.power_off =3D ti_sci_pd_power_off;
>                                 pd->pd.power_on =3D ti_sci_pd_power_on;
> +                               pd->pd.flags |=3D GENPD_FLAG_ACTIVE_WAKEU=
P;
>                                 pd->idx =3D args.args[0];
>                                 pd->parent =3D pd_provider;
>
>
> --
> 2.39.5
>
