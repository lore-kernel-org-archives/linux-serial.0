Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5F3C465;
	Fri, 17 Jul 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294173; cv=none; b=qQMdSySFqJ8a4zJ+1dfMQ4cVnN69mw7sGH9WYT/K/ANqwzcx8MD67GwEw3C7UKvs2Ev5/EPTx42AdAULT0V6PGoieAr3ot/8Vy9BGXEYUPAK01wSTt+dLPSnI0YksurUZDRe4LuAxKOpWL5F18ZhVTpFyS0eLd6jB/CJkXkp1Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294173; c=relaxed/simple;
	bh=q9zDT5zMKTI9/B7zhzZDyLQbx6QImkuos2wgqay4xz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQxaV6oZy4IzW1+73yDn0TI4YofMQRr50QJO3NagBljQav3HGoTeFx3iYMZWS0SOD/sJl7Ov39oxDOjJpXYfzeCm2xjMskMVPtLsu4OzVXELv/ewN45d1SRWmQtveqLmu860daPSLX3KXEwFIfCZmBuRYpoBXH3ZA8mhTBzaMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HWYFU9T0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HWYFU9T0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B171F000E9;
	Fri, 17 Jul 2026 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784294172;
	bh=1v6kjlO6r8jmwYBEZrXNvEv/cHkklSGGki9AMF0qEVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HWYFU9T0cK5JG+TWzfGTy5lkxcvv+svYrriIPfWwcdT9V6MhVI7BQ4e9tHKRKwZDG
	 pTbm+X/hFVKiQ9FumrfJ0lec24v7da3y24B8LK2c2PKBOWtRdCC4RhK/yjarivo9gw
	 adXA177EX2JNFwhYpXUs6UbAOBP9VECP2azxucew=
Date: Fri, 17 Jul 2026 15:16:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Markus Probst <markus.probst@posteo.de>, oe-kbuild-all@lists.linux.dev,
	linux-serial@vger.kernel.org
Subject: Re: [tty:tty-testing 11/13] error[E0425]: cannot find type
 `BoundInternal` in module `device`
Message-ID: <2026071755-overture-crunchy-bfaa@gregkh>
References: <202607171517.ScFnGK4R-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202607171517.ScFnGK4R-lkp@intel.com>

On Fri, Jul 17, 2026 at 03:07:34PM +0200, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> head:   ec7dbdaa11c7be1806f0ea1a272ee6daee42a843
> commit: cbc11f4e978d1ee0bc857a9c51d43bbae6966f1d [11/13] rust: add basic serial device bus abstractions
> config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260717/202607171517.ScFnGK4R-lkp@intel.com/config)
> compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
> rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260717/202607171517.ScFnGK4R-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202607171517.ScFnGK4R-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Now dropped, don't worry about this.
