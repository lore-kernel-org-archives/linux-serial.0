Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4564B1280
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475977; cv=none; b=GWG0cLEmLqbvHYJ0qgY1FoVMwKaIRfy5jnUZ6rxOxwKTuxMyb+B6mAfjfK8CvFxtnaE1D3cF2Mj5Z1yFGMNswJ/tRIBQEyJOfBEmDEf3wVQyQ5EDGxgvYMpY7GxQyq1znk7Kg/pS5Wj2xOQX8629ScdlhWaDLfKA4MZxJN/HeSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475977; c=relaxed/simple;
	bh=PCrx61r+WjhYK6M7NL1fOYENh0kcxb0uFV2ps0JHmXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GRvezE7fUhLKdXqLNBU2BzuPNDfAZIzALOX9oxJznVuCd2yz0QfhJB5if3caR4apUy9EKK9ZWJSznK3MHsAFr1gmLk/imKTpEriQ24RZPRdy6Eh3o4jldwrJPLCu6vvwUbTfHwMx9cvPexRy7WCeeNFZyLRPdgkxkds3xxPLOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDuBmyMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDuBmyMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1C91F0089C;
	Tue, 15 Sep 2026 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789475974;
	bh=PCrx61r+WjhYK6M7NL1fOYENh0kcxb0uFV2ps0JHmXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gDuBmyMb5NUb0f63N0hzpGCeBBwUFKDSsYUOH49EV+yLR1N9zf84PL6llByk/FOYP
	 tuLNCI1URu2g9W/RL3duDIIfpM2ajk+rZTDaTodKmGVCY7rLY+W1I/UBLc0azXTi6O
	 oIU3Tn825ZbPlRG1Ta+5CLIZdx9QULRsD2A0y04URBzv7gVZxopPPtWitfnag7L2Bx
	 Cs8qDKWbWdzop7MokDv5yAdKkM6uktsHF91qK3V91HIQmuwYOdLUcZpsDCTU6fRJx1
	 FShUd2UvQ/HKKVeodV8+7Qfm1jaCJHhHG3fdio3pGcPNvJEBCKu07gXU1d9nL6bk8Z
	 99UygBgXaMThQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] vgacon: Use vt_cursor_{start,end}()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20260915123304.1027277-4-tzimmermann@suse.de>
References: <20260915123304.1027277-1-tzimmermann@suse.de>
 <20260915123304.1027277-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:39:34 +0000
Message-Id: <20260915123934.7B1C91F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Replace vgacon's custom cursor metrics with the shared helpers
> vc_cursor_start() and vc_font_cursor_end(). Note that the _end()
> function returns the index of the scanline below the cursor, while
> VGA hardware expects the cursor's final scanline. Hence vgacon
> subtracts 1 from the end value.
>=20
> The cursor shapes remain mostly unchanged, except that non-underline
> cursors now also use the glyph's top-most and bottom-most scanline.
> This follows the style used by fbcon.
>=20
> v2:
> - restore use of vc_cell_height (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915123304.1027=
277-1-tzimmermann@suse.de?part=3D3

