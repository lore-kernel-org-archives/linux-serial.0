Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036B11D1F51
	for <linux-serial@vger.kernel.org>; Fri,  6 Sep 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634608; cv=none; b=hC1vc8NdB70B82Nj54cjhZbCiTPZ9EJtejGu/79sVkNuewRLRQozB7+0drBOlAz9tahTFPrinFFJ1+ueCWfjTMMJTmmmsNn2M3yq8VqJ05QhF7aXxzc1TcYRsdL/PDeIDenapLhsjjBNUCjfb0IMYa7xRy849ITwRhwsdPpBLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634608; c=relaxed/simple;
	bh=Z4WKeJmpOYFiYE7cCHqfI5S+mHBFpdvOr74BGZhwPJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUtaGmj+3Ljx+Q8s8Tbalxb9U07hWH+MA7annXGZT+G2YxJXpaNX8doJT4CgvVlYIL5ZYo92NzusHvdrvzpyEhf5GLx4xFXvHZqHciaBNVXevrEnKYHHk78KXv5muPMcfYqHlD+KI9FyESgcDN1PPHuvoCcEVTPO2jRPSKFd/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fX/BeLPk; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fX/BeLPk"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-500fbacd680so653560e0c.3
        for <linux-serial@vger.kernel.org>; Fri, 06 Sep 2024 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725634605; x=1726239405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8DQFAISHS7i5IP3gsOeV2GhBMoOIKb1H2ynRnefFiA=;
        b=fX/BeLPklJ3TmlNwwRWISchAp7HRYNqY6dXUsSIIJldZZf6s0kvTvLgXg51cmPH4b2
         N8ELqNwCwjPnNIg3sQo8R3L/eHcoEalymtblwAcqP/BWKcXfuKg+ej1UI+ZlMkGB1Wdo
         ojWpR3JLBI1Av98+L2SF3RDpiqUWIvLcjrZ7ZqEnd8Bj38uVzc1NdzjbCYa+Zr2fGHu7
         mH2XXNknaDOsliy1ZBduX4EyGVqEwiUGXky1rgaxuh0bgfXD1jExECbOjtD79qY1wW7G
         fpqvnTCQ1BeJ0VMrQW8TqZDjihtCeZQDPIejcYwhGWkGSzijfEQVYbke9a9X9B84U8Mt
         ZHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634605; x=1726239405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8DQFAISHS7i5IP3gsOeV2GhBMoOIKb1H2ynRnefFiA=;
        b=K0q/bNLTRH+jBw9dm/g/cE8y/CfqpXL/Pg2QmiLZrCDQuCm8pO0quHj0ZoA8gLYmXR
         PTW/I/Wq5jNUNkbzsSFLWV11BB9KyIdu1zd8Gc+QEtwL3lflPEMaXgvGGwxHkButYzag
         li9U9txW6j1tHgGBBc66k886nhM8EwN9U5rNlQ133yitu7qhDWlXdo8lCusE/VO9i0To
         qUmGo2GmMrQwKI+owAmnFcZ2YictsZzP3A8X8nKuV1IFO/GxDL/NIXFD+GdJJBkKSxtg
         GyUxYsZH19HqM33Jbt/f8qmoUnh9+eVa9NCp/+JZT59bMmi9B2rMu/MJ2aDvNoz1dFBi
         lQlA==
X-Forwarded-Encrypted: i=1; AJvYcCWUSz91vDsxkzQADq1GQcl1TjcMSZ49pbzhpo/yWv3+Gd4UWFulUpRYHRrwx15lsvOj4IKf5hppO6Syp60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/W8aKLjlBW4nNH8w+r3VaMRMK5BI6okgAF7HeEFKT51euEEGx
	e4ecAbbKXYzFaVvJSS2vBWcxnS10CWvEhXMIL2FUCXTnM8u6cbesAf6jVH1pRm9lGMQ/E1eSQ2D
	7tLv6MPpyQesosaPx4BvBGQqePqoBW7iwPbEQ
