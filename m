Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F41211A26;
	Tue,  4 Feb 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676721; cv=none; b=q/UdofPnHXlFTK57gA91qC/oZO3eYYAhDb8eZTWFFgRcotoNUkNMOxPR6T3Uv19BDtq9UO8IYQejEv7xnBT/UyeOqRh3S1HUlbO2dbL7eaH8YaY09obUhw6L2I+YiwraoSHO3em5YliONpIC5zaPjSDyikehgoB9TSb3ySMWkLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676721; c=relaxed/simple;
	bh=13HGikhPbkBWchqHLScoYyLGaKpaMPUrmDdVvIj6fC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYl7jg1VQfGLCTplW95uUum81LvyOiumkP7oAy1dA64t/uxpeN1qwHRL+3Mn5HvoZGcduppbNyjhKUD9v4aJbnlsVR2WPDAyk16pb3vH2V99z6uCdW/8R07OKo7g1sthpyVOjmsmDOO0DhT4I6DCZt9S8HCauIJ36p0jHaBpqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BFWy9F0T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BFWy9F0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D944C4CEDF;
	Tue,  4 Feb 2025 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738676720;
	bh=13HGikhPbkBWchqHLScoYyLGaKpaMPUrmDdVvIj6fC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFWy9F0TdE3eNkun6pXQPB6zg539uAhgK8Gg0qUP2gBtm5aNDJzhNONHJWXudgE7t
	 0K8XCq46pIUfTtKD2LjCv3C1YSokfL4U5z4nJ33A2Nsi7WUbgicdJ6ob+U3khEpu5K
	 u7tskCpCSsbkxnRwWj373qyJZx09/c7Yrs95QU7A=
Date: Tue, 4 Feb 2025 14:45:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Guanbing Huang <albanhuang@tencent.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/6] serial: port: Assign ->iotype correctly when
 ->iobase is set
Message-ID: <2025020459-shelf-wanted-1349@gregkh>
References: <20250124161530.398361-1-andriy.shevchenko@linux.intel.com>
 <20250124161530.398361-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124161530.398361-2-andriy.shevchenko@linux.intel.com>

On Fri, Jan 24, 2025 at 06:10:46PM +0200, Andy Shevchenko wrote:
> Currently the ->iotype is always assigned to the UPIO_MEM when
> the respective property is not found. However, this will not
> support the cases when user wants to have UPIO_PORT to be set
> or preserved.  Support this scenario by checking ->iobase value
> and default the ->iotype respectively.
> 
> Fixes: 1117a6fdc7c1 ("serial: 8250_of: Switch to use uart_read_port_properties()")
> Fixes: e894b6005dce ("serial: port: Introduce a common helper to read properties")

You forgot the cc: stable lines.  I'll go add them in, but be more
careful next time please.

thanks,

greg k-h
