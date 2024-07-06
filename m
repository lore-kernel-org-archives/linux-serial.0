Received: from lf-2-32.ptr.blmpb.com (lf-2-32.ptr.blmpb.com [101.36.218.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339E2B9B7
	for <linux-serial@vger.kernel.org>; Sat,  6 Jul 2024 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720253065; cv=none; b=l7P1pH1Tb4ln+81ep33sES8DOkVVHDplwWpIOa6ioynr0if8iexNgjwwyUpue4CQ0rVYQqz7LbsvM+Z4Hk9sEtdiu3OlZqKXh/shWkHh5S07KiQCxTG0B7UOsZKu1cJVJYHXR60WaiM8kpXeGGye/h2euebX5R1xlQ65ApV6huM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720253065; c=relaxed/simple;
	bh=YwRsSs/oKAKDshInedUrk2wajjIOyuTY+S2UpWMr3Fw=;
	h=References:Content-Type:Subject:Mime-Version:Cc:From:In-Reply-To:
	 Date:Message-Id:To; b=QSkHtYk2+x9BGw782vDwaFunkChp5AQnDLzzeaEaGJLHF470Jxs9ImctasOOGJ7w9lAHrTusL3qTgk3/d7ojRvkMRxXxRHdzVKploiJK9W9d5l+BRDvqm6a8nyPvpVHkuCrhBRukE/7bMVy7tdqIL9TlQadGc5PbizAUJMXci28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=y1dhAhUa; arc=none smtp.client-ip=101.36.218.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="y1dhAhUa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1720252978; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YwRsSs/oKAKDshInedUrk2wajjIOyuTY+S2UpWMr3Fw=;
 b=y1dhAhUaCr6Em1kMgXSo6szlHwAd7BOf2ONI2Ex+GjWbZ218kHedtJPS4qaN4tGU+D/PrC
 UmDE2iHSIjPlVQ0y8JOcvH+smNAhVaYy9wBDs9eAp3KryHPtJwpfUad6dmyeCLfLx6hbf8
 EcFmYcOaVIbr6iSFoe4okOQxlnIhmugmlXpQzeJ/USJAXGMcv0Rxb1e/15yMAJaeW3QF2C
 RYAlCx1BZXXwqaq3eF2S6ulD5YJtHksR8dL/xp1zcVKH3JoYKd6XyvEISffGA2L/FLR9Hq
 qSb8Wyg1EKBXBYh5loiDze/DeVISd7VBIW+RGXxRA/IahXxyqM7KpyrLzqwW2g==
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org> <20240703-k1-01-basic-dt-v3-6-12f73b47461e@gentoo.org> <ZoarsYMNJRu1-_wn@xhacker>
	<20240705064721.GB3042186@ofsar>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v3 06/11] dt-bindings: serial: 8250: Add SpacemiT K1 uart compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16688fa31+ca3f8a+vger.kernel.org+zhangmeng.kevin@spacemit.com>
Cc: "Jisheng Zhang" <jszhang@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, "Conor Dooley" <conor@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, 
	"Daniel Lezcano" <daniel.lezcano@linaro.org>, 
	"Thomas Gleixner" <tglx@linutronix.de>, 
	"Samuel Holland" <samuel.holland@sifive.com>, 
	"Anup Patel" <anup@brainfault.org>, 
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, "Lubomir Rintel" <lkundrak@v3.sk>, 
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Yangyu Chen" <cyy@cyyself.name>, 
	"Conor Dooley" <conor.dooley@microchip.com>, 
	"Inochi Amaoto" <inochiama@outlook.com>, <linux-serial@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>
From: =?utf-8?q?=E5=BC=A0=E7=8C=9B?= <zhangmeng.kevin@spacemit.com>
In-Reply-To: <20240705064721.GB3042186@ofsar>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jul 2024 16:02:57 +0800
Message-Id: <21b192b47649688e2400e3968e28905bba186d51.42926de8.32d7.41ea.b98f.6e2edb5e6c5a@feishu.cn>
To: "Yixun Lan" <dlan@gentoo.org>


> From: "Yixun Lan"<dlan@gentoo.org>
> Date:=C2=A0 Fri, Jul 5, 2024, 14:47
> Subject:=C2=A0 Re: [PATCH v3 06/11] dt-bindings: serial: 8250: Add Spacem=
iT K1 uart compatible
> To: "Jisheng Zhang"<jszhang@kernel.org>
> Cc: "Rob Herring"<robh@kernel.org>, "Krzysztof Kozlowski"<krzk+dt@kernel.=
org>, "Conor Dooley"<conor+dt@kernel.org>, "Conor Dooley"<conor@kernel.org>=
, "Paul Walmsley"<paul.walmsley@sifive.com>, "Palmer Dabbelt"<palmer@dabbel=
t.com>, "Albert Ou"<aou@eecs.berkeley.edu>, "Daniel Lezcano"<daniel.lezcano=
@linaro.org>, "Thomas Gleixner"<tglx@linutronix.de>, "Samuel Holland"<samue=
l.holland@sifive.com>, "Anup Patel"<anup@brainfault.org>, "Greg Kroah-Hartm=
an"<gregkh@linuxfoundation.org>, "Jiri Slaby"<jirislaby@kernel.org>, "Lubom=
ir Rintel"<lkundrak@v3.sk>, <devicetree@vger.kernel.org>, <linux-kernel@vge=
r.kernel.org>, "Yangyu Chen"<cyy@cyyself.name>, "Conor Dooley"<conor.dooley=
@microchip.com>, "Inochi Amaoto"<inochiama@outlook.com>, <linux-serial@vger=
.kernel.org>, <linux-riscv@lists.infradead.org>, "Meng Zhang"<zhangmeng.kev=
in@spacemit.com>
> On 22:03 Thu 04 Jul =C2=A0 =C2=A0 , Jisheng Zhang wrote:
> > On Wed, Jul 03, 2024 at 02:55:09PM +0000, Yixun Lan wrote:
> > > Found SpacemiT's K1 uart controller is compatible with
> > > Intel's Xscale uart, but it's still worth to introduce a new compatib=
le.
> >=C2=A0
> > Per vendor's kernel source code, all the uarts support 64Bytes FIFO.
> > So if it's compatible with Xscale, it's a xscale uart 64 Bytes FIFO.
> yes, I agree
>=C2=A0
> further question would how to implement specific support for spacemit's k=
1 SoC
> one possible option to add a PORT_SPACEMIT compatible data to 8250_port.c=
 - uart_config[]
>=C2=A0
>=C2=A0
> > >From this PoV, the uart isn't a Xscale but a mrvl pxa.
> see my previous comment, probably need further clarification/investigatio=
n..
>=C2=A0
> >=C2=A0
> > But I have one question: is the uart really a mrvl/intel pxa uart? or i=
s just
> No, I'm unable to answer this, I'm not an employee of SpacemiT
> All informations are based on public available source + docs..
>=C2=A0
> > reg programming compatible with pxa?
> >=C2=A0
> To my knowledge, it's compatible with pxa, but it would be great that ven=
dor can clarify this
Yes, the programming model is compatible with pxa.
>=C2=A0
> > >=C2=A0
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > > ---
> > >=C2=A0 Documentation/devicetree/bindings/serial/8250.yaml | 4 +++-
> > >=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)
> > >=C2=A0
> > > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Doc=
umentation/devicetree/bindings/serial/8250.yaml
> > > index 692aa05500fd5..0bde2379e8647 100644
> > > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > > @@ -111,7 +111,9 @@ properties:
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 - mediatek,mt7=
623-btif
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 - const: mediatek,mtk-btif
> > > =C2=A0 =C2=A0 =C2=A0=C2=A0 - items:
> > > - =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 - const: mrvl,mmp-uart
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 - enum:
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 - mrvl,mmp-uart
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 - spacemit,k1-uart
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 - const: intel,xscale-uart
> > > =C2=A0 =C2=A0 =C2=A0=C2=A0 - items:
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 - enum:
> > >=C2=A0
> > > --=C2=A0
> > > 2.45.2
> > >=C2=A0
> > >=C2=A0
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>=C2=A0
> --=C2=A0
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55


