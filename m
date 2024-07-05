Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA45143C6C;
	Fri,  5 Jul 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161009; cv=none; b=JqIKxTF/enLd26tZD+Tflh4VUoF37CAOIiTcQJGBDu4RB3VNTdzlubsnZVltM2TZSBXuTq7iwlhElRJRr1osVKDr8isuYly/INMa3R0eUpTK0N0riAMPg9AmLS3s7DPSlrxlFP5D0w2PQhd/HGt44xrXSub+kL/YR1IMpAwpD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161009; c=relaxed/simple;
	bh=izJ3y+NkTJsJ80bDCgRyTE8U6iYt3auKIsi7LoIzQKc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbC3IzwZpnD4PonlGKAqkW9pG/zMFyOzRwHw74akaVa+HWUYCTPmnj5gNImNdghltFK636Webz/06SbLr8iWrTkw0uK7dZWYrCao01x/5ygKTwA2a8iDHm8UqGAQH/CKNN6o1DP1mvwIJzH341FLg7RSoYviN6G9Mmo7o65cIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZQA68Ysd; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZQA68Ysd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720161008; x=1751697008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izJ3y+NkTJsJ80bDCgRyTE8U6iYt3auKIsi7LoIzQKc=;
  b=ZQA68Ysd5tenckhsS/PSFuZhs38iJbQmMQJIHwIPBRUHeV/114xmgmqO
   hnh/zwkNDT5KJPs7zneK4ektOfv/X17nd9HWXO3zrJmmQr+1095ooSfce
   RNRx20UtAh0u+iTlMPCjQM99yN+cOqESnaIFPKPfvY2uI83gseh34L+2Q
   +/T4SJfFKZWcDwA2H2tm8AZO3LABQaoqqdUQU1GXH2EEOEBEusaN5wESv
   9/B3nGxQ3R3oHYzJXMDhvm0ye7OkZcD/Z6LAEVPm+vBPddN0X2gmb2bGv
   YPXG5PrhxoFQqjL6+xSAB0o2BduzaB7eBNGzVN1HqnS/D5YCr2airVnvN
   g==;
X-CSE-ConnectionGUID: gdsRTikOT2O4QUp3P+IObg==
X-CSE-MsgGUID: lqjWRQYaSmmt33bLQNGuLA==
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="asc'?scan'208";a="28877280"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 23:30:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 23:29:23 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 4 Jul 2024 23:29:19 -0700
Date: Fri, 5 Jul 2024 07:28:58 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: =?utf-8?B?5byg54yb?= <zhangmeng.kevin@spacemit.com>
CC: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conor
 Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-serial@vger.kernel.org>, Inochi
 Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, Yangyu Chen
	<cyy@cyyself.name>
Subject: Re: [PATCH v3 08/11] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <20240705-moneybags-showpiece-a21262d4e2aa@wendy>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-8-12f73b47461e@gentoo.org>
 <21b192b47649688e2400e3968e28905bba186d51.f11b05e2.052c.43d9.be00.bc0a5da97b9c@feishu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r5FHo/hUFI/U0wLN"
Content-Disposition: inline
In-Reply-To: <21b192b47649688e2400e3968e28905bba186d51.f11b05e2.052c.43d9.be00.bc0a5da97b9c@feishu.cn>

--r5FHo/hUFI/U0wLN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 01:55:43PM +0800, =E5=BC=A0=E7=8C=9B wrote:

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0 riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond=
_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpm=
f_sstc_svinval_svnapot_svpbmt";
> Linux 6.7 kernel modifies the definition of the "riscv, isa" property, an=
d describes the extended features in the "riscv, isa-extensions". So, can t=
he definition of "riscv, isa" be simplified here?
> Defined as =EF=BC=9A=C2=A0 riscv,isa =3D "rv64imafdcv";

No, they should match, other than vendor extensions. Not every project
supports the new property.

> This message and any attachment are confidential and may be privileged or=
 otherwise protected from disclosure. If you are not an intended recipient =
of this message, please delete it and any attachment from your system and n=
otify the sender immediately by reply e-mail. Unintended recipients should =
not use, copy, disclose or take any action based on this message or any inf=
ormation contained in this message. Emails cannot be guaranteed to be secur=
e or error free as they can be intercepted, amended, lost or destroyed, and=
 you should take full responsibility for security checking.=20
> =20
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=E9=99=84=
=E4=BB=B6=E5=85=B7=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=
=B9=B6=E5=8F=AF=E8=83=BD=E5=8F=97=E5=85=B6=E4=BB=96=E4=BF=9D=E6=8A=A4=E6=88=
=96=E4=B8=8D=E5=85=81=E8=AE=B8=E8=A2=AB=E6=8A=AB=E9=9C=B2=E7=BB=99=E7=AC=AC=
=E4=B8=89=E6=96=B9=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E8=AF=AF=E6=94=B6=E5=
=88=B0=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E6=95=AC=E8=AF=B7=E7=AB=8B=E5=8D=
=B3=E4=BB=A5=E5=9B=9E=E5=A4=8D=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=
=E6=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=8C=E5=
=B9=B6=E5=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=
=95=E9=99=84=E4=BB=B6=E4=BB=8E=E9=98=81=E4=B8=8B=E7=B3=BB=E7=BB=9F=E4=B8=AD=
=E4=BA=88=E4=BB=A5=E5=88=A0=E9=99=A4=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E5=
=B9=B6=E9=9D=9E=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=86=99=E6=98=8E=E4=B9=8B=E6=94=
=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E6=95=AC=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BD=BF=
=E7=94=A8=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E6=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=
=8C=E4=BA=A6=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BE=9D=E6=9C=AC=E9=82=AE=E4=BB=B6=
=E6=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E8=80=8C=E9=87=87=E5=
=8F=96=E4=BB=BB=E4=BD=95=E8=A1=8C=E5=8A=A8=E3=80=82=E7=94=B5=E5=AD=90=E9=82=
=AE=E4=BB=B6=E6=97=A0=E6=B3=95=E4=BF=9D=E8=AF=81=E6=98=AF=E4=B8=80=E7=A7=8D=
=E5=AE=89=E5=85=A8=E5=92=8C=E4=B8=8D=E4=BC=9A=E5=87=BA=E7=8E=B0=E4=BB=BB=E4=
=BD=95=E5=B7=AE=E9=94=99=E7=9A=84=E9=80=9A=E4=BF=A1=E6=96=B9=E5=BC=8F=EF=BC=
=8C=E5=8F=AF=E8=83=BD=E4=BC=9A=E8=A2=AB=E6=8B=A6=E6=88=AA=E3=80=81=E4=BF=AE=
=E6=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E6=88=96=E6=8D=9F=E5=9D=8F=EF=BC=8C=E6=
=94=B6=E4=BB=B6=E4=BA=BA=E9=9C=80=E8=87=AA=E8=A1=8C=E8=B4=9F=E8=B4=A3=E5=81=
=9A=E5=A5=BD=E5=AE=89=E5=85=A8=E6=A3=80=E6=9F=A5=E3=80=82

Please fix your mail client/system to not append this. Such footers are
incompatible with kernel development.

Thanks,
Conor.

--r5FHo/hUFI/U0wLN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoeSmgAKCRB4tDGHoIJi
0sF4AQDCX4JI0M03jibGYAqEQ7wU9mHU2p/KBPLAZdO4LNHmkwD/W7rLzQrOADWi
aweZNUwFUrpe1QE1vQc/UoM1xw3llAU=
=GiR5
-----END PGP SIGNATURE-----

--r5FHo/hUFI/U0wLN--
