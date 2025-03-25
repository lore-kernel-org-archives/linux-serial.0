Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE2D27456;
	Tue, 25 Mar 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914525; cv=none; b=pU19+WjIW+BlVibI5afLvTLv6rfHxUvPbOySlqSTg3+Ft7Wy+mayLFo2QH2huLQtzs6pgpct4f5Hu1cowQT2Fwq1jX86ZJTz2gZ+qnQklqvye8Hgnf/6rV+CMCHbLLFK3Aq3IHYouGYea/Drwz4yUSey/3Mk5MLjhievnE+WT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914525; c=relaxed/simple;
	bh=h+xC3o+EvRaEsszN3O1Z6v/cvKxIPSpgJ1OU/4mg0CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXMzcjPjgrHa1CE/qfkXBJDNhkp+krVEXsy+uHrRSuC/I1hbruFupuOLKq+8ecTkdzGEW/pX2jWVGi4vz9Z0TZIjaW1gF2bAdxBCxltVDz19e/NstfY6VOtau/lovKdtZz+O7ak6wC4vEpiJjyunYwZLLKuJjd86GEsqqv61c14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka8xV2V+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka8xV2V+"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so9568622a12.2;
        Tue, 25 Mar 2025 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742914521; x=1743519321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+xC3o+EvRaEsszN3O1Z6v/cvKxIPSpgJ1OU/4mg0CY=;
        b=ka8xV2V+fRAYXwOxhbF4MX5dcsZSQGvYE9QOQ1xIrF6OcOMnWVUEmqC+jSovKyA2pf
         MNrGO/yzsEpxdCpjrVgseGFgVVEdbAYgwQmTLTAz9wNNsfqfs97Yvqy11VLsdqrOQnYB
         3e93IZeRji0UsBo0jBavBZ43WrflkCGOFoe0J7k7vuP2+nrz74g0Qd3fvI70yKK8y+Di
         DLgZeA9if/gvl6Vb6TSF4SzQOSM8aFRQXhIQxz8yrVGhjpKeqHFdQIAdCAD6I0i+DGlZ
         iNdFpttI19Hs73g+gdkFEhuSWQlXv4ifE8kNQBKzeanIv0SIyfDEj4kU/uwa7G/UnRpK
         aLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914521; x=1743519321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+xC3o+EvRaEsszN3O1Z6v/cvKxIPSpgJ1OU/4mg0CY=;
        b=LiNLw6o0jLri9WjThAbZZIb/KQvS2Xewy1ftvPhV9iaYJSoMZiGny7ki2CbECZLn1w
         2a+bMVhQaFULd/AStGDYKxt+e0h3rBYup/idRJ9hM72T9k1iXMgvLBCKKjm/H88s7Oq2
         iI5dvk+Q/7trx+UWZ1XgO37jrp37BFLkIzlW+i48l+bKw6ZL5l0T9l4DL/s1hM/LajlL
         kyzSU38f2SrU8kFGGXrCnDfw6uRVDlDTg6RohJm+WEKlF84tL+SKKf51rST2pWImGHnL
         n5uN+IZ7GAOQcxF6XYXJu08raZUzVMEnkKaUaA0VpAZ7r40g+i6Is4T6XTdpRRQrGFxI
         KuAg==
X-Forwarded-Encrypted: i=1; AJvYcCVlKrjuwlsnE28KdFLW+6N9zIiRHBVllYmyi1F2bqSE6AjpwwqGx8KuhUkk4Nis44s8g9hXpabY2Uag@vger.kernel.org, AJvYcCWWGLBv67HzrcXQJs2WV40dXSjXs0xRT2thWrI+3ZrKErZGYA/QyvlOHM/g/X9xNqhH0EsnY/3SUCVtmwP4@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHaZV+Mt5kEYSdONYE9UiXsbeMtjoR2LjV95CP+42K9SP/ZDe
	2jjAHeWmuQwXgywzNNAbWfP0QdweQoXu6QUpgIhs0jpfUAz1Hlh3xcy6PNHa3lN35Ov/Ga5FCoc
	CRpE8O9nhkftjA68DHkLhKzL+JInWV4K/OGw=
X-Gm-Gg: ASbGnctYu1o+EBKLV+87gOJJTG0Z3gQP8LCf+i7NKtYKU2vXnvXUpG+05DRfJ4Et1Ke
	eWCqPun/Lz3nxv5txp5uxLfZZHOkqlVaSzGOk4eqlnjbXxCl9IKMiU7zX3bH6ZliW32ceP6k4mI
	JxJFaTTe2eq7CSPbA9DK3AGBeG3qZD
X-Google-Smtp-Source: AGHT+IEuUQYN6PwvTvTwwnMGmt0P4vWLqhxNd+GIGHY0aZBd9Bo2XRNy5vfno9+jBysJbJXi8vwQWX5545PCjWwZqcQ=
X-Received: by 2002:a17:907:1b2a:b0:ac3:8987:5ca9 with SMTP id
 a640c23a62f3a-ac3f20dd210mr1724301566b.19.1742914520994; Tue, 25 Mar 2025
 07:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>
 <2025021019-overtake-elk-e644@gregkh> <28a3cbc9-53fb-44e3-bc87-d33cbc406c8e@genexis.eu>
 <Z98veiHLkQWlCdBE@surfacebook.localdomain> <75df16f4-3413-414b-b71c-ed64d4ad7b0c@genexis.eu>
In-Reply-To: <75df16f4-3413-414b-b71c-ed64d4ad7b0c@genexis.eu>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 25 Mar 2025 16:54:45 +0200
X-Gm-Features: AQ5f1JpO7ftZ7FaSzFYxTvPrw5WSB7kut519fhl2Fwab-IM9CNoHs2bShgnelIQ
Message-ID: <CAHp75VfPK9VjRFtM_-mMOwKOdO9Q7soPGhy3-TX5SA4emrPwbw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Airoha UART support
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, ansuelsmth@gmail.com, lorenzo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 4:45=E2=80=AFPM Benjamin Larsson
<benjamin.larsson@genexis.eu> wrote:
> On 2025-03-22 22:45, Andy Shevchenko wrote:
> > [You don't often get email from andy.shevchenko@gmail.com. Learn why th=
is is important at https://aka.ms/LearnAboutSenderIdentification ]
> > Fri, Mar 21, 2025 at 09:37:09PM +0100, Benjamin Larsson kirjoitti:
> >> On 10/02/2025 07:14, Greg KH wrote:
> >>> On Sun, Feb 09, 2025 at 10:02:39PM +0100, Benjamin Larsson wrote:

...

> >> I would argue that I follow the current flow of the code. In 8250.h we=
 have:
> >>
> >> CONFIG_SERIAL_8250_PNP
> >> CONFIG_SERIAL_8250_RSA
> > These are historically parts of the main driver, RSA code theoretically
> > can be removed.
> >
> >> CONFIG_SERIAL_8250_FINTEK
> > I would love to see this being not part of main driver.
> >
> >> none of those enables COMPILE_TEST or the option to compile as a modul=
e.
> > They all together may be compiled as a main driver module.
> > Again, this is all historical and new code would need a very good justi=
fication
> > why it can be held in a separate module.
>
> Hmm, ok I'll see if I understand you. I should create 8250_airoha.c by
> using 8250_fsl.c as a template. Adapt probe for Airoha by replacing
> .set_termios with a wrapper that calls the custom baud rate calculation
> code?

Not sure that _fsl is the best example (we have so far: 8250_exar,
8250_lpss, 8250_mid, ...), but overall yes, that's my expectation.

--=20
With Best Regards,
Andy Shevchenko
