Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF01C192B7F;
	Mon, 25 Nov 2024 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531933; cv=none; b=IVNSLf1oWC+B1jSCjKP81DYKgAV1B4zmCl2LjgOwfVuE9iOLHAkBohWWjc/OcbHQiXGVAsbL7/5Gp8ANPvClqDe667dj9CJjWcp2s6SZkLxWQwuBLqneea92hMa+XrPhzOAXS/d3XlEw9KWdI0DU8/MihxawBEs3qIRb6oVxl6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531933; c=relaxed/simple;
	bh=LQdscQoHPXFaOlKqrHrLET7Ump5Q8lvyH1vGESrIY3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfFbywn+UTTbV18qXWpKYBJ6f36WiQJF741EBgD/2B223bLVkp3e/dJzugZjtHBhkxftnh1C4G/ck/SUBezchmzJ1zqMs5h8/o7JVpaIHyV/7OLtdSGFDMEcPyAh7pjXR1j+xut/LE0O2FX3g6JFHA87cCrzEqm8LAmvTzAPlTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mf6DO0mJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mf6DO0mJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732531932; x=1764067932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LQdscQoHPXFaOlKqrHrLET7Ump5Q8lvyH1vGESrIY3U=;
  b=Mf6DO0mJ7iIYzgm+WsOj5KKkTd34S+gv2X1h3xi8rV05lIOxlobUFReg
   W0kyuNSzkc+K43DqF0/ZBI821PoyMJsH7dAqGEFDKbGF+BaG9Yn67nPV0
   aeQAvOZI/DF2H+uT9DxyOF5bOSi79QaEoD0mv73Okkdimb33eki+xe4Dp
   XHwgRWRfETN96ZDnaOt4x8cR2raL1zx2BX/HF+mYCz2WTQYt+hlPbsQ+g
   69Mw9yHizoT9aMhAaxIrs1Ull71nS0Uy7acWlqsRovKclikKDvrj97rnh
   TqIuhUkxSemW25a7LVS4JlFVARuqvlVVj/qR4krexKHTDEhgOP0/zDSvE
   g==;
X-CSE-ConnectionGUID: 2TU03WTxSJS+TQmhK1CDpw==
X-CSE-MsgGUID: gyWA0W/BRpqfL20rDm/faQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="44026379"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="44026379"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:52:11 -0800
X-CSE-ConnectionGUID: PFlaIhVYR6ux0xMNF3fvLw==
X-CSE-MsgGUID: QHP2SAFJQ5KkxJg7O5lrnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="128740664"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:52:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tFWhL-00000000iln-1Nzv;
	Mon, 25 Nov 2024 12:52:07 +0200
Date: Mon, 25 Nov 2024 12:52:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_port: Assign UPIO_UNKNOWN instead of
 its direct value
Message-ID: <Z0RW19I9VsuBlTL-@smile.fi.intel.com>
References: <20241125103305.1614986-1-andriy.shevchenko@linux.intel.com>
 <ce88e017-9c2a-4963-a64c-9893e12cf6ea@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce88e017-9c2a-4963-a64c-9893e12cf6ea@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 25, 2024 at 11:45:32AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 25, 2024, at 11:33, Andy Shevchenko wrote:
> > serial8250_init_port() assings 0xFF for the unset or unknown port
> > IO type, use predefined constant for that instead.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thank you!

> I already thought about sending the same thing, but was going
> to wait until we have found a solution to the
> !CONFIG_HAS_IOPORT warning.

But it seems orthogonal to that... The solution in any case will
be more verbose and intrusive than this one-liner, I think.

-- 
With Best Regards,
Andy Shevchenko


