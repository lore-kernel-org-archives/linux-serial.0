Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E49448B81;
	Wed, 30 Sep 2026 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752271; cv=none; b=kg4Iz7SqSvzs7faXwFW6greSY+iqRbn9SCGE/9WnNG+Nblf84oB783VZKZV/5MaGXD1SndtyepHXWf2x48HmlTQrWDum2bikQbxQekB2ziow6XZz4D4nL9Eqdm5N/Jdj7FzYDSRFdxUAJvN2KaSxprvj0P3V0A00tGsWcjyKvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752271; c=relaxed/simple;
	bh=JMfgtbpVd/t7gGOgajYOAVknZYzvFHzcVMJeC7+jWz4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=icYpCTKDw30qK4mwlwcH+E4b4hMdqnGg630Ym2826YwEZgsRYRIRbKwCEIZ/So1UuWAieAcVrDAq228Fgy+fOLBei6dT++NfzWs3wDLs5Yxeh/KVXm9ivMk363zIGj908+1yDAbbH7BQeyHkq9UWIAFWJEpKSWdDLs6ZddArtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB61V5q2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB61V5q2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940D41F000FF;
	Wed, 30 Sep 2026 07:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790752269;
	bh=HA/DtQ13Qgh/wq7UptUz3LFISmjqMXcPpegvrzt1kQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AB61V5q2zVX3RVWhZ61nm8aAn6L1ef8vR4cxK9fH3wpRz1N6cER66hD0yCgxbhw6z
	 QX49uefXxudKCatX3oMTuVK/WOeEUY2OIa6lPTKsRaKIE+zza5N0vjibJVnfveiRAF
	 tmPFnGmUSMThXinePvoRBduMMzLXd8j2LgkpnXmF6kFLOq92YcJ+gccMIMwSR0w2wm
	 aJcBrHQ8JbAWtR3XseXiEmBTaPbcy7fhkZPAElm/2yPsIL18v+l2ws1NS0u3f0xUWF
	 vlx+vX2+ksQXJi2zkMZKSWHliMBfNXQVgGlocr0qB/EQqlin0rhWJY5eR/2zf1hA9e
	 S0MB1HfZpt/2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/10] ARM: debug: Add Cortina Systems CS75xx UART0
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: conor+dt@kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260930-b4-cs75xx-v1-5-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-5-4617c4463529@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:11:09 +0000
Message-Id: <20260930071109.940D41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm: debug: cs75xx senduart clobbers register on BE8 breaking ne=
wlines
--

commit 8bcfce484cc05ad1abae605952a7f9c8f05d1c26
Author: Fil Dunsky <filipp.dunsky@gmail.com>

ARM: debug: Add Cortina Systems CS75xx UART0 support

Add low-level debug output through UART0 of the Cortina Systems CS75xx
SoCs. The UART is mapped at a fixed virtual address by the generic
debug_ll_io_init(), so no platform map_io is needed.

> diff --git a/arch/arm/include/debug/cs75xx.S b/arch/arm/include/debug/cs7=
5xx.S
> new file mode 100644
> index 0000000000000..d840384cc32bd
> --- /dev/null
> +++ b/arch/arm/include/debug/cs75xx.S

[ ... ]

> +		.macro	addruart, rp, rv, tmp
> +		ldr	\rp, =3DCONFIG_DEBUG_UART_PHYS
> +		ldr	\rv, =3DCONFIG_DEBUG_UART_VIRT
> +		.endm
> +
> +		.macro	senduart, rd, rx
> +		ARM_BE8(rev \rd, \rd)
> +		str	\rd, [\rx, #CS75XX_UART_TXDAT]
> +		.endm

[Severity: Medium]
Does this rev instruction clobber the character register on big-endian (BE-=
8)
builds?

The macro reverses the bytes of \rd but does not restore it via a second re=
v.
This violates the caller's expectation that the character register is
preserved.

For example, when the compressed bootloader's puts function sends a newline,
it relies on the register retaining its value:

arch/arm/boot/compressed/head.S:puts()
    2:      writeb  r2, r3, r1
            mov     r1, #0x00020000
    3:      subs    r1, r1, #1
            bne     3b
            teq     r2, #'\n'
            moveq   r2, #'\r'
            beq     2b

If writeb (which wraps senduart) permanently swaps r2 to 0x0A000000, the teq
comparison fails. The carriage return is never injected, resulting in
stair-stepped early console output.

> +
> +		.macro	waituartcts, rd, rx
> +		.endm
> +
> +		.macro	waituarttxrdy, rd, rx

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-b4-cs75xx-=
v1-0-4617c4463529@gmail.com?part=3D5
