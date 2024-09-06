Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6801D1F4E
	for <linux-serial@vger.kernel.org>; Fri,  6 Sep 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634471; cv=none; b=qklcFOkzEJJC8fNY+a6pzgift7iNMHCH8D5TrwrODIR8hTQE0iZ/JdFR+3sCU+gXZvOroRdJ0/ZGEZWrrSlW6AiWfibOTtn2jx2fy39BfqLbx1Yt1MTzzUt3o0YPmWe1WSPBwdrzoyrZZ+7jtou7IjmEm88y/NcDpWScPGTiNSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634471; c=relaxed/simple;
	bh=ClKhqxGbstKanb0/jRi/QInpRewdF+k/fJjdYaHj2XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQ6IAC+WBVdKWGI8aTqplNmawfKxCkFs2ESlnGX5azmcT3OdSHpJcumXoq4aGdhPexlw3TVF23IS0db9peS6SLFAoxKwcEzIkjQstxLG5oi82UAoU0Y7VdDWxa0xE6DurKmK/6OJehwo9ui5XABxMLpmKWaVogTq/6Hi4iUT6wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fyTRKZDd; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fyTRKZDd"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-846c5c2a8e9so508969241.1
        for <linux-serial@vger.kernel.org>; Fri, 06 Sep 2024 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725634468; x=1726239268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsXB+HsGxSbnX/oa3Y2+uGuA8knOAtnaTuSxqQBTqAQ=;
        b=fyTRKZDdogcCghBgrr3L2QcVm2pjXXgMB/bFbo5J+e75W8IXYV4QQYssaNn78zCVe2
         wk5YDbQMQBfTgCHGDr9bVtJMobBYAyVrw0yOOzD7TzeVcylOspfYGxnYZPudGxraDKkG
         MWvorXgrGeY+OFGVsfHeyvNGQQyCwoKvL07m5SgJDlSG1z12bU/77Qq4Idyj1n0H/kj4
         hacGZ4R2R6PvnqGRDiJCq2/ozRFXeZoSD/SR3In+6deyYpln/B6YPqwF9fBG/84AOsDI
         aHwC5Voca+x6s/0pI5Q1y9DiJuvRH3X/cI78g7gGdnWOIkuyRy3rbXuUNlrtrL4qq6ga
         VV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634468; x=1726239268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsXB+HsGxSbnX/oa3Y2+uGuA8knOAtnaTuSxqQBTqAQ=;
        b=lUp4ISP/08GTqqYBznea1ZTO7s/HRO7rt+5WrjVVpNEqIjKzLR4ShX7oftUOwraAhS
         iFzJaTM2by7HOkFGPG69n5zgVYNvAhaYe1rqcy+GW7Eu4dGsXpgLT2OeYQIFNvPywlGg
         kzx3QD6wTOuXDogangDWF5r+UprQSzDRiFPBQYoCQq5jb0f4hP2WsE05O8xAYSUxVlCy
         avmVIXQqLBzNYvNkIk3WFGlF/u5HGkAEwGcr4cNL2mEkf+1DskjlxvRlMXrRPJGFxLfk
         Zdf/nrRtPjIbTsAbrzYiRIe7Vu/AbbiYijimrxwb3XRrYvTe9/huFByzjdyCcHdYBIEc
         RzLw==
X-Forwarded-Encrypted: i=1; AJvYcCW62pPQSwU26UEvzsJCMI5iuWeAvKFhcvYurafPLBVnlDvd3vHMnWFjLYUSqQTYhgwcJJ9j5CHcf9+sMtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY4xTxbtkONBSuG7Deg7/aF+YGdASeQ+POJSIGB84cqO7+uhq0
	m2ZWtI5DluYOuN1mibZRX8DoDlZ2g39sEobZ0juh1UV+Jelget+V3IwuPn7BahSiYFZbwoRZwLl
	4AZKJKtvyRTqUUSPX2XrodTBzcGjSlDlngSpi
X-Google-Smtp-Source: AGHT+IE2ETqS8j5INGhOJuEC0LfB5JoY7mno+WUbnlfQDVox+nEHO2zDE8qlvEGgTlm1b5qEJlJi4b2dA1AvozrG+1Y=
X-Received: by 2002:a05:6122:318d:b0:4f6:c44b:2504 with SMTP id
 71dfb90a1353d-502143c9c06mr2840417e0c.10.1725634467954; Fri, 06 Sep 2024
 07:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-macos-build-support-v2-0-06beff418848@samsung.com> <20240906-macos-build-support-v2-7-06beff418848@samsung.com>
In-Reply-To: <20240906-macos-build-support-v2-7-06beff418848@samsung.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 10:54:16 -0400
Message-ID: <CAHC9VhQkstJ8Ox-T+FLU34s9U0gezRba6bMA-tUPs80u6sVh2g@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] selinux: move genheaders to security/selinux/
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
> This tool is only used in security/selinux/Makefile.
>
> There is no reason to keep it under scripts/.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  scripts/remove-stale-files                                    | 3 +++
>  scripts/selinux/Makefile                                      | 2 +-
>  scripts/selinux/genheaders/.gitignore                         | 2 --
>  scripts/selinux/genheaders/Makefile                           | 3 ---
>  security/selinux/.gitignore                                   | 1 +
>  security/selinux/Makefile                                     | 7 +++++-=
-
>  {scripts/selinux/genheaders =3D> security/selinux}/genheaders.c | 0
>  7 files changed, 10 insertions(+), 8 deletions(-)

Did you read my comments on your previous posting of this patch?  Here
is a lore link in case you missed it or it was swallowed by your
inbox:

https://lore.kernel.org/selinux/3447459d08dd7ebb58972129cddf1c44@paul-moore=
.com

Unless there is an serious need for this relocation, and I don't see
one explicitly documented either in this patchset or the previous, I
don't want to see this patch go upstream.

--=20
paul-moore.com
