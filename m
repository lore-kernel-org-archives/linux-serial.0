Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685591;
	b=DTRMdYE4Kzf1zrhhhcGXLy70oQlyYB0LUAjUyHmwrh5/Xb0YWpGJvuei1iEFnZ/Q/9Lh
	 KYoFNtWqrp0szcG+yziCh/Pkk3FaA9iKcUqWx6F13FrZkeTh4bkUJk/QOPPUjudIxiDys
	 w2BX6ucdTWhHNdOpsGEM2ojrBMUYl0SxomboqfIF0sdDje/O2Q74fcoZKEbG44qXff+7L
	 UJPRna91KaTbUMU2c4rnI55Tq7EXPFShTj95BVE+1BguuhGCXAwjwMCsRoV98ptGhs5I2
	 tk08YNjwjMBIZGACVCmCnUa078Sb2DeCS7ZoavB5ULGLP2PFkPGqoJ+XiqrR7/uSYCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685591;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ID1WUZWPShbGJj7kh+s83X1k6nYw8JhotNoLF5kbVj4=;
	b=R2ovA57VDtq+yMEv/7jVO0rgQ37XasZLycsMxkN2udM6HGr+HjnStAYGpDsh6E1UT31m
	 mEZYbARFGr7DjEp/ElxQJEeDg53UWgAmkWISkvb/C7VES4Z6LF97MMPy38nosqX80hbZo
	 nz6OM3jOQCjDws98gbt5+hGIEE58ce2njDeY4Sm9A5+NHAgY1i8VNYmzMyOak0TPzvje/
	 VyDvEzZwHiugp7XPErTcQubgrZlI+6HTw83uMntk//khjeTR8u+GD3UVXrZCzm922O9Id
	 b30efR7nKkyVjp/st5dFnWJX3Jz1J0IEIs4cL92mIe9sgnq23P630dYFF9iN6xN8/Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UeWLkhyl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F6606A31D;
	Thu, 22 Oct 2026 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UeWLkhyl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA831F01828;
	Thu, 22 Oct 2026 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685585;
	bh=ID1WUZWPShbGJj7kh+s83X1k6nYw8JhotNoLF5kbVj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UeWLkhylSKQWGQiz+D53AZdzgeb2th45+6/FB29ga2bW7RmOFImji77GAqWfxZ0dS
	 6+Xl6DCFs1PmNHls4NGD5mBUIOTrNJkXqi2ETLJK8+y6SFx4xiyb5aOcikeMVmMUmz
	 NK+b7RAKDyM1uTHewEw5DCrQGyhhlSSVO/KGWbhWvkFmxnte21f3SKmgHauAe9ijno
	 N/ahyCbeAEqua63p2JxL87Z5+tR0qqnoBQ+GPBXTI33j5LfjykvVVr2sr/0GXH7vSX
	 p/Vq9Au4h4M/M6OixCj8hlBIinsoUHOhCkCjiarq8dGYaPPjxUs/9qtHJGlwywFK6c
	 w7FCGeIsGl/MQ==
Message-ID: <sashiko-outbox-181772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/27] pinctrl: rockchip: Add RK3572 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-8-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-8-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Cunhao Lu <1579567540@qq.com>
>=20
> Support RK3572 pinmux, bias, drive-strength, and Schmitt controls.
> Enable input buffers during mux changes for the RGMII receive clocks.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D8

