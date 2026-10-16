Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CD1379EE7
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145264; cv=none; b=Cn+aeFDxK3t7lDKyhZ9HWgOSZZsb62th4HpJhuMgxyftukh7/N72BgKLeOarqY8CfHDlCAM9k81p5db/aDbyMklt4z7XXeyxTD4dKFt+p1saGMaXo55IJ3Y+POEbVC3U15pmDN9N3+JXsbYJvc43AIqULhJcuBUO7UGAeF/T6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145264; c=relaxed/simple;
	bh=Hu7CxjvEpi1g4sVHjvGl4SEQsu6YffP7RhCnHZHdKow=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nEoXW5VYX72w7BRZ3c1mCeK/Gworq9q2v4eMYAGLkxofanwligbNgNo4fTX9j/xEJuZa9otdih7OZR69WAb4y1pTK4WhRsE6mntHLazQ9TbdyAbPXvMHJoULh0lcb+BPkH45VaavBNyuOei1fwLcq0YUtcsXG90AmswSQcNRIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUWUltFk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUWUltFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26031F000C4;
	Fri, 16 Oct 2026 10:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145262;
	bh=Hu7CxjvEpi1g4sVHjvGl4SEQsu6YffP7RhCnHZHdKow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aUWUltFkSNCIq3HYRpPuACRXwh00A1PckoR7lRY4v/VOHT4chXWvy5lG/aDBfOHjR
	 vT7iRAzAE7xB+tx5Izw28mRCJca+f8i7tYe4LKXNH5QMpqtrbJrl+HITvg2v0UDwSY
	 COXxlNx39Pobyzv9JZsEAm2UZ1Sf3JUCcm/LXhD+6rKqV+pt7SBfiDCKDrz1SvUdrf
	 DsA5MbipeKvNbpANvNOsweBB3tb6lA/0Cm5jo/vEYZZgZFd0qw2p8SfFnVcRCXPDSX
	 wkMZ/Mq0MTNwaxgqDvvFVIOKfcqUtsnOi/ewr4eSB9z+SH6U0TNJOLFygmSJAy+HY5
	 fiuVZFOf0yu9Q==
Message-ID: <sashiko-outbox-174123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] newport_con: Implement struct consw.con_unblank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261016093357.33294-5-tzimmermann@suse.de>
References: <20261016093357.33294-1-tzimmermann@suse.de>
 <20261016093357.33294-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:07:41 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Implement con_unblank from struct consw with the VESA_NO_BLANKING
> branch from newport_blank(). Remove that code from the blank helper.
>=20
> Both helpers, newport_blank() and newport_unbank(), clear or set
> a single flag in a hardware register. No further VESA DPMS blanking
> is supported.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016093357.3329=
4-1-tzimmermann@suse.de?part=3D4

