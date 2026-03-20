Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E4E395DB5;
	Fri, 20 Mar 2026 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010292; cv=pass; b=XpQQasN+q5/iaQmUyHlzUENaRSVH4FdPIKNsmuRbWnF7WwtxXutQQR7fdDLEtHKmk2cv3sVCKjpOO2tBn0/EoLPfqEnmrJEb5LlRx9Atmuer0AwM6QzCvQoO2BFHyL1W1ZmpnSV2xhnbPfdMu6Ihwxf9C6XixpWqLC2eGhPT/Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010292; c=relaxed/simple;
	bh=wV2XOk1Kz9d3NznBjwLCj2478PRXmrJLh622XGggBls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t2RIBBHnK/QKJR5QBSfWd/UokJeRW65xhUXmY8RT+bMEJGoNR2M/qr1csshNNfGyp5vFoGm7PndNkSOJfY2GbvHzy3IPu82hXfe6zGDEZVTWp3j7ED4H9kLZ7hJTcH7a5s9LFnJO+1we4kvWq+J7G818mGQqflwJQYQ8Qx7FL7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=RMZiiDIu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="RMZiiDIu"
ARC-Seal: i=1; a=rsa-sha256; t=1774010260; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IT1X9lb4WgUGJ3f4XpNl+vAjgAOPfWmZtyaaQKBpOo2bNLHnO9li7xmwGPEbed71lTevrox//bZlixs9FBN984eFZczlLYEM4WIULVmra1p5kiJbeAzfeyaR3+9EpM0+dc1mexIHEIAzsE50Y8+8xHLrb5luj3cIqEG8eGjs9mI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774010260; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eqvJd/tLOchy3iTRcrdUAE7UOOBzOUBXPqr7730FrsU=; 
	b=Tsh96p4MSAWs8lU7Vew0vYe69xpMVDUqTfLNPkQxKXS7edfUihiwAkVxJsh6V2PjjTIFmHWRckkaLg3KPfr2zN/wj6TGiLnVmVVE3OEwGJpeGVr0bM3yUl2z+AMzLlmilxMkVicIdJ8D63CkdTyYkufWFK4xto01O3+6AAcgmkY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774010260;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=eqvJd/tLOchy3iTRcrdUAE7UOOBzOUBXPqr7730FrsU=;
	b=RMZiiDIujKB48XWmRkT8/L3xbYeJXdVQivCo4d7Qs0QuywxwSHnMQR7y/b0N3xrR
	b9y6YbIP2cjgyLxJurJpjJI/qT5PPCyiSKM9WMUe5/C1Pp8JlZ7laavjWFqnWiFkAab
	CZPFmG7wrmgmXQjUjPqdC844jhQy+mmiq2f4tV/s=
Received: by mx.zohomail.com with SMTPS id 1774010258810384.6051275065198;
	Fri, 20 Mar 2026 05:37:38 -0700 (PDT)
Message-ID: <7d1e52c0b9c3a6d30e9db617b9bcfa23ed9046b5.camel@collabora.com>
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: add device-tree for Genio
 720-EVK board
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: David Lechner <dlechner@baylibre.com>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob
 Herring	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean
 Wang <sean.wang@mediatek.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Date: Fri, 20 Mar 2026 13:37:33 +0100
In-Reply-To: <c2618423-2466-47bb-a8cf-7c849e7e231e@baylibre.com>
References: 
	<20251203-add-mediatek-genio-520-720-evk-v1-0-df794b2a30ae@collabora.com>
	 <20251203-add-mediatek-genio-520-720-evk-v1-3-df794b2a30ae@collabora.com>
	 <c2618423-2466-47bb-a8cf-7c849e7e231e@baylibre.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi David,

