Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37852437448;
	Mon, 12 Oct 2026 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788668; cv=none; b=KnSIJevGveM+n1gbYJtMMXCr0eOSV7UHFEbVsauNyaKzNqu/N4ArVNVwsODQ2wHPqzyP3AC3Del2+pOGaLaAnna/5hyiHEBWnGPdpANHJBaFy1WRx8xAYRNG8T+vzBfLbWI7eHmgxt3ZR5PfHzSafK1y4Or1xZGpV37l+smmTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788668; c=relaxed/simple;
	bh=njVTeMFlWCMn4UN3hjmEl1tC2Is0UxJm45Y9QN9dZL8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gQOysRXClTlMh+GJJOigistP0Ph7CyHE+RG0WWOHQCnFhG3zoGiX+163IpBFJpp9SoRlE0H6PBvbp9RuW85JyyINaQ0aQiRpuSQEF7MAgJ4hbcuyLuoAthe29U6aXQx0MLOSEcjsM0i47EaCBqDke7h/na9XIOVEpKOIIYataAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdRFOa9B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdRFOa9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D78E1F0089B;
	Mon, 12 Oct 2026 07:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791788666;
	bh=njVTeMFlWCMn4UN3hjmEl1tC2Is0UxJm45Y9QN9dZL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YdRFOa9B5CYZYq62m4JbF8ktXxaGOOZ7/sWMYkiRE4jUgqTXixuqbgjRcUVlrstsK
	 8K/DuNJL34LIoSMK7Hf1fQ5yrc0yvK/uiOCnOf3ImYJW+u3uWz4sqqm3MAc3z8DGZt
	 tZiU+aGAjUv7/dlMFeLCQlEY+FQ21/vkRUDO51wh6hZA6TQPu5cT6nZ+5NRY2+wwCo
	 +gvx6ZNTF0Lja9de1WXhVUFQGxl7uMPSRfRTQ9crpvOrLy+DjVb4Mg4rt196NyOf7S
	 /jc6g+74ySbnwLIbTa2cM+BNZy/ULzpxdGVW9AGYfP/yfKGvg3hF0wS8mxD8Fc17vL
	 r+taMW262T3hg==
Message-ID: <sashiko-outbox-167772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 08/10] ARM: dts: cortina: Add CS7542 SoC and
 Securifi Almond+ board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-v3-8-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
 <20261012-b4-cs75xx-v3-8-0e0d17a098cf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:04:26 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add a minimal description of the Cortina Systems CS7542 SoC: the two
> Cortex-A9 cores, SCU, GIC, global timer, private timer and watchdog,
> PL310 L2 cache controller and the four on-chip UARTs.
>=20
> The peripheral clock (APB) runs at 100, 150 or 170 MHz depending on the
> boot strap pins. Until there is a driver for the global control block
> that reads the straps, model it as a fixed clock whose rate is provided
> by the board.
>=20
> The Securifi Almond+ is a touchscreen Wi-Fi router with 512 MiB of DDR3,
> 512 MiB of NAND flash, a QCA8337 switch, QCA9880 and AR9580 Wi-Fi and an
> ASM1042 USB 3.0 controller behind the SoC PCIe root ports. For now,
> describe the memory, the console UART and a ramoops region, and reserve
> the top 64 MiB of RAM which the vendor firmware hands to the packet
> engine queue manager.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v3-0-0e0d17a098cf@gmail.com?part=3D8

