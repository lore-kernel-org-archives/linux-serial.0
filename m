Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com [209.85.222.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782213CA487
	for <linux-serial@vger.kernel.org>; Mon,  8 Jun 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936853; cv=pass; b=k3Dt8AYw+mo48gwCr7GMv2FCBz9xNQAqF3xHMaXM4EXJLuN8I99kCoJKBKsM8SDJLGsRvFK4b6MY+bqgSEa48FXizPhKJ0AIgHqqQqE9ZDgr+P9xVvggLWGZJ2YKmEuqnmVEGyWNq3I26rlVdRLWlzpk2I2fHwUjE9RBvnt/uT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936853; c=relaxed/simple;
	bh=rx5DadAO67UpdbFbKqO4wfxzyxKs/HiVe57B5TgYgWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxbkbzgmHtdRC/j2pqcdYKeJuokkc/ZwO64Btua6G0js+UtQAlWUk53tCBhS6zD444tQuzXg9hhwPaUrXeY2DOiug3X0yo5XSisEQFJDOTGEtQTf7K2ojHggolcFTOR9iNIDjghe/C6+l2WnAJtt1LTrYpRtb/Y3R3XmJovh8BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbTyU0BS; arc=pass smtp.client-ip=209.85.222.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbTyU0BS"
Received: by mail-ua1-f68.google.com with SMTP id a1e0cc1a2514c-9640111c168so1548784241.2
        for <linux-serial@vger.kernel.org>; Mon, 08 Jun 2026 09:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780936851; cv=none;
        d=google.com; s=arc-20240605;
        b=VfL27VFCqGfNtFWhNEHdoPRdXqOuCtQx0gRjxgBoUoPYnmd+5wHqz8v9IG9C248urt
         erzy0PZ7z6/7BSt1hkHpNnDgn0q8ieHRJkehKwXVUiOo/gh4u7BifowJJFjj+nEk87gn
         DoRmnb6VdN9CUnmUcd6Q7aUPhoq0fi6NgV5ou2k8eEfD6c4hgPQn17oZO4z7LHdl7xsN
         HUbJeqwYUyCxfgs7+UvrnxdcsrQn0wSGqBmfrWEtxM3icOsR96r+vi8nNMaT6SG540Vk
         sMwmiup5e4vAv7tZ8nWzDDCwE6Sl47ES4+TMRc9s8hx0j86MBYNUn6/XiYLhRWM8PhTV
         y4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rx5DadAO67UpdbFbKqO4wfxzyxKs/HiVe57B5TgYgWY=;
        fh=m0xDAUJ8vwyC4QdHSgeprThCUNPwpD+gbyCiDrNkLYM=;
        b=UuBzBAXbX6abY4/nXi6p1NlcttyTN2tFvSi89p4iTE2m9jymKQmVEuTfaAQaD+4rNC
         i4imNCRQz7LAMlwDYT4NMguQ7aeaIsOcNMq519NqZO0BzjkcFk9KCPhI5GjpfHFgX85C
         iMaTQNebRwQkxuSv5+A6uUxBfPKATHx83O1gVkRjKHklcjX+py+0Hgw2FeZE4Ti0XzF2
         enIba1hdHVuZGxVycSF+i/j6kWyzucMsm6IuXcZvWmUZGQvALpYfqQXMcgwKMHnImpxZ
         wz/hnIJoLZtJCPlrC+vN8z929yxuyuCVcOHzALLrMpobalVlzrrAOd9o+cHMKY0dpiBs
         elkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780936851; x=1781541651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx5DadAO67UpdbFbKqO4wfxzyxKs/HiVe57B5TgYgWY=;
        b=RbTyU0BShHTU+KT9tAqrgsehEw9vlCIxxcgWC5lkKPNJ2WNaq14odqI2b7owWKiPOR
         +/JMAOf+1OtcPmdXlaz278QwJpw99E5rOpMcOTLvZSGM/s8+Fm1KDrKX0obxFCG2KQnP
         VXtQgvCTzwF9RcgmH1fgpieZAXRpCpKVlS9jZldxkeI97A9NN5Hral6c01CHexdxiLgo
         s0puiRH4V4pzolW76cAgmV1CwWZUicqS5PUn9SdolFLV3CqOT6fJBw8DehGBWwOspmRf
         2UKOfl+Y7oQAwjPR2UaDpy4+9NS2+eaVL6u1prVogVlqiBUnZZ29B1eZLuExxobztndC
         miew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780936851; x=1781541651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rx5DadAO67UpdbFbKqO4wfxzyxKs/HiVe57B5TgYgWY=;
        b=TG8w9nQQidV8DUL//dZnRCNMsHjU81pO0c+h14symsx6TjIS5c6jgxdsTReR+vmx0c
         USLcCK+ovhOUA1nXwEcS0phipXQYBoXrBObj9hmt5+/eDfPgwZ/jXnxIqSK3EMfVo1pC
         bPOJR6MGOCNSeM23yoysqNdoA913QlOZ+A4BUItJ729DlVIFea2709APADGPqhuWZ27z
         hhAD4rk6oBOJe22Wts6U0k/a7fZDhjspdZiwtogk84TXKWIascf6KvzRFUr8I34EmRVB
         oMUESbVtiqOqIGsb5OezmX4VC+8uSixxRTec9fMkpQDFgD/ATyyw4UjncP+RL0u5H/la
         AJZw==
X-Forwarded-Encrypted: i=1; AFNElJ8jHnVIiAEIdA6uB5oA+zBUJKbPrW8ZHaE67vzvWcuMDF/8CprSbUTOpul+VTwu3aAh6eqeRZY8R64EnrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHiDrPmZphBUwYOputdVT1sFi+tKDQmighCbS7O0hC4mEQjr23
	28UjCtAOOlgJ0fue0Ivu5dabmgvxuPGCBw2sKA2D/kUx4dYm7p+G7lI6REwdeGd/ZJ0yoWpuLV1
	3QtZz7BCmdQG6lY10VEWPRXPeKCFqsNA=
X-Gm-Gg: Acq92OGLT7mGRTAxB4QX+CSHF58CZ/ZSi51YmIkvN1TvYitkntcLvsY2/2cBMc8NYcK
	kXXUrdgUmCMBS2hB3xE3AhCcObHlmIS+UmiWj+piP4HNr+F4f9wp2j25J2qE34qhnG/2KWa28Pm
	wV+vvwUOixxldRM+gQhggIjuNzYrCQrC8bgDPogZGE3LFL9ctQSlFFPm9i98XaS42HwU066fjV5
	u5yd3vgK0lkRepoH0iap1RKhceN0H3z9/RfOe86WSteWu2/fMlh7iR7VrmNvRzsO/fdgYRJ62kf
	ettVBgak6+5g9/AEtO9QYcrVl+mWKYWYrvza7a5RrCKsEPGgcRl45Xsvgcdl+jj7F3u90JuDEOe
	cUb8=
X-Received: by 2002:a05:6102:5490:b0:607:4fde:1921 with SMTP id
 ada2fe7eead31-6fefddf2777mr7527961137.24.1780936851466; Mon, 08 Jun 2026
 09:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510052107.555825-1-enelsonmoore@gmail.com> <CAD++jLmUW4KjxEjwv7_an_dEMTSOtvG=q2MjhqKvnuGrWaaCsQ@mail.gmail.com>
In-Reply-To: <CAD++jLmUW4KjxEjwv7_an_dEMTSOtvG=q2MjhqKvnuGrWaaCsQ@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 8 Jun 2026 09:40:39 -0700
X-Gm-Features: AVVi8CckAHRTjPznUi9TSdmF40ARXCb9sYaYjHsEIjd_pzo-q6SLDDWWJhkDXvc
Message-ID: <CADkSEUirvwVzdmGh0bS++cy8coOiMyuHNYQrC599eyVmWMh_Hw@mail.gmail.com>
Subject: Re: [PATCH] ARM: footbridge: convert to sparse IRQs
To: Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, 
	linux-serial@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Linus,

On Mon, Jun 8, 2026 at 1:50=E2=80=AFAM Linus Walleij <linusw@kernel.org> wr=
ote:
> Have you tested this on real hardware?
> The commit doesn't really say.

No, I haven't. I can try to test it in GXemul, but I'm not sure if it
can boot Linux. The developer only lists it as capable of booting
NetBSD.

Ethan
