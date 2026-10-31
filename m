Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446019;
	b=opJjIh8tOebsRV0RItQHROYzVXCFcCtJLc4w+aq2sBmn7BIqCOmw8yQVm6dCI2noYc0w
	 LOFJYQWCLAv0595BlCY2inkaYaYzC+phfiROjqLXdTmRetfgVDYYGH8TlsvQ2dFpwg9ED
	 /1JP+f6R/4YCmQY69TsLrGlwFj+sRvs5Fc7yRS+utXfhvy1veRIBsLRPJDYztKI3Fm+sp
	 fuU1qorS7gJbLwH76zjEU/pBZGLU4aKkix199dVjEp64uZQ47XACT3WJr2WdfIO+//3vJ
	 s0hnDBsI62+rqfHkXBjr7gpveUBcmIkqI9ZPBcrxAoanViLrxaNHkF6am/siSMKxQ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eBAqeg3P7IjkzEoe4Ha0kzpqAxzRiyS3drMdSnkFfrg=;
	b=eRVxoenvVnVOg/o80d3Hz6G4L/Bep3kEJCsw5lPBhkelpYlk1oekkFDwHfXUhmWf9Liz
	 23Ia0mV1X0Q6uU5MO9uiyuTLwTP41OiFWKtmH5VnwnLzSXiAScM1aSuRRongWdJi/Zbkw
	 b7pRnc7abC4M1kyLggv5nAV+95u11IcL5TOYWeSmNhSefPrM5e8YQ1bI0YbASWch4L+2X
	 q3fM0bKDV8PK/A6DxaMt4BEEJ2/IKvevez4MmwB61bjoW7PORaNXtsuqCU61AZKc07wPe
	 5BF6LMfN0lAylv+8TN8vlU2A54/8364qwYvPegBLrGYRXH84u4/sEELsEl6ByFJXufQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OOHFPiJv;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F073606A31E
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 11:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F073606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OOHFPiJv
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso689769a12.3
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793446019; x=1794050819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eBAqeg3P7IjkzEoe4Ha0kzpqAxzRiyS3drMdSnkFfrg=;
        b=OOHFPiJvJJp+Y8vZjZ0nvwcq0VjDLqEY0recjcf2GspS9dMsfqZlPeR5uLbH1VAgb1
         ImUtA2/oSWkURP9z3Ve7mYKAlbqumGkxj/mVlnRC5F40hh32RIdYXwz2u1Jp13G2qiJa
         h3HAWvRG/fMz8z2Dg5dYecnZT79LHQ3HlKAGcmkhWRBWng8CStQ5BcH/sfce+uAl93i7
         +hM+NRY3XYz1mXB/sj9jwPhtimenwm/WVCClkuoROdDITpbUakuSFRdIHeVtOS6etuXq
         XEfzvrhDSPYLDX6E8gsuC7AXrRKXu+QT3q5f4n0h/Wfsm9VhHcEIYA6mCncBZErfpBy6
         Q49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793446019; x=1794050819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eBAqeg3P7IjkzEoe4Ha0kzpqAxzRiyS3drMdSnkFfrg=;
        b=FnCi6gYVzRy27DPezJetMkQ2PQF6WPsy17Ql98JFh4WxPNn3NhuamDE5P0HoUUaKFm
         DKTTFkI3b58W48dhppCB9jlEwP/eg3Lc+ady0hNNZiob4AFx1L5LWS7Ezo/yF7r+ZKol
         sTJ4E4ZB5R1nSLRLPSJWjHC6H3Wmom5f+jDyVjF7jl3kvnsxDkNJBDVG7NFyU5GZJhVc
         2ftX879FhO8wW2xdRI1+avbuDjaLlrcnxjnh9Pgp/aQwOptR/ssoieXt0iEEloIrG/CN
         CY4XZQuLRhC7gAtd7qAn45c99Jc72aGQhlsekWBfleWd6qJNkgfq+Mh9WHl2SPDhD2Gk
         i1yQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrj48hujCziX5qiOEyewJnbLIc3u8aJ8Pdvz4C9iylqaw6XGW17iO/MfNhtjzkcUuv//ulFChA29OOZyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxT0uo1wU7ybKJfe2DaoLIadKHLEjxoKrZzbajpICn0YumjHO+
	1Qbg3gNP/R12pmjXw3XfBe3RgWbqIL/0xZeo9UL+pdiF2pNuqFn6jHWv
X-Gm-Gg: AYBFou2XdWEasfktaE9yhTrnQxG/48fiytvPil1vCvMbqcJIpkBVvQPi1eOejRUCRJj
	RhiPZlqaepEqhgXMVNEs0Ie2RiPr3l8OluWpv0W5G2+Oh+7pOS7w4iyabkluk12cQj08ncoQfsi
	DHRmOH/J0MSpMa9s0pD18bgcKGMfHHI0XeIj3kLOjhnj0wriU3OHwg/oUjVH6PKW2KoNqidBEn2
	pUus66WQ2Q5/4C70ei1q2cXq30HznfXYiCo5leQ/82mFCppPoZbJL8S+fbDsdp9DGO+cKhFk9xU
	LatXciqzbAnokM1XCOewjVvVAv5ypr23hQyIv3dRlWThWjdS6bYNb5XdMsTnzRTcWfc5Ei7cNpZ
	o6VIt0uy4pfLLBmDtjpF/LNpPVBJ7ahZVeL09g5nhYelgWKBWB4jwc8tInISPILNmRw6vVHsZwN
	z94oFF42non0XwWa23lctSr0bLoQtKcPo+RIBXK1OmCqA8WSzw2423cDp47S6h5WXMyWXbASKcU
	sgUogyR4W8PdWsPOU8oAnwqbbiaHAczjBQTAp4Jp6ofbuwXWlef2CSkpBlzy8XwMm03ViXhW/bu
	QmlILQ/3eRPKvWK3yCA4Pw==
X-Received: by 2002:a17:90a:e7cd:b0:3a0:8050:2ec9 with SMTP id 98e67ed59e1d1-3ae897ccf9dmr3920644a91.16.1793446018866;
        Sat, 31 Oct 2026 04:26:58 -0700 (PDT)
Received: from debian ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb2fesm11638646a91.4.2026.10.31.04.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:26:58 -0700 (PDT)
Date: Sat, 31 Oct 2026 07:26:33 -0400
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
Message-ID: <auXQaY25XfYzxEb1@debian>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-12-b736ee920078@gmail.com>
 <20261029-spyglass-evasion-772697094cb9@spud>
 <20261029-amuser-savior-6a6ab062f471@spud>
 <auSDJH9V31wmbrYv@debian>
 <20261030-slider-finished-360b10521e0b@spud>
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
In-Reply-To: <20261030-slider-finished-360b10521e0b@spud>

 
> Okay, that's good - but that's more of a response to my comment down
> below about splitting the entry, not a response to what I was asking
> here about the lack of a git tree. Are you going to send the SoC
> maintainers PRs for this platform or were you expecting someone else to
> apply the patches for this platform (IOW, me).

Thanks for clarifying.

Could you take the BL808 platform patches through your tree once they
are ready? (If that you okay with this way)

Best regards,
Kwang.
