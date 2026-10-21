Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571065;
	b=bFtxrRBLh+QmV008dJmJaBYtCdM3BRx+Pfz9dkfuD8D6CZmD5aU9+8O0fyyfEAuDu6dZ
	 trgxzqYZ6ETm1fvsJLnXKUl4A3Vf8OjxWZktBTbkI2UiIzGIbXCIAILzBIszk6YBZuEet
	 yI3cOa/Ht1bvlTjEn80zw4BDgPrvURRtMf2385gdPJNqJ9lSk/mctwdpUwhnzObCHhSw+
	 EH7m79g86h9veba5vZEoRPo/x/FL9pSZCPkWLsVKo2aBN/DZbnTDj+2BGDnmv+wo5V78+
	 hQ7/PiGER6jnalr/bq3CMWIunPDDuOXsv+W+EwOHVDQsUijTQWZThUAqeyDyhERv6eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571065;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o+587Yi6rOQvVsQfNzIonVmDY+myE3lKJJHYGCxOym8=;
	b=RtTLBN4SE3u7ogW61w6x5C3YrGa9a5ughb5xns+FuSXGX2qYDNCDAndSq+j4rzODf9yA
	 0o/dXuMatG1zQ86eYl0RZWq66SVbnpKtRZma0PjvOZgUtRa0wt5Q86YiU/KgLKE7p/wHy
	 2Eo42SJieT6Rc5qJazpFMbP2tz37b1UMLQTcuH/8Ar0XOb8p84Jdjr2XdYQB0DcZzhvua
	 nqJ0WUDJHN33EP+hK2fiEaWJBNjE3kUK8Gp/fFH3ax38wa3euIQzDO+wYR8toQLKBuzuz
	 I6eTRRl9QnNMT9cvyiyFUUkrK8qkR2VpPxCOB+S1M49ch9AG5LwRREYfXDeehiJOIDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6bCvT07;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD5C606A321
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6bCvT07
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFAE1F000C9;
	Wed, 21 Oct 2026 08:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792571064;
	bh=o+587Yi6rOQvVsQfNzIonVmDY+myE3lKJJHYGCxOym8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=n6bCvT07cjIKqlKS7sVZkUeD3R9jma/YnlXIAESvsUTn6MCKc+b4OyTW994fMP+c1
	 ClHvy0IFkylFT5uod/YMcM1MsIEbXr2cjcp/qUI6qSzn2Z+yoapn/uFm5QZM6eGHXJ
	 vVwRtecf6oZWepTIT3zirhG/2Kb6dQBwS6EPzHudtyJiSWPQNU5ut9JCIPB+grEG1C
	 Grd86kHdGTtY3nsnKmBPAnBzWQ/RZc0W44H469C+bLRX4+xs3/AU2jBFsN3opY5UzN
	 vxUIlYG3byEUZr7pWjKEzwv3MiupSzUzAMS2YQzgFPvjWWcjbzbLmvNMzoSnLCisjb
	 hzwqje1/KuYjA==
Message-ID: <sashiko-outbox-179961@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] [v4] serial: 8250: remove obsolete PORT_RSA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>, linux-serial@vger.kernel.org
In-Reply-To: <20261021081746.3278002-1-arnd@kernel.org>
References: <20261021081746.3278002-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 08:24:23 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> For all I can tell, the RSA support in the 8250 driver is not functional
> and has not been for a long time.
>=20
> The RSA-DV II/S ISA card[1] was sold by IODATA in the 1990s as a faster
> alternative to regular ISA serial ports, and it was discontinued in
> 2002. Linux support was added by Kiyokazu SUTO in 2000[2]. The company
> also made PCI versions of this device, but Linux never supported those.
>=20
> It seems that a patch to setserial would be required in order to set
> PORT_RSA when not using autoconfiguration, and this was never merged.
> Autotoconfiguration in turn requires passing probe_rsa=3DIOPORT arguments
> at boot or module load time, which is not how any other uart drivers
> work any more since linux-2.4.
>=20
> This patch removes all code related to the RSA support, with the exception
> of the user-visible PORT_RSA definition. I had originall sent this in
> 2011 [3], but did not follow up at the time.
>=20
> Link: http://www.iodata.jp/products/network/rsadv2s.htm [1]
> Link: https://pub.ks-and-ks.ne.jp/prog/linux/rsa.en.shtml [2]
> Link: https://lore.kernel.org/all/1309211120-2803-6-git-send-email-arnd@a=
rndb.de/ [3]
> Cc: Kiyokazu SUTO <suto@ks-and-ks.ne.jp>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021081746.3278=
002-1-arnd@kernel.org?part=3D1

