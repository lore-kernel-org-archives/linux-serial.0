Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0AC1F94A;
	Sun,  4 Aug 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722762856; cv=none; b=LwlqDnggIOg5xwIIeFhZM/sf4wh2CCQIA7E7wGcn3IG9aY2UtWDMYFIHsOC3AmylGeSIL8vFfT91I0oc/klzjWFETUn/MKJ/SMqhLej88eiXorRX2Hlcs0nv0xUZFn/gL9hy63nVHwRCgSEG6KqZ058YxstD4iLNMnHhUq+Zzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722762856; c=relaxed/simple;
	bh=Tsv1Zf8TZmbR1ofzjrLs16xA1rHFmbB/wMkp2gb68VE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g6K+3yNtYRjk/X71Je2BFln/WWFkTiiMMdwFWT1vkYSoIHk5/c2OXbney49dj0so95kNv67xGuhQ/12JA2I8BvFSa9qUnkJoKG/ONJeH0LG9K2zFoxHN2HFHOzln4Th3jYgV6VJHVpCFWHpjS3LXBvjF0eS7WtLaZyJFCDgfrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW5pehCa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW5pehCa"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso106048181fa.3;
        Sun, 04 Aug 2024 02:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722762852; x=1723367652; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8xhaK+HKr8txiVLN5oIG6mLd/CNIxGQ/Xronjna7FY=;
        b=SW5pehCa9ytWVtCBqT3jSzY5jfKrP0+ZwnhtknG/662aZwxyliO2Tt2pDRYE9a08XK
         /17VpEsZ+CuGMdgLZet5/cbb0oROzavCVV8CaI3o0NTpl6MJvhPESiafH9JtfjFM+sDZ
         8DXY9Hdd78LmQhBFqlnAr/33Sh+hq+diBIT7rm0Zqb5dXU9zShRYSZNcER2Ay6RUqYy/
         MZi+MQHbKvWKC0ZBSDX36200F2sP/7OTuV6P2PcogHrAkMOo6/sZjiQa30RPxIoW+5nQ
         ykpCuTHJpo6vnC/VkFnwDVxrjB6UZdBSY6y9ZlyubQy4rnA6N6l5GxMWp/KovqqCl0oC
         Nkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722762852; x=1723367652;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8xhaK+HKr8txiVLN5oIG6mLd/CNIxGQ/Xronjna7FY=;
        b=mPdiwnEgesXYOlPVsdRzZi2z5aKCs2b7UBMX1noJifEGMQ0VisIh0RsGtajWGSs0aI
         gIh12NqHs6lVqLvz4mk8ouDcRMWWUxXBocivKLsCI23j3x9Drz92G97j2Zq7x5Om16sp
         hkMtzOaGNHd5MVi770MiYA4g2mg3mwRK7ir/T2zgl1hbDEtVm0AtjjnURayVE0WG/3nb
         DPqRDy8uq3dJ2xFl02HlOAjemdSodSVNk4WqrWVaSz+Qaksj/EhhXFEgz11BoTfc9bZL
         Bsti8MN5ZdyIHswD+HV3zqKl7eW6Sgf5QFXrKlzZaWpbK003Z40JUr6a4QnQd8SDMTLs
         JRyw==
X-Forwarded-Encrypted: i=1; AJvYcCXxldpHGW2EcWTb8PYVzbluKPXVusC5DvpSlMC73tJSPOfc1cTLouF1lBFfpQi8kbXfT6rqToiDootuUo8gEDhxstLcWPB/+ErdqYDKtTYiRD4bQwzvXCRIo6658G+vCfRenwsd7gjjox+ihldu264kwOwFK54YZ5TCTiBbRpmu5PiIq2TSMw==
X-Gm-Message-State: AOJu0YzAPoYmKGBirB2RvnR1OPAwsJEy/TPIQiedPy7WmmPU798iPosq
	cm3y/K4Xx8XakyroWIRrE8REWEHFgyCnWdJOLqnn+520D6GEMpwg
X-Google-Smtp-Source: AGHT+IGyj5V/OyfV2RPE4TLntui3QqyFRdRf2CycS7NXzrsfltpIxE6G4LIrujK/h4qDZiDBxzPkuA==
X-Received: by 2002:a2e:8456:0:b0:2ef:286e:ca68 with SMTP id 38308e7fff4ca-2f15aac2b49mr53430811fa.23.1722762851736;
        Sun, 04 Aug 2024 02:14:11 -0700 (PDT)
Received: from smtpclient.apple (84-10-100-139.static.chello.pl. [84.10.100.139])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1c7581sm6843141fa.68.2024.08.04.02.14.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2024 02:14:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH 0/4] Add initial support for Rockchip RK3528 SoC
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <Zq8eJB7zqOvYQvmw@ziyaolaptop.my.domain>
Date: Sun, 4 Aug 2024 11:13:59 +0200
Cc: Dragan Simic <dsimic@manjaro.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Tim Lunn <tim@feathertop.org>,
 Andy Yan <andyshrk@163.com>,
 Muhammed Efe Cetin <efectn@protonmail.com>,
 Jagan Teki <jagan@edgeble.ai>,
 Ondrej Jirman <megi@xff.cz>,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3EA59A56-C6E5-40B7-A5C4-C280B001E981@gmail.com>
