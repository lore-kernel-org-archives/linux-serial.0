Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B4614B978;
	Wed, 24 Jul 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818833; cv=none; b=ek/NJ8D/XYFsPv1h7jTYtHg/cr+4pOYcsEkMagDAKzIx0N21npMACHsqj7XUSej2kVl2B8WKjxHDBgBT80o2qcCpEl5ImGVQDGFOwaeJuu6qNxJVueokKngUABzd/PVv28Wi7y3LHLT/yOggB487JZykyXJJZXMzno1BXYeAbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818833; c=relaxed/simple;
	bh=x/5Uv0Wnf3YcdvNBp68Y+EvGEr5B529Q6mlrb/v2wug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unGFqLBILb6anj+5cOFgIU5GeALxwDgGR+HB0+qMJaKOQhhZQWaXPnMyGrByoSc3F3F6MpGMn8iMUHz5Kf9/h3ccOgnfgOyKmAD99iB2BCQvWOWSNsOJbM1M/OSi8i087JU8zmxlA4Dx3dXIA1XQZc8XSW+cRdnF11wd6qUMLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sWZc9-000eFY-2g;
	Wed, 24 Jul 2024 19:00:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 24 Jul 2024 18:53:00 +0800
Date: Wed, 24 Jul 2024 18:53:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: stsp <stsp2@yandex.ru>, linux-serial@vger.kernel.org,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [regression] ENOTTY returned for tty fds
Message-ID: <ZqDdDPF_N9tcbu_S@gondor.apana.org.au>
References: <b6f4aa5c-10ba-411b-994b-6dbed2bf63db@yandex.ru>
 <2024072452-pegboard-undying-4245@gregkh>
 <c74f1e3e-a376-42e3-86e0-a804f9a7da2c@yandex.ru>
 <2024072401-spearfish-gnarly-a09e@gregkh>
 <be1a3839-23a6-4726-9018-3d18a27163be@yandex.ru>
 <2024072401-obtain-heap-6d8d@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024072401-obtain-heap-6d8d@gregkh>

On Wed, Jul 24, 2024 at 12:15:39PM +0200, Greg KH wrote:
>
> -ENOTTY is the documented result of invalid ioctl arguments sent, I am
> pretty sure POSIX requires this somewhere.  So this was fixing a
> requirement here...

POSIX does not specify this at all:

https://pubs.opengroup.org/onlinepubs/9699919799/functions/ioctl.html

I think this should be reverted as it breaks user-space code
that dates back to 2003.

ENOTTY doesn't even make sense anyway as it literally means "is not a
terminal" and pseudo-ttys certainly are terminals.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
