Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFDD220F55;
	Tue,  8 Jul 2025 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961927; cv=none; b=cKN1mPyrdGZ7G6k7JaRy9FRnEAIrFpa2dTacr2YS8zmW0BXCC2WEFMF2U220AeYTKwFegieVNlRVO+yJ+6wYhy6VHyU8Nj0dOEZCM2FpeKIltOWhVUK66Swhwgc//0XB2YIODnn3KXvKWkyiluqw0dHGsacB6YQDZJkx5Oy/0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961927; c=relaxed/simple;
	bh=nQ+QLVjfD7gctFAolY39NqAnjXt89PjYsmMH0wSX98g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwDyo+E+5uaQZ7MzDFvF+6lfgI8lhpG0YEWVX2OgxhCtSZ6mdgTMC9o2IlQLAWGldF7WoMNA5nE/7C6ST21CM7vBujN5hDm0nXVkHXApN9vQAR6JCsYQL7EoAH5sMjgfQRofG1uWldZ+2CcowBOdlK/gOrJVhBxvda08CniT0yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lRaROpKn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lRaROpKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0B8C4CEED;
	Tue,  8 Jul 2025 08:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751961927;
	bh=nQ+QLVjfD7gctFAolY39NqAnjXt89PjYsmMH0wSX98g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRaROpKn3DFS/NcU/7lFt1vlJyxI35huUx2gxRvX0NgqOIe4p58jfS8zbSmDEBIMC
	 exH2vnuxRr04ogoxn/yzUxgspgYABLiiQ79O1SYezzaD0aQDd2QREMIQYAxRNvwYxx
	 zTAr0vPWh4Qvn/hoTVgMV7/MyMQNi5jMxouC+UkU=
Date: Tue, 8 Jul 2025 10:05:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marwan Seliem <marwanmhks@gmail.com>
Cc: akpm@linux-foundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: sysrq: Introduce compile-time crash-only mode
Message-ID: <2025070804-curler-hummus-8766@gregkh>
References: <2025061938-making-igloo-3326@gregkh>
 <20250707211650.12051-1-marwanmhks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707211650.12051-1-marwanmhks@gmail.com>

On Tue, Jul 08, 2025 at 12:16:50AM +0300, Marwan Seliem wrote:
> Let me clarify the security rationale and address your concerns.
> 
> > "security" involves crashing the system, so I fail to understand why one
> > is more "secure" than the other.
> 
> You're absolutely right that crash access itself requires careful consideration. 
> The security distinction we're making is between:
> 
> 1. Controlled Crash Access (our patch):
>    - Single, auditable code path (only sysrq-c)
>    - No runtime configuration possible
>    - No ancillary debug features that could leak information
> 
> 2. Full SysRq Access:
>    - ~60 command vectors to maintain/audit
>    - Runtime configuration complexity
>    - Features like memory/register dumps

One can make this argument for each of the sysrq options, but attempting
to make each one a config option is crazy.  We have chosen the "either
all or none" to make things simpler overall.

So attempting to maintain yet-another-configuration-option like this,
for the next 40+ years, is adding to our maintance burden for almost no
benifit that I can determine (hint, I still think it's crazy to allow a
system to crash but not the other things.)

So I can't accept this added complexity at this point in time, sorry.
If you can convince others that this really is worth the overhead
involved in it, please do so and come back with some more support.

thanks,

greg k-h
