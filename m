Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F84772A6;
	Fri,  2 Oct 2026 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932490; cv=none; b=FbSc7Bn8OmueEUUB+cB1TBZJx96h7/eBHfCEqoFlagyVCUXIfyRB/RwscrdIlETWv8oVk0kqmK5ApN/e5IA0xaz1FQrucFSND2XqDud+GGxHAmyiiTle7c4KkBQ6Uifb9aByroygurT4I5GqKTMo7eGstrp5sKUmWWqOTGLZ8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932490; c=relaxed/simple;
	bh=n9XPVzmamJ9SFi/utHDiLl0mrcfA1+JtJQXHpWb3o4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V6aROQekSi6OoOWyKl338WW/V4iS0BLMQs3MHbNZRSFQrsTDxQXY1r19rMiMkWc4r9pxRC1RLhiUHqFGyTppKF5LMnfiMRnetn/LslPq5FA1jabRpsDL5fsoEV7FfIBSoBQj+zkJ/3b6ysupFNJFaH3F+5GKT6E+RYsj+MQrQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEahz5Nj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEahz5Nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0911F00893;
	Fri,  2 Oct 2026 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932489;
	bh=n9XPVzmamJ9SFi/utHDiLl0mrcfA1+JtJQXHpWb3o4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EEahz5Nj+zMjRDGaJzTrt/4iq1bOhqMLFzGVZ2+IoN2ODPjnT6Xy6zevlL0xTh3AM
	 9kabDeQMi+jheU1Wea8uAdqJAe5K/LUZPY8m4c0FkaXSbXL1KTKlhfMN+Wjq4zB4TY
	 /9yP9sRUvvD5kp7e87XPaB00IHYmhwynS3mYNpRB6zIm7N5oCdqAGD3os7Nm0AKF2p
	 HM2KSFJKNwmfQwgwSvXn0CIVOqUtmomEmKVBvrJ1DKoRFrncm3hwVn6XJNzG7YJhdg
	 eO+BVwFtIgf7khY7KfXLP8xiF+iPWZcy1syRdICbVWG/00rsjQTtQG3VQgg82EYQGT
	 oHW2J9d/Y/D6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] module: Remove obsolete __MODULE_STRING()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: "Petr Pavlu" <petr.pavlu@suse.com>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org, linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org, linux-modules@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20261002-module-string-v2-3-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-3-fc7438acaf4d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:48 +0000
Message-Id: <20261002091448.DB0911F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
>=20
> Remove __MODULE_STRING() now that all remaining uses have been replaced
> directly with __stringify().
>=20
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-module-str=
ing-v2-0-fc7438acaf4d@suse.com?part=3D3

