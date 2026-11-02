Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649866;
	b=pO5TLImieW8cfaV+JOWPU1+RqxSZ5h/hOU3obTWfCZg+CwobmMOouG4/is5iVqVPI4KE
	 PQ300j40x5Es913S5hLn88YYGRfR92Fm5nR3yUuxtUhWOjODow3pSbr0cyyuxB9OHpH8E
	 rbJoL43FVMT47FSXGX/sIfbbrPPtNnEXHCjR7BnFSGFTE7iPTXGqJkljXgQAD6mx/LUW9
	 kzn1RJTCJOh5/x8vnmIUKhgqHqA/n23qd2C4bdpNlGIho8gt1xagt6VoLeDn2m+ZVBBVA
	 oduVD0XITX8Hytg2I3NhuRXoqa5WUVb6KGGMI/lpV4z7KnSo3z5h91fPNIST3dxaNng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649866;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FhdFn/WWChrH2VacR1sRlyZQ8rSCOxcDT1DnJb81oaM=;
	b=bsq/+4Hj+IvSpeemPJ4Vo7Xl2AkNt+uXTf96IeU0akwcgWrSviuYtP9WA2lafD1rJboC
	 dT5vtbFkFtc+axoSy42IRl101qiD+TuSSuqIvHX7018F71HsYLKkBvNepIJycou78A270
	 CYxU85lmPxYG9QqMPTqS00qIOx7jSbo0pX2viFjH9Z5S908QgmkedRKMnwiCCqv16GFO9
	 snpcMBwRLnbTSi+n5vRrbyFhgjjhq6JU8B0Mj2Dkf/hp76sjeISD9Lwgx9ZooDXKQngV1
	 ioDHHLDsPgHO6b8fEml86J4h67PnWdK6MsMco67UZoPAd3/SAIWeMW/KvKp/WfEb9sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4opFoBn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73E606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4opFoBn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D811F00A16;
	Mon,  2 Nov 2026 20:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649865;
	bh=FhdFn/WWChrH2VacR1sRlyZQ8rSCOxcDT1DnJb81oaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m4opFoBn/gcKtMDC0sNpLP3MinpzlPqoRxhbJ1qj+HSOP/Tcwwq+ZJ/mCF7n5TV0t
	 l77ZJZa7Sw2KQ0fsZv8dlPobLqZaKTV5IrjhY37yJdbXVmS8IBuKwSVDzWkBeBPUNG
	 wWO7jmJHFB3SQ0cbqY8+o1RGcsXPQQWcY/9C0GxaOqClxoJw5wu0jJx6l0iH+eg733
	 AQxytbDabjiio/rIw+hezs1jVSLsKYuFbPua6JBgFkIMTVD1XRV3i1b+c9ZqYOtMNO
	 9QhoYavkkUtkBV0bFXEl2Cf5fdYmhNTktLuVLexehVDrYTTp+ixIMxWk1ROCPsZGow
	 dNk5X97DDloHA==
Message-ID: <sashiko-outbox-194052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 07/17] pinctrl: zhihe: add A210 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-7-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-7-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:04:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
>=20
> Add pin mux and pin configuration support for the AON, PERI1 and PERI2
> pad controllers of the Zhihe A210. Each pad forms its own group. Drive
> strength requests are rounded up to the next supported value.
>=20
> Across system suspend, restore only the register fields Linux has
> programmed and leave the ones set up by firmware alone. Release the
> optional pad controller reset at probe.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Co-developed-by: Han Gao <gaohan@iscas.ac.cn>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D7

