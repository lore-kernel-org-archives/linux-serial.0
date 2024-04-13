Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC828288DB
	for <linux-serial@vger.kernel.org>; Sat, 13 Apr 2024 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713000682; cv=none; b=nJL30FJN7TlXmBAhKbtoN95V24BR6rXTq1kqVXi0r+IIZhjXsRAwMXMniFWbWvdN2dK/feqjMVPd6XUhISN3dlwYvzHFkltynXEBSjJU1KMPLJYHiamBE4GadVMHNZhNoCZcwqw4M/Ma1UZxadb7Hb3S13A6lD5ft+KYxnE5NLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713000682; c=relaxed/simple;
	bh=+wQqGGefb0PMPLrFSxp6IE2L36t23v96VqETSDdq6AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxyliBD2YClBySXycB7aZ2eCjTBQDNJW4J8myZjMYdLAUXXNmYV8RO95a4q+qSvJWkRz96E+qqmRjLE+Y30RVmVG67gi1a9UfAQBhnrVvEaDKR510gbxDO+/Fpjw90pksFSeKrOI3PQqTPoeoLTKOpohQ7PoJpECMCvKyRzPtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=XOajjUY1; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="XOajjUY1"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 5DB07604C0;
	Sat, 13 Apr 2024 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1713000674;
	bh=+wQqGGefb0PMPLrFSxp6IE2L36t23v96VqETSDdq6AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XOajjUY1lfjy2eOZqdDeTQ/sfdWcysB0zbX/LF8+lG0RyfDRJR102w1Vykuftw5Ls
	 Ojl1cXNSkJ69VSpTHvzuz1Kd9e8eVFIa8TdCHlT68ZAwh1fSLBJXGRpMT1TA7rDGMP
	 6bE/KbbPFMdM7P+WMYxArN51FmOz+u4FmUgbien5pS+tRfi9C5PxQ/r+ZBuYXrWzy9
	 u39btm3o1vh1wF5UTPUCNJt2epcaVyaF01v4GIxpNWdWpSYUZcmGiCnNaY35IHgn66
	 x7Jmag0CuPQL68/PYNtUma+EmMHfvOhXWmQ/YegJfOgSbD7tppm5He8wuncBiYgL1K
	 fHI7ASaZhvE7w==
Date: Sat, 13 Apr 2024 12:31:01 +0300
From: Tony Lindgren <tony@atomide.com>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [tty:tty-next 61/65] drivers/tty/serial/serial_base_bus.c:267:9:
 error: call to undeclared function 'serial_base_add_one_prefcon'; ISO C99
 and later do not support implicit function declarations
Message-ID: <20240413093101.GL5153@atomide.com>
References: <202404131416.VJljwvkS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404131416.VJljwvkS-lkp@intel.com>

* kernel test robot <lkp@intel.com> [240413 07:04]:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> head:   1b743485e27f3d874695434cc8103f557dfdf4b9
> commit: 4547cd76f08a6f301f6ad563f5d0e4566924ec6b [61/65] serial: 8250: Fix add preferred console for serial8250_isa_init_ports()
> config: mips-mtx1_defconfig (https://download.01.org/0day-ci/archive/20240413/202404131416.VJljwvkS-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240413/202404131416.VJljwvkS-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404131416.VJljwvkS-lkp@intel.com/

Thanks fix coming for the ifdef issues. I'll run make randconfig on it
for a while before sending though.

Regards,

Tony
