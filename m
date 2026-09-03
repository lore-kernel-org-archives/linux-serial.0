Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C473B71B9
	for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2026 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461951; cv=pass; b=UzQGlc1PNrgFNG/tomt07l5L9cym524HYvy59eYAZjAUzJCYeFqa5mtQsRTa+r4YpkbPOVNoSXfgH1rt0leFtZtAGHPI5OsyWus4x7QzKy0c+9vyUV0mQGhq07KqfNpl8g2ffHlwvgR+vIbpFzilKUH6KuFiVhLL4x8s/fcPr40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461951; c=relaxed/simple;
	bh=/OxdHj9ysvfR57EEzc0+AuUsvMW1G0r5zIF1Md1GvvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isQgATgpcn1QFebGU1sy3uLxFDd99RSMzzdhmZ5PbKnNbRQNaoMtqGxhrU+QIpnPsbve3/nLDKKjpUVBnmp6nJy6NubiL21bhVrPXeoH4F0mAZ93U2uPCigFvHIvyq2ZzOnO74zh/0jHTM4KBNX2u2XyRr0edNeOacaiR8vMOe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njSLHGQx; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njSLHGQx"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a623987d32so139433a12.1
        for <linux-serial@vger.kernel.org>; Thu, 03 Sep 2026 11:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788461945; cv=none;
        d=google.com; s=arc-20260327;
        b=oSh0v+9KlJ6uaWyT9aZWlY6TRk2JmEyrtUH1aLetwSZSH4lv9xcmJ532JwN99knYJw
         pP1SkmZUC27NJhUOdDfeFroalEkuwjrSHQ1EEHtqcLouptQUVGkEHwHB2TiU4tCJzDXn
         RzX7fVT1lb1Iq3aBErRPR1zu1qzhttc1diK/J7otgHCWEpo6u+lxaMmhGIDEikSlzKe5
         5b8NzGv4dcLHXgEGJs+WyUHKFZCvnchTN49L20rNlt70sILlStBXSidOuMTgTqb3/V6R
         ocDMMGl0OYZFUfnIRM08GxZYMQSVskjCyc3qCUe1SnzhV4DJl10y/JhBOZO3KI2p7zxl
         9hQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nI/hqBwcSMNIp3RBgD0iAO6W4qosGQLQpAKeR8JRNrs=;
        fh=C6xT4NJW+U1nJ+FTLM1V7HqRX3y187tV/pU+EoVceJ8=;
        b=U/RrKHL3sRWmPJxsXRp5AvOCkUBukfrikH1QIkrIv9Br9MBQYWq19KWmOfVrZVTJ0l
         UVwlpIlh0IvhQON1HCoAH47xY8lKcNNwU14xt8+/soPyXj8QhZwtxCPSaxsHxaFydGA8
         N5nzRqQJ+byvnfeKTnumaKzbwzvf0lwacG7jCgh/cZZwjYYuQmlrrCZYtKHSYrS/UM2b
         nWU4TMc1J36qdrimxOhOUmLRkYEKN7nJy9Z5XtK32nhP0RZkRCPIeuZ6LyZcMBuyKOOO
         1PbWstnB0FefC2HZ3N5f8A0JRqQI3R47x4ADgJpeNwghNKmZLI4MuoJbjWCNK4nHHzdB
         yaYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788461945; x=1789066745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nI/hqBwcSMNIp3RBgD0iAO6W4qosGQLQpAKeR8JRNrs=;
        b=njSLHGQxCP2li48YR6bUqLXOlIVAOS9Y4DfCyF+hwyMgmNTpgeiJ5/HJ0/q0FpxfcH
         zWNz3e/bRS6ozvpZiy//nb9Ywndb+AjQCmAFskXYWkIIoSGuz8C2RSwc4iREuLGrugnT
         q3DzOlS4ydOhd6BdRx0AoN3EabGSxbkvWtVKukNvb4/swQcc3ZVNhBfZTHN/oTcW/hdp
         SAwGo302vNaGl+2mAv9k6AZ+RtVMPcdEARFSVPFr/wCArpNHT1qn03CrC4AQeo2QvR4M
         aDW9BIVfPgE/DgeuKDbQT3AQFbaDgZGdK3KJHxt871q6kx7pVeYaKfZhCiVwtNUFTuoY
         z7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788461945; x=1789066745;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nI/hqBwcSMNIp3RBgD0iAO6W4qosGQLQpAKeR8JRNrs=;
        b=S2ekr+XNt9sYMrdum+Q1SffWTLBuPS6sJc9MikJjjHFI5ODuJOHxkdRUO776q89SHt
         pZtG+fv3k4Qrw/uxCQx6iUroAt/oaiigNCEiBfa4GqyWDVoTrYZW9e+9FhFrHJePxUlO
         uHfmdmwUIzePFKX6EO2ihGroYRaP32vHVzXJF0IOpCd7BvRvaWihSq1rsGOc6dbapZ9T
         xc28WTkwFILK9sBjdjwsq7t+vsTtNRmJICCu8AVbC3eqFfqfXWXU3h1cqC0PXwAhsDw0
         leF0h5AzdZMKJjX3biSi8QGPKxuGxT5uWuHtaB9HHYT3bu+2xMwAVpwlTbK6XWUpcFqE
         d07g==