On Thu, 2026-03-12 at 19:26 -0500, David Lechner wrote:
> On 12/3/25 7:59 AM, Louis-Alexis Eyraud wrote:
> > Add support for MediaTek MT8189 SoC and its variants, and a device-
> > tree
> > for the basic hardware enablement of the Genio 720-EVK board, based
> > on
> > MT8391 SoC.
> >=20
>=20
> ...
>=20
> > +	mmc0_default_pins: mmc0-default-pins {
> > +		pins-clk {
> > +			pinmux =3D <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
> > +			drive-strength =3D <6>;
> > +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> > +		};
> > +
> > +		pins-cmd-dat {
> > +			pinmux =3D
> > <PINMUX_GPIO166__FUNC_MSDC0_DAT0>,
> > +			=09
> > <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
> > +			=09
> > <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
> > +			=09
> > <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
> > +			=09
> > <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
> > +			=09
> > <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
> > +			=09
> > <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
> > +			=09
> > <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
> > +				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>;
> > +			input-enable;
> > +			drive-strength =3D <6>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> > +		};
>=20
> Should we also have pins-ds here to match mmc0-uhs-pins?
>=20
The data strobe pin is only used for the HS modes, that is why it is
only declared for uhs state.
No other mediatek board devicetrees have it for default state too, so I
don't think it is needed here.

> > +
> > +		pins-rst {
> > +			pinmux =3D
> > <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
> > +			drive-strength =3D <6>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_00>;
> > +		};
> > +	};
> > +
> > +	mmc0_uhs_pins: mmc0-uhs-pins {
> > +		pins-clk {
> > +			pinmux =3D <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
> > +			drive-strength =3D <8>;
> > +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> > +		};
> > +
> > +		pins-cmd-dat {
> > +			pinmux =3D
> > <PINMUX_GPIO166__FUNC_MSDC0_DAT0>,
> > +			=09
> > <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
> > +			=09
> > <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
> > +			=09
> > <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
> > +			=09
> > <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
> > +			=09
> > <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
> > +			=09
> > <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
> > +			=09
> > <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
> > +				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>;
> > +			input-enable;
> > +			drive-strength =3D <8>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> > +		};
> > +
> > +		pins-ds {
> > +			pinmux =3D <PINMUX_GPIO167__FUNC_MSDC0_DSL>;
> > +			drive-strength =3D <8>;
> > +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> > +		};
> > +
> > +		pins-rst {
> > +			pinmux =3D
> > <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_00>;
> > +		};
> > +	};
> > +
> > +	mmc1_default_pins: mmc1-default-pins {
> > +		pins-clk {
> > +			pinmux =3D <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
> > +			drive-strength =3D <6>;
> > +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> > +		};
> > +
> > +		pins-cmd-dat {
> > +			pinmux =3D
> > <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
> > +			=09
> > <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
> > +			=09
> > <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
> > +			=09
> > <PINMUX_GPIO173__FUNC_MSDC1_DAT3>,
> > +				 <PINMUX_GPIO168__FUNC_MSDC1_CMD>;
> > +			input-enable;
> > +			drive-strength =3D <6>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> > +		};
> > +
> > +		pins-insert {
> > +			pinmux =3D <PINMUX_GPIO2__FUNC_GPIO2>;
> > +			bias-pull-up;
> > +		};
> > +	};
> > +
> > +	mmc1_uhs_pins: mmc1-uhs-pins {
> > +		pins-clk {
> > +			pinmux =3D <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
> > +			drive-strength =3D <8>;
> > +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> > +		};
> > +
> > +		pins-cmd-dat {
> > +			pinmux =3D
> > <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
> > +			=09
> > <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
> > +			=09
> > <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
> > +			=09
> > <PINMUX_GPIO173__FUNC_MSDC1_DAT3>,
> > +				 <PINMUX_GPIO168__FUNC_MSDC1_CMD>;
> > +			input-enable;
> > +			drive-strength =3D <8>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> > +		};
>=20
> Don't we also need pins-insert here? (to match mmc1-default-pins)
>=20
From what I've found, it was done this way for other board devicetrees
to avoid possible reconfiguration happen for the card detection pin
while switching to UHS and causing a switch failure.
Also, what you declare in pinmux nodes is how the pin configuration
should change in a specific mode and you declare only what changes, and
not what stay the same.

> I was having trouble with the CD input pin not working in U-Boot
> until I added it.
I checked and debugged this on my board and did not get that kind of
issue, whether this pin config is not present for uhs state or if I add
it.=20
When inserting my sd card or when I boot with it already inserted, the
mtk-sd driver first sets the pinctrl state to default before switching
to ufs. The GPIO02 pin config is also OK in both states.
The mt8189 pinctrl driver seems to apply a default config for this pin
that is the same as the one that is set here.

There might be u-boot particularities that could explain it fixes your
issue.

Regards,
Louis-Alexis
>=20
> > +	};
> > +
