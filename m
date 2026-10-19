Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15064991C
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418807; cv=none; b=oOBIaMf5I3Rg7gAZfl0LNBVCRkn4s/jc6cE0rKpA3wC3MATFWfrsOaUKh+AFtyqKD8S+dnVvouvYAZps9rFGvwATT3JnJWUZ2aXc1eyXD9N4wyewiWHyOYCnbcbyiz7KGAUa58VpwE8kgOLWf54MvxK9qpOlj8BFWFZC6Zg5150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418807; c=relaxed/simple;
	bh=w7+28ibyMlw6BUK8l/ycKJ7GgZLTs6pilpCua3q4ZdU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=J6P8T1QZsm2qoVMZct9zuQo/wfeW+Y8nOo7zjJus0FCVowVhmN0mRofS0/hF6umsPk9dpMMLQrmbkfz+d1M/pu+CIpX90yHyF7FqJqU73Ad3yrswaLzwVexhDbZYW3pMs/3D9Iyhp16AQ3jXKtCMJRKlVqW3gEvzIXS11ARDL1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6H0es4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6H0es4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55101F000C7;
	Mon, 19 Oct 2026 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792418803;
	bh=w7+28ibyMlw6BUK8l/ycKJ7GgZLTs6pilpCua3q4ZdU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V6H0es4Takev2ZHxuyNWbKSW5J3UgvW71FQlvUBHGsdh5/ZlE2gD4YPn8HQC2CY2a
	 o+jjk/jC0CzJBJgy8qdgau8Pl7rOZSbXp/mmkVf18oia1TyxD5x5CacBPHe8IEIZos
	 hOTYaFlsBxPjNQ7mlXOcCk3aA0IMyAGoMMzwG1PQ40h+hagDMADSuBZ/prjoQYkGP7
	 sBtmL33CZK9vqNBSgRvCh9JDOluNHqaAUYm5kIJEhNLFDE0v/5FvLChfsGUyj/Lf0p
	 BIg1W/AR9ipjw3W5iEHypsoic3TJLYmdmHZ3KNUcR/Lv02noIvrrC7Yie8DHelFYV7
	 VgPkqOpwyW2MQ==
Message-ID: <sashiko-outbox-177289@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] tty: serial: pch_uart: add check for
 pci_get_slot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019135441.1420968-44-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-44-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:06:42 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Haoxiang Li <haoxiang_li2024@163.com>
>=20
> [ Upstream commit 970ede67de0e3f6a1e707ec99ae49d80bf3f2966 ]
>=20
> Add check for pci_get_slot() to prevent a potetial
> null pointer dereference in pch_request_dma().
>=20
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://patch.msgid.link/20260623140539.2272473-1-haoxiang_li2024@1=
63.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-44-sashal@kernel.org?part=3D1

