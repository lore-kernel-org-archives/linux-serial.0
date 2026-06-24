Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F53AFAE7
	for <linux-serial@vger.kernel.org>; Wed, 24 Jun 2026 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305297; cv=pass; b=QR3hqJARdP2csp7yWFftYfXKXKDTxl9f3o8zxEO1vY7cnT/PJ42WoyP+Nv7UtFhQ9t1pOSXzu+DA0xfZM9qjLcl9acAgXedAb2ye02J7iJchsmlTFLvafUV9Yy1oboSneGABwh552qkshm0fOnbN4RFwTuAkmDIxssjsByOCr8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305297; c=relaxed/simple;
	bh=Eq5j+mgRZceDcTZasDH7TbWj5H7RHsli0Kha0kPj5L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKlEqrvL0dHk1mzjvkn3teS0TPuCbFyL8peeruCILmYNhhncw6l5f8xrgSlyJ3VMbdbzV8lHBAMG83KNUPrD6Tq/jNp+iZ4mM4nu3GMJ4W8a7Aqo8TEs7C3ReMSaXypkLmOgmx02fO+CKi+tmNA8tj5hfCqBiU8nlNYYoPMiF4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=fqnf9DNj; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="fqnf9DNj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4924f8db066so5820195e9.2
        for <linux-serial@vger.kernel.org>; Wed, 24 Jun 2026 05:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782305294; cv=none;
        d=google.com; s=arc-20240605;
        b=GZw0fHs5oZRkEGps7oycnNTliupxksM0a5yG393Xr/q1FfAhRwLBYdCrYII1JGBdqm
         /DjVDpARSvXQwfigeM/LUArlHGSOvtDVrkoq9Ep1dq3RKHzVMoQp2xrEIznj9BDntXF6
         l3LJRxRsl+XHSUBW6EvVGF+kohjLXD56ghs+9REgicuUrJQDcp2nsZWSDjGlGSjeoPdl
         kwfesdasl2lSHtLlhoi4gBq/PlVAsy/tTWMpUZedgdE7d9GSWVS03XkYj4tm7I2/UbjU
         BB7O1WYWjl0e15SOzohRVFa1vJ5TML5RDMluGKo2UcLbox7vOPniMR8Gwt7vkvMCF12H
         4ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3MWM4Rp4reeuC51yhNdvSwjoOhRN6bkNqY5FS9+XPUo=;
        fh=d0lLVJlJII3EKUYeXkhCCB3h/4G7ITMejXEj/R+IYnY=;
        b=QDeXBoLdiausW23T006uRUJtlezRFXFhGZJQdMLZJSvnb8cQAKwlm1xGCATyRDEJm/
         PvdhGvmEmtgnJ/g7XIkZf45jXuZxPc4pPnmhcCoK0sQXJMLrELfwWqrivQIGcLvxZtgU
         sMk+l4DoVAEQHym1tqMkpK7BgRmt7qD7yfd2uOr8+Ygh3yZzJYWqGhzBxd+IzTymreb7
         XfY4zyn0UyV9e9MLL0cZsga6hXXWMREC18qwRyywVx12GOV6i4FrpCrSNNAouyNxTyUh
         1jIXJMQ1qa0DZklrkGmEoxPRnGHun/N8JA5D0uVGxrkXffBkslwPyrSWMZR9UzRgVYF/
         xkLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782305294; x=1782910094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MWM4Rp4reeuC51yhNdvSwjoOhRN6bkNqY5FS9+XPUo=;
        b=fqnf9DNjSIG+PyANSfaJ7VvDHz04fWQ2iaVTl6HHaguDnrGx1wftZnISlg1J5SjqBr
         i2eOaKvDnDBrxvlBaXejSDV14WfltagY+zqG5khJDKD7HUtwgM/b75/EzlF0kyva1KVx
         +CaNb7dmLRNCzxDhYQxljaFLFZ7QK2sY1fQHDQ3A6YD51F8U1anI5fYLG1fxbqBtGYIf
         rr1er2iUvBvgl9heXvgTKlHxZs9pGN7bET199aOQoG8Pogspka+f+qT2k+uOING32vM+
         K3+UMd0rsrjEaggQOWnaci3ePlQMLXfdN+wMsas1iB+OiwmKfxM3YuwTniWbJFT9aB66
         LBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305294; x=1782910094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3MWM4Rp4reeuC51yhNdvSwjoOhRN6bkNqY5FS9+XPUo=;
        b=G3OBPUV09tlabTIhkJTyDP/C45evob5PBfGZHwOElANgOx6v2kSMnlJ15vFn3ekq9g
         Wf8TJKOxNydPo0/VL+VhM2QZ2In9R9LshnJzvJAq1jg59Jlm5elOwNvxAvUzrhwW62m5
         68aXwgBkJB/L5VDdTF82F/nXcZOl7r9xqujG/m5k3KK6yoPxuasPmhudWLkNnUIPF/eN
         xaEzaQ0T7I92Hs4pSU2puogMKJbQDmoTpJuB+aRL9Xtkx9oS6uRgMuW3uOCy7Bait54k
         pZNwI4Nvy4hYzfAruS3JZ5aCoL0Japxuf4ycRXeifkGdO6mZQwlX8Y8I8N/5FEz15dJc
         nSSg==
