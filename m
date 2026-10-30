Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339787;
	b=aVWo7db3tuH1XKyU+kfQg24wM6H/9Huofugya7jKTKuAVYYoRAgxFtaT2UW6+PGnUU6n
	 Jz/DMq/L5CQamFWuY751x4KvblihE25dfDiu4Hboh4a4S0100/mfbBVKLCXjbiY0zguad
	 5Gz6RTDF/rffHke9BMpCdO7sPkZsIVvAYQX4+0QxInh/8cCK/oqqXuZMhvDrnMOa6FIti
	 FnCRbnBOL22scRvjn2BtBL9drsD5g5eW5mCdKKGsnxbeMYiul6+9XBTwC3tlaItc3+qz5
	 qu8i+xUvX5xBRcQSja4++f9XCS3t/o8X3795UMshBYzCVGTG62YO1ymI1V6HGpZ3OjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1anniFrPD+gJ2zvk7tqiNGRs4XaU4IBzFvazZsvzhO0=;
	b=Xf7SASShXuYobflsuHa1egPn79jan/f0aKgCDkMdKwamD5a5GvmNxcMG3CbxFadFDMEL
	 O91tOTG9yNvqUkhHYE+PzspLITORPkBXhB7HRsYcBffzbxEMQLCJhPuxCz7eJLCjR95c6
	 Fdol5yX9shKFPv3iMVOclrqcoigX06O67GELZxbyi0dUV8oTluxkTMZopyMqTgQVHxtff
	 LATb2f4Vz7dSIjNPRdeYlwNqdYdXmD2a0qZ+O01zclDP9SpiAsHjR8mM3zqcQ4vfFxTVC
	 XHG7j4ADPc//60gEU1nBpWhX/XqZMX2CexTCyIoIlD0mptrrGjff9VDPIVeZGNgQKKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fKl8poaN;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E8B606A31C
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 05:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24E8B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fKl8poaN
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac6fe4aff0so304487a91.0
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793339785; x=1793944585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1anniFrPD+gJ2zvk7tqiNGRs4XaU4IBzFvazZsvzhO0=;
        b=fKl8poaNCXBEsyf/0TeOYoZMv/2E/sAsxAaTA9idn5zsncnfapu7bD/PQdeQW90Mzn
         mCzONwoZQBnHk4TvJHXmIuspzXUn2H9t0CUzKLY1wjQUoPQ/WFGjC1kyGeWOVUfAH7gn
         GGYPK34LxFAT6RfKoRFzuiMs300X7QNHK52ld/T6rNpRC10GIZTZAaR38cwWwa+pmqT5
         xNgxif723swRBNrxKbd869GrkaKNVdZpoP+PWOZhlwDvb9cJbQyMqi3Wk+fWZiTUYEyX
         DcD6QyYsXGvI0CVsu9lwhMgY6tQGm8IllX03u0UwLGi6Az2Gg87e7aQzoHzlusCMUJEt
         DEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793339785; x=1793944585;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1anniFrPD+gJ2zvk7tqiNGRs4XaU4IBzFvazZsvzhO0=;
        b=usNWntA9egEXnQjWEVTvXs7m4FS/WtVyU5lEtxSeqCYFp/OoSR+guMjghPpQYQkDr9
         cRtRr5RFUor13XQzhqQxH3six1E3OK9E3YPt5wowNbArY/OsUfLnf9NAaodw1a5vhYjG
         eZaSib7/gbQhx+g18Bgf1e/Fa1xbJyBX4NyoRZkjE55ToAujy5J2J1E4qwXmRMmxizBN
         RUUudDb6/z7XV0uZ/sieCWYZC/LYZcSatJZtB+EYUtokrd/4XMZvQZzrt79Gwj2lf5tz
         Y9MyE9JIHDWVfbdJqqdDJOQCHr5Tnzo16OJwKLDN2tdFvgUQjqeJ4xcSnfmMe0Fl1PtE
         ySPg==
X-Forwarded-Encrypted: i=1; AKwUvBx2b+lg8eZ0EYVtBZP5QiA7fcgyzdAbRzIizmUiA3XmRzu/1dCCzcSbf3EcDs1pvbeCpewlaNJUTwOxZbY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTHMD1Vy8XmITrO+NQZzGX+MFYoiqw0apmq7HNZj+OFVYaQVe8
	LVKkHpPvo/1Zh3hBfe937HzLNuoFA/ZeyOuqgP4d/ppdekGaaeI+wHa6
