Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360293;
	b=SrtEP+KXg46HfSrFi9oqYV1LjJXUqjlurAmdKKlW3+3V/UdUO5YX095CR2oWQiZM3Qmy
	 wmQGi/HO/2Fe9APqVdtQMoKyddPlSu5G6tRI4QZ/ZezvyzuLZC7xH28TRj4IjWy3FtHX3
	 ArWwrl75FJOizp2v2lPWq9VsE/NIhsUYuu5uJ5eoI+boJ6m0zMsNTSlnByu56Cxbk3CbJ
	 VlnynVMVTdUS89N/gp+wONyRRupd5IKatGS0pwtPJ3ta9vB4WJlHvOzBoShopb8m7Mivr
	 IFmgHagcShHfHL97x402VNMUEHd/D09BG2wdPOkd+REa/g85lSzZoerrNphx6YjkJEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=e15qUec2OZ0h2GwREdIp79FcmOHYvFA4NalPpqIJkEE=;
	b=ywtfOu9+7yVGqsfnge+FHJpzvXUkA1ncOT80smzLBRYzIqLIOE+dNHKKNqKtIInjUJhH
	 Y3yft062AVtoyAum7uGA7AjVfweWVhirnf/uWuqTquf9qKcBKh3w3BuEYBuxZD8v75aXG
	 62Ayo4mX6c5s9NTitKNaf+mXyYr5+c5/x0wn9GSejmAA0UQ4JwcLR9z6JhNUN+nW3BdB1
	 MY2IcX65SE8NRt0vwZ800gSPK0oMBPH3vgKHEzIrDH4M5BHrfo7dkHz2d0n/9ma4St/hU
	 tj8asXBu0b1QbTa/P1YmN8+nkT2oWQHbEtNFaxmWzb3lykJouUtYretdS+TFXrI0bUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tE+EbX5K;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA0606A31E
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 11:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ACA0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tE+EbX5K
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-89ff475a152so170025b3a.3
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793360291; x=1793965091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e15qUec2OZ0h2GwREdIp79FcmOHYvFA4NalPpqIJkEE=;
        b=tE+EbX5KjLQieRMqd53kce/1beDxB0fzvNrXs+EesbVbO6RCbTs3RUvFY2aNHMLqRi
         S+BOPfIe4jnCUuWdIKhOxX9RwPb8om8Txoj5rtTVhA3UxtureS/YrL7Sz6tJ5r+Prd4f
         kKzAeVO8Hcy++POmk1YpQs4j5e5UC8tbQpcaS1nsKqHeRkD/Ioe37qOmbDTYN7QsQn39
         otQXCXtItQPWq1TWhm+b0+s+nfhP2ckecxD31qkJTUOaumPl08H4a1u3QFXro9x5HV2I
         b2BpRZCuNZPlMEJxlCCB42OEtgrFdAouSz2XGIBq2tGXmrmxX7KCtzfWzQxwtCjOjakR
         RyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793360291; x=1793965091;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e15qUec2OZ0h2GwREdIp79FcmOHYvFA4NalPpqIJkEE=;
        b=gSdgmEJGSbTKkNB/ZrZmf0lDyPvmz3rKEvKi9OURgtg3Ai8d19YJZTiqupCgB83Emu
         acmfOoLBvZGDbZdIeT6c04PfSTCae2ot0Zv7IAg5EJGnVh/i5mkoX/wucq8hw7x9zcSf
         +zfCIE8f+8K+nSNTzzJ+iy+PrnCJMFYmC4U154t5O/nARLPX9NQdohQEE+7yE3wXLYdt
         uXMxQay1/iCRXrBcUOBwHX54Ob8Vif65aBkPavxg0u6ibuY7nH+mHo3jqYDdu/Jzh+Hx
         VGHSN+pDgtgY2qcdtm8vWRy4jNIJri80wTp6d7iTVPX2DWsGRyxCRoFEaIg2ho5bAUUi
         z7ew==
X-Forwarded-Encrypted: i=1; AKwUvByM5pPdXABi8p7UC2oTwKbbIrCAlkxxTFiI7QeiHoumTLZ4008eJQMJP4rx39a0gfLYTbzoYmFzMjYAa8M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWz+ko3E5Jnslm3nMJx+d/Q65d6TNkbv15d9saA1Kg12xpiakE
	7jLyBu0PHZEHP9UxtOcUG6trWZV9qBhAHKeug1+uloeU8UIpfVZep9RD
