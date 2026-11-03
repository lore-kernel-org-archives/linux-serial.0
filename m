Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745241;
	b=vSh4tB6Dbml3XhjO83n6FLCVR/opR7oreG89twoZGRzt8LtNJ/oOgpYVN0U7QRivoKjU
	 5IJ76ugHY6zHI02L0wuxhjillBPvoWz7L7XxHd3cezBoN4kacbm1+Cl3AQ9aUDH5x7dav
	 aTYw5OVRDRUvQqr1C/sRJjUAvzuPCQaLC5YARJwObxHA3JIiF9dpp1JZaLAWP69KaRDvO
	 V0MIj17Y++sb9ulJzezakxkO6RZ58czeQENLLuyYIFva1qvNQooUa9QqehOhc4qXfS73Y
	 PIY7riHnKmpc6DI7dp1D5fAcEPszQeNzh2wgIIhZ7Xu3Np0DpZFXqZe/Er6VNKxnRYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745241;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V8tfgVtMUQD/ZsMCDROnZT+B4hzsD5g2G80SBvNK7lc=;
	b=y7lps0dCfW3iFDkeQhJGkTGoAChQkoeyjJgaOe1SYHAwB/tbVsutFWYOcbZFWY4Czp6c
	 vbntuZW3EJ3248fT6rQe7yNFgv9ooFBt+xTpjLRNlwGDX0SATMtBPx+YRIb2sSLUAOdK8
	 Q7V5/l/zELmOd2bItQeKmP78vB38KNcsbw9uOgdnJX2aVYNUaAAequWfouENkPebL4qa2
	 pDILC99CzPx6C/iMqqaEoE2HGgWKvXR0ZGEu6juWDPOk+E3j6WK+eGpVkHEEXJHSJQX6i
	 LK5FzYwsDd8gNudVnmdIZUmlKjXSubpCDuoBsbiG3wJO/SLwMD/4BcR6y7THDc+M8pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvIp+GbY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6A7606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvIp+GbY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C481F000C1;
	Tue,  3 Nov 2026 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745240;
	bh=V8tfgVtMUQD/ZsMCDROnZT+B4hzsD5g2G80SBvNK7lc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CvIp+GbYIZWCucojYQ4nKW1aMlGg4ScRwslBR5kufmTlTxRBptNUN/qFyqOFVu/k9
	 tvV+VFMiQF84FIpRvT02TeJHe33OWFfvpM1aO+WuaFyIQnOojDZpu1dtZ2UflKvThb
	 LTjFUd2gycFaVaTCCQMv1S3RR0fTIfsSQU0jhygznWx6vGk7D8knyjmGExnNMRgcI9
	 Fuu+TVmykW+TiJZwts6wMSAPp+mFeyYryYSFyBxRVzGJGqru+osx0RCZWVuTPduxZn
	 X7QuuLJLJi1zY5JI4OVO4fv5VZvZctyyhsCEBJ8SeV/B5D7uk2VCSGjmtMUtqaKsgO
	 mWwqvJ8F0yxAw==
Message-ID: <sashiko-outbox-196125@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/10] dmaengine: dw: simplify transfer-complete
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-6-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-6-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:33:59 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> With hardware-LLP residue handled by the status getter, the descriptor
> scanner only needs to process transfer-complete events. Return through a
> common unlock path when no event or active descriptor remains, and flatten
> the completion handling.
>=20
> Only one transaction is active on a channel. Detach that descriptor before
> starting the next queued transfer, keeping cookie completion under the
> channel lock and client notification outside it. Preserve software-LLP
> block advancement before completing the transaction.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-dw-=
dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com?part=3D6

