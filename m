Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B823AB88;
	Sun, 11 Jan 2026 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768127195; cv=none; b=gUsMDNExMcPGRMrBUqoBZlC3jJfhd9usmvf3w2rz8UYIcdopoubFOcubIYNMsOmvqyX/vOzqt2fhIB/OEzH8nXVdcfqqgT/jp8c2VEU4Hovsu9GFFO4bI7AKa5/McFx5WYXeFgg8otlTWoUsNpJhT3W21Q8xn3H/7fdGr9tKdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768127195; c=relaxed/simple;
	bh=4sjlRsRXnCiU1+Vn2EpRzWnXPIuxu1JKKXUgm2mFkCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS05jDY8aUi8Kuh0GcLEzUAkwtccbKxIGnj288bGMMFhzPhYiidgz6Xo2CIsZzYeZ/FpXsb926vJb7NmRVSrN7WsHWuYc7KEXXskEgo89ZTPCmTuXTF2kOZzSi3liQaK68yiA8J9jyem47GhITL0rpSM5hWxhzxa0jtzFqKhwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RaPcsb/f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RaPcsb/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5FEC4CEF7;
	Sun, 11 Jan 2026 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768127194;
	bh=4sjlRsRXnCiU1+Vn2EpRzWnXPIuxu1JKKXUgm2mFkCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RaPcsb/fYzLWxjEPVkto0vT0zS0pVocR+zXrskrkcAj185oyuHU1xeAKXubup7bxs
	 ygspoQ9W1x/iQdp4K+P9OWb6ZeZd5lhgnO60RrKtJPWFEn8ImVJVBKModGC949B9L+
	 wjG7AMzLoFVN+lIb3t506+br0jq4jz5ncOxNTjac=
Date: Sun, 11 Jan 2026 11:26:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: replace use of system_unbound_wq with system_dfl_wq
Message-ID: <2026011107--0bfc@gregkh>
References: <20251104105446.110884-1-marco.crivellari@suse.com>
 <CAAofZF6DCmHnpT8mNGiYRJdeQc9yBooRf=N+WVEw371-ZP06Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAofZF6DCmHnpT8mNGiYRJdeQc9yBooRf=N+WVEw371-ZP06Zw@mail.gmail.com>

On Wed, Dec 24, 2025 at 03:54:01PM +0100, Marco Crivellari wrote:
> On Tue, Nov 4, 2025 at 11:54 AM Marco Crivellari
> <marco.crivellari@suse.com> wrote:
> >  drivers/tty/serial/8250/8250_dw.c | 4 ++--
> >  drivers/tty/tty_buffer.c          | 8 ++++----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> Gentle ping.

This isn't in my queue anymore, are you sure I didn't apply it (sorry,
don't have access to my devel tree at the moment...)

if not, can you resend it?

thanks,

greg k-h
