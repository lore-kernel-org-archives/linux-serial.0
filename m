Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F740414A20
	for <linux-serial@vger.kernel.org>; Wed,  2 Sep 2026 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384914; cv=pass; b=T2SoZTjW5eUOXkIDvdAUY3aLD7z20qBPdLDTUsjXESYiYEgi53wlrDi6lzsWoVKTtsLwsW4E3+E9CnYP5U94KDlJV63GUn9vjIJrVpImpz3ZRSK9UWLACiYisD8rZn7Zhl6WdxOrcfZwtu4P6zig+Mah1FxkFX5ew7HIhBmf/o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384914; c=relaxed/simple;
	bh=/3pcgbsRpKvkjeE4xYl4+01L2pgs/y1sJR7qtHiJdnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dj7q7zhXHR7N4EShOYEXTLnLtS+u3iSKDdIvDyYd0y5P9BSHOSdefgLlreUO1Xiqx6ctTZPz4GtbTZtDK+xNS33TmEUe+nLIj4iteGAx5RdEkLV39jrKbVKZ29jkEy6aGe8UtLDxOCLppsJZeuK/vNSJAMcpNv6otPx161vhGxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+AuOdSi; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+AuOdSi"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so2847722a12.2
        for <linux-serial@vger.kernel.org>; Wed, 02 Sep 2026 14:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788384907; cv=none;
        d=google.com; s=arc-20260327;
        b=PM1D6nGX7g9tAQsAlAzwr116OAnaieGBWog8qHAuKUDchzfRpgiycu3k92YJwkTEGj
         gAlYoPYh3POo3QCjatBRJqfA6Di+sjLuWfJoVjBgNwTMPt9X38ZPlEx7lFkyM332kIBr
         rhGiJnlMJV//fOxpd5xC4t+ErSWgaFHNlqZa0l30AtDXtu8e1hUFucsbJZRtAFLk5Krp
         orilVn/whI+EEiqYAY0TcviJ3/HX1UgIRiVkyW3JckgpbZmEz7Y9srpOniNMlGE+jrZo
         VkFyBus9OrIeo3DkaxkD69y2W1wFdYtrfi/D/Yo9wCeNOZgnYDLqYHq4mbIBfuANYY3v
         tfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3AAbrMEFHcqDNT5olp4jYzEjeN8ZcYhbUy/GnjuDWU=;
        fh=C6xT4NJW+U1nJ+FTLM1V7HqRX3y187tV/pU+EoVceJ8=;
        b=Iy3QYcJ3/mKbrHtoACxK7Ud/cUvxIPKI6Uylhu9qdQJ1Nv8+xjqscFvdNd2a+kLcWd
         R40HDlI16Q8gEWR+DPA5rJRmd9CxSrOaTqwwIHNz96/Vof5972eeQUW7KAETSoq9DVhC
         v0rWLNjko8sg5m3kjKbdoglda5JBsQB6mgCE26Q0QCk6W9VfK/vhfX6rOL+Zs6Gf8TTU
         uMw6i/qYZCeZaOvFNs0GPfmh5L4WnuazdnbLM30T+kUXwpJuI6rRblP4NLjWBPx9QSAf
         jM8Uj1D0AGXBwBjk0MMhxjrmDvAcZO21sufPqJrTKdDgkSIn+XcLWZCY8gkNvm/EHbaf
         1y9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788384907; x=1788989707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A3AAbrMEFHcqDNT5olp4jYzEjeN8ZcYhbUy/GnjuDWU=;
        b=R+AuOdSiXtKqWskLsD5Bw5He5p5Kzkl36kaBnjYu6VyynddTv4RCuS4BUK8mZIPMBE
         eEMU6kxN+HwO2sowytw2IeEmaLVoKcg1LBDiFDpDl6uqlbjrIz/w5dGlK3lOxkL88PGw
         iT1VpEYXMsmGPoQkXuWKfiThN12TvzCKakqAoypcy1sHU1UJOmaD4jFQ7KPzuTDFxvST
         jYSSjQjVVsPAX949Cpv76lFsrt84QXHjM8S/kuMu2PKzzVRLmPB31A3x3PavufEV0W5V
         IXmyppD6jNRzj8Vx7W6PRTAifm6kqJ4UQFbKsIzY5QP/Z+HxzVXiLcOwnSuSHSR5OqHz
         h4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384907; x=1788989707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3AAbrMEFHcqDNT5olp4jYzEjeN8ZcYhbUy/GnjuDWU=;
        b=ha7ydkB5EP7a754n7aZdoGkdvbMw3Ig6bYrS/pSG8VS8qcAhC2rmV1soUB+EMIseYG
         C48YrZh897dEM7bPIFSH7INEb8djr01pBnAosJPeuTjYv3VF8HBO/NgygJBXJzuvHjfc
         TRuizUYBiR/vjGAO9BclnOZ3KH2AykTBZp/FBH7Tc8kI/RT+E2xs6VMJ5hcDqBKRIFtM
         kBoY+WnO5e+IoKsZsDRmXPbpDNy/Eu4Nv5LSZ9kC2XBlg+VphwMmka4m5XWVNIMqmyc7
         MIGESxmJ36qbphkv24LE/gVGDkobcYnUH6K/8fJ68kbftQLfobOICrFsXwz2+yLIgK6c
         SZ9Q==
