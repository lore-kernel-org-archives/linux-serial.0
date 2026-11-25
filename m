Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795588774;
	b=VGf6dZ6GXWkslYzz0h4QPvGJ2P+8qUOaCZtI1yD6sK5oWoQJPxZ7nVTjAPTVfX+c1qKR
	 Tik+x6GnpbwvKoeKcFH55Lo7gAzShn3c2Ugk/wR4PJBLwGwmlKCV6OZ1jjkqwhdj+8k8m
	 vAZj3O41hd3yYTTPB91gM2wRm7SekN6082pcxH203F6EhpFqZJiDJeDR7BKKxBKbqzWOe
	 +MXSjey9GE8+wLa8/nSJyc+/N+0yBz9xic5zIakf4XtEf8Pt+KDuip0xesQchBhySmulu
	 pGpt0QEJR8XntzsIo1UlZBTL8rR4JaniulOhqmr79ojfIO8gJVKwf9OS3hSBu1HmOlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2N0HpHcM8mF9ugP713fWJ2a14UxLxacvTfc17W7cvH4=;
	b=NKKp2fZr8o1jI3JXObqeefA33HOTusuSHitsNpt3F2Jslr2AuUIdZz2WgHjGjCggLbCj
	 aK6gAKaGX/lzMYuhFOUx4rwz+MMxLErczIr08MWjoOuAC/eCEby+yYAlrOHx/ber1S7KG
	 F4Jw8K/ffhTkXBCvzUYcWzwBXWp3JnpuoMrR6VYNi6SQXyxACpGX08CbsTh2jjtj6TjNt
	 pm57huzIgu08O4cXPB5gx+rduwgP/6NFnVDZvKUgeBLyPa1O+f72Awu1sfgJy9gmgRB95
	 1JeduT+O3NCr8Pp9Ktql8c/sIoa85UrMnNJ75Bsa9UJFxmXde3K6Uqn4RRQ75IFCW8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LPFadlM7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E15606A321
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 06:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66E15606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LPFadlM7
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso17026166b.2
        for <linux-serial@vger.kernel.org>; Tue, 24 Nov 2026 22:39:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795588772; cv=none;
        d=google.com; s=arc-20260327;
        b=py4lQz7Uwje2DXGjHtr80HMA3Tyw/T13VQFhGov5OM79bO7r9+3djqASo8dSwtpjt4
         JPlDHPtBf2zFLUC/NxpaqjeIuZDPl4AM2voLiAp43fR8KZabgYbtEXzhBzX1w9zRgabt
         qgOLeYt3uDKITL22J7iT4//iBMud56z/HhT/TeW3kQZRSW4hP5mTsssiggniYUlmewXk
         pDgSPLXOKkuzYRogS8CDqqlE8x2sCl63diaAm0jPvXdpPa0AdI/Co3Kp9hNEQpdDi8Ft
         jlPLvwEhSKpZ1qAROkcCDPp488ZX9sxsbMB/B4aHsu4Nx6uzdjTKAAFX9Dz6Zu4OOXcW
         uBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2N0HpHcM8mF9ugP713fWJ2a14UxLxacvTfc17W7cvH4=;
        fh=AGSATVyDNifF9xgxX1OHYTjv4g0FkAemaqj9fWaMl2Y=;
        b=b0Rp5DHSufwmPhQIQnx0ha5VgNC60pBS2B2i2lt3EMnjpnG0l0dnZHaKH20+cOpbga
         yI1ImY0k9+UrkYnLRuIvYVfyAd97B4I+2t+T8jgCdyYImySiDT7I18y/xPZKHv0ZoVRv
         DvSau7V+wkpQNFjD0eEF31Jk4BlrJTM311RY8ArvoFIawZ1awQXUw2tw/yxefPvRvmVV
         j/FxhTO4VXYM10VYePmEc3wu73wAzuspTbK6SxUMw+mxmXvtzSAUBV5Jx6+vteU+7kOr
         +9U3tjtgDdAnGBGp+li5wJSzuUMFgooW8vwsCdVSE+CDufwX93SqbZlfWaotAe8hvuI2
         LQww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795588772; x=1796193572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2N0HpHcM8mF9ugP713fWJ2a14UxLxacvTfc17W7cvH4=;
        b=LPFadlM7D7rNGBOZeQd/sWVRJgc3bvkjZ3pLMilK44Z8frq4Ugre+QFyiFboIQswV8
         YrNNhYzkV4qvbRM84knIUHJR0CILbs+yNDEitcl3OdbaBZXhPCh/YQlQAH0YkiA48npn
         Pn0LWmTuz0d/c+MDjxzpccPK4E6ebq37sxCWXFemnU7XCPXy7ibGRlrjh6pz1KM8MVij
         2GLuLZUF7Hl6i1D2wnXPcYNQXy4TdxBLMXgZSW9suSj7EpPbdU/6joOmJ006A8sTwzho
         +a33KG6khNzi5RHqntKGyecQdzug66SaaLyh/8RbRM9rpmok7MvW+wDqKQJKl6WFmzIM
         y40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795588772; x=1796193572;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2N0HpHcM8mF9ugP713fWJ2a14UxLxacvTfc17W7cvH4=;
        b=dtBAj6n8gs2cfLSN+ZwFvr1XFwtWeA2R/KklWUvK3NOVNos9k8grw2Sc8fspc9Q5IV
         KQGfcvRlNiu/gaJsEaedjVjCOOrr659ZJ4a2UwRObQDPHzPwawJvnWuGtT8hslKis7PD
         J2Bxw6Z+VmFmMD0SdFupO6w7eHTejwD/ASHiAdMBjpsEsWWhzYkEUOqeogvb46FysyEY
         lOCo20knCq4pquURBGvnYUHW37ywtr5WChxyjFVs/Kug6uhgbeKHT+7qhG3ouI055xTX
         q1OK7Qf4gceTDwvOZInfzT2eDbCCXtfvKlnoFXPzlhXaUn7IR3zucPvbEv0jrn8tssee
         uTAQ==
