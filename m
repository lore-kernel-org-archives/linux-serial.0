Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339928;
	b=BF2d7Wyz24pl6P1hyYlL0BeHzMd6RiYpdsLYqiVt7nPBHpBveJAXXjwyShRWqUBja2b7
	 CbhbYFP4h+UoI2YGi4fttmAc81ZDEq9CXh47ZgQJuTvWeIb+d9Pi9OZPhvd5qpvrZCpVp
	 /OHsBCT6sDlTB+O/OOFhWVT2QjZpU7/wZ6szlXQoKSLbO/vWOwGRcxnEjYDdkD7RbUiX3
	 V7MLIJhrN0LyrNpchlp6KBzN/5LC6Dz5/+XSehBk1s5gW44p0xFychnqOODFK9aml4hHL
	 XSMEKbmmrTvbLbSucJeJWWnLNuCntev4cwhkyFHsJ9h0t/cZWpRNzXgHVJPyG8RB+eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=x1ZOonFo86/OLdHx4TEfvsl1dhP8QB7LtaQ6AkA34Vc=;
	b=hIy8pGbk/uPVu3wJUgOZkYtqFg2F4g1WptB9tupg8nNq86ekUpdp/67WkPJ4FVk58hJ+
	 rI6zB6BrSEPYSjkMQ7Pp68gL6N3v9VVSbR/lx611/Z1ot6cGohCc9I0gAyfZJXHP7H5Rr
	 JG8VA373WwgF+UMShtOyhshl2BaW3lhfnUk+y8IrGNH/glG6xK13B6lAIDmhqZ7vf6xU9
	 UPd0k6p9wJ7A1XkYr6WGXMoB1nGCZFMfsvfk99JFWBWuoVc7uZGG+2oqJqUHpUfWBLn1I
	 vrZgO8MexU6S227zwQifgsrP/IHP7J2EN/ZOZogqYnjfhgnbf8iWvkKQxj6+BLKqf6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UxOWSyi0;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF59606A31E
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 05:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BF59606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UxOWSyi0
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so259349a91.0
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793339927; x=1793944727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x1ZOonFo86/OLdHx4TEfvsl1dhP8QB7LtaQ6AkA34Vc=;
        b=UxOWSyi0ZLjT6K/CtEHFfVSX4upjGZhtjvTQuYaOgoghxRdqk6YuYKma/rstK8OnyW
         EnlMZpYbwB5JxxcbXq8zBvy+70m6AbbNzMP6+FwnV2skuLOZ6ipMEK7v5pYZrMDTRWMA
         AyTTdhQO6aHAZ+xHJkR7p1UXP7BbTaP+l3sXKECV2E/6YG8xkNC8Hzwx4lzFGnBXzpzh
         qye8ca0y3z2k++H2xxu1sQvDiEJY2Euq6dJmJ8wdUAnZTEfBMvK1RmzJsXaY7ZA4XjhU
         GuO0J7l9DqYUyarNsZNIDWJGksm/oUJs3nxPxK0HlTarEOkVg9jXhvNXEJBdgV3wfrIP
         naag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793339927; x=1793944727;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1ZOonFo86/OLdHx4TEfvsl1dhP8QB7LtaQ6AkA34Vc=;
        b=HCyy37DYEB2no/QJORUs+g52i+ITDyW4yhlplBDrmt5lOUV8leEsKOFklBVsXdzyNf
         7cvbqUgedn8fVzESwRyklFsK2wRkoXZik8kDk8aqDW9Fu4hzWDctU7wbQRZeQPlTXLn5
         4xOmcCcMhY7VEw/SQeJcA/7X4dY4vRYLiBCNwVzE14YcCJMxl+6DBFmMx1Ndtzynkxwe
         Hrq3s71UVie+4uAsn7tKR3SLtXDDoR4uRyukJg0huWjsN8fnW2vK7Lhfjyjj3X554mX3
         kdf6zB53NpBQn/wAkp3gU4UI+daBQ+ZKJnetNrep7wY07lO4rkIzOTRrO4YJdfNBL5Fo
         TPNg==
