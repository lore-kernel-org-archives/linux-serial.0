Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478670;
	b=fdgjHL3B5zKjwmM3KlF+Us4KZq78Sn9qVo5oQPYdw04l1XRKofVAsOey9OmWMz43hNes
	 CwSflXmSDqMVB0TU94GSTovhGN3YJdFt7pKlmQEeoJIYEfL2ZDsDz0At3yj4SruDnHB3n
	 JCrfma/T1CGBLpjUi4OTKoroUXX5WXkvtL0aljOCZph+W6RML/OOHJjDYWmag8f2+hWfa
	 3JuIUkqkCXYZx6epvmNm1ABetAIXJSHw41QbDA/18ekL0camdi29oFLGUAohI17gkwtJh
	 mH3ax8eSF1mL1eRJSn5CxXezhVBWpMji+4AkKKTNcHDwyMRRLKnPDrNULzYROpcq9AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478670;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xOaXH4PEGmhU3k2OJSZ6CM7Z/muRblvptuHyGveShks=;
	b=bwGwtMn1OMqL0zfIJ4wYfny16M1W2B58p3qy3RBDhtQHyEOqZtiNrLDCbXakAwlfZMCG
	 XxCO2qPDnwbJjBn5bM5bwYxbsYnHa/KkZKqdKg9lS6uET4m9wYBmRrVLII2lVGzVN457A
	 IUTGvOtDHO8YFhZPJT/jXgCpXrNeRMrx5OiHckrgpW83wWZU4Hjd1a/AxnN+AoPDXOz24
	 hFSsp7b03IrsVikJ+n3PEMkA5gy25vVATsuAjc0cJq7UiBWCRzV3ODL8M3l79ONAUr2B4
	 vgMa44i9FhI5m54Wd6BLC+VsuxA+PhLeYWAL/plzAF/4XsbHqLW0vBQOI85d8xJaiOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xU8X59Xq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B43606A31A;
	Sat, 31 Oct 2026 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xU8X59Xq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AC71F000C1;
	Sat, 31 Oct 2026 20:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793478670;
	bh=xOaXH4PEGmhU3k2OJSZ6CM7Z/muRblvptuHyGveShks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=xU8X59XqFS9s9oMFP+Mmc4VXMicv9Ctg5b/6CRFpNACSy5sfp4YY/hbwrtCrYLinO
	 pDji2Wtwn3/ny/K6wbl7Enw8UqekxC65wexyyiTmkMCqRZHsahAQOugm4s45TMhMxy
	 gUqVsRzQKRRXg7DXYpQ4SwOxXoHgk6e119JZ9YNQ=
Date: Sat, 31 Oct 2026 21:28:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: tianci xie <xiex16070@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Samarth Narang <samarth.colleges@gmail.com>,
	linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] tty: serial: samsung: fix TX fifo underflow on flush
 race
Message-ID: <2026103142-shorten-shindig-bedc@gregkh>
References: <2026103122-repurpose-cost-2da7@gregkh>
 <20261031152656.1422-1-xiex16070@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031152656.1422-1-xiex16070@gmail.com>

On Sat, Oct 31, 2026 at 11:26:55PM +0800, tianci xie wrote:
> I do not have a Linux machine of my own.  The x86_64 build above was run
> on a rented Linux server, and the arm64 build was cross-compiled there
> with a no-libc aarch64 toolchain; that is as far as I can take testing
> without hardware.  There is no Exynos or Apple board available to me, so
> the model is what stands in for a runtime reproduction.  If you would
> rather have the flush modelled as a KUnit test in the tree, say so and I
> will send that instead.

Sorry, but stuff like this you are going to have to test on your own
system.  Why would you do linux kernel work without that?

greg k-h
