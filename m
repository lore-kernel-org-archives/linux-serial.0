Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435477;
	b=XzmyMyKpfyTVmJxUtyItcsfkZi0y4IJkVbSvgxMRLlth7a9YFohHdPqqcebLvLEZVE31
	 oJT8wBYORZ8miDwD6+sBCPiNbC+1CQjUYmn3KxCqJlBKL28pQY51O5rJem9VKjz0kO611
	 83jS0yOfChcILEiRccAquhpta7yGei1y17mt9l6z78M0YP87+/Qcaq9Nijo8Q8AHuV9PH
	 P2ox4ukEZx7t7p8VQj66HOgruFK+J+jXFEVojeA2+J1gvIBeHPqFt/kxqDb+BcLtjKcsO
	 zVylR2Z8EdXh59xQf7nPX3t9pFb5hHxkx5CusJmEi3AJXs4eJ9qL5DrVLXGhe7Gm6SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435477;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TicYu1LNyXPUHNb708qeXtsOiE9Mjvg68dH1aSn1fi0=;
	b=iEFCssjGGHLHakQWjo0uMTIWsNKiE369xzVhaoatD0FVLQczSil+EruT/ThCzGmJ70bp
	 m44NP/fDMahcPtVLlBM9JG/Gi3lajOHHvMQfHdO6sqI4oetVu7Xuhx3abxHDo5QeXsfID
	 T8o2yOA96RULHgiMYajNeAi51BunDNQKcybIc9rbETao4xW1OaIps2B2uLV+69GUfXigX
	 MrYxsmwshMQ17A0j9N6akD//YWh6ZSiCWwslrTNxM86Ciqm/Zp6PEOiHGh31EuV74c96w
	 SOD4HoPE5XjpQ3jMHTuyPkj5Ey/MH515/VxRA9GAZ7NW/5ZvQYPy9w9dqd0v1ydXNdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=lf6cJxbL;
	arc=none smtp.remote-ip=109.224.244.116
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E734606A31F;
	Mon, 23 Nov 2026 12:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E734606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=lf6cJxbL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795435474; x=1795694674;
	bh=TicYu1LNyXPUHNb708qeXtsOiE9Mjvg68dH1aSn1fi0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lf6cJxbLe7iiJV12W9PIZ7Z8UkQW3hiHJcmRegufXQUe+h4hul9GeIQY9gNswlbrV
	 e/YBSR3kSvp/KIzQ3+zblIFRaxxNtVVVN23D2vTLIL/M0SbBr1pn8utflUy/pfLaoJ
	 ZKPhXZ5uTtT1bWCHXdmKXRTfOEKb6sTzLUCa5vda9ckRNP8z8qlcpNpNFgQOoQhI9y
	 TzzaFEdTZGjnoiOvzUxYSzHc53VYBCR/86vCV6eQZvo1FLIuSXbxgiKqipKOESU1e4
	 N1YNKiDtfH5I+C8/bCV2nbXQgl2BSoRL1sH63qNApscHCqbYFJ7Yq5cG8+UFozKQB+
	 k/+kqGhL8O+PA==
Date: Mon, 23 Nov 2026 12:04:26 +0000
To: Alexander Letuchiy <asalde.le1@gmail.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/7] arm64: mediatek: Add initial MT6895 and Xiaomi Poco X4 GT support
Message-ID: <OZecqgdcxZrbwT7Ps6SDq9u1Q2EeF9jng68KHoWs8vTEetcTU8GAfC5LYcKzDGEZlr5Rlzh4rgzVh36JelFK1zHk3Dgh3TVGqj_a5Y3hv6Y=@protonmail.com>
In-Reply-To: <DN2KN6PFHOXG.1EWK1XUHY7IKK@gmail.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com> <ckJZtdZ4-fPzsa3vkozNyEYYUbG9qd134hYb0hHEuq2nL8WMAR1PS87OpDfXrkU-E-85rsG1I4V99_M41j6-ewkD_41XPguDel3z8z0lmMk=@protonmail.com> <DN2KN6PFHOXG.1EWK1XUHY7IKK@gmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 89375ca8f2e561b9db71121183ab2a32e2685cf8
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

On Monday, November 23rd, 2026 at 1:59 PM, Alexander Letuchiy <asalde.le1@g=
mail.com> wrote:

> Hi Roman,
>=20
> On Mon Nov 23, 2026 at 2:41 PM MSK, Roman Vivchar wrote:
> > > Bootloader dependency
> > > ---------------------
> > > This was tested with a modified LK bootloader that is not public.
> >
> > How are other xaga users supposed to boot the kernel? You might want to
> > port uniLoader instead, or if you're on an old enough security patch yo=
u
> > can even replace stock LK with U-Boot. U-Boot chainloading is also
> > possible.
>=20
> Right now I am replacing the stock LK with a modified one that knows
> how to handle mainline DTs without expecting downstream Android nodes.

LK is known to mess up GPIO and clock state. The earlier you replace LK
the better.

>=20
> In an ideal world, I would like to replace LK directly with U-Boot as
> you suggested, though U-Boot chainloading or uniLoader are also valid
> options. Luckily, the security patch level isn't really a concern here =
=E2=80=94
> xaga is already EOL and hasn't received official firmware updates for a
> while, so LK replacement works across the final stock builds. I
> definitely plan to look into a proper open bootloader setup for other
> users in the future.

You can take a look at mt6768. It's not upstream, but we replace U-Boot
and TF-A with custom forks, as well as provide tooling to prepend
meditek-specific headers for the latter.

Best regards,
Roman
