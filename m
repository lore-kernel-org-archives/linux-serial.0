Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202322;
	b=tzJ/bjDiV+heFSnH5Qsi9ADqmb77si69CzNUWIDoCZgRPV5l3IBX8V0Z/9zUtNxG8MWV
	 P6jBVSW/W6J3c4hrAbJ+E4IX8kksobPXdBiRW9HY2Ig6/e3+QdQlfa0bVC3ChXqsTkwv0
	 rJSZrwZA+WZuy55Gjfz9ENjU1Fs3sWaTaNfhNAWphcnzVxRK4jYwy6Wwm020MXAVjPoJY
	 kRG4fkNLVRBl3PXmW+OT6a13O2faWowTAxAb9pGnB50DnTkIv9M70i7HhKw84l+Ls7YMf
	 8/uvGuik3HJeBK6ZguRs3OgSlBxjoKJ8UL/wO/gDLlZBYddBc8lgjQAteqNrVh7T+Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202322;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JQtIlYGFUDrMt6fYbrWl91tqud9c8gvw5erYVflcKsA=;
	b=GpB1Zvuq7Z+S/ZXZWQfYXUQlTUJqcm+mCzeTAsUEpo6pjckowHq7eQYby6DgvQqO2QTL
	 6i5DSCi5v6JRDUrzn5JSQ4syuLZkvokwoi8WLhbebcUzi1iJT7EbE007oO6MhGs8wPZCG
	 lWSP79eAQ+FS6Q9P8wC3/HbeV2Iyq1G8kggF9G6N54010Vb2No8hPH1FIKDNBQBK4v/Vo
	 +/2THTNQdQiWZmRHKc1t7hjle11CwBgjnmrE1ORQs2klJ21iMM058SFfnOt0NWTF/vb/w
	 +Dw+5PzoJpvdleN/kTLaxESIiaapWX6ed8MslmMgbdr5FeAbaPqUhlHxF2RHj6CrVUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imYzceAC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3E606A6D8
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imYzceAC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3611F000C0;
	Fri, 20 Nov 2026 19:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202321;
	bh=JQtIlYGFUDrMt6fYbrWl91tqud9c8gvw5erYVflcKsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imYzceACe0U2EYxbA2ceD6Q3rO061hMUz8MSndmfR42iJCdWzq+heVta6B8QBZ+aL
	 X+VPwjm+gEvs+s7TJ3RNx8SrKrBamB25DdsVh97tZU8a4FMP1FzWhNSGEa5kRf1sB2
	 pg0S48Yp6xmt2WWNnEX1NeIeVVsJc7CFn1WQ0jj7P8cokflEBI/tcFCOjomOWD0Mgm
	 xs8NqFMpdu8DZltHk/1vklqGf2ScUvBrDoIBJG/FygIvBTk0PpraX4iAU/wYleqkTT
	 mrhZvVkrP5m9p/jBUZS7QcaL++8rvMtnPiimlSNLnd7ZwmLCDvhmRP08GZKBP/7roG
	 wqvr6hJDtX4Nw==
Message-ID: <sashiko-outbox-225904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/13] dt-bindings: timer: add Zhihe A210 CLINT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-a210-scmi-v4-6-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
 <20261121-a210-scmi-v4-6-4a795a0a9fc9@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:18:40 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add the A210 CLINT compatible with the thead,c900-clint fallback.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-a210-scmi-=
v4-0-4a795a0a9fc9@iscas.ac.cn?part=3D6

