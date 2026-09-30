Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB44B8276
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774801; cv=none; b=OnMgGrJIH0ypPIoPBt4/eVXE3ra6j+wJpykyU7mjdg981rLnMOz3wc7fR9sNliptEDMuxIuXyx3HfQfcadYPowq3MEfDeFZZaAlNtKiqVRiGP7x6P1zir2qDgkFVrTgd8CV4BGhFRX/urhUUE+SZklVs+GOFq75Ttj+lVRYPXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774801; c=relaxed/simple;
	bh=Vz3sKPQdwVfP958/+GK8R97kTilxpjxUKhWE79sbX1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ViKKBW8imJZ07r9pjJ8LpwgqBWS6kiXY5Be91/uPwiyzuCpP6372tr4Pi1EWQfGUogjBEtlRGEHRukLkvQ3a1uGfgPziLAE/1PsWbcxsZBVBgGDSWG7rnQ3bSgQIknX7sMZ4yZiXJqILUOg9wm3Q2/2xpbniiWd5b1k+goRyqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8T55y13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8T55y13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BBB1F00893;
	Wed, 30 Sep 2026 13:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774785;
	bh=exOpKSVqZSEzkZJ8Efp+gCrucIWIxqPsb5ovHurJvBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f8T55y13LOhdLylT+ii8+iUWuissIXvuKHMoqz5jgSuWQT9vFMJwQIbxd/vMqjs+E
	 I4uLyYbeONsy3WuSj4VfiY21EVQhQGI0aTEPcmgKxGpEsaGIG+q7BznvxmBHN0lCkv
	 NcyE/1pjo6wIPMjeq19SaM9KNJHiHfUunpEqI8qXKJOZKVuOB4XKiJb2NzESlyvRAs
	 79q8mDAtOT3HbUWnzFsOjw0E2q0Wr/Jr+TyjclYTDxeB5q2k7HGrBP5RmblTn0B70q
	 3kVFvnCqzrZMvdfI5qKvbxOr6Ec3NVRkJAFqZaHKyGUjpXqmNomi/N+UgVe3k4Riuh
	 GS9Uk1zkgUsrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tty: fix saved termios reset race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260930131845.1809256-1-johan@kernel.org>
References: <20260930131845.1809256-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:26:25 +0000
Message-Id: <20260930132625.90BBB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Resetting saved termios state on device registration is needed where a
> minor number can be reused for an entirely different device and where
> the old settings may prevent the port from even being opened (e.g. when
> CLOCAL is not set).
>=20
> Not all TTY drivers guarantee that the minor number is no longer in use
> when registering devices however, something which can lead to a
> use-after-free when closing a TTY (and saving its termios) races with
> re-registration.
>=20
> Add a new TTY_DRIVER_RESET_SAVED_TERMIOS flag to request that any saved
> termios state is reset on registration and only set it for drivers that
> make sure that the minor number is no longer in use.
>=20
> Fixes: 93857edd9829 ("tty: reset termios state on device registration")
> Reported-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> Link: https://lore.kernel.org/20260926184154.3017929-1-nicoyip.dev@gmail.=
com
> Cc: stable@vger.kernel.org	# 4.12
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930131845.1809=
256-1-johan@kernel.org?part=3D1

