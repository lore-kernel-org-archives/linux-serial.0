Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502913F434;
	Fri, 11 Apr 2025 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351240; cv=none; b=HVWZB4pON4JdH8fqpJEqqJ5UnVwIxIoo9CTJOu4Dqui496zVzqgnGEtUDhFl7hC3FIwp3ny/rO4KcvZD5hIgR1U7GPav0eo9OMmAZZK61JTPEB0lNwx0qDkv5cTCQoimNizPHu02OxEHHuLtLbX8RA6ITb9WPFu3LOvZyXNJjYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351240; c=relaxed/simple;
	bh=XLNuZl1M/V2LzJD/AZf7Wdiyi698tvwzlUnWdV61V+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKavrodKrWCOSyxhHgqpybrq5qBQVRtVlqxskl8FhCo3DyNzEPFPNASvV0l6W3nHkTMofiIGb1C92SCelzM5SQwOBPlzoYr1GvDCQPltaAy49NIlDAfFMBhsj1pmSI36gl/PxexJmdUzETLooBUZSgwo1m9mdoK3PF85sI9jn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9gUaiU2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9gUaiU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744351236; x=1775887236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XLNuZl1M/V2LzJD/AZf7Wdiyi698tvwzlUnWdV61V+E=;
  b=A9gUaiU2N9hFbUiN2IiDD3IDjhza6SvMtymZLol/stg9fN/Bgx8KQrWo
   eA5JLWEVZ2nVPKFPsLFqRDWl/OR6LPSz7MdnDajT+7KOpXp8m7GTvXXUa
   WDFEfOE9Er+H/YDzjb9ly5w4FCDqSJJASEMZA9FZLxMX9ZmpMkDAl64xD
   OGvGMproJ+j74l/kO8uIziUkGs5pfSRDfj63zsl0HptQQD7RkwTi2s9bC
   AhBmmF9KUVrb8vmNe2R7pIIMCIbGdAUNrlhufio+L7yeR7bxhaSpOZEAq
   W6gXFW0tztSE7XsnliRNEBv7BO5BtUk7cfEubzHCHLCkznFi3Fkq1oN6t
   A==;
X-CSE-ConnectionGUID: Ap/cq5kBQvmvyrRmZgPaZQ==
X-CSE-MsgGUID: 4nLKMwyYRL2UXAeHPST0qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45133933"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45133933"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 23:00:35 -0700
X-CSE-ConnectionGUID: TRt2w+rgSeGCSYvkQJ6qtQ==
X-CSE-MsgGUID: IKbVr+5tTXqoUI+D6j5Sbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="129072394"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Apr 2025 23:00:34 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u37RH-000Ask-20;
	Fri, 11 Apr 2025 06:00:31 +0000
Date: Fri, 11 Apr 2025 14:00:19 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] vt: create ucs_recompose.c using
 gen_ucs_recompose.py
Message-ID: <202504111359.urXWyzvQ-lkp@intel.com>
References: <20250410011839.64418-8-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410011839.64418-8-nico@fluxnic.net>

Hi Nicolas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.15-rc1 next-20250410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolas-Pitre/vt-minor-cleanup-to-vc_translate_unicode/20250410-092318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20250410011839.64418-8-nico%40fluxnic.net
patch subject: [PATCH 07/11] vt: create ucs_recompose.c using gen_ucs_recompose.py
config: csky-randconfig-001-20250411 (https://download.01.org/0day-ci/archive/20250411/202504111359.urXWyzvQ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250411/202504111359.urXWyzvQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504111359.urXWyzvQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/vt/ucs_recompose.c:148: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Attempt to recompose two Unicode characters into a single character.


vim +148 drivers/tty/vt/ucs_recompose.c

   146	
   147	/**
 > 148	 * Attempt to recompose two Unicode characters into a single character.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
