Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1EE40C03;
	Sat,  4 May 2024 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714839040; cv=none; b=ZN/EcLySboh7j+bY+2ThQQ/WOO4VGc382GPnc3M8DBV86rGHJhN70RjpnL69SVYThaKUx26FoWsDJTzUSJGLHLxJV2MGHPY3pVKss6eP55bKrcatyTXfve5M6I0k56besuGIlaXiQ0miKn2PA6oIGmu7dnzz2CwUOjEH/cw51Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714839040; c=relaxed/simple;
	bh=VuPfx3OXc2YATbajz+aa7ONlNhqPwnL1gJRjSxvcFeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKQZhEwznKc1njMjzvzu88yik/C4PNyxw3g82YuuO4XZDhDuMwlVOKap8oosozn3LlgPAvX1oMsQvU5CGyfz+bjU62KWK3P9DyJLZgE35JCwrUr/eezRIZ5T1JIcBVRMhy1uFggEN6T8ucT2F9NKnkjTsatppUNQUYazXITg/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tFVWEOHM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tFVWEOHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ABBC072AA;
	Sat,  4 May 2024 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714839039;
	bh=VuPfx3OXc2YATbajz+aa7ONlNhqPwnL1gJRjSxvcFeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFVWEOHMLRl4NYynXslO2vR/2q/Jbh+fG6WKYMDWXIg09QRcCewcYnQguhq/AXqg1
	 w3TAuR0lanHakc6LS/4z+v5eD8sO38efj/o7i1KdVvdQ417MP8K0BSJNaSkVQAG5dv
	 M++InNvoduw1QenOiXzwAvXMmcmzgRWTLrB4pUy4=
Date: Sat, 4 May 2024 18:10:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/1] serial: 8250_pnp: Simplify "line" related code
Message-ID: <2024050421-daredevil-excess-3b96@gregkh>
References: <20240423134930.67033-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423134930.67033-1-ilpo.jarvinen@linux.intel.com>

On Tue, Apr 23, 2024 at 04:49:30PM +0300, Ilpo Järvinen wrote:
> 8250_pnp sets drvdata to line + 1 if the probe is successful. The users
> of drvdata are in remove, suspend and resume callbacks, none of which
> will be called if probe failed. The line acquired from drvdata can
> never be zero in those functions and the checks for that can be
> removed.
> 
> Eliminate also +/-1 step because all users of line subtract 1 from the
> value.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_pnp.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Doesn't apply to my tty-next branch, can you rebase and resend?

thanks,


greg k-h
