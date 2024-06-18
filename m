Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1633FD;
	Tue, 18 Jun 2024 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718689094; cv=none; b=T99rRe0uxmk/MK7EnNlytSEEcb53b4Wzu8ovr7h9LXVV9+bbcUiD5UXRyk+t+TcWch5UomksZ22igfisXB86tcQRW0C/VbnXKddQj67a4wEaCH/fhfDav/NsAxjZVzf27voZcvwR+LsFmm7JuA2UnYqG5XRqJJcgriKfCXe+3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718689094; c=relaxed/simple;
	bh=ohYgG94vVqkwT1SOSVEe1M+1W9x5uMN9lI20nJGX4+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntd4XQyE7u+XjO8TACwugqs/A0F6jsTU4H5z3f66CnaRO+63jqLlOh1HBCH0mzAGdYzM2LqOsFTSQkZfCeVG+zsXbBJ6pXjVIlWJiv2uw+SPpeTUk3GgH62B4iozPOyNTSSrnQazRyoXxdw5FhxIZiA++eFMJ+mqF+YxLU49/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aqAW9+7O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aqAW9+7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65127C3277B;
	Tue, 18 Jun 2024 05:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718689094;
	bh=ohYgG94vVqkwT1SOSVEe1M+1W9x5uMN9lI20nJGX4+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqAW9+7OEqhEbrS1DMPWUOV8Y3JQ/a9DnjOrJbPX2B9Eu3GUcXN/NvJV+R5VoU01n
	 rdyS1rT0+hG9kPFl9cJ1PbdI5hhCwQmRD60CCmYXojtn4L3fZuj1bb1Hu5Wyo0zeLt
	 PHfKULGK/8wzEN2vYR1tEnu0RToNi9toA/2/cT4E=
Date: Tue, 18 Jun 2024 07:38:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Rename preferred console handling
 for match and update
Message-ID: <2024061803-sermon-refund-d2a6@gregkh>
References: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
 <20240618045458.14731-4-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618045458.14731-4-tony.lindgren@linux.intel.com>

On Tue, Jun 18, 2024 at 07:54:50AM +0300, Tony Lindgren wrote:
> We are now matching and updating the preferred console, not adding it.
> Let's update the naming accordingly to avoid confusion.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
