Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F10768FF;
	Tue, 20 Feb 2024 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449889; cv=none; b=upMzPjS1AAFQoGp6c2ZkwFIYKjLdL3PJ1erPb39K7bkwg0+0UwtODFGKmrAcdMPz0IWmzvDnWtfEnQ3OatqXt78gZaRMhv9wHCUfpo/FUvlO5Vk6TV3TrILpvyIeJxy7ppkdCaoxNfgITQR4LTxkuD2cmd+/0HRCfM3XKq88RUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449889; c=relaxed/simple;
	bh=aKwPCBXNl0gY8TjknCsbiBlOL8RUt4XBoy//XgBLfMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok1aX6EYU/9hMSHwW1wxtLg2utCIIRIxG0oHLWOQGvP4pGAwkkenUszTQdN+HYGG4/XyEvxcFujMMEWdovWuHfUdxZi0kQzVdwDCIn12qgolEysuEMqvYSdgt29AqufKNn2f5HbKbRzIlOs9y2fofaih/F4CLjDK/npyM8kKYug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rcTrF-0000o6-00; Tue, 20 Feb 2024 18:24:41 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id B9BA7C0267; Tue, 20 Feb 2024 18:24:25 +0100 (CET)
Date: Tue, 20 Feb 2024 18:24:25 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Stephen Rothwell <sfr@rothwell.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mips: cm: Add CM GCR and L2-sync base address
 getters declarations
Message-ID: <ZdTgSZRTDkakekkd@alpha.franken.de>
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
 <20240215171740.14550-3-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215171740.14550-3-fancer.lancer@gmail.com>

On Thu, Feb 15, 2024 at 08:17:27PM +0300, Serge Semin wrote:
> Based on the design pattern utilized in the CM GCR and L2-sync base
> address getters implementation the platform-specific code is capable to
> re-define the getters and re-use the weakly defined initial versions. But
> since the re-definition is supposed to be done in another source file the
> interface methods have been globally defined which in its turn causes the
> "no previous prototype" warning printed should the re-definition is
> finally introduced. Since without the global declarations the pattern can
> be considered as incomplete and causing the warning printed, fix it by
> providing the respective methods prototype declarations in
> "arch/mips/include/asm/mips-cm.h".
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
> 
> Note as I mentioned in the previous patch, since the weak implementation
> of the getters isn't utilized other than as a default implementation of
> the original methods, we can convert the denoted pattern to a simple
> __weak attributed methods. Let me know if that would be more preferable.

how about simply remove __mips_cm_l2sync_phys_base() and do everything
via mips_cm_phys_base(). And at the moment without anyone overriding
mips_cm_phys_base I tend to keep static without __weak. If someone
needs, we can change it. Does this make sense ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
