Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017611C9B76
	for <linux-serial@vger.kernel.org>; Tue,  1 Oct 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795695; cv=none; b=qfi1pdZbtZK+VmxnSMG94IdYVAVPK+zjawD+Pw9U4lhyLQ5bNegp7EDmWgjzMtrq6sUnxFT6gwfh1PnFLQHeZQb6PYnu12ZoVvJrtycLfVJAwPJWv1Bp+0GGPb2fDoQ6fuUjXE31vysOh95dclbkGSslryNlViGI/Iibx0zf/nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795695; c=relaxed/simple;
	bh=K7etQLbsdRPA9ww2bgOCB4P1qo2jzjsVUWz7e6BZbX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJYGA1JdmXXP11md39/skehXgvtv4KxERZ60wl51hyWPqCvvdbCxXYGxYEvJkatt6auQsXNI/nSz6INgx39/dD/8s8zCGh+nrwwMM8OUgTU+NeWMlbNo+df13VH1wDKaWFVWVtY36UA6hi+eVo2A4ctuWwBMkanbHBPnfGjRhPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S1OfRk18; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S1OfRk18"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e163e2a9fdso162318b6e.2
        for <linux-serial@vger.kernel.org>; Tue, 01 Oct 2024 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727795692; x=1728400492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXk/gs0HYEU1ezw3ww3vXkMichEEjYvt1gYwWCgyPCc=;
        b=S1OfRk18+pPseAcyuu5l5U+E4eYU2t0YnJNd7ELnZ3qK2ssbxJWKaBSsD1pHm8r67o
         u94evu8R2xSNeejesh8ONH1mIJcz58laE0SVvyD/nKbB10OlflkLHxxKfh9M205+ik9H
         ftYzfvdbWsejWpQQ52DxCxG7yKeR9KRtf1arw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795692; x=1728400492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXk/gs0HYEU1ezw3ww3vXkMichEEjYvt1gYwWCgyPCc=;
        b=dnBRtcTiO1yvLKM2OFvBFNrACumbLuJT7x8QGAe+WklrekacXDUa/9cjSEK6jicqUt
         fvC3H+smb8/zbXRBl3SMe/2Q7hrae9KK3rPDm5swnuK+1gty+AkxWFd5uMA7Y6EvQwMo
         aIx2ZbJ5rDoIlDcr3FbcC4iQIdF6UEO2mHTi/RRhsGOwfwldyCsgvbuOoc69Wnu5N6Wl
         FIpTap/EXnhaEJWV3/GhnAQ4mfN60ouPyyi59JhJ+MSFoSwFQkFFY6WIKETtxJUiaCqM
         /ngNGdcUusC8vtC6sXZljiw/P8s3ng8IXQr1HNISmQWVYBr4yE287E/dRMIuRldn/mgm
         Z42w==
X-Forwarded-Encrypted: i=1; AJvYcCV85ygVByhflPIzx6Byp0xdrcetdLJu9YK7HPc9z08xDrXK1IX0qNAALc33IVI3PnuHdVdOg9EU+iWD0Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlija+vbEK5mB1CG3O/o6e5hE3YTFa62Vcn0v1y770Pr7eLQR
	zXkn5cYvhlPFOls4bYw71Cx23N8hyypFLrsJsMcEVcyYNzQu23sEmjdsZq5/Tpg0Ln0iEBBA78I
	=
X-Google-Smtp-Source: AGHT+IH+1DjBTtE4oAiJ5nYLQrSihVWWKtUtFTHCdH6sonHXfbLM6XNV0VwS7he1vCcG4PQNRjGLAw==
X-Received: by 2002:a05:6808:1406:b0:3e3:a285:b284 with SMTP id 5614622812f47-3e3b40f9214mr60462b6e.11.1727795691735;
        Tue, 01 Oct 2024 08:14:51 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db617088sm8225938a12.93.2024.10.01.08.14.50
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 08:14:50 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so4842596a12.2
        for <linux-serial@vger.kernel.org>; Tue, 01 Oct 2024 08:14:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqAKUZse+P6BeqZRb3KEutq2v2ejpzdxn9sozlgnf5uNgBqLqlfc1Nq9eXJzq/77XOr2PG7hvIA6YFj/w=@vger.kernel.org