X-Forwarded-Encrypted: i=1; AFNElJ+JTAqtns+a7ed3mbnIy9m3YRRkRyHFVH6uenXmH1AJvIhj+ws8lsa+uJ7UxV8Y02p5k3HwI2htWdBo1HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7FdjKmws1hAnEzc/V4FVy1/1iaF64BO40H4Zwu4PUOWZlwIo
	dkqUaz1C0LRCRMtVXOcFgMs9ryudyhfcCacWoqirleD7Av1ZszSpeC/hEhjbMRgxtDV+D64OQgN
	SJhBNPx/CuZZFW3f5gfD0O6Xk2Ni3hjK6ZagYlGQwyw==
X-Gm-Gg: AfdE7cnIEDEYsYM5/R5VMql12ZIWct3AgbaTcPdWC8jonc9twF+LtYW/5nzg+6Q+A2o
	gbLgb+lhZ0bWcEPrlS7Rn5Xdxw8mPI6lExMjHZZP14rnSdO9dyyPI4P8vgh7FFIwYtBTxwKpMiC
	fbqT+bfMgK7f6lOftFBLy1PxBQU+CwrwMZTyJiZo/DSmYc5B56pkxTtIY5BxyH3ZIhpwE8AysRc
	asSk+2YO9bh3jp3D7FL8Uy5DC6r/EvDgCGWgVERkzLuu5CVmtSxILWHLf7633SD3DN/dNkaeeI+
	hhLVoR7hWh60IRRdTAvjm33QXSKMF3LIRlKymB4r5WBZuc6iHLhisU9blA==
X-Received: by 2002:a05:600c:699b:b0:492:6113:d4fc with SMTP id
 5b1f17b1804b1-4926113d5camr38002035e9.17.1782305293997; Wed, 24 Jun 2026
 05:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782224059.git.gregoire.layet@9elements.com>
 <73b2bd81ce70814612e6d3cb689c3296de742aaf.1782224059.git.gregoire.layet@9elements.com>
 <20260624-original-vigorous-mayfly-dfceac@quoll>
In-Reply-To: <20260624-original-vigorous-mayfly-dfceac@quoll>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Wed, 24 Jun 2026 14:48:02 +0200
X-Gm-Features: AVVi8CeO23_9ds8O0yHhJLM3WPWltEB3CF7pRM6viO6egbyN_FuIGSRsMbnIPSw
Message-ID: <CAFi2wKbKr8FMcJeGWA5e1UZUTh2=LwYNkLEj6exd2as7=AcvVQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: serial: 8250: aspeed: add
 aspeed,vuart-over-pci bool prop
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> What does that mean? How UART can be accessible over PCI bus?

It's a Virtual UART. Internally, it's two FIFOs accessible via
8250-compatible register sets on both ends.
There is 4 Virtuals UARTs on the LPC bus of the AST2600 and 2 of them
are bridged over the PCI bus.
So, from the host, you can access the 8250 register set on the PCI bus.

> > +  aspeed,vuart-over-pci:
> > +    type: boolean
> > +    default: false
>
> There is no such syntax. Please do not introduce own style. Instead,
> look at other files how this is done.

Ack. I will remove 'default: false' for the v4.

> > +    description: |
>
> Do not need '|' unless you need to preserve formatting.

Acknowledged

Best regards,
Gr=C3=A9goire
