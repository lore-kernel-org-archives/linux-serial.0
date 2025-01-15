Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB91156872;
	Wed, 15 Jan 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953762; cv=none; b=XopDWtTZyUJMqcz59/ivRFTVLctxVFRStNmWlZYrBbIoleY+qJ0ElLEGRwAlvMn/shS/tqDJA1aUy5Po3M29XgTwLKLtLxFqI57OYl2MKSvBDeTuzVg6+FR8CE+8f6o5qFJKGuR90B3PEPPDUi5FvZIIOYGGC3MTsEo0z2wKc28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953762; c=relaxed/simple;
	bh=9rZ4pxhEV6U39XA0V6eXP/hZQ/fFefihJFDYK9VajvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvVDu4R1u8uOkKyhwM4IF3th0GlT2ZEmC8ruKek5w5LCkeAeoktBQQD9hPxtyI+piBLHYvuKnB990BFlVw4hxFqj/XtnjdMatuMdIKCOISZAVug/wxXtDcn2gRq3ZnoRQOczKvXUu6jqJY/NfVL9EeVtwGHqoisQs6+FLX7m+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyGqtP6M; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyGqtP6M"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so1213850366b.2;
        Wed, 15 Jan 2025 07:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736953758; x=1737558558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzYu3qJ8QgTzfQt709xDN3GWHbP81C9WCUW/N0FwAvY=;
        b=MyGqtP6MAIjIjx+QZ0+SvDJgo4tvpv0Lf4WlbbeheU2NYp6ZJCGbw9tH54QHGQFlrl
         O3PRi0TA7vmQZWRjNlI424jhBq7QzHYmgneR6XbxOrc639fmbkogWMMpXq9p/nr8kSDu
         dZFSPHVklTgXjAUwfR9CtUKUi2Q9y2hQihPweD6eZVUCPdMhq4GC+TefZnRdVpSFo6pq
         Yu2WC2vSyVi4j/dFJyruXdouwesew/xpu2+V3daTHSqDdyBZDfKw4uyd13hpy0FLh7Hn
         9acwCMVqiNshZ92r8TdMWSfxyXWUKzNCzMbFk1ejXZmT/Ob8edI7MoCJULXMKFHuiygJ
         X7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736953758; x=1737558558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzYu3qJ8QgTzfQt709xDN3GWHbP81C9WCUW/N0FwAvY=;
        b=ifD46bJ1ovYB0kfhCS/1CP+wU/+SxNUHtaoAZQt3CebnpzorMIobFItZXVCTRVceNq
         wdaO1F4MV7S3SevbFLyhLK86tsjPeQYxpdvRfv+uEhzV2yRWfuKVAagcgZ95R+dwbvwp
         +4uNOdhBi02rh1Sy1kFOITlEmgeK6Gjjxm+kB9HKKMAMcvPWjJ67Y0Y5drCZTAV1XAQd
         ILz5EOyvMDXQv59PUYKI6hEs+KB0MmLalpt6+iQYTLAUISSkgKH6cqDPEgjkVarkUySX
         +sxuYn+VuRYla/lhe8jFWc5Qf4UO8HVekVlwDT8IRvNNYlu3vwAQi6Cp/9RVssX6NNHn
         3TWg==
X-Forwarded-Encrypted: i=1; AJvYcCUkFzKaF+M/aCDE9t+t16u+E3smWCSsjEYc3+Xg2sOozV+vxT5spNU3G/vDJLciIUEFYZT3FZth5rq2@vger.kernel.org, AJvYcCVBquOpeLfMukG5+5amx0101SI3qZPPB3/6NPAvdHHDC4mbn05Uxq+tvMGHVJzl5tZWrFk6V0qOtUvr0RLF@vger.kernel.org, AJvYcCVKnoELcXUNW6mhvca/5r7UfODrASM+FOFWloYggmQcDIFqMoXmP6XdrvTHL+PvtySG0sbzELFNfLfrdkc6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35N4UThwrYZWSsidKTHPcM1sMUPjfm2sFutEL//qKZP2a/nYg
	AarYKG1x+bphrUrad2JoyNeLWt+ouvzFzlqfXzbLOTBwCHnl1srZbnvA7iDdAl25V5EBzGQTnXW
	EQhTUq0ju2EwOX1cZJ3ZrDc/w39Y=
X-Gm-Gg: ASbGncsBuAJaHT5bJY7B6ISGWStJJLNYaLZYyNpjWqbmAgO7c0gPpIbFCGnmF3MJDxd
	I2uHxgfw5W7QcYIIW+Ir63ve7Wn49GovECTejcQNr
X-Google-Smtp-Source: AGHT+IGVv0kRG4CV80SchQtOvpA6+JA9Z5WM6SCZ833us1IVEIwXNWIt3iZ7cuA3okit6yxwZMyU6RI0v6ILvR3aPtg=
X-Received: by 2002:a17:907:97d6:b0:aa6:6c6b:15fd with SMTP id
 a640c23a62f3a-ab2ab6b52b8mr2731889666b.20.1736953757754; Wed, 15 Jan 2025
 07:09:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114070449.34226-1-andre.werner@systec-electronic.com>
 <20250114070449.34226-2-andre.werner@systec-electronic.com>
 <Z4Z7JUP2vMEX9JsW@smile.fi.intel.com> <bc6aafdc-4b86-956b-afa0-ecf5b3ef393c@systec-electronic.com>
In-Reply-To: <bc6aafdc-4b86-956b-afa0-ecf5b3ef393c@systec-electronic.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 15 Jan 2025 17:08:41 +0200
X-Gm-Features: AbW1kvZFg7gXIxSLY3gVv93jG0XlZjmggBL3SuFU-6b6wqB2q3WoY8deujsiRyc
Message-ID: <CAHp75Vc==m3mE1TtxjHnpwL-d8W4rFnKreu7XB7MWspJKCCOGA@mail.gmail.com>
Subject: Re: [External Email] Re: [PATCH v7 2/2] serial: sc16is7xx: Add
 polling mode if no IRQ pin is available
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: Andy Shevchenko <andy@kernel.org>, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	hvilleneuve@dimonoff.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	lech.perczak@camlingroup.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 7:23=E2=80=AFAM Andre Werner
<andre.werner@systec-electronic.com> wrote:
> On Tue, 14 Jan 2025, Andy Shevchenko wrote:
> > On Tue, Jan 14, 2025 at 08:04:49AM +0100, Andre Werner wrote:

...

> > > V6:
> > > - Use polling mode for IRQ numbers <=3D 0 which encounter no valid IR=
Q
> > >   were found/defined.
> > > V7:
> > > - Try to improve and unify comments as requested.
> > > - Fix typo in commit message: pull -> poll
> >
> > Please, rebase your series on top of the recent Linux Next.
>
> I performed the rebase and get a single new commit to fix the merge
> conflicts. How do you expect the submission? Is it a new commit or
> should I mark it as a fixup? Shall it have new version number v8 or
> is it a full new commit series?

When you rebase you should not get _merge_ conflicts.
What is expected is that the first (DT binding) commit will be gone
from your local branch, followed by the shrunken / conflicting second
one.

--=20
With Best Regards,
Andy Shevchenko
