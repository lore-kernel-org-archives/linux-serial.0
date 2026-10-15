Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8F4B95C7;
	Thu, 15 Oct 2026 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054572; cv=none; b=CrntaW+q2wLKyCOp6+EIYezXBgbvLIpjjyoG9+QBcWMI7AHwE/K11N4i8T85KyjfG3Xhhk2ljoiDBtd44l1+XbpM5r9f0IYgdHZ3Og/RGr2cTHyfQYesc8nCQX9dYj7IJFuN/A4IEVHBLw5kQcC7+9cgj39ODEsS2SGCTqMW3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054572; c=relaxed/simple;
	bh=H3LGV2dtU27ea2Hy0M2Dlc0NuJ0lZrREQnqW8yrFhZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8jwjDaCkpkuHo4Dc1dDwBrB4vp3CD363m/q83oN3ClRwAkAp2GP2mLDiysE/S3YBTBNKifTDNuSmzXgsv9oVFQPegXK3xhftrXXl1UC46NvjQsfA+n9eMNgsxSXDWttsM7yJ4KB8kf/DElgi3Wj+9eIPW8bs2DVbvKvw1ka/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmzhDxdT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmzhDxdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034461F000C5;
	Thu, 15 Oct 2026 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792054569;
	bh=YEGOytqQrOiJnusKbWMA0QBioBFdjczdGiAdGlsTPOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bmzhDxdTLepsOK5wGoXefuDU1D1MBd0xMQrTrnCdFEEdoyvsVhmnDoNUMGeM+bA2D
	 Kpz+5EcJ/Nj/F6vQulzqh3DOUm1pgSUfeXlKJ5QwDOPIAyBVhX3a/+J/jdPqVZjX1K
	 Hc8ejoZBTAbbG8hnMjM7JJJnFV/1LToNQ+pq2cUrt1/22xRfwTpzW9mJF8t1ML4Dsm
	 6TYKlBAa6JBALp57K+ckqdsdDn1PLohDLDHcE+tYomTK7HLhf0s/mvZj8QbRHrHlGV
	 lxgj7T+ETcSxTnlAkLuvEhXmn7pDBlTx1ht4x5inJB8iljJgY4h92BykTNhCMEfcW8
	 I/D3e/OJtSKSA==
Date: Thu, 15 Oct 2026 10:56:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: serial: create binding for mcf-uart
Message-ID: <20261015-adamant-realistic-bettong-a24c4f@quoll>
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
 <20261013120831.1046590-5-gerg@linux-m68k.org>
 <20261014-expensive-shrewd-nautilus-abcab6@quoll>
 <d256f39c-6ed5-409a-a7ed-224165d00521@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d256f39c-6ed5-409a-a7ed-224165d00521@linux-m68k.org>

On Wed, Oct 14, 2026 at 10:48:41PM +1000, Greg Ungerer wrote:
> 
> On 14/10/26 21:24, Krzysztof Kozlowski wrote:
> > On Tue, Oct 13, 2026 at 10:07:02PM +1000, Greg Ungerer wrote:
> >> Create documentation for a new binding to support the Freescale ColdFire
> >> UART hardware block. This is found on pretty much all variants of the
> >> M68K derived Freescale ColdFire family of System-on-Chip devices.
> >>
> >> It is not compatible with any other known UARTs.
> > 
> > You never tested this, so limited review.
> 
> It is tested. It is working and running on multiple ColdFire platforms.

You cannot run a binding. It's impossible, otherwise show me how do you
execute that code.

But as proven already on the lists, no it WAS NOT tested. You have clear
a warning.

Otherwise you claim that tests shown errors and then you decided to
still send it with errors, so then th enext question: why do you send
code which your tests tell it is wrong?

Also, this misses to cc actual maintainers, so I don't have it even in
my mailbox except Patchwork.

Best regards,
Krzysztof