This message and any attachment are confidential and may be privileged or o=
therwise protected from disclosure. If you are not an intended recipient of=
 this message, please delete it and any attachment from your system and not=
ify the sender immediately by reply e-mail. Unintended recipients should no=
t use, copy, disclose or take any action based on this message or any infor=
mation contained in this message. Emails cannot be guaranteed to be secure =
or error free as they can be intercepted, amended, lost or destroyed, and y=
ou should take full responsibility for security checking.=20
=20
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=E9=99=84=E4=
=BB=B6=E5=85=B7=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=B9=
=B6=E5=8F=AF=E8=83=BD=E5=8F=97=E5=85=B6=E4=BB=96=E4=BF=9D=E6=8A=A4=E6=88=96=
=E4=B8=8D=E5=85=81=E8=AE=B8=E8=A2=AB=E6=8A=AB=E9=9C=B2=E7=BB=99=E7=AC=AC=E4=
=B8=89=E6=96=B9=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E8=AF=AF=E6=94=B6=E5=88=
=B0=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E6=95=AC=E8=AF=B7=E7=AB=8B=E5=8D=B3=
=E4=BB=A5=E5=9B=9E=E5=A4=8D=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=E6=
=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=8C=E5=B9=
=B6=E5=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=
=E9=99=84=E4=BB=B6=E4=BB=8E=E9=98=81=E4=B8=8B=E7=B3=BB=E7=BB=9F=E4=B8=AD=E4=
=BA=88=E4=BB=A5=E5=88=A0=E9=99=A4=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E5=B9=
=B6=E9=9D=9E=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=86=99=E6=98=8E=E4=B9=8B=E6=94=B6=
=E4=BB=B6=E4=BA=BA=EF=BC=8C=E6=95=AC=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BD=BF=E7=
=94=A8=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=
=AE=E4=BB=B6=E6=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=8C=
=E4=BA=A6=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BE=9D=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E8=80=8C=E9=87=87=E5=8F=
=96=E4=BB=BB=E4=BD=95=E8=A1=8C=E5=8A=A8=E3=80=82=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E6=97=A0=E6=B3=95=E4=BF=9D=E8=AF=81=E6=98=AF=E4=B8=80=E7=A7=8D=E5=
=AE=89=E5=85=A8=E5=92=8C=E4=B8=8D=E4=BC=9A=E5=87=BA=E7=8E=B0=E4=BB=BB=E4=BD=
=95=E5=B7=AE=E9=94=99=E7=9A=84=E9=80=9A=E4=BF=A1=E6=96=B9=E5=BC=8F=EF=BC=8C=
=E5=8F=AF=E8=83=BD=E4=BC=9A=E8=A2=AB=E6=8B=A6=E6=88=AA=E3=80=81=E4=BF=AE=E6=
=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E6=88=96=E6=8D=9F=E5=9D=8F=EF=BC=8C=E6=94=
=B6=E4=BB=B6=E4=BA=BA=E9=9C=80=E8=87=AA=E8=A1=8C=E8=B4=9F=E8=B4=A3=E5=81=9A=
=E5=A5=BD=E5=AE=89=E5=85=A8=E6=A3=80=E6=9F=A5=E3=80=82
