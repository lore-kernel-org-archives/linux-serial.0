Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708E352021
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633551; cv=none; b=fVMisSWHVUl7EM7+NZo1RHxdctvBRBsmDz7Mku1cGsqnKlCQQGZk+KAxG0j6QFyT5p9BKlkW1oEXNYH5hyTHNhRjlN6gwMVA1LVeE1g8/xZ1vIySrhN2uC9I/GEvmIAknVjUc4Kg7DkC1rhmDh2AUf22D7up3ikMQXVQ/ybINPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633551; c=relaxed/simple;
	bh=45Cp52wzE2ey7jKmF2LTHma7lqa3BbrvRenTdb+of0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jMaWs5dCk8JKPjiftbbatn/ciBCfaZXYhBdacYQdGmfS/s2YRjoFMtohJKJPGDtvPqczwKSYDW1ueafRMwq3Qw8eMnlHk59TgbuIVQSOtnvHusOc2/yG9CG68lxuWtB2H3eXD0xdArlhJg4YMOVqw6H75iwAxmgpFLXMdkCD5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXSD0FFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXSD0FFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7B21F00A3A;
	Sat,  5 Sep 2026 18:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788633549;
	bh=45Cp52wzE2ey7jKmF2LTHma7lqa3BbrvRenTdb+of0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JXSD0FFWgy9wzOJiW4meHjKgtTEjJD1VjmRHZQvNijWAuWL7OKofRNgkTmPXhHCaw
	 8y9dRj5b6p+JkY7DCbKLAyFtmg22EmdpSUXq7R2zA9D7q5sY3EzPCMzlRrwv/kOzvF
	 qYXed9YXuFShoU37Q6cn5Ys1XzkVm83SxHSzrtw7mG978MXmV2U28bQ3MoHnQ/hQtH
	 FO4Jsp0C9EaRosTwLbXsiuV/rA8qavQ6RI8YOyGflD2U2g3r0l8/KJQPMYVMcPhJCE
	 2j5sDUpRB2ep4a8jVPL+FOtuPHjYBvgmzw451duAj2QDc8NhOKu6dtZMHeQCG+1FOt
	 Toql1yX4PktBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] rust: serdev: Mitigate race conditions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260905-rust_serdev_fix-v3-1-b86056c3f7a4@posteo.de>
References: <20260905-rust_serdev_fix-v3-1-b86056c3f7a4@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:39:09 +0000
Message-Id: <20260905183909.8D7B21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> There are currently 2 race conditions:
> - in probe if `Driver::probe` returns Err
> - in unbind
> . In those cases the driver data will be set to NULL before the serdev
> device was closed. If data is received while the driver data is dropped,
> the `receive_buf_callback` might try to access the `active` mutex on a
> null pointer. The race conditions can only occur if `Driver::receive` is
> implemented.
>=20
> The issue cannot be cleanly fixed without rewriting some logic, which
> might introduce new regressions.
>=20
> Temporarily disable the use of `Driver::receive`, until fixed in the
> next release.
>=20
> Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3D@=
smtp.kernel.org/
> Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@=
smtp.kernel.org/
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-rust_serde=
v_fix-v3-1-b86056c3f7a4@posteo.de?part=3D1

