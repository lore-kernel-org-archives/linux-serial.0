Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894849;
	b=Fv0ILzUkxm4nCouZPTmBfhIqVwO28Y6LWfoINHxsSQFo+RCczHVu83vJLSAcYuqyU5Ar
	 myBOktp4saDfxDZRV/fV/kkOyEskrhMFyaA5KX/VjmuGHiAuDj+lJ161n3Z/e5LuOwNLM
	 kSukbXNbbySRSuRNmKzT5tQic1QexjV28TQAooLBgZma50opgcywyvoQ56WIgv7NLQK68
	 lYpkF6uUIjfhqE7mJq0jngZpCgXby+eX8pQI1o7QGRfjogybACB03g/pnaDZe//ZPAhqf
	 P809p3LjrIxBe4AWogSM6Yk6yffmtPozULSXJkPtRAXPfFj390W4eVxaz5KG//ATS/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894849;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s6Ddw/yI+mjAY8qV4Nl9kgRhIyuqzMhK4+qg7LDAA2s=;
	b=QrtxCV5KfCPgslahIMoz7uhM5sNtJpggvklxMqPMgC67NtwQ+zEfRYoDa+6jBct6anjU
	 TtcCSVDCO9w69myukYH82dGYAuNEUqgOb0trgm+139n+lil6ICQTBp7M2ZEVhukDdQ217
	 YfSzdAiFEqwyWYBONPLePkh90jU6unlFQQTCawKdINBI4c1TBU5dOmfSYP33AjyknixsB
	 mBZfY3eCnh1RRZWccWCOqFwdXL6fj8v+nwP3lboNPmp+nf0pyOdNTUAEKXu8WJu2FChJC
	 9P1eIY4BiyIePcoxNNrpAvR2ZlzYX52/qDcJTyyu54kY08X1uOTvjLtrGYo4dwF1kMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOhuvQdh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73784606A32E
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOhuvQdh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C521F01825;
	Sun, 25 Oct 2026 02:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792894849;
	bh=s6Ddw/yI+mjAY8qV4Nl9kgRhIyuqzMhK4+qg7LDAA2s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XOhuvQdhm0twjs0Qz3C+agZ404ryid6S9Fh0Y3BZVgWQzoX3rLTBmoTCNIstNG3Wb
	 /gNoO2nWGPXF/e8TFs2l0nkq7CZkAZmgL1Dpv24pyXTU4+7f8Ws6UvQCi2peLQSrbP
	 o/03KQYRwSFwkyv6fAWPdoJwdrkELzWwKLQYuwNOfV3y0ZBFRkJQ92hY7QG81hosv7
	 lQI91Vlt5Gz91KCyWOyrIKyD8x7VAovooQ/ZBpW3SwhpRQGujgCYIsj/i5gjahBBch
	 2hEiiZ7aGGKOfJgBUqbtw+GY2V7gOo0WYOq9dDQhVP8Z6xVdwxSi4P/svdTa0Y4HeC
	 rFbi3qNpPTVRA==
Message-ID: <sashiko-outbox-183983@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] platform/x86:
 lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal serdev matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <3827984795c4bd797008652a49b069151e1e8be6.1792856688.git.an.wu@canonical.com>
References: <cover.1792856688.git.an.wu@canonical.com>
 <3827984795c4bd797008652a49b069151e1e8be6.1792856688.git.an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 02:20:48 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The software-node-backed serdev client cannot be matched through ACPI or
> device tree and is force-attached to its driver.
>=20
> Pass the modalias to serdev_device_add() and give the serdev driver a
> matching id_table, so that the serdev core binds the two through normal
> matching. Deferred probing is then handled by the driver core, so the
> -EAGAIN translation is no longer needed.
>=20
> A failing serdev probe no longer propagates out of the platform probe;
> as for any other bus, the client is simply left unbound.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792856688.gi=
t.an.wu@canonical.com?part=3D3

