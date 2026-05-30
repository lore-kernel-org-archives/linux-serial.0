Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD220125F
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780169626; cv=pass; b=Y0vzr0ewUPcy5jWh3ixEFwKOXl9hfMuEJTI2y9sd9/9gqXRSy+OP0EULn+PzELEutT2TXOogDYrKOdxWqQzSm4hZUf3n1GscsnHsgsTsd71NkQhREsm032fy80ciGhQx2F+XtqiBHHKpFQEbIq4f+PWjnYIX/cSotisLUtlBHRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780169626; c=relaxed/simple;
	bh=Ii9QhGYH8Ddx4p+nDmph5Vh8dMNnUCvxNxmYJVM6HU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhknUrMp7m8gH9MT+OcRhom3xBr4aEFAITMURDM2idQ8gfyfmbN0PaLwn+WAWZcPnn07/hzDApytBGvVgP/Cudsf1jsSldabZRCxLjxzCUm01XIdy5erUMK2c6Pu4GngjatGXspRI4mKDxIgd73n+Cdr7ATHm4+FcjnAKLERMJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glSzQNfz; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glSzQNfz"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68c5eecdd56so1758617a12.3
        for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 12:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780169624; cv=none;
        d=google.com; s=arc-20240605;
        b=QeBLUA5VDvI6eLMTfC1fFTlfkuNdTBicZQY0qvnEiAS0J2rWrqiNWbNuanHfLQBWKZ
         pKcQW7puAsiO4AxkDPspG54q9VRaAa2L1oikNeR9NsEEvQ4ldJRLKvvBmSOFfsZiz06p
         wsIM4ADVkQtaBJl10s1oG8EIvPbljsvYAyOFVPyP5fkHDHO/JCpw9hJoO1wrOrjdvpVk
         6CXSx2E97QNG6OASghEAHrxKwdDCE9wLt8ABNZr6vVC4NabaEed394f7gQRTRMS2b/63
         UlCw72fAd+vST3saNL0yeVJZTG5j7cohgsheTz6grr5SWZaSPlpPBKLx+j6E4WusY1mm
         PQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DekgsxuMi51WS5zY41eRSoIAsmckrInSkJh0VriOufM=;
        fh=O9wYL0kJZOzGTjTpARDvzMwwq062vuKldWOpKyzeTbA=;
        b=bqvboLfl88qEmiHDRvQw86JaYtO0pM8CHjHdayd7SRqfbuDtz39WILonAox25z9L5p
         BHsR2qo+2DDWze77tvjKMUssoS43fNMdzI1EAgr60acOVIRzQUGd7O4VGEeaj0eOnOps
         y/G6c1UA6/tKkeK7z8TY+L+ooRALcAKd1a36RuWcWV/fksxE5F99vOxxTlZO36PFlF0V
         ReHsOIOYk6foO63t5SJO/LKIhwR4LQG/iWjI7r32u3DAey+Bs3CVZoKm2mE3w4DdKnvk
         OxBWd+THjcHQ/c5smpQwpLu7ufvSl9r4eWwf8nIrENEUYce8mKHyc08ul1qvsfTQ7lQy
         I+bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780169624; x=1780774424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DekgsxuMi51WS5zY41eRSoIAsmckrInSkJh0VriOufM=;
        b=glSzQNfzPPgJB+Pl5MrvjrXXH9wIZXMiUT6KxYDpXhiZi0xcDq/1NtoWjB52qVZD2J
         7RfCty0yZE0iYme0vjcYqOBCO3AdfcbNcqml85JYPdsg01/GjFpbKS+mRrXjkigmpODr
         ot/wNmZ7BUdlgxaDCiA6Ul611WudEdip1e18W5xtyg0EJLqXwivljCQcFqHS5WNIoZmD
         HPTUwWMXkxG/TAJMcML2nDYcJ8jatEZSU0TNSP87dEWbgsq4poI+dfSMKFihcfveuYl2
         KVsABJgXQj1m6RhAtc5MaeLsdnKD2XS0WQ5zdgHfwIym0VyVePriDIVVmzpRhk6oy+bG
         lMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780169624; x=1780774424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DekgsxuMi51WS5zY41eRSoIAsmckrInSkJh0VriOufM=;
        b=cYuXazWuyEVUOkoEmfG4N7ZrNcU5LwYuXbvb3xNIORG/Ux4vHlHQWnpMlc7tgndFcd
         aoXHNPsPfn2oIm08AhKG6XPjfq7v9yIODbexhwjWvrBamcAMqLB6KEJ0429cs3ZPTZJJ
         F7SMjvcljKV0zgpSFOlxIbfiScmN8DMx178s7pAsDmcPI6NNInx69/DsN7pHXrH2re2W
         PhbgPJzfzUpix4Fe1F7IE09f1owvWQH5WKSP/UTI1dczWUSuI9WPTR4Val7u69n67wT1
         4ZiQ4OYRwPXSe4rptxkGtw13Y8VeQf4JtgZV1pr2YvNeZyx0v8tg//C9MuJiIj9qPKtG
         uz7A==
