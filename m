Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAE1214A9B
	for <linux-serial@vger.kernel.org>; Tue,  8 Sep 2026 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857164; cv=none; b=vAlX+thb5IdzEyZhaS9ZZx9G+0F/J6pHA8/sz7lkftr1Bys0gTEY2Uhe7fwCG4pxd3FNc9Beoz3KyJ6wyHzhz0G9jk/ERNvBTiL+8tEKLQxxBH0s3ZBU1nlNpKlQmBInX6h29g03GKrJW4jJ3maEhMLUi5RcUeAkqOjfHfdTU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857164; c=relaxed/simple;
	bh=VlJKEntZWLbxVxtBkDR0XfRAis2axtquQ72HP2oaokw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pDC1YB/oQZvJDifT5b2TzBZcauEIK3cbUtz2L0PWWr/LpsyAJJBDzlR6Dla1UlstBW4TVPCeqBqR0kvLdERFN7szoNS4d7BdSLxCDxlQIstQyJhunV+SmWJoiC9RzVk9lrUx5cT3PwABWhFaQBxqetAESjZ1ZIeFKwjVacG0e0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn/Gi/w9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn/Gi/w9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A241F00A3A;
	Tue,  8 Sep 2026 08:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857163;
	bh=cLNEldg5VC4nARMJjxGDaDv3lET52l/39LReBTiurdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vn/Gi/w9kMcqfP0xAkaMWo8iWjVLfhLd+DqbHfFBVEzItxyN1paEHzr905tpkjzqK
	 +gbmavmhH1UcsfC55ca70PXTattd9uHyFXkktGMD2NguXdReQe3DrcerQhwva0V1PC
	 Q/vUFPB1WOaPhefw6cpGrUG8Sd1RCYP0QCWxchi/KFgEJ99fjy/+W9Lfln6cUu9JXI
	 w+bya/uhHvZpfEOqavu4zDLc4IZo+vaQalfjgY4DEh6DX4pHJjXmc9WiQ1a3nLS7CQ
	 +h4ipb9dDv2Xl3UmmZLp0KZL7PSasU967REKRQDugRct3U8bJs+L9xLS+vH4RP+4oQ
	 yUXQp4MGrpf6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: tty_port: restore TTY_IO_ERROR on activation
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260908084000.218528-1-johan@kernel.org>
References: <20260908084000.218528-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 08:46:02 +0000
Message-Id: <20260908084602.C9A241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Make sure to restore the TTY_IO_ERROR flag if activation fails to
> prevent I/O attempts on a port that is gone or powered down.
>=20
> This specifically avoids issues like kernel panic due to unclocked
> accesses or NULL-pointer dereferences when accessing powered down or
> deregistered ports when a TTY ioctl races with hangup and open.
>=20
> Note that the flag is set again in tty_port_close() but not restoring it
> on activation failure leaves a window where drivers fail to handle the
> ioctl-hangup race.
>=20
> Fixes: a9a37ec33a1b ("tty: tty_port: Move the IO_ERROR clear")
> Cc: stable@vger.kernel.org	# 2.6.33
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908084000.2185=
28-1-johan@kernel.org?part=3D1

