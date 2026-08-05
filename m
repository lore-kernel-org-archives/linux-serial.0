Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105293D648A;
	Wed,  5 Aug 2026 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785906038; cv=none; b=NzFjj/Z4gO0ACmiR+KZVChGZr2MOEmxztjQ0eMPFHseKAhg38sgL4hmITQDf2K50SQbmtM4BMXogI7yPDAdGWr9aaIE/jiPLiYFRwX1Lg1Wk0hHO8lJKRuAqo10xNuzwSa7kSAaOQawzNqh872zYb+cP0O+ienAFDBh5ZgFCPKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785906038; c=relaxed/simple;
	bh=dLycvoXdQFKQK5rEGdagERB3hxz5rD/JfAd87bkHVKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqVv7J0JidCkZd0AXv2cHAXfJWr42LZTSc3d9YUin9ivY9v7obt/1e1zcPK9osoPao9cPm6Cwma+ZwAtVz9UMVZBEiCmSOeXyfGDtgvZsxnPEj1zrDRaTFb9bWlYBDOZ+fRdmQmrnXrJYK9yWrN5TJ7qrgc639gfA717Ht/TLu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GyUGyah/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GyUGyah/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDCB1F000E9;
	Wed,  5 Aug 2026 05:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785906036;
	bh=8ijpeMhHeoc8QaE6Nw7fkeWgPqpPGqGsJSeWAP0LgXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GyUGyah/X0X0VYyla1fFmSvMsNRLuM5sLmWNdmoPzyotGD9MATUT7vOwN7nqNJkeL
	 oc0KblHhpKBcnKW4rnA9jC/m3Q6CTz1FOJVdVC/hDjfiKeaTmsT1rdRsLIdxYfK9Vb
	 iPldP+ADmRSWfk8P6yT/xqFz0zE1sKA5Jhjzqk14=
Date: Wed, 5 Aug 2026 06:59:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: moxa: remove driver.
Message-ID: <2026080536-dislocate-driven-9c2d@gregkh>
References: <20260804-x-remove-moxa-v2-1-947c039b66e8@linuxfoundation.org>
 <anKDyz8AEpyDpdeS@moxa-KabyLake-H>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anKDyz8AEpyDpdeS@moxa-KabyLake-H>

On Wed, Aug 05, 2026 at 08:28:59AM +0800, Crescent Hsieh wrote:
> On Tue, Aug 04, 2026 at 03:35:29PM +0200, Greg Kroah-Hartman wrote:
> > This is a very old driver, and no known hardware is still around for it,
> > and the company says they do not need it anymore, so let's remove it as
> > the LLMs are starting to poke at it and find "interesting" things which
> > will just waste everyone's time given it's not actually used.
> > 
> > So let's drop it.  If someone really needs it, it can come back in the
> > future, in a more "modern" way, as the style here is very old...
> 
> The removal looks good to me.
> 
> Acked-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>

Thanks for the ack.

> With drivers/tty/moxa.c removed, the following device IDs in
> include/linux/pci_ids.h would have no remaining users:
> 
> - PCI_DEVICE_ID_MOXA_CP204J
> - PCI_DEVICE_ID_MOXA_C218
> - PCI_DEVICE_ID_MOXA_C320
> 
> Would it make sense to remove them as part of this patch as well?

I'll remove them as a separate patch.

thanks,

greg k-h
