Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7913F660F
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762299; cv=none; b=lKO9nRwi1gfIgaTFHxDzqEIfcG42eP5aEL14SAcFc4M0j2AWWONNyy6U4WJO6EEH5iWxggBtz6yz2N5UetNDKAjmy8xrx+9YcRT60XGX6ZWo9GVypVxONsAhfYrTRtKKl8bR/LOSzMiLdSLX4D4TpHAH2tihMS9PiNmxrMxDXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762299; c=relaxed/simple;
	bh=0Sl3VeOxmIWc0/FHhtBrqHO4LTDod/shA0uGQ9sZEHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jg+hdMnvKfvgTwalaSY0ScKQ3RA2OCRcsPhfCxe+coJAkevziHw72P2cW2//57PFokMvaEyYa+lwgnGsNoBlwY29BN4fawpPVXJV5UbsIFSgQOrPCvlChq1wnnADQRJbuF0QG+EQNKUnzSq6I/buK+cNuPaaOem7VBsDMA0Jy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUbFv6BY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUbFv6BY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DA91F00899
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762297;
	bh=0Sl3VeOxmIWc0/FHhtBrqHO4LTDod/shA0uGQ9sZEHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TUbFv6BYy0BYMPu/2dRG2IrRhyfl3Nmw8iP7m1nV10kOAaPSktEYYPGygLJw5W1XP
	 OgGNPbzjXf9WccmE7X/e65tRYtaozqybLJQqi92F2G7aULuMwSaggsqoF6VzknLN3v
	 j/119SKQJkNVyoYXyVi+ZU8t+oSCh0sgipwkVqLv7gmECa/zwIBUzBnRuwSmZUlhSS
	 2hOWz51MljSyTsLRkEULmI7TSwJgpOYDyzQVYzd/6AYyqBSjLDzMP8sLNgvwwtPOq/
	 uhKNcavvziezdqSJlcJVlJzw+wUyZfpQ1fDKNtQd3pgr2+ysvKE1r8rErIkAOsM4bp
	 SZ+wjeZHW+fcA==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8f5ae6fa8so3177507e87.2
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 02:58:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByGyti22hCexh2rTg0XiLVLnTxyDpUUAjuMfk0gXxOfyCXkP3epBCtP9GW1M5MPgVjw+anyigeibAzFYQM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKs4oZNa0Dz0RFR9mK85/6mT5tIvNIplDk5Z+QcL6xsE+bvVlXC
	KkWhm9WjUs7NtBVpv0XKypODdaaemvRWmHZgODGLA7dWNBo6agWFRwuN3RARFiUnGHaPulLX55f
	rG2fNgYsRvCqezRUx9KHar970KuKd5Ec=
X-Received: by 2002:a05:6512:124c:b0:5b8:f4d4:8004 with SMTP id
 2adb3069b0e04-5ba403e9adcmr391243e87.15.1790762296323; Wed, 30 Sep 2026
 02:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com> <20260930-b4-cs75xx-v1-1-4617c4463529@gmail.com>
In-Reply-To: <20260930-b4-cs75xx-v1-1-4617c4463529@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 11:58:04 +0200
X-Gmail-Original-Message-ID: <CAD++jLnAY5xh-jrCboLBNh95sMD4jo3+eD3r4nmGgOt07uSJwQ@mail.gmail.com>
X-Gm-Features: AclHuK-sK780whOzNFOmVs_mSNYseiLByWBvfxCT8N9Rk8B9pxQ3jl9L_xIBQyE
Message-ID: <CAD++jLnAY5xh-jrCboLBNh95sMD4jo3+eD3r4nmGgOt07uSJwQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] dt-bindings: vendor-prefixes: Add Securifi
To: filipp.dunsky@gmail.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 9:00=E2=80=AFAM Fil Dunsky via B4 Relay
<devnull+filipp.dunsky.gmail.com@kernel.org> wrote:

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>
> Securifi Ltd. makes the Almond series of touchscreen Wi-Fi routers.
> Add a vendor prefix for it.
>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
