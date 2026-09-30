Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCEF471CED
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766434; cv=none; b=iN4BbvBbFXtQ5AucrHH2hbp0l6ppx17kH4+9SR78Gy9ppgwjWJmfSvDbNnwrBsLLkwPGnuad2hONzjchyyn0EsOQ4VMNMHp+oH/iSzLRmwQlhQHJNfxLEcsN5WfpCw5usvO5zlnaqfi1irIO91NadonaAICcknNti6Eq/0i9Ig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766434; c=relaxed/simple;
	bh=UOnsyAg/MuVmzfBYv2/LKdmOuEFogRMiJr3Cob/q6Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3ebkPnOODmOyWWpoE5y+c1Cl9Bw5AZVPet/BeMH2z0uPw9I9xJkzMIe+FCWHMsMzrgBkwSBxN67Jjds7l+YlB/50cFk0o38hPrJgwd8yfx5TVweGMu4Y8yp85RBOhEyJmzmpAvCRkTxy45vK0sAojdUG9Qc9pRUPrwrTdWPSZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRRvhw3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRRvhw3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F751F008A1
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766431;
	bh=UOnsyAg/MuVmzfBYv2/LKdmOuEFogRMiJr3Cob/q6Os=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VRRvhw3/VTpR7LMyKSdM0CBwFJrTjIPGSNJuW2ZsyN2y6jfZiUqVSx7NY0mTHJpWO
	 5nPOfjl3EytXUQS1201G+zlOZZi9HuEZ4lif+ubYKdPmGeZygl8NN3ITboKG2g/FZy
	 Yyi9VC5wSdxHgTo6mqlNqIWZqEYI1+XOL4lSPqSTbC9aw5m7KdRV6s2HDSqYj7kFx+
	 NVAshSRHgluW+LPHXhHkfQ0quBh97dT89GiAAXfhGdJXXWSWdQkl52DtV6S6jGcocf
	 2kWA8UivmFxuPg8bicg+Bf+WBy9ga4ZmToaCqjq7NoTGhmG+bY9L5V9YO1A7w7TJ2K
	 TMJ7ahvhigUZg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b76ff64d78so5109478e87.1
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 04:07:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxrKJKtFfwKc9ZSjUGWkWIKoqvbBK9hu/d1RI9elmumwHMtsRYFWUJlA2rhinXsC4LrcOwtImE1p/uiCHc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLB0MSKFKrNh4I1VCM0SjaxUMvhsmYNlNOEZo2HouJeQ9FYNKaI
	rbUSVQ6BYWPr/LtFMXxWaJu9KGCxqaswHQ8Oub9fvIwzU11jxg/Mrhrrv4ah3eOZNzogLomNM24
	U5TVAAbpFHqWPAfU/zjl2Chb3Jdj7j5w=
X-Received: by 2002:a05:6512:39c6:b0:5b8:e83b:2e1b with SMTP id
 2adb3069b0e04-5ba402ccbc7mr530988e87.4.1790766429870; Wed, 30 Sep 2026
 04:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <CAD++jL=0Zc939o7UaFgtx+04gLRmgmPVHTAeuW6OS9nPP5Xt8Q@mail.gmail.com> <179076583798.3054629.14422335928572048671@gmail.com>
In-Reply-To: <179076583798.3054629.14422335928572048671@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 13:06:58 +0200
X-Gmail-Original-Message-ID: <CAD++jLnVh4Uqc4eWr0t+Ut9EmNrbxkV9Qa6xJL0TuLAxM1ajCA@mail.gmail.com>
X-Gm-Features: AclHuK-or11HqloWUen4cBXQxiec-MiIiyBRze0xNfafpZukVzYlj54OfVdkbzM
Message-ID: <CAD++jLnVh4Uqc4eWr0t+Ut9EmNrbxkV9Qa6xJL0TuLAxM1ajCA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] ARM: Add support for Cortina Systems CS75xx and
 Securifi Almond+
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 12:57=E2=80=AFPM Fil Dunsky <filipp.dunsky@gmail.co=
m> wrote:
> On Wed, Sep 30, 2026 at 12:39 PM Linus Walleij <linusw@kernel.org> wrote:

> > Is this OpenWrt fork public?
>
> Yes, it is under review in OpenWrt:
> https://github.com/openwrt/openwrt/pull/25033
> The sources are in target/linux/cortina/files/, the Ethernet part in
> drivers/net/ethernet/cortina/cs752x_ne.c (plus cs752x_fe.c,
> cs752x_sch_tm.c and drivers/net/mdio/mdio-cs75xx.c).
>
> > Actually what I'm most curious about is the packet engine, which may or
> > may not be related to drivers/net/ethernet/cortina/*
>
> As far as I can tell it is not derived from the Gemini GMAC/TOE: the
> vendor driver has no StorLink or Gemini references, and the engine is
> split into a network interface (NI) with per-port MACs, a DMA/LSO
> block, a queue manager with its buffers in the top 64 MiB of DRAM, a
> traffic manager/scheduler and a forwarding engine with packet buffers
> in on-chip XRAM, which does not map onto the gemini.c register layout.
> I have not compared the descriptor formats in detail though. The
> OpenWrt driver only uses the NI/DMA path, all forwarding in software.

OK once this is merged post the network engine under
drivers/net/ethernet/cortina/* and I will help out to review it and
get it merged.

I agree it's a good idea to merge this upstream first to offburden
OpenWrt, that was the approach taken for Gemini and IXP4xx
and those are extremely lightweight for OpenWrt to maintain
since then.

Yours,
Linus Walleij
