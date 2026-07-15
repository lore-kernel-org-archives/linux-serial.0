Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452DC22D792;
	Wed, 15 Jul 2026 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784092614; cv=none; b=m7nNOb5nrczmY0UI2F1jTQAilq/2YtwQpdohqgZBYLbC/ohutgWxUH5oatCsZOdSBLHwLXVS59Cg/K2oqbWd35E6k8CiEiq2Ea8sgHcJ3HvArax+TvMdnz2fqo8hiE+NeduAZ+Qrj39UO2qplN7xzM7NhrVeOwWNePl3jNwlZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784092614; c=relaxed/simple;
	bh=MhjOFwN+YL6LNugxn6A/ZqkiNs66fdE8U6jIS0JLZKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfDXHE4bQY2xYebTAbyMd6OzQpDawUIN0Eg3eDKutpNh2Vs0EBeDT/WVp6XKL0eyDCQsUw17bUQKBwj8yQ5NmOT38AtesZOqM/2fRsf9fbGSY3OCFAdh7HozLNWGTYC8dan5NwZ8/fDTI2iBc3gN17qV2FthGjqW4XFRYjJvQjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B8iTWTyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B8iTWTyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1A51F000E9;
	Wed, 15 Jul 2026 05:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784092612;
	bh=TKBAYGoy6OJhN20+nBVfAOp80I6Py1YCwK0I3j8Q+Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B8iTWTydlKkaQrGuCHjoccxJBdEHrfhWTfW+EWo5R0+rSE+tRVWGAoLzBPwKYconM
	 qwLvyFdZfCVj+OJ4TOs7IRpHTZC3/BORR15sgzcopDluPD6Qb1+OD1n4W6ypouxUkR
	 b4LNS+jm7+TuJTFalQWhwAARYc6j/96+QyXZWwuA=
Date: Wed, 15 Jul 2026 07:16:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>, Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: add missing include for
 hub6_match_port()
Message-ID: <2026071505-outgrow-yelp-cd59@gregkh>
References: <20260714012610.576746-1-hugo@hugovil.com>
 <202607150717.2YxVdWpX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202607150717.2YxVdWpX-lkp@intel.com>

On Wed, Jul 15, 2026 at 07:42:00AM +0800, kernel test robot wrote:
> Hi Hugo,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on c1d4ce2d9eaeccd7e8aef7ec1109df49eaf4f503]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hugo-Villeneuve/serial-8250_hub6-add-missing-include-for-hub6_match_port/20260714-092814
> base:   c1d4ce2d9eaeccd7e8aef7ec1109df49eaf4f503
> patch link:    https://lore.kernel.org/r/20260714012610.576746-1-hugo%40hugovil.com
> patch subject: [PATCH] serial: 8250_hub6: add missing include for hub6_match_port()
> config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20260715/202607150717.2YxVdWpX-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 16.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260715/202607150717.2YxVdWpX-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202607150717.2YxVdWpX-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/tty/serial/8250/8250_hub6.c:46:6: error: redefinition of 'hub6_match_port'
>       46 | bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
>          |      ^~~~~~~~~~~~~~~
>    In file included from drivers/tty/serial/8250/8250_hub6.c:10:
>    drivers/tty/serial/8250/8250.h:340:20: note: previous definition of 'hub6_match_port' with type 'bool(const struct uart_port *, const struct uart_port *)' {aka '_Bool(const struct uart_port *, const struct uart_port *)'}
>      340 | static inline bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
>          |                    ^~~~~~~~~~~~~~~
> 
> 
> vim +/hub6_match_port +46 drivers/tty/serial/8250/8250_hub6.c
> 
> ec9f47cd6a14ca drivers/serial/8250_hub6.c          Russell King    2005-06-27  45  
> 3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21 @46  bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
> 3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  47  {
> 3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  48  	return port1->iobase == port2->iobase && port1->hub6 == port2->hub6;
> 3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  49  }
> 3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  50  EXPORT_SYMBOL_GPL(hub6_match_port);
> 3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  51  

This patch didn't cause this problem, just made it show up.  Can you
provide a follow-on patch that fixes this?

thanks,

greg k-h
