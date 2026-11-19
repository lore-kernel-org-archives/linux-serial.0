Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082969;
	b=VmkgAXQOWrUw/rFBh2g0T7wtjb5pB6uSXcaOwd4ECXtSRaE3H44TxIAPRNRvO0xNkRZC
	 cx7qKGMBJlzRn9He+ZyjtQ6NFsUVp3CO4njBj0rBK+gywjHBC59GAQotnoHubk6+9Cpfn
	 W0TZ3943hSv55he+uoiNarnxaQOgaPtC9yKzCLR834Sx1x87wDM8Ba9oAWl2Ku+/lQFiI
	 USKy931MBk3eazKi/6qEJmvqtvV8mC+ohlSzvLXILqoXfjJRACu+W/kyk6p3VO9JOQx2B
	 HlRu4f5Wi/+S1Kd0zHlU06HlnorpQFmrMZ/UqmydDYqTLpFREfqRFaBtCe+w9ZoMXWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082969;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Aq7Ul22a6p3e4q+6w+sYGgYeFj9dVD65FQOlkHjIHTs=;
	b=oJm6KGRxAyIoT846heySFiohViOkEW8DgiO6UXq3rNLyf59oVdr1lCwUc/LvBKSln3iK
	 b0QVckH5eob4wA16WJ/su8BnrOjYnbaYnVTyrnqZWuiSJKNX57F+q9LjJ/CVc9Phda7gX
	 F6E4U/WX+k32+dBb8QcvpGl47q2cHbmdnG1vtuDnhNbhHZdGQEzkhLKfc6PS/MKgn7IW2
	 fiSwXv6TmTXBipt1cUZx/934+ESwcrgeW10LWr/VvFBz/KrWCMZcAwWJPGkEpyIq/HYjb
	 g68ZeZ/MwBywch/7rBZeUsDcOl/ig447qDT5+/AuCjguNDf64iehCGdUv0U4tn9A9uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bw9sd0mj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938F606A337
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bw9sd0mj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B600C1F000C8;
	Thu, 19 Nov 2026 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082968;
	bh=Aq7Ul22a6p3e4q+6w+sYGgYeFj9dVD65FQOlkHjIHTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bw9sd0mj27m9nmIE8KOit3WiTF2lT8NvdIJeMw8b2NWl2vw0WfpwhpXLU7BfZMptO
	 ZahOIz8Fe0WpyCBla7VOIcwLGK2GMqGApv57ljagET/XdnMl6OUaWSaCd5BN7c5mpH
	 K5eppZNBVdWKPrwnaW8hAcF/UCwqLx0QHAR0GSG3r20JLJjV8YtnrN1CrE/5JUt5VJ
	 ySC5/F4iUChhKhijX2eAnx6KBLeQ+TfjstoxxwOiOjejz5JoBAOvxcu8gFypXb4Ve+
	 ip1eeSf/64cUyFPCkv/13MXCXEfSRIFTICvfwkLczj6Ogo/jGBmAK88T/ILgdsbCHa
	 W96HDPbcXX5LA==
Message-ID: <sashiko-outbox-222918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 7/7] dmaengine: dw: report residue for queued
 transfers
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-7-3a737597a0d1@gmail.com>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
 <20261119-submit-dw-dma-synchronize-v1-v10-7-3a737597a0d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:09:28 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A submitted transfer may still be queued behind the active transaction.
> dwc_find_desc() only checks the active descriptor, so a status query
> reports zero residue for a queued cookie even though none of its data has
> been transferred.
>=20
> Search the issued and submitted queues as well. vchan_find_desc() covers
> issued descriptors; submitted descriptors need a separate lookup. The
> status getter already reports total_len for a descriptor that is not the
> active transaction, giving queued transfers their full remaining length.
>=20
> Fixes: b68fd0976286 ("dmaengine: dw: move residue to a descriptor")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-submit-dw-=
dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com?part=3D7

