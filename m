Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3C3FB7EF;
	Fri,  8 May 2026 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253718; cv=none; b=NMDveR3OE3hpZo2o2w3GIBTaFzDVHL42t0zqT17JC6suPpqmPWZPykahNKqNrwG9xWhU9tBiNmA+VdEtVD5yblmtEVZBGe4nDRyMWNE3xTnDUWbm4rC19l6mdF0RtX0QfxE7jYK3lYK9GvtWMLJ7mBH9V+FeZ/ai26BudU9RIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253718; c=relaxed/simple;
	bh=1Ts4kYseduboKsIUf+lbfxpxNyozd7l4VzIGUhH5GtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTWFAGYSemuR6b/eCYjhY+C8u/G/tpQvdxilgp40D6hxSUGLVIP7pRWqSgECmup4QJMRQWGI6lz+Y7tmFBtj46AhP9ZWINaVcPA6DAF2odSaU7rEUGseHVzOvQdk9Ih4/AsoeV1fZmfyXqLMqftD2pLU3+lwS8VKNhG2SKcVAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RMuxdTE4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RMuxdTE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD1FC2BCB0;
	Fri,  8 May 2026 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778253717;
	bh=1Ts4kYseduboKsIUf+lbfxpxNyozd7l4VzIGUhH5GtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMuxdTE4WdGdY6Ms3G75+5Sd9Tz5kXTHmCAaeFF0rc8SarwZ518vkkKQvKxRCghL6
	 IfPkgpWWQZT9JrkkB96zVRVHyPUY3/PgCXNJoPWZMsGqvZQ4StDzboAaxQdW9/J2TQ
	 z9DBrjpW4suhPA+lRu5CSJFgXGstEDuWf0teBuKk=
Date: Fri, 8 May 2026 17:21:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: ilpo.jarvinen@linux.intel.com, stable@vger.kernel.org,
	linux-serial@vger.kernel.org, andriy.shevchenko@linux.intel.com,
	chris.friesen@windriver.com
Subject: Re: [REQUEST] Backport 8250_dw BUSY deassert series to 6.12.y stable
Message-ID: <2026050837-criteria-occupant-c6ec@gregkh>
References: <20260508151614.498810-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508151614.498810-1-ionut.nechita@windriver.com>

On Fri, May 08, 2026 at 06:16:14PM +0300, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> Hi Ilpo, Greg,
> 
> We're running kernel 6.12 (LTS) on production systems with DesignWare
> 8250 UARTs and are hitting the BUSY assertion issue that your recent
> series addresses in 6.18:
> 
>   Ilpo Järvinen (7):
>     serial: 8250: Protect LCR write in shutdown
>     serial: 8250_dw: Avoid unnecessary LCR writes
>     serial: 8250: Add serial8250_handle_irq_locked()
>     serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
>     serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
>     serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART BUSY
>     serial: 8250_dw: Ensure BUSY is deasserted
> 
> Patch 7/7 has Cc: stable, but it depends on patches 1-6 for the new
> infrastructure (serial8250_handle_irq_locked(), the reworked locking in
> dw8250_handle_irq(), etc.).
> 
> Could the full series be nominated for 6.12.y stable backport?  Or if
> that's too invasive for stable, could you advise on the minimal subset
> that would allow patch 7 to apply cleanly on 6.12?

Why not just move to 6.18.y instead if you have this issue?

thanks,

greg k-h