X-Gm-Message-State: AFuF++l4uPTCzMuJsU/HbuD3nv4R2D98HD59vsqu5Uhl2HTX2kM/JTLP
	N/sfnmJEb7oxgk6x6KRSd3nmdrlOH+DUNnFcoG6BdRSqJv7SO3yeIBqp5fU5MiosVe+PyPnYeZJ
	JQrn9hfXE3gWsI1Gohh8TYNkNMMWwrPk=
X-Gm-Gg: AYBFou0eCRJcAKIVlzxmSjk5LtWerxho17NjB/pwGTF3K2B6M7DGaSWgvOc0jlPgfu7
	XBJYcI4n/6Q6C8acVWRUY9iTMdvnUwRjGXJQA6P+Gets9iegGoJzoZH7Ah2drP4DH0VBAZslbA0
	6QPGofU2L4pXzJoy5d6HEqKT28YY4VXEZDaDdsbSe0G8zPG45rBoW3bWzng7knfjPN2C28GaFKd
	jeozE3h7JmLDLnn6A0ubvEszYUyoGdH0zwyys/V714aBtBsjn8lFCwS2xmalSpkIAwzpBHlSHgj
	D8V96mC2eI1m/iWEP2WKFDKz3RQ8QB5KehkqtRrXLQFkUO3VvSnEg8WL5NrBuzA3kOKg0IgWniG
	VNL9DmBnJ9/iOmN8/p37tZ3nGQVEDBQGWVf1UM3Nz1bU74uHk3oljAuEfHKJvh1PI7hqN8q9t32
	ShM00+N+E5ABUgNMstKxHHujL54bCj//9sFro1CjeuWLkZFEVjXwNpIlAiWfxHQ2ZlBA==
X-Received: by 2002:a05:6402:2381:b0:6a6:1076:8152 with SMTP id
 4fb4d7f45d1cf-6a68313f895mr5049013a12.7.1788384906985; Wed, 02 Sep 2026
 14:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901004203.49686-1-rosenp@gmail.com> <20260901-corrode-unvented-4cf271941722@spud>
In-Reply-To: <20260901-corrode-unvented-4cf271941722@spud>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 2 Sep 2026 14:34:55 -0700
X-Gm-Features: AcwNN1VBhItwhJb21bPHSs3C2UiMxziNU0BPB5MkKs7BmaQD66JnJpLxPrmmKk8
Message-ID: <CAKxU2N9X=fvr-a5h5o5XaRLuRuSUq7wR85xmSduK9vff4z4CQA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: 8250: add marvell,armada-38x-uart compatible
To: Conor Dooley <conor@kernel.org>
Cc: linux-serial@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, in file <devicetree@vger.kernel.org>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 10:51=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Aug 31, 2026 at 05:42:03PM -0700, Rosen Penev wrote:
> > The Armada 38x and 98DX3236 SoCs use this compatible, either paired
> > with "ns16550a" (armada-38x.dtsi) or on its own
> > (armada-xp-98dx3236.dtsi). Neither form is covered by the 8250
> > binding, so dtbs_check reports:
> >
> >   serial@12000: failed to match any schema with compatible:
> >   ['marvell,armada-38x-uart', 'ns16550a']
> >
> > Add a standalone const entry and a two-string variant paired with
> > "ns16550a".
>
> Only one of these is correct, add one and fix the users.
> Given there's match data, it's probably the standalone one.
Commit 62480772263a adds the second one to support earlycon.
>
> pw-bot: changes-requested
>
> Thanks,
> Conor.
>
> >
> > Validated with make dt_binding_check (8250.yaml) and dt-validate on
> > armada-38x and armada-xp 98DX3236 boards: the UART schema errors are
> > gone.
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/serial/8250.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Docum=
entation/devicetree/bindings/serial/8250.yaml
> > index 8c2c177faf89..f71c6afe02f2 100644
> > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > @@ -109,6 +109,7 @@ properties:
> >        - const: aspeed,ast2500-vuart
> >        - const: intel,xscale-uart
> >        - const: mrvl,pxa-uart
> > +      - const: marvell,armada-38x-uart
> >        - const: nuvoton,wpcm450-uart
> >        - const: nuvoton,npcm750-uart
> >        - const: nvidia,tegra20-uart
> > @@ -119,6 +120,9 @@ properties:
> >                - exar,xr16l2551
> >                - exar,xr16l2550
> >            - const: ns8250
> > +      - items:
> > +          - const: marvell,armada-38x-uart
> > +          - const: ns16550a
> >        - items:
> >            - enum:
> >                - altr,16550-FIFO32
> > --
> > 2.55.0
> >
