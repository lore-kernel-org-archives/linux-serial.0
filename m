Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EC24F055E;
	Mon,  5 Oct 2026 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221577; cv=none; b=LJekSdFe13WtddQU20PZ02aXiB67Z/CIbiZ+aM/lLdEFUfjYijbnnwTgCxWJEPdpcLinA98sk6dhG+5pV+9U8ASb7EDjlwJATQndzcbO7V4DJcRTMKGzN/NwpGa4NvPjb5R8PYKMxO3jUTfpJNya4lJvP08FDk9tfk/p+j3G50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221577; c=relaxed/simple;
	bh=Kq6OeCL8OnZTzvPgEJulhkOwt9tPCL5Q0u/Fm76iL60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dKavFgunX6Yj2vgJdNwBA84VlS6UZTDvhCeV1weBW1Sp+FD/PRUBrXc+uwl1BUY3RQr31Xu/8e+ueNs14bR3JdtX2m/UU5wizwGFSkrgTkx1QZrLxFz4MCO7LNPDaus1NYkOuy66NK2Aa9stH4o6VCTS5GMRc07dDD4cAzlL66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpzzHR0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpzzHR0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A627C1F000FF;
	Mon,  5 Oct 2026 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791221576;
	bh=Kq6OeCL8OnZTzvPgEJulhkOwt9tPCL5Q0u/Fm76iL60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CpzzHR0PcwTIGNC5EXj1bn/RmA7B/WpuvPhMAZdmwYTPoqRIbmM8BGSpsDwsDetva
	 w0NGV9XFheqRAdqMGapMXjgHl8Z5TCOSmrbmBs3ESmiJPBqNqku1YIyjgAUe0qGkNd
	 mhb16mL8/7o3dHXaQLHpIx+NoWj6PJwbwLU4NMtryY9myb1EL4XIixaB79YlCMLeap
	 cRMuayOw1JkGZGYq0bbIMSulCUxiAxh35qcw96j76XUbX/uewRXvze2cLmLmQOSdpA
	 8/BTgwUSQa7yRMmovim4pKYY0TXIxx5LSCgBnc/eP3xtn9YvV8uI8e69EFX7b+cH0z
	 UrgrlRu32iQQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] serial: 8250_dw: Add Allwinner A733 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinicius Pedrosa" <vinicius.eduardo.pedrosa@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-serial@vger.kernel.org, linux-sunxi@lists.linux.dev, conor+dt@kernel.org
In-Reply-To: <20261005172538.398522-4-vinicius.eduardo.pedrosa@gmail.com>
References: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com>
 <20261005172538.398522-4-vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 17:32:55 +0000
Message-Id: <20261005173255.A627C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The A733 UART is clocked from its bus clock gate, which can't change
> rate. dw8250_set_termios() still gates it around a no-op clk_set_rate()
> on every termios change. That stalls the character being shifted out
> and corrupts it on the wire. Use the existing SKIP_SET_RATE quirk, as
> other SoCs with a fixed UART clock do.
>=20
> Offset 0xc0 is the RS485 control register on this SoC (A733 User
> Manual, UART_485_CTL), not DLF. dw8250_setup_port() writes all ones
> there, reads back a nonzero 9-bit value and takes it for a 9-bit DLF.
> Every later divisor change then writes the fractional divisor into the
> RS485 control register. Add a NO_DLF quirk so dwlib skips that probe.
>=20
> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005172538.3985=
22-1-vinicius.eduardo.pedrosa@gmail.com?part=3D3

