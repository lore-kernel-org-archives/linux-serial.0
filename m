Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEBB4D8CE;
	Sun,  8 Sep 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725786092; cv=none; b=GXqgwJW3Y/EmBTlL2klPzuL7/WTbIO3pRpP4uM0Gh9mDzY3kh0ASb3RSl/9Bbl0tJKEvKFA0BHrnkSfGhe7dq1ZjP7FZVk27ZALVFtKckoY46jydRhs3oIAfCWt0vHa03RmbCcwZl4Uv63kL5LpG03q42IP80aogjwP0i4fuplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725786092; c=relaxed/simple;
	bh=xToZsQTiEUaatVECmcZa2xZMNMgV1GnA3jFUHS95k1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atLIYxNb1SlaIm7egdKXw2yuDqvpBDXcwcN8a8lTFXVP81/U7Zk3cbRwijIAwqKq45d3NBj8r3D8qPTUzMW7Rj/T+shTHOmkYE3U6yD4aYJlDvbczvdSw2AUdqdvfLb2sjH0Nsj0rOE/dS4W2JkhFU5rLfFyvEVYv+xwchRoUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=me50i/jK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="me50i/jK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BB9C4CEC3;
	Sun,  8 Sep 2024 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725786092;
	bh=xToZsQTiEUaatVECmcZa2xZMNMgV1GnA3jFUHS95k1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=me50i/jKYs2q5kBltc2pV4CuxsX/kV/etOvcVWKHIqK1pIw+ZLj+AhC3Kc5CNQN6V
	 9kQaE/qAxBtF+unG8ULStYZvqUTpFVspnR0wCqFdAlc/KNKsWkdj8XdQUCdPwNFCCB
	 1re15PnJrZT0nreHlExRZnTZj25k2wx18jgqjkLA=
Date: Sun, 8 Sep 2024 11:01:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 0/3] tty: serial: samsung: Serial fixes for Apple A7-A11
 SoCs
Message-ID: <2024090809-crusher-overact-8dcd@gregkh>
References: <20240908075904.12133-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908075904.12133-1-towinchenmi@gmail.com>

On Sun, Sep 08, 2024 at 03:50:47PM +0800, Nick Chan wrote:
> Hi,
> 
> This series fixes issues with serial on A7-A11 SoCs. The changes do not
> seem to affect existing M1 and up users so they can be applied
> unconditionally.
> 
> Firstly, these SoCs require 32-bit writes on the serial port. This only
> manifested in earlycon as reg-io-width in device tree is consulted for
> normal serial writes.
> 
> Secondly, A7-A9 SoCs seems to use different bits for RXTO and RXTO
> enable. Accessing these bits in addition to the original RXTO and RXTO
> enable bits will allow serial rx to work correctly on those SoCs.
> 
> Changes in v2:
>   - Mention A7-A11 in the comment about changing register accesses to
>     MMIO32.
> 
>   - Use BIT() macro for new entries, and change the existing APPLE_S5L_*
>     entries for consistency.

Your subject line does not say "v2" :(

Can you resend this as a v3?

thanks,

greg k-h
