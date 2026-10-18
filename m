Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55AB4A7CBC
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331549; cv=none; b=TD3QNbah/C/x5X7V815vabYdefAdviWa+HplgPfmlX5R94B3N4qAAkuJP08MPya+YPzT4LmviwUOQCGGq+s0nb0kWFqO7rv66kW+30+Ce/CazB7opnIIjkbtGOHcgCGMAx4eXAx60AyQeGjx1crPPc4IJcBI+cPKuWPBiTGOtvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331549; c=relaxed/simple;
	bh=0XXjzV7IADtIqzWcdtGPN2MC1LiHofmQYnFcFDuhDfM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QdxsmXd7+PYL31XdQzzImIFPUbCvc7m7N09BT+7iCKvGVwqcza8+Mhmgbfc2C9epZc1syQESuH+2oJ1jtqEB1qguDqPgy13CxhKiUhg2VkiAhKniW8NeO2eflIkGlt5wjMwtlOJJvOKZ0zCfDiYnJMJ8YxQ76z9dXtPEiHbsXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEV18/XX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEV18/XX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5958D1F000C5;
	Sun, 18 Oct 2026 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792331548;
	bh=0XXjzV7IADtIqzWcdtGPN2MC1LiHofmQYnFcFDuhDfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GEV18/XX0258vndn1PiLPnHQPLUicSz+/DXbU/BW6FTfuEytHVtFC2FLEOfTUDmhn
	 vRoydyHF+3s6gcgXsdTBG1qt3HXLSeXC/iDyYe3N3PQzj2UpmcVWpbGAmQCXD7dlDY
	 1QMxconsliZHZfC3SZVgZDQ00AKP5D0ilUvpLvbcOVQOdn/yvZ6v97tdDzGixBpEtb
	 klc17nVknAfz+JrS6Ihqeg7Ai2HTsz6leHOErndZ3oZs5mYi15cTk62NtbkzFmVmKM
	 cfdIYKX9nC0sHDnNmTqk+zcsrnfgl+MuRupZ0KwByeF50aWVINlNMXXkwoP9dv37l6
	 5PvhyADsLliQA==
Message-ID: <sashiko-outbox-176163@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/10] sparc64: retain the DMA segment start across
 SG entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261018134738.1016106-7-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
 <20261018134738.1016106-7-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:52:27 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The SG mapping loops reset out_entry to zero for each input entry.
> When extending an output segment, the boundary check therefore tests
> entry zero instead of the segment's actual starting IOMMU entry.
> Adjacent allocations can be merged across a device segment boundary.
>=20
> Keep out_entry for the lifetime of the mapping loop and update it only
> when starting an output segment, in both sun4u and sun4v.
>=20
> Fixes: f08802572965 ("sparc64: add the segment boundary checking to IOMMU=
s while merging SG entries")
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018134738.1016=
106-1-linmag7@gmail.com?part=3D6

