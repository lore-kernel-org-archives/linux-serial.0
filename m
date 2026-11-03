Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742365;
	b=ZZID52uMWRTE6BHgvOMqG6frakjxoZSrt0Y2wpAD0KXi5QrpcLrUTql3Srh7/C+JqSoG
	 IY3s2LkAIZ0qPm2dnL+JwVM7S8BhcpL7Z3gaFMZ5PyockeNDOBjNs4JMpXn0n0btDYELK
	 o9Ewe5j9qMpy+Q06zatcvAl8QSk2wiIyzS84HOUw9YC8T3on2FDoBH2Nl4G82eQT81a7B
	 ikbkWG9pzgLIh9fQk2xGuR9Ej4B4XGw8Eyx70oN78Q2un6jAeHwQHh0mXdZy9l6V4xox6
	 5B5fnlJbbwchrJRKH2pa0gxhzR15DTBopUF6kUifbubAqT/c77JqQ/zBbAvZ2mr6+4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742365;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SGvcNrLAfe1g809SQJorhm64W/0VmSRWz/yOQckjQak=;
	b=tVl7CcB/Ik/w7RCiHFPFWOhAiS+Bo9OuRGA0l9acVeGdIThoRuTE94Bg8k615XcSClzH
	 GmpFORq24a1bZ2AWMUJwS5L+Q6shc+ajacsxXKCVwlvF48oubS36Af1ppbXlwekNV/bHA
	 4XBxl87xXVresNb2VcGRoRvVPhJFd6JPnzi2RGpoCJTPThv7EE+ekM5zc8NxbaoA1VTf1
	 2Capdhv2iHbk+F4dhrUsJe854jRwgFH0ZfAuAoyLAxv0P9RX26NIMtvud3AriFQLcDNaa
	 2AXwUkjuQiJUWZYTf0eoU3+LTH2WT4GGkduwVrE8xZOuuD4QA1aREx7lg/Qb5y69pyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lo91xMGd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045A606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lo91xMGd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178EE1F000C1;
	Tue,  3 Nov 2026 21:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742364;
	bh=SGvcNrLAfe1g809SQJorhm64W/0VmSRWz/yOQckjQak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lo91xMGd2+3BWNKgDPRaAubpm14wVDioyqRrL76o1ecvWFHR8BtVKttuPHZ0woHV8
	 rEfdpEYIqYDdui8ODNvC4sT87J7KrEXSqwxcn5I0x8eogxLDbTl8Mg1J/wBkdmDqYw
	 a+1ar14cv7ta/aAnSdQzUw5PGTwuYvyqSgmEbJsEHpa78+6UHaBlu2/GHEi50kIajF
	 MXG6ihroPdHuLXkBgX2doNnJ/TEMUDJFRRG8ahJeDYHGG8t2Bkk3bdLca4h6dOOAX6
	 OmxGrRrMODnJkvx59rFMx7FnlUbbpq+K5aFqrL4Ox0chBB29VslgR6odUu8LI8/IWZ
	 xymmlhGv0beFg==
Message-ID: <sashiko-outbox-196074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/12] arm64: dts: allwinner: h616: describe the UART
 integration
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-8-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-8-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:46:03 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Identify the H616 UART integration on each of the six controllers. The
> specific compatible selects its fixed FIFO depth and integration-specific
> register setup. The driver uses that depth to derive the shared DesignWare
> receive thresholds.
>=20
> Retain snps,dw-apb-uart as the generic fallback. H618 includes this DTSI
> and uses the same UART integration.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-h61=
6-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com?part=3D8

