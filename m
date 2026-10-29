Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250662;
	b=jY3bJzzhA+ALKYibJ+M6f9wRbH9c77tRlmbSeRNaqdxPIUxBhfA4Sqmj4TBR0C7JUuSW
	 bMnDe8RBo0MKreOC4JqMQF/u6alXJsZs8AZOmdDHw826VUfwSHggMY5zZcUcmcMnn0+q6
	 o4zyP65cgk0OiU/+0BQ7rob9bcp+/b9WL49X0/UsDsv/93DHPXmJ98fdakIe7CJ4lIrFO
	 nLJAhSP/gP91IT7WWZnATBbn12XbU3o351ISZaO0xzHrCfq2+Ig6T5gX7IweYh/yyL1fA
	 w31Zst/WnPd6XiNTAjXGpA7DNpDCqr0XfFv2YYtEyOCSbTdE7Cj80jvLkffnQoIvrAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250662;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i7L++0L8ClBYBaT082QrtqA8rLg/805VwaGfTk4oYK8=;
	b=hsQpb9w2Qd3QdYr5QdPAU8sNzGkmvwAd3wg19GuAUr3gsIPRHCVQZOAXB96MgLMo4DfH
	 Mw8xY39YXAVsL9KCdwJq1eJYT32j4ROk6opWnTmjaunKIklfav1s3E3T+aFIcY3LULg0j
	 eX1pDHesmExYUZ+TyuYxU92g0frt+hnRQoU/622MwMASWXzmx2vgAWzU+wepTtdMAV8Ue
	 PrrAocGnsnLR/2mZKfkC9OsyKHkvZWi1fm4A5eDhnrLFZvV9QxAa6EFh0o9W2egnGEy1L
	 nRSHOZfmvwWeDDYOwWhb98VbB+y0iJM4CZlJhEstUtQndAMrMN0LV2wa8f/y0FgoSxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQfG6MqX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB21606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQfG6MqX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853741F01825;
	Thu, 29 Oct 2026 05:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250661;
	bh=i7L++0L8ClBYBaT082QrtqA8rLg/805VwaGfTk4oYK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LQfG6MqXYfQ1lCOZVcf1sdFb5vnxaVlC+pUQTBLrVmL0ZCFjxsPDtTZEF4ynXwmH8
	 lXs0HCHsZFkCeHF2NfbCCuQophODaGPSAudwl7ooGs99NUUsNI/VVSwlnDmCpXgyDY
	 ZxamIz/ltmDmnUYEIZULUnArrIGqgPohg5lzITy+10mITHRFOax06DT5JJpJR1I4g2
	 r8m0eqSfqUW4j8qa6VCbtMljLDC2aJG1PIe/CwXkWMfslgVm2uY3tzIC829HcriDut
	 8zJfX8oNaV0M9M/ruotei2mzXaMFxywxWclwbxv38qHic4rBbWB6bv9n09EQUqRIDC
	 nKyEDQUbYUscw==
Message-ID: <sashiko-outbox-188736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/12] dt-bindings: interrupt-controller: Add BL808
 PLIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kwanghoon Son" <asdfkwang@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-rust-bl808-console-v1-2-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-2-b736ee920078@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:11:00 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Describe the BL808 D0 PLIC as a T-HEAD C900 implementation. Its
> interrupt specifier includes the source number and trigger type.
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-rust-bl808=
-console-v1-0-b736ee920078@gmail.com?part=3D2

