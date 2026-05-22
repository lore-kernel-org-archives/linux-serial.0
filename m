Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864D73CC33D;
	Fri, 22 May 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462923; cv=none; b=ATIP3u65plEQ9cEEHf2qnWzoPA9D46W0ujT7FrLucXm1WyOim5XDnuR1IGyDwghmdT1YvAKRY/LL4lu2pqJAkz8LUgjvOIMysSzgwefk1mmIKxWYTSo2Wc4AGzAkSIS9128OHg9wLsLv4igjJi81Ox6FZ3eXIN/XKXZsHoxssf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462923; c=relaxed/simple;
	bh=nM0U+b2T/CJ5j7pAUzglayS8uvz77dq7aIX6uTDBgfo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hmf7HVaiO8ePCRTMlh10m1uD/s7Oavh0zzljOEFz8hBeCJ91WQTuEKqGVf+UwPcApFAK+AHOA+3x27Y1JQuArjOv5UaqViDqcN9KjFLNnwQTF2QL887ciq0sV0ofDy4xq5FZuQC96CbAmsN+kWeIZlRtA5g8kP8ggh1AQhXpsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id CED1692009C; Fri, 22 May 2026 17:15:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C8C4D92009B;
	Fri, 22 May 2026 16:15:06 +0100 (BST)
Date: Fri, 22 May 2026 16:15:06 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, linux-mips@vger.kernel.org, 
    linux-serial@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 00/10] MIPS: DEC: Fix serial device regressions + RTC
 cleanup
In-Reply-To: <alpine.DEB.2.21.2605062240290.46195@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605221609220.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605062240290.46195@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Thomas,

On Wed, 6 May 2026, Maciej W. Rozycki wrote:

>  Two extra introductory changes, 01/10 and 02/10 have now been added to 
> platform code.  No modification has been made to original changes.  The 
> original description follows, updated for patch renumbering.

 Will you be able to get these two changes merged sometime soon now that 
Greg has queued changes 03/10 through 09/10, so that these prerequisites 
land ahead and there's no 64-bit regression in mainline?

 Let me know if you need anything from me here before I disappear for a 
couple weeks in a fortnight's time.

  Maciej
