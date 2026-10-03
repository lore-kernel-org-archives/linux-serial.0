Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517613385B9;
	Sat,  3 Oct 2026 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791039863; cv=none; b=DvtlPU1SGKLyJCKqvk4Y20QgltcTsGuN6+vq+XxPd2wNH1wjHnhlyTA0z3vaYhASUX0bRG0Y5ea/7Qc77bOhuszcEDdi2oe7O/uOvYI52mP/1jluqvTVGo1eiAT0QmCJCZRFLkVlBqCHfTC8HFoRZ28pk0HyHrLwm+s5nJz5XX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791039863; c=relaxed/simple;
	bh=k+q8OxJrMuAb+UgE0ryZVjfl6muvWrbcOJ1oVxbotBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMvqoqn7MQ52pTCjGWSKPoVUeSlPRXOH3Kfj6/6D9oi7TgtPUZ6/bdCFL+aeOJfvxSqkqIz2I61jNT59xyrVLpOPkprNik07wfhbwtRSCuAITBdh4mFhRdNkonQzwhllRckUHh3BeCdFVDNSsotxkBzQ+vGkEWB1AGTrtDVka1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9RcMQuX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9RcMQuX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791039862; x=1822575862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k+q8OxJrMuAb+UgE0ryZVjfl6muvWrbcOJ1oVxbotBA=;
  b=J9RcMQuXnwm5gQhjNRwXs2KKQRO5oaoeDvH4X4CjxUmY8aFBf59g5AfR
   A0du7P7tP3RXnaLKb2hOkbZIkzGWT5xoEm+mXAgvrEhah4Az7nX9dteNU
   rfM6LWRBt9G5Vu12/dZyOJt9a+o4ck080FxKpZBFrc9PO+sk9CTZ90+o2
   nZ7HgzolU6Ko7zNdDO8OREtXKoW8AapLdTXw5eLeiaUwStbj30PhYc/q7
   LuTMuytlXF1s5tsDt38UakPzzCftRNNhxB/fW7uC1QfoxBa55q0X1A3Jt
   njxZkP/rJfn9oUz2LYQ3D6oDNQCchtbzTZR+Huj9FHd8uIa2HBPGdkP05
   g==;
X-CSE-ConnectionGUID: f2xAgdmFT1CS4Wx11BPtfA==
X-CSE-MsgGUID: oLDRHGqZRD6tCZDDzcxt5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="108155722"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="108155722"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 08:04:21 -0700
X-CSE-ConnectionGUID: nUYLhNEORlqBDVvjezx3TA==
X-CSE-MsgGUID: 6WbNGJOjRj6c5MisoY30RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="279710769"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 08:04:18 -0700
Date: Sat, 3 Oct 2026 18:04:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank.Li@oss.nxp.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Zhaoyang Yu <2426767509@qq.com>, Frank Li <Frank.Li@nxp.com>,
	Kees Cook <kees@kernel.org>, Haoxiang Li <haoxiang_li2024@163.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	vkoul@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] tty: serial: pch_uart: use dmaengine_submit()
 instead of ->tx_submit()
Message-ID: <asEZb5v4vdvmKKmU@ashevche-desk.local>
References: <20261002200927.236033-1-Frank.Li@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002200927.236033-1-Frank.Li@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 04:09:23PM -0400, Frank.Li@oss.nxp.com wrote:

> Replace direct dma_async_tx_descriptor->tx_submit() calls with the
> proper dmaengine_submit() API wrapper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


