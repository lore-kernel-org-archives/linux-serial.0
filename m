Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082814;
	b=1aKnKMQ3Hs7cLiB2tnaTg/WAdTmWp1nq0PPPc/U69XyntHHeHUKi3oB+/E0LQ/GTgIVv
	 9XTB6iesV3giHT59c4F+jCR6hJkD8vEB+rwUdC21BhamA3uvlVYZjiryLlZ61zGX7x3KN
	 bpnRG3LVS88uYk9q9hlWhi98+cfgK6Xjw3VP1p7F3+ne5/ESbvMgYQP+KIMyCsDmJfMFZ
	 J/+/OQTFfVSioMVHqUiw3xTQ4Po2PANRVaypn2FDxv5tVKKin2jk09ZWUbZr2UTELkxWV
	 Ip1oHXvndJ8SLyrbtqF7JqASJRFmCFh52UCnmc8HusS0Mb2wnM7tl0h5hCIePoAnKmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082814;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ajwJUKik/xb3o5xPxiM4d89Rror4ZT7IxpGgSyDQBBs=;
	b=faqpGFAi0Ot+KPfYyEudUwT7VCie5mtbDHDXXIhh4JvSxARk8f3HgnVs6CSFCNNF8vnE
	 /O1/fCAwoRdoCzE6xNURu9kBvWfvj/2pLYulvpiFhp506x/jK2W47Lq6zTbZ7MQGJteX0
	 mZPZfykvkIEpXazOz4opAEoKLkmFP/3AsUe/Ls3pqAKZIbLYlTWhAS1MZkJ+dSRO5kIcj
	 SyjZsFHValWzd3+IKTJsbXFu57Y/Y1lCE5TiTAu6o9ucDWt5zUNg8iMf1iVr0+vt7xhJq
	 bKIm8XER3uanl7ms4h9v4+G6RzlbQK2TleB2OSovalRAzNlzbHSeLKlyX0rl8dY6TSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEMQDus6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD260A262B
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEMQDus6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0661F000C4;
	Thu, 19 Nov 2026 10:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082814;
	bh=ajwJUKik/xb3o5xPxiM4d89Rror4ZT7IxpGgSyDQBBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CEMQDus6PhFGUnevuJSxvrD6+EiDgCcfW4ZcJovmAvuqO24YWDeCFd1vPfHyJEw5S
	 5VSrBmV9K8bKkErr2aJt/2R+4IiyRFMUDR/oMhe2Q0O/7/YRvh8D7SXHhONXBm1OIr
	 xDFaJA7zMcOO+8GDGrj4NWVCs20M8CG6UvplWOeMWkbv6OD2h+Jxsw9jV8O3mis2T+
	 DOKac6M6hte0fl3bUn/3BYxUreSFIdFSO6vDc166QCUDsFe9nsWTCn4FBYFrLtAvEH
	 0B1FoUucYp7wDBBZTc8E6SDfVfLvVGz3QeSytRV5Tgf48xtA6N7lRR7/cQA3lE7krt
	 Dw4BfArgtRjPg==
Message-ID: <sashiko-outbox-222912@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/7] dmaengine: dw: embed a virt-dma channel
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-3-3a737597a0d1@gmail.com>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
 <20261119-submit-dw-dma-synchronize-v1-v10-3-3a737597a0d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:06:53 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Move the DMAengine channel and its lock into an embedded virt_dma_chan.
> Keeping channel registration, descriptor queues and callback delivery
> unchanged separates the mechanical member changes from the conversion
> to virt-dma queue management.
>=20
> Link: https://lore.kernel.org/r/av3oxznSW_5oH8la@SMW015318
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-submit-dw-=
dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com?part=3D3