X-Gm-Message-State: AFuF++nKFfBUATTL3qL+dIo6cmXphQNVEGL+sS/sUaXR7mDCoOcW2FYX
	lHVRZd9WSVXOX5571AjNiEpkVjXLdlnYQcgZuXf6yirT6Jqaj4BGf6YluAzGAzdmONQziFHqrjw
	rwd16O0zwKszdnzljZPnevRMER48o6bjJTYAm
X-Gm-Gg: AYBFou106kpkEhKSDInCD8LVigZ31t6NAhDmKFn5UTsLRmBOdH85zs3XGqkoezBrUAX
	XTd7cpbuIybqMk762LmbgKW97yg9Q7JltpH0cv2fzcqTgJgFhLc9Z0wSCJxGPPLXVJxFqdxuQh1
	cwsTLU2MAjO8pr4r/b16le2998oSUBTmTS3+CJ5gYB9wE9Bpt/FjFsjh7uzLozx0wAeVkeMdrLr
	py7loDJUUWueEmKumQmfWgtLXMAWcYFDK/Q/aplb92eb5hTyduRX92WGMcagn7bHjTpNyNsHi7Y
	0JNh/zwTzVOn0HTMhVeP18NZ/z+W7UrKyXpEtRN/8Az/iUrmxMnm8SnYfGLeX7mBYVXFu68eRlS
	EtAz7WcOtaSRtls9knEQt6/mPy/zpwzMLs1sJlhcvI77DB6QGw9e7iGBU4uPaSJ4TVP40InTHnA
	OkeXURXB0IVA2KmLAr0EdZnCTRiYKysuSMyNCyTX9zL2m6yQRKMxHoyxg=
X-Received: by 2002:a05:6402:3886:b0:6a6:32f5:5571 with SMTP id
 4fb4d7f45d1cf-6a7e8f946bfmr27530a12.19.1788461944874; Thu, 03 Sep 2026
 11:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901004203.49686-1-rosenp@gmail.com> <20260901-corrode-unvented-4cf271941722@spud>
 <CAKxU2N9X=fvr-a5h5o5XaRLuRuSUq7wR85xmSduK9vff4z4CQA@mail.gmail.com> <20260903-pettiness-crested-c4fb1b3ac05a@spud>
In-Reply-To: <20260903-pettiness-crested-c4fb1b3ac05a@spud>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 3 Sep 2026 11:58:53 -0700
X-Gm-Features: AcwNN1VKJMbKCu_T1F0VY384x3qLO0B2LRU-9HQpE-yQn8Eo44X7b4XrjE7mWcM
Message-ID: <CAKxU2N__+u-mJ4bbAEFcT3jbxPShi4BeEj+0cAN3oHWzqeGzZw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: 8250: add marvell,armada-38x-uart compatible
To: Conor Dooley <conor@kernel.org>
Cc: linux-serial@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, in file <devicetree@vger.kernel.org>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:42=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Wed, Sep 02, 2026 at 02:34:55PM -0700, Rosen Penev wrote:
> > On Tue, Sep 1, 2026 at 10:51=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Mon, Aug 31, 2026 at 05:42:03PM -0700, Rosen Penev wrote:
> > > > The Armada 38x and 98DX3236 SoCs use this compatible, either paired
> > > > with "ns16550a" (armada-38x.dtsi) or on its own
> > > > (armada-xp-98dx3236.dtsi). Neither form is covered by the 8250
> > > > binding, so dtbs_check reports:
> > > >
> > > >   serial@12000: failed to match any schema with compatible:
> > > >   ['marvell,armada-38x-uart', 'ns16550a']
> > > >
> > > > Add a standalone const entry and a two-string variant paired with
> > > > "ns16550a".
> > >
> > > Only one of these is correct, add one and fix the users.
> > > Given there's match data, it's probably the standalone one.
>
> > Commit 62480772263a adds the second one to support earlycon.
>
> So the one with the ns16550a fallback is the correct one?
Good question. I posted an alternative to this patch here:
https://lore.kernel.org/linux-serial/20260902222555.30C151F000E9@smtp.kerne=
l.org/T/#t

If accepted, it would avoid needing ns16550a in dts, and a v2 of this
patch would be the first hunk + dts fixup.
>
> > >
> > > pw-bot: changes-requested
> > >
> > > Thanks,
> > > Conor.
> > >
> > > >
> > > > Validated with make dt_binding_check (8250.yaml) and dt-validate on
> > > > armada-38x and armada-xp 98DX3236 boards: the UART schema errors ar=
e
> > > > gone.
> > > >
> > > > Assisted-by: opencode:big-pickle
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/serial/8250.yaml | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/D=
ocumentation/devicetree/bindings/serial/8250.yaml
> > > > index 8c2c177faf89..f71c6afe02f2 100644
> > > > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > > > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > > > @@ -109,6 +109,7 @@ properties:
> > > >        - const: aspeed,ast2500-vuart
> > > >        - const: intel,xscale-uart
> > > >        - const: mrvl,pxa-uart
> > > > +      - const: marvell,armada-38x-uart
> > > >        - const: nuvoton,wpcm450-uart
> > > >        - const: nuvoton,npcm750-uart
> > > >        - const: nvidia,tegra20-uart
> > > > @@ -119,6 +120,9 @@ properties:
> > > >                - exar,xr16l2551
> > > >                - exar,xr16l2550
> > > >            - const: ns8250
> > > > +      - items:
> > > > +          - const: marvell,armada-38x-uart
> > > > +          - const: ns16550a
> > > >        - items:
> > > >            - enum:
> > > >                - altr,16550-FIFO32
> > > > --
> > > > 2.55.0
> > > >
