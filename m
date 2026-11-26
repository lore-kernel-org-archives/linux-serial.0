Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795676253;
	b=vPUeEhOMMzcpqfk3g6ATzbv/iVIPoBNeX6+by9gERcR6tStWeV+Ks5dvdImgXF3CqdWx
	 4FzNdYQQcn+eNctyzTS6MI4MWQAhLMWwHUEBcnawW5bpvnZZPlIngZz9gPdjQr6+aCDeW
	 Qk8cefoFHlLx1ay24QpuDmcLIc33GflGUCQRLCqSDb1Pu+zc/wPjr9BBeBvhS/ECHRYJH
	 Ds/l0Jb1DNAzopbRZGX5RUSdNrux6y5og4tpkSbigxgkPSJ0GSy2WXnuV2HrrDwv9TVXe
	 5LukWuWuEEb/bYp+K0ZzmQsrIkW1PxKBmAS610IqCezhOoDyuEzNsFKcopSIxZrxlZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795676253;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=DCIU9e+MkuOEc5CGS01ldGfbplHOk3sa5t8VNxiqpLA=;
	b=2vvk0My9dqLxvTvBuaEaI9cCjZaPnUmtDou2Ix3tAnbJpdYWl7Smr4QVp+U9Ay3+HfQX
	 qcMmUTe/ozoDb2kOds9hbBSdrkK7tjWt4W+hoUKSPHAalpYW0MQMq2G2ydeZJijaW3/Gb
	 8R9sM5GzESDleFL3pGHrEwG6u0SfBMnHSAt/TOmnAzruOy5YB23iO6RKo+gWe9Cziqfon
	 IzCYzYyon1ggQ14dMBFASq/yBymWkPKPIPnCvpoL8OoIHqTbiH0X94/8dEy1RlEMZWDpQ
	 ttrBgQHqeNwZTM4okUEW71B/Yq1n6AMh3hqLQdHtvwMoJkKw0L6Zmu4i93Of+icmRcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hezw6UTj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3645606A31C;
	Thu, 26 Nov 2026 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hezw6UTj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021B81F000C0;
	Thu, 26 Nov 2026 06:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795676253;
	bh=DCIU9e+MkuOEc5CGS01ldGfbplHOk3sa5t8VNxiqpLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hezw6UTj2COl02vqc+jI4BM7dqpzM6w5EtT4WUokQYzYcIk5SHnKgM2z0hUpoDAyZ
	 k0QQUnlGgpybaRZBcAIggvZ8Gc2f4Hm4Zt3KnucyJ5AcLo353P772lnJr6IzUe2UMI
	 45Yhv5xhHmbvl11llAXg+V1/oriIL0K2J3TuvhHP/Sjtl2Sday3KhnbQaM5OGGMehV
	 Tx9aE3spkKflkt65OyzciYhdI1/S4S+UQKtLa3RKa5Fw8Ubp2J/sTmuW4JGK7d/cRv
	 ndyHXXdff18mReX46s4KV8QQsD3mzyCT3VDXvog7bVSM0IVFgcGvjvrhHDMNvyU+5b
	 Gh7Gxb2xq/N4A==
Message-ID: <32321472-2593-4a5c-a347-952188c05333@kernel.org>
Date: Thu, 26 Nov 2026 07:57:30 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vt: Escape the CUR_ prefix in the cursor kernel-doc
To: TAKANO Mitsuhiro <takano32@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
References: <20261125182903.2396749-1-takano32@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20261125182903.2396749-1-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25. 11. 26, 19:29, TAKANO Mitsuhiro wrote:
> A trailing underscore is how reST writes a link to a target, so `CUR_`
> in the prose is read as a reference to a target named "cur" and the
> build fails for the three cursor helpers:
> 
>    drivers/tty/vt/vt.c:276: ERROR: Unknown target name: "cur"

I believe fixed by Randy at:
https://lore.kernel.org/all/20261104182258.3226665-1-rdunlap@infradead.org/

Not applied yet, though.

> The same line appears in vc_cursor_start() and vc_cursor_end().  Wrap
> the prefix in double backticks, which is how the rest of the kernel
> marks a literal, and all three render without an error.
> 
> Verification: before the change, each of
> 
>    $ ./scripts/kernel-doc -rst -function vc_cursor_valid_size \
>          drivers/tty/vt/vt.c > x.rst
>    $ rst2pseudoxml x.rst
> 
> reports "Unknown target name: \"cur\"" once, and vc_cursor_start and
> vc_cursor_end do the same; after it, none of the three reports anything.
> kernel-doc -none on the file is silent both ways.
thanks,
-- 
js
suse labs
