Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202424;
	b=IWpsX7scrT842Dyl8wvMnMyvzCzLa+NUi8NDxN/1Lh2hMGNEkifvoRE83G55urDVXtdP
	 JmuraBoFaf0sYQQMV1qe1Wq7DOLJOb6i2foAuSPTZ5pq/063fbJWBAO7V6A8UsUY62l9C
	 h0lCgYhPITl+C15F8lxbkdKdiuSbtsY0HyoEMuKFYMhzyUURGs8co083uiLWwxpv4mjhd
	 Clw2AhBKwXONcOgrJHxo9tQ8DQAoRCiQrUeATU3V0jwrn1CCZuIOj5WQBmMNkWALYhFDc
	 sbealiNCEouAbS95LTPASTUNoMcrsx3Fz150mN3yOgzSua7ck52z/SCb7jkmOBrngQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202424;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hx7nF1mqPVpU1fp92fKTPwviqIDP89mPMSV9d9d+yH4=;
	b=B/d+w49jcQEu0zRb8KSoeBfegD/ro7aijh/je6zbteyBKBZsHoCRHgDrwjEDTkFomf2Z
	 MoyZC6NG25Lewh90WvodgUR6lMPFOL9fWG16qYufPYRWjvD4lJvowMGAMKUl+apiFdeRV
	 /BCFB50vvRjlYkwrg9QoVByHcWCpmm1LYfKrgMUXiNVyaU0pOZ33l5jy8L5Zno67N0DKe
	 9Fx4nZ31j++6udz3DvtLW7LOD8wjFRcBe1kLAbYhaKKZiejvYYZ5/zG/2TzChKiBE7uhX
	 oxKTE85w7jSER7Jo9nlnX9uK0pOM7t0jkIn63v3hugWBtg7W+Dm3SOcjom8XRgDF/Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tn+1nClL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42004606A6CF
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tn+1nClL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD961F000C4;
	Fri, 20 Nov 2026 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202423;
	bh=Hx7nF1mqPVpU1fp92fKTPwviqIDP89mPMSV9d9d+yH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tn+1nClLVxShNmYYBwsKtxHQYmgLIKKx/zoKvwvFF9/Gxa39+EG5Z02jVijdhrGBC
	 EI1/Qm7duLzrTqKLHQqNNtacvu5vMcyvPfnzQaqxpMFw/oXmA3YJYnVBLqGfKa6Bef
	 AIi/XPIE/qRaaSifnfZ1tIdP/v72SFhRiy2FJiYW8kV1d17vJM8nEXHQFbO/oM59k3
	 g1Ah0B/epG0J5j7jisyVLr/4+0M5+enz1ki1YHpJPiiJu5Lxvp7LLryC2K14WP/Iw/
	 N9XEvSPfzf7t9PvOxzyU8v1ZdVL9/gKji0HvK8QMXYzukm/qV6FbJ1bDWLvi72GcLz
	 iDVkooE2R3Kcg==
Message-ID: <sashiko-outbox-225913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/13] riscv: dts: zhihe: add Melon Pi V1 and V2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-a210-scmi-v4-11-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
 <20261121-a210-scmi-v4-11-4a795a0a9fc9@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:20:23 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add Melon Pi V1 and V2 with the UART4 console on GPIO2_0 and GPIO2_1.
> Use serial aliases to preserve physical UART numbering.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-a210-scmi-=
v4-0-4a795a0a9fc9@iscas.ac.cn?part=3D11

