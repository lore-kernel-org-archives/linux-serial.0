Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AD72E2EEE
	for <linux-serial@vger.kernel.org>; Tue, 25 Aug 2026 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787699756; cv=none; b=F6X6lwMO/D9WJQY98LCOFy152MFTsOqeSCoyXIAsKMKQsvGdOhwk5XwbjtKPJ+RvpO+mpgFcumZtzpKzDbUR3O8s2K0+ouaPmC4v9XUMwtyV+yvuXlKf6jt5N+UujNusAyUGbdRMPCiCL9EvR0suhAUq5HnmffGR6iAzB9NF7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787699756; c=relaxed/simple;
	bh=rDVKUf+0jtijme296wbH+lhhHQLbKz/Ryars16INIaw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vv+64XuxgiAnl1Lj41GB/1QKiaJl2CgiHuwdAUJ3/Q0OSSKBSBFzzsYlPaJGmvZywx1JD2C1i4+XyKhiFncyy4MN5pptkeg5G3oabMWBMXjV7sOENaAhGHD50QsdZXPYoCrOip6F1EBxC9tDmpjoA2z6IqzeXwH9oBjkUOeHEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT3Eti6B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT3Eti6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DF91F000E9;
	Tue, 25 Aug 2026 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787699755;
	bh=rDVKUf+0jtijme296wbH+lhhHQLbKz/Ryars16INIaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kT3Eti6BgZFDgW9PmfsQfRf2RoIZ+MUpydqszNooQEXr/A8+PEaBQj+49NKFSyREO
	 KvJCzS6JWWCXJM3Rx9jmTLPVOjU9AFx7HwYwApumU4WclOxEGoW5Vy7M3r2eEa09v/
	 8ZOuh+IJvTR9tc7F8AFwazoIR1pWWwLlpe5TseJZ5lZbT6nMrfoGCJatorChqCmgAs
	 9EKILNBZXVypnaIEssn0LRnxX5NSXXL/rFnP6lkqvQOc0fOR5gcjQyZtlp8od6Vtf8
	 hwgcI9weVUyz7MhfYDG/UPnE62zNsQrCIkj/7CObEJFDW1MBtmAULWh0RhBq0QGKTo
	 UBCPiMUujaeNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] ACPI: SPCR: Support UART clock frequency field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260826-acpi_spcr-v4-1-2d5670dace43@posteo.de>
References: <20260826-acpi_spcr-v4-1-2d5670dace43@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 23:15:54 +0000
Message-Id: <20260825231555.64DF91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Prior to this patch, we assume the uart clock frequency is 1843200 Hz in
> the early console. This behaviour results in garbage console output if the
> actual uart clock frequency differs.
>=20
> The UART Clock Frequency field was added in the Microsoft Serial Port
> Console Redirection (SPCR) specification revision 1.08. If present, use it
> to configure the serial port with the correct uart clock frequency.
> Fallback to old behaviour if missing.
>=20
> Add function `setup_earlycon_with_uartclk` to set uart clock frequency
> while still allowing to reuse the same console string with
> `add_preferred_console`.
>=20
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports=
/serial-port-console-redirection-table
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-acpi_spcr-=
v4-1-2d5670dace43@posteo.de?part=3D1

