Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289253FB7E1
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762371; cv=none; b=mevsgsA5r8zLDdrrVDbkhzEW2H42FYbTZ8jYuqiV1hs6lRiw/fa69yCRc6i0yvY+mj9VLxHqvYAFFCPHxNmDIKkqsxY/M07fTNOx5rNINZ4eQp+Oj2ufZ7BRiHwmYUxzQn5hWhtBy6cVFXEedyscluwPLbAG8Fx0EWI8PBK+2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762371; c=relaxed/simple;
	bh=oCb8pD0GTaCJdPRTDUHDOrP9QLPA+6gtpfNrrUBXRJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6Ro6v0F1CNA3yRMpfd4KsT0kRI7giyaHaSYGKciN1gL+TtXYxPoprwgM+TpL3YERdeJmCVTm220sM2bMssqlfngLLugahHTXWW9d6V+wNLduc/asmfqBT/8MuFfms5VWqTHLyVZd1eH3GAKeXfhUYNb1bx4h/hiC2ZggJZWwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKlR4Mzl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKlR4Mzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67C51F00893
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 09:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762368;
	bh=oCb8pD0GTaCJdPRTDUHDOrP9QLPA+6gtpfNrrUBXRJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UKlR4Mzlio3ueEA/PjgwIA3gAlgGElwwdLk5nx8l3YdQoQHbfHZBfLoYxcBDffpIB
	 CDgMDXXoqqy1vGb0t9ajW+Lafs882vdcmFrW9t3sxbgzlvBIwGXNld9RMprZZr11k5
	 l50TxsBM33PAEzWu+hTKjeGoPuxPacFUrVeRrsskD3HRFuWAWSb8svbRFsSi9mfHBJ
	 J1/FwH7fqHn6Yvv19MZf2wPneLTfDwRrFQIFNDXj/F8NnY2hod+QmjoGGtp9tN3dCI
	 dUuEyXJUQPoj6w7ljJnv6HAu+cZ6IvcqEOT44O4gwZRpc3hSIPYxdTfJ6GHdp2aWIW
	 f2DMRYML1OWCQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b76668f4ddso1874057e87.1
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 02:59:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByb/Ok5irGUONzQGVcoy1IggOUqe6GKiF9aiEs17+quAiuYrVHTtAge5q4WmZDAUSJ/ERIbKqHafXhLbzs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKusR7iSObBK8tigtkhoRrpHvX0ZgXOnipNkCRHvL55UW+JTThK
	Wtwj1OFiIJdLRCNH7ixv6VcDQdf2gVGXZpMqn8xNHox1ZeEJKqGHzhE30NrMuuxMOI4taOgcfuS
	/hhVllHk5uJXi7rKGq5I5fLdrWD7rwsQ=
X-Received: by 2002:ac2:464d:0:b0:5b8:f573:35ea with SMTP id
 2adb3069b0e04-5ba4069be69mr221068e87.16.1790762367713; Wed, 30 Sep 2026
 02:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com> <20260930-b4-cs75xx-v1-2-4617c4463529@gmail.com>
In-Reply-To: <20260930-b4-cs75xx-v1-2-4617c4463529@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 11:59:14 +0200
X-Gmail-Original-Message-ID: <CAD++jLkubGK4wetxXQz8PPDU4aHdSC7e0RgZtwOjrAWzHxX=RA@mail.gmail.com>
X-Gm-Features: AclHuK-m3HmD7lYV6qupQKjYpsgXbfMsgcuHzWJL7-TIFY8_vvfiqbhmnPD4sQM
Message-ID: <CAD++jLkubGK4wetxXQz8PPDU4aHdSC7e0RgZtwOjrAWzHxX=RA@mail.gmail.com>
Subject: Re: [PATCH RFC 02/10] dt-bindings: arm: Add Cortina Systems CS7542
 and Securifi Almond+
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
> Add the top-level binding for boards built around the Cortina Systems
> CS7542 ("Goldengate G2") network processor, a dual Cortex-A9 SoC, and
> the first such board, the Securifi Almond+ touchscreen router.
>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