X-Gm-Message-State: AOJu0YxWYE7JbPrD82My/QRAtezvMFF326yIsRYni5f+yEQ3et7Zu4GE
	P5/hDpvhtmIQ3AjLE+hvXRBK9pUF3NgxVahpO9wft9JmZUUTWEcl7YQii3e0iHAcu81hBbYCVhS
	88CluOT7GCwTgVPM4BQhu7XGHCuiqFP0=
X-Gm-Gg: Acq92OFKPuKHBSFEKUWXXQouckgU5FVAQ6YVbunEk8a5v/swVPMNF5I/SScVkbMK5FS
	amJQC9gu8I6ISeBXrTjubavSWLM1hquFFMnPDhjKuUlLGYh/3I6RU8N/jE1xxMcMfJOiegP6BE7
	dDYSaK56UhnkDPtltw6UdW/dhjkrmtVGLLA66/zcYuB3G991XdEhpXp402GLK8cZmOvBSBYBcK/
	MP855plwqRo/nR3VwgldNTCxpMzlb8BizKUGlhUf9rv5/wPc9wWAJvDwoBkWPkscW/P0nwuIcPc
	HEz0idQW7ndZ5NwC24RlANNHVs4aUZJQ6+5BDNw+2yJRxptgKoi9PGaT0hpLg+GHRcWIq95bemj
	yHYvEJkqfq57zL60fVFbg38tpxADx7bEts0w3RZp/RFfwodwq8AQXthtdtlOGe2YPkpUg
X-Received: by 2002:a05:6402:a50e:b0:676:9c6d:7448 with SMTP id
 4fb4d7f45d1cf-68c8d008593mr1310597a12.22.1780169623588; Sat, 30 May 2026
 12:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528230616.186792-1-rosenp@gmail.com> <2026053046-bonanza-bobcat-6ed1@gregkh>
In-Reply-To: <2026053046-bonanza-bobcat-6ed1@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 30 May 2026 12:33:32 -0700
X-Gm-Features: AVHnY4K79MARsE55gPXS-mt6AcSVjDoRJ17LhtVUNVWG0hsymJZR1HNJqMyC57E
Message-ID: <CAKxU2N8Nq1hdG-C4xrbpr2OCiQuf-dZRC1GebuPu9PUE1jProA@mail.gmail.com>
Subject: Re: [PATCH] serial: mxs-auart: fix probe error paths and clock handling
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:25=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 28, 2026 at 04:06:16PM -0700, Rosen Penev wrote:
> > Sashiko reported three pre-existing bugs in the mxs-auart driver:
> >
> > - For non-ASM9260 variants, mxs_get_clks() obtained the clock but never
> >   prepared/enabled it, leaving register accesses in probe at risk of
> >   faulting if the bootloader had gated the clock.
> > - The error path and remove function used pdev->id instead of
> >   s->port.line to clear the auart_port[] slot.  For DT-probed devices
> >   pdev->id is -1, causing an out-of-bounds write and leaving a dangling
> >   pointer in the array.
>
> This feels like it should be a different patch, and not burried in this
> change, right?
>
> > - The probe error path called iounmap() while the IRQ was still
> >   registered. An interrupt during that window would dereference the
> >   unmapped membase.
> >
> > All of this is a consequence of using mixed devm and non devm. Instead
> > of working around these issues, go full devm so that everything can be
> > cleaned up properly.
>
> Are you sure that devm and irq code is going to work properly?  That's
> always a very tricky code path, was this tested with the hardware to
> ensure it still works on teardown correctly?
Nope. v2 incoming.
>
> thanks,
>
> greg k-h
