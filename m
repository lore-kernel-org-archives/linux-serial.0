Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DB1A3166
	for <linux-serial@vger.kernel.org>; Mon, 10 Nov 2025 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736353; cv=none; b=XrmseGNrv/xdJtKRKOMEQUi4kdRK5I1re5boEIvhaTd5bXDjRZhD6yw7TEx6Fy8P93OYBIJPL4ouqMgZDhnPgsgHeYCDoGLKHQxAjpI4FelhCOHJy5zC5CGEAkkehqcGlzhyR5qu456Ii8YX+XGxnQvT2R87EEyf5JRZiVjj1ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736353; c=relaxed/simple;
	bh=/g6t3DMIOnfqIVaC4g4IG+fdPWjgZalgL5AnU+s22X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR/zbzKRqChdNsS9e3O0xE31wa9ozI87M7m6lSgjMOzLVcI1vfklbTwtYTO4vuGgoUXfML3ygS6XM8yP+wwe6KbGaKcEYx4dJmO03+bWEnvKuNh65fniJTEvOvctxxBhmajb+gQVoA/7tr8bzNVBBn+SRMLKcA7c0WRqQUE30ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r4LJ6137; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r4LJ6137"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13296C113D0;
	Mon, 10 Nov 2025 00:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762736353;
	bh=/g6t3DMIOnfqIVaC4g4IG+fdPWjgZalgL5AnU+s22X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4LJ6137ynqPh5mT0XaFKxcUUmVEfYTXzwmLs6DzLhiIkqTgG6ShL3721sES1csGC
	 B7xw1Ww7HCS8zrgIdPi+ltZvsF1r/ylAUmBCaaJ8stfP8ZvTVlMvvtkECCOWO1+khA
	 xnV57oxXrHCfsTqcDrfPMSzwxiKd6qLONBGKMOaM=
Date: Mon, 10 Nov 2025 09:59:10 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: "Magne.Bruno" <Magne.Bruno@addi-data.com>
Cc: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 001/001] serial: add support of CPCI cards
Message-ID: <2025111009-whoopee-avalanche-002e@gregkh>
References: <20251108214617.77631-1-magne.bruno@addi-data.com>
 <2025110945-poison-luxurious-7e49@gregkh>
 <AS2PR08MB9917F98E256B2C7A97EA5BFAAAC1A@AS2PR08MB9917.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS2PR08MB9917F98E256B2C7A97EA5BFAAAC1A@AS2PR08MB9917.eurprd08.prod.outlook.com>

On Sun, Nov 09, 2025 at 07:03:14AM +0000, Magne.Bruno wrote:
> Dear Greg,
> 
> If, we do not add those Ids to the serial driver, the driver will not manage automatically our 4 CPCI cards, like it does for PCI and PCIe cards.

I agree, sorry, what I was asking specifically was:

> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index 
> > 92ffc4373f6d..221a83d4e1ed 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h

This file, look at the top of it.  You shouldn't be adding ids to this
file unless they are shared across multiple drivers.  Just add the
#defines instead to the .c file where they are referenced.  So this
patch should just be touching one file, not two.

thanks,

greg k-h