X-Forwarded-Encrypted: i=1; AL+hErGfAoxyXed266kgcQYqg1ncKYbUf02bKdCtD3XVjpvsUxv7fyBram+a09lTcSHKXl87zcc18+HYzSWtC3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+agv28CRlRAP6GprrOC9eSNTbKhD/nF9b4c7645YdmTQ0dVu6/
	oU3z+jP7w6IV/j4O0RnuHwI9A9nXfL+6kBXV6zuXNvTCOZktmKoeybB9Kbc9rlw8KQl1krP/C3j
	Hj3kVDE7vFvYZw+6IsSS6fRWQF0Ty22A=
X-Gm-Gg: AZFdTZd5/vzRSeGK+zSHtxOuKlVf0Hm5EB9lyMPVBGCrcc9KHR/ezLR1w6pc4f9Hh+h
	dHk4f10gEw9p8RayFMandqaDlrzakRHEjWslVKi2qjTKIrBUZLEufxbOejfuAevmI7iRzULmKcZ
	kE+HxaBiXngh8JQmKTNTVuOebXJVFf6DWkPPiJZTHpxG4uTBn/SgBwXPEDWoe8uqGPKfAEh7yiO
	2ZVYfGZ0bhIeB5URouIykPIJdcL9DZ8N2/HDBEfb0wlG8/ZjpkqjQGrDWMe0Q3w0W4XFVycZDmn
	b3k8xPPOUa4ymIVoJpC+k0MSyJofcwZ/9U5xeP/mdiQIwzWGnaDIRljO8UtP68ee8XT4wx40RM3
	4e+yxPv5ro1fNJJ+Tfj3SEE8dntaVl9kGMlcP
X-Received: by 2002:a17:907:a890:b0:c4d:31c5:e30 with SMTP id
 a640c23a62f3a-c513ab12652mr1505328766b.49.1795588771543; Tue, 24 Nov 2026
 22:39:31 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793776192.git.zhoubinbin@loongson.cn> <c194b5248184779da500476281fd411fc80a98d6.1793776192.git.zhoubinbin@loongson.cn>
 <sashiko-outbox-196836@kernel.org> <20261119214532.GA757146-robh@kernel.org>
 <0009e3c5-dfff-4254-a06f-13c8664a1543@loongson.cn> <20261124134407.GC3404231-robh@kernel.org>
In-Reply-To: <20261124134407.GC3404231-robh@kernel.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 25 Nov 2026 14:39:19 +0800
X-Gm-Features: Aa3M54rdaSaGyr7l6GQ5KvPJFYaTr3GJRENcNxHkmOtej3JVVHPOUUammhE2TCc
Message-ID: <CAMpQs4KRnVuZBZGtormXFK3X8n4KP_3bEr=OhwA-mHN72JRsgg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: serial: 8250: Add dedicated
 Loongson-2K3000 UART compatible
