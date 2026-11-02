Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648308;
	b=f7+qsi7rmk8NoQAkEpIbCV+dInM8sglgr6aLaxKcm8K/nf4d1cc0hZnBl6yj73fQz4Ul
	 8gSg/3aLO7952po0By9DmO+Mv3rxnQAwufabr+J1v4Ba57E4WvpfMC0ZhT1lRMTv0TYmm
	 XqSbFNez9m+A5YmNUbJFLy4HYUBdR1GXpYXmhqsTwSwnreNRxDBYR6jQHq0g4ZIgscGQi
	 VQt1DIAsvlA4K0VPRRoKrR8FrsN+3ZT7fZrU+AseppkPeFZ4tyDvwoQvyHAHrwGKOA1vI
	 a2/oFjos2vi5P4Y8YN+kWsiYCzn4TPqX+x4NIKfDAYSpuQ44cZv/+7WrEKr72Lw6fPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648308;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D7qlUV+nBUl0w31mSXgU622VViW3fiHDfgPmoKmYCLI=;
	b=U8eusQZuz0Nog0ABAUVXNatTW5T+LRS8Rnc58pWBMy8oVG3i3X1cs54c/faitZM9cWAX
	 u4bB5nCKPsDqnpL9HMnNP4df0/hiQuNBR0X3EyEXCXDeQjhCiATP3x0XyrksSh7FuHIib
	 8ZjNBlN6xqqve/HHwkFr144N7Ic9JucO6zwtqi6dsBex9sA0UBxs2OcVU8401kyQeroem
	 z/apBNoy7s19SILAl8ls+ctkWimjup/3BFveqCaLPzh6/kb9cWhCnBs5C0GLRZciTsQEC
	 H2gYdtv51CDT7u6gs5nuy+YbKYvvEP9OeeG+/+poasKSzf7vVbvkJYv4bChpNgCGxPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZbn6rMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11E606A330
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZbn6rMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F571F00A1A;
	Mon,  2 Nov 2026 19:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648307;
	bh=D7qlUV+nBUl0w31mSXgU622VViW3fiHDfgPmoKmYCLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZbn6rMGwkPjjQH2t+i2qz/aQ8QJJzqx8oeqFWF6YetUfrDPL48iWf/nLY5qgQlC8
	 /sFi44uH6G9ZlHTsL4wSU5N8VVo2AffM3/iMHQ0IWLMM0t0v3NEgXsr+FMiWhEP5Mt
	 aP2IMbvEL7AwCjnIcRRL8glbkdhmhisyxU0tr6T/1YEP7FbpzUNn8zHgk3kprgCxRk
	 Fbzsz99bE2K+h+pBg3ppEsC7ydFQUiSUZGiBcROZy2XS4JsGXcXZiTnO9HF94PXRRd
	 GXFUKa2UByE95pHoHsITOaNa5zMqi5+vS8C3Y7SbPyrZQNYawdf+YX/VhZk45zf+Hj
	 SaRm6rExnuxOw==
Message-ID: <sashiko-outbox-194010@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/10] dmaengine: dw: simplify transfer-complete
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-6-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
 <20261102-submit-dw-dma-synchronize-v1-v5-6-d3207758fbf9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:38:26 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-dw-=
dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com?part=3D6

