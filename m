Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32D1FC7F7;
	Thu, 20 Feb 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062383; cv=none; b=KVebsYfpesXwdsdujQq45zpRoDU7BGDBtcfEAkeQa/b7aaYczTxQ9jp5VixXxPM5jmW+IgUqkujW6xoXJsKwDDmRtLwocyjUMQJxD/bYDECY6Sh4z2G1Jbt7JiO9Enn7muiQ/J78n10GKXHD+4JnfQJRIMXdMeFkKhiRyh1UQXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062383; c=relaxed/simple;
	bh=1LKdPwjEyhWLYIelpzALC3HYu2XbKwz8JQ2qvcNVomc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEtD6DcUTMsHQuTcEXQHd8G8s8TL9i/ALAVBXtWc8dx3hfWBQgkNaS1dhHMRB16192yjQNbjvmFjcvy/Q8Iuqpsukrmi3X81C7Pk2uuzDUPSvmh95nGxXmr5JI8nK/ulp23VWP552h034AMNlblSH2hSTGCEPQDDdDOiZB62JnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X7438IKv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X7438IKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FCAC4CED1;
	Thu, 20 Feb 2025 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740062383;
	bh=1LKdPwjEyhWLYIelpzALC3HYu2XbKwz8JQ2qvcNVomc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7438IKvi0a1iUnPvD8iwTdIM4xZM8RWtZ7THG08xYI2/hZhZpMXAONXmFcykrL6V
	 xshXF4u5A0+U8kUUf+OH5d/NYHbk/Xj2t46piXlnGVSSfb9O0TYuTbfsv4cUgfc7ly
	 WnKdCWLZdq4nrbgGDsCRMlX4h3kZOdJsF50t7/w4=
Date: Thu, 20 Feb 2025 15:39:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 26/29] serial: 8250: use serial_in/out() helpers
Message-ID: <2025022032-movie-citation-b267@gregkh>
References: <20250220111606.138045-1-jirislaby@kernel.org>
 <20250220111606.138045-27-jirislaby@kernel.org>
 <Z7cfvXUCHXVXK_mp@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7cfvXUCHXVXK_mp@smile.fi.intel.com>

On Thu, Feb 20, 2025 at 02:27:41PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 20, 2025 at 12:16:03PM +0100, Jiri Slaby (SUSE) wrote:
> > There are serial_in/out() helpers to be used instead of direct
> > p->serial_in/out(). Use them in various 8250 drivers.
> 
> Is this just a mechanical (compile-only) conversion?
> IIRC 8250 DW code is twisted in some cases and it might
> be a possibility of dead loops, but I don't remember it
> by heart and haven't checked myself before writing this
> reply.
> 
> TL;DR: this needs a thorough review.

Wonderful, are you going to do it?  :)
