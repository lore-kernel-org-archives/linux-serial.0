Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BB1624D2;
	Mon, 24 Feb 2025 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381609; cv=none; b=KXxQILe9uFiGxwDTezDKQUgzTBovISBg+kDsL0OaVoWZMg1aW3JsL1JNdcZj8bNP4X1dVm2MxP3f4Qdz1ZxcbtJXDbN/W2ZQ2GxjM2+BbBxA3Ma/OuUEVuOa0rNg/ypTQJ547wEkoRmB6byYCLG+EQ74ALmwWEtiR3gVstC5URQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381609; c=relaxed/simple;
	bh=Oafipzm6XGCDRBycB+ux6+bj8zA6/+6fWk2vvae9lW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJYuPr69qYEtNUwUx4lFrXlZfItig0nqr5pUw0CSlcuNc/EtbXtLjuVENz+vDBS5vE3gFiLrgXf3LtSA2eLRV4RHIvKf7rGqDUvj+4BvD9W0PrwhyA7m2oBEfJ06ER3UAAbC+X1IT6cEqv7mVKDZUiCeLk994lsFleyKVpk+Gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kioX8eGa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kioX8eGa"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso623216366b.0;
        Sun, 23 Feb 2025 23:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740381606; x=1740986406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oafipzm6XGCDRBycB+ux6+bj8zA6/+6fWk2vvae9lW0=;
        b=kioX8eGaOcAG47IwjPY8ABuvzVQQhJjzvYOukEoNP86bAddV/5FUyCvW37hVTt88sK
         Ia1fsaGL8vJXDflrj2NwtQYKauuqwY1nf/Wi6iYj9d4CCyniX5kKSAfu3H6nQm1AaFNM
         jhfay+NXquHWAG3z8RtKH2V+b38fsIKcncNO3Y2kQk7O2XtbJAOGW6uQy7VCqURDo/d2
         CfUEblMd+l+AkomEYE30DU7mFVMO0m3AJ/NtP8OI+jozJeX5oy3f0Iniyf2n8nEsPsNH
         MDAimYdpcyC7W7iRdud6b0JySpdeKBnAMHz7MfamIjhr+qrFG/5ANeFgx66yhplNYMu7
         yv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740381606; x=1740986406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oafipzm6XGCDRBycB+ux6+bj8zA6/+6fWk2vvae9lW0=;
        b=gXbJF46lyC2/sdxnZYaoXSVD90HTJjb2DelDM+vCPnV+2zyNwO3gPsljM8TSayga0V
         1V2cepFvBo099Sydmytg2n/aTQSFN5A3fyrIlE8pphDV1D1sUIYSy2sGLidjCD+4DNNy
         mcllxIuAhHqz71U4+TKl5Zy6T1HjrbWfvKozCVlcr/g/y8xxkKhuGJrNcJM0lrQOMxKC
         TetFtw/DuL2BIyzXPfTbItCgu8McpiJG407xOP88ot2bDqCNw2p2pfXlupNIxzYKg7gT
         FYRP8S0PJIsQH+TMhjVbgf5h/Ymdl+ZBLtJfNS1wmSfuKUMwrvWQ3fVo68XF+sx2A7Zv
         VysA==
X-Forwarded-Encrypted: i=1; AJvYcCUZsn7QZnvukOzTgRtxocvmG3Fc37+tQrmD/0szeTVSqc7p3G2nVVIgkIVOFfNRbeirPCRlmM3//ocFYX3y@vger.kernel.org, AJvYcCVX4GNuKvsNEH4iC9gctlQs+Onysp2kbBG3tmIBvhlLJX2evz1GnTH6SkpulYJ4zEDvPoT1HKrcq2einpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCpDlRlR6G/yTuEDN0zQ94a6Alunix7OxR9BTuBxi1krCbbevS
	H5bwIXmBvdAePf6jhRmcxANLqEiZiw0GrmM0s+hRgE3R1WVmuL1lDFAU8gMpUqF0Y1RRZpBo5Ji
	9/7UbbiWWADDpuE6j2wvZX7Dnsyg=
