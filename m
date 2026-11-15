Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794781692;
	b=A2KzSuHYuieHf0tmhipugUZNj3I3XtNteYw44l0mzoUSk66JmHAW+11Xnh5A+oOtZj5D
	 txpBJK+1ECA9taQ97hOP5yvXfJ0hGAOtE46jXLff6Kd4+JpsPGn/HK0nX5kQcicTT59Yx
	 Wk2pSfMtKtatWOwld6YjTHvy3P3CCFxJ7Ea0Gfm1vqkpeSUa+l05icI5r7pqT/ZAa/oPB
	 uKBe3cs+FHbFt+0/levNe/UYb0qYhG8bbarlyh388MVytQjesrUc3/SQtab6ajCbk/9JD
	 0pgAr+gdjdGXPHxHOHzokOoCEJZV3Xk9t5UOHnJxusmYTV2/SE3MVNZDxSfBUkjuAtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794781692;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TEYwC0yd2Q6rJp4otTipe3rkKTLSLdWxD7WurCB1Zgo=;
	b=xde6cpuvIBXvXL+FVEY4KsKi1tIeWdcR4Ce2uS6HphEI/dFJAA2yD5v4T7LQL8N+y9R9
	 rstRJGMM6AosPU1IGJqdRx4ebU+P6OoapSjLVrbAmyd56K4kp9/RH/1KyTERi8OCHlclc
	 fPw3q5lWJdI/rK5OUgSA2EZ64BkUI1QG7GW2piu2MyodERjDQwg/t5K4zO7Lkgw8P4Avr
	 KzhxmX+GA2E/9s6fcv005+xwO+fvaRWnbaq1p/mQkUDqVWSGuevSsbsVqM5uIAiTVlrjl
	 jq0tqj37SZCkEF7EbPMZhCAZsqX3BqhcBkr6aqGE9LyZT3cTMFAPfkhDaAzAlSBfD7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWVzejUX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07866606A331
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWVzejUX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F031F000C4
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 22:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794781691;
	bh=TEYwC0yd2Q6rJp4otTipe3rkKTLSLdWxD7WurCB1Zgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NWVzejUX9qF0XoM4VmEyXPZSxIG5Fs6unNadjPRXKBSH+vjBwWuW9IwsP2UD1Jyxh
	 N4DWmQdek5RNSEdOLJueNW9tvqDthvnNazJBw0TiF7oKW+Ke/20zMucQiLpYLKA5nO
	 3jDVSQIj1Uzg7SYszycMfFEzP6fakMh9E/SFLUMyyl3Pw1POrN19p3pgZdlMG1hBfl
	 uDu2Fs2NFFfeBArnwiJLuecqZC8ijTgMvmd4rCgRDyv0DuRa4QKIeDtU1FGrbDm1fT
	 9x3ewZn0T3RJPSLbtwwWddaebGc7zSZ3YdLKxYfaWHR5eABuub1dS5nx5aZcMg9Q0s
	 IUuDfWmSm/WOw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so1895707e87.0
        for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 14:28:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGEvoo9WmVERCihzmbp22tM60Qc2qVc1nQrzUb8zAyuVGYPL/DqwLSDtBrPeGv0PWqX13uA24lDmE3i6PM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jlsvIPJBuVcneGnic3/Lwot/eZNzamm3+LhQIniyO6DlWFXGK
	7cGdscTj32m5UntExKFAnXX33+CCvES2OROrXgw19PydsZ4PUugSNe/bQuxRfOtdd6JkHuAG3Tb
	mHE1fnrfGhoW3JytBcO3vyigCK9OO3TI=
X-Received: by 2002:a05:6512:3f04:b0:5c1:4cab:2d03 with SMTP id
 2adb3069b0e04-5c170b2ecf5mr3075860e87.63.1794781690375; Sun, 15 Nov 2026
 14:28:10 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com> <20261114-b4-cs75xx-v7-4-8f17f38821b4@gmail.com>
In-Reply-To: <20261114-b4-cs75xx-v7-4-8f17f38821b4@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 15 Nov 2026 23:27:57 +0100
X-Gmail-Original-Message-ID: <CAD++jLnu=ycR+_ZXW2K54oeDJMCfybdSUDVOTJ5B=rFTiOnjLQ@mail.gmail.com>
X-Gm-Features: Aa3M54oN7V3Y8V-EQUC0vRGZ-PhoQTaP6aUjOIuJowZCATlHdfiiGxoj1XFGWNs
Message-ID: <CAD++jLnu=ycR+_ZXW2K54oeDJMCfybdSUDVOTJ5B=rFTiOnjLQ@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] ARM: goldengate: Add support for the CS75xx SoC family
To: filipp.dunsky@gmail.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Jason Li <jason.li@cortina-access.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 2:41=E2=80=AFPM Fil Dunsky via B4 Relay
<devnull+filipp.dunsky.gmail.com@kernel.org> wrote:

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>
> The Cortina Systems CS75xx ("Goldengate G2") are network processors
> with two Cortex-A9 cores, an SCU, GIC, the Cortex-A9 global and private
> timers and a PL310 L2 cache controller. The family includes at least
> the CS7522 and the CS7542; the CS7542 is used, among others, in the
> Securifi Almond+ router.
>
> Apart from the vendor this has little in common with the Cortina
> Systems Gemini (SL3516/CS3516) supported by mach-gemini: Gemini is a
> single ARMv4 FA526 with Faraday peripherals (FTINTC010, FTTMR010,
> FTGPIO010, a 16550 UART) built for ARCH_MULTI_V4, while the CS75xx is
> an ARMv7 MPCore whose UART, GPIO, interrupt controller and NAND
> controller are different blocks. It therefore gets its own directory,
> named after the Goldengate codename like in the vendor kernel. The
> Kconfig symbol, ARCH_CORTINA_ACCESS, covers the whole family and is
> named after Cortina Access, which last sold these chips and also makes
> the newer 64-bit parts.
>
> The generic DT machine is sufficient for the platform, so only the SMP
> bring-up needs code: the bootloader parks the secondary core in a WFI
> loop that polls a global software register, so boot it by writing the
> physical address of secondary_startup to the register named by the
> cpu-release-addr property and sending it a wakeup IPI.
>
> The CPU is a Cortex-A9 r2p1, so select the errata workarounds that apply
> to that revision and can be enabled on a multiplatform kernel. The PL310
> is r3p1-50rel0 (CACHE_ID 0x410000c7), select the workaround for its
> erratum 769419 as well.
>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Looks good to me.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
