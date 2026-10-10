Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D123D332A
	for <linux-serial@vger.kernel.org>; Sat, 10 Oct 2026 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791627339; cv=none; b=BdI2zj/HB5BDdAtObLRlRYEyIMsMkgwgQl5sJBwdVvusyazSv/87SSgvGRx6QmXCx1i1KcuafaI+1sawxRfjFnnU9desEtP1zhV7ARY9Cx1TyIHFyhre6EdadbaI7xlfv18+i/vfpvaecs1phha1Zuqd7moJXXW3y/uvYYgyURs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791627339; c=relaxed/simple;
	bh=s2Ql09kkJEJFq9znATy+PS3AgnuNcyM5kBHWFTPLd60=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ULFiQfzCk/JDlZf7abVf+p5h0UOTlAYPUu8Kpw6dOcntqQKt4GSigA/9m8WzD0bePbAPl0kD3Y21ffFQcFtdL3SvJqldbidirdgklBbFLURAgGfLDbpcC8ZXL3acJLozSN18HI8GZWbXHWKNuMGHxr/j7GmZy7t+rxWbEQ+rwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hewikdwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hewikdwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACB41F000FF;
	Sat, 10 Oct 2026 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791627330;
	bh=s2Ql09kkJEJFq9znATy+PS3AgnuNcyM5kBHWFTPLd60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hewikdwlu1fk7gKR0AgpF/SIs0vgMid1yN65fHxZ6dZb6ux/cyBD/2KoyqTxZHhdm
	 KzYLHKW3t1MUbaZzx92spDquoQlbe0pSt1ftswY7VV1pcqDrQ7JBhTOyBfbrHAoEG5
	 +iquWm5jNymgBb+4yC1lzbndzjEGnSeepoQOKGTwFGNB8XwHdfOnjXWa42UC+K9EO8
	 eQ8yaIOYwYf48ewcz7BKQosjE2UUix2zurg0hJ/bqGcQmMSWJT9iUCydrtSQVZOCi4
	 01MBBfnntKpQML5h2a8bSULBaUrpvAhPWCVItGA+S3BFXlg9DPqgLHP7fhByjAICKb
	 B76+Gv75/hu8Q==
Message-ID: <sashiko-outbox-166421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: move sdio_uart from mmc/core to tty/serial
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <1791626517-18161-1-git-send-email-shawn.lin@rock-chips.com>
References: <1791626517-18161-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 10:15:29 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> sdio_uart is an SDIO function driver, not part of the MMC/SDIO core.
> Keeping it in drivers/mmc/core/ is misplaced: it registers to the SDIO
> bus (sdio_register_driver) and only uses the public SDIO API from
> include/linux/mmc/, with no dependency on any mmc core internals.
>=20
> Other SDIO function drivers live under their respective functional
> subsystem, e.g. the SDIO WiFi drivers are under drivers/net/wireless/.
> sdio_uart should likewise be placed under its functional subsystem, tty,
> just like the PCIe and I2C/SPI transport drivers (men_z135_uart,
> sc16is7xx, max310x) that live under drivers/tty/serial/.
>=20
> Historically almost all changes to this driver were tty API changes
> (e.g. tty_operations adjustments, alloc_tty_driver removal), yet
> scripts/get_maintainer.pl never listed the TTY maintainers while the
> file lived under drivers/mmc/core/. Moving it under drivers/tty/serial/
> makes get_maintainer.pl report the proper TTY/serial maintainers and
> reviewers, which benefits future maintenance of this driver.
>=20
> No functional change. The CONFIG_SDIO_UART symbol is intentionally kept
> unchanged to avoid breaking existing configs; the dependency is updated
> to 'TTY && MMC' accordingly.
>=20
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1791626517-18161-1-=
git-send-email-shawn.lin@rock-chips.com?part=3D1

