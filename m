Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FDC535FB5;
	Tue, 22 Sep 2026 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084515; cv=none; b=YrtzcGIYS5WYIPxxxDDnmHkLBH5pqDEAsqa0teMw4hp5iryKgUIxtLB0V2DA+iOV85WzwBdBu+hoDgY/yNpygkJa5OEuhHhXTDBNxhdxHfxxKwWRomSMGhfUkOPJY4/9zlryLNY4v4DONUnORyUjJiVpAiaPTHWnVUOqppH9nKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084515; c=relaxed/simple;
	bh=hpMH0dXH13wSZ/dUZfL4U5SUQ4JPJzBdDfkOAQBLy1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O4Yqoj3Ud1PbHA4vblOBmoIMQm3F24iLKWbAbNTbTJ1FMQJMtn78JJlhTEpzW/NtzOP67p+7AacI96sZHaVQI4v6vvzgfyfrHcUWaEthXiUEgAZU8pmVuQ8rU2yEmUnNr3DkDpnffuhN+a0SqkfFHsDRSBRN0u4HvysZmTJPGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpVhvuzn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpVhvuzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040F81F00893;
	Tue, 22 Sep 2026 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084514;
	bh=hpMH0dXH13wSZ/dUZfL4U5SUQ4JPJzBdDfkOAQBLy1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bpVhvuzn2IL97ScTX66/rV0HWa8oDNhOcngJ3YkuGxs1S5BUC4UlqAu8FpM+0FoH7
	 lkCjDok3zPlRN8FWed6YztNPfuK4sTH6+Hkmg4llQlX3sg0WoQ3jxhcxJR7XoKaRYM
	 4TPEMwPrj8i1ZYggyHdz6TB/cTgGkylKhCFLLHvhPJf54Jt22hve8ffo9CikqBOJII
	 0oqbYsS9l0pFxtA5kADENvAWXYvYpQfnodDwuF2NOFP6A7OIVyZmJjVEJ+TKUiFjmw
	 /GyPSYxsgk6o+Madq03eRQZ9PNls0SxR1JjB0fqUDTPLelaIsJ2HVarmUYKaAUTfce
	 zKOzu75Lt71wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] watchdog: Replace __MODULE_STRING() with
 __stringify()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-modules@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260922-module-string-v1-1-c18766690185@suse.com>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-1-c18766690185@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:41:53 +0000
Message-Id: <20260922134154.040F81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
>=20
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
>=20
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-module-str=
ing-v1-0-c18766690185@suse.com?part=3D1

