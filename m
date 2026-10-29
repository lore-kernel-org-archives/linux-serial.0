Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313276;
	b=c7MbWY/o8rGbIin9WJ+F0GRFvNvU9XF4qcprS6yS1s5IHp8tRwh61DBVdW21JSpCz84E
	 N29jmGjzL1HkZD21g2jahoHCXkx/rycYbCtKzltd8Co5puHe7JwvBqDFXRNSnjOT/qbRJ
	 1eOCPHCdLqgB4WtA5ONHaxgT9AX9krVFdYNPA0J/R7aHLBp8vsHj+r171aJiCNURPC9sj
	 kV45q9QKjCDWVXEdKuGJVrtVvRAeAmc+j5ywXDVubJlOF54EGInnu/DNceJplUr07WPm0
	 6uabB2TUYIZHj2CVHBp0WCrxWucFmUKYTR1EbLfVE0hNoneNVa34A/L2CHQDuh5+u2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313276;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MUGQLiQqfErl0mQ+f4OYAAmACw8dh84pQcirvW89HSA=;
	b=PoaXPdW43aZ6jQJtINiBu9qppDdeURbjfNRlSm2udo66GhVUNdgNoEd9Fjsqav24Qs4U
	 D4s51aG/fYIuU47xMdBAxkZaE2f7K91HhnnAAIxojK7cFEp+2YOTU9Mk7WWZQxGciw2OW
	 O3oNZUxibi1WdcMPeXiBWxGA/fO/fW5+BQY+JNw7Y/LsM0dDN/BL/iW54AYVG78KfZIAo
	 UcEHm1+QMPzH2J1Hwj+lHfvpVWcDm+/L1yBo2GHancWVNRQyipaLGwSeeYTIotQo3aX9o
	 YZC8X7BQ+MKBUhEYwMZPJC60Xnzz++p/dMWrdIyFvqvDIEz2vrUfDI91CcfEh1sLflg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Keb3lyjt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56C606A31C
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Keb3lyjt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC761F01824;
	Thu, 29 Oct 2026 22:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313276;
	bh=MUGQLiQqfErl0mQ+f4OYAAmACw8dh84pQcirvW89HSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Keb3lyjtnK9/Ygbjalr8LjScoOUGt0SxqCjMMMaDYyGPT5amoL1XAt3lyATSGf0in
	 yeStpTyWyoJoG2YucEUlRzrUpo48tgb65NVXgENBk36sNIZho8GcWEYYLnYAlLZBAQ
	 9922LisbcorD9X1NYANk7wRJXBS9nCSh9eUHOktvukeQDeOCi+c4nhBg/PVvNGsjNr
	 oPbSErJMiO0fnTnX2q9hDGzbkq2OOLkxV92j+xD67IwGO8fOIMFZyPD2trF8PdApHy
	 NjfPKqlp6nuGaZl7DQeKEiENWSIYwCpu1Yk2z2Ff2LPCbjyrWkLJ4VGGsZ6x1mK4s6
	 tV1996ugfUosw==
Message-ID: <sashiko-outbox-190079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] dmaengine: dw: complete cookies before releasing
 the channel lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-3-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
 <20261029-submit-dw-dma-synchronize-v1-v4-3-fea447d9f285@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:34:35 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Completion detaches a descriptor from the active list under the channel
> lock, but updates its cookie later when freeing it. Termination can take
> the lock in between and complete newer descriptors. Completing the older
> cookie afterwards moves completed_cookie backwards and makes an already
> terminated transfer appear outstanding again.
>=20
> Complete cookies while detaching descriptors in the completion, error
> recovery and termination paths. Keep the active-before-queued ordering
> when terminating so completed_cookie advances in submission order.
> Descriptor freeing and client notification no longer update cookies.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-dw-=
dma-synchronize-v1-v4-0-fea447d9f285@gmail.com?part=3D3

