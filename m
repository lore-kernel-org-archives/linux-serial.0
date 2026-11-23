Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434097;
	b=dL0lokXA466ITihP+bD1jVd4bMp5l0UNYAPVnTIRLwuxa/C3bet0NFUOiuYqy7XU9bBh
	 6xs80eYkd8utj5LB066kpD4RgvCdtXuKcU3DC4wIAP0wT5SA/L/9P7wu0LbDHoaM7wsOM
	 n80rLOnECaLeewUEOPPJXDOLCqzWa6E/XvYh888Yu4EqGWP7poTJ9D/ygYB8Zntn1vWTf
	 TasTlGX5qBPSP9MaigZlEzfHPyxl00VSVW1u20w+XVXrFfyUd+07A7dqbVej0IlSnkjLl
	 jPd70YxCkkjh125ZPG1bir66xgqGUMuye/jrHcl6FXHVfyECriSLqhsFRDW0/snjZLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434097;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hPH+xwQQ5YvRprFEfig6JwjI4JJt7gcVnXPnZvpsz58=;
	b=cz0v/xm0EjqURxLjCfkKHYhpEoQeZHIOC6yconbl8jFqae2xXdpTGDNWZVnNx8yEJmeS
	 qgDBg72+PSE1fgYr56DnR9gSWrsYlvOAUWdO/4WLV4/o6MzQaRr0ficUJhwBMngjWkEoP
	 bs+3hC5POJp1uWC9H27BDV+RtEBb+nhO94OpTDLCJZuvy/plBIzpe8mcl3mNek23hOTMW
	 Vz+sHSVdlmuj3n0L8tPbsKjyrkvNyYQIOc/wjC7KUBq7huIdoS5+3V6EVytxItLwSUa2T
	 3IsXwlHuIeKJdUM0xRzem3qIIr3SJmB957FBA5LQwqBiwScmLFKwbDEfhr0zpPjqXcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=AqvTCW5q;
	arc=none smtp.remote-ip=109.224.244.123
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFFC606A31A;
	Mon, 23 Nov 2026 11:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FFFC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=AqvTCW5q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795434092; x=1795693292;
	bh=hPH+xwQQ5YvRprFEfig6JwjI4JJt7gcVnXPnZvpsz58=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AqvTCW5qPw2qcd8PAjH5z5PbIyHUU6oizOI+s+K7cDDXtV7PFmj9IPlnbrb215L2x
	 m/RWi1veWIhSUlB/2yxBLWKrJ69FXS+kDOfxoOAtKdY0VGw8HX5V4CcN9NMqqdSUOO
	 TkIY/hivq//dNMMUveqVLQH7TGTHMWrbAEWJz1WnXIp5tUbeopHRYv8Nald0kGqiD6
	 +ZHfgxEipxsOUqfvrohVIY580xB1XNgjb6Uv0ukoGEnvbw3xOJCRhfzLNO0s80dZKr
	 coDUkztBL3JK1cVGJ9a4XYR96VHe4UDIgcQUy1tcuYlBRkExLmlf0LDqW/KmalhSrC
	 CcDxrCenLvhJw==
Date: Mon, 23 Nov 2026 11:41:26 +0000
To: Alexander Letuchiy <asalde.le1@gmail.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/7] arm64: mediatek: Add initial MT6895 and Xiaomi Poco X4 GT support
Message-ID: <ckJZtdZ4-fPzsa3vkozNyEYYUbG9qd134hYb0hHEuq2nL8WMAR1PS87OpDfXrkU-E-85rsG1I4V99_M41j6-ewkD_41XPguDel3z8z0lmMk=@protonmail.com>
In-Reply-To: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: c6b719aaffbb9f16cf86df1433c20e78eaceb862
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Monday, November 23rd, 2026 at 1:19 PM, Alexander Letuchiy <asalde.le1@g=
mail.com> wrote:

> This series adds initial support for the MediaTek MT6895 (Dimensity
> 8000/8100) SoC and the Xiaomi xaga board, sold as Xiaomi Poco X4 GT, Redm=
i
> Note 11T Pro/Pro+ and Redmi K50i. It is enough to boot to an initramfs
> with a serial console, CPU idle, the CPU and DSU PMUs and the volume down
> key.
>=20
> Dependencies
> ------------
> The SoC DT describes the pin controller and the board DT uses its pinmux
> macros, so this series depends on the MT6895 pinctrl series:
> https://patch.msgid.link/20261118-pinctrl-mt6895-v2-0-0728c4eddcac@gmail.=
com
>=20
> Bootloader dependency
> ---------------------
> This was tested with a modified LK bootloader that is not public.

How are other xaga users supposed to boot the kernel? You might want to
port uniLoader instead, or if you're on an old enough security patch you
can even replace stock LK with U-Boot. U-Boot chainloading is also
possible.

> The stock LK cannot boot this DT, as its Android fixups expect nodes
> that are not present here.
>=20
> The DT relies on the bootloader to:
>=20
>  - update the /memory node
>  - add all firmware carveouts to /reserved-memory
>  - pass the command line from the boot image
>=20
> The carveout addresses are therefore not listed in the DT, as the
> bootloader allocates some of them dynamically. I can describe the
> fixed ones in the DT if that is preferred.
>=20
> Firmware behaviour
> ------------------
> Two things in the stock TF-A affect what the DT describes, but not the
> DT itself:
>=20
>  - TF-A rejects CPU_SUSPEND for about the first 40 seconds after boot.
>    The vendor kernel lifts this earlier with a SiP call, so with this
>    series the idle states only start to be used after that time.

It might be worth porting upstream TF-A too.

Best regards,
Roman
