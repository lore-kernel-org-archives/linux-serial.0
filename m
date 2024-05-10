Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359FB12C54B;
	Fri, 10 May 2024 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346101; cv=none; b=nGz4IweJmTFjAu4121rRxmxPkHfSUfz1Fxtuxz1/bj4+8hPoUinOhgA+/dMUE6rXpCZOiVRFBbRF62NDQNoP0bwMPgkqTGUigyEmkSsujtLAier9gWQkFaopnn1Hc1q4Llp+IF4ofrVKRzzAxy6bSwTE4pZ7EB/uxdbqXzQG8AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346101; c=relaxed/simple;
	bh=njd3zUm5tRBduH0NHuwBDQT5jxTP3Aji7ivXBeqbQV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtA+Qh0cejcHb61KeE6hpDeU90kUiZgCk3sNA15mSpY7cgQ2kxmcKc/jRJGmn6NaMNZp9fbj8XbmAogL/dCiPrKZNzgSowkXs3L0cHWuxf9KgCVfKgt/kYc8SH7xEYqXqffqkaJ6R4GNbyn0rxCXk0q5Ar85ByDxGSCpdG1ms2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tty6s3a0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tty6s3a0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715346100; x=1746882100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=njd3zUm5tRBduH0NHuwBDQT5jxTP3Aji7ivXBeqbQV4=;
  b=Tty6s3a0L5y/BhDfzTtkGQemob2dJEKgxUD4RODVD+sePAv4Ff5FITBs
   AcHPw1aYyXJjodGZVyixymTnnORYmjjtxDMNHkfsWylpPhoH3XIgnI697
   1MW/qU8GR7PdopLI+tXGVwlogLfMqVDsrjvMhUDg3SKdxBwlwmFTpoggv
   F2FLAVhQetWorcGnY5UCAIBOaIVTN5Yq+Rum8DAr+wuuHmAk9AFKBtwim
   RTIGSlj/LQGzumtJLBWU61ZLIv6kdm7VRto3LE2dWNSROHoQNrLA40H6i
   Scqhtim4hrPqO2mPWEm+Y4jMxeOZbSirvffPmnz4NTqrQ8uyYsoyZOhyn
   w==;
X-CSE-ConnectionGUID: NkA43NSjQIqw3uLK66EOoQ==
X-CSE-MsgGUID: tog0ODRKS8iLRZGy5X1mqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15136361"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15136361"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:01:39 -0700
X-CSE-ConnectionGUID: ZAA2yO3yRUCp7wLNG7BJiw==
X-CSE-MsgGUID: 0yjpahTXSPaJw7mUL6Na7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="52819266"
Received: from bgurrier-mobl1.ger.corp.intel.com (HELO tlindgre-MOBL1) ([10.252.35.51])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:01:35 -0700
Date: Fri, 10 May 2024 16:01:22 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
	Weifeng Liu <weifeng.liu.z@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: Clear UPF_DEAD before calling
 tty_port_register_device_attr_serdev()
Message-ID: <Zj4aoqqsRq5A5Qvg@tlindgre-MOBL1>
References: <20240509141549.63704-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509141549.63704-1-hdegoede@redhat.com>

On Thu, May 09, 2024 at 04:15:49PM +0200, Hans de Goede wrote:
> If a serdev_device_driver is already loaded for a serdev_tty_port when it
> gets registered by tty_port_register_device_attr_serdev() then that
> driver's probe() method will be called immediately.
> 
> The serdev_device_driver's probe() method should then be able to call
> serdev_device_open() successfully, but because UPF_DEAD is still dead
> serdev_device_open() will fail with -ENXIO in this scenario:
> 
>   serdev_device_open()
>   ctrl->ops->open()	/* this callback being ttyport_open() */
>   tty->ops->open()	/* this callback being uart_open() */
>   tty_port_open()
>   port->ops->activate()	/* this callback being uart_port_activate() */
>   Find bit UPF_DEAD is set in uport->flags and fail with errno -ENXIO.
> 
> Fix this be clearing UPF_DEAD before tty_port_register_device_attr_serdev()

Looks OK to me:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
