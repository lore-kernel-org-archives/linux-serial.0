Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D83CD8B8
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120011; cv=none; b=rMb4cVpHaAESSXu1txNUHoRSJDzEfnEb15fDBQ61n7KOPNCCHq+4IwPLJVSp/zESW4feXhTMC95C4ENz3qA5VIaIPGWxMeJU16CH0lDXci45W4DEAV2lngIj5AK1w+DKgtzsLOPH0C8b+G6tKaAadkgn27Tmt9T2W18sLOjz4CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120011; c=relaxed/simple;
	bh=0uyAjL+n/B5xkxFrjnWVY/7ig2tPXTs4hqw0V18ZP/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ioqVrc4OVuIWI+FE7BUB2VJ1uDNunrpV3CpNPHeornc1AlH0IjNJtJdIm6sI3ECls1FpsC55z0It/3Pts9aI3KtwJ7l4hzavN/XMegiuKYpwpoI+4I4EW8mWV0AoDDNXIR5yAL1+x5UYwttP4jWsdPhAo6GM7KRD0s8wmOZCqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWoH0qGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWoH0qGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394521F000FF;
	Fri, 11 Sep 2026 09:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789120010;
	bh=0uyAjL+n/B5xkxFrjnWVY/7ig2tPXTs4hqw0V18ZP/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWoH0qGgc8F1a2Y5nE8MxUStp6K1tOKG9nWdU92Rq9YK4YYnSn4r/vJmbMNyQ+5SH
	 AsY8AfGoX/EO+8XWPFOLclSNrutokY/D4i6FA1LC4sbxYX9Wa2gKgQmX1ftN7bYu3m
	 aFedDVxnIR5BSDGPY63S758VtkSGB3MRm/LEfmrWJzKjialKw5fLr3PDPlPYNbmFbV
	 0lZfPeGSuf40DNzfRlziRMlBzEskwcpo/MnUQ7+VUpxSzra3uyO/mrmeTjJySZ1jnT
	 OQUENvIfOjBQJUE1gc/qVPV6NEkjxdiIL8p2SAW5i1hyJNn+cKi+zOwjF93TTPWLFb
	 GQsxM5G0xqrEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] vgacon: Remove trailing whitespaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260911094518.78093-3-tzimmermann@suse.de>
References: <20260911094518.78093-1-tzimmermann@suse.de>
 <20260911094518.78093-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:46:49 +0000
Message-Id: <20260911094650.394521F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Fix coding style.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911094518.7809=
3-1-tzimmermann@suse.de?part=3D2

