Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360686;
	b=c38cgJF28otCpc9LEJIMxZ+NoesNIZ55G4ybNu13L6eo50CtjOCqt/w1UKS3ZPKAQILH
	 5rYq+QDR7jeVBQvXbDMwLgcvFG0w7kCgjw3vnyUJ/LNqWOXY3Z0i62ZmZF+k6mjvsA6aG
	 zlYW124tpsgY7tHFzAJtRsVa1vX6Lt/Psp3A1iTzwC7pqrQEr9oc1GS15BWwBCl/Fr0VM
	 tvXEJeikdS/pET22dsQiKuA46pzsnNP+Uo8/VMgvbSCFmMGW+EobMPdKUm8SNMt16Xisf
	 +alr9Ek1D08k7r63gyzvHS6nCjgzbh0A4RB/z6DGAtRmKSSu3SthUd/pykECm1wrUmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=J/6UIvMwC+2M7xk6hrl7rsj5PVVyi+u7mrNva4BtF6A=;
	b=i6j72l8oX5j5b7ng8+5IIJw8MhDAEBjG2O0TDo0brTsAOvhd5j6FpTA4t3bgeP3Xg0Oc
	 Xq+pzcKYLUWRY/TLi7gPDXwsvogTor/+JL5yGLFQWij2pSlSSQY8NrRNcMMBqlaPQYzcL
	 Akf5AqEYm+Vo7O6iJCJfdTvYhRLzojLFh6B4Pvxaap5sN4HLVu4QD3EZIhYirMi5vcXDv
	 tQSs379TouCgquuRWzSvyCGhIRy4mtq8SHjo+t7VPnicrTr0a6IDSD3vLQDf5YDyUVuDa
	 6x6L6ZGJtmSHPixW164LBDEdzw3mqAOkfXDlC28j4OP82gohVa8A78GsIyVRuFypa2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g2ZLV5dl;
	arc=none smtp.remote-ip=74.125.228.8
Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F012606A334
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 11:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F012606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g2ZLV5dl
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cd3da0e82daso107105a12.1
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793360684; x=1793965484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J/6UIvMwC+2M7xk6hrl7rsj5PVVyi+u7mrNva4BtF6A=;
        b=g2ZLV5dlxpbuDPCjK1MaVrsjqjHMaipBPBqsisVQUZ6Ty0skoAdWgIyeA/J9clATlp
         1p31QUCLSPGy4TWe5KV53YJ0M5p3O8t50RFB+4xnBn+6p7AZfE273lGPVGIPHOozNW4I
         Brk88Y8w+9TGUkPqvbXhVtdn57OSLzIo8kkyGSJKcqqMoGP9/9uk2gR7hADIIutWzDjg
         7gpHz4vxYE0+7wo7MVXxWBdrsSaWVdHnQ86v2oJOfSh+JISrsA4SZCk6lj5ulEpnJ10Q
         ulC+27nUlFpdausCL04tV09g1AbYKQxaiCg3/e6n6n8iqx/cOEYX/bJmH8eJ822ICDF1
         m3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793360684; x=1793965484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/6UIvMwC+2M7xk6hrl7rsj5PVVyi+u7mrNva4BtF6A=;
        b=LGt/wOe8reQL9H6m17T7sjNsAYKSpiwfGKKpcsmy4GPjkmf9qpmLpTYtdeWL8xIGfU
         7n4sQCb8k6a1CniQy9FN9hdjMBSEYyqyvtQ1yd74U0BwLVHDDxEFdPzQggsQXNVEpx8s
         tFwER8cRhlanjE1QaZaK+uQSveW/gOSB/E3oRNgeE83M4sDIE0Uzat6KA98BThNDgR6i
         /10TuKjuigshVU6KpRDfJCWgNGnU4NlKVgJ7RMvAOZOJg81wrHVL8JSReonrZnX2TMO5
         HwyAWhmwHdKEussr/dv1evftutYGFHFRfvNhL5AVtQBpy3POc8ph9ko7TzazvD45rfVr
         kOBA==
X-Forwarded-Encrypted: i=1; AKwUvByDWXzDXcSsiCV3xWalkoyNIHon+MRNxJWb9OsDzHt2YkbHbMbVYsuzaTMkcYf6gRTtRkEY1kLDPVRlT30=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeDiawyLtKMNEuL24Ja/E/X4jpsNDsBtz4b/diJvUaGJpViFtx
	0yBGc4zrJMRu+Dt/YGd+hRESw4049T3fFGQDS5R3uThST7TTG3a0GGvC
