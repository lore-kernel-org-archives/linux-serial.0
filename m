Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D514C591;
	Wed, 24 Jul 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812117; cv=none; b=Vi2ZIkq3egJAnlWFnN8Jjp6KKQufoPAp5LCcHfu8jHIPhIejRNrugZ0EPLDFa0IHj8JfLYv0WJokJRGPVNJsHd/W06MeBXaMPG9jrHaVTa5SGtyRgtq8TgygbwKWfH96ZBksowMIAxMB18GD9GN+Fx75/kQrPpaWpovu1ow3x6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812117; c=relaxed/simple;
	bh=tThCOv7HD0yQTlkshwFBlHGO7UMypXlIxhmNLRiS0Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7dqn80zfhgfA4k2DMo9O7iT9Pc+3XZGrfOvOYsi0ZR1MDGwMcqwUVlxTI/LJWpJ77/VfAqjYZ0I1zdYyujIqWBLuuS2jv1RjHOTn3zc8zzNXM/ntIIAI5ey1h0Zf6vXhYzpUYeFekAW4+BVyXVfr8m29GZUznvxjutYzOhH+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+71Z8LO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+71Z8LO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D254AC4AF0E;
	Wed, 24 Jul 2024 09:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721812117;
	bh=tThCOv7HD0yQTlkshwFBlHGO7UMypXlIxhmNLRiS0Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+71Z8LOPZ4uFjk1NrmOZ/Ye37gdQjWpGwGHDnw3I6xEX2GCIm9HNl8sb0haeUUrt
	 R74+dBR3Q2gU+CsgZn3of7TmEudNr/MxwYXwWJdpF+mgpcG8NQdhbHMu6i9QIPn1PK
	 nY1g9QKJfh0RmAIqAieI9B5xEMZLYCwEOJ+U63bA=
Date: Wed, 24 Jul 2024 11:08:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: stsp <stsp2@yandex.ru>
Cc: linux-serial@vger.kernel.org,
	Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [regression] ENOTTY returned for tty fds
Message-ID: <2024072401-spearfish-gnarly-a09e@gregkh>
References: <b6f4aa5c-10ba-411b-994b-6dbed2bf63db@yandex.ru>
 <2024072452-pegboard-undying-4245@gregkh>
 <c74f1e3e-a376-42e3-86e0-a804f9a7da2c@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c74f1e3e-a376-42e3-86e0-a804f9a7da2c@yandex.ru>

On Wed, Jul 24, 2024 at 11:07:32AM +0300, stsp wrote:
> 24.07.2024 09:51, Greg KH пишет:
> > What caused this change/regression?
> 
> I have absolutely no idea.
> I've found it by debugging userspace,
> and wrote a test-case to make sure the
> problem is not in user-space.

So this has always worked this way?  Or has it changed?  If changed,
when did it work before?

> >    And does any real-world programs
> > rely on this?
> 
> dosemu

It does this today or wants to do this in the future?

> >    What exactly are you trying to determine with this ioctl
> > test?
> 
> Whether it is a PTS (Pseudo-Tty-Slave), or
> a real comport with MSR signalling.

Why is that needed?  And why not do it how other programs (like stty)
does it?

> >    Is there a different way to determine that?
> I am not aware of any "canonical" way
> of determining this. Maybe you tell me. :)
> So far the only fix I know, is to stop checking
> errno. But you return ENOTTY for a tty-associated
> fd (isatty(fd)==1), so I believe this is a
> bug in a kernel.

isatty() is a libc provided function, not a kernel call.

thanks,

greg k-h
