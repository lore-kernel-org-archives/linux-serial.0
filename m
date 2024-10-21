Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8744E1E201F;
	Mon, 21 Oct 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499358; cv=none; b=bSjsQny2UANpmmNeJWJxHINrLZAN7sUBpxhr82e1YUZzw3l9lf3kp3z0pTCAvGPxpxKun01q2BlLeWHPwgEi49SIVkUoFulnBxBdf6FroYWMleEk1pzmGNUxOAPQY/nSN2KUAiegscii6dl3jnnOfFykyPxul/ImveLD4ppYatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499358; c=relaxed/simple;
	bh=/zePlugoobNxm+sBHhUrdXCSLuE+lS4wRijxDZIkJbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0m9usQb+cIim2ueHt5O9mNf8XXSTBMGgE4xeXkiYxqI1+doH+RWJmNZDgTT5vcKIGM/R+iDAp6z8MU6s2xBpPa2LGaiRiBS+xMGt2dNkHI/RSN639prNiCmA+A8cbo9kSo2JS5DMY8oFNDPUqynwmOexxVgIiqrtUqFyKlu/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZ01roiN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZ01roiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729499356; x=1761035356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/zePlugoobNxm+sBHhUrdXCSLuE+lS4wRijxDZIkJbQ=;
  b=OZ01roiNB53qJ7WEBlqWCiKuuZhZnVNYm3+4PrM1oxxTEW183tBPMvTz
   zZmJHdBZn5kszGxcCtIItflzy0MH923lWu0G8+WrPTacYsMYFi5qTs37U
   YaA0/eGSBQ2u2nL0a+gX1EzbaV/BWb8g6WKJXIXYtwnSDj5y5m9eoXy1P
   +loNY7feaMic/sMipB9+N7moOzaYbkSiF5TrdODToBaZBGsGrB0T9Ajuw
   0rh1Z5hunTQl4y+lpzQ1ba/NTGdp/L2HrSdPe6PrHMZ6XMdfIbcVooGyW
   xv04wy6gkuDbBKbxrHuJygSHbEZousA8PAIIkIfgF8yiwIKgPW3gnIsEo
   Q==;
X-CSE-ConnectionGUID: GAf9m35PSCed3FU9eYa/tw==
X-CSE-MsgGUID: GZ2y97meT3a//IA2zWGyQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="29181708"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="29181708"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:29:15 -0700
X-CSE-ConnectionGUID: YErJoinJQ4aG2lyxkEghjg==
X-CSE-MsgGUID: 5NSCvMZRTjCnP+C+W3NSiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79052574"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:29:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t2nmn-00000005QWt-0eGk;
	Mon, 21 Oct 2024 11:29:09 +0300
Date: Mon, 21 Oct 2024 11:29:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>, Yixun Lan <dlan@gentoo.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: Add Sophgo SG2044 quirk
Message-ID: <ZxYQ1FKtloHPnjb_@smile.fi.intel.com>
References: <20241021072606.585878-1-inochiama@gmail.com>
 <20241021072606.585878-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021072606.585878-3-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 21, 2024 at 03:26:06PM +0800, Inochi Amaoto wrote:
> SG2044 relys on an internal divisor when calculating bitrate, which
> means a wrong clock for the most common bitrates. So add a quirk for
> this uart device to skip the set rate call and only relys on the
> internal UART divisor.

Assuming DT bindings are okay,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