To: Rob Herring <robh@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, sashiko-reviews@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob:

On Tue, Nov 24, 2026 at 9:44=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Nov 24, 2026 at 02:58:40PM +0800, Binbin Zhou wrote:
> > Hi Rob:
> >
> > Sorry for the late reply.
> >
> > On 2026/11/20 05:45, Rob Herring wrote:
> > > On Wed, Nov 04, 2026 at 07:52:04AM +0000, sashiko-bot@kernel.org wrot=
e:
> > > > Thank you for your contribution! Sashiko AI review found 1 potentia=
l issue(s) to consider:
> > > > - [Low] dt-bindings: serial: 8250: duplicate ns16550a fallback bloc=
k for ls2k3000
> > > > --
> > > >
> > > > commit 71974153fe22bc00d365059be9198364c9cfaa86
> > > > Author: Binbin Zhou <zhoubinbin@loongson.cn>
> > > >
> > > > dt-bindings: serial: 8250: Add dedicated Loongson-2K3000 UART compa=
tible
> > > >
> > > > This commit documents the loongson,ls2k3000-uart compatible string =
with
> > > > ns16550a as a fallback so the driver can distinguish the Loongson-2=
K3000 UART
> > > > from earlier Loongson UARTs that require MCR/MSR signal inversion.
> > > >
> > > > > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b=
/Documentation/devicetree/bindings/serial/8250.yaml
> > > > > index 01abd39509a7a..33c13c48ed56e 100644
> > > > > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > > > > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > > > > @@ -196,6 +196,9 @@ properties:
> > > > >                 - loongson,ls2k2000-uart
> > > > >             - const: loongson,ls2k1500-uart
> > > > >             - const: ns16550a
> > > > > +      - items:
> > > > > +          - const: loongson,ls2k3000-uart
> > > > > +          - const: ns16550a
> > > >
> > > > [Severity: Low]
> > > > This isn't a bug, but properties:compatible in
> > > > Documentation/devicetree/bindings/serial/8250.yaml already has a tw=
o-item
> > > > block with const: ns16550a as the fallback that includes the other =
base
> > > > Loongson UART compatibles:
> > > >
> > > >        - items:
> > > >            - enum:
> > > >                ...
> > > >                - loongson,ls2k0500-uart
> > > >                - loongson,ls2k1500-uart
> > > >            - const: ns16550a
> > > >
> > > > Could loongson,ls2k3000-uart be added to that existing enum instead=
 of adding
> > > > a separate two-item block?
> >
> > Let me briefly explain why Loongson UART `compatible` is necessary at t=
his
> > time.
> > First, as described in the driver, each `compatible` type defines diffe=
rent
> > driver data:
> > struct loongson_uart_ddata {
> >         bool has_frac;
> >         u8 mcr_invert;
> >         u8 msr_invert;
> > };
> > Since the Loongson-2k3000 has already fixed the hardware issues with
> > mcr/msr, we need a new `compatible` to correspond to the updated
> > `driver_data`.
> >
> > static const struct loongson_uart_ddata ls2k3000_uart_data =3D {
> >         .has_frac =3D true,
> >         .mcr_invert =3D 0,
> >         .msr_invert =3D 0,
> > };
> >
> > As for why a fallback to `ns16550a` is required in all cases, the DTS f=
iles
> > for the Loongson-2K1000 and similar devices were merged into the reposi=
tory
> > before `8250_loongson.c`, and this approach was used at the time to mai=
ntain
> > compatibility[1].
>
> No one is questioning what the compatibles are, just where you add the
> new schema entry. Use the existing one with the ns16550a fallback
> instead of a new oneOf entry:
>
>       - items:
>           - enum:
>               - altr,16550-FIFO32
>               - altr,16550-FIFO64
>               - altr,16550-FIFO128
>               - fsl,16550-FIFO64
>               - andestech,uart16550
>               - nxp,lpc1850-uart
>               - opencores,uart16550-rtlsvn105
>               - ti,da830-uart
>               - loongson,ls2k0500-uart
>               - loongson,ls2k1500-uart
>           - const: ns16550a

I=E2=80=99m very sorry; I misunderstood earlier. Also, after further
discussion with the hardware engineers, I discovered that the
Loongson-2K0300 should fallback to the Loongson-2K3000.

I will revise the patch.


>
> Rob



--=20
Thanks.
Binbin
