Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793815674;
	b=FTP5rTw+D0E4mxp3luMJ/NRZ30o/iGTjE67cUcgl/xxTwLjogxIuNQ8jLLILP/P0Ayak
	 abHys2RFrO1rXWgR9j/11wK5opiG7v4AvbuCGAQCh4wdtMJLeMF0rW4gACrdRammaPXDR
	 WA9YYg/OJV8P5HTjSGde4ycCo21JnuSeZvCL2z9IrzojrQCh0ZPIk1p7GDrPSKjJEg604
	 pmcMrA4cLUdS8KliiaBXb5AXIx+VaOQ4jswglNP9CxQ3BzXJLA9GRxAG2cIkQxtf722Si
	 ToFGMG4K6dr36pZ0+XBJsR4hHYkMJnOL+B9k5b//tmE6/l6kShBEIm73xHYrqz4JbHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+gQ5Cuyj8b/949TwI5RgIKdEjddDg3DiMb9qtnYfCaQ=;
	b=QwmWBdXTjd5tgRMQgLGP8QDOqHhMTT8+2GbUCvMdDHUY2eBgy590htviVhJV/94mO1Gq
	 qbyOWjh7Oh/03CvbQ+SA9A0wmfNMNlgHNwEUfOXpHQtIHKhzsV1q6g0Q5y6PxSKMpe+Uj
	 laqM1u3yNqOs1413JEKvEkfjzCvEGZEP6yMoI5shZOc/w6B6tw/n1nQJsfsf7LCs9XIEg
	 0d3jTKzra/7sp1uypi1McwqREr/RcBLLwuMHTC0k0HpJQfxqcm2EYQh7ltVI21a0VMTnD
	 57dXClaGFDanhx3sTh8VwjpTunLuGdD9ppOFt81I7STJ5Y1xrSawmLVZqAR6p6+z3/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OC0GfPy8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB9607A3CE
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 18:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88AB9607A3CE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OC0GfPy8
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eae1276409so342491e0c.3
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2026 10:07:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793815672; cv=none;
        d=google.com; s=arc-20260327;
        b=VjDQcrxLSmFFSQru8FaxdOsfV4vw/0vaRmD52YNEUoBoVbnRT7lLOHcdHo1OXqOI2O
         0ZyjwyypsLBgxPW2ScEr5jH9pHd/dMFpr76QXGB9zU8cajOYxUQVXiseNM3zl4019Hmy
         e4Jub8BpMtepMKKWrboVUrKB8lRSXDzV9ibXXZH/evGPXs6hsjagsi/gDbf5Y4dEUYyZ
         IZKuhLeCxGp7QfuUEGKnrRW2bW48I6MePrtCKUwo8WjTdLCOyrDMwqI81Pt4jnTEuwKs
         4vJGeGi9GAbs8FB/JL2YvpyNgMBg/bsKSSOgDGM4Vv1rav0AY1XVBF3n/CULuUIubci/
         Q3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+gQ5Cuyj8b/949TwI5RgIKdEjddDg3DiMb9qtnYfCaQ=;
        fh=2hbPwCrOjydSaAKVp/xn0r9QhgIo0/lUEuB2+1XJRwA=;
        b=Qov1XfMHyZdZ2KwV9sTwghMZ1lVTJmAmu7HfNqIWsZHUT4GfawzlPX/nibWgkzecXE
         3kQTXFO/Nd4dHTwcBscAZxYzDEKNz/+eQDC5mSd276LhdXiMj8KxBCGsYOANrpe97I37
         g7cFu74ykoYc7+2V6CtuhApCSv9Vs8zrwIX9u+C54lJvQ8DFG52bB2WXzKNeN6PnUq6d
         lfevIwo/yGKKgJg9azBoV/5N/QxSinLnA5pIUK3o7BsP4JKB7KpmOsHja1Qktr7uwTLV
         BBtsuY8Xl/BoGXxhgufQdf51U/ChKbDXlxLd7gvW5sdsfjhQXzGnwS4rY3SOa68IZHIB
         kTkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815672; x=1794420472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+gQ5Cuyj8b/949TwI5RgIKdEjddDg3DiMb9qtnYfCaQ=;
        b=OC0GfPy8B6coBFfqqPUhLTgXstjsDDCFbNUJMZTVIqso3hvWFKF0azN0fCUDbJCAAU
         wfCT/GZi5JrYt7lLimUB14AzLYhqnKi4F59ReUFe3H2Wqu3KJl1X3yj1oYD9Gw9fHvqo
         qAHOEnBm2uSSdcMiOEflwxmtfXlFNzD+EsyHYZY5Vt5h4ZYcy7uLUmVb+3jq4a4wL8wR
         MD+Nt/Oe+x8mwWyqP5gaQ6ziv6Sx5dsVMCc3yi3OBc9th0Lq0RA4mVEcC9UWE20fBQGg
         POAUoS/anoBEGQPi8B4zcNI2L65uHATBiLA6pGDRKqHH2RyPejN6je54qH189TLi3g9B
         nW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815672; x=1794420472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gQ5Cuyj8b/949TwI5RgIKdEjddDg3DiMb9qtnYfCaQ=;
        b=rfQEYSMdFvmYF3x0779uF4MITWVeX4xCnVwlUDtFVPd+BQyIAqjitmwUIyAoscwTHh
         TIkJfbnL2yRHpEcPNKxQGMirBo0Tkf0f/vPW+WPYKNExb8fOfp52QqVXYVkTiV9ebz1f
         QVFyI8zIMs63Rvl6vmqTglECfLjoWLuKE4ohvl5bVBWFIWUkw8i/k93+c8nw7ZNTuPAU
         e6uhGs5RrsvkIEdoGYuwt9kin7n+eKzfnLIjGIWdkPmFSydMsmL+M1YCFMdGL70JKGHu
         Ii4vJEMBgBpuX7On/1gyoc+mCX1CBwxAicO+guIdy1w3L0FoUSpCyjz5Ojh4USHkFNA7
         hF/g==
