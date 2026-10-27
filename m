Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144634;
	b=dvGjqRaNrjZI8oN1dKc4jC1XZ2CMHLqI5dbNWNK6hA8j3iO21oNNcXgHdUB0mVnUirmw
	 wqGimkua05d5cJLpmuFR11VUpk9JDns8+3vOGUEtesOQzgFhAiF9JH914AfseW+Mwaniu
	 BhGMAB0VyE8mX/zlKmmRZpk0+ShBJSBBYeXrlLTWp4Ihmyh1R6M0y1NTlxeNBTNWWoXYV
	 nuY9DfjJmsZf+FcHRAsuInBrkwRQAPSEKBzpS2vYFQhYYH6bUZXM9mfL/LHFyr2fTEaLT
	 v1x3MFbRPpKFXFQrTh+WZ5FqwFSbqFIWxMf0iR3zSLPAlDDH5c5XiYh7BoAtezj0tzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144634;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ENYFJTGX9Iq8aDvB+mfHz1MAP1j9Aeu9dbTr//RfLh4=;
	b=pWPPPWlS1hph0JaG7Sbocqjxlrbv0wWEE8ltX0rYweqAmvzeIPxOX/Hr18/zs02F2IBF
	 9Uoh3gCbpDk6NhXeXMTSrS26JqJvDvr07QsB2VXpGX0XGu8kNb4n6atlQVYeTvOmsOQBs
	 RIHuCCKzHeasRPM/gTu+mgOcSg4EQckebcXFOjYJWWxhV2E2ZjW5UUonkIqFfnE4hWwPS
	 fdFp0i5w1FLDjnBARmhT6rd3N2WABGyqy7bqM74FvC1++kcTz4DPl3prEWUIXkgD06xkp
	 xFniAQ0NgS000rSVgC4P8Np5X6u1KCKiptVf/1sekc89NXb9fgqBldS9oN0gFteQ3Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRFJKc5I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57788606A32E
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRFJKc5I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F2A1F01829;
	Tue, 27 Oct 2026 23:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793144634;
	bh=ENYFJTGX9Iq8aDvB+mfHz1MAP1j9Aeu9dbTr//RfLh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PRFJKc5IKfLWIwZkBWtLwOpnT3rlyNM1YGz792PAiI5/bP+2kUESPAlQvapg1WIVU
	 NXXZlNJUhk0e3vCqHDnVmyad3zwl3UGjPbxHsANTl9XibRNybhcJzOYLbxgd2H7/MU
	 mHEyv0vBdA3UuxctTdyzECaKWltMoAO6NcNGpZUqeWkqZOBApqud2JdFOHa5O9Ntw7
	 oppOnwetyxruHlK3LG8hkGNARUt8RLPgGfkfCsUP2rMFft4NwoVEi6xwd9ao6nejVb
	 rGwfiQhfyINTPcbs7+xOM3FMTJBzYmkieI6lAxQO3wJYSjClKk2jfAML+SKCeiaTPj
	 fwqnklxaK5Y4Q==
Message-ID: <sashiko-outbox-187233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/5] serial: 8250_omap: separate locked TX DMA
 completion processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-1-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
 <20261027-submit-serial-8250-dma-cancel-v1-v7-1-985a023ba4b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:43:53 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Separate the port-locked completion processing from the DMA callback
> wrapper. Keep the shutdown check and locking in the callback, and retain
> the existing FIFO accounting, delayed register restore and THRI handling
> in the helper.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-submit-ser=
ial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com?part=3D1

