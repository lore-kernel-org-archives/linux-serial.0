Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D94DA9B1;
	Thu, 15 Oct 2026 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103961; cv=none; b=eV0UODhPrLf3Tnjmxdr5N+5LPgKyEHZ29LKL2lrEYaWOuOTCpj4c7LU1enm3l64z5zPmH6zxeOrAIWofrjlaffjj7N2RQRneG/G4AnfxMwDXSIi5DIjS36ZsP0m4bkOdpz0oRa4VWi5KWdkNKtBxqw9OB90rVzL+/i6NghDuILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103961; c=relaxed/simple;
	bh=1zNb440uYDnmlPCW9U13QGfWctFPuHMsxgLI6Gvd55s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PqxOHNA4vzJBrfk77kHIKJH6JIOeS6qFjEICfbG5ThL4Pvnop480a2WdvEhIfAoUDY12cM9nSgovqQ1SGhiUOHSwTzxYwEdC0ygwoNgbGSUM97u8l6aNotA9Y2gOMDPbMSHIX8ZY9QRQvr7ocrgGegtp6k91gwPa6O0LIWYPg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jczU2LGf; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jczU2LGf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 219D21D00163;
	Thu, 15 Oct 2026 18:39:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 15 Oct 2026 18:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792103956; x=1792190356; bh=MsfOp++XQVnQkLbK18NW8Z38dECPaCnvO7c
	7zOmRFhY=; b=jczU2LGfvD+IdqR+PHiOZvcox0pEaB9mNCATpyjHYNqxU6Vb0j/
	4+dWVLC2XFkFSfhZ/msB8kwFfxd9CXhPufJGtRJCJ9aar0Cd0yM2W20SkltldWAf
	UHaxm9QUTg1QK4CW1GzIqZumfeH8FY9JhQ5GqutXKq+We/XuAEe5vANAe15htpiS
	3M1bui+gzl8rBOrNsg/3Co3kimRCf0FDk0z7J0NxHhi2SeeqQuy7aKwuUSNzcC2+
	mBKAw6xHubM1+8iLgpHeozmrgMHGDNP2XCwQC9p/RQ/0bqDRZR5xrCUqJI+BbsJa
	w3oa13ErDKlzCFjPIHMHBpOe3XeDCeZQdFg==
X-ME-Sender: <xms:FFbRas1DI_UdlcJbKHepmVN0XVgeFViwA7fKZ5FM4Y4gxgSykeqhKw>
    <xme:FFbRaiArGuX4x9WdsB10Ii2PrHcogov-uhUJZMQociPn5_QFxoxrR85TD6rAVQ9EX
    L3Nv-6LyPEtLNu2j8Fap6PKHU_tjNZIiciTDppqctvnsaU3sV6akCE>
X-ME-Received: <xmr:FFbRaj6Ta55mHKNVo_9D_W0qhTuGByVI4yPQXhd6sNSTnMUJAUk8qUS7q3l4mpqp-fgQK87GbLgK5AtY-A3D7A6vOdGatJdbRjw>
X-ME-Proxy-Cause: dmFkZTFlmHkCW3pF+j72AbU606l03hO4kL46oa1JkZipyDZBixMVJFW9+wwe4Agpip7l1A
    btZ8CPYWQYbbpAgoHOU8pylFd5tbDCm+TNjZC67YQEjXP5H6KHAYLpTLhbUkEu6AQQOu3x
    HdxdixDlnluhf3dCJ7V+jxgbsNpuW8/rLjKMUyIKy1KTTKvNem7xsn1ESmoaygULyYbpVo
    NbOFamtCsItJLDPpGYqE89MjEex7OqVWRYJQmcywG1lwmiprUjCfcBbwmdzm02EO1i9Lnl
    jznCDw4BlbvobR/2+oY9tFdKds1iqO8BEnRukKdIrGH8nIJ69Vr1SBGMcIt7HjXWk2T7Hg
    28Jnk1zf64PKIhIuGsyxIwfpRkbfFonSvAwtO/atsRMiN5RXYMt1+IyXEHndKbZorddOCu
    dKvME7bUY32mz5dRpAwjW7FZxgK9n1L+p+Y2kz4DOHux6rHA1Cb7ICC+tUpe84NgBDJBTI
    xnIaR4vWv5EX3avFCkTP6XsGxakkL3Dl8e7J3/saRm6/PF279lZtu9FTfbUtAeRITCNCdU
    YeWvxUZLlhQEr2rqr3JodFHOaxu4P1W2xroYOY+4d416RghmpdDIpyEtf6XvjfocB6PQJ0
    Zxii1ZDWHoyhRJcfzFNa+e0IPNpwh7p2swbc9un6AN+14Avdx3QnAFq825Bg
X-ME-Proxy: <xmx:FFbRarJpDZr-VStogePh6qF859VcLVIUqWx4Et7rP9EKUY4yKpNvcg>
    <xmx:FFbRasvIB1yfIeY_EX46x0W_ZrJxx_hdWPs7hZYYcnJIoQ0PQ6ZdDg>
    <xmx:FFbRaqJOiuGu94ilEhVwphZ-Pq-ED_P2XKpyaeQFI73s6DAC3n-aAA>
    <xmx:FFbRal_blYuMelA5oTw0gOMMQkNAyvQoe2v9whnCLDTMm0aLyzfKmQ>
    <xmx:FFbRagXF3v9cHW-35rTaH8lPPcOkYu8zSRqdHjdhJDBMl13ngI5WAey6>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 18:39:13 -0400 (EDT)
Date: Fri, 16 Oct 2026 09:39:15 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Greg Ungerer <gerg@linux-m68k.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
    linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, 
    devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: serial: create binding for mcf-uart
In-Reply-To: <CAMuHMdUcGt7RBc0d1A-8O1Dt71RL=epPgmnetj_4NGCPvCj9LA@mail.gmail.com>
Message-ID: <c0fd5f48-4490-2901-593c-8d9d029dfe1a@linux-m68k.org>
References: <20261013120831.1046590-1-gerg@linux-m68k.org> <20261013120831.1046590-5-gerg@linux-m68k.org> <20261014-expensive-shrewd-nautilus-abcab6@quoll> <d256f39c-6ed5-409a-a7ed-224165d00521@linux-m68k.org>
 <CAMuHMdUcGt7RBc0d1A-8O1Dt71RL=epPgmnetj_4NGCPvCj9LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Thu, 15 Oct 2026, Geert Uytterhoeven wrote:

> 
> An "mcf" vs. "motorola" vendor prefix might still be a discussion point ;-)
> 

Motorola Solutions is still trading under that name. Sure, that entity is 
unrelated to the Coldfire silicon presently marketed NXP, but I would not 
presume that Motorola Solutions has no interest in this namespace.