X-Gm-Gg: AYBFou0rKRZyks4A1/y3yR+38Wd2IKlpT1n2OrJKPIrkiHv9aTTlsNr8v/UMO99afeq
	/dHwRQ9kkaLyEbuPjiMxs9KqkjNspqpAG+BLYgpvKDvpmWQ2rTWxuspzIlVf2mDkRHDhJoYOlfn
	FkARAmyEzX7FoJsV7cZPJPCNX9EBtYsC0ahv5bgk2TZitQVorb6fvLIOE52Gvej2KlYaaqmuc9q
	ca99sfuok6zKE70ts7iDyvKYm5RXIH8DnqPxFBhRcJnPUAqMSYOB14ehFChNthU9Js6r+1wCgTS
	oxlLtbHi+HxP3CyZ554LM2yHbDZnkxbk7C4GMs+EkqZyKz5LG22/3EjpPVcR3aq8OUC4Ww5oTKC
	PPUNw71aoeW6PJLrZ07vxwTmqu62nCBUH4/cPYHOO5/znvUsoh7Ggy/v3Hrqx+yPVE7Z6PTL+Rw
	0MLI67RS88rL29StB0L8XpZQPdSZdCCf0ZWy2s1rIy35hY2PGSnqQzB0nzrFhUqztMO7gATFcTR
	0/ZrxQ/TFzCoI4UMo0EQEMe9MK8zgnl/kvV5dM5dOOKcLr9DiIKyECn+OnzdNqm/rGX6TOcxGeo
	WaE436W6NNFJAPM8leuHBg==
X-Received: by 2002:a17:90b:3142:b0:3ab:4f1:4f7e with SMTP id 98e67ed59e1d1-3ae897f3919mr1033345a91.28.1793339785483;
        Thu, 29 Oct 2026 22:56:25 -0700 (PDT)
Received: from debian ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8454327esm2520564a91.4.2026.10.29.22.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:56:24 -0700 (PDT)
Date: Fri, 30 Oct 2026 01:56:15 -0400
From: Kwanghoon Son <asdfkwang@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 05/12] dt-bindings: serial: Add BL808 UART
Message-ID: <auQxfw7NgnfnVi2G@debian>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-5-b736ee920078@gmail.com>
 <20261029-pouch-enunciate-e74cf84e42a7@spud>
 <20261029-sequester-countable-6a7b597c2551@spud>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-sequester-countable-6a7b597c2551@spud>

On Thu, Oct 29, 2026 at 07:18:38PM +0000, Conor Dooley wrote:
> On Thu, Oct 29, 2026 at 06:54:49PM +0000, Conor Dooley wrote:
> > On Thu, Oct 29, 2026 at 01:05:46AM -0400, Kwanghoon Son wrote:
> > > Describe the UART register range, interrupt and baud clock input.
> > > Initial Linux support targets the BL808 32-byte FIFO and reuses
> > > Zephyr's bflb,uart compatible. UART3 is D0 PLIC source 20.
> > > 
> > > Link: https://docs.zephyrproject.org/latest/build/dts/api/bindings/serial/bflb,uart.html
> > > 
> > > Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
> > > ---
> > >  .../devicetree/bindings/serial/bflb,uart.yaml      | 57 ++++++++++++++++++++++
> > >  1 file changed, 57 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/serial/bflb,uart.yaml b/Documentation/devicetree/bindings/serial/bflb,uart.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..df29d258f0a1c6d7bb283cf19c4157436991b64b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/serial/bflb,uart.yaml
> > > @@ -0,0 +1,57 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/serial/bflb,uart.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Bouffalo Lab UART Controller
> > > +
> > > +description: |
> > > +  UART IP used by Bouffalo Lab SoCs. Initial Linux support covers the
> > > +  BL808 controller with a 32-byte FIFO. The compatible follows Zephyr.
> > > +
> > > +maintainers:
> > > +  - Kwanghoon Son <asdfkwang@gmail.com>
> > > +
> > > +allOf:
> > > +  - $ref: serial.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: bflb,uart
> > 
> > This needs to be a device-specific compatible - please just use the
> > binding already reviewed and agreed upon in Jisheng's 2023 series.

Again. I'll base this on Jisheng's reviewed binding which is
"bouffalolab,bl808-uart".

> > 
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Baud rate generator clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: baud
> > 
> > Drop this clock name, with only one clock there's no more need for it
> > than the interrupt-names or reg-names that you do not use either.

I'll remove clock-names from the binding, driver will look up the single
clock without a name.

> 
> And additionally, I see no value in picking something to suit zephyr,
> when zephyr uses things like "bflb,clock-controller" or "bflb,pwm-1" and
> "bflb,pwm2" and so on. Make a clean break and do things correctly rather
> than try (and fail) to be compatible with the zephyr dts.
> 

I'll describe the hardware rather than compatiblity reusing the Zephyr
name.

> > 
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - clocks
> > > +  - clock-names
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    uart3: serial@30002000 {
> > > +        compatible = "bflb,uart";
> > > +        reg = <0x30002000 0x1000>;
> > > +        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> > > +        clocks = <&uart_baud>;
> > > +        clock-names = "baud";
> > > +    };
> > > +...
> > > 
> > > -- 
> > > 2.47.3
> > > 
> 
> 


