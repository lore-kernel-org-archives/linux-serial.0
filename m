Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA821ADC7
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440955; cv=none; b=XMeB56U5H2GXy+CreiLzqwJR1wfc6cT9Wpdppx2FFKfC+UfZEI4eBA+pQCRqUsALa1/rvlwby81W0Twvtd1wKDXk85e8trz8cPRzHNyiYQC6QRqVvehyzWjrmz+5Gaw/GNjR9uHTyGlqo16Yvxvq862XUeM/PiphDR8HXLBn0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440955; c=relaxed/simple;
	bh=yrFK7QsybS6CHUGjTSkYJbHsNYsm9ZWDr9AbMWSTL+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ex+ZITHRrqWmICt36eFwREiuH8tVCIsF1WGech5xuPcjHn4uKJj42o+JI8rO6xt8Sls42HUXwhIHiR/mIgtNApl5Km2xK7T5lmU9+mepGHbNAmM8W0nH//v+hfDfeH9IDwT3BpeAqzuRZ0gFBXbH6BxMOo7Gdf7IcTrzt5jhQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACqP650V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACqP650V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914491F00893;
	Sat, 26 Sep 2026 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790440951;
	bh=yrFK7QsybS6CHUGjTSkYJbHsNYsm9ZWDr9AbMWSTL+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ACqP650VRYdCAWroAuKQ/PLE3vsfZQIlxLhWKlYcfFXuj4fMy1iNMMbHD+RvnbOQJ
	 MFXCgdqplQnwsyZVY8pMy4wqtB0Edw0N14n/eIkdVZqi9UK4JOOScQTF7U6BRFAEKz
	 AqlEn0DujCCTSOZ/OHWPBlUe2z3ADNAloMGRZwe5bF94Z+JprcLrW4ShvloSIZdMFN
	 /L9Bck4sKeHvL4zCRGTVKxkYgBQaFNvwhEFk4TBOo1L/2CWOLp8rtvNpGPJ9XfjSd9
	 4aabn9iQHSwCH1Fk6DlTw5yE7ONrgzV8h6JsrkoDKPEqBvl3OpkutbZbYHAMfxiYXA
	 oVzBri6TPAJhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] rust: block: gen_disk: use DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: ojeda@kernel.org, linux-serial@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20260926163551.52371-4-mohamed.osama189110@gmail.com>
References: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
 <20260926163551.52371-4-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:42:31 +0000
Message-Id: <20260926164231.914491F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Replace the ScopeGuard instances in the Rust block layer generic disk
> implementation with DropGuard.
>=20
> DropGuard provides the same scope-exit cleanup behavior while using the
> new Rust kernel memory API.
>=20
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163551.5237=
1-1-mohamed.osama189110@gmail.com?part=3D3

