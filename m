Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180263;
	b=YKZmQZZ4vrYji/lqVAxfbe/N2N99nypGbddj9Hj1nSklN43b1thia2LBct5sJgXfrsGI
	 sNz2/xGxDpDc070Xqy9e1GLXaAVPjt6+txK7X9ATDezUd8shhRGBWr9lbD06YcheTjO0t
	 TL/ZW+s1dxNjiN7zuiGHJAaSD0wYggUM6rU91ekP1SxLlnjgG1cE48DtNL4YsBeTbn+vQ
	 ylDsnWE3o4Avl7mkLoULu7lle0oOlZsvEHXuwguKJwhwi45m1o2tnkGy/dfuxEqaPUFol
	 za50ZL7vT06XTKqlypISEzwV8nHxlMG0aHEqodZ8ugTCBfJZDFhBX/MNr6hNi3vJB1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180263;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=PfFt5b3z6T/Dye1GZfdd20rqwauprOu5i4Wb9YAWnjE=;
	b=X2L/hZvEOmQMYRSnhvbxaPxgksZyC218oUx7RHP8ZsEBxFIDpoxRnie2Gli0SUHDji+1
	 OWWEbtkU+yOOjtpPh5R+GMobZvcHhBa0L0dWgGUHw0FAX0hN++Z1IMTtcX2Ps2Si9B/Pt
	 E92EL42nL3DF4DouH/KWCoJwemOdcjb9PlwX22bo8o2HEOMyx0UAjD2tv8xg1NLgVni3p
	 EV7qgOy1EjSv+/8EcIbidjizZ15AuSYYPQhSintqn7pAojaVnaPEtNgPeMeMWPCXwir1M
	 nFfo2WuDEpjKvzOpJje8vzB0PeZ8yB6wpIE92GNLgPAyEjBAyActM2BVVvXpUZlNF/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PEwjczoW;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5EB606A31C;
	Wed, 28 Oct 2026 09:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD5EB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PEwjczoW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793180263; x=1824716263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIfnoQkZ4V2uVEMm5sBMRELn7o3bsPgvE78ZyMH/yWg=;
  b=PEwjczoWGVvFFou/B8QoDkQOeR0gLrqeJqyiu8YV79BcutacU01HY38Q
   +417BPHjTz209dbCMNqZNQpawBpkOHikEWheJmMPGJcjP0ASZXk36zNZW
   5NOIopKPjtTWNMdN4OBe0D7+j8AT9FpKFMb1tRdc7tN0kyrgm001FyVsL
   c5QBxW1Jqop7h62Xeq1FHeXUFFChsMwd5P4+CaXI7l5IqYuneR6CJbrHP
   qPe+LKaBIq1GFYoe0ImA9kK2dJIKlVeVe++h8EcWwoFZCj+jOYa9fWGJT
   8G+y3EmqITVD18a2ecc3PsFg7vEt/4+XYiigwIzHnALyTMLmy/hslZM0A
   w==;
X-CSE-ConnectionGUID: krLZLEhyQLa5ZWQrFJz1Ug==
X-CSE-MsgGUID: qLi+ewB4Rc25wDM0hwOxnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1918967"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1918967"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:37:43 -0700
X-CSE-ConnectionGUID: sJn63pxHQrGnAsgSV+mzNQ==
X-CSE-MsgGUID: VpaTTqh/QwSf/O0Focra7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5142869"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:37:39 -0700
Date: Wed, 28 Oct 2026 11:37:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 2/5] serial: 8250: share the RX trigger conversion
 helper
Message-ID: <auHCYdZEqSh4RX7B@ashevche-desk.local>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
 <20261027-submit-h616-uart-fifo-v1-v4-2-d37e018fd0a6@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-2-d37e018fd0a6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 05:05:30PM -0600, James Hilliard wrote:
> Extract the receive-trigger threshold search into serial8250_bytes_to_fcr()
> so drivers with per-port threshold tables can use the same conversion as
> the generic 8250 implementation.
> 
> Include the unsupported-table check in the helper and preserve the existing
> nearest-lower selection and highest-encoding fallback.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


