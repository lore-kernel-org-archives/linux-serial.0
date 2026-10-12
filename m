Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70A4C9E17;
	Mon, 12 Oct 2026 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826658; cv=none; b=WOllOgbKvhIBoiq3t7dpq1yGU2L8FToQKm/UsausAkXGTS20hz7NJCy84UCM5BKPBCylBVfzLZhVIIE0neWVUU5XplV44WH7qqmbXCVNKR6M6MzMsaFDBMgczf1rWCk6Ydb1Zf0cA3RwvIM69D32lvTFKXzLCV4x+hjYgAstgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826658; c=relaxed/simple;
	bh=gZfT1OpM728LwJ+TSy+96ePxAVoTM1TQox2DPgt0wkk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MGK+r2raEVfZESDUJ3C7zeudsBC3Eg3O8Buoz43tMyRpzbSGBy+hyTU+KLh6IH7PpXkPSF4wKBxdAHspsrZcB4IlBu9GfOXDIA2tiH17PCSHEYQbGNU6NACGh6WpmEj9uaeqhk3zm6gK2qKKB3o+ZekzFYYxL19afTGYm/pHDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qos1wp76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qos1wp76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B321E1F0089C;
	Mon, 12 Oct 2026 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826656;
	bh=gZfT1OpM728LwJ+TSy+96ePxAVoTM1TQox2DPgt0wkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qos1wp76jV1HZXC3l6R0QCnbdTsN+pVZ09IMdHUHcMaXP3xo+zQPIyuhrAxAuTuUQ
	 1rbQITEoXiIQmRiTe7jzlnXsPTWUTaz5WewxeivMegZsNjEzFgBjoY38gfSTI4elk9
	 Buqbx5sqSCJBrF44XVks6goNDe0d79b12ij4ekHoC9qZj6jXynMRtYf2d2VQo5P0xf
	 QN3PFyBMj5cW2PCL8vypFEaEUh67JIgu7j7FXz8qLjtlN4YEb3PLOMpIh5fhw69les
	 RWtpSB2B4Mu7HUrd2n6DsXZdcSg4AfxRm/OCJI8V0s58NZqvfgXhfwKABX+e9WwXZh
	 mMqms+cwNPZiQ==
Message-ID: <sashiko-outbox-168470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/10] ARM: debug: Add Cortina Systems CS75xx UART0
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-v4-5-df250d903682@gmail.com>
References: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
 <20261012-b4-cs75xx-v4-5-df250d903682@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:37:35 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add low-level debug output through UART0 of the Cortina Systems CS75xx
> SoCs. The UART is mapped at a fixed virtual address by the generic
> debug_ll_io_init(), so no platform map_io is needed.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v4-0-df250d903682@gmail.com?part=3D5

