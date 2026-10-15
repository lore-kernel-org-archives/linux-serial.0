Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D051617F;
	Thu, 15 Oct 2026 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058346; cv=none; b=tUX5oF3Fs3pPlPi/Mm4pULcbLYuoPYVHc14wc4b61/qPQJuWEK/iTo7ZKJxrHJrV0NzvTRayytbL6Wo3nnIYyMyPTv+SSEg5CucUBrUKtOjl0Ay8nDA5ah4NOtZe1lRGDz0jt6waFpHhxwNTw0K2Fz4g4BImN6Fj2YMlWGCGf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058346; c=relaxed/simple;
	bh=Y4pBy2x0j6Suc5T0MdHA3GtQWW2AivDvn7u3767tiXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwdjiFZKOhqA2J6/TsRJ6i8MMxfLxivppLmAPZDn8RVWDhaNdO8JaKQ2I/+MPBDZsP8360e3qrfk5NMpNhQ0jd/2TlJ1c4Ksopb/O+6KQ9wtty4+KJ5/FTSw3MoXbBz2OKc8JJG2lIHLkO8oimx1KnMLBUP/W9/jTDp+i4f/cWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAABnL+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAABnL+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E490B1F000C4;
	Thu, 15 Oct 2026 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058345;
	bh=2w8nKiVNXKMTex69kXfqDRomq+Zwxb/enPBvj8nlfgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MAABnL+YNUJ/43f1DfMwxhSMnzYFkcsn8s4nRUndb+5Yk8wa7q5CdTgrL80IMoG43
	 wxa8IFmRn55OVqzhKceP7k9S3jKEGxJtpe0lct/zJQ210l4onti89YBNDmiU7+xoVm
	 mTogZglMzEk6EmnG6/RDMTKgOBRbQUbf3zKAfMpdxqMsX6grS14oxtNM8dkrdM2236
	 ACJ9VjWVTQNLyOj5FzHohAJcGEDL4JFMup2Vyvd2uRUoXuMFdphov5sguRVta5+gF2
	 G8exkrvxQp09n8vSVgMVwnGZA307T/ko868/xfG+T9Z8pBAQBBkQTmZhelUbmyFkre
	 S8UscuthDTANQ==
Date: Thu, 15 Oct 2026 11:58:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: serial: create binding for mcf-uart
Message-ID: <20261015-valiant-puffin-of-zoology-6ee470@quoll>
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
 <20261013120831.1046590-5-gerg@linux-m68k.org>
 <20261014-expensive-shrewd-nautilus-abcab6@quoll>
 <d256f39c-6ed5-409a-a7ed-224165d00521@linux-m68k.org>
 <CAMuHMdUcGt7RBc0d1A-8O1Dt71RL=epPgmnetj_4NGCPvCj9LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUcGt7RBc0d1A-8O1Dt71RL=epPgmnetj_4NGCPvCj9LA@mail.gmail.com>

On Thu, Oct 15, 2026 at 11:19:31AM +0200, Geert Uytterhoeven wrote:
> I guess you want:
> 
>     items:
>       - enum:
>           - fsl,mcf5206
>           - fsl,mcf5208
>           - fsl,mcf5307
>             [...]
>       - const: fsl,mcf-uart
> 
> As no new (possibly incompatible) Coldfire parts will appear, a generic
> fallback looks reasonable to me.

Yes, although still preference is to use one device as a fallback.

> 
> An "mcf" vs. "motorola" vendor prefix might still be a discussion point ;-)

Best regards,
Krzysztof

