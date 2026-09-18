Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE0A3A4F3D
	for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741661; cv=none; b=XQbiJF5aU9LS4ZalqSepw7WQIUhnrB0/n+M8SnT57QlV1dWb8oqISl926NEVNzHgGpDTpx0jn0xgkYyz6geWM8itiAG7lS1FauNKL9VCi+Z72/3axkzSJTaXoMskqSrmnGRpiz3cTNjZrzvTr9OyYx5ZAMouMErilGDfEZfrw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741661; c=relaxed/simple;
	bh=vdR5rUFPUuX9zhqxo+TgVt3Xp3wJ+PHZX/ZN52z2tX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dsJkD0B914CTlgXh4B784F748tL86PSaVB/ICni3d8j9wf1dL+0KuKrNIjkRBtm5LkPtXZ5C+YR8VBRpfFU0zMKV02lf7XUCWHd0N82sawDEFdqK5D/kRhQL3P1pePDh4Yd4TGJ9ivcFIpuBSRxwYqua7hfYUEtii9+h17DdaC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYtLs0t2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYtLs0t2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03A51F000FF;
	Fri, 18 Sep 2026 14:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741660;
	bh=vdR5rUFPUuX9zhqxo+TgVt3Xp3wJ+PHZX/ZN52z2tX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oYtLs0t2WS+QWTyFgLHhSGjpCReiVeiJ8Upx/H+Jcs9PYOlR4AjPXmdktCZvSI3ZT
	 L9Wg2PMdIcRmrVg1NW1KXKMbGuvo+HmofOflssV0kCNyKOaq8kwqDYvCuhzq8szHk/
	 LOACwnUDtOk0Ne0ndZs9kn0Q61PWfEF9W0PsIXFkBTQwfC1voOwTZBCnedQU9bbHoG
	 wOdApZYMYyJMWO/IjMAfBA5c8rWt9Qrd/xps0aLjSwGcoYMWXXDN/AuCuhdB1WHrmk
	 nnuCsHPYYaLKwg7/hnL0FdpORCU5m9dMg9rGCRiD9qnJRKb/YxIaxIAz08PK/AduDo
	 SLBv1O7S9gRZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: use assign_bit() where applicable
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGVuZyBGYW4gKE9TUyk=?= <peng.fan@oss.nxp.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260918141842.3023147-1-peng.fan@oss.nxp.com>
References: <20260918141842.3023147-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:27:39 +0000
Message-Id: <20260918142739.F03A51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Peng Fan <peng.fan@nxp.com>
>=20
> Convert open-coded if/else with set_bit/clear_bit and their
> non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> API.
>=20
> Done with Coccinelle semantic patch.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918141842.3023=
147-1-peng.fan@oss.nxp.com?part=3D1

