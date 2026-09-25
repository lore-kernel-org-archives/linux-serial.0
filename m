Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4F3B8959
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361485; cv=none; b=aRct1+hnwVRphX45apWWtnch39K7JjX0qGl7DFBhREVuQB094oCtPLMHu2g+guUF8uqO+lhukiQZ3IP63h45UXS3lQSROwUM806iFHHUfIqSQ+xy3VV7iPFa5ibpql6d3KglNv/hPY3BTv8fewb4oXL+dCK/y+YHbe9IAjvDzjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361485; c=relaxed/simple;
	bh=BJy8D01a9aMgpLgAC4Bi3s4plwkLH2/pAi3qigup7jo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=McW8qbUVBGujFaNW4GizBHjie+dDTdu6rmbQM9hqf+4wPh8HliCSwRwAHrlVqnM/nCUtT8DHGWQTc6wRUIS3TQy0/xkgA60wI2S5O/fWDg+E+XGCX2p+TuthnGN9QGkC7u9Q4eDrWPGQNesMyrPd+2BzIv6bBjnJFIMfG65ybsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlyuhMWu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlyuhMWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFBF1F000FF;
	Fri, 25 Sep 2026 18:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790361484;
	bh=BJy8D01a9aMgpLgAC4Bi3s4plwkLH2/pAi3qigup7jo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GlyuhMWu9VYIDe5fpvhzWiPvpbm9ktzFhp+KGaU5ml1Z1z/Nq/7IE7wlV4mNa9jJQ
	 Ad+sIiaDtnxHq5D7HloTF/nMLz+WD1X13E23KpGG1MIyOZhh8yQ6s1FuayZ10v4OLV
	 RzxPVElYtrKV5mBreGigKzhf8CRjYC6Nogbf9D2LMNAt4YpxIqM4wPXT4OOSuvHjfn
	 JNmV9bRKlGxvtalS7k9UpVfUgpz78lJ0mVKM2GVg2cOjUrr4SvKAQs+AD2jpWw/ZCY
	 fh5jW1j9EF4maC2gzL6eNpgYbtZPw9qPBHRs8NqtlkgqGZeZRr2oAVSS0Ztbn2OHfj
	 zHwVJriOxM5GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: arc_uart: Use platform IRQ helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260925183050.56839-1-rosenp@gmail.com>
References: <20260925183050.56839-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 18:38:03 +0000
Message-Id: <20260925183804.6CFBF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Avoid calling irq_dispose_mapping() by letting the platform_device
> machinery handle it. Also enable possibility of handling -EPROBE_DEFER
> and other errors. Handle as early as possible to avoid doing unnecessary
> work.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925183050.5683=
9-1-rosenp@gmail.com?part=3D1

