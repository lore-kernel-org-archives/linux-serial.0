Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ECBCA4E;
	Sun,  8 Mar 2026 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772979377; cv=none; b=T5YYp/qGxq/dQUsOCtusGSGHWIR8lEYF/euIKG//vCOZIqumD7AP452GbW9Vu0rvwdX/Q+Tj3lHamepxXKMF/6GbWdxnq9CbTMwO8i03+IGzYb9wzFB4r82QHMLVtpiMlV0ioJVIRlOL5qpwnEwe+VUbvdfp/3qz3TDoA0346TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772979377; c=relaxed/simple;
	bh=IqBeFl/EJ4lS4GvTQGTHlzzIz15G3xY/I2F3K22XmpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXAbjGJZWrdIt9lLHY6Zzp6E2ykhyDiqpuYKHxFjFS3vLE1P6M7aNMZ8g/SEZHnMqTvwCVvCRPQsh7sc8KkiHGPsXsFK6F/12Z5xzVKMmNJw7YtlGdL1OZUysQnx5XkDQGRvLCqd0rUENypmQyedc0LkOPmC1q3dhrRCQaVLP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pHvZdSX3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pHvZdSX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ABAC116C6;
	Sun,  8 Mar 2026 14:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772979376;
	bh=IqBeFl/EJ4lS4GvTQGTHlzzIz15G3xY/I2F3K22XmpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHvZdSX3NRPLH6SEOWffdsu8SL8HPsmpwYfcVMK7GIcASajSYlB/xJetc80OANTmy
	 VL8cR8zgioAUqDVQ0vK9ZFjjMtK10qCaPtvUzD1oKCY1VILretngPISWlllO1hN7BB
	 o3rqOmrTYMft/GW+9vBIwU5TERW8fyNMVi4yVKJU=
Date: Sun, 8 Mar 2026 15:16:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: jcmvbkbc@gmail.com, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	jirislaby@kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/tty/serial: move ESP32 UART drivers into staging
Message-ID: <2026030845-chastise-briskness-3317@gregkh>
References: <20260308131412.1102749-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308131412.1102749-1-julianbraha@gmail.com>

On Sun, Mar 08, 2026 at 01:14:12PM +0000, Julian Braha wrote:
> These drivers were added about 3 years ago, and depend on the
> XTENSA_PLATFORM_ESP32 config option which has never existed,
> so no device can actually use them.
> They can only be compiled with COMPILE_TEST.
> 
> As you can see, this config option is still undefined
> in the downstream tree:
> https://github.com/search?q=repo%3Ajcmvbkbc%2Flinux-xtensa%20XTENSA_PLATFORM_ESP32&type=code
> 
> I propose moving these drivers into staging
> until there is a device that can boot the mainline kernel and use them.

Why not just delete them?  What can staging do to help out here?  If
these can't be built, or used, don't drop them in staging, that's not
what that part of the kernel is for, sorry.

thanks,

greg k-h
