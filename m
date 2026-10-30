Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377942;
	b=ZbjasnjYQhjU9Tb9azqhPg/vrNn+nfEaicDVTnayCzyVz8yCtoIFuxQedsf9NATCT37k
	 Ic/jyCWMIzWlmbyzFig8ekgZOyruMOKuEHq70iVxl6eQWlSuPKj9pycXrxMuimWl8abA6
	 gLEnDhZQlLHpyZ/Kvec7gKbyz9qs+ownY6myw323DmOUPKg96Mur6pMyValSY0ftdeoC4
	 R1wCigby+AJ8hmt+4T8JxfwLKM73YyR12hHMpzsfLnuQRgGidCuYpmXFSTc0748NHJ2SK
	 etwBdLAudUpXIZaxZb8WcfDMXTf2I5exDu910BGiNVYZX/HPPdyTpDRdxPSzpjS03IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0/yQMMRNxOjgwv9j1QEHGM1KOsAPCOkIfo5wKL7tiH8=;
	b=G9Wh+jWNgDwPDny/iqExpnGSMYQCG6teVQ/wf2HH/ndOXX6eWGG1DANaMwtKJ5aNgRm1
	 nIo1BM66rPuhcrcvn7LA11JlzbsRuClsXSEwakG9ZZfZKg1Lf9kTL59tEtk/h0LYILzd2
	 nucuPcUuPJaqj/4Ds42XWjrSiXxgBGuvdNJnORipZ3CxgrlpHPhWP1fW+5FYO8HERRU0a
	 6SXScrCTA3vPJSjKNjW6ypo3Ns0RpKite3JpXDwJjoFTN4LWWo68AxUJM9WCjsKMvoL4S
	 Wn6WBtiWa+MAnjx79QtvKpR1UnPVn9Awg8J7GZpQf0RpeJ7+Nmr3WlztUcLqzdFl/SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrAyLMTr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584CF606A31A
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrAyLMTr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2251F0093A;
	Fri, 30 Oct 2026 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793377941;
	bh=0/yQMMRNxOjgwv9j1QEHGM1KOsAPCOkIfo5wKL7tiH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PrAyLMTrNI5mzy1fT3rWJ93krZE+G5hOtqYUAMPXc5MFox/2CktrAnGgLiWQRBfKk
	 dDiapE7VYlfmvqzJnBhnpuNMZZnMgzNbaubUaGMhXxvwaCO33Vp1c0RoqAh7luFTrG
	 D9VnufLqYMG0SaFYIt/Jd61dKGHmteHNLgZwZyZibcOpDecuwV8skvQiYOrKAYgyML
	 HxAXIOVtfT2MrkRROWCboppliaSmKzBZI/i04s5KJqUqsU7Z5vyCAmHm9xkaCjOw0y
	 aVd/7kXK7kimlRAJS1T8ki4pLKpOVbg61kmFpGVckLCmms2xnD9ApNgjIaYdXRB635
	 /CflwLk9GAYzA==
Message-ID: <sashiko-outbox-191264@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: samsung: use dmaengine_terminate_sync() in
 release_dma
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samarth Narang" <samarth.colleges@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261030162334.3000737-1-samarth.colleges@gmail.com>
References: <20261030162334.3000737-1-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 16:32:21 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> s3c24xx_serial_release_dma() stops the RX and TX DMA channels using the
> deprecated dmaengine_terminate_all() before unmapping their buffers and
> freeing the RX buffer. Since this does not guarantee that DMA transfers
> or their completion callbacks have finished, the controller may continue
> accessing memory after it has been unmapped or returned to the
> allocator, particularly when the port is shut down while RX DMA is
> active.
>=20
> Replace dmaengine_terminate_all() with dmaengine_terminate_sync() to
> ensure that outstanding DMA activity is terminated before the buffers
> are released. Both callers of s3c24xx_serial_release_dma() run in
> process context, where synchronous termination is permitted.
>=20
> Fixes: 62c37eedb74c ("serial: samsung: add dma reqest/release functions")
> Assisted-by: LLM
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030162334.3000=
737-1-samarth.colleges@gmail.com?part=3D1

