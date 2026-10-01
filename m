Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B304E01E8
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849513; cv=none; b=DTwWKwFHXxDrmK4d1bj1ju/cAYaVRyCt1JHhlBK1uxKrJdqY/8TGbE1VtAOfs/gTudSOIaXQ1d8aCX77T4ZsEr/cF8O5CeBFW5tPz2xNuhX87DJfnELdP/aIeHcDsMSNRAOtk59OhimkdT2jakSXgiVQr/conjsm65KDrlEDs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849513; c=relaxed/simple;
	bh=BmENRPtP3YTfvwJZXATrbCrPkBVW6tepPdXUbKsjMn4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k9UdGn7sNoXTycNYZhx958nmOu2DZ/NrA2DycMPJ8p+i73cHT+/exWLNjznGJ53s5kZ+4BxjB+KsPpm37hXdzNA1gtEKkjzjAiZ2795oftGisPDySXcITsbqHPW3wzpPGaxgB5q9qdZbPUsUZ0e9f6VDj3cZWn78q23R0P2EvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=expqlqqQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="expqlqqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E046A1F000FF;
	Thu,  1 Oct 2026 10:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849503;
	bh=4XePtPz2pFzNJ10GRBGN2bjxNWBbZkm7dqyV+pBluY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=expqlqqQ1L2gLUuUxZWyIXqtID9HEyiaIIBjCLv6wR1v20IufSif0Bq+3oX3y02UA
	 Y2A44ELy+/V/GynLp+YiBypZD8TYbXMGalXuZt0ntc9HK7PuGTs784L4JoGoe5l0U0
	 GkozByNK+BdTHmupBS78mk/c2M8Cvj29cwH4COGQwUBhGjWzp7kejPnIOo8KoqND16
	 sgaJjfMu877a603ywDwSwzSprpvmqidKnn2deSmjC9hklPgm+mpks6euZ896qyotbu
	 0wqg5Jgjw0PhQEm3MZLidWV3XSjW8E2i5M/KvfOg5OJNwcXwoXoRT8fxykfcyurO7y
	 7G8OF/E4E4KKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: sc16is7xx: fix data corruption due to
 unexpected xon/xoff
Reply-To: sashiko-reviews@lists.linux.dev
To: "Martin Fuzzey" <martin.fuzzey@flowbird.group>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261001100534.1225894-1-martin.fuzzey@flowbird.group>
References: <20261001100534.1225894-1-martin.fuzzey@flowbird.group>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:11:42 +0000
Message-Id: <20261001101142.E046A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The hardware supports automatically sending XON/OFF based on the
> FIFO status and that is already implemented by the driver.
> However that capability was not announced with the UPF_SOFT_FLOW bit.
>=20
> When the port is opened with the default of XON enabled the driver
> configures that in the hardware.
> If userspace does not want XON/OFF (which is normally the case) it will
> use TCSETS to disactivate it. However the serial core optimises this
> to only notify the driver if someting imporant has changed, and for
> XON/XOFF thit is only if the  driver declares UPF_SOFT_FLOW.
>=20
> So we end up with unwanted XON/XOFF in the data stream.
>=20
> The problem only occurs if nothing else needed to be set by termios,
> ie if the user space requested values are the same as the default values,
> except for XON/XOFF.
> Since the default speed is 9600 this means that the problem only occurs
> when requesting 9600, otherwise the call to the driver will be made to
> change the speed, and that will also clear the XON/XOFF.
> As 9600 is quite rare these days that probably explains why this hasn't
> already been seen.
>=20
> It also only occurs on the first port open after boot since the subsequent
> opens will use the "logical state" set by TCSETS but not communicated to
> the driver the first time.
>=20
> Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001100534.1225=
894-1-martin.fuzzey@flowbird.group?part=3D1