X-Forwarded-Encrypted: i=1; AKwUvBwhQctv+eT2lefXpC1tIDXI7bk15k9X6vg89QM57r/8eDWPm8OUCxdpo5qj9UX2KM1YgjG2/bBIHz2XdDs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WC2Ky64D2iJmaLP3uaqVXGJLz6dNLOSUOQFPyAMTxNovJA1Xz
	XluEJtYkymCbcP7lzleA7hO2INN7kqmUngrsGy+sOmdc/avt0o1HC1tbPfEipkrU7R16Js8eYIc
	SZT7c+HYruLuPPqULvfNMzmnpIRXabd4=
X-Gm-Gg: AYBFou30+nC3cjfuPRpxY0/LZ2gVls7nxaLklFJDssGkytCwXqdgz1rxGnI+7BqS+ls
	Bjk8yMk7/vLb9l6fp38Z/vs2CYuI6nipE+1widASDCdAMAf5vs10rxxSi2+nklJM+gN3/dev/IS
	8uW3Tb7pSmMDh97iP9wUyzIwK57v1M5hNJTuX5qc01WqAWtoDrjigFBfIyxl9YghST4F4YP1rxk
	RgiCbQJTFZrAg7Uj20bnUnS1D/7tNPDvTSHS58zjAaf0Ljyj6+4/VFUl6igbBREEno9LtlSlN4w
	xpk+6l2awq60qzFaaf33bcEw9mKBRazxH2LTlEFh1d56BPa693Ztyr8CCUZGGSyAhbqnsjZ88xt
	OFqGJkxikccHmfTMkhtZBcRSVjFhBrHsaEM1xQJgrdv5W1FzxotS3/l2gRP7KzOZ0xvmAJ58RJw
	PFM750CD7OpmOj2VbxP7GzHAyz3gBMTH/JvIwyjw0+2uT/O/rpSHi8BSqUSd2LTf3VCKqkk3QOP
	dBEDqwNoE9gpitfsIHmpEYMvyYlEEjkbz2E20UbjgM8R0Mh3Bk=
X-Received: by 2002:a05:6122:1794:b0:5c9:a60d:3275 with SMTP id
 71dfb90a1353d-5ec6894bafdmr7258349e0c.9.1793815672343; Wed, 04 Nov 2026
 10:07:52 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-6-c9e248d685c1@gmail.com> <32461e0e-2512-451a-8eca-f2df63553379@arm.com>
