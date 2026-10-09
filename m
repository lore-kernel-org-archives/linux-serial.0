Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E89371899
	for <linux-serial@vger.kernel.org>; Fri,  9 Oct 2026 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536280; cv=pass; b=CQmzbY0W1h9OTwBo2YiB47OloDi9RaJ8Lvgrq3Hk1cr4MovvPXWYJ5kZuoDPKouyX2Cxy9Cr2kWFPkh67OxPzNH7k0qThSntm5tAhOJyURlsx2hHvHJCa+FGZTwPmazK87O8iYcaeRMSAAWs7EVe6BWCHs5EPfH08YCC9+0MOpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536280; c=relaxed/simple;
	bh=NfETxoF4ucCCZgxIexpfcNpfV4dYp0/llOpv6Ji+XEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYjdmTnKyXzqVXJYJ0o6ljvYO7bHJOqB/x+gBtNM56ZF/gc/mJLZDB0CDy2G7wu3Z2Uy21SGjOm3/2kTRya2yefppH+JA+ntRFWgl/rv4FbJSg2GX4TJ9bPk6AluXXMp0WkbQeOUHXzBruFvJgDXDJUuz4BKT2TXzWeAbOfztPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhVxsxXe; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhVxsxXe"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2a4e013a44so945159766b.2
        for <linux-serial@vger.kernel.org>; Fri, 09 Oct 2026 01:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791536277; cv=none;
        d=google.com; s=arc-20260327;
        b=laejmNBGgNWqzUVX6Hr6KD+J7VShVIPCwO4cm1i6lh4zQ7BY9Ym+dLqGrkx3ZnoMdB
         SZ8IrLO8xGIEKQQo4AQP8/tPXNc8tdtmFixYnAZd/yHQb4UYeoQoAnbddYhXt7yOJwlO
         BdzRBQ1fNOCReZL1rovm8ad2KRt4STMZkaD3GfU883sFwrVGOc9cf0NnRkC+L3bhTLAM
         RJsvrgT9LfrTRSpompAHBSMLDbdC8oJSev6R5AGkPtWL0eFMCUjm3NXuCwOZnwHFyMd9
         Mx/99IxFLnpyKcHWabfDz7ARRHp3zdRpWYO0leB1yDPR/+xfwkYa3fYpT5DiTpqUn2/+
         bjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NfETxoF4ucCCZgxIexpfcNpfV4dYp0/llOpv6Ji+XEg=;
        fh=wJl6jxcD+4pQaGGe+nK2QAQf4nRh8TzsiVSwZX7SN2E=;
        b=LXH2f7rDJ6wtLpv1to8eQ08XE3+hF+Vmj/DDhL/J/8xmFyZyEuiboZYVIqnfP/hmAm
         GZKMKgBT7D+y8CD/e3UbUOc+i3jZNeIPsQ40r3+UzvWbyFjyALJRwUOs2MoNI/w+SFSk
         b3OSTwvaGPD0s0v3tYpbq/N2pxDhzGi+zhCX1v70RxSYy2smwn7oK4wW7rDPQeJ5nnR+
         SjSCFQun7PebN0RIFBtdfY2+3Irma4bxrmcZ9+IudLq7kaCnucXrgTJEIf+atkCusa2n
         M9dFZLkwATlAOQLbeEnl0oyn3T7wDg3SzJ6Z4CjnEfVqgS/lx+JAVkFpqfrtlNMcvJnC
         SRZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791536277; x=1792141077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NfETxoF4ucCCZgxIexpfcNpfV4dYp0/llOpv6Ji+XEg=;
        b=MhVxsxXecptYlID4IUm6AzVPsaZN7LkFCH0SBo4E+MoN+TJL/npo0mDZK2znYZIeJ2
         PW97Pa+Osx+gNnMHmIAs7cPvxS12or/PKKUz7/qbkHYy8rLZSxpF20DJap/gyxiYoUAr
         2q/bGcQby+XFX6NSzE67/53HO8jy5q5b4Cu3xasSGS8cKCfu8jQDgm7eINV96PwWBvc1
         qegyhSnNxBqvhzB8EEdbyFX6szGaQdDm/sZrdbYE4MSfL+V2UU/vJDMe1yXTZlufVh0D
         m72ZXvV27HvXndSuaK/h/286TnCgjyzB+oeT3+NhhWuGJ9T/NphgzhKucCkXKfltuH9/
         tcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791536277; x=1792141077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfETxoF4ucCCZgxIexpfcNpfV4dYp0/llOpv6Ji+XEg=;
        b=XrFOkHZn2PMZltSxi+bqTMCg+CLxkazMXm8T8mh/COxxTyy782niFXOxCubffbpfrB
         c01aJMsqZmLAelNw30XeU+9ELV+gfcSbuAvuRY765nAMyUG5auMeyIln/cH7pQk23ivf
         rLLJ49mbW6qTM7iVSoQPNEUmBDFFlqojkb/olDHn8DngRkXx9Iq8Z8+M4G5a4RnLsCto
         C4XMiWCHXVN8JgL4gSNwtxxFnNlwbAdhsGSsDRJ5iL6l77J8QiypSIpKtpI2Aqnrdos7
         EKF4wbVje1+FiDYKaqnobENrgmGqBFZxRJqMoxsnM7b5Cl3AcVe+DDhQhAcmExJQgQXm
         BLnA==
