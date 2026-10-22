Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685580;
	b=RTcmy0YkRVIaRJ3XRqtp2ZWChKcuWvCUxvqf4EPPjMFsbCm9r6x1QBPfZaxTxoyrvwAd
	 ekAs0TrDX1Cd4sccV2532JovONc69K4vdnKHhSRP3OPi2eo0YcCSLg3pT/PZ7TS000twE
	 kPDSsfxOc0nklebCJRpQy8lh/DaH2g8NzHzDcOKDvQOW6isAEdMHQ9lA9kbzx9v8bYQDp
	 LF/1sobYKk6LKgEdLTKzmrIKhadrbEDoJNvNFzBSiSIF61Fzcuhy1Lw6IRKwuvJ1rbuRF
	 Zc98UtYWipV6BfFS0/7n+3IBzYToh2t+DRT3UV9BkHtREWV9RCeWSYImG7g3N568sdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685580;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C5e313gtibJipVenJwOMGPFqNpgAMFpunJj4cC36FJA=;
	b=GqIi8CqIIHe0+8fYePFthWoR7uvhEGIEE4KQUrQcpHfVBSplAladGFTGRQXqjslZ/E4I
	 QZeo4JbK3OQi7CIV25RSKr33jTiH5UMZtK0YThClhnH22Cs4JRxGauTwaH/r/1GJmOerN
	 T8BCfcOg6/6aYWIwi3uoz2qPd8JAcsUwshrLusldwLdK1P7O+Oc2p0xHaA1PqsALJuxnn
	 QVHCjyDSIXsqtdlbfxSWEQTGpMBzR2AaxzslUl+FFAnppjOZsroMf9HSavp8HuPqVQOMI
	 Ab7YUTSiBk9tb7p30vIapM6RzQfjOVe/XUYmptQ8qdwoyIXmElgpRirH7iEj1JpXOzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFQM89kZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DCA606A321;
	Thu, 22 Oct 2026 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFQM89kZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131B61F01829;
	Thu, 22 Oct 2026 16:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685579;
	bh=C5e313gtibJipVenJwOMGPFqNpgAMFpunJj4cC36FJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VFQM89kZK4UIIWMxjOOsbM9cWi/+WavjRSgpd2wGmEgKZAcPxEaTbzDUAV+/Eu6wU
	 dx1RKZ0pJqtC9g75XWxwvQht7YS4T1NV2pfVbeSsohKaQ+IdrKy/u7/kdsgDdeQYa0
	 EKdWsnniZJFvvdlEkWQlO2WK7vcIBYcDvMer/phjKg5hDoi4Psy8Z/BQD/1R79OzjK
	 TgsKBjrBQheVD9sB7GLCawZQz2+8YppQPLFUxclhA5WkeP/SWLK1fJvZZRDpj1b8gH
	 Bf4DcA5nkhHLgFIQNPIu5KZc6UX9ECQAD8vmiAtkDPyL9tOz50xC78lxHd5pOWW44t
	 8leumv0SWhZKw==
Message-ID: <sashiko-outbox-181766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/27] dt-bindings: power: rockchip: Add RK3572 power
 domains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-2-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-2-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:12:58 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Cunhao Lu <1579567540@qq.com>
>=20
> Define the RK3572 power-domain IDs and require the system GRF used to
> check firewall status.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D2

