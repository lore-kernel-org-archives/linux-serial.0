Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE0492E58
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159788; cv=none; b=t1lHG/W7MpsS3n1tmnwWXxGysIuJygg0lX13X+uof9JvRT9C0dZS/cwDs/c26BCvevgGzpiGvWpUuF8ehCJ+VDZC5kK4iciDAeXCRoDaXTNeuJDcd8bixj8x05E0Dq9CXolLOYF6670kQdz70C65kJxgnDy6QJka6JrL4nvk0xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159788; c=relaxed/simple;
	bh=lTfxHKUBCjXxH/e7AxNWqcn60QnC7Qx4AApVrloWaA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG0CvR7JKh3iWTJXArfpCfVZruoklu6F+HB3NQZ41hfsIwt8+D0UsqrRbZgaxe3oPCEVcP/ZskPeyeaMy5fZxmmPurleQaBQaKLWCZofXf+wTGOcIj9AUSCvdkV5z1MMh6M8D+qo5f66VOyH6xhcmrOneecwI6IgW2DOlCSAcqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=KCTPPRbJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uPeMqwDM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KCTPPRbJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uPeMqwDM"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0BA357A00D8;
	Wed, 23 Sep 2026 06:36:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 23 Sep 2026 06:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790159773; x=1790246173; bh=lTfxHKUBCj
	XxH/e7AxNWqcn60QnC7Qx4AApVrloWaA4=; b=KCTPPRbJleowEpmYctXXbLvRFv
	5dGo3RCFtxXm/m2xVxJFSLetQLXMvv1ZQaqOhMZrkg9HON4e2usgJp5mNRfFe6a3
	L5X9vkQyvFVpwoIpXwTW7v+LP6bLh0NzKQO9uDphQ9Kj0PGcMBkdcjHmcr9PTNJr
	xAC9vbQVrzT8zfJOXnQfojm0ScWlsGUt+nCVQAxZTNW0178vCZOvXm7SEWem1tzu
	5yAG/m9kDzFx7sbBwDfl+DX0EzmX2iRPRa8CBQ+vEgfGtaHVS4HyKAHb4KJ6Cn1t
	FkAdD4+kC3/h2kwwn2OlnJySFPGVuZHmEkfS5O7I7IvaNgoB2oO1I85+mjJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790159773; x=1790246173; bh=lTfxHKUBCjXxH/e7AxNWqcn60QnC7Qx4AAp
	VrloWaA4=; b=uPeMqwDM7NhQm08bQ8jALztziL4904uvSAUJDCl/u0b8yb7GtSX
	iCGPe8nVKALFxasAtwx5ly+rUSrLkggFKaPAHH8LiPAm8f8JDtd9VEo2cHASuSml
	dDpv7vyMogRFVecex39XrVFOZqAsr/flNVqu599ZeqZF1mv3d+3yUohwrztnxFmz
	qpkQpYQJpqoS5NRnnd7QR37xJB8A+5HIc2mA7ZhBnZ3kdDsSxby0LnspypPIK6Al
	fWIBnQ3nDAsh3TjDYwIBBCTDwLa0StLk2moY0a5nkReE7FSRczQmffFa7WChwHZg
	AbQQ/Ax4nt+CUg5SxDu3aJSBUoblpGw0pTg==
X-ME-Sender: <xms:nauzaqTos1Ed8H2DcBB-7crx1l-S4Jq79DjE-LgHxgLjfcOwUKzhag>
    <xme:nauzan92P97g1QRZFDIiSWzJSMh3CGTxVJ00fP-5QRedw3aWlKBCHO_ZBNiHF8Pc7
    bb68DUOslte69CrCSu22kxV1Hm7Evvm57M2yU5NU6FmogNLN31j>
X-ME-Received: <xmr:nauzajZQCo7P61GSkRZdI-v6hG4KSJ21DIIb1faJnpAo5X7PNeEW49Zttpj4>
X-ME-Proxy-Cause: dmFkZTEgGunAhsZDg2EBZxmaPi+PmRL6na2eN9ccVeA7Fe39XWis8rxLIglrZIj1quCS4e
    ddk9rfYcWi8NFmSvtSZr4BL2JyouLVtHwODWat2FczEOPlGjgWeKyoUZTl521fx+FA9eGi
    wlE9B+L9eGqQ/JAyq46D51W3sD5rSc1kdI0dBOvNrydOAo1RQICBBkwDjJ/Yxj03plxzaf
    Ern62WGQguU7jHhFHXFp8R4cbT7jgQx+Axp8lO4y4FwtnbHLtflVavszN+mtgwdu82ympP
    pvIbM6THOfZ5AyRDgZ3z7lFMgPduZgk2O+1TFWIBOZ3KrML02aN7KPeWBLpkfdNAi1O5U8
    k1s9xNtSyjbgUlFj8dU1Xe5gi+ihp+A8NvAkzdPbawBA9dAZPXEMEPdpLUGhIMM3p6Llt7
    n6fFIKSHjC03zO5VEvg4U0RTtYQXPMnV91OmCRV6VHnuxzxR9r22j7gWWIEQf0G4O+DooB
    59PLwlW10tUl2QJjMUWj6CeQjtJ/jThIFGZuXLmbDg5m9b0lUSJhVOHfKq43eZ/1quAmZy
    IJK7n4Vf2vqYc93H6AnbVDr0owagO7jgF2MrAa2Z/o5ybdEN13yJM4I4sXbdBU144wtX/n
    WK/4JElaB/4qqwuhDZMxXHZlYFTwnBgCY5RbGX6Qpbm1eMKweE5jpec//8OQ
X-ME-Proxy: <xmx:nauzagoxtea7Nr-iw0fd5lFTSnUFFDLQFXkjYrxBUsTbRIRudvpdhg>
    <xmx:nauzavQgu92VjLBdA7VOFXGLhSRKsviQaDugXtaoZYFz8sgCFijbNA>
    <xmx:nauzasoSHXgtJY07pFhKBTe6Aa4jlvV1dKkKQweio7koovj3zexnNg>
    <xmx:nauzah2XRZGkbaKSJpcCDspTNGbrzoooQc6UdigMlp5YNhWK6bkIrw>
    <xmx:nauzagueoGtiD0RcxdSahJieyR9nh_YMPMwSehohrWcx-z4TpD0Qztkc>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 06:36:13 -0400 (EDT)
Date: Wed, 23 Sep 2026 12:36:10 +0200
From: Greg KH <greg@kroah.com>
To: sashiko-reviews@lists.linux.dev
Cc: Markus Probst <markus.probst@posteo.de>, gary@garyguo.net,
	linux-serial@vger.kernel.org, ojeda@kernel.org
Subject: Re: [PATCH v2 1/3] tty: serdev: Export functions to pause
 receive_buf callback calls
Message-ID: <2026092347-blend-enrich-b4fa@gregkh>
References: <20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
 <20260920-rust_serdev_probe_refactor-v2-1-43b855162f5d@posteo.de>
 <20260920144023.B874E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920144023.B874E1F000FF@smtp.kernel.org>

On Sun, Sep 20, 2026 at 02:40:23PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] tty: missing hardware memory barrier after test_bit() on weakly ordered archs

Ah, look, I was right :)

This is all really really fragile, please reconsider it all.

thanks,

greg k-h
