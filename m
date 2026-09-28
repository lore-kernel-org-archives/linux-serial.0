Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65D4ABBC7
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595725; cv=none; b=rci0rRPiDOFgRToPu+nN6DWxzD9+3ir/m5B9aYuk920/l1fe9Q2uTSfZAv1+JoV3U1wtkriz6gr3hA1RPz51QxJngQVi4uVNiUzhPwZIrwSVqkUCffurWpclIzHm6C+3d+nM7BJSv9W5SpyAdmpcSNoiuNFjeiYnuP7Zfbh3XFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595725; c=relaxed/simple;
	bh=9LeyPLssXkRWhhdwjySaOA9pUglFEBh73xqlkIVWvdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEVfqPYm+YHdFg/p7/wCjJpd7EMWkkITqLhccK9QzgE5lncthHQhBq+wjuqysWLaav0iTL413qVhPOLAViI6WIpWyZh/6tS37ex3BR7pXWL0+eW3WlJLF+dTNqayp/FpPjtcXEa+gczYTzJT4jFhJIMAmIuyaRvrmDb0t+afFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=F09KQl+F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k9RmS/2h; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="F09KQl+F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k9RmS/2h"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F4501400100;
	Mon, 28 Sep 2026 07:42:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 28 Sep 2026 07:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790595722;
	 x=1790682122; bh=zvdLEzyyzPI/Ym8HVc9Vyt+3yu0mU9ZSLYCINtq0xXM=; b=
	F09KQl+FWeNrsu7NoFVW5s++mnBFCjlI1RBBZB2VnqpBa/3EErXNIoHaOaRCajLE
	coNWyk5KSyNu79I0e5azjJ1AUWnrFjTp4Oj85rTyrfRAMTLG4cbHlcqXB9vPFf5L
	OKHk/+a7JKoXqkiUOV/TUgH1JHwuUEfinI0+CvXu/BV+T+TmpDLE5Uxm4cO/JgWI
	V4yT6aC6jecz6+pKfVK+FWc9Uxaiigej+OXVraoR5+2gT2o08o1DNPJeK6FbbjS2
	bb6XQUXbajxfVPSLq7IVyZEhwXv5JZDNRUISULEcNVS6cZwA3hkbbCBJhabz3WcQ
	uH9G0i0O6wS+4UPFoGDKBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790595722; x=
	1790682122; bh=zvdLEzyyzPI/Ym8HVc9Vyt+3yu0mU9ZSLYCINtq0xXM=; b=k
	9RmS/2hCxMcBuqjgWkqdPfv4dNgHLO+HPnpdIBP8PwV6mJSVsNy50AEIFizK7N2K
	XfqfOe0MZgKcQw5jyu8C3IfrujbdyVQyyba63s8fb8e0tHFmKUdf3BwcjxNBDevo
	9J7sAwfNHLOGMRQt2Qr85QrIFZaRWvZC1AQcXqHxUCq0QUo4K+DNlaL7tQR8OSmz
	05xA4OHv+eR87Cd3bHaFNlwhXN3bXvAzQTGX6Gu1KZZxvKKeVZQJaDhg0/Fv2sOs
	3M2UWb08aIQAX17tfxJGi8EtCt5dmMilfYV0HDgJXASg2Ve2zGdb4WpeGJa1GUu+
	0/TA2hDOEllepxwgqVAvQ==
X-ME-Sender: <xms:ilK6alJahDIkoBGTadq8paHPM4Uvq9p0NycJ715j13KSMpGZ_9xLHg>
    <xme:ilK6ahnXudwdnARr0c6OQdBBNIrdpX7I8SaRKepE-XBkFwNhluHwLjpUJhTZYULde
    KaUmPkBX3YVQVT5G35TfE2hdTnK112Q6_75BBROz2rjp8VN1Q>
X-ME-Received: <xmr:ilK6auYHdLS4XZBDTADnz3lUCMuTCqwHy8lXK4Xv08sfGpiBEbAUprI3PMX363yRB2LC_Y6W8lItKSUd7liluUhQ41fd5oNEJoexTz0zEBI>
X-ME-Proxy-Cause: dmFkZTGZCAMwRFKDTjABgiaB0R9EJcd6owdRlhtwKPZsqNkc79pZ6f6w4laYhrGGw2tG/s
    FBHGSvYN32AAdrdejGlBHxfBWSB/EVRiIwlv5uhHwSft1AI7xsJt2CjztZSemkHY5YR9Eh
    QzTWBFg9sR/Sb7SAjS4L5gjOfeDR/Y/fI8PjHs++nUD0nT8lt4jrusM+9+bLFZR6/qjbp0
    rYwrcPpLtctTy0mwQoxsEMCVXYou+pWhcxQas+bfrDY3ywCjjbRXYOuwc/VF93WTK8g1Tr
    ZFw5fqIBlL7NrU8F1iX7RMIg+5g1V8+08c88GT8fdLklnMdl00TRKCratu4yl/N9QGRlb3
    AK3BQVYc3OXWZErXi1ZAOwOGlKJRxUEsxAIAgq5G/PMnngc52PWJ599IcKTb3RBF3znrVn
    TSGgaaO3KziWw6QliHAFWZ6e3PJCUmhHg7HKjrxW98jOnHW8CSMg4DFOGFd8aONAwwfPQO
    fTD/8SLldN58ntzRAOBrsetvdKOGlrZjLCrO722S+Waw1Xo1xe2UlmnsCHyjeDpCFoAtWS
    OMHo1XvawYWKK4FyRGbXnze/Xnzn/B/FzePJhUdb6eJ/lgAMa9Su9mlubrZrLaXQ127MWJ
    G4yo5Ehl0At3ZI/AlYCw2Rs7sVnb/dIDErNjs/4Lib3qLheAYMtzdx2TKSLA
X-ME-Proxy: <xmx:ilK6at_nU0hbUG5mShSwNnrDw6C-QRpKOjpLaMBlcPhQOfrIkXYpWg>
    <xmx:ilK6atZMRsUqHAwuY7y0LQLLPTKKKPzw7fBFs1p7UsXXv6aMBcVjqg>
    <xmx:ilK6anf8s8Gr7rd28W3RT39RYs8OSbBPVBiNV08Os14jUzG9alCV6w>
    <xmx:ilK6aqlAR3qrowEVu-kyX2lwWj30X7-HDHyTIvuQl2dQsBfOYlcl0A>
    <xmx:ilK6arnN7rNNM5GXebl2PA49dWFF8wj7CP_397kNe4HnXkh8cvXRywg4>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 07:42:01 -0400 (EDT)
Date: Mon, 28 Sep 2026 13:41:56 +0200
From: Greg KH <greg@kroah.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: sashiko-reviews@lists.linux.dev, linux-serial@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/5] vt: Add cursor-size helpers
Message-ID: <2026092838-deafening-diploma-6481@gregkh>
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-2-tzimmermann@suse.de>
 <20260928090923.E6F9C1F000FF@smtp.kernel.org>
 <9a95df99-3978-46b1-a3a3-17392006f5f1@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a95df99-3978-46b1-a3a3-17392006f5f1@suse.de>

On Mon, Sep 28, 2026 at 01:14:20PM +0200, Thomas Zimmermann wrote:
> 
> 
> Am 28.09.26 um 11:09 schrieb sashiko-bot@kernel.org:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Low] vt: unprivileged log injection via pr_warn_once in cursor sizing
> 
> FYI this is by intention. In DRM land, we usually allow for warn_once to be
> triggered by user-space code.  If that's not an option for vt, let's use
> pr_debug() instead.

_once() should be fine, no worries.

thanks,

greg k-h
