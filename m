Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152446C840;
	Fri,  2 Oct 2026 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932489; cv=none; b=XnC5lFqNvjWMFA1wEmLPNz7PS0RqdFWwfa99fAXtDN41dH4aLgUNg3YqVev2fO0F8uuahBjsQXRS4OZ4I+jyCoNu/t2jxHN+1TuO4MwKG3iVKgoid2wSi56gy4ASe6Jlv+zrA8/oDDATpBHgEnVfMLiO0s/gB1zhDrBa+R4EdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932489; c=relaxed/simple;
	bh=//8fxdMsJh6/kGtDdgLOpr6PPslJ7sGIiQGx+p6a4P4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CBKD4B9MWLgDU2WHxBFdUqWLQke3Ho6IbvHCVEgGArpQe3oQyk7hRUH479zE77AdKFqCJ8C6+FFO+J3fKZ9cZjq0c9/Vr9AlO6r/HZo1Cn4/XQxvqKFKLmDvJ4ht7Q2xrbNrAsfwBbYXvtXlbqgTjsX/nMbvKJp0lafTJMGfZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpsmJPb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpsmJPb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5ED1F000FF;
	Fri,  2 Oct 2026 09:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932488;
	bh=//8fxdMsJh6/kGtDdgLOpr6PPslJ7sGIiQGx+p6a4P4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XpsmJPb0sdEKeIq/UesdQfhLDQk6S9g+A2bIgzdI/7FdfJJvc81oavlWgIC+Qa6dm
	 2o9HtMRYIQQ/lLZ+hmkUI9dYaMPIFiHwkovmCzfugbzp+0ltHoDsg6H9DTk3DeuEKE
	 nSaaj5gx5Dai2z9yIUsrzcntO7Dxep0Jr1ol4AUknDlRvPQ797z0Adld5SjYA0WvDI
	 6KMEeiWciWSZQzrHE15B+5qz+JX0WChssvTgiCd4lKrtE+TY1ToAl9I0PXc0ybKi+I
	 ZuByXYnVxLI6+aqVGWbrhmtHPn/lhqLRFAg+Gsgd/SjbhG8RO3ODIxvfeNSxquYXDG
	 ZAUTnGj9psfnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with
 __stringify()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-modules@vger.kernel.org
In-Reply-To: <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:47 +0000
Message-Id: <20261002091447.DB5ED1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-module-str=
ing-v2-0-fc7438acaf4d@suse.com?part=3D1

