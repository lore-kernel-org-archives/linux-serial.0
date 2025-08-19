Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7612FC87B
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628339; cv=none; b=GnEaksEQDNAU7DjBeMO6ffBT5NWfB6ydCzXRTzR5e691TImHy0XTh20468iOh1gdx2PaawbhJ/eeusMH/ItcVMkO9242e1K8MKtM2Y/XSVHw+e9xNXVsX5PRH37xPJyQZc/LYAkepf6r8pktJVP5+nXAj/hvQF37P8RZEZnGuIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628339; c=relaxed/simple;
	bh=RdRpq9Mw9CzM9hJ57LoBYpV3yrgL/3d1PQ3GAfOx5rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV+XnD1b1UPI0DxylLuTVtZ19qs1+r0x38ltiJddyfyn1ri7PDLfHdHUEMokjwPVBe+MXzVxWkTzsNW0FrRZsSm7QE22inrB01ZWEBzjODlPUL0wcxG0svX4T9DVcGCtJDe4yeMqaSAu4tlLF99+yzZ0yi7tdO70C4o4TqeYfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJcZukec; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJcZukec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C723C4CEF1;
	Tue, 19 Aug 2025 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755628336;
	bh=RdRpq9Mw9CzM9hJ57LoBYpV3yrgL/3d1PQ3GAfOx5rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJcZukecJz6AfW8a1rZtJZsa7aW6/g+PWOgv9EXjCz0CfoSDyCUqmxJx5HDItI0FZ
	 uzyrwiAEEoEQdFjJjyHQqbAKWeqwHv58sKo+mYDijorGTckIhFBEOkbOMjWNW1hDRa
	 6U/pU/LyFl3QcRO3QCfKI58fuVmTGzMTYThru884=
Date: Tue, 19 Aug 2025 20:32:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: adriana@arista.com
Cc: linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com, prasad@arista.com
Subject: Re: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
Message-ID: <2025081925-polish-cornstalk-32ab@gregkh>
References: <20250819182322.3451959-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819182322.3451959-1-adriana@arista.com>

On Tue, Aug 19, 2025 at 11:23:22AM -0700, adriana@arista.com wrote:
> This patch is proposing a custom configuration for Synopsys DesignWare
> serial to be used by products with associated compatible string in the
> device tree.

Any reason why you are ignoring the maintainer list that
scripts/get_maintainer.pl spits out?

thanks,

greg k-h
