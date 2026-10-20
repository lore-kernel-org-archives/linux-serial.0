Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530540;
	b=lg88bf9rQV9vmDbAF++EsW4Bt7QjcfeIhJyBKCgQJoTfyOhxvX1TuM+HKPY6WRJhFPth
	 RKN/bJODw1p7g56npgZK4rrgb7jOrYOz0sus2BwTRjpX2cUYO2UEBBfSvnukCtfbqoO5r
	 JJfEB/KLLpHizbn8e1cKAdazgjBprdNvAwjTspV906YYPw3TH+4skhaE+M5Emi/13e9Br
	 LdAYjGbba+WHIR0HWR9d3zHKk0rlMbExA+brpzq6ZH3oNdgwTa1qDWO7bb0oHxS0ib0/n
	 8yKQrMFjq0xjT9T1odeqkYTZ3ndVRUx2UoIJfmyybwWIft7hJ71RxZqLFIWG60A2JGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530540;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FWlmaieVF3G5nqJkpjCWlEpztN0OshGDCOqC4t4ddFQ=;
	b=hU5BZXIRJEw3tpb0DaB6e8ev/me7h0NELqGQ9tNHnl6rqqniek/ZQDu0fJVjZtPgNfPe
	 TL5Jo0cexGki9ct5PXZk83yq9z9vvrzF3DDgP5HXC1yWg8vDHlCdioKU2v2sjiL5+3ZUx
	 Y7q8OJbOzfdRxVoynsAZOdtHvH+MJQktfATRYUrQC780nHdKAQQytdFMauYd401s00wUP
	 Vty8TnWiKR8EQ2fVfmjdo/onOncDir0sw071YjLZFO+YBPWsuKIW9rxJEtirL8K0/mYTV
	 xXS4EszOFpdKgsOnwYMvqDZx6m9UcDxreZHYc0SSHpgt2jo2WdUCNpKmBqL8jB1uVXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OxP9/a2+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF34606A319;
	Tue, 20 Oct 2026 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxP9/a2+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641271F000CB;
	Tue, 20 Oct 2026 21:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530538;
	bh=FWlmaieVF3G5nqJkpjCWlEpztN0OshGDCOqC4t4ddFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OxP9/a2+ATby/nWvWsklJEXB+YxJyzUyrH3x45stE0us9xPlS37nBoJvZjIFfebYT
	 SXWgapf5vSZ1Ji8rh8PBAl8HTD8j8xpuSjTlSmCt6Qb1V2E8Wnp4Wf1MZEKo4D+lLG
	 i/45LJT9p3FoFTWPQndcVrKBPNgHIBq5FaqBLCU7gPvUAxdncUkb5tL9AFuNLVfpkg
	 P3w2vpfbfQ1zMvt7MGzq2gNaphtQV+pmcHFkoltznYV1UaIwKnj5NngiNGsqUfsdyu
	 noK6PYFAMlfPW3XVPW3fyq96knkfQfmd2f7Foo7AMKhIBbakkBAQ9WFk7ZhWWzQEJd
	 B7t7JrgUgET+w==
From: Imre Kaloz <kaloz@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	mfd@lists.linux.dev,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 31/53] mfd: ioc3: Add support for IOC4
Date: Tue, 20 Oct 2026 23:07:47 +0200
Message-ID: <20261020210749.11045-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179198346971.839288.6829273567060577383@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org> <2e8b812274f3049c687c37d1b7c3b3a4ee22d008.1791890466.git.kaloz@kernel.org> <179198346971.839288.6829273567060577383@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


On Tue, 20 Oct 2026, Lee Jones wrote:

> >  5 files changed, 438 insertions(+), 46 deletions(-)
>
> Do we really need to bundle all of these changes into this commit?
>
> This is going to be a nightmare to review!

Fair point, and sorry about that. It grew in one piece while I was
bringing the hardware up, and I should have cut it up before posting.

For v3 I'll split it into five patches:

 1. mfd: ioc3: Add per-variant interrupt banks
    The irq_chip, domain map and chained handler move to a bank table,
    and ioc3_priv_data gets a variant pointer and a generic __iomem
    base. Only the IOC3 variant exists at this point.

 2. MIPS: SGI-IP27: Add IOC4 register definitions
    arch/mips/include/asm/sn/ioc4.h on its own.

 3. serial: 8250_ioc3: Take the UART clock from platform data
    include/linux/platform_data/sgi-ioc3-serial.h and the one-line
    change in 8250_ioc3.c, with the MAINTAINERS entry for the header.

 4. mfd: ioc3: Add support for IOC4
    The IOC4 variant, its two interrupt banks, ioc4_setup() and the
    non-serial cells (kbd, RTC and, from patch 46, ATA).

 5. mfd: ioc3: Add IOC4 serial cells
    ioc4_serial_setup(), the firmware revision check and the four
    UART cells.

Each one builds on its own, and 1 and 3 leave IOC3 boards behaving
exactly as before, so they should be easy to check in isolation.

The overall shape of v3 still depends on what Thomas prefers for the
series, so it will follow once he has had a chance to look.


Thanks for taking the time to go through it,

Imre
