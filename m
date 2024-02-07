Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633C23759;
	Wed,  7 Feb 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299505; cv=none; b=duhnhT+ju30JFkMno0Iw2Wlzzpq4OpAVSenWYfZKRNxPkbs00JzQHpMtRfWgF8vAiqHUZL/CEbr0fzDsbY42xN8H57mo9CMeNaqSpZy2eQbcQHYnklgpT4SpEoA2GFgmuVLIZ/M1DMH64Cop5dU742RwzpXn9XGtVZQIDXSQ8Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299505; c=relaxed/simple;
	bh=q43MH+lenOB9ylP/fJbs+XxYluDSrl1obvPsCaw5/qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wk+YVBe948tb33cJOKBRuFm+gqESf7FpBG6TnHFWDfJ7oCEyMG9/ghSLMfHhAr5o3mZBqXgox8227KtLc5F5hftj9qwsi3LFVJ2qdrP/YyMNj54ta3Yb70EBtpC0QudEmwZ+Gj4Ogzs1udYSGIj6CdEkdff4F3O9WWTi5AM5teA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NG4uDLd9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NG4uDLd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6028C433C7;
	Wed,  7 Feb 2024 09:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707299505;
	bh=q43MH+lenOB9ylP/fJbs+XxYluDSrl1obvPsCaw5/qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NG4uDLd9567/mD8Cm7Y9Ll0pAWb10GtbdlnARs2MEag3EyRff/WSo2U8BczID2Iyk
	 wjI4YnlCwNpvunO9JSTzxFQj8+4EAF7wuYDW6pHKAKGCdmJScnnbkPUlfPYUL+eiwg
	 NlQnVQrQb3luE+BhMQ+FqmKURmFTGq8HCzzc11Ds=
Date: Wed, 7 Feb 2024 09:51:42 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Sreenath Vijayan <sreenath.vijayan@sony.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
	Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [tty:tty-testing 28/29] include/linux/printk.h:275:13: error:
 unused function 'dump_printk_buffer'
Message-ID: <2024020708-unknotted-ceramics-f6ec@gregkh>
References: <202402071252.Zj78sTXN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402071252.Zj78sTXN-lkp@intel.com>

On Wed, Feb 07, 2024 at 12:22:40PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> head:   014e10bea593b963574d607faa34e7eaaad3c02b
> commit: 558367b641b3802572132e7ed865f5eb887c41ea [28/29] printk: Add function to dump printk buffer directly to consoles
> config: i386-buildonly-randconfig-006-20240207 (https://download.01.org/0day-ci/archive/20240207/202402071252.Zj78sTXN-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402071252.Zj78sTXN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402071252.Zj78sTXN-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from lib/test_bitops.c:9:
>    In file included from include/linux/module.h:13:
>    In file included from include/linux/stat.h:19:
>    In file included from include/linux/time.h:60:
>    In file included from include/linux/time32.h:13:
>    In file included from include/linux/timex.h:67:
>    In file included from arch/x86/include/asm/timex.h:5:
>    In file included from arch/x86/include/asm/processor.h:23:
>    In file included from arch/x86/include/asm/msr.h:11:
>    In file included from arch/x86/include/asm/cpumask.h:5:
>    In file included from include/linux/cpumask.h:10:
>    In file included from include/linux/kernel.h:31:
> >> include/linux/printk.h:275:13: error: unused function 'dump_printk_buffer' [-Werror,-Wunused-function]
>      275 | static void dump_printk_buffer(void)
>          |             ^~~~~~~~~~~~~~~~~~
>    1 error generated.
> 
> 
> vim +/dump_printk_buffer +275 include/linux/printk.h
> 
>    268	
>    269	static inline void dump_stack(void)
>    270	{
>    271	}
>    272	static inline void printk_trigger_flush(void)
>    273	{
>    274	}
>  > 275	static void dump_printk_buffer(void)

Ah, inline was missed :(

I'll drop these from my tree for now, can you resubmit fixed patches
with all of the collected reviewed tags?

thanks,

greg k-h
