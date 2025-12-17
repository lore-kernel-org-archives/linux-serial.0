Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA963A1E7F
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765943319; cv=none; b=AL+XV2o48Xrx+70JTqxdZtB8H4xYQW2F4Y1PM7GvumpiN/BvWhGP+JHjMntf158GYIHKAAF1Fp4VJ8tM59MKWNODYrnoBL9A6XhtUtOm0yKmESRrUK9V52e/R1uePA824Dh1HyW1kAgI2OyTglyxANWyd0u+HtxR29h+FZ+ThkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765943319; c=relaxed/simple;
	bh=8FvrpbOhdERcwaI1E1+Rw1nM08PWRfP4dOu/PKQvbqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uABR9DuLaJkdARTJ3Ip2VzQDbisVWjsGcexDSHkiObTAgF3y26jrGNlOzDM3pqFxshQMtqte/3XJHbexA4V8dUsoA0yDoD3MFyUf14GJz/hHxttvbXPrCf9IgKgUsvPaigQMf8IUOkhN9MrUwdSs1jilVvqpIczfU0+hr7fsstc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=fgCEWlgV; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="fgCEWlgV"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7881b67da53so47021497b3.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 19:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765943316; x=1766548116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T94a7cnx4YfqtwUokEvbKCG0vEzrPFcv5snanGGxpYk=;
        b=fgCEWlgVRcyq6/Q9wMbExyvefAJ91iCNAb70Ld/NNogV3gzFZxzNDN284ObEh4GZ2h
         BhKSgOkGTAY2kJwDNWJQFE/0ce/ATnjURyEdRMsP4mkyEMm5GJ0/+KZSE9suZhoK9Cz0
         ywCjR2GmL36DNdPDE1YDYoQB6RmCFBxssl8oLqJAyOXMeSORMs3TxltyuZzqH8Ne5hEF
         3fpxvYDzrNmwAZhLhYfRA5qDkXBVcrbpDcGrMbxKGEHjqgLaSuzkiCG8CDqzkgOI/tAB
         rf2RrZfRpQZ2wH9UYv7LtK7ZeZgZuC+vAZVo3yNekUPnG04TTr09DEWGKa8flQ3hMCKw
         4MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765943316; x=1766548116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T94a7cnx4YfqtwUokEvbKCG0vEzrPFcv5snanGGxpYk=;
        b=WgKGSORQi6vjQtnHrEoINg+bEtuuoq6tTbeUqQDcioOfpeiptIo6iXtuEbFTbZ4qA7
         KI3cuwQC4Fgp24Sko+yxxOx+cXRqAQDWBL9D+8WN8/Tyxz3K0AkoaiZV8NxTqs1e+YDT
         jHyvwBYWAWRDL9UsRMmSxmeyDzDnlvTbuvGOZ9tYou0eC/mYJuVtyBpQD8nI/k/69k/W
         8VIv9p8pPgh8//PTemT70tHCaKSYx8Fh5HgGEbsCKyEYZypotGJ8TfgF2c20rk4Nl3jE
         ep0q9DpyfNoue9ari9vjLKbOmgy56cozcBh+zvNZFApkLLSlLWWgvZ0wKf7FNTey6UEE
         heJw==
X-Forwarded-Encrypted: i=1; AJvYcCXbkdPAvJNYAIqrqvx0N4wzOZvsZaskIybAgeHBYHIXJU5vD7aONdpBWpkKhj8Av8BbUV3bdNGMhtX5q64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj33AAkdBKxJ7FTXjxzk4F8LUCr4n4WyHMytaXm3TpzMex5cYW
	vVr18+aF7j4ljXm3NAi9H3ncWZJ2aJmn9M28Gc7ikHKD78udRLYzo0rliAuKByClgSLa7G+9Ttd
	Z+XbJpPAW6Nx1d8QheUfVPFBtyvSqbNCeqqBE3jpCOQ==
X-Gm-Gg: AY/fxX4/FZe++pd9WwZVHS53M5tNcyXw+q9h5sakUBBeNVr7Xza51IoofaQfoUyVy0m
	f85uLnkzb85I10Sz8fwPz+JOpzeBL55O8NnUD2G/kunUqHuWi+zrPdT9klux/khS7YkQTwUGXuA
	rW7redT5M52WwPLvr3ZTMV9B7XQ3LcATAd4BrBLmHeKUYv8RnZwMBJ1D389qZLGcteaqwuMOrMq
	N3CMX6yEQi6XU/Z9mv7J/n89Udxt64YzaBOs72YuWVEElyj92AIDowLhze2DBoywWpojezQKKnC
	GfB6gRqkVNXM5oTB/bHTCJsTIHZx1eAJLTE/m3BET0aR
X-Google-Smtp-Source: AGHT+IGCRy+MgcC+gjoWTqizBxZYC2VIXnORXboRecI5mqVuneW7cQwX/1bYSoQ1MM7mSJb8g348UoINohu6U0LgAzg=
X-Received: by 2002:a05:690c:688b:b0:786:2f01:16fb with SMTP id
 00721157ae682-78e68331c64mr142690047b3.26.1765943316482; Tue, 16 Dec 2025
 19:48:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-4-a0d256c9dc92@riscstar.com> <b3af2b4a-1d70-4c49-a794-b4006e930fd7@kernel.org>
In-Reply-To: <b3af2b4a-1d70-4c49-a794-b4006e930fd7@kernel.org>
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 17 Dec 2025 11:48:25 +0800
X-Gm-Features: AQt7F2p6ARP-MpjYyTdAooXcg_070s9HlwUsyU9wcd7x5M0Aq4HZ6ZgO_uPeqUI
Message-ID: <CAH1PCMZdsUfurDqeRh2WQig=VzNx1k_3Z=1m_3TdJd2bYX=nVQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] dt-bindings: interrupt-controller: add SpacemiT K3 IMSIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:34=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 16/12/2025 14:32, Guodong Xu wrote:
> > Add compatible string for SpacemiT K3 IMSIC.
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> >  Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.ya=
ml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/ris=
cv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/ris=
cv,imsics.yaml
> > index c23b5c09fdb90baccece03708f4a381084b22049..152eff7335dd8457bf01d02=
497b7080f2a02ab65 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsi=
cs.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsi=
cs.yaml
> > @@ -47,6 +47,7 @@ properties:
> >    compatible:
> >      items:
> >        - enum:
> > +          - spacemit,k3-imsics
>
> Also not sorted. s > q.
>

Thanks, Krzysztof. I will fix this. q goes first.

BR,
Guodong Xu

> Best regards,
> Krzysztof