X-Gm-Gg: AYBFou0f47c2oxIdNhCQN8IecIxifli7JcMtvVZbk+PWzdEUxHF+likVS7Vcutc5rS+
	+aBYgWl8a+dgtR2pRzhFSpLNZB3saCREgJAe7d3bX68vI4Vw1JegqQWQidD0T3qCCjNDmTt7Ffl
	D9TqMTSs3spYNZT+p3oXju7b4r/AHLgLRbY14K/XqBWzbYl41cSqQ4aZvPEJteKGa8qc+4sdppq
	b2HLiUzXnPF9xF3Cp4sA0nFbDRZHB4+Fd4buw1iWR9Rk94uGjZaSGOuxrVPjcBQt65B29YJjSKS
	Fwn8MfjA6xNLYQHtnipvBkOACve4gWMq+rArFGI7gFMUFQm6HEBMzxQ3Cx55FmR1L2vB3isAfvB
	RrBtKrqJwvPoQ53/rUui7lJDMaKo0vgCzjjco3qLkZROvD+JTVVYood8CIgbmuc7M58zhImAWXR
	RSmRin5KaZzdzopuAhI92lsh7WC9WKoP2H4yjNaTGhSGaBDElOyeEYIbo8KIot9YcytCG/9e1d3
	3AZ92DtEFUTMUjvcdZ1qI+H0euyZ8OrgtbLhh48DqdBYvSyskSkBjdzLsBdNbFkvqqLb62p6EKX
	FsUmHCG9Gb66/1vCmSTjDA==
X-Received: by 2002:a05:6a20:918e:b0:3e1:dfcb:5a75 with SMTP id adf61e73a8af0-3e928956abfmr1766192637.21.1793360291245;
        Fri, 30 Oct 2026 04:38:11 -0700 (PDT)
Received: from debian ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9ea4865c8sm679545b3a.0.2026.10.30.04.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:38:10 -0700 (PDT)
Date: Fri, 30 Oct 2026 07:37:54 -0400
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
Subject: Re: [PATCH RFC 10/12] riscv: dts: bouffalolab: Add Sipeed M1s Dock
Message-ID: <auSBktpboye35BrU@debian>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-10-b736ee920078@gmail.com>
 <20261029-pork-resonant-fb692b84bef7@spud>
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
In-Reply-To: <20261029-pork-resonant-fb692b84bef7@spud>

On Thu, Oct 29, 2026 at 07:07:00PM +0000, Conor Dooley wrote:
> On Thu, Oct 29, 2026 at 01:05:51AM -0400, Kwanghoon Son wrote:
> > Add the M1s SoM memory and 40 MHz crystal, and enable UART3 on the Dock
> > with a direct stdout path and 115200 8N1 settings.
> > 
> > Boot firmware initializes PSRAM, UART pads and shared PLLs. The tested
> > firmware configures D0 TIME at 320 MHz / 380, represented as 842105 Hz.
> > Firmware using another timer configuration must fix up timebase-
> > frequency. The declared 64 MiB PSRAM range must retain firmware
> > reservations or be narrowed by firmware when memory is assigned to
> > another core.
> > 
> > The stdout path selects the native polling printk console; userspace TTY
> > I/O is deferred.
> > 
> > Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
> > ---
> >  arch/riscv/boot/dts/Makefile                          |  1 +
> >  arch/riscv/boot/dts/bouffalolab/Makefile              |  2 ++
> >  .../boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts    | 18 ++++++++++++++++++
> >  arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi | 19 +++++++++++++++++++
> >  4 files changed, 40 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> > index 69d8751fb17c803f0efb8003e111ee24144c222b..294f9c119f8f1d608c878ca1f95891843301f07e 100644
> > --- a/arch/riscv/boot/dts/Makefile
> > +++ b/arch/riscv/boot/dts/Makefile
> > @@ -2,6 +2,7 @@
> >  subdir-y += allwinner
> >  subdir-y += andes
> >  subdir-y += anlogic
> > +subdir-y += bouffalolab
> >  subdir-y += canaan
> >  subdir-y += eswin
> >  subdir-y += microchip
> > diff --git a/arch/riscv/boot/dts/bouffalolab/Makefile b/arch/riscv/boot/dts/bouffalolab/Makefile
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..4d63365edc095fbe9df31c4b12e29c4b624cbd1f
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/bouffalolab/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +dtb-$(CONFIG_ARCH_BOUFFALOLAB) += bl808-sipeed-m1s-dock.dtb
> > diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..c719a53c6e2de45f3718b48ba2116e99c70e559b
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
> > @@ -0,0 +1,18 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +/dts-v1/;
> > +
> > +#include "bl808-sipeed-m1s.dtsi"
> > +
> > +/ {
> > +	model = "Sipeed M1s Dock";
> > +	compatible = "sipeed,m1s-dock", "sipeed,m1s", "bflb,bl808";
> > +
> > +	chosen {
> > +		stdout-path = "/soc/serial@30002000:115200n8";
> 
> You should be able to do this normally, with an alias. Why are you not
> just using what Jisheng did?

Because rust does NOT have alias OF yet.
I intended to post the Rust OF alias helper separately after this RFC.
But if this way wrong, I would patch for rust OF alias together.

> 
> > +	};
> > +};
> > +
> > +&uart3 {
> > +	status = "okay";
> > +};
> > diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..ae54e6e301ed2c5a1448d52c530c5074515ee38c
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +#include "bl808.dtsi"
> > +
> > +/ {
> > +	compatible = "sipeed,m1s", "bflb,bl808";
> > +	memory@50000000 {
> > +		device_type = "memory";
> > +		reg = <0x50000000 0x04000000>;
> > +	};
> > +
> > +	cpus {
> > +		timebase-frequency = <842105>;
> > +	};
> > +};
> > +
> > +&xtal {
> > +	clock-frequency = <40000000>;
> > +};
> > 
> > -- 
> > 2.47.3
> > 