X-Gm-Gg: ASbGnctF+2LntMiUR5IgQYNZMMKn1/5eQHP5C027AKXiQlmfEedGzJSeTbus5fZPNos
	LbJyQUIZlcMSMGx+rQIxugch2FYwF2EGVp/YN4AHC6poVCi1l7D2Bp1a7BQ31tlblrN5gGCYjir
	KDC/HlkgVSVg==
X-Google-Smtp-Source: AGHT+IGRr20D+nYlL7vLzLB1mN9NJEZQKWhzH6eB03dSlbA2B6mRnsJbOsX8KS7nvKXyl15DlDt2/6foE0xae6kMc3E=
X-Received: by 2002:a17:906:6a11:b0:abb:d349:73b3 with SMTP id
 a640c23a62f3a-abc096e0044mr1164920966b.0.1740381605564; Sun, 23 Feb 2025
 23:20:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223204456.1913392-1-adamsimonelli@gmail.com>
 <Z7uOsqky4Tw9J6QR@surfacebook.localdomain> <7410687.31r3eYUQgx@nerdopolis2>
In-Reply-To: <7410687.31r3eYUQgx@nerdopolis2>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 24 Feb 2025 09:19:29 +0200
X-Gm-Features: AWEUYZmKNiXteHDqx_3jgRszbpgunyLPcTNFa2QeZzxEJN-VFRbaGn5lZevgluo
Message-ID: <CAHp75VeBaetiQBykfLk_weBHdzZF1nWp=k8BJu+OKNp6iYRRTg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Optionally allow ttynull to be selected as a
 default console
To: Adam Simonelli <adamsimonelli@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:23=E2=80=AFAM Adam Simonelli <adamsimonelli@gmail=
.com> wrote:
> On Sunday, February 23, 2025 4:10:10 PM EST Andy Shevchenko wrote:
> > Sun, Feb 23, 2025 at 03:44:54PM -0500, adamsimonelli@gmail.com kirjoitt=
i:
> > > From: Adam Simonelli <adamsimonelli@gmail.com>
> > >
> > > When switching to a CONFIG_VT=3Dn world, at least on x86 systems,
> > > /dev/console becomes /dev/ttyS0. This can cause some undesired effect=
s.
> > > /dev/console's behavior is now tied to the physical /dev/ttyS0, which=
 when
> > > disconnected can cause isatty() to fail when /dev/ttyS0 is disconnect=
ed,
> > > and users who upgrade to a theoretical vt-less kernel from their
> > > distribution who have a device such as a science instrument connected=
 to
> > > their /dev/ttyS0 port will suddenly see it receive kernel log message=
s.
> > >
> > > When the new CONFIG_NULL_TTY_CONSOLE option is turned on, this will a=
llow
> > > the ttynull device to be leveraged as the default console. Distributi=
ons
> > > that had CONFIG_VT turned on before will be able to leverage this opt=
ion
> > > to where /dev/console is still backed by a psuedo device, avoiding th=
ese
> > > issues, without needing to enable the entire VT subsystem.
> >
> > This rings a bell of the following
> >
> > https://lore.kernel.org/all/20201111135450.11214-1-pmladek@suse.com/
> > https://lore.kernel.org/all/20210107164400.17904-1-pmladek@suse.com/
> > https://lore.kernel.org/all/20210108114847.23469-1-pmladek@suse.com/
> >
> > I don't see any mention in the commit message about these, have you stu=
died the
> > cases? Will your change anyhow affect the described there?
> >
> I did see that sifting through commits, it looks kind of different though=
, as
> that was to make ttynull more always on, and if I am understanding it cor=
rectly
> it looks more of a last resort? I could be wrong, but I see it was attemp=
ted
> and reverted because of conflicts on some hardware platforms?
>
> The scope with this new patch set is much different, as it has to be manu=
ally
> enabled on top of CONFIG_NULL_TTY, rather than assuming CONFIG_NULL_TTY i=
s
> enabled, and adding it to the list of preferred consoles. It is more for
> Desktop configs that are looking to disable CONFIG_VT, but still want
> /dev/console to not be a physical device by default.

Thank you for elaboration. Even if this may be a different case, I
think it would be nice to have the PRINTK maintainers (who are also
involved in the console code) blessing before going in.

In case of a new version, please summarize above in the commit message.

--=20
With Best Regards,
Andy Shevchenko
