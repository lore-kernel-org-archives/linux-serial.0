Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A137BE6B;
	Thu, 30 Jul 2026 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428404; cv=none; b=a2D7KhKPuggBQDINns3+C4tdBhWo9l7e+VcVDEUtSecrd8zHPHf4BnFVXHfa4fQYr0ExSxZfDgJhPnfVqMma2Mi2CDSUtaPgfYBjbsPYgJCsXhk0o8vtd79gf0y++y2A1qUvN4VxJvQLjpHcFZWBl3dkR+uO50Ulsq6pinTLxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428404; c=relaxed/simple;
	bh=jcZeaLfQ6zD+vXftAwGPX8QEZqx6VpMY4dOCeGCp82c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Idsyc/rzN//FhKcvmbXdMfyXvNI9u1xPEmVKdGz7NKwvAmngH8Sr1AfL+Sf24/2/hwLUusOkmst+du16wniSZdFzLzpCUe9dDh3KE31Bn4lxcmrlUuChAd35qTgrOEHB093lVx3MznrBr7MctxgrViNvORpZvjTyRpuYTwV/oGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QIoJlxxL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QIoJlxxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C6F1F000E9;
	Thu, 30 Jul 2026 16:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428403;
	bh=KPToJt+Qzhvwimh4jr2kFhz5PbYNSzFusVg510y0Xbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QIoJlxxLKILj0w816NBmrWQ8aD6ErNrHo8joIY7r9xhKWjtb7e7FLJUskS538c4PI
	 +wOeb/0qOwtYnLB+wlOJpHM93RRI1K0IBmHg3EIRGfZp9NiH8YZm8F1jfM3PrFQm7H
	 2tjAFBC+PejedQMOoM0sjq4rUx9hvsrM4GThWF3w=
Date: Thu, 30 Jul 2026 16:47:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: remove always included kconfig.h
Message-ID: <2026073034-unbroken-busload-f0cf@gregkh>
References: <20260721144847.3728422-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721144847.3728422-1-hugo@hugovil.com>

On Tue, Jul 21, 2026 at 10:48:32AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The inclusion of <linux/kconfig.h> in commit 7ab80d1e72431 ("serial: 8250:
> fix compile error with hub6_match_port() when compiled as a module") is
> unneeded as it's guaranteed by the build starting from commit 2a11c8ea20bf
> ("kconfig: Introduce IS_ENABLED(), IS_BUILTIN() and IS_MODULE()").
> Remove it here.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> Maybe this could be merged with commit 7ab80d1e72431 ("serial: 8250: fix
> compile error with hub6_match_port() when compiled as a module") since it
> is, for now, only in tty-testing?

It's now in tty-next, so I'll just apply this, thanks!

greg k-h