In-Reply-To: <32461e0e-2512-451a-8eca-f2df63553379@arm.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 4 Nov 2026 11:07:41 -0700
X-Gm-Features: AclHuK8w6f78lagZOCqY3kBXvDEG6Z5rWFvxVoRwnTwu0OTjK9VJe-pup1TnDtw
Message-ID: <CADvTj4qPfWo=w0khBM+vPfT4vxCJVBQsqzAE3C9V+2J7fwq9gQ@mail.gmail.com>
Subject: Re: [PATCH v7 06/12] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:59=E2=80=AFAM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> Hi,
>
> On 11/3/26 22:39, James Hilliard wrote:
> > The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWa=
re
> > component parameter register does not report the FIFO depth. Its option=
al
> > register layout also differs from the generic DesignWare integration.
> >
> > Add a specific compatible to identify this fixed configuration, retaini=
ng
> > snps,dw-apb-uart as a fallback.
>
> I think we should not focus too much on single SoCs here, all the
> Allwinner UARTs need some care. We should have had SoC specific
> compatible strings (plus the fallback) from the beginning, but we
> didn't, mostly for historic reasons and because it just worked (TM).
>
> So just from looking at the Allwinner A10 (the first one really
> supported mainline, since 2012): the manual reports a FIFO size of 64
> bytes, and it has none of the DW config registers.
>
> So I'd suggest:
> - We add compatible strings for *all* Allwinner SoC's UARTs in here,

The current series covers H616 and A523, but the setup is structured to
extend to other integrations. FIFO-depth discovery is separate from the
shared DesignWare RX-trigger calculation, so adding another compatible
does not require duplicating the threshold handling.

> regardless of whether we currently need a quirk for each of them or not.
> This is now regarded best practise for DT anyway, we just catch up on thi=
s.
>
> - The FIFO depth is all over the place for the various SoCs, and most of
> them do not implement the CPR register to announce the size. So we
> should use the already existing generic DT fifo-size property to

v3 actually used fifo-size for H616. Krzysztof requested removing it
because the fixed 256-byte depth is implied by the compatible [0].
That is why subsequent revisions supply the H616 depth through platform
data instead.

The earlier discussion also covered UART instances with different FIFO
depths. The feedback was to introduce the property when an integration
requiring it was added, rather than require it for H616 in anticipation
of those devices [1].

A523 provides a different way to handle that variation: each UART
reports its depth through FCC. The current series reads that value,
rather than putting either a per-instance size table in the driver or
fifo-size properties in DT. H616 does not rely on FCC and retains its
fixed depth.

Linux already reads fifo-size into uart_port.fifosize, but supplying the
capacity alone does not handle the other integration differences. The
H616/A523 setup also avoids generic optional-register probes at offsets
used for Allwinner registers, and installs the FIFO-relative RX-trigger
table instead of using the static 16550A thresholds.

Older integrations with a fixed depth implied by their compatible fit
the same model as H616; they do not need a discovery register.
Compatible-specific data supplies that fixed depth, while FCC supplies
it on integrations that expose it in hardware. Adding fifo-size in
those cases would duplicate information already determined by the
integration. This is why the current approach uses those two sources
for the FIFO depth and shares the remaining setup between them.

[0] https://lore.kernel.org/r/20261027-nifty-reliable-octopus-6cbac5@quoll/
[1] https://lore.kernel.org/r/18f1e637-48de-4962-8a13-65f6597eb2dc@kernel.o=
rg/


> describe the size. This is the simplest, yet most flexible solution, and
> avoids hardcoding implementation specific values in the driver. And it's
> friendly to other users of the DT nodes, be it U-Boot, the BSDs or
> whatever else is out there. IIUC, that should already work out of the
> box with the current Linux driver?
> Since we need to touch the DTs anyway, I think this is the best way forwa=
rd.
>
> Cheers,
> Andre
>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > ---
> >   Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.=
yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > index e2ca126d58ba..fc1289073241 100644
> > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > @@ -60,6 +60,7 @@ properties:
> >             - const: renesas,rzn1-uart
> >         - items:
> >             - enum:
> > +              - allwinner,sun50i-h616-uart
> >                 - anlogic,dr1v90-uart
> >                 - brcm,bcm11351-dw-apb-uart
> >                 - brcm,bcm21664-dw-apb-uart
> >
>
