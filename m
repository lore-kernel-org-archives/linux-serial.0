Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44679258EDB
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 03:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765942723; cv=none; b=L3DoxFnoxrHGYoqf8/UJf8wUBeuQnMV6N+bt/B9a3c27LjuoZlo+UJqAUN/Wal4PB/KHUyQ+yUlb0nTSyk3fEgQ9rvqc2XzXLStSB1dsliJC969TJNcM0ZDmlbJZK9nrslKd9U1ejuTYQenx8E7id182chsbyLHu4cnOF37O5AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765942723; c=relaxed/simple;
	bh=W2Q0HgCNapgVc0CETYI43MiykhR8+/4vfvNL82lfLCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEcfQDViw5FhPIqJDJskT9AlNRRZvfPknrbCakBUAaetUggfgu4htvV06+T6OvzqtXacRWEBeevnmRFs+ctef8b+eRRis1iW4NylT8Th6rDP4Cd4RZvA2SEtkJOpO62NAdulvrME18/F+fkQVBRL7+iqiEfYbopARkgLJPDYSSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=M4YyzDi0; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="M4YyzDi0"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78c33f74b72so49266507b3.2
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 19:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765942720; x=1766547520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TH6F5a+vmttqLO62jmTQVj+LKt91ZrffUns0UWLXns=;
        b=M4YyzDi0aQ07u3TeAHmQDS8ol01O1+riDPfdNHcDWVGHLMbDURkYc5zMNyLu94UnrU
         e4q6kifI+X3USvhZTOD6NFI6MkCCn59NrzrR8YOYrAqbeM510CTFeS9E7IhOGXRiD/+9
         lTkhzPp7IQZF/afcU4IuUoxk/fZBSWGOV7II15c5TIjMaDJr+UUeFw9blAiZbCr4ExUP
         uvdrfF4Qujk0Kxk+BoqePHEHOAPp0l7nnstRsegLwyTTCI//VNWpymWaf0HdNvlQtYW+
         T+Uz8vbygMPCiwE7h+CSNDmMuMPS947PBuibQPHWS3xowun+aK6a4ed+iHlWCVGp121o
         Preg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765942720; x=1766547520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7TH6F5a+vmttqLO62jmTQVj+LKt91ZrffUns0UWLXns=;
        b=DhRfL8nd4WW6yFcReu9OReagz7cRHWInXv1oCrOquCkL6hSSD7dKDWYEZ3V4b9XHFX
         y/AeugrEeXmv4YiurmQ51zCkF/dgHCqcU9b9dkPxgGO2B8wQ1FezXmaQJbFySX69C+qQ
         lbZ6mkNiF2sq1ozXNZE7KbPa+v2g9RjLq3SKhgsTclCGmPkhcPdAx0eCkhcmFscZPO70
         ZaGyO6s4FJxfA2DqO2L85U59PsWzpYMTUelZlcw6d02C1Pz61xqExjrRinBoIpj0Ddrj
         tmvCWjKfCl4m0STxqOsb+HLlg5AQiQrHaPTVfOt6NV8gA+UVA4w2SmPM8UP6fa1iJGc/
         IgyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2/0WihGPpzUhOBvzhwgC9OWPsxijx70jQZzXmet5sTOQQ6xeDv4P3pUiyGN9HvBSwwzf3sdWM6sJJSE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQayot1K3znDxd4xUYEOnbGzvS+tQ6jrj99bcHahQPMspvZOlT
	ri+0c9tqp4AF1M9AokiZRsbtMfG0T5hXiaAuXjEUMvQ8J/wvI9wAop6QxY91fV391NoelrwL5YB
	vbalnee6NrEo016mCWxYctxlrEph2UMlWKJpAFDovkQ==
X-Gm-Gg: AY/fxX4+DfeUvGMVIqI0eSRU9xAsm/gZ1TnBejf+sqZBkESus2HwgqVhPXtTu5M5ijE
	tchWmTTsA8ZKr6bei64q5Ga4nrusdU1TGs6oqTpYx+ud4Xc7yI8sX+JWSa4k+0awJtBnoUyPXJ9
	2JRsERbiQsWZIwC7b8Cf78O6fuZJ3XgQzx8jXygF8Lfz14r27YDGro2n+bO9FdUizafFiUGkVn3
	q1ZP/vSxqf/+1n1EgF2glXuHRbt5EFmNtdBWa29xAZWGJyVMsMvGOa8m+YpSUjZJlzbqbPm75JG
	93D3AY9HC8qqeRXZRVxCo8nOYH6iIsnmkNK6XcEEacMpT/obqQtV3QI=
X-Google-Smtp-Source: AGHT+IGa7io/fWTaKLPtHu4hL2REwdTwIrx+nIg3I9tnzS6/9scQa0HmxED/Tl79m0mGkX+RuCXaoxmwdtXcYdb4V4k=
X-Received: by 2002:a05:690c:6c8d:b0:787:ef99:1e82 with SMTP id
 00721157ae682-78e66e50910mr129319847b3.38.1765942720296; Tue, 16 Dec 2025
 19:38:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-1-a0d256c9dc92@riscstar.com> <20251216151602-GYB1937017@gentoo.org>
In-Reply-To: <20251216151602-GYB1937017@gentoo.org>
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 17 Dec 2025 11:38:28 +0800
X-Gm-Features: AQt7F2pID3WWQ9Vri5EMfO_v0JvS2MCRf6LsnJZs9APTGewWq7PKaU-MP0eF9bU
Message-ID: <CAH1PCMZ7rA50ns6EFfX2BcouVYX6L+mYkUSYeGjp+fPNLc62gA@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: riscv: add SpacemiT X100 CPU compatible
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:16=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Guodong,
>
> On 21:32 Tue 16 Dec     , Guodong Xu wrote:
> > Add compatible string for the SpacemiT X100 (RVA23 compliant) core.
> >
> > Link: https://www.spacemit.com/en/spacemit-x100-core/
> it would be better if you can put more description into commit message
> as I don't trust the link too much, it may vanish or change in the future=
?..

Thanks Yixun for the feedback.
I understand your concerns. I will expand the commit message with more
information about X100 core features so we don't rely solely on the link.

>
> besides, if I remember correctly, there are still few optional
> extensions that not supported by x100, it's worth to list here to
> let community know..

I would prefer not to list the unsupported optional extensions explicitly.
Basically there are two reasons. Since the RISC-V specification includes a
vast number of optional extensions, and they are categorized in four groups
(localized options, develpment options, expansion options, and transitory
options), listing everything not supported would be quite lengthy IMHO.
Secondly, looking at previous commits for other RISC-V CPUs, it doesn't see=
m
to be the convention to list unsupported extensions.

I will expand the commit message to state X100 supports all _mandatory_
extensions per defined by the RVA23 profile.

I hope this approach is acceptable.

BR,
Guodong

>
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Docume=
ntation/devicetree/bindings/riscv/cpus.yaml
> > index d733c0bd534fb63ed7c0eada97c42832431f1fc1..cce87092dc7749f49066154=
d9a256af6c7b6c19f 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -62,6 +62,7 @@ properties:
> >                - sifive,u74
> >                - sifive,u74-mc
> >                - spacemit,x60
> > +              - spacemit,x100
> >                - thead,c906
> >                - thead,c908
> >                - thead,c910
> >
> > --
> > 2.43.0
> >
>
> --
> Yixun Lan (dlan)