X-Received: by 2002:a17:90a:b38b:b0:2e1:5a55:a4b9 with SMTP id
 98e67ed59e1d1-2e18456a9a3mr52944a91.2.1727795689370; Tue, 01 Oct 2024
 08:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911123507.v2.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <ZuwfvyiOMAzciZX2@pathway.suse.cz> <CAHQZ30CVM3toTJCki_ao_+_2VkOxmB+a=BU73HF+4WCM0qRbwA@mail.gmail.com>
 <ZvwQiSNEwD6XB0yA@pathway.suse.cz>
In-Reply-To: <ZvwQiSNEwD6XB0yA@pathway.suse.cz>
From: Raul Rangel <rrangel@chromium.org>
Date: Tue, 1 Oct 2024 09:14:35 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DMD9eqN7hFL8z6+XuJ1N_0EfyE8d9F2Vv+CsHn0UBAdQ@mail.gmail.com>
Message-ID: <CAHQZ30DMD9eqN7hFL8z6+XuJ1N_0EfyE8d9F2Vv+CsHn0UBAdQ@mail.gmail.com>
Subject: Re: [PATCH v2] init: Don't proxy `console=` to earlycon
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huang Shijie <shijie@os.amperecomputing.com>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Yuntao Wang <ytcoode@gmail.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 9:09=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Tue 2024-09-24 10:05:08, Raul Rangel wrote:
> > On Thu, Sep 19, 2024 at 6:57=E2=80=AFAM Petr Mladek <pmladek@suse.com> =
wrote:
> >
> > > On Wed 2024-09-11 12:35:14, Raul E Rangel wrote:
> > > > Today we are proxying the `console=3D` command line args to the
> > > > `param_setup_earlycon()` handler. This is done because the followin=
g are
> > > > equivalent:
> > > >
> > > >     console=3Duart[8250],mmio,<addr>[,options]
> > > >     earlycon=3Duart[8250],mmio,<addr>[,options]
> > > >
> > > > Both invocations enable an early `bootconsole`. `console=3DuartXXXX=
` is
> > > > just an alias for `earlycon=3DuartXXXX`.
> > > >
> > > > In addition, when `earlycon=3D` (empty value) or just `earlycon`
> > > > (no value) is specified on the command line, we enable the earlycon
> > > > `bootconsole` specified by the SPCR table or the DT.
> > > >
> > > > The problem arises when `console=3D` (empty value) is specified on =
the
> > > > command line. It's intention is to disable the `console`, but what
> > > > happens instead is that the SPRC/DT console gets enabled.
> > > >
> > > > This happens because we are proxying the `console=3D` (empty value)
> > > > parameter to the `earlycon` handler. The `earlycon` handler then se=
es
> > > > that the parameter value is empty, so it enables the SPCR/DT
> > > > `bootconsole`.
> > > >
> > > > This change makes it so that the `console` or `console=3D` paramete=
rs no
> > > > longer enable the SPCR/DT `bootconsole`. I also cleans up the hack =
in
> > > > `main.c` that would forward the `console` parameter to the `earlyco=
n`
> > > > handler.
> > > >
> > > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > >
> > > It like this approach. It works well:
> > >
> > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > > Tested-by: Petr Mladek <pmladek@suse.com>
> > >
> >
> > Thanks for reviewing and testing! I know it takes a significant amount =
of
> > time, so thank you.
> >
> > >
> > > I could take it via the printk tree for 6.13. From my POV, it is too
> > > late for 6.12. I am sorry I have been busy with the printk rework :-(
> > >
> >
> > 6.13 is fine. As long as it lands upstream I can cherry pick the patch =
into
> > our forks without any pushback.
>
> JFYI, the patch has been committed into printk/linux.git,
> branch for-6.13.

Thank you!
>
> Best Regards,
> Petr
