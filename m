Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523AA4A3D28;
	Tue,  6 Oct 2026 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310897; cv=none; b=FUsw7ODs3HXVd/PNSobIZM4BRZGATx4XrqVAf7B2XxBFitF45WxCOFjJnCgi6TvEYD/foFD15gcbJLB5sBs1+jlP9P8S8ahVYLt6qDp2z9wDp6RisR96f6Zx1NGPMMuYoY7fJGvkSlbXPJveBQQTtXWjADbAt5PnAnWM9eW8q3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310897; c=relaxed/simple;
	bh=kTf36CaZea21vkDtaoagtn+y8+BgGMYDXR+7ns2r/wM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=phtt0VdTAuzbXttT8X3UfNgdq6cV3J9EqXjC51xZ5u5fUxh8Grmlxc4GttPVDLHMLtxNtOrApzRUEX1jlWCVq9XredxRIHY4XFv8q69B02OhR50B8hK7n9GNzvrpmy9VeVC4bahZon7UsekXlSGXiJ5UwKRzj3KpBc81LePxpxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETlShvBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETlShvBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37801F0089B;
	Tue,  6 Oct 2026 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791310896;
	bh=kTf36CaZea21vkDtaoagtn+y8+BgGMYDXR+7ns2r/wM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ETlShvBsFp9jX9iPk2c/k/V6nvmKKQ+qMj9VVlO+b+s83ZPPISwyuh0Ss9mxkpCwE
	 Jnz21T+y3idthbaTTHMD0KecYDW/kmLHJ9PeJ6i9MPBZv5cQXq3Yz+yGGqNaTR0ARv
	 6cBc9YxoIbimAlbiQ0JVpXJIyuPMT7lNdYHM5nThCHdE11RhENtnn8Ma99mlVp7Q83
	 MkFB0QsCSB0phKIE86vDbktHoaUlTz1gnOtrX4CZPFy0z0SsJUgmbR4hERCoJdKiEi
	 wKPmq3oVmqU5gWgO/Qgr4pLwL+exMq1gcEbIIM63iNlROc4Detxp+2ims0hx0aDTqT
	 6fOCMeX6YhkaA==
Message-ID: <sashiko-outbox-162336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 09/10] ARM: multi_v7_defconfig: Enable Cortina
 Systems CS75xx support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261006-b4-cs75xx-v2-9-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
 <20261006-b4-cs75xx-v2-9-b7d6e1e24d44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 18:21:35 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-cs75xx-=
v2-0-b7d6e1e24d44@gmail.com?part=3D9

