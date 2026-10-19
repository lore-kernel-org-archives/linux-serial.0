Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C439D48BD5B
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400878; cv=none; b=d63nvZe6YFkPq8PBT4OdQVxpLB5DOzP2yrky/MAcNrt1q5rwrw+Z9pUMSZFprcIrM7JZA6j+JhWTN8iVZQ4vCGhXLCOnqR+mihYCBVLh7ds4rw0E2IZMFEl466yNMHX/lC5hRQfpGh4nORHJlYavWFRRBaO1shh/K0xUPBLXpzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400878; c=relaxed/simple;
	bh=ONp35CxqzMGHF5x2x35KgUqVgps7kilXuy7aN1CM7bw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YeE9NQeiDvl14i2iNoaT7NPnOi1I4q4TIs8vOWolDL1OULCbjC58i9po1TKl15TuvYjNR7Ab41GvV0F1Woof9vc9VY8tpTC4MtyZrJu5eO8f+tl31uckOg9HtpgflwEZ+ks5o/vtHuE6ZTprpKv94iFxaB89rZSjGSzRq/syTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP5t8Ln8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP5t8Ln8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE221F000C4;
	Mon, 19 Oct 2026 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792400876;
	bh=ONp35CxqzMGHF5x2x35KgUqVgps7kilXuy7aN1CM7bw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GP5t8Ln8LmabLNWQnsQLGbUTFz/AE7xzmiDDWQZREGcm5OEax9ydt5WTYmBsztGC9
	 9pV9tbeVK3IIOiTIaFjoDZMR3N/zYs6wNk7RtHnuOTyp/cO5ry7nKmEIpmuJBVLUHw
	 lSby+R5SNQwf5RZ5pbZIpL+sWbPcGembBYUhtNdBDw5BAmzHyk7xWLN0DDuvbAF9nt
	 IIxyRe+JYGxvkY0SfPSpnRjsmF9hBaxHLjku8ZsNf5zvfG7OFLzxWNtKyCefPNpDr4
	 p6CwxQh/9UDfoCbhFTG3VumXKe7W/CIILrp8axEcDnUWm2PBrl8wGkpYXxYVbaxL3Q
	 WG95+Epio8HgQ==
Message-ID: <sashiko-outbox-176872@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] [v3] serial: 8250: remove hub6 multiport support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019090323.583178-1-arnd@kernel.org>
References: <20261019090323.583178-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:07:55 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> hub6 support was added in linux-0.99 and the hardware was already old at
> the time, being discontinued in 1990. The code for it has always been a
> mess since it adds another dimension to the I/O addressing in the driver
> that has leaked into many individual files.
>=20
> Hugo and Uwe have attempted several times this year alone to isolate
> the hub6 handling into the 8250_hub6.c file, but I feel that none of
> this has been a real improvement over the original standalone loadable
> module support.
>=20
> Any machine that would have used this ISA card in practice is likely
> 30 to 40 years old, and with i486 support now removed, it is clearly
> safe to just kill this all off. The only bit that has to remain
> is the ioctl interface, to ensure the serial_struct field is always
> zero.
>=20
> Link: https://mirrors.nycbug.org/pub/The_Unix_Archive/Unix_Usenet/comp.un=
ix.sysv386/1990-December/007174.html
> Fixes: a300273c458c ("serial: 8250: hub6: Add cleanup code")
> Fixes: c526404a4a92 ("serial: 8250: Fix corner case for port matching")
> Fixes: 7ab80d1e7243 ("serial: 8250: fix compile error with hub6_match_por=
t() when compiled as a module")
> Fixes: da7b5fd4e17f ("serial: 8250_hub6: add missing include for hub6_mat=
ch_port()")
> Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Acked-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019090323.5831=
78-1-arnd@kernel.org?part=3D1

