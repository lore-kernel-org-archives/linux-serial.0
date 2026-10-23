Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779097;
	b=AHy/HgOhaF6L+WbajVY2shxFHe3HfsN2y0IKKO+xFhU0FDHT0Twwwtql36IWDKN+GfSc
	 hm1m+ulheN7wcq6S6dfv+/nWlUTg8VJjzeP9uqUlPx9wUI8GdEsgeS2NvnLaDtAWkC4X6
	 Z74ktRmWXq7079wIpAjB/+TK4Z4IYC4KFc8r8H9M682bHvXscumH+zzQc5xBn1fDW72Vo
	 KNlDnMX3Q0ZUFd0QCGtGpNY4K2Xk4ozX8pViEDBk1kvtCL3pYtQXL+rGAFGy3ISTAUeiF
	 WfoV/C/TieiR6/lQBTBgm084z9oPMoOqe4IlcjcgcNxgO+QQBOc2088jAobq60F3SRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779097;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fu4gmYYJWvr2Z8fH+d/cL6dzZNBc2OiKHiSdlT55v6k=;
	b=SRElkvLyxaCZgTPf9sF7whKO8OguVd28spiefw+fjIKtZFv+SRCa6mlwkjl1j+l8YWWj
	 cMFsHvJoye3LDJ3qId+e7NYZ9gJpUso9ntpDCnOC0oX6CWYQV4zX4ddvy65114j3M3v49
	 cmiz9hX1aAAH5GhBsQx1N9fuVkCCKD0TqDp88hLQbfGqQFRMVUmSBg0d9jajUuJO+Ajyn
	 9MZhysDWDgXqIKaZ9TjkP8lr96oFPBCi6cji5DRYaMtXmtFVb1HHQebCXCiRB+ObJDSzk
	 YSGYKYABt5bn8jnvqOM5EcrxVksfTT4KUtthRWGipIqaZO7i1xRGn5FGyWJXLhYA+2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BH7OAgJA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47DF606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BH7OAgJA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4014A1F01825;
	Fri, 23 Oct 2026 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779096;
	bh=fu4gmYYJWvr2Z8fH+d/cL6dzZNBc2OiKHiSdlT55v6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BH7OAgJAFNDKM5fi3DJRIzu0YRK+WcsNAPFwOWhAmkWI2E0jNzTEsUyTlF3xPzhsB
	 60vtyaKtVtRjUsdmr7o8wefwBvIUczxC07IusPEi+iA5PlPLxcpReBEGUQYwX+/FjN
	 Us4YV4Ubvpz/hC1RF6N/6PoAo+WBMi+73b3v7LuLoZUXsqfzPuBxytEpzzHmAUE/HE
	 bjTNUn6iQkqliCCgJuyl9u8AtNXNmgS4aHpCHTtXNMp9etATD1AI6zT9Q0uuofQxTK
	 vLT8E77ZggAt1GlzAYGpSgTobsmw5ZGFJqnT7thtdBjQQoS69c96qmvv2chaxcz+iH
	 Q6u6jbKjuhbAg==
Message-ID: <sashiko-outbox-183051@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] serial: 8250_omap: separate locked TX DMA
 completion processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-serial-8250-dma-cancel-v1-v3-1-d78f9e4c4932@gmail.com>
References: <20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com>
 <20261023-submit-serial-8250-dma-cancel-v1-v3-1-d78f9e4c4932@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:11:35 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-ser=
ial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com?part=3D1

