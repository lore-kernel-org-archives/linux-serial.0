Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74819E99F
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 01:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765934599; cv=none; b=VdGBoz1HZiieG8LDQomsCcGzSpYdFmL+yukP7lqn/vaWAhPnmw4hCQ/VOnOMSyZmmVmxDKXwTqjtzwTnK+14X2Em6xMZBlBq64rns5pAkwW5Q15FFXnZ5XTp1nbQnm8qSHumJq2eItMnDghc3nzln1yUqK0TLSanS4fvWU0g1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765934599; c=relaxed/simple;
	bh=yXSiB1Xb8XhlVaTSYdRfhglLs0Rb0EeSwWMMmodjhtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzGmylinWH3S2ikk+Za1B3KiSnAnQCnn2L5Zf6Rut9eIwqSdqy5fXKTscoD+cvrxBskJLrTAm+rnSpMdOVqGyf+5jn01UxVE3Oc5geP4NSh1yPVVFo22FghvGOEb8DMYw1reRE+n5bY+jeNgS/0eHDY4frD8/Yg2VQJGc3+87lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=gi2PTOfx; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="gi2PTOfx"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6432842cafdso4854618d50.2
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 17:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765934596; x=1766539396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20u+Yo9zixTpysc9eprKHwVlPvXZQniYnu0FOsSjV+s=;
        b=gi2PTOfxX8fp+GlFyxwT+lOSc/lShK48U2FTZo8mALq3AQdKWXb+a1UJsfaskFFY+I
         W/E26XWV9dwqHUc1O3njtyjpyzjgd3eSIfEUPIy15Qkhby6fcW0HLvjlQxKpJJftFUFq
         ANEQgFbr/VBe4hDgkaSnl5VMHGzjQ/jc0lhUor6NpwbN3bJx0uaJWxglbG1NkqX3DVLb
         +Takl/LDMKAOfR3AXy4uRh5d0tl7pT622iz3yHWNEYLOidHClCOR3/8MOSuxq8hScwjV
         a8A41OUd9HCvYDM4YZspFd143xy1rYiMtV+IgrrJTpqCgFVy6qcDwAfbyGksf9lEKqH9
         N0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765934596; x=1766539396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=20u+Yo9zixTpysc9eprKHwVlPvXZQniYnu0FOsSjV+s=;
        b=BiWmYau2llX3A50CfOSMBFh51+TTDmfLvNCx22D9kFAzwaoZLPDBbzmx84GPJB/dxe
         gFx+w/zPjXfPAM4J7RKhYl5BDRjhxQH0lCyIDTurFJMvBlyWqC20iRNiQxYRjQsm7Faq
         xZBMH9GrLTLSwxyX2V/pH3EIseqEyhtYj4Nj/aF9E2NbSw3BT7nn3Jf+twzOKayqCjEj
         a5fxnFCqZSv/WvTvVN+aA2wLW2FXdPL3yudyFKplZhp8cDhGcmMcL/5uQw2dsD+ajOj6
         EHAbO0D3+4zOy0ngdcCZ3HwIgDykRYQ7pY1tpLNysj9rTj3C911QEOAf0ChUWYSZlRO6
         w0lA==
X-Forwarded-Encrypted: i=1; AJvYcCWc3DYF3MIoDRmzosGfL/drVeytjuMpxeZDCpnZ1YsxRpIFu1+ROIsgCPAyPdFQm6LDRtZ2yunKSOe0KWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2xtznLmOmIWiZJhtL8If3vWG4OoWlEQ4UNcFEsniVvWJI9jM
	f7+DEe1ht6zckk9Nm9oZVGXErsR6QppXpyKUkGrLqYpSh54mBvRqi3Co6SI9nKBAA5QKg5dT50x
	jNNQzy5C74Od4WBnEybRRIroxqppuqWuhbF1yfy0JUg==
X-Gm-Gg: AY/fxX495uFDMgEsgZhzSU3gGFEkjVSXKQsZmAPqsFeoHF3eoq6JO9yT5oaHmhFgPQr
	AvkIvR9nFLPZ8ISJhgKSURNtTLrepaMLd6lI+4Bx662K/tq5ykg38NOYjlIhsoT7zKKkxKPsdam
	pgnDu+lHwC2FAo9P1XpN2bcKezlTs81+tFaqT6q/VPZZxf9BxjU4RfIKX06alkACj8JBiAgxHay
	boQ/ld29znRd3+lA8QPjNYYO8uKrUYqnXPqa7v644nH0sbsJdd5p9Uqhl0/xxTXnbGRQFnYaFTJ
	Nc5i2Rq/Br3iTVLkDKEngATSi0tZtbYOs00TXPA1OXfi
X-Google-Smtp-Source: AGHT+IFO05qMq19SSBI4gVmifTjzTpnb7vNwVZXOZr/LC4PrjB13iviO83n7Ke+Aymi58gBSK3b0Bq+DG4yndiKAVvo=
X-Received: by 2002:a05:690e:191d:b0:641:f5bc:6961 with SMTP id
 956f58d0204a3-64555664287mr10955876d50.77.1765934595707; Tue, 16 Dec 2025
 17:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-6-a0d256c9dc92@riscstar.com> <20251216150530-GYD1903981@gentoo.org>
 <20251216-wing-squander-2fed378d3035@spud>
In-Reply-To: <20251216-wing-squander-2fed378d3035@spud>
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 17 Dec 2025 09:23:03 +0800
X-Gm-Features: AQt7F2pscWPGj2PRq6RScSaqgPax4HcbFJUbL6PI8fgs-Pvj3uUzlMNApnCVER8
Message-ID: <CAH1PCMb+Y6zUCpUNdMYfB3trKuEUsSKQ3kCn+wjoj2UA4o_CPw@mail.gmail.com>
Subject: Re: [PATCH 6/8] dt-bindings: riscv: spacemit: add K3 and Pico-ITX
 board bindings
To: Conor Dooley <conor@kernel.org>
Cc: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 12:33=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Tue, Dec 16, 2025 at 11:05:30PM +0800, Yixun Lan wrote:
> > Hi Guodong,
> >
> > On 21:32 Tue 16 Dec     , Guodong Xu wrote:
> > > Add DT binding documentation for the SpacemiT K3 SoC and the board Pi=
co-ITX
> > > which is a 2.5-inch single-board computer.
> > >
> > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > ---
> > >  Documentation/devicetree/bindings/riscv/spacemit.yaml | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/=
Documentation/devicetree/bindings/riscv/spacemit.yaml
> > > index 9c49482002f768cd0cc59be6db02659a43fa31ce..003b0bc1539b621e39172=
a0565dfea1274cbc8b8 100644
> > > --- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > > @@ -8,7 +8,8 @@ title: SpacemiT SoC-based boards
> > >
> > >  maintainers:
> > >    - Yangyu Chen <cyy@cyyself.name>
> > > -  - Yixun Lan <dlan@gentoo.org>
> > > +  - Yixun Lan   <dlan@gentoo.org>
> > > +  - Guodong Xu  <guodong@riscstar.com>
> > please simply use "one blank space" here, it's more consistent,
> > trying to align them like this would result in even worse situation..
> >
> > - only email addresses got aligned while not user names (first, second
> >   name?)
> > - adding another maintainer in future may break the alignment (if long
> >   name)
>
> Yeah, these are never aligned. Just do one space gap.

Thanks Yixun, Conor. I will fix that.

-Guodong
