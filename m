Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70992370D57
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 07:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014799; cv=none; b=oQycsXERU32TKX7Jfu6KEjZwUwgdIKqhCYPveLQg1EoCeIo4+QRYbkSMvjqxQMaQLjlJGGMsTK7brnSRr8SYte14c6K1svtz4xot0s0yGu8BQCmohtLuZlTqjXxEfiIuehIC0tRVSH9szVA7NxcgGlAaLiGBjnqcAc7mL91O6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014799; c=relaxed/simple;
	bh=tLZ/GDek49sI5Zs/eZ/fXFs5/EAJg95zumCgRfB6mFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHDdAiqBB2Qso63vFGoYM7t16oeILRdYjxrs3FaEZbCRJ/oQc3lWbdwImNLmpTgqLH1bUjfhG1JTiOPWgSd064yhXhobsteDDJtrqPWv6QN3FuQ679YEyYszIe8c9LhIwUMEK2s+imyFwt4CfrubMYDh9C7uO2zjW1oUf2mXzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqTAkPNF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqTAkPNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B812C2BCC6
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 07:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777014799;
	bh=tLZ/GDek49sI5Zs/eZ/fXFs5/EAJg95zumCgRfB6mFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZqTAkPNFuRt4zBNN91MjsuvIMRLyywfrnFCAPb7T7f0WzSHRKVAzABlzj6MTWuHbO
	 DipU6fp9WKBSaiUKDif7XxbY2cwSKQFsZVjec2UqA6paA98OtJdhzXApvhX9eQM1B5
	 KWVQ48tVMzv2gxHax2ms3LlSmP4v3rQ1z0m6p71HyPxmc48Q4c4VbWzKoOQ3d0NGMI
	 BtrWK5VwCDE+cOiJ6a45f6dCGhdjqDGEPtZGrNrAcJkWy4okptGPbEExz8hJJUsr+s
	 jnkuFrOqTdX49kDYy4u6sIUy7EAaa7WILsMvqfJfS7CRoujVTv8Ba4S9IT2zFRoh/G
	 moZTOHfwajdSQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a283c44478so12718840e87.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 00:13:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ++YHH9e2f4S0oMQWlI8sNFaZn8jSjly5MCEA0wNyE1EILg8QkIbNIiuTt91FN6bpM8weJjickIKKPS9CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCO1IbZ8VBfthKG4jq/886Km5mwitVyz5cgvp+qMQA1/D7Gcl8
	2j43TTu4vVnBxhhzL3hFW73S18Ahk9buuHa5SDBYTlGXTXbDpdYnuIQjv4ff014Chp0Ca8NpQS0
	xmQaKEyIvl7ylfAWsIgH+ihWaeblpfWQ=
X-Received: by 2002:a05:6512:3b0b:b0:5a2:c0ab:b57f with SMTP id
 2adb3069b0e04-5a4172bfef2mr9090696e87.14.1777014797734; Fri, 24 Apr 2026
 00:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-send-v5-0-ace038e63515@gmail.com> <20260421-send-v5-8-ace038e63515@gmail.com>
In-Reply-To: <20260421-send-v5-8-ace038e63515@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 24 Apr 2026 09:13:06 +0200
X-Gmail-Original-Message-ID: <CAD++jL=_eDY_mG_QBreSrZiho0hUrDSciedq=vrxXaTiMwrSyg@mail.gmail.com>
X-Gm-Features: AQROBzAS_qKgmsidFIdx7V3XpX1JGmVrzkG_9S8znjc0YtyWq-b8e9KYfjIHcLw
Message-ID: <CAD++jL=_eDY_mG_QBreSrZiho0hUrDSciedq=vrxXaTiMwrSyg@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] ARM: defconfig: Add a zx29 defconfig file
To: =?UTF-8?Q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, soc@lists.linux.dev, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 10:24=E2=80=AFPM Stefan D=C3=B6singer
<stefandoesinger@gmail.com> wrote:

> This enables existing drivers that already are (UART) or will be (USB,
> GPIO) necessary to operate this board even if they aren't declared in
> the DTS yet.
>
> Signed-off-by: Stefan D=C3=B6singer <stefandoesinger@gmail.com>

*I* personally (as SoC maintainer) think that having a few more defconfigs
is fine, even helpful.

But I would defer this to the more senior SoC maintainers because I think
their stance is something like:

- We have multi_v7_defconfig for compile testing

- We know that binary gets way to big for your system: it's for build
  testing and perhaps booting in QEMU or systems with many MB of
  RAM, not for actually running it on products.

- You are encouraged to keep your own defconfig out-of-tree.

However I even challenged this myself by adding a defconfig for memory
constrained Broadcoms a while back (NACKed/ignored ;) so if it was all
up to me I would merge this.

Yours,
Linus Walleij