X-Forwarded-Encrypted: i=1; AKwUvBzNa1XGYKX1CCrCtk5jrJbVWvFilzMZXc4h/tf4M0Bl0LlgqzxwGGlrilAEpgjVJEXVW+NfqtzLo/oIhq0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCiskQBlbCrSmtqrKBfRrWz1t8uvJOJ0lxU4lZzRy2jJTJ1ly/
	9KpifoyENGcfchJeCjLv8M48ApwBne5FTzngXuIX6iC0KBUG8RJD8oBI
X-Gm-Gg: AYBFou2BG3vFk3Q1Tq4RHsIOj/tUK2Fiu1kf4KCVJMsWHleTGqaKVtvchnQkBSL3C9c
	FxVP9xH8Ay7fRA5XsBSy9fiUCLnR015b7pbqzHM/lH9+IJ5f9HFGf27tAMsn4wPkM1Bhoi/b3QN
	RE1NmLMShfnwcYpwwdSBkdIkll1vv2RUyuNTp0loh0liG+JFIYki2AYNh2sFIMRqs4dCzsHNp13
	kkCWUwq5KPyPlRFAbOy6u0LzqrOtS5g473uAvEMxuzax3/AWRzG7SOdbjTrsNfTbxSRruw7WJB/
	V9OdFjBwBkYUHOvHBDAVttiqvLo2an4R8oy8ZfeiBwKU2jolj2zgWWV1fqQi9yJgaa0IayNJCse
	yeFfSTg+hNopVWfrelVRd16zgKxnd5oaOMQqEYiyOaPaWpQ0Xp0N/UxxRYjfIZCA+klJxnB/IRH
	WDpQN/ZFoK6XbCtVuXHx/xye0lXmtyKfUgYMkkab7+DThHMdD9MiAzKtjgkgcJnlvSXRlforQS/
	1WdcoX+fIR5HXZB2xSXosUXmdSH0CGg2ctve8lh0xEq1UxAm19FmwmlneCJm7E0t3HAdG0DPzS/
	GK9v7r+ZK1D3N9ZwVVXY/Q==
X-Received: by 2002:a17:90b:4e88:b0:3ac:85be:cd52 with SMTP id 98e67ed59e1d1-3ae89867829mr983310a91.59.1793339927439;
        Thu, 29 Oct 2026 22:58:47 -0700 (PDT)
Received: from debian ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb2c5sm7211185a91.3.2026.10.29.22.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:58:46 -0700 (PDT)
Date: Fri, 30 Oct 2026 01:58:38 -0400
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
Subject: Re: [PATCH RFC 08/12] riscv: Add Bouffalo Lab SoC selection
Message-ID: <auQyDnBA2tS2MtxV@debian>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-8-b736ee920078@gmail.com>
 <20261029-urging-dimly-3747c8bb9b1f@spud>
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
In-Reply-To: <20261029-urging-dimly-3747c8bb9b1f@spud>

On Thu, Oct 29, 2026 at 06:58:41PM +0000, Conor Dooley wrote:
> On Thu, Oct 29, 2026 at 01:05:49AM -0400, Kwanghoon Son wrote:
> > Add a platform selection for the BL808 64-bit D0 processor, including
> > the T-HEAD errata and common clock framework used by its UART.
> > 
> > Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
> > ---
> >  arch/riscv/Kconfig.socs | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index cecbce0c498384d3283ed23cbf2514391eee361d..ea4667da7716a9a8d2ae156c422b277064b42530 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -12,6 +12,14 @@ config ARCH_ANLOGIC
> >  	help
> >  	  This enables support for Anlogic SoC platform hardware.
> >  
> > +config ARCH_BOUFFALOLAB
> > +	bool "Bouffalo Lab BL808 SoC"
> 
> Ideally, this should be more generic because it would eventually include
> other bouffalo devices.

Agreed. I'll change the discription more detail with devices
information.

> 
> > +	depends on 64BIT && MMU
> > +	select ERRATA_THEAD
> 
> > +	select COMMON_CLK
> 
> This is not needed, there's a select of COMMON_CLK at the arch level.
> 

I'll remove the redundant select COMMON_CLK in v2 as well.

> > +	help
> > +	  This enables support for Bouffalo Lab SoC platform hardware.
> > +
> >  config ARCH_ESWIN
> >  	bool "ESWIN SoCs"
> >  	help
> > 
> > -- 
> > 2.47.3
> > 


