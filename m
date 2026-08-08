Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36591C5D59;
	Sat,  8 Aug 2026 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786222929; cv=none; b=frangdYlhf2rgRcLS56ERt5SQmnmKO5sP/0mlOZ4Dn9C+Juqo96XQ5UhDtVj9C6brpEdMR3z8i+mOnZW9m5OZLe3HOEciQX9V5wjBM62+CJ1zoA+F1cmyYEeoxitk1c1PhGO4YBusHdbKoGkgmVGhNsviXh5tA4V/3vgCZ+nD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786222929; c=relaxed/simple;
	bh=jsjqHzmdO+8hFzYFnbPwyL9DZFR345Q7Ca4OVZ3+tHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9eN9S5CD38ij0Tgc4b0Zo2D5aFPuQwXF09XUAeCho/jQ80zSOd7zEjdlDRjfXY0zsV/uamNuD9p2tf0zBmEkhOdnv/NiqMeBXasyZywjCwiShWZPuvYP8e6yCQa6zZU7Ywz6YlQwzcrA0yfI2cnzuo6ShzxXqxsBjrxE4AHCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7Upbwzo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7Upbwzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786222927; x=1817758927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jsjqHzmdO+8hFzYFnbPwyL9DZFR345Q7Ca4OVZ3+tHM=;
  b=Z7UpbwzolAWimhyzbwrIr1VQEJawWX2rrTGACQFkkvVeNfOBRmgC4Pxx
   ZkBOCYgMe2tQXQSJ9v7iYb4mYZ5y+PE+Ilk8qJ7onWrzidNnUAFm77mJh
   Ne7ChB6b3id96SSVqe+JlyVYsBpM75k5Eh0zPx4wlyC2UnhTASzh8aKdu
   RYsUud8Wwh37gOFOEozB/DovYpEUmN5j0XLCAXlfO6gIFNtcASkHviStz
   ajGOE9iFFUn8X35C2of0l1rwBOlFf61QFj8e05lhJtOKj/G02JC04mjsy
   Tr7MD2PliQr5wKToma/AUX61ffFX1XePclPCwrqjAgwUmiAg3QdHTwCbi
   A==;
X-CSE-ConnectionGUID: PSVwQc+kSIOS3nD03hEuGA==
X-CSE-MsgGUID: B7ZhbBbRQWykL0SsOBZZOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="97445197"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="97445197"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 14:02:06 -0700
X-CSE-ConnectionGUID: RWcw9QUMTgi5e/dm/yG31Q==
X-CSE-MsgGUID: z8+xpp3uQ+uB74hu5NtKpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="259364220"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 14:02:00 -0700
Date: Sun, 9 Aug 2026 00:01:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>, Alan Cox <alan@redhat.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	linux-doc@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Abinash Singh <abinashsinghlalotra@gmail.com>,
	Rahul Bukte <rahul.bukte@sony.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lukas Wunner <lukas@wunner.de>, Huacai Chen <chenhuacai@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Gerhard Engleder <eg@keba.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>
Subject: Re: [PATCH v2 0/8] serial: Some yak shaving
Message-ID: <aneZRkjv_Lfkm4Tr@ashevche-desk.local>
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 04, 2026 at 10:57:52AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> changes since v1
> (https://lore.kernel.org/linux-serial/cover.1785489518.git.ukleinek@kernel.org)
> 
>  - Fix author to be my Capable Hub identity for proper attribution
>  - Rebase to more recent next
>  - Actually build test (rant: For mips compile coverage of an
>    allmodconfig build is rather bad)
>  - Two compile fixes (I spare you and me the details)
>  - patches #2 and #5 are new, originating from suggestions in v1
>    feedback
>  - slight commit log improvements (Ilpo Järvinen)

I like this series.
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


