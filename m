Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BE4BB276;
	Mon, 12 Oct 2026 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826407; cv=none; b=q5/IEspCo8KDnzpjKQ4jFhKoV0jAVxMJ1MbnWIl8upNwIkdw9oxN9yrbF8qPViMb09PDbY6ulNLZINpu0uwutENUvJ7si85hCYiR4nr/TzR0aER/kbAJEHL5gLrFixsvE6+Uhx/UzthbfPNmuNYQ02poYf5sYz7xmn2ar95tg6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826407; c=relaxed/simple;
	bh=oQB+x6MvTR6ZDcYVdfq2mywssSY535nE3GXO3nD0XJA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nAkqxxIdBpJpTHDuLkwaE676wiauV0u63jmxijXsg/HTZMJNJYAyP9ZE9Nk8eCq8d3nkvwWioFAFT9QoPxIgeL4OAi9cg4vY0GZ2elBqqK9mxX31lBXsBHxZJbE9CmMXTt1p1BmWEFpFiP8xNXBPhuEHFuZq2PqNrODaO+HvEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyRcgx/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyRcgx/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E63E1F0089B;
	Mon, 12 Oct 2026 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826405;
	bh=oQB+x6MvTR6ZDcYVdfq2mywssSY535nE3GXO3nD0XJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CyRcgx/xGCKs9r/D9cil4BY9ODM0ivlqUB3EOcLQBhU/8d+3O5pRUnvtGYRe9+I2S
	 bRFETiozpoLECTmQkthRyyZyOJb6KjAx90ph5+qARk9oJa4hSrUl7mx0afmuHPmMLq
	 lTUxbC8sJ3QXywtw4CR5huyzr1Fxn7qUW4fjplwVFRjfJ9s6UXwdIVd5Ap0uvlBRap
	 4nNRoWiYMboL2JNqrwwoIbz7dG/rNzUzQPdZ5KtPlUiheh0UkDdQLgTxh/DL79KxKw
	 QUuCkEhylnA7ditIHRKzau8t/8gE3t1vn48tpmfJ74FJn7bL1FfKr06TbEwW2QQ8Xa
	 gpt5HcIoGf1vw==
Message-ID: <sashiko-outbox-168460@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] ARM: multi_v7_defconfig: Enable Cortina
 Systems CS75xx support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-v4-9-df250d903682@gmail.com>
References: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
 <20261012-b4-cs75xx-v4-9-df250d903682@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:33:24 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Enable the Cortina Systems CS75xx platform and its UART driver with
> console support, as used on the Securifi Almond+ router.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v4-0-df250d903682@gmail.com?part=3D9

