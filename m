Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C612BE65C;
	Wed,  6 Aug 2025 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754513028; cv=none; b=JvxKqoJ5XKrzj6Vt25BLYaHl+3eUra5wmVYgQKYFUxHfqnHg4YMQBDEwM/C0/glAcOT5CI25eGc9ElHSxUu7w32wrXte2bwauHBemNy7tjMBSfHL378vu72alRbUcbxU30NPg9Wyyw8ckndqIBQuiZ+LIX3uxHWcyv7nnsQDdNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754513028; c=relaxed/simple;
	bh=MwJSiczF6zG/3d6djGTXvnW1UNek1LFszXaUex04NDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDKiMzDuurrmyFHiKDAjtvrK8yvoHdwHIly/WPYn79nkFGrOLYyAIFNCe7z4N8vOgJ2GG/5YIjfSL1s1SnC/EGX1hX/IaTWAlOa3R6SJTWPiTEnSPsxzpXufO7h8X3tjkqQBOgMpTzGwXiIqJDPDZj5Q0Jq0ubqPeG6tRyRuw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kh7iJ76h; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kh7iJ76h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754513026; x=1786049026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MwJSiczF6zG/3d6djGTXvnW1UNek1LFszXaUex04NDk=;
  b=Kh7iJ76h0s5iakWJhMAjDeveSUoFgSacNlwHFnCDtBdKz0X0V9i+umyS
   jcrsij6BvfeWopI5vXV5EmyTz7u6dYTUFsXD3L16OVcZ7lDrKXg4smL9u
   TswFjeNn5Edb1GUHFu6sT9tVK21EAmUKN/DHxi0pqNQEwYisR5yMyd08U
   bHOYvV560z2bmEWyZzp/X1EuSn3yJnGF2THFeQAKksmfJsnCKdZef0197
   7rpIG5vNnUUyYKeGuFutVu2vcc7etGgdzdeBYxgK7Fnopvy4oVDryk8b+
   gHRUcwBSCo4EXhcZNyEAoEB/F3BkCsdJfmfIScnWfqYQU4CqG3yFsBNP0
   A==;
X-CSE-ConnectionGUID: BC9VDkzXRP6udb5G3VGDgA==
X-CSE-MsgGUID: kge2615nTYKezxMG0J7Ocg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60651715"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="60651715"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:43:45 -0700
X-CSE-ConnectionGUID: AiosLALiSReS77YQCHLX0g==
X-CSE-MsgGUID: GC1fjSIJS2u0IRE08sFWgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165236216"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:43:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ujkz6-000000046vp-313Q;
	Wed, 06 Aug 2025 23:43:40 +0300
Date: Wed, 6 Aug 2025 23:43:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Abinash Singh <abinashsinghlalotra@gmail.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	sunilvl@ventanamicro.com, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v2 2/2] serial: 8250_platform: Reduce stack usage in
 serial8250_probe_platform()
Message-ID: <aJO-fB_dSwuTp5XZ@smile.fi.intel.com>
References: <aJKDp1LBpzswp5lX@smile.fi.intel.com>
 <20250806201047.754240-1-abinashsinghlalotra@gmail.com>
 <20250806201047.754240-3-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806201047.754240-3-abinashsinghlalotra@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 07, 2025 at 01:40:47AM +0530, Abinash Singh wrote:
> The function serial8250_probe_platform() in 8250_platform.c triggered a
>         frame size warning:
> drivers/tty/serial/8250/8250_platform.c: In function ‘serial8250_probe_platform.isra’:
> drivers/tty/serial/8250/8250_platform.c:201:1: warning: the frame size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> This patch reduces the stack usage by dynamically allocating the
> `uart` structure using kzalloc(), rather than placing it on
> the stack. This eliminates the overflow warning and improves kernel
> robustness.

...

> -	struct uart_8250_port uart;
>  	int ret, i, irqflag = 0;
> +	struct uart_8250_port *uart = kzalloc(sizeof(*uart), GFP_KERNEL);
>  
> -	memset(&uart, 0, sizeof(uart));
> +	if (!uart)
> +		return -ENOMEM;

Missed __free and same comment as in previous patch. An rule of thumb: avoid
such a split in the future, try to have an assignment and followed up check go
together, it 's easier to maintain and less prone to subtle mistakes.


-- 
With Best Regards,
Andy Shevchenko


