Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3DD3B7B9D;
	Mon, 12 Oct 2026 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788473; cv=none; b=aSw1nzutvPyLFxLZgJsigqKi55iW5SXMESQaypTBNhKQ9JVrJ+e5t9ZHOjR63CC2JFfa4NrNwA+QLxy8MEnUrfQEqVPuqMyDBtojsk+3Tth0znnFOr6lUozrHE59B+NaPSMlxVeLQBdEcu+yxxJLyzXNTUa9ut8UIQEug73ev2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788473; c=relaxed/simple;
	bh=NrWAxcPp4gUKj/YJzrSQZuKn9Tgns94TbvuTOLw1nSE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EwhC6VTu3sxMobF04k05lXXds16i7Z1hDbAFP1VMvLVuuSKGXGbXmthJlyMNMr96vnSitVyaDWWfntCIct0pbXgTYrBx7WYlvthMfz1QebsKzh+rlbovkn7YroDK20gJz9EJH5izsW4aAsd8IRsS8dqjaTwMwHbUccgpnKTIoZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2XxuEDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2XxuEDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EDA1F0089C;
	Mon, 12 Oct 2026 07:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791788472;
	bh=NrWAxcPp4gUKj/YJzrSQZuKn9Tgns94TbvuTOLw1nSE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b2XxuEDWuLfNBOj4Lbm+HGuLZrI88TqDp4rAhnGRsUMyymY5Hkyqfv5pEbMJUgI3t
	 wqUQhAdv8PVI9vvBvWBz9gNlVIieZ+2Jq5GUL+KjZ29BGBwt1QJZ7EtbofaQMoGJvE
	 9juVPT0FR3DqBjdKbUSlgRZS4+bowG50VWChNrSBk9k0ZEX3RuM+jJ5AP6ZjVJPfpk
	 fqWKIvLaCJ37r6tnZo6GKT7vCuXcepe7SxvUaoqI1zvScq5UfOkX8hohWRqN+yL6xn
	 V2NkRPx/cpxlrfjpncgWkLBpc+HA85a70/yZ2uVUgK/NRE3G9j7zyMj/Gwvz9J7MkP
	 ZZMF2CjMn00aQ==
Message-ID: <sashiko-outbox-167767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 09/10] ARM: multi_v7_defconfig: Enable Cortina
 Systems CS75xx support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: conor+dt@kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-v3-9-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
 <20261012-b4-cs75xx-v3-9-0e0d17a098cf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:01:11 +0000
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
v3-0-0e0d17a098cf@gmail.com?part=3D9