X-Forwarded-Encrypted: i=1; AKwUvBwyrbNVnuF7JF1Mk2xGi0oly3JlqRdX40YgjHHcDfc9Wu0Wp8LYbixuZc4/BThk0IxhMGsMj8QjQwH7+dg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/CM2LeJIGch3MQIZrIPGoraCNoOtmjxQH3nk8n/vIXbqzLUgA
	ONFPYrPfUZa863yTAvAL/2tmeITK5FxHtiBrThpZaeiyNDoDdU/NAFpA5cfntHNb7chfaCkMNWA
	fICsqzijRYsI3kiSCQGKa0U6Bf0X+0aI=
X-Gm-Gg: AYBFou2gbUXbFlt58NnoqiAbM2beX4/Pd9yeK4pKnTiDrKk5eKwoSMzRpg/5bROGAvB
	NjhgysZ5PElZn/oq379AWkpoZ6veHoqVl4A9pxgIdag4AQ/rOqpv7riJkFeThCTAcvoeO8oRUA1
	XRIzj2t2KX7D03dH3LMUaY7Qt3psq6Zh15SJG0aEt6RCmtSqh4I1gnZXMyK1P5uPiktFUilrBjH
	AY5EyQqqzhtbn+F6tYwBM/3yL4Aiy9l8gT/8boVp/C1n7JIbnlrxRdJaRiNsroV3Jw/Rqrd6tFW
	xEVlNZYtsXpOgmRQJyvh7H2IPPl99lAEKJtiGVnOm4ujQAUdLyEQokR+2kPKvQss/pmWQwTUwqN
	FKQuOXuFcX4pPhxjAcEwIduvpYHOKW5Rv9NFpPSzc30jxikVrAFZbOPYtb2vNgxWXJd2uja/QBN
	jnXaMPoaOJYqo0nTndN6/RoDYogP3vOPlh5lbUYfvh
X-Received: by 2002:a17:907:c19:b0:c26:19de:9ae1 with SMTP id
 a640c23a62f3a-c31a9f92fafmr107811566b.32.1791536277123; Fri, 09 Oct 2026
 01:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
In-Reply-To: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Oct 2026 11:57:20 +0300
X-Gm-Features: AclHuK9b12DMuE5IdZa06_5PZbK1OQ4johR6fh1kbHOWemGxMcH63xDoKEpiMps
Message-ID: <CAHp75VdiO9tPX2vLqsX2-omNvs-YjkWWD-HOiqyDSzpJrrZ_5w@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_pci: Add support for ASPEED BMC VUARTs over PCIe
To: phil@phil.gs
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Corey Minyard <corey@minyard.net>, openipmi-developer@lists.sourceforge.net, 
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	linux-aspeed@lists.ozlabs.org, Ninad Palsule <ninad@linux.ibm.com>, 
	Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 4:27=E2=80=AFPM Phil Rosenthal via B4 Relay
<devnull+phil.phil.gs@kernel.org> wrote:
>
> From: Phil Rosenthal <phil@phil.gs>
>
> On systems with an ASPEED BMC, the IPMI Serial over LAN (SOL) console
> shows the firmware and the boot loader but goes silent once Linux
> starts. The UART that the BMC bridges to SOL is not a legacy COM port:
> it sits behind a PCIe function that no driver claims.
>
> ASPEED BMCs such as the AST2600 present this "BMC device" function to
> the host (1a03:2402, class 0c0701). Besides KCS, the BMC firmware can
> expose up to two 16550-compatible virtual UARTs through it, and host
> firmware redirects its console to them, for example "IPMI Card SOL/COM2
> (Pci Bus9,Dev1,Func0,Port0)" in the AMI setup of the ASUS Pro WS
> W680-ACE IPMI. Register these UARTs so that the kernel console and a
> getty can be used over SOL.
>
> The UART registers are in BAR1 at the VUART's LPC I/O address shifted
> left by two, one 32-bit register per 4 bytes: VUART0 at 0xfe0
> (0x3f8 << 2) and VUART1 at 0xbe0 (0x2f8 << 2). A VUART that the BMC has
> not enabled reads back as all ones; skip it so that the ports present
> are numbered contiguously. If the BMC exposes no VUART at all, decline
> the device so that it stays available to other drivers such as ipmi_si,
> whose PCI table matches the same class code.
>
> The function has no INTx pin and advertises 32 MSI vectors. On the ASUS
> board (BMC firmware 1.3.13) no interrupt was delivered on MSI vector 16,
> which is the vector ASPEED's own host driver uses for VUART0: transmit
> stalled and nothing was received. Poll the ports instead.
>
> The same function also exposes the BMC's KCS interface in BAR1.
> 8250_pci does not request the BAR, so an ipmi_si interface described by
> firmware (ACPI or SMBIOS) can still use those registers. ipmi_si's PCI
> driver, which matches the function by class code, can no longer bind it
> while a VUART is enabled.
>
> Tested on an ASUS Pro WS W680-ACE IPMI (BMC firmware 1.3.13): the kernel
> console and a getty run on ttyS5 over IPMI SOL, while a non-PCI ipmi_si
> interface uses the KCS registers in the same BAR.
>
> The register layout and MSI vector assignment follow the host driver
> from ASPEED's SDK as posted in 2023, which was not merged.

There is already a driver for this 8250_aspeed_vuart.c. Please, do not
add new quirks to 8250_pci.c.

--=20
With Best Regards,
Andy Shevchenko
