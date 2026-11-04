Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753874;
	b=0kifLlae/GEnGv4JWEQahH3Xd9CxbESAhhklQCleUftOE+QggbMBX/JAi9i6+zRATOb3
	 M3l423SvohUErP909Rmy/GRe4iwbNjNMxpefAhfLtneN7CYg52bFnly87hChbVUllHmuG
	 RRi4ZTMCM4psSz41t3HmmRddvqaVK3xU/+Hb+bUKNeccjUijvIlP8Ids5oHSiQhWhYc/A
	 Pkd6RKfrZo1Ts3rdAX75FSiO70ZbgrNf3aJC4Re+WGRhAlYGbCLJVH2AoyokCudMDLNFN
	 rU4NqnwXjWzOv0ThVc/RYLy7DO2l00Skq7LtsMACjKcqPEXC5wc5BX16DMIVnDMET7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Sk8Hr0fhc3C8eQFrISEupQ4YS+zYJDt+3X6d4EBkWvk=;
	b=WqLPdiTaDSafIv9RGRz1R0lNLZNM2WWt4EbaUn2Flro4BXLLL+RCDGCZtyfJgwxf+bWt
	 WWjWfjG33YaA2aISZrx6c7aIH4ynajRpA5REsHO2OewsU4WQwh2ZHcKhknzlOjMhNZnrb
	 aDRl0OJBXBVg5sbR/3zyHeE6mjxai+OZpxLJN8gWYiXNAFynMe49coGi58zB7mFF5DW2N
	 A3IEuogFuxJTqjP52xnp6aWM2FKiXhoTfohNTiDeskwHlSJG120Og7AM6bavTKkvTd2B3
	 LnxQMnFHIj6j/rWj/SDQz7hREx47rTVyQ09HJi+Q2yPLS/+RB+bJPwtAuuj683g1OJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Cbod9g/Y";
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE76606A329
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 00:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABE76606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cbod9g/Y
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so711068c88.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 16:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753873; x=1794358673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sk8Hr0fhc3C8eQFrISEupQ4YS+zYJDt+3X6d4EBkWvk=;
        b=Cbod9g/YU3+tOlTtTnbUSHpJBHl6gN8BoKQeRJP9pi5xeiIv1FPevko0jwJ+aGLuLy
         9+Vq0qwtYZhy1ZPpENlk06KJavb305By1d6MkDFwSS94Kb6MIUB0aPCZyna27CAn7nKa
         5qPYzapHjs6ljtS11Yg9JQyVgMkYRqEZjf5pCJfeYdjPZJHnqGxPSheIJ7o8Q6jKz4WX
         A1WQiE5SigEMfFCImoYerpJq3aJaLTVBDKu+btRbLQAt6+T7SXBCUpxxa13F/V3FNOgp
         CvccOATz2nUzmYNW+L7KhgaTkfkqgypeLVVw1GbDcJvVMaSGuL8YWhYn4Er/QeuFqmKG
         q7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753873; x=1794358673;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sk8Hr0fhc3C8eQFrISEupQ4YS+zYJDt+3X6d4EBkWvk=;
        b=ByIpDivokO+KDbVj8Ylxq4xXu0e2tVi9PckgouXe25FUAz9LhpvD3BQCkxRtZmg3bm
         tAmmDg2tINGDZsNHcDCpdBnWGpmYRg/TfuCeKonbd0Eg326WaRr3X3y6uWcmPEKiUOfW
         t0UeDUgR4hZqkuSMCVI4c1zpOrPWsGFee8QoawKsa7UWu/UI6MePWp0E7DiUR5rUxJFd
         tCWHAoJAVFcTF+dvmrzElaVDVWC0k3/BHpu1kC8nnt9Bo+F+UpGyMFJ949Dwy/QjilUJ
         escP0tKBu/lmApZh5nFGJcn/x7n5BEC2W/n2viNXbZn9FND88T6zvrSSFp2JFoQYdZs+
         30vA==
X-Forwarded-Encrypted: i=1; AKwUvBwY0QzFUs38Yxtgoz5DFi95vOBB7Gpeghko8Ek24VI8JpvlbkRrgU7Xr0TVdN2Ku7hRhbJYwjHVbodRiIE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nVJ7CQKUl4AkxaRCY2YTEjjehpHdwzjExnRyiEMgSFI8fD+oh
	PGiDNkNd6FfKbRm0TVD1nBb6b8ymArWT4ZGFtYc87PHwBAkyxEvi0hP8
X-Gm-Gg: AYBFou3jgBLznNnfyL30liC8druISUEIViHfw5HHb/KdLI2v5PsGWI+fBadRc9gZmV1
	PLaRLXk7hz83Y7I8UKUV7Xhm44n2wmFYW5doMMLSg46kx9kXglqwKtsA7hzTTOucEKte7JF08xH
	I2geF0KIb7mVuctifoJnSRGS//VYHOxgU6LA2quK6S+hFoi+GCx0OGnYkYLYok2dTfO7z1iMj80
	x/lf6B/aEQVE1d3IUwcMkgzc9CMwKYCycNsoFPyzmurKjhG12CcNpTHjQjmYq9HLDbbEHMcUdEq
	BeI3I8+JHBr80pFlFLswrQmCM/ghnNiSFCcTmJgU7f6uMUo+/sNKaDWdEU2+WobSQgNmPMiIsK5
	/AoLSAjeWhV5L2jzSZAtARiIVF9specrsP6rAuEDL5Spccz7NckLJMJNvkLamG9U1ix4g9wnVs7
	8ztdEpJyQaAneFDt1JgPSkOnyWupZ2OYeqlSM+rnuiE7GvhkF71Y6tfLCtWuatmvv54iWsL41at
	5S4VfsbW4QvVvuCwegHLyM/3OQSlaB9WBGJyHjFbhDOHpXD4oQCyZfYJTW7hqCAonLxZA4xNOTr
	3KNE+QBTfI9gzbWdsbQ6
X-Received: by 2002:a05:7022:1117:b0:195:49ee:94c7 with SMTP id a92af1059eb24-1ac5a0b579emr19552410c88.8.1793753872638;
        Tue, 03 Nov 2026 16:57:52 -0800 (PST)
Received: from debian ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2c2ddsm2546423c88.10.2026.11.03.16.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:57:52 -0800 (PST)
Date: Tue, 3 Nov 2026 19:57:42 -0500
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
Message-ID: <auqC9jOIQTyieQUJ@debian>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-12-b736ee920078@gmail.com>
 <20261029-spyglass-evasion-772697094cb9@spud>
 <20261029-amuser-savior-6a6ab062f471@spud>
 <auSDJH9V31wmbrYv@debian>
 <20261030-slider-finished-360b10521e0b@spud>
 <auXQaY25XfYzxEb1@debian>
 <20261102-throng-botanical-b244058ecc37@spud>
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
In-Reply-To: <20261102-throng-botanical-b244058ecc37@spud>

> I'd rather not really. I shouldn't be the maintainer for platforms I do
> not care about, but I will do it if you're unwilling to - in part
> because I expect that the volume for the platform will be pretty low.
> 
> Please read through Documentation/process/maintainer-soc.rst to see what
> the expectations for a platform maintainer are.
> 
> Cheers,
> Conor.

I'd like to take on BL808 platform maintenance. I'm new to the
maintainer workflow, so I may need some guidance initially, but I'd like
to give it a try.

I'll update on v2.

Best regards,
kwang.