X-Gm-Gg: AYBFou1LxFiXpwiIBKFBmZTAXF4Mc4ib4XSN8nCMdvPpUENjnIif3xFqovFJgIL2awd
	HR60Pqw7PjYE6Iftkqw1Ey3RA/2aqOYAwsmSGlyVia0XiovDErNMnz0Iksoxr3j4tFg1lTW8myh
	DHnxce6jaSh5QMoS/3cwaphOTwQW6nhzkU5nT6wQjBda3DzQ+tSOSC2Kbm+WnQhXc4/4z5I6Rnu
	L8cr6F1M30sDl6NVgkjreu3m6Oqs1RMwjL39zj9UaGJu/4TVtmKrI9jCtiH+m31f4mKFi89h7Ir
	mlmB2P88Q2W6aYlVyHGYXHj9IEDWHPYCSFbLizs96o28c0vFr9SGnaRHbVziw1kaWIjKYpk4sBu
	rPntnpjblHiarE+1w+R4L1c9PK8JjaOotvpiO1g95BP2PTbWeODqzeOJgg10KHc7gfJOuFV5iOi
	aK0kJK9p1Vlf8mT5OBzqhtABf4rrP0oYoQwoAeM0xxnplhkF0xmSmQO6uGFqlG+eF8g+FZt1ToZ
	Fx8aV2AtsVi62mJrATNTwu6LtjaxtV2DkCXR+yoSlrmXwy5YvBTW075xxT3A1Y8NEN986NYVPpH
	J8L/5V4jHPZm8JPHOf/umQ==
X-Received: by 2002:a05:6a00:2d1c:b0:8a0:7dc4:95c0 with SMTP id d2e1a72fcca58-8a9be5896acmr1842901b3a.15.1793360684421;
        Fri, 30 Oct 2026 04:44:44 -0700 (PDT)
Received: from debian ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef957e6sm660253b3a.15.2026.10.30.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:44:43 -0700 (PDT)
Date: Fri, 30 Oct 2026 07:44:36 -0400
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
Subject: Re: [PATCH RFC 12/12] MAINTAINERS: Add Bouffalo Lab BL808 support
Message-ID: <auSDJH9V31wmbrYv@debian>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-12-b736ee920078@gmail.com>
 <20261029-spyglass-evasion-772697094cb9@spud>
 <20261029-amuser-savior-6a6ab062f471@spud>
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
In-Reply-To: <20261029-amuser-savior-6a6ab062f471@spud>

On Thu, Oct 29, 2026 at 07:20:41PM +0000, Conor Dooley wrote:
> On Thu, Oct 29, 2026 at 07:08:56PM +0000, Conor Dooley wrote:
> > On Thu, Oct 29, 2026 at 01:05:53AM -0400, Kwanghoon Son wrote:
> > > Add a MAINTAINERS entry for the Bouffalo Lab BL808 platform, device trees
> > > and Rust serial driver and abstractions.
> > > 
> > > Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
> > > ---
> > >  MAINTAINERS | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 801f964899ba790a8f71fe61f9b3777a494dabd5..b76d3e168468bf6139c958a81b626c73b422c0d4 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4926,6 +4926,19 @@ S:	Maintained
> > >  F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
> > >  F:	drivers/iio/imu/bmi323/
> > >  
> > > +BOUFFALO LAB BL808 SUPPORT
> > > +M:	Kwanghoon Son <asdfkwang@gmail.com>
> > > +L:	linux-riscv@lists.infradead.org
> > > +L:	linux-serial@vger.kernel.org
> > > +S:	Maintained
> > 
> > Missing git tree, unless you're expecting me to apply patches for the
> > platform for you?

I added this entry after seeing checkpatch's MAINTAINERS warning,
but made its scope too broad. I'll separate the BL808 platform support
from the generic Rust serial abstractions in MAINTAINERS.

> 
> Additionally, are you actually going to add wider scale support for this
> device? Like a clock-controller driver and the various other
> peripherals, or is this really just a vehicle to support your rust
> serial driver work?
> 

Yes, I'd like to extend BL808 support beyond serial. I have local work
on peripheral clock/reset support, pinctrl/GPIO, SPI and PWM, including
an SPI display on the M1s Dock.

I'd like to bring those pieces upstream incrementally as they are ready!

> > 
> > > +F:	Documentation/devicetree/bindings/riscv/bflb.yaml
> > > +F:	Documentation/devicetree/bindings/serial/bflb,uart.yaml
> > > +F:	arch/riscv/boot/dts/bouffalolab/
> > > +F:	drivers/tty/serial/bflb_uart.rs
> > 
> > > +F:	rust/helpers/serial.c
> > > +F:	rust/kernel/serial.rs
> > > +F:	rust/kernel/serial/
> > 
> > These should probably not be maintained under the arch support since
> > they're not platform specific.
> > 
> > > +
> > >  BPF JIT for ARC
> > >  M:	Shahab Vahedi <list+bpf@vahedi.org>
> > >  L:	bpf@vger.kernel.org
> > > 
> > > -- 
> > > 2.47.3
> > > 
> 
> 

Thanks for review!

Best regards,
Kwang.