X-Google-Smtp-Source: AGHT+IHq7ZiORKnHJ7OGW0/x1cWaLstSbHVVP69Jhc2KtxHBDUWP5W0/AltVyanWWqQY/QWC4tnW0snbDbe3WIJv/jg=
X-Received: by 2002:a05:6122:3b17:b0:501:2842:428a with SMTP id
 71dfb90a1353d-50128425272mr4021883e0c.8.1725634604866; Fri, 06 Sep 2024
 07:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-macos-build-support-v2-0-06beff418848@samsung.com> <20240906-macos-build-support-v2-6-06beff418848@samsung.com>
In-Reply-To: <20240906-macos-build-support-v2-6-06beff418848@samsung.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 10:56:33 -0400
Message-ID: <CAHC9VhRpHgqN2fp1J3x9=zBqNr3QHsSDgUnoZ7M-SuOQ6hQ4nw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] selinux: do not include <linux/*.h> headers from
 host programs
To: da.gomez@samsung.com
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	William Hubbs <w.d.hubbs@gmail.com>, Chris Brannon <chris@the-brannons.com>, 
	Kirk Reiser <kirk@reisers.ca>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	speakup@linux-speakup.org, selinux@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-serial@vger.kernel.org, llvm@lists.linux.dev, 
	Finn Behrens <me@kloenk.dev>, "Daniel Gomez (Samsung)" <d+samsung@kruces.com>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:01=E2=80=AFAM Daniel Gomez via B4 Relay
<devnull+da.gomez.samsung.com@kernel.org> wrote:
>
> From: Masahiro Yamada <masahiroy@kernel.org>
>
> Commit bfc5e3a6af39 ("selinux: use the kernel headers when building
> scripts/selinux") is not the right thing to do.
>
> It is clear from the warning in include/uapi/linux/types.h:
>
>   #ifndef __EXPORTED_HEADERS__
>   #warning "Attempt to use kernel headers from user space, see https://ke=
rnelnewbies.org/KernelHeaders"
>   #endif /* __EXPORTED_HEADERS__ */
>
> If you are inclined to define __EXPORTED_HEADERS__, you are likely doing
> wrong.
>
> Adding the comment:
>
>   /* NOTE: we really do want to use the kernel headers here */
>
> does not justify the hack in any way.
>
> Currently, <linux/*.h> headers are included for the following purposes:
>
>  - <linux/capability.h> is included to check CAP_LAST_CAP
>  - <linux/socket.h> in included to check PF_MAX
>
> We can skip these checks when building host programs, as they will
> be eventually tested when building the kernel space.
>
> I got rid of <linux/stddef.h> from initial_sid_to_string.h because
> it is likely that NULL is already defined. If you insist on making
> it self-contained, you can add the following:
>
>   #ifdef __KERNEL__
>   #include <linux/stddef.h>
>   #else
>   #include <stddef.h>
>   #endif
>
> scripts/selinux/mdp/mdp.c still includes <linux/kconfig.h>, which is
> also discouraged and should be fixed by a follow-up refactoring.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  scripts/selinux/genheaders/Makefile              |  4 +---
>  scripts/selinux/genheaders/genheaders.c          |  3 ---
>  scripts/selinux/mdp/Makefile                     |  2 +-
>  scripts/selinux/mdp/mdp.c                        |  4 ----
>  security/selinux/include/classmap.h              | 19 ++++++++++++------=
-
>  security/selinux/include/initial_sid_to_string.h |  2 --
>  6 files changed, 14 insertions(+), 20 deletions(-)

Similar to patch 7/8, please read my comments on your previous posting
of this patch, it doesn't appear that you've made any of the changes I
asked for in your previous posting.

https://lore.kernel.org/selinux/317c7d20ab8a72975571cb554589522b@paul-moore=
.com

--=20
paul-moore.com
