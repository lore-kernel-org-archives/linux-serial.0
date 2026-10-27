Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793137713;
	b=neaQRF6RAH20kX4bHSWzFIvrRTcQm238csK06iFcfM/s1Q3Ym7mfY8uBQwl03HqPrBWS
	 NEh1zIZZ2Uh0rpQUbFp+mr86Gj17wYdRzhafNry30S+/FdACQ6XKpjoVbYNohiiFm5AtV
	 MjRR06mPE5MfGKtqFRjWd+x+Cx6GlNf8Hq1SexQBstA8B9h5LB6oi5nGywAARkRV3lJ4T
	 vKlMYtdUAq/Uu4ylXO0rIC6FW28PD3CB9IrsmarloblwiowtdjTmYLEw2sHqajtCNsywe
	 vcC1w3GXAkXQ5UF/ueTzZw0LcQp3fjjckefdQYVYPJ6mSvQj/c9s5iTjLAiJGr3R7ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793137713;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R5y3TC+OxgWb2k2zCyoTeuDSWBjSf0l8Xg0k9asjKQ8=;
	b=F+Jdh7ao/lFvbmRDZBFSIJ54KvBa/b2wMeqPRLggnMOZ9PuGxvlnJrqwKAWw2F6V56oz
	 +haKTYc3jj83F+L6/TCipkhRuBvA3SC7De9j8SP0+f/wvy0Fm/dvIGw0mTtQZJCVQurKe
	 RzcdsYjrjEV/rbd57jDPCMhRXvYfM/M1icKwNGga0PE4CJcjbcvgnzoMV0vEJsDlDDI1v
	 qorYTLI4VPNu5Dq5dnLy9lt7tH4BXtvI8+5iOeWyzhE+G208xAU/zUdTFOjTfuSobUIPo
	 vx7X5ZCJPSmSVbFEboDr4FSiiBZxccl2JVcRMr1/8NOa9JlP9g4Srn5aIqAYhwAc6KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=NsnIF6s2;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE6606A31D
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 21:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0AE6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=NsnIF6s2
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 090DB3FBAE
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 21:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793137710;
	bh=R5y3TC+OxgWb2k2zCyoTeuDSWBjSf0l8Xg0k9asjKQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=NsnIF6s23mLz8NdigrB4LFVWsHXrAI2gv8c/0r4DaBDgi1/szzsT3mv4J1WQvsX7U
	 zdzd/DmaabVx0WgdHBRtYbsUUXQfLEmyIpuGgKO5QETxu3kW2fIUwM5U7EAKh+CzyL
	 Pp9eBfvo7+XiQGcCKx0ts23DJkfEFlO/G03UBIhkJasSzYcHH7IHNp5njCNmk+G+fX
	 8D5ybftMkhFpOTqrB031ZTfloLSY5zbGBxPF3Pi4FrN6DTWkxAj/qZzzsg59AoaEST
	 9SQcPFdyqRxu7i3MP42POw4BgRS9tkm1/JJA95eprKGqLI9+SH3EgE2aJ+83zzBQsH
	 0BK2u573yl1ivql/6a50YiauLCYuvqU9yJpCciUGP6JfULI4OnQFcAEoLF8LQkShTJ
	 C8pkCrsnxG0Ls3PJ67TagKG7PvFo6IabWsfM8+YMZ2fKbwt8i9URBHx+cOA+J+9wIB
	 wjNDKJ+hHkZKc3fQAhVSzXiNzs1EkPR6BwsF+9hJgbaT19J/EoO76NQTPsQftvBV1S
	 fue1T1CPnh3FP1giDmLPTaBIcypc/pNfudv+N/2IhOW/d7T1F9SgW+oVhU44HidGMJ
	 +gSp4ue3iAgi/OMUiyJX881ZsA2MKWyhDgMtdfG/H//GT7I9gqPXcQFi3DcV1xLLUR
	 +OW5JYCOTL41oZtLE0vGfUp4=
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad94b96698so75842a91.1
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 14:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793137708; x=1793742508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R5y3TC+OxgWb2k2zCyoTeuDSWBjSf0l8Xg0k9asjKQ8=;
        b=H1TYo54ZL86kl+faggyzN0piqglY0e02HO8wgeOvDwd/dErSbPoMD43NjP8NfVyRnl
         IBYROkNJOXnHY04ONappUzVHSWP43/2iT2KUgXISC3V5v64KHMf+UnuJx3N4Om+AhoJC
         ydWPCFoh0eXn3V52QqWOlIbizRC+6ZvaNRjB3CKgYe9nPeOWJIhP0IQzWjRjpLcT/q+s
         Mtmb+N/8Zeu+8x2p7/n8KLH3iqzJDZ331NwiwKz5GebI49UeHq0Mp2n0CziKKDGPHliK
         5ISmzL0X7i++MI+nJPslumcKL9rlJfxUPHDTE+pRIicBDR89gAOwxgBMZFNyvDPJUsH1
         92sA==
