Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746031;
	b=Q78nwf1NdJmobGHrgpqvLi7FCKe07NSJzDtUcmVqixhe85JcNcA6pEen1cBkJVx+OZFM
	 SKr0COeCiAKVed2r7yOADm+hP79yHul0OxwN+VA6Enplv1X4l90hWan+h6w6W2KIZKBlW
	 /6qQmuvOTNa9kLtzBX1i+biDUcuuTQxeNB5WuPhQlRKsmK/n9VArzV8IwW84PNssW9Dek
	 hdiehribbng7+8jKoW/EQcKkFbZDfEv70EwKmgoyrsXTQUAIURv5THELZJPfOlInYw5/i
	 0kO8nzwpZ0/mKtuCpz+w5kj5glaMn6yPZl+myowqzAqJ3Hy9S0Rv5J9NZ5051HsDtXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746031;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gzmBjIJmjosMbPCyc2LuhFNwjbDpwP3uJrpZL7ar/ms=;
	b=LtaF56iUNUoZCKXyGVBOabm6oY36aRtzWAkx84oLAJ792L9iU4yjoLtrSRnJAz0Day0o
	 TanHR0bfRkHLVDRaNkDIdDYuREHY2exB2PBaMFkCQp/mMLCB6UQwgYIYcZErvsNl7gMmG
	 aCpxe+tF3gvPTjYO/8/bfskZOIDKp6QjEp+dcmDfzAaY/X8braNG8WK9Jd9+wTYaExHPE
	 RkmWWLq8fHttMnDeEit82fP+N8mPQSSOgcHUDGF+Iy3ujAx8JdKk+rM4dVQ2p32XKgIX8
	 XOp66Bry0CVZUQWDFFIFl0uCdRSA67momcrtys8K9/H+HdxSD1csYt158QZUeH1IZcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADZgB7xZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DDD606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADZgB7xZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04731F000C1;
	Tue,  3 Nov 2026 22:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793746030;
	bh=gzmBjIJmjosMbPCyc2LuhFNwjbDpwP3uJrpZL7ar/ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ADZgB7xZPwjO5yZn5btXlsiIVFHrRX1Bsv6D/MZ5GSOP9k41WEPFPBVt3EFfQ2hCu
	 eyWR7oP0Yj4AMVNUZfmaUHDkUFdV1XRvUJ20S7Ml39VrOn3p8RKE0CAhozuFbByMM4
	 ZdjrSpEiCZafQ3MrhhLTtAbWvE7gtIuG6HyvKmE4PpdsPwj71yiyn0+6qS1wk6uIus
	 IlhXrBFKPHW+CanTI54APqEdaczHHGNc071oYV5reptjSyqUWzR1kgnR7JuljP0nSc
	 XczjAy2VN/MUAYvBhmcYPR910DOFTmfJtZHm3oQAaW1A8BTKKqYNg0HGLMvgs8f/hZ
	 yJYb6pkeu2kmA==
Message-ID: <sashiko-outbox-196152@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/10] dmaengine: dw: drain the tasklet before
 releasing channel resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-8-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-8-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:47:10 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The controller tasklet invokes callbacks after dropping the channel lock.
> Releasing a channel can therefore clear its configuration and disable the
> controller while that tasklet run is still using them.
>=20
> Disable the tasklet before clearing channel resources and re-enable it
> after updating the controller's in-use mask. This waits for an executing
> run while preserving pending schedules for the other channels. Have a
> pending run return before accessing registers when the last channel has
> already been released.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-dw-=
dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com?part=3D8

