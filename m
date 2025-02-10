Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86A2F2E;
	Mon, 10 Feb 2025 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739168059; cv=none; b=CfzlrsRarSzWQe7Wamgj3PlmcE0b20sei0e/B4vX0ymc5fhHEByXSfzJqtcyh2MRC6ti4xdoFgv6UwrifxKh68s0As9IIH0J9LPIX6MiV3T4JmKWcjatvvf34HARyWEa+379oRdFawt6DXFP7fBZ5wVba9rMwui+w8U+bQkbnKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739168059; c=relaxed/simple;
	bh=sgpQW2xZOAgPtOCv8PBlrmcFUZoKPzCKjY4Aq3Kj7II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVOtUxSkIPQBOTYoMnSxfQa1x3q1+2iWoAPHNuIknWQOwKenHgCKz44JvV5zqI0rlf80tEAp4Z6L6e4Uvup5QCsu8RyWhQy5akWd3gwFUOC0JT/xn7XXv5jnlP+k8JuUwH3h4Q6kO9kmJKoOHr/6B8fSlJ2d7DFVZFm4fX84oKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NNLIWuq8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NNLIWuq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9E3C4CED1;
	Mon, 10 Feb 2025 06:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739168059;
	bh=sgpQW2xZOAgPtOCv8PBlrmcFUZoKPzCKjY4Aq3Kj7II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNLIWuq8xUHWuxpuGhPwiGRhfXXK14TOBZLA+FbKFWxHFjThh+KCS2kIQYDm5WvD1
	 RdOCkzppavulFojBcP/1QTViH2pCKmPzxEJ0FWCLYozT6z+4OiGsjyQJfVbT71Cp7U
	 pqUteLqYFLTcJSv/qs1pIaI7rNgo7vd7kbMa8k0g=
Date: Mon, 10 Feb 2025 07:14:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	ansuelsmth@gmail.com, lorenzo@kernel.org
Subject: Re: [PATCH v4 0/2] Airoha UART support
Message-ID: <2025021019-overtake-elk-e644@gregkh>
References: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>

On Sun, Feb 09, 2025 at 10:02:39PM +0100, Benjamin Larsson wrote:
> The Airoha familty of SoCs have a UART hardware that is 16550-compatible
> with the exception of the baud rate settings.
> 
> This patch implements code for calculating the baud rate for the Airoha
> UART and HSUART.
> 
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> ---
> Changes in v4:
> - Removed COMPILE_TEST from Kconfig

No, please don't do that.

> - Removed Kconfig option to build as module

No do that, you want your code as a module so that it can work in a
system that is built as a "generic system image" that does not force
your driver to be built into the main kernel image, wasting memory if
the hardware is not present.

thanks,

greg k-h