X-Gm-Message-State: AFq9FYKmh79lBMaVEAdsKmAkGwl6JWe+Ue+XhIqNT5xEtoL543+/0cTx
	sLGMnZtcMx225ciBktiqOoAEPsc2efpZ9iSwMvcgHwt/GbINoUNO1xnwYpDjcRqUhwekutGSMfd
	nyNfSc71qXyYxybO6wIVAY7pLy752swjClNp3xUAOk88h7s9rbwzQa7BlQorFtTc5P9oXNixoKW
	y0yGVwyA==
X-Gm-Gg: AYBFou3kqhS/z+KzxHwH3GnhnPDZH/J4MpFEYqNITHs/BFMOw3C3WPEMdX7yv2pxgwJ
	KITuv0awGDVtcpVNSthODPo1ZDz7opiEU6v2O4PyooVG1Epekv8XKrZvP+1L1cU3CTbCMKmKMPo
	TvukE1vqiYSzIAhiO3bs7DIiVMdHkfk1T6rA5IEfIpHieFQC3zGnhE+OXKJ1iENwSbE2LcnSAUj
	VWNPcnNrTEqfrhBDc/rveBAxrX6COvzpQKo0IvJF68aV3PtiCVocC7X/pwQ7lgEyqYi1gN9gTt7
	SNhiM7mSun/Bh/P/OvT+vuEM47VhIcVxdnyFkFgIo36GGIXMlWZY8bB2rTPqhXyaBg/IfFfUcrV
	7IZgtcC2z8LV33T/mycSOB63lUKy7UtG+LWIBgoWU+KArnkhzBfkhxsonPM4QNZ5yCd49K3E4wg
	UHS3neotAcfltH8NLPFksP0IO4sDT6nmc1AGLLbu5poDw7g6KL5Wy3PbCVsXDeh+3Ah8KVaeSIe
	jG4hx9e+ULor9a+PRhsYF//b2ViXVmWp179d6x5Gw==
X-Received: by 2002:a17:90b:6d0:b0:3a6:e1d1:e511 with SMTP id 98e67ed59e1d1-3ae581402edmr428967a91.4.1793137708585;
        Tue, 27 Oct 2026 14:48:28 -0700 (PDT)
X-Received: by 2002:a17:90b:6d0:b0:3a6:e1d1:e511 with SMTP id 98e67ed59e1d1-3ae581402edmr428960a91.4.1793137708192;
        Tue, 27 Oct 2026 14:48:28 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-fcc4-d427-0dad-9764.dynamic-ip6.hinet.net. [2001:b011:2008:445c:fcc4:d427:dad:9764])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9a5e73sm37741a91.10.2026.10.27.14.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:48:27 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	cocci@inria.fr,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v6 1/3] serdev: handle devices without an ACPI or device tree node
Date: Wed, 28 Oct 2026 05:47:42 +0800
Message-Id: <20261027214742.3624605-1-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <75e6d86340073638d966acb85465c28e6a08ceda.camel@posteo.de>
References: <cover.1792856688.git.an.wu@canonical.com> <263a607c3602f31a3f6fdd245e3c2008cdf97abd.1792856688.git.an.wu@canonical.com> <75e6d86340073638d966acb85465c28e6a08ceda.camel@posteo.de>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2026-10-26 at 13:59 +0000, Markus Probst wrote:
> Reviewed-by: Markus Probst <markus.probst@posteo.de>
>
> You should add the maintainers for the modpost scripts to To/Cc.
>
> $ ./scripts/get_maintainer.pl scripts/coccinelle/misc/of_table.cocci
> scripts/mod/file2alias.c scripts/mod/devicetable-offsets.c
> include/linux/mod_devicetable.h

Hi Markus,

Thank you for the reminder. Adding the Coccinelle and modpost
maintainers to Cc now.

BR
    An
