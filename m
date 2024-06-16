Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D053611A;
	Sun, 16 Jun 2024 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718568408; cv=none; b=e2WS29NUMgbKqHUcOxSS28SimvGVFvgisp5B4WKdIWtBMiz9uogWB+KecqZt+6D8NGOvs+dW8jx9/QI8dGYbUODrbW3vaMCf43jobJqFpO2vBLH0PgCQRP+PecKcBIvJkldDiOl/f8Ixfimy+FGKT86KpsjJQ7xjlqzv8QuV1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718568408; c=relaxed/simple;
	bh=zdEE3Z/98LgHvrgAzYdr4mysyFX+0r1SdZ81GViBwUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EX0kaFRuBmcnLca5YhWwVH2/nEnMgH6y+BPxjyPEIrJq23kmrVNPQDUZ/eLUj5ApFegN0r2WqW8SJBFyryjc6fAfaiUZkz8cTXTISXPrhqV21DMTK2coni+xDAoLdNl4uFjjEV4sqRIy/9hAPm59kERlW+g9WRVZZtFRrjkukSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUDZf9FB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUDZf9FB"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso63267411fa.1;
        Sun, 16 Jun 2024 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718568405; x=1719173205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdEE3Z/98LgHvrgAzYdr4mysyFX+0r1SdZ81GViBwUU=;
        b=aUDZf9FBVPLlFysAOkq5acVV/hN3fDqgttBLS7SWWCD6yOVtgC6fo63RlUvQ5+2AId
         hjHdQCV5kg+PpsDwHUjuejX9rH6qwUydyJnPUkyvlY6ehE0vZpqJCieVDf+MW+/3R8cG
         U93VloOCweje8/JclnZMiERy7VKqoGlHkz2L0sgamRH0NpFId7fyB43jm7jE8D/40Aya
         6BjEPLyfDZLDIlbXAna73EIQISTScLNxLeSKkNuWCS2SEyVfY3Os6ujpe/Jojo19+hKv
         lNRKGL+nqauy/cHdoTp8e1bwWX8yFuZLYQsby9lmPYTPs0yFHa1wot/V0ROawQQSvbAB
         l/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718568405; x=1719173205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdEE3Z/98LgHvrgAzYdr4mysyFX+0r1SdZ81GViBwUU=;
        b=lfOq0WSZbhnDjkUMYCNhvi1ST5LlJyE72QL1YV5xSPKKnXu9TGbmYI7i/tGF2GrKC/
         0WWYQlf7JGNaiV1kpAQM26wpb0gHhuV9vHHbKe26ocHFTIpkZlF1i++sZ4vl0ennWN/p
         /63mheQ4ofj21NiVvq/tgDmrNkSWzBJm+u+X6ZjkkDdBVQXyeKJGA/nWWRRl5fUIDgXl
         PHv37QdH32iCurwRZqHEQXkTWDi4CakhzKdNlwdipJnIAHmZ41+L5ebgdqj3J8qjU2KU
         m+q4nKSItuAadTAqOpgjbj6Jha6psIFwOVh8cZ/OMftFTpS+iYD3Re8rdYMqjwLjDEJV
         nY6w==
X-Forwarded-Encrypted: i=1; AJvYcCWaKeNoQTGGYTC6mUE1bZ/UAknVh8+iWQ1hJGzDztmlpN7su9PH31qqujqk4okvauardGJ2x/HjTs281MJ0Hrjc4AWBnAzk8WNWc+iZ/7a2JLMdyAcw6hgXePpNShweqlLljCQN2gJYrdGG
X-Gm-Message-State: AOJu0YzxMCcQk+ZlHhfq3gDi0J3evS9cNTjnMKmPoiCEcSoOJdyKx8xc
	6QTOX31WsTBtimOk+ProZK8FZBpIA6H+SE21TL88LVafU8O/qRCv6zTc5cALiID4gorXZVls2wN
	lvhuA58hzo1mYuvExpzxozrauVjg=
X-Google-Smtp-Source: AGHT+IHObiQB7LL4C/5+FYIsfN1rmPNm8ohg0PljoTLJ2nGnSvW6tHM+rUfhp1WBrtSvbcRNHmcBxQbKWPNJpeiD+rI=
X-Received: by 2002:a05:6512:1056:b0:52c:ba7d:f032 with SMTP id
 2adb3069b0e04-52cba7df104mr2298460e87.16.1718568405315; Sun, 16 Jun 2024
 13:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614090322.2303-1-crescentcy.hsieh@moxa.com>
 <2024061406-simmering-sanded-17ef@gregkh> <Zm0odLN7ZJ/qI1nX@localhost.localdomain>
 <2024061500-jeep-upchuck-6b3a@gregkh> <Zm5nFVCNfLZbW5tK@localhost.localdomain>
In-Reply-To: <Zm5nFVCNfLZbW5tK@localhost.localdomain>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 16 Jun 2024 22:06:09 +0200
Message-ID: <CAHp75Ve3mSt_LRnpZuX5gV+qc+HsO4zZ86pcAAcH=jztxibt+g@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: 8250: Fixes: Fix port count mismatch with
 the device
To: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 6:16=E2=80=AFAM Crescent CY Hsieh
<crescentcy.hsieh@moxa.com> wrote:
> On Sat, Jun 15, 2024 at 08:18:41AM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Jun 15, 2024 at 01:36:52PM +0800, Crescent CY Hsieh wrote:
> > > On Fri, Jun 14, 2024 at 11:07:29AM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, Jun 14, 2024 at 05:03:22PM +0800, Crescent Hsieh wrote:

...

> > > > What commit id does this fix?
> > >
> > > None, it's just a normal patch, I might have mistakenly added the "fi=
x"
> > > tag.
> >
> > You say "fix" twice in the subject line, and it looks like it actually
> > does resolve a problem in the current code.
> >
> > Or is this all just a "cleanup" change?
> >
> > confused,
>
> After reviewing what this patch has done, I found that it does fix the
> problem of retrieving the wrong number of ports on some Moxa PCI serial
> devices. However, this issue is not severe enough to cause any system
> problems.

Yes, but it is still a fix. So, which commit does it fix? We may add a
Fixes tag then.


--=20
With Best Regards,
Andy Shevchenko
