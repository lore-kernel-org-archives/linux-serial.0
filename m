Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947413;
	b=hlLLh3APYJ4UVfbBSd90jpT+CVZXSJm2guR766bNxLS8motfU6x8C5lgkamJEEhS+7M9
	 JO2SIgI1NiBi3xE782Usp4oqOXbEV5SZUrxXBjW4t1WSS4LOo1stvqhv3i+4rTFtVM4Xx
	 GAA3Yp9AiRR47OjWa+teEhe/z7Q1Hcx01A59tNfrivUsvs+QqRso6gYQRcG/nJMT77rtS
	 XLAmCtQfATM5OoKMFnAOxV+MEO/AbmM/GZyEKXRfVTg2arGvbW/HgdtFoQmym0kHMp+c4
	 pfuzWaxZFU6xu3PXThmB6sizJ4Ok6qX/BX59Mv/XV86LYajWizxDEqAI8GMqfwOC7qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947413;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vlr6y7Yzb5jUg4Dqba5/EbpRu9+9pDrOtkRWstNls3U=;
	b=DYVrd4qxwe+yAic8vYB9/ydAJT5fLr7Yp+0ZY1AlKSwecd0suA7BSGnPxe8seylLyvg0
	 6rPnC2VPSCkw5gL35N9TNKJYjvZ8Ov+Zo//3mgxwZnTBhIh++1jkkLlRH0wskskdUQAQe
	 KxuIF1pqLd2mEpWzdzICrauyLU2m6pLrSC9DSojBME9o1z4BfnGp7tFRWb36DFXAI4ZUU
	 KCg/Me+xnVXPmAAp8KxgPS0flLlMsn0wM16ySyhq/KHs6B1OWpq0q1mmzyGYnBm8fqIyo
	 ATNxnSRBjXhFIJcxmOHKV/4z5/4jdj79+auvVIOiqKIlB4lj7cAZLyHtXRTl+2tcsIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eknIbkK/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED222606A32C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eknIbkK/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7050F1F000C4;
	Tue, 17 Nov 2026 20:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947412;
	bh=Vlr6y7Yzb5jUg4Dqba5/EbpRu9+9pDrOtkRWstNls3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eknIbkK/u+Koy8ulSTW7+wPvT9d0fdGioFhQ/catzE/sx2L0qe32ETYf3xddSmvGm
	 UvdjEqYxE55CResMD8IQQ1fgS5u6mekp9YJD5TPckZv5Mr7602yhhVMZKEXCUvxQyd
	 0k6z01xUntoH5MxLcgZqGsl29aAv+E2/yZG/OccEu9afTU80vLG+mk+s3eEY0TKLyP
	 DMMbJ/pqYZyYxMnGHPg/3kmp+yjMjkZNngxgcM/b/1KI8rqWkxo2ea2uW8Kl80iLs9
	 vOsiaQtxelOG+pFtUxuzaRdUtxjDgUtfn+b0uORGP3hhXIUkDcpfdzdrtshsb+TDMg
	 SmodHpR+nTT4w==
Message-ID: <sashiko-outbox-219609@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/16] HID: ft260: i2c: fix large write transaction
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-11-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-11-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:30:12 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Fixes a regression from commit 5afac727defa ("HID: ft260: missed NACK
> from busy device"), which waited for bus-idle after every HID write
> report except when the report flag was exactly FT260_FLAG_START.
>=20
> Multi-report I2C writes keep the bus busy between chunks for atomicity.
> Treating those middle reports like a final STOP caused ft260_xfer_status()
> to spin on -EAGAIN after the second HID report and fail large writes.
> Write-then-read combined transfers still worked.
>=20
> Pass the bus-busy check policy from the caller: ft260_i2c_write() and
> ft260_smbus_write() wait for idle only when the report they send carries
> STOP; intermediate chunks and the command phase of a combined transfer
> do not.
>=20
> The SMBus side matters for register reads. The command phase is written
> [ ... ]
> Closes: https://github.com/MichaelZaidman/hid-ft260/issues/35
> Tested-by: Chris Keeser <chriskeeser@meta.com>
> Reported-by: Bruno Giacomazzi <brunoceg1@gmail.com>
> Closes: https://github.com/MichaelZaidman/hid-ft260/issues/42
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D10

