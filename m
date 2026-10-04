Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EDF421F0F
	for <linux-serial@vger.kernel.org>; Sun,  4 Oct 2026 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116702; cv=none; b=cGKerKQsXklGgeYURCrnfGHj/1lQpl8xGYHQXQ9xGAQRAMdLWD50Xzo/Y9anDzEI2Yc21jMGJ5y2oE8UVOjqnMbbh6Ih98TrM/GlHrng4IvjiIlHX27NuPHZUPjMJakmRzrGpkkp2atObRbEC2NrTfMWImTeDivhjdRzCuUdosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116702; c=relaxed/simple;
	bh=njmR7OqoM/X8gALu2aN6qjXgPRCHC4gRSpGx0qVzteA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j2vjDe597vqy3VhVg9N3BTGjNrsYkM4fUwW0Tht7sNhc1XkI0AP60fP70nUMn7hxeKiBnqYfK7p9WDVDOAddWa4vhQ1XLKn0t4GE9j06XPZBJxI/wc32JqYKiXPeVK6C0ui44kAMNR+v6mMblQaZIAMiEsRu6U7FJ1Azys9lvpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgkNx0KQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgkNx0KQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5764E1F000FF;
	Sun,  4 Oct 2026 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116698;
	bh=njmR7OqoM/X8gALu2aN6qjXgPRCHC4gRSpGx0qVzteA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GgkNx0KQKI7Hu1WIzQKnardeaFCUYio4KKXGf/y80HX1+Jvwz1zo2BGfJac+Mv7Us
	 FujrC9XPQIJ3+qgMY6DDGi4KXk+Z9YclI7GnQKGQPHhljPsdv7kAFj1yZtmT/XhOgC
	 CRBL8ikj2ui/8zitow4bpGK0AuEd73Q2Nzsoh/ln4QSMxl0yAFYnTI84lt0z4QVSg7
	 EAtqmNjq9RkkoUzeZNXvOBH55JlftCmFDUkfG4pxTQMhrJhE5nF1DMyqHVx2dSfIwa
	 8NotKQnOOT80qjA34piLGtBlHRiZDaS+WUeexNZky9Y0ji+NKgvEksnTaDwjTJJq8C
	 AoNGQyw2wan5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/9] serial: max310x: centralize the RS485
 transceiver programming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-3-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
 <20261004-max310x-rs485-sw-delay-v6-3-3a0ef13ed9e3@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:24:57 +0000
Message-Id: <20261004122458.5764E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The HDPIXDELAY RTS delays and the MODE1 auto-transceiver enable are
> programmed in three places - the rs485-config worker, startup() and
> break_ctl()'s break-off restore - each with its own copy of the
> register sequence. Move the sequence into a helper,
> max310x_set_rts_ctl_params(), together with the tx_break guard that
> keeps the MODE1 write away from a break in progress; the break-off
> restore reapplies the current configuration through the same helper.
>=20
> No functional change intended. The copies differed only in that
> startup() clamped the delays to the 4-bit field while the worker wrote
> them unclamped; the helper clamps, and the difference is unreachable
> while rs485_config() still rejects delays above 15 ms with -ERANGE.
> Break-off additionally rewrites HDPIXDELAY with the values it already
> holds, a no-op on the wire.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-max310x-rs=
485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com?part=3D3

