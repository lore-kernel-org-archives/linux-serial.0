Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2CE3FFAB9;
	Tue, 26 May 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807071; cv=none; b=rwzYEpQaieJnuvL5olmoTDmeQimdyj+rwe9QHu3UlxWZ5q7pShE1xLM1T7Wi4oAj7zHE3tAOB6ks5GQnJN9vyFnDnDu1Om46EgQ9zeX9MBF82vmNRjFPZ/88aJNaQOssbKV3DM51WBvyQzcYe7ZFbC/KRRNKq1nqjxMDI3NX3T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807071; c=relaxed/simple;
	bh=q0R2WmyWnbg2MejpFO6ouqo9jMd0E/Aae1r3bx48hJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKkeDGJ3M5NOetRsELmtjdPzDzYRRMaVg1XOH2xYNK86XVHhkqJCoh6S7nxe4xR76ShDyLfEn1K2x1gSGfli+/+WzIYnmSKEvhHIF2aamTXBVkYZq+R6HkUzt+uxmLJCo2odaZZSLJggR7uD1NMqmozSXMXvo9+I4HeNBgBuBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1wRt7c-000157-00; Tue, 26 May 2026 16:51:08 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 1D9C3C0837; Tue, 26 May 2026 16:48:24 +0200 (CEST)
Date: Tue, 26 May 2026 16:48:24 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-mips@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 00/10] MIPS: DEC: Fix serial device regressions + RTC
 cleanup
Message-ID: <ahWyuPUMe7XQ9fZp@alpha.franken.de>
References: <alpine.DEB.2.21.2605062240290.46195@angie.orcam.me.uk>
 <alpine.DEB.2.21.2605221609220.1450@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2605221609220.1450@angie.orcam.me.uk>

On Fri, May 22, 2026 at 04:15:06PM +0100, Maciej W. Rozycki wrote:
> Hi Thomas,
> 
> On Wed, 6 May 2026, Maciej W. Rozycki wrote:
> 
> >  Two extra introductory changes, 01/10 and 02/10 have now been added to 
> > platform code.  No modification has been made to original changes.  The 
> > original description follows, updated for patch renumbering.
> 
>  Will you be able to get these two changes merged sometime soon now that 
> Greg has queued changes 03/10 through 09/10, so that these prerequisites 
> land ahead and there's no 64-bit regression in mainline?

I've applied 01/10 and 02/10. 10/10 doesn't apply to my tree, because it
depends on the platform.c changes from dz/zs driver change not yet present
in my tree. So either Greg takes it via his tree or I'll pick it up in
a second pull request during the merge window

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
