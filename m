Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E083D440A23;
	Tue,  4 Aug 2026 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837488; cv=none; b=TsHExGgyJLVe070DtDUjFWgUJ17QFZXuj+QOk1TSCKXkNAi2PGgegB0adeW0ZBpzNel2J4YE0FWavFyxrTYiDy99f4EUSdlXo/tWHb5WaFhodABojhcC9l/ZT++56Oip1PlOGVkY4Dawl/zekxikfLxOpICRhRB+99Ga50FGDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837488; c=relaxed/simple;
	bh=REpAHXcnP2eJ0pbU9bIljfleGc8qy6I/DzyhYpCtKYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEIuyEjfpRxrK2YC348GEWBZf3F+TZUnOCs0e22qGWQfjwS4S+Y89lVTeyykj9kl2o2ZiiDOrMgOi7alp8b2jQj2r9Sy0bSbg2k85sdckp0Ou3JHBVrO2Cg03b/BwP6+GsQubPZC40lIZag7IOdDRYtpTJIZ18hOjmZ+M2E4O4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1CcajIkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1CcajIkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA8F1F000E9;
	Tue,  4 Aug 2026 09:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785837486;
	bh=TqoANJ/3I396vuzyuigpkl0b3SaHeHySj+rowYU+wQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1CcajIkAHH4D7xInJGEs2x/RckuJiG/hjH1yHz1Skb5edxvItZj474bg9HTanfJoY
	 gbNIlEV+hS3yrJJmMqfr5jsY4DCfMe8vDDb3Q/dkEiuDnmi52wdbuUQhwwxYrPgMn7
	 TfSc5eHFYOBpz6ACKGuKRHcQxZ5CWwgt4n6TJnw4=
Date: Tue, 4 Aug 2026 11:57:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: Re: [PATCH] tty: moxa: remove driver.
Message-ID: <2026080429-deforest-snowiness-90ad@gregkh>
References: <2026080345-unmapped-sliced-49f2@gregkh>
 <7a3538e1-444d-42f5-b48a-0a8eb9f2625f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a3538e1-444d-42f5-b48a-0a8eb9f2625f@kernel.org>

On Tue, Aug 04, 2026 at 07:12:01AM +0200, Jiri Slaby wrote:
> On 03. 08. 26, 14:52, Greg Kroah-Hartman wrote:
> > This is a very old driver, and no known hardware is still around for it,
> > and the company says they do not need it anymore, so let's remove it as
> > the LLMs are starting to poke at it and find "interesting" things which
> > will just waste everyone's time given it's not actually used.
> > 
> > So let's drop it.  If someone really needs it, it can come back in the
> > future, in a more "modern" way, as the style here is very old...
> > 
> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> > Link: https://lore.kernel.org/all/afqyY8FQ8ZfpH48_@moxa-ThinkCentre-M90t/
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> LGTM, there are leftovers though:
> MAINTAINERS
> 18341:MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD

As you said, that one documents the mxser.c file, not moxa.c, so should
I just remove both and this entry too?

And the .rst file needs to go, right?

> Documentation/admin-guide/devices.txt
> 2391: 172 char  Moxa Intellio serial card
> 2398: 173 char  Moxa Intellio serial card - alternate devices

Oops, missed that.

> =========
> 
> Funilly, the MAINTAINERS entry was supposed to be for both mxser
> (SMARTIO/INDUSTIO) and moxa (INTELLIO), but the F: pattern for moxa was
> never added (cf. 679655daffdd). INTELLIO should dismiss from there,
> nonetheless.

As above, should we also just drop mxser?  Same age of the hardware from
what I can tell.

thanks,

greg k-h
