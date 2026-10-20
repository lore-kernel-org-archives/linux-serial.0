Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497774;
	b=Ij3bku+KBWZngvBqGN5ETncyUAe6Jegn6lhYB8UxQokzKu+BcpNIDSHoFaU5kfihJGzg
	 l7MrIVdhCyCAsDgq/eZPfD8zl6+gaK/tyCsMsjxyLgUcrf3u7BVYwnbQT6PIm7h2SSu3y
	 zIKvSphqkLf41+cI6S+xHSU8/YcbxmaiNmX9CXGSco5/K3DMTNEM4nkAuiHmHpLZLWLEJ
	 +JvF7xrEbiqapH12OXfMEd7s7spxHRb1I9mSE9Onyzo07EbT0mPrg1vTVrQfyjjn7zXjs
	 49mKDkfAq0HN9I5WYm0r3AiyKZySZR5RGQx3VimlBi1CvmbV67KzEewF5ecBvWD3mOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497774;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=Y2DFF4RD/jpeoGAQOUaJaBLkOA2GdM6dme7+WS01fbA=;
	b=y11ki587H+59Wi16VPbWv/os5ACEcMhRotZNymBaOf4/he8itDr1k93OQWOs0rc92IKg
	 lV+KBZic/PNFk3ac68phlb8xxprqZC9zPZzZcY26gsndUynaXXrED1XyvU27JQmuNQIYn
	 afF6jEgecnsjzvXgvqW5eKr3l9OjzBmxySWSxrH+/XWu7kbz4An944lbXE6u2HvPpop1u
	 R7Dd9eWcT20FgAndcGbCIUz2IHlXApK5gRNGdz4sNXEF7htdSNlfKvc7D/3QNsdrDiCo0
	 yJrjdrJMBN2fLNhyZDLkjjm5RHX3+S6QGtYtOEix9XaRuUO9ld2AtQK1RSK/89Czfsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RZ7nwwD/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55157606A320;
	Tue, 20 Oct 2026 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZ7nwwD/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96F21F000C8;
	Tue, 20 Oct 2026 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497774;
	bh=Y2DFF4RD/jpeoGAQOUaJaBLkOA2GdM6dme7+WS01fbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RZ7nwwD/kK42buUjMB+42iUvu0ezt90YjX9ThQlTajBVSuiNGSiIlOJd8hqIoaBXH
	 0vHRuNChHrLsty+JHf5kfLn7qoheh17/56QxjSlGtvZRWSi7+DMFL80AMjTHpXF2wq
	 0Uoku9c+GfFUI5+Z3NGbhYe0XOIpHzKly7S50suMvkiQwb+eQVaw0FjBZLnapDchgv
	 iLuT9J/nHkxT12XhoYXxSn9yXQQz0FpZ963EkUrpAltSDEvanKLnwLndK7qO7yWFcj
	 8ggTzPsKA5xo8AfZdwl20B1QYwytpifRhL0NeIwhVCTcplbdxPd15Ey1rzxobO0rqz
	 pgMYh1PRVrDjQ==
Date: Tue, 20 Oct 2026 13:02:49 +0100
From: Lee Jones <lee@kernel.org>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, mfd@lists.linux.dev,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 31/53] mfd: ioc3: Add support for IOC4
Message-ID: <179198346971.839288.6829273567060577383@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
 <2e8b812274f3049c687c37d1b7c3b3a4ee22d008.1791890466.git.kaloz@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e8b812274f3049c687c37d1b7c3b3a4ee22d008.1791890466.git.kaloz@kernel.org>
X-AI-Review-Draft: <2e8b812274f3049c687c37d1b7c3b3a4ee22d008.1791890466.git.kaloz@kernel.org>

--- checkpatch.pl: clean (0 issues) ---

On Tue, 13 Oct 2026, Imre Kaloz wrote:

> IOC4 is IOC3's successor on IP35 Origin 350-class boards. Its serial and
> PS/2 cores reuse IOC3's drivers and its interrupt status splits into two
> banks. The serial ports need IOC4 firmware revision 62 or later and are
> not registered on older firmware.
>
> The serial, interrupt and GPIO register definitions in asm/sn/ioc4.h
> follow include/linux/ioc4.h and drivers/tty/serial/ioc4_serial.c, removed
> by commit f7bc6e42bf12 ("drivers: remove the SGI SN2 IOC4 base support")
> and commit a017ef17cfd8 ("tty/serial: remove the ioc4_serial driver").
>
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  MAINTAINERS                                   |   1 +
>  arch/mips/include/asm/sn/ioc4.h               | 142 ++++++++
>  drivers/mfd/ioc3.c                            | 323 +++++++++++++++---
>  drivers/tty/serial/8250/8250_ioc3.c           |   5 +-
>  include/linux/platform_data/sgi-ioc3-serial.h |  13 +
>  5 files changed, 438 insertions(+), 46 deletions(-)

Do we really need to bundle all of these changes into this commit?

This is going to be a nightmare to review!

>  create mode 100644 arch/mips/include/asm/sn/ioc4.h
>  create mode 100644 include/linux/platform_data/sgi-ioc3-serial.h

-- 
Lee Jones
