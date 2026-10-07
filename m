Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8554749DD
	for <linux-serial@vger.kernel.org>; Wed,  7 Oct 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373254; cv=none; b=Z4eW8ZIDAkLqoTyEk0KkEYfd55hOpPbPhOiBZ5dI/7S87g77c4KIZ3ri5Bzq8KJRnQFlggYVEIfDo37glO+6jRdyolb9UYLdy52p9bPSfu2dfBmkf+BdRTNyB6171QLtI7OSQj6kNiNdkcjZlTQUmwqCU7yMQH9bzGbutvy8y7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373254; c=relaxed/simple;
	bh=fKOCvjoNQtwRqFI066qdcmZWGjZbp8jaY+FDxN7dTcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exniHTVOxG1qOsqUyKhOMeAq/Ndu8TKX6BtkqveKRLXbwQhQEac31vnwcGbYOrpXtweFQw88/31LHxEEzFA0dN2tAxC15cpAfm6wARROx2+q0P5lGlkIrFDXonJkQFKt+IddbP4f9c6xEZbI0SEZAoqar890uWczVhiMwEXbPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i25gWA+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i25gWA+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFBE1F008AB
	for <linux-serial@vger.kernel.org>; Wed,  7 Oct 2026 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791373224;
	bh=fKOCvjoNQtwRqFI066qdcmZWGjZbp8jaY+FDxN7dTcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i25gWA+/BKLg3TJBUNxM9g1wPMz2Jd2k0rRtVH5gzvl0N+WAoLKmZgmomQI5MUIqM
	 QjhKugvm02ZHL4j71MoW/sn/NAtHgybdhk7vxmgchTSLfSrE8jSyX+I1RZfKlDj10v
	 jS7thfqmx0ZAh+FSeiez7fkJWNde5unlCkg18ttSR050jBqcvekEX7aeL8Ly4JXnkQ
	 A0cxXKUwk0X8WHPJ44sn6g3hI8HPMk9K6wEzTpBJAv8toRWbABUsd3j5exzGC/xWJP
	 2hCiKXjyoVxSoTIFIhvrSomoRqYtY3xdcVGOSApBa7BJJ0vnHRgKtJgmQCeaCwg/ST
	 SgEqv+I5eeTpg==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6df0b02fe91so1342234eaf.0
        for <linux-serial@vger.kernel.org>; Wed, 07 Oct 2026 04:40:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxeE1iBd/GxUIwQvCQxFsElX4o23yhq5L29f0X3rKfO+WiwiH4T5HQWRcugLQxwkJ2H7bAjG7XNk4+AWNg=@vger.kernel.org
X-Gm-Message-State: AFuF++k5oF4MsZEu8pPnUFoSLOYIo6QDxUnLHPZBiXQ3qw1KCNJe+7EA
	A4pOqKakpfx8zR1xz0jttskt2R9498GG1l4qbIZ6NswCHUEMmwWNRssDlqizQ0juenVrx+zKvL7
	wz+sPjYsdvFEJkzU940pW27GEYrWdae0=
X-Received: by 2002:a05:6820:200d:b0:6dd:7f2c:2bb6 with SMTP id
 006d021491bc7-6e4a7e43471mr4207285eaf.57.1791373223883; Wed, 07 Oct 2026
 04:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com> <20261006-b4-cs75xx-v2-4-b7d6e1e24d44@gmail.com>
In-Reply-To: <20261006-b4-cs75xx-v2-4-b7d6e1e24d44@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 7 Oct 2026 13:40:06 +0200
X-Gmail-Original-Message-ID: <CAD++jLn74bT_Fyr_Og-4UCHzesesgzDUe9UiFWNX2zQrJ92-gg@mail.gmail.com>
X-Gm-Features: AclHuK-Qje_8nYjYN9tMFCPYQzKct6wydoO2oDonV_Y-5ca_xI58bQphqW6iRzQ
Message-ID: <CAD++jLn74bT_Fyr_Og-4UCHzesesgzDUe9UiFWNX2zQrJ92-gg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/10] ARM: goldengate: Add support for the CS75xx
 SoC family
To: filipp.dunsky@gmail.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Jason Li <jason.li@cortina-access.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 8:17=E2=80=AFPM Fil Dunsky via B4 Relay
<devnull+filipp.dunsky.gmail.com@kernel.org> wrote:

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>
> The Cortina Systems CS75xx ("Goldengate G2") are network processors
> with two Cortex-A9 cores, an SCU, GIC, the Cortex-A9 global and private
> timers and a PL310 L2 cache controller. The family includes at least
> the CS7522 and the CS7542; the CS7542 is used, among others, in the
> Securifi Almond+ router.
>
> Apart from the vendor this has little in common with the Cortina
> Systems Gemini (SL3516/CS3516) supported by mach-gemini: Gemini is a
> single ARMv4 FA526 with Faraday peripherals (FTINTC010, FTTMR010,
> FTGPIO010, a 16550 UART) built for ARCH_MULTI_V4, while the CS75xx is
> an ARMv7 MPCore whose UART, GPIO, interrupt controller and NAND
> controller are different blocks. It therefore gets its own directory,
> named after the Goldengate codename like in the vendor kernel. The
> Kconfig symbol, ARCH_CORTINA_ACCESS, covers the whole family and is
> named after Cortina Access, which last sold these chips and also makes
> the newer 64-bit parts.
>
> The generic DT machine is sufficient for the platform, so only the SMP
> bring-up needs code: the bootloader parks the secondary core in a WFE
> loop that polls a global software register, so boot it by writing the
> physical address of secondary_startup to the register named by the
> cpu-release-addr property and issuing SEV.
>
> The CPU is a Cortex-A9 r2p1, so select the errata workarounds that apply
> to that revision and can be enabled on a multiplatform kernel. The PL310
> is r3p2 and needs none of the PL310 workarounds.
>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
