Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33824BBF0;
	Wed, 19 Aug 2026 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119082; cv=none; b=XtuEJraniofVIyNNJqCG3FzftVp6uaDRPF6GZU6MRDGSwOur9u9P6W1oTbLOWnnJCuM9wqiHvpR+91mP4Icwv+xKXN612QZohxClmTXqsJhwBvjjEX1HQLEPLu6vN3nu1ZnNNIyRD2nORJ403QT4kX6/b2q57FGP9oXV5JTWD5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119082; c=relaxed/simple;
	bh=uleT3oonKuUHp8KyB+FWYMbjZkqtqmZ7O2UgttsLjpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvNtd9NbQdNLC8ZBRaTFDHdgRchina6BVtSGYDLAlmujSHjaiQ3bX7rDKGfDqz+9O5nInuEfzs0RC4wZRtcrKTh9ARtSGClhMVsyThUFfKcrCiocTnafSC7BI0VCLqK+ZI65eLyFQYlA0R5ECSv8knMQWTBRxMazsemkJp+4FWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=weqaX/St; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="weqaX/St"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8140B1F000E9;
	Wed, 19 Aug 2026 05:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787119080;
	bh=M78ux5Luv12vwazeY14UpmURjJXkAKhmW41TkZV357k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=weqaX/StkOb4nqMvH9291nqGBfaekt1OXYqsLpV3HLCTK1uMWBf+bvkv6jtjulAr9
	 ZMdqcJpGSL4eaXXornAXnGbEb43LVbpyV4XJZiaNNfL9mR+i9Fbjek1ekwG4n9T3sC
	 YkIUK9VKXAUNu07eO3RKrwKlMSqffkRane2Ppt3g=
Date: Wed, 19 Aug 2026 07:57:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lucas Tanure <tanure@linux.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: don't register ports that have no hardware
Message-ID: <2026081923-magical-enlisted-64ff@gregkh>
References: <20260818185200.10243-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818185200.10243-1-tanure@linux.com>

On Tue, Aug 18, 2026 at 07:52:00PM +0100, Lucas Tanure wrote:
> The 8250 driver creates a fixed set of port slots at boot and
> registers a ttyS device for each one, even when the slot describes no
> hardware. On device tree platforms those slots are empty, but they
> still take the ttyS0..ttyS3 names.
> 
> New Amlogic SoCs (S4, T7) name their real UARTs ttyS as well. With
> both drivers built in, as in arm64 defconfig, the real port fails to bind:

Then fix that bug, don't break everyone else's systems because of it.

greg k-h
