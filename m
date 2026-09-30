Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A80445AFC;
	Wed, 30 Sep 2026 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751782; cv=none; b=qWYm1+eIbpoFjKWVklXTHeNaGInAbEIv9dItWkKwMs2E0sl5PPxzDqJSrEhT+angX4gTedMddfeDTqQzzQpdxkh5qO2GuV7evj5msgu8h2m9JokBLy1MQX57W5ZRY0KzMBFAEW/yYLJahml67W9VAi+lWGOZvlJo+s8PbXHW5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751782; c=relaxed/simple;
	bh=hnnhQWUmLyRJoEBxtL2y3Q5H8+orNTvTK089Pm/IMq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FS4Q66f02njpdq31RSx5I27V3o46hleoiZdAjKxR150Pw1Dr5EoyriW2yMZI7sZAkdjy7uVPGX1BDU9r56/gTfrj1nX57MCIueIULRdJnF2NRlAY9v0GL2sJG3XsdA8tRopb4Evctyax+ITrq9Bm/QVNYj8N6tjFJerQ+8+tZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDF9+bln; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDF9+bln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C531F000FF;
	Wed, 30 Sep 2026 07:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751773;
	bh=hnnhQWUmLyRJoEBxtL2y3Q5H8+orNTvTK089Pm/IMq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GDF9+blnNZKrRA83kQPvKVkMqKrfOtXD6HBQQ5nW3/D9Wnbo+INpjVvB8l7h4TW8j
	 Khwj04NHwKIrIOinsfxPiFLdN8+uPjkWHFSvWEt7UO01ZD2/O7kyDlNkFU3aSMbD/U
	 6XG43foE0vgcanQjbH66/NCRtDQO2F4+nNWioykKAVikjIemHImTzcEsfUL46R1IG5
	 rradJLcqYD9S2fxNOnnPsIBqkMNgyo6RlcKguMJzEEDAkROKILPpPo6C2g9vJgWFiE
	 OCd2lE4umySM3YodxLUDbjIBB3BhQImp9FsHm0ZWADqQQXS0s+QSAPmHbmdQ5Aa/zY
	 VZZuhwk5/4e3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/10] ARM: multi_v7_defconfig: Enable Cortina
 Systems CS75xx support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260930-b4-cs75xx-v1-9-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-9-4617c4463529@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:02:52 +0000
Message-Id: <20260930070252.B9C531F000FF@smtp.kernel.org>
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
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-b4-cs75xx-=
v1-0-4617c4463529@gmail.com?part=3D9

