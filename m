Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6BA86341
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556987; cv=none; b=rKhGQeMtoj2wjYjq6ZDmZ2ieIzrnzTp19H7Zb4g6b2R9Gfc8K7crW46K+2mlLB6f/BK/9+nRM32xVyvhmzoyWlpbyFnWRaKMmAN9VAkhB38pH+ldEte9KBbd66Zkf1r/RO5OhQhEbZ9bdDf6DYm70mCaXpcTbI/gv/RUpQhthOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556987; c=relaxed/simple;
	bh=CT2reeFrlFMTdYgOdnagtJDlJcNm2+OIA4d3jzB366Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyytdF7mwmjSN+e2/Rq0cyGvuLT9rB1VttqpPO7Inx9grzmloSeIJ+NHslontnvzPhMlXjV4dZyLWFksAl+QS43rbhMlrHuCiJto30XZq7EKv9FEPw5HzxS550tuHeTlJMZs4jLnrU2HTkZ5yDoPKdqs84bQrz30DqkS2EDNpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4HwTaja; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4HwTaja"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b72bf7e703fso651951266b.2
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 18:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764556984; x=1765161784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNoV4nEZoQ9O9VsnXlpEgvaW8mp4uEJFmSs3349KpLo=;
        b=G4HwTajadEjXis0TSMPV+36fjcCKXtvp161kYJFYlR1MEd37fRHxV5HN868bpzupq3
         2gUCD3U2hYImmbYyMKJyWRKlpjIgr2Xg9deONeq/SyU73XICKqc7/ElSN7+L+Cn9QJrd
         YBXmE/J6WvVWf+jA97RM1kjlP6J579rvEypFkV8cKg6fMdHTUZdIFshmGiVs4GLU4/jF
         wnVTc364+WlnpUxtYRdjoIQdCMc5IHBAvBBybsgqrQY4sErgc5SJGxnZFufqXvn2xmMq
         VlebpjRB59YqvKAJy5CdAgJoFhKuisZzvFYwjh07KEp30BLoB8X8EIJ/812shdNSl0ct
         qJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764556984; x=1765161784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNoV4nEZoQ9O9VsnXlpEgvaW8mp4uEJFmSs3349KpLo=;
        b=T3nOhYDeRDwYle42M00kGXcTIFwfixd2IIaH+AVOa1SLK4eXelJe0Qdd46LOVU/fr8
         WbWrYjMGHptiE38IpJEXSolSVIxcxOGWbhCTTuzJKFvlASxKlfY/D93/uOOAdoG/KMzj
         7z8SvL+Zji5MP04h8x9O+GbO6HASiMQ59kT0M2ckFRTQPHX6VyZsOrCoAQZ6dp1EsLov
         Ct7jtV4gnGO9Lsgj+OK83W4FZZHl3v9H60K7djhmwzoUtBQNKXyXrRInu8HyMs6IGAv1
         vkorBn5/0H/8L97zRct2rysH7lKVvN4l5PH0PP/tsZy3famsyrWDqjSdMFS6Gc+c1nWC
         tlug==
X-Forwarded-Encrypted: i=1; AJvYcCW/he404LAr7oJxtnM+1RFJGAvPsyLe/YbE2KAiHI3w5Vs09l9RvlytwxL8i8G+TmjlKYfl+PupUUaHNek=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuc5xzu5AdMBqIne283TiHUjWcbQAyFVLzAejyJHsB8KnMZ/Ek
	JF+4tfEeY4jtvnHKJ66pPjUagtAAgaUvRtT7O9FGuMjaGbuMaceJc+xYsXR+Ls2yHbtfej+3WW5
	XdvVaPAyTGpekAHacgMw5lTIiIx0QPoA=
X-Gm-Gg: ASbGncuzej1aXszQCk8y9f8s7yTQSdG8nHCJbX2NGuO+Z9Y+ye6ac1Hlnv42HDFbjRi
	0bUgy5/gBpaqs5ZT6NEe33q+gaxoBid4XAd2Y+JV3P2kc80w0f+eGq8G3QcFwG2wf3LUx0Mx/Iy
	0Tc3vKLTs4P9pKeUkYqnmMJF1q72F0L6QUkIbHpOatozmGuHm9sJ9WemtErv6nx2cWG4AAXV2dp
	YeIGDvyltT/uJvCtXBEioPRqvLNXqRc5zV7suRAqUbhz8i+Zjx3N76DFBWU7gthBmEE43I3nEBm
	YRMgFsYZ14Bb7JrtMuNqpuzoM8yr8a3ybvb7chTpVwg2/TPEfHaARW2qS6Z8oLBjJpa3SRY=
X-Google-Smtp-Source: AGHT+IEKL09UnxId5Fkl8A+WkCPcw08OOxhtGVqq+EfeDkSt7rLIwB+TMEhZJumknNrZuXk1FuJrQ1vjRiIW39oaHUA=
X-Received: by 2002:a17:906:c115:b0:b72:aa52:6034 with SMTP id
 a640c23a62f3a-b76716f630fmr3841623966b.21.1764556984243; Sun, 30 Nov 2025
 18:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-31-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-31-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 04:42:28 +0200
X-Gm-Features: AWmQ_bkIwSHYzDobGzoIPxqXmGxzVCsEg0FVGCR0-UciIczCZK-N9izBG46V32U
Message-ID: <CAHp75VceYXN5jXrHjRujH9mXfxhccxVONyzkAHWJCDXHGi8iKw@mail.gmail.com>
Subject: Re: [PATCH v1 30/31] serial: 8250_mxpcie: Add sysfs to control pull
 state via CPLD
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:46=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Some Moxa PCIe boards provide a CPLD-controlled pull/bias state.
> Expose a per-port sysfs attribute to read and set the pull state from
> userspace.
>
> This patch:
> - Defines MOXA_CPLD_PULL_STATE_FLAG and {ENABLE,DISABLE} values.
> - Implements mxpcie8250_cpld_{set,get}_pull_state() with board_lock
>   to serialize CPLD access.
> - Exports "mxpcie8250_pull_state" in the driver's attr group.
> - Restricts support to CPLD-based models (CP118E-A-I, CP138E-A,
>   CP134EL-A, CP116E-A-A, CP116E-A-B); return -ENODEV on others.
>
> Example:
>   # Enable pull state on ttyS*
>   echo 1 > /sys/class/tty/ttyS*/mxpcie8250_pull_state
>
>   # Query pull state
>   cat /sys/class/tty/ttyS*/mxpcie8250_pull_state
>   enabled

Okay, this all reminds me of the pin control subsystem. It has already
established an interface to do things, why do we need this custom one
here?

--=20
With Best Regards,
Andy Shevchenko
