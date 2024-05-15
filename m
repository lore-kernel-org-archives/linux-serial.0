Received: from dianne.skoll.ca (dianne.skoll.ca [144.217.161.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286013EFE4;
	Wed, 15 May 2024 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.161.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780993; cv=none; b=W5eQVfEOH7GZCV2h+WEdHnYdY4ntApRUqKRWjoSz6ZkESMyNKGxBT24QnNyTNK0YQ+4un2Huy5K9ttAT/jn5bYlhFni6dtNYsxm58XEc78YdwxGmaY2wb30zjIHmYAyReF/xx+RrHkBy/vXnbCrnfCzM6tcf363rZfnXJTHGY7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780993; c=relaxed/simple;
	bh=ph199rVCo0b/EbNzAie21c0eAUet5W0TtmezyXByfqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2YqgzFg2/ZKNJp1QiGIs63eL4Ooy0JeGnexQguvlMRO83wfBIVCJ3CmxYT2nkiqrvliDVmpZquD+CTaIzMhrjahY33E0HV8IrE/vWv6NR87DghHzRkmUSQOaL5OhptnQCFifUHzHs6uTdzzmAq6OmV1UtgYQ3KpAFWcMb3fVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca; spf=pass smtp.mailfrom=skoll.ca; dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b=BXG0mP7q; arc=none smtp.client-ip=144.217.161.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skoll.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b="BXG0mP7q"
Received: from pi4.skoll.ca ([192.168.84.18])
	by dianne.skoll.ca (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 44FDgrdt1088392
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 09:42:54 -0400
Received: from gato.skoll.ca (gato.skoll.ca [192.168.83.21])
	by pi4.skoll.ca (Postfix) with ESMTPS id 4VfZDF3bvFzgd52Y;
	Wed, 15 May 2024 09:42:53 -0400 (EDT)
Date: Wed, 15 May 2024 09:42:52 -0400
From: Dianne Skoll <dianne@skoll.ca>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: N_HDLC line discipline: Race condition
Message-ID: <20240515094252.5f63fce9@gato.skoll.ca>
In-Reply-To: <c937cd80-ecd5-4d41-ad72-668661898039@kernel.org>
References: <20240424173114.035ddd7b@gato.skoll.ca>
	<20240425140127.6504ade1@gato.skoll.ca>
	<c937cd80-ecd5-4d41-ad72-668661898039@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skoll.ca; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=canit2;
	 bh=ZLc/hObTwxSDwUWL0r4G3UTmP3/rKzazoUIqIj/jfAc=; b=BXG0mP7qeWlb
	8b3t+6UXjLFwfsfzJSjxJBDyggW1Ty2kdz7j8PmAgg9+w66uUqA7/aWt5iiMXYGP
	VsA/ndoDLP4FBXNySVzbdOH0pnEOerZs/tlWzId8mMBKoMa4mIx9cSoOyiMuD3i+
	9RlflKwC6nVZ7+z5ZjewKKqZyNv0hI0zVGuzvokxBfYVjncRNFoXplEu6fibSYHp
	QDdISJLR11vZiQBqdcUzc2hl10OBNEsehwddEKbmNv0hBjUklVuiv1v9dZJEGyis
	9WK4apA4PU3zKwtU8S7UB0EGuU4fYVWxz84OpHKLfvumNoWtFykH8p5mNj+hPSDd
	bOrrSdBShA==
X-Scanned-By: CanIt (www . roaringpenguin . com)
X-Scanned-By: mailmunge 3.16 on 192.168.83.18
X-Spam-Score: undef - relay 192.168.84.18 marked with skip_spam_scan
X-CanIt-Geo: No geolocation information available for 192.168.84.18
X-CanItPRO-Stream: outbound (inherits from default)
X-Canit-Stats-ID: Bayes signature not available
X-CanIt-Archive-Cluster: tWKWaF/NcZkqjWIj0BEJTBHJhwY
X-CanIt-Archived-As: base/20240515 / 01cnpGS3r

On Wed, 15 May 2024 12:33:24 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> I can repro even with 4.19:

Huh!  I managed to make it happen on Debian's 4.19.67
kernel.  I had to redirect stdout/stderr to a file because printing to the
terminal slowed down the writes enough to prevent it from happening for me.

I guess it's hardware-dependent because I can't reproduce it on kernel
6.6 on a Raspberry Pi.

> > So I guess it was introduced sometime between 4.19.67 and 5.10.209.
> >  I'll take a look to see if I can do a git bisect.

> Were you able to do so?

Unfortunately not; the older kernels failed to compile on my machine and
since I'm not a kernel developer and don't actually use any software that
relies on N_HDLC, I gave up... sorry.

Regards,

Dianne.
