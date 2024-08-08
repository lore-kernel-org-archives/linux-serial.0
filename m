Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F29015A4B0
	for <linux-serial@vger.kernel.org>; Thu,  8 Aug 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154752; cv=none; b=a/RDPefOug7WPV/V9bWezePGifltTMaupmAPqfVEV5YYtWfi0mqHUOm1E9ZMQa5pjWM+/8Ammk3yKE2C7itEfwlsrnOZ7MrLkb3qGevendPINWB7mponkdN1dOXFdViEYKuYpPmZd+xvWuCK/1Zzy5PqyShANpfXm/oLOHIDKk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154752; c=relaxed/simple;
	bh=oaE42XbgpQLOA13s6d80CrBFI9eTqgGHDSnPFh71lvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZN2Dpjz2aHawqp5k/Qx8aHgQW9TwbROjkVppHHMgcROQ4uj56kieAUpWHQXttjArlLBxfZXcotNqtO1m+Hoq2yyFWOwlxcqjsQHFExqRyn1eW+mT1N0hiKQ5+R/wY+aN1bUU26UTEiTVEhSWF1SSIr9cHOTKlSnfs5vAAcSFYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1KRvjoG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1KRvjoG"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso165474466b.0
        for <linux-serial@vger.kernel.org>; Thu, 08 Aug 2024 15:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723154749; x=1723759549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaE42XbgpQLOA13s6d80CrBFI9eTqgGHDSnPFh71lvg=;
        b=S1KRvjoGCxvQsbSy7lvvmQNS+eEydfqN7Ht5OWPhu9cDp6jw47RbFSITycg8C0daEd
         XWppoNOvhinw21vXMuunUHGwqOoHhG13/zH+CafuG9CgD79XPGJ9KH9erpwdRIaaWJjZ
         2/ibRkVUpe22jKVMhU/3Bh9WZx1luf5u/sinJkcXAeR6DjO9IFkqQ2iIkIu/ppb3aAli
         vkvGFaOfu/xoLXyXg4nezijAgE6P6Uu0nEEcqyOVOjmvk//JmWgk/sSl6ekokBlM8HEg
         Xy9/UJ8h2BGjWmGFPjHpxeTL7guht3Hc3gugDSX2crMXiyOsHtSDx7klvy0lP++nA2zG
         btKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723154749; x=1723759549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaE42XbgpQLOA13s6d80CrBFI9eTqgGHDSnPFh71lvg=;
        b=RvANhyeQM4byD7K5yl4MloTpcZ2QN7ytmEb72B5V0IJxcDM7a4woaG+I+virTh8CE4
         foY4ROfkHKfacQ0BzySYHuq+SwFwTuuE5dvFPrOnlUnr1Frf0ZuDJUPcouAjPJ8JodaL
         e+U4CaGonwjNJW7xLmTv527Lvo/4IiCpaM8UschTdP7Pg2WeZDzeU7nO7gkMaqWD8dFD
         y2V9ISatirGuW1ebGag29c5AtYSYT5vy0wErzo0JQJBKzkMbzdbIlnsNggFoz1BpEW4h
         i9dJT6lX/ChRmz8McLBpV+WSlDY1PXqzx5be20o2h3yZDEZQD5GRfcd6T6wMfBqzr+Qg
         lp3w==
X-Gm-Message-State: AOJu0YxZr+V6c2g1mDCwNT9o4+0pl9/h1xM7/MSFpcBpmBm/1wm5ZvFU
	He4FFPgKSAE1iFrFLAFNDehnLHeRuxmtBnP0RANdM/8bK9oGfwZYYQ/Lt+9a0JZtGeDc0Ncd+77
	O3af5lxSHmSMtSP0dlqtD0g7Hx/E=
X-Google-Smtp-Source: AGHT+IE2g1p0CpLkd12TMG6xRH+GXsExKk+/b7gNynfYl/I2Xp7VxwSCx6pqNz/RtVucasbLx08KIIGK1apousWotQ4=
X-Received: by 2002:a17:906:c108:b0:a7d:2bf7:5619 with SMTP id
 a640c23a62f3a-a8090f01b2dmr230701666b.58.1723154748428; Thu, 08 Aug 2024
 15:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6bfb7abc-0264-440d-b0d6-6dd6a8b64b5e@camlingroup.com> <5973c217-9979-4107-85d1-be1ee342c950@camlingroup.com>
In-Reply-To: <5973c217-9979-4107-85d1-be1ee342c950@camlingroup.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Aug 2024 01:05:12 +0300
Message-ID: <CAHp75Vcm6kx6_-ZBA0nuFNCsg7pQ9Ka-2V1uyOeKBjkkMsVG9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: sc16is7xx: remove SC16IS7XX_MSR_DELTA_MASK
To: Lech Perczak <lech.perczak@camlingroup.com>
Cc: linux-serial@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:59=E2=80=AFPM Lech Perczak
<lech.perczak@camlingroup.com> wrote:
>
> This define isn't used anywhere anymore, let's delete it.

definition

...or...

#define

?

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Andy Shevchenko <andy@kernel.org>
>

The blank line is not supposed to be here, and instead I think you can
put the Cc list...

> Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
> ---

...here, i.e. after the cutter '---' line with a very similar effect
(the only difference is that it won't pollute the commit message).

--=20
With Best Regards,
Andy Shevchenko
