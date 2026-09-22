Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B1539780;
	Tue, 22 Sep 2026 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084515; cv=none; b=n1DEcImFO3zj1IJ0qv3CZebzhs2/+CZ0HqAY3+tfZ8vPvSxM6d6RdyuXJ7NUUWh8302yLPb3dLBLS0WISAqE2+5Xms52Zh6IRko225cXPqpN8dx2LZWR1vL6ROVU8Qna8fnQ4YTut2OmaM7YKTElyy67JUqLCoa456n0lRym/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084515; c=relaxed/simple;
	bh=lVl0fgKjqVy/vhthxNUYL8fKrxtcMfANmo0SEydbDh0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EBDVSLl7og18jo28M0hCCG6YrTqY479/RNv+0EeMPL1gXqoIv34iKpRo+yWXwwcXgcYnqVJltzFIEvY9t6riH4V66njVMTZv8s+26TT058Ds+dWwosKp//cx7TbgvvYXiKozwX0RNBCwjROp55Qs63XzfiLB0sJHMVhw7WPKHvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZx2iSUM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZx2iSUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225A91F000FF;
	Tue, 22 Sep 2026 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084513;
	bh=lVl0fgKjqVy/vhthxNUYL8fKrxtcMfANmo0SEydbDh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bZx2iSUMlwCFCcanq+6EXP6q5cVqrAKJfT92rukW0mgOrDt2bv+Mbv/F0FPGHdXK9
	 6CP44UZJ8oIol+CEgSy8wrlJ9DwZfszk309ymt8+sKBdn9NASzOdaG2XH0zrUtXjYu
	 xShwcLk2iUI88ojOQy5tAEO84BvOCvZgC47mBslwRTpizysRe+AH1jieiS7x6ckK38
	 yYorKnZ5iyhXEtBhD9vuYFQ6zEC4lEUKq0FhW3/FwkMYd5HK1hbLIhGBEIgHclLxGS
	 6REqITFDFxvHgqX7r/VslBp5tYqmFRQfTiQgTQziqZj5Q1weuA2eC1iBjlRk4yUCgz
	 WVI09un0B+e/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] module: Remove obsolete __MODULE_STRING()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260922-module-string-v1-3-c18766690185@suse.com>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-3-c18766690185@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:41:52 +0000
Message-Id: <20260922134153.225A91F000FF@smtp.kernel.org>
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
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-module-str=
ing-v1-0-c18766690185@suse.com?part=3D3

