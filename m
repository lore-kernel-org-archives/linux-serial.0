Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC6447604B
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863371; cv=none; b=tNKKUZdMy+fhiixGVR/Uw4Q7g1KfNsJO6Yimg/KL8wHRZGU0oNkQCtheMoM9414thfVCmPk3f7xsFhS/YhZaTdhqj1j/6N2/e/cesm9wGRqxSWaAubn/7NKBtyLVC7iEY7mBZ2tIlvrvGkXVYG/PyhFqN9fiF7J//Q0SSwNsmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863371; c=relaxed/simple;
	bh=ojwDbnCHvWYSVJ5t02ppp/FW9Dt+DSs+zDbACw0BPj8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Wv4AzU9KtB4IIAIoqsFkxDBwjdNIJIcVUgWcEGHhd/gGZu426O5TW7xh3d7q3AN4e5exhcEIATfEoEbf5zR8C8Md/fjZjafqxSSpLZwPJZOK41VL95XOYuawKVE591sImsttPDmL32dlnLwUIiBaLzoUeM/s5NluAm5TLGH9oh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+w+4Bgs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+w+4Bgs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6492A1F000FF;
	Tue, 13 Oct 2026 03:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863368;
	bh=ojwDbnCHvWYSVJ5t02ppp/FW9Dt+DSs+zDbACw0BPj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+w+4BgsGOr/rWq3CaP0vqHybQwR02oa6GoEjHhIfpb3kf3ANHQoSLFLKYSKdKUlo
	 fNGlcWKGRT1PjKLXjK0RCSNHlVYre7QDBXBqdlJ5XNROq44hZAJW6pHIdP+HkjoPE5
	 fFHHOlmzQ80Q0qCi+OzfVBQfOFmaqHefSprMZRV+fiM1fNZEI8PBzXvQFFggWhVpkU
	 +KPVGNjpqDzRkBM6wyz+6Wosprnlmgo/IoUc0jO++SYIlPlTGjWHfA/3j4DMWtgFKH
	 ZFrSsu9u+RLg9/5DQDRezvCW/UwoxwGwmKjCT2ilXoZgpc9V8F3A/q18O3f0ItS49o
	 fRWocEMo9+vNA==
Message-ID: <sashiko-outbox-168922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/10] dt-bindings: serial: Add Cortina Systems
 CS7542 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v5-6-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
 <20261013-b4-cs75xx-v5-6-4e72aa383d39@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:49:28 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add the binding for the UART found in the Cortina Systems CS75xx
> (Goldengate G2) SoCs such as the CS7542.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v5-0-4e72aa383d39@gmail.com?part=3D6

