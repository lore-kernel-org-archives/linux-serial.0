Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733548;
	b=fDdxEkQPL7BoR43MVwxoM9PZH7IvU+ADxOofnEGp0ynagxrKXq92xgdCXDHjdBynlDHa
	 meUIjzWyBNTEXl2O8DSjU3xUonCXr1wlxJUXlFfxveCCW3j1A3fXdL07+qDWwphpwyRIt
	 Zh1lidCeUNoWEGIKE2oTKDSFzc4L5Ipdemi2k08bw/MeUHl/sociHWn6JsMPTiMNySGVl
	 UFJ3Q9Rv9xzFbCAF1rHLWS7lyJFb3fA16AzyOmJyBbzOSmbfM4p4tgMfxyXTzI9w2kbJQ
	 Xzqzlt/tHNNM3BDUZa0+So0FfOP0jjOLVIVywI+o4SCFvF7Y5skX4OXwTR6EVX8kEAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733548;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K+01KSPQORTETxKK9w9k1Nm7B2OkzJLUD9opRH5V6lI=;
	b=HcfgpAcsNvgUdgCQfIHUR4Z8mnWTtydvsMjGEj9lD+AYNJn0rSp6nqhgCCBD/qhHGw77
	 SNHHklWoSqGjrLAWuneGXnJY7gWEZJuRdlk5Bzbx3KlCIQnn1VGU1J1dx9XJOuOUHTECc
	 B0Q9zxnHS7MyAxYqbQ98wLE/y4sccK6sH3Pb7vShn8iORsesCqDKguElly5h9dvp40p3e
	 Fg4H3ABE5ubUXmzYphVXF5jxDLQlycoWwhTMTO82qGt/8rLNmCM5Cth/gP3wclVMO1kG4
	 0HFt2YpbwSXcwN2eh5Ip9DbrvvNGXlOZeb5gfUFWOYD4orOnNupMKFnAk8LCRjycidA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SHcrw/XF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908A606A31B
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHcrw/XF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2D11F01828;
	Fri, 23 Oct 2026 05:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792733547;
	bh=K+01KSPQORTETxKK9w9k1Nm7B2OkzJLUD9opRH5V6lI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SHcrw/XF/4KF3WLFtWVt/2IMUAAf6g7i8HkQtu5VNcm0Y4yV4Dhu8Ma9Lx7+/U4Yd
	 LNkk+Mib10LkQYC9MsaWhV0JiF5bDZ5jN8kGUtaoXB8NnVhuVqL/Nax35SK5zDdHsg
	 9usugqj0PyMD2lU0Z8TLdugtMXuHs3oeZqxiTU8rMeWmkXM//hf6x3h6UpNLkk63it
	 u+yvw3vQEcKRU5MfpDUGG56QRcERKXA32ygHmmT9Xhp2LndttzAIdVsjcEpzlmhVSz
	 cWAhZBDMp1c//xVpDDhPmpjU5Hc6KsIpi24fO++JosV0tIGOuepVeQ2XL+1XEobF1s
	 q1ndHNkAS48EA==
Message-ID: <sashiko-outbox-182315@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] platform/x86: dell-uart-backlight: Bind through
 normal serdev matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <20261023052717.2577234-3-an.wu@canonical.com>
References: <20261023052717.2577234-1-an.wu@canonical.com>
 <20261023052717.2577234-3-an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 05:32:27 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The driver creates a serdev client without firmware metadata and
> force-attaches its driver to it.
>=20
> Set the modalias of the client before adding it and give the serdev
> driver a matching id_table, so that the serdev core binds the two
> through normal matching, then drop the manual attachment.
>=20
> The client now also reports a "serial:dell_uart_backlight" modalias to
> userspace instead of failing with -ENODEV. A failing serdev probe no
> longer propagates out of the platform probe; as for any other bus, the
> client is simply left unbound.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023052717.2577=
234-1-an.wu@canonical.com?part=3D2

