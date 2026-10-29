Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250785;
	b=wQjCHGrfn7w++OSyfLxSEdBki6Nj7Puc4YcY/nO0dOzcfFYr7qQhYratsxuO/9OsBGyT
	 bG8aQwEHapYn/YQtH09nRM0qIspxH2lsF8ZTfLKyR0F4I1vgUV+5OZ4m1vkwEWH1YZDSG
	 IbqmLv6uvdS18YIOjoMoijCl/oNbEv6TkoDO8Q8Le4Cd3TZ20HQxJRvVxkUg2JbyKkmHN
	 T1pL8SUlGJT7eY6FG6Oc2UNYA2GNAX7cTiemQJiQMKkAuPe0N7khqD3kHaBUMGgGOC7A4
	 ObjnZkg3FDV5vlIslaCYDKX/SUTdOXmIvgJlbqY1KKE5bPR7hjNpJY/DHVto5YwDSJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250785;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6HGvkp9T1qOIR6TNrkel0RlyMfKvP+RafWLtLrD9OE4=;
	b=CMUdl2YCRdsmsRbHw1BFd9Ujbuwc1o1xuvbySuwKOkK50eEG/9raSyL+/gkfB52cUqKE
	 w6MEmnKLX/ExXvVirryl9eI8w8hqB+h3H/2LQEmwhUXqidVyo3jc/duV0lApBwwd6E5vZ
	 8Cxq31Q2jKiPNrYtoC18jtP2nKIIfwPBTV0Z0tKt1z65LyBTN11+SboGnfuV+ZZS6Ty8+
	 Oo+3+JghXzyllWmmioJ3876gTJYe0obMMksQiHM4VAldua7x58jqPcXlinTh//4itirfc
	 YAxQbfYoVwqv3uOBmqDcG+mqQlfUfNgPrUTJNM4pPDzwjTXNcEBiYVZm7ON3erFISNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3qH9Nr0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD6606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3qH9Nr0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CD21F01825;
	Thu, 29 Oct 2026 05:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250785;
	bh=6HGvkp9T1qOIR6TNrkel0RlyMfKvP+RafWLtLrD9OE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G3qH9Nr0eTIOV14RZcIBMM2ymPsoeJ5fNCsjnzZM3v6bmJrB92q7J/DkjZpAd/Y5N
	 UISwnULfiznxMmwG/S2oWzvYm4N83gjLKNmLVOZhNBEVxJohN6tyoIYOIp3blGMaRZ
	 l7tNjG4AprA1LZGZEtkptpWQBWXnGFW2Dss9A+lxBz+PvsVZHRv2Xujmb0BkDyzeEP
	 rue4ppw6qRgoILt8N2XDVtx6FIff7T61VbmBgjo1ZmS30GA80x/7QtDLIgqIh7M0ed
	 ugdiohhRoO0mjBqPpKUFY3WMVO4yxCpgX8Tj3onc4z1fEd2rQPcdYNBuMH8BhUeYkv
	 bhBF+V0vIICfw==
Message-ID: <sashiko-outbox-188741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/12] riscv: defconfig: Enable Bouffalo Lab SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kwanghoon Son" <asdfkwang@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-rust-bl808-console-v1-11-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-11-b736ee920078@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:13:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Enable support for Bouffalo Lab SoCs in the default configuration and
> build the BL808 device trees. The Rust UART driver remains an explicit
> configuration choice.
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-rust-bl808=
-console-v1-0-b736ee920078@gmail.com?part=3D11

