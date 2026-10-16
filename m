Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A13FE348
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145638; cv=none; b=KepUO6WsDAY1bhJHIZK46eZbrLoLEi5he4MBF0ngjNmu/MmwmYzOHV0tsIkZXQPrvEw1q+4Wr+fIqKEtIEqiC8IhRYlY41WNWAegnp2Ji6HxPUicdVnjRdwPWOva1ueuaRwN3SGSwvzH5y8tC9raQ7v3PNzOBppOsdVZEo5JHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145638; c=relaxed/simple;
	bh=FKApaEU80SlpQV9tUNtRxJUjzESXdRuMQXVGC0We+q0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dKzLNDFOfO/Kl5MfJBlF/6ZECYnaVRIg3OzXjeUsQwqfkUwW2dZBRNwrA+U/tMSx5rzUMAqKELoIroqwC1rjg008RwWXtSoswre76NiwEPT5EEvVmDmKPeVRWNzk93LaP7tfXy+NXBpw9cc2kyPewC8VAFEUTGoCClsEdY8klpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7v7/RAh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7v7/RAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28391F000C4;
	Fri, 16 Oct 2026 10:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145637;
	bh=FKApaEU80SlpQV9tUNtRxJUjzESXdRuMQXVGC0We+q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z7v7/RAhKmkSsQimaFZcF0dx2zHfWZmWnegaJF64kOAZjqOQJkFKe3lwfH5Htv1hI
	 Vj/iomrk+raPRzVWcL2cgOQNoatW8aDkehe/VNiZxoq2SgktexGSe6NiBRyhfM75v8
	 BT24LDAJpGp9syyzdBMmPHaTCuChc2KvIFT+85+oY28Q3ewaYuEsgZNX3R4Fv0l3mE
	 Q/v+/Qz3FloNdY+1naFUZsjPCmGTCTCQo3+9BCnfuAjQg7YaokKXlNXozRzkNsvMNp
	 J8nMX3jyouyrhOi4v/mLusj06zEgUGoE9Unpx/sxYu1Kx8tbyzo+6gLrZqG+3utZ2G
	 gO4i357IA3Yqg==
Message-ID: <sashiko-outbox-174134@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] sticon: Implement struct consw.con_unblank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261016093357.33294-6-tzimmermann@suse.de>
References: <20261016093357.33294-1-tzimmermann@suse.de>
 <20261016093357.33294-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:13:56 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Implement con_unblank from struct consw. The new function is called
> sticon_unblank(). Remove the related code from sticon_blank().
>=20
> Sticon uses the global state vga_is_gfx in several places to test if
> the console runs in text or graphics mode. Track the mode switches in
> sticon_blank() and sticon_unblank(). As sticon_unblank() does not have
> a mode_switch parameter, derive the value from vga_is_gfx and vc_mode.
>=20
> There is no display unblanking in sticon: only return true to redraw
> the console.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016093357.3329=
4-1-tzimmermann@suse.de?part=3D5

