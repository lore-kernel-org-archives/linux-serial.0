Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280604;
	b=bAqr6ZIJCFXmoHPPDbpoqDCFCSRucwpe8IclwAHGkM45lif/2bCY2wU0DFv0ABGoooSU
	 edUAIF0Zt7KoCuooTpSaXPuQU62JI0wR6r3thSkpnCuDxM8C2I2FiS1VTG6bI6hX+kTbh
	 7OZztj2AeX4S+Ao8OCqx0eAq4Cs4aW42Kck5y8xx0Lzm+TvvY3h0/iUzJtcenK5+KKnw7
	 gbtAjycaI1Mzb9mvhLS9iwxd9PDyO2LjqPRQleos9GsgSecPY8xK+mMe5KSutJ9teofWu
	 oL2407583zenPq+iTkijqW8SO5Rl5GXPrhF9qL/mkoZipFhUfRelzwSSbOzBs58d3gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280604;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XxOC4789lS6zZSC2gZqfsVjpVs62x6WkCqEm3a2N6K0=;
	b=gnV832M90mwq8rWltqBSXkcwcQV+UhjSdgdTt317zhfhM6vc46CLLoURhzNa0qya71d6
	 21Ip20KXuYjTKLGOhi2vU5/0nyo3fU5zBVyF8effdtCby3L+pZu2pwuUed9lDfpUD92nT
	 2u1o8BfiyNj6GAVEQMYCNM1BF7HuiHjz+71OQ1nKkHMFFfbSFeUBIi3aR3+EXt3Ige1VD
	 ZyA7srjS0K8RLZHsuci/m5tMfcojmN0LavXXde6OaNqHTCzzBbR3d1JIs866Ye5c2TtEj
	 Ce3En/01y5aUHdguW4JNL8uHxBjl6xcs8Ev8II1EyWbAC9AhbQHHYsyMiavQvL02cSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mExAZtNK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8930606A31C
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mExAZtNK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB281F0089F;
	Tue, 10 Nov 2026 03:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280603;
	bh=XxOC4789lS6zZSC2gZqfsVjpVs62x6WkCqEm3a2N6K0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mExAZtNKRNF1++OLls4d+5Ce3vSMBmV3yrxf7RIo/HvKas4cBXBnxS9GPPpj/RKeJ
	 y/7ZTDKp4XZr523f28U8P2dQSZSmOTbS9Mh8wcEnCos0OdkdYSBWJw0utAhfinznWs
	 T4Rte5QVNtl7pwkgfCxZVvFX19YOfC+BWY/wgYLFWtMDdCaTzCuN4mI6y7huRthX3Y
	 izFmRwtQ8OsnTcXiOqgFGwaBkttYKz7WS0pU2nMRLHhAEVtub9HNG1Se5CCsXWZaeX
	 IU8WL3Kac3WmuWIaK35TqykhBjP0cdcjUTMOJGuZivuEO6uHq1VZJejXaTlqPWPOvE
	 /AAC25rOgsXCw==
Message-ID: <sashiko-outbox-206099@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/11] serial: 8250_dw: select port setup through
 platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-2-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
 <20261109-submit-h616-uart-fifo-v1-v9-2-3f03961dae8a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:16:43 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Select feature discovery and DMA attachment through a platform-data setup
> callback. The generic callback probes the optional registers and attaches
> DMA when a FIFO size is available. Integrations with a fixed configuration
> can supply their own setup before the port is registered. Allow setup to
> return an error so integrations can reject invalid configuration before
> registration.
>=20
> Replace skip_autocfg with the Octeon setup selection. Octeon is a 64-bit
> platform and continues to skip optional-register probing while preserving
> its existing conditional DMA attachment. Select the DMA setup helper
> directly for this integration. Keep generic setup for devices without
> matched platform data as well.
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-h61=
6-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com?part=3D2