References: <20240803125510.4699-2-ziyao@disroot.org>
 <0c77f99f4af96807a2a8c3028e3c1d4d@manjaro.org>
 <Zq8eJB7zqOvYQvmw@ziyaolaptop.my.domain>
To: Yao Zi <ziyao@disroot.org>
X-Mailer: Apple Mail (2.3774.600.62)



> Wiadomo=C5=9B=C4=87 napisana przez Yao Zi <ziyao@disroot.org> w dniu =
04.08.2024, o godz. 08:22:
>=20
> On Sun, Aug 04, 2024 at 07:40:43AM +0200, Dragan Simic wrote:
>> Hello all,
>>=20
>> On 2024-08-03 14:55, Yao Zi wrote:
>>> Rockchip RK3528 is a quad-core ARM Cortex-A53 SoC designed for
>>> multimedia application. This series add a basic device tree with =
CPU,
>>> interrupts and UART nodes for it and is able to boot into a kernel =
with
>>> only UART console.
>>>=20
>>> Has been tested on Radxa E20C board[1] with vendor U-boot, =
successfully
>>> booted into initramfs with this log[2].
>>=20
>> I wonder will at least the RK3528 datasheet become available =
publicly?
>=20
> I found none for now, and I am not someone from Rockchip, thus don't
> know whether they have a plan to make it public, either. But there has
> been some devices shipping it already and getting them mainlined will
> be a neat thing.
>=20

Maybe this hight be useful: at some point in time I started to hack with =
rk3528 support in mainline kernel.
HW I=E2=80=99m using is vontar rk3528 tvbox.

So far - on mainline 6.10 kernel - I got working: clocks, pin control, =
uart, sdcard, eth, usb.

I started to work on dw hdmi and got to stage with correct mode sets by =
dw-hdmi but I stuck with vop3 support.

Generally - I was back porting code from bsp but rockchip bsp is too =
divergent from mainline to my back porting skills :-(

If anybody can help with vop3 - then we can have quite good initial =
support of rk3528 in mainline (the, sdcard, usb, eth, hdmi)
gpu, hdmi audio should be probably easy=E2=80=A6

My rk3528 enablements:

Bindings: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1100-dt-bindings-clock-add-rk3528-clock-definitions.patch

Clocks: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1101-clk-rockchip-add-clock-controller-for-the-RK3528.patch

Pincontrol: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1102-pinctrl-rockchip-add-rk3528-support.patch

Power domain bindings: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1103-dt-bindings-power-add-RK3528-SoCs-header-for-idle.patch

Ethernet support: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1104-ethernet-stmmac-dwmac-rk3528-add-GMAC-support.patch

Power domains support: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1105-soc-rockchip-power-domain-add-rk3528-support.patch

usb: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1106-phy-rockchip-inno-usb2-add-phy-support-for-rk3528.patch

SoC power domains: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1108-soc-rockchip-power-domain-add-rk3528-support.patch

Thermal: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1108-thermal-rockchip-add-support-for-rk3528.patch

Naneng phy: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1109-phy-rockchip-naneng-combphy-add-support-for-rk3528.patch

dw hdmi: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1110-phy-rockchip-inno-hdmi-add-support-for-rk3528.patch

Inno hdmi: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1111-drm-rockchip-dw_hdmi-add-support-for-rk3528.patch       Nvmem: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1113-nvmem-rockchip-otp-add-support-for-rk3528.patch

Sound soc: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1114-sound-soc-codecs-add-rk3528-support.patch

rk3528 dtsi: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1150-arm64-dtsi-rockchip-add-3528.dtsi.patch:=20

Vontar tvbox dts: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/f=
iles/1151-arm64-dts-rockchip-add-dts-for-vontar_r3.patch

It may happen that above patches will not apply clean on vanilla 6.10 as =
I=E2=80=99m patching kernel for =
s905/s912/sm1/g12/rpi3/rpi4/rpi5/3328/3399//3566/3568/3588/3528 and =
rk3528 patches are after applied =
s905/s912/sm1/g12/rpi3/rpi4/rpi5/3328/3399/3566/3568/3588 patches.

If anybody is interested in adding vop3 support - pls give me sign - we =
can work together=E2=80=A6
=20

> Just FYI, the vendor kernel is available here[1] on the "develop-5.10"
> branch.
>=20
> Best regards,
> Yao Zi
>=20
> [1]: https://github.com/rockchip-linux/kernel
>=20
>>=20
>>> [1]: https://docs.radxa.com/en/e/e20c
>>> [2]: =
https://gist.github.com/ziyao233/b74523a1e3e8bf36286a572e008ca319
>>>=20
>>> Yao Zi (4):
>>>  dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528
>>>  dt-bindings: arm: rockchip: Add Radxa E20C board
>>>  arm64: dts: rockchip: Add base DT for rk3528 SoC
>>>  arm64: dts: rockchip: Add Radxa e20c board
>>>=20
>>> .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>>> .../bindings/serial/snps-dw-apb-uart.yaml     |   1 +
>>> arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>> .../boot/dts/rockchip/rk3528-radxa-e20c.dts   |  22 +++
>>> arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 182 =
++++++++++++++++++
>>> 5 files changed, 211 insertions(+)
>>> create mode 100644 =
arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
>>> create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>>=20
>>>=20
>>> base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

