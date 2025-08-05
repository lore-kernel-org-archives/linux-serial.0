Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB31C8603;
	Tue,  5 Aug 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754432430; cv=none; b=TPfS32jXuSmP7CVKpGCe3QREoka7NYy4BMLmgnK/zNc2Fazk4TZbXssw5wIScDPN6emA7dMPRpAC7YxoTVvLXPbJM5NjOYH3R1x7QoB+XgbjkKtpM2JIH9u43SQQK7DrKRg4a41MGqxBpBmDYlH32vdqXpQe93MV1RDRIJiKZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754432430; c=relaxed/simple;
	bh=DvXMuKzlkswWxDWS0FNoCNN4nTMyCzShOVhB6iJKmVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQK66EXlm6ytvZHEe0g2nwMJPIaU+rl0YYrOvvYkL0RPwjQpzO/1t8Xu/QXf4DHyi9JP3kscwZsehPeqUmchqAblKU2ph8w7Nc6eJ1psn1QskACjEDm4Yn5QL0E0XesHyVejmpyw+/i9iR7Y5EEAI1VH2QnxylrqwfQIRGeOotM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEst3Q9S; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEst3Q9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754432429; x=1785968429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DvXMuKzlkswWxDWS0FNoCNN4nTMyCzShOVhB6iJKmVM=;
  b=WEst3Q9SkqciUlsUChIV3w9Wf+57QPspEvVk8cnrmnVyC5nUs13/X8Sp
   ZjnaVABH5srEkT41tgtGssCpZffOb+mcdkYHVKnjqFgatsfb5Q/oYQiLI
   T+DNub/7blRU6NX85nUDMfsXI+UL2/i/i1KvkuNJzHJqlDuNrUVZCM1Pg
   WLHdKYL4GGNnVJt+QWAWmNa68FO3NAOYrwhfzzzKu3VlnACWiymqTziE1
   yIDZGJkZI96BQgk+lJCBiOu7qXnW4lPTOHuf2Z90udugjiPgBdJkhhgVv
   gxuZyM76xXoef21s+cqunfgW07jtnLPK6UPcPDJZZdp6k9J5YEgOLEQPi
   A==;
X-CSE-ConnectionGUID: RGUeiOECSH2fVSMzT5bUTA==
X-CSE-MsgGUID: y9KU1fo7T4GOXtTlpkOCiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="44335700"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="44335700"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:20:29 -0700
X-CSE-ConnectionGUID: iUmb0UQFRFexwuq89A7bVA==
X-CSE-MsgGUID: zK07A3/6Qz20ESVQvvpd7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164141359"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:20:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ujQ19-00000003rpe-2weI;
	Wed, 06 Aug 2025 01:20:23 +0300
Date: Wed, 6 Aug 2025 01:20:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Abinash Singh <abinashsinghlalotra@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	sunilvl@ventanamicro.com, arnd@arndb.de,
	u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH 2/2]  tty: serial/8250: Fix build warning in
 serial8250_probe_platform()
Message-ID: <aJKDp1LBpzswp5lX@smile.fi.intel.com>
References: <20250805195155.742004-1-abinashsinghlalotra@gmail.com>
 <20250805195155.742004-2-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250805195155.742004-2-abinashsinghlalotra@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 06, 2025 at 01:21:55AM +0530, Abinash Singh wrote:
>     The function serial8250_probe_platform() in 8250_platform.c triggered a
>         frame size warning:
>     drivers/tty/serial/8250/8250_platform.c: In function ‘serial8250_probe_platform.isra’:
> drivers/tty/serial/8250/8250_platform.c:201:1: warning: the frame size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> This patch reduces the stack usage by dynamically allocating the
> `uart` structure using kmalloc(), rather than placing it on
> the stack. This eliminates the overflow warning and improves kernel
> robustness.

Same comments as per patch 1.
Also, here in the Subject you have an extra space. Actually, check output of

git log --oneline --no-merges -- drivers/tty/serial/8250/8250_platform.c

to have a hint how the Subject should look like.

...

The approach in general is okay to me.

-- 
With Best Regards,
Andy Shevchenko


