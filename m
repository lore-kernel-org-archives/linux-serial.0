Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FBC343896
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040535; cv=none; b=KeMimq6X5EIQxn4pwvJUb966ij1hBTqowcj9iafAHpeZBVDGDQjXUo50XmisqWV01pqVZumY7agvKrO6McFdtJiMsOnr3PpPZNQk5lp5ESl2kAd0HZ7ZTtcc64yWtWztGLPov0q6J+bQsAXV5MCx5ANHicPCio0B2BOLRY9xN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040535; c=relaxed/simple;
	bh=QmLXLUGPfBLFpK3A/Zs3U4xSl2hIpf6eBaqLhDIIGpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jAeIcxrh/FEJCRjwM4PTnpid5gmgdtYvjt6JuQGjzyfUxwfnNRbYesHDyThgroamg8O/yElouw4PXM2UlGH676bmE/1zG/39oJ0BUj5RTUOrvC9AnvIKG9Ww2JvpE6kfitQ66CUqmhgc4XjuqSJF1vhDF/C3VNJ1npP0wwcb7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYfO6EQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYfO6EQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27601F000FF;
	Tue, 22 Sep 2026 01:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040534;
	bh=QmLXLUGPfBLFpK3A/Zs3U4xSl2hIpf6eBaqLhDIIGpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BYfO6EQQhywW0uZfikQoab1Lptx/I8gwtKo/GIt3zT3fgJpFM0NdawJcRmhguqqin
	 vKYsrG60I3qdS/Y8A/duJMGXDgvzNVo3zo1j+Xzme/2qogZ9cytcCsFf47rIFhL+gN
	 lozsvFz2q4e8lbGHE8ChfaKiIkXJuOlFKhqhHjHsjvkRHC6KMuPMgMtPo+CR7sWAem
	 fPL1WLqh6ekmIOKssAnc67Jxop+AtIkmnQUI5bUT+3Lmq78zLuuKFgRGM2zM/6WZGX
	 a11EHi2bLTIR4z0DdA7ZZ03rD0UT2vU1rHHOkIXnWvvWRhJe+snsbYJHjbeMzEQC0t
	 ZPoIdSfd/n8iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: amba-pl011: publish amba_ports[] entries with
 release semantics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921-mb-pl011-v1-1-b378bb057d43@vt.edu>
References: <20260921-mb-pl011-v1-1-b378bb057d43@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:28:53 +0000
Message-Id: <20260922012853.D27601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Jaidev Shastri <jaidevshastri@vt.edu>
>=20
> pl011_setup_port() fills the port structure and then stores its address
> into amba_ports[] with a plain store. The console callbacks read the
> slot through co->index with plain loads.
>=20
> Store the slot with smp_store_release() and read it with
> smp_load_acquire().
>=20
> Found with MBCheck, a static herd7-based memory consistency checker.
>=20
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-pl011-v=
1-1-b378bb057d43@vt.edu?part=3D1

