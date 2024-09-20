Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD52D482CD;
	Fri, 20 Sep 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841941; cv=none; b=O4acuSTuzTDsXD3KYI/Zf0zRVRpUq8bHd+v8CbRs5AQ9lck4P7xY4d9SywGqcT3rMYlKYaULzPyLc0zUFdQrFrqu0Q+0vb6cAcygUMgCb/BwPfO1R/P8JRAZFEDduaMCQ64y8xFOtLb5lk1HYYv1cDrU+4T0ZzpW6o6P7cif1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841941; c=relaxed/simple;
	bh=IXPUnzpp1w57YA1bQOgZXNfrvJ8JZ6uPN7NAZSoFc6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgyZFmS3O+oVw/fI8isVADA3k+oGFPy6lishM74mK5OfvUoJDuWeyhSqU448q8v2gSwP6VX2VLfmwHLVg7+VKWU43igDXiRIt5cfjVvQDhY2HiYrZucZOQVpBMfb7cR1umGgYvQAtRAwtLXyZ3gSoiiV9p3KR6B86JZ9T8UwKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAeLn8rK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAeLn8rK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726841940; x=1758377940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IXPUnzpp1w57YA1bQOgZXNfrvJ8JZ6uPN7NAZSoFc6Y=;
  b=iAeLn8rKHdxIWhsaCyzA67Al8h/HHlv9D6hmowlJYQSMinuB4+ZAk7k7
   6v1+eZYqJ9vAJ0NK00UTX+oVsk7Yvx5PDjQLhODwHSNY6pk5hQXHyQ3MV
   3gmbUJo1+hlgaerikt24WDWSLxNc5TWdhV+NVklyn3d6pd/gRbVQp6y68
   Sy9tTtpySjOwRQqu08anVdnl139ApQOKPsNPcEoYdMesQ//zBp+1/17YL
   xsYmnHNv/B019w4AZKHn/yvLuHthZzT3UkVBS8d1gdyhV8XsptTOZWa9c
   y5MupzoYqTfi3jtDawkvWKxJYXyIHtPZ9UJDXcuo9c78QgESC7cicNL9s
   A==;
X-CSE-ConnectionGUID: 3j1WGb7UQVOzdOiCHaq/dA==
X-CSE-MsgGUID: Z4BY+kqbSma+NfLHwIyAuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="13609042"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="13609042"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:18:59 -0700
X-CSE-ConnectionGUID: mQoxdzwdSn2iP3NaOtHc2A==
X-CSE-MsgGUID: D6NvOD3NSvSIg7wqGvJOnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="101049845"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:18:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sreTE-0000000Aw3C-2O5A;
	Fri, 20 Sep 2024 17:18:52 +0300
Date: Fri, 20 Sep 2024 17:18:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yanteng Si <siyanteng@cqsoftware.com.cn>
Cc: linux@armlinux.org.uk, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	alan@linux.intel.com, bartosz.golaszewski@linaro.org, arnd@arndb.de,
	u.kleine-koenig@pengutronix.de, mengdewei@cqsoftware.com.cn,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, si.yanteng@linux.dev
Subject: Re: [PATCH] serial: clean up uart_info
Message-ID: <Zu2ETNl_IGcQGxqA@smile.fi.intel.com>
References: <20240920053423.1373354-1-siyanteng@cqsoftware.com.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920053423.1373354-1-siyanteng@cqsoftware.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 20, 2024 at 01:34:23PM +0800, Yanteng Si wrote:
> Since commit ebd2c8f6d2ec ("serial: kill off uart_info") has
> removed uart_info, the uart_info declaration looks lonely,
> let it go.

Confirmed.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


