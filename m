Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F3F13B588;
	Thu, 13 Jun 2024 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718311715; cv=none; b=BDyHQ4yDBaHbwi4/WMDq/+z/yWdR6STfMIRNEzQnjMc6dDWFfOBdMSXHrIpATJSRmXFuZAhkDM/m+e0bVxddkcFNoZ976LXfz+id3B0vXXbRvdmeuOt8gmRHU17cWNAHSDWSzof0ShSFBj81ys8s3YFkTh8OrXjccRTRAz+DJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718311715; c=relaxed/simple;
	bh=L0KOOhVuxd60mrMOguSYJIgTVodk+yK+4lWwef/NX5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGQWx9L31D4K0duYqH9E4eCyoBL0ecAXtmCPWYNgYrz4DvtFz81JDJmVwks+tlH4A3CKNMWzvUJpUyiCDm5HX75jCBC85ocme7nm3A6fMTlixkZGcgxtFLZ8FiZ7Kpzr3+dxLdqc0YBsVmjYVaRw2PzB1xbKRgkJNnFg09nnEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoVlJBcz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoVlJBcz"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6efae34c83so195519566b.0;
        Thu, 13 Jun 2024 13:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718311712; x=1718916512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvk0v4yG3/t6YZyQfeNudt0AkpCPJ7jKM98d8gPFSTI=;
        b=NoVlJBczu7ICMMcpQpoCPqmlg6HFtFBhoyVAIZyazmBMbqRWrQoYxSWRQssJb4ScQ9
         37+r8w3aw2n3OO43CiUkoaTbS6aKwFoBPEHqcV8u+1mLU34Zo0vRe8gK8BK2vr1zZV/P
         DABQgnxR6WxQYlUEc8nmkFK/f6dN/wi5faVP6PnfPfamAkJCkOB3xHgZZIHDK3m32Kdw
         S9iBtOozdlIGsp9y/pVx5qn64Nwa/oBQz7i8ZASCr2v5xiOiCHpMDMb43s2Xpl/jeLhY
         GhqHkG1JThZjt3MX1GNb7bLcOhshW5rI2JFZ9GCXzuJTNjv3m1PR2T5WtyE3/iN6D6oD
         ocCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718311712; x=1718916512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvk0v4yG3/t6YZyQfeNudt0AkpCPJ7jKM98d8gPFSTI=;
        b=bD5b98OUsrj29SJJlNdSDtQFHFr+DaUxhvUe69g4rsZ5ux/m8npdIxTUkJA5OPW6dV
         bqkiMH1iz1pGZDHCoHoe1UJUQp+TDvZDr5dKJHdahSJJxbAdFW/IgoOo7K7acfggRqjE
         A4UEzTU3SV2qDTZYXpHh/+h/WBVRo6yuy+HXuh6tLCUDtjgTh+2jz+wq3wGs4gLNBeo2
         bWLsqoe52RQmH/XG4+aTyGJG9RBApkV7GBspfgpyZIC87juCe8ZjZ1wrDHh6iZexu3nk
         /ylh6s+HZnYyfIiglmn6Nf2JLNw3qoJ0fqVv1HWx8gkkT9DFcUJLrulwlZYmpaP5KpuA
         PFrg==
X-Forwarded-Encrypted: i=1; AJvYcCWAiArLu2mLsRghvp2EOBIe++51/tLL5cKDy2bib013jL89aFPwUA2GfqXNucN+hhLPwbUvLtqlmwUPINJrE85OfXCN3vCayTIRLw==
X-Gm-Message-State: AOJu0Yy4I1FaKgqCGAWUvON0iDYXFn1cCzhgiKe6OYI1mwvViDxiMzbu
	YvUIbz5kOwabi1d6C8PYeLg3FLASiBbZof9oPZhPwKhcJU6SxZl70QUdxTE7nETN8K0Hv1BiRN9
	k9MBxBB9eXqa9IlP5wo2id8gSpefXGGN9fm+62g==
X-Google-Smtp-Source: AGHT+IHyDh4OwJuVVLPRPUIEuzM7hBD6hlZs2pDuXDTrOXcX6l7ZkjvT/zo0+umsZaIkXSyToKl3k1BnsORmyrYmlVs=
X-Received: by 2002:a17:906:f901:b0:a6f:309d:ec23 with SMTP id
 a640c23a62f3a-a6f60de68bdmr45626766b.72.1718311711947; Thu, 13 Jun 2024
 13:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613082528.22591-1-hui.wang@canonical.com> <20240613082528.22591-2-hui.wang@canonical.com>
In-Reply-To: <20240613082528.22591-2-hui.wang@canonical.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 13 Jun 2024 22:47:55 +0200
Message-ID: <CAHp75VcuobPDHX8eAskc-=SL5_527PqRiNCSfq09=RpP9EH0cA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] serial: sc16is7xx: hardware reset chip if
 reset-gpios is defined in DT
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org, 
	lech.perczak@camlingroup.com, Maarten.Brock@sttls.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:26=E2=80=AFAM Hui Wang <hui.wang@canonical.com> =
wrote:

> Some boards connect a GPIO to the reset pin, and the reset pin needs
> to be setup correctly before accessing the chip.

set up

> Add a function to handle the chip reset. If the reset-gpios is defined
> in the DT, do hardware reset through this GPIO, othwerwise do software

otherwise

> reset as before.

...

> +               /* The minimum reset pulse width is 3 us. */
> +               usleep_range(5, 10);

Simply use fsleep() and it will take care of the sane API to be called.

> +               gpiod_set_value_cansleep(reset_gpio, 0); /* Deassert GPIO=
 */

--=20
With Best Regards,
Andy Shevchenko
