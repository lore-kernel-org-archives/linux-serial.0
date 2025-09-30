Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6222EE5;
	Tue, 30 Sep 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217675; cv=none; b=f4gUa8KgFRb1u++thK2GnwhcVBoX/en1rNWsdqyojqHHA8C0gRvs15Bc9KrLwm/H53Knas6V5WuYZy44gzuDSN+BRGyiQfG1zgE9dmrxSpW8PJxK2HCR3PEyUdS3OPNYpPEiyxMB01mbLJL87ECv3jQvk1HlFx4tcxcC32pk9Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217675; c=relaxed/simple;
	bh=Pw3oLp5PNPEd234wqKJBXeXn612o8IuJm/a2sdRpClc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ju1mfxynNRvO3/iYBZ4MXeiGlT5uatrlDrWAD2RakXnEfHXdKBk2NPGFQvv0AvmyQJf+pe2Ifgpks/RreHcSepRP+4kP1a1kLFIF+O8CIoJTuMQLKYFpJ5cwPozWoyChD46TuHL/oMuK40Ca3g4TuNi2aR2bitT71AW77VdwhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JH2baIFa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JH2baIFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E85C113D0;
	Tue, 30 Sep 2025 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759217674;
	bh=Pw3oLp5PNPEd234wqKJBXeXn612o8IuJm/a2sdRpClc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JH2baIFaMmhWWyAMLV8biZbLDt+ez+oHxm8wEaXnuR7NqVQ0zOxw9XetNqTsG83hy
	 xBP7E26juhAvt70F0avHcyA6wyHm0TcKhQrh1vo3htuKYnlUaceysRzNs8g9YIFCtE
	 TgDPsES0qe6NeLwXRd9qpa6ElPrJC143B1lpRhLpdRzHv0lpnMbPLfu88j3Pt6LAQ/
	 WTHjVoBE0M3AcTxj61tzNLjtOEDGIyxIjBNxx5XYEJGQmdOywe1EECRbe16tNYj/18
	 RAS/YO8ULaMolEmkGHCblQTwY3xbr72NWcKcB8OGmARvegPZFo9+9pYAv3wcLWQbqT
	 o37AAjgQPHB1w==
Message-ID: <f6fe95e5-0dd3-4ce0-b741-06cacf283e4c@kernel.org>
Date: Tue, 30 Sep 2025 09:34:30 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: 8250_pcilib: Replace deprecated PCI functions
To: Florian Eckert <fe@dev.tdt.de>, gregkh@linuxfoundation.org,
 kumaravel.thiagarajan@microchip.com, andriy.shevchenko@linux.intel.com,
 pnewman@connecttech.com, angelogioacchino.delregno@collabora.com,
 peterz@infradead.org, yujiaoliang@vivo.com, arnd@kernel.org,
 cang1@live.co.uk, macro@orcam.me.uk, schnelle@linux.ibm.com,
 Eckert.Florian@googlemail.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250930072743.791580-1-fe@dev.tdt.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250930072743.791580-1-fe@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30. 09. 25, 9:27, Florian Eckert wrote:
> When the '8250_exar' module is loaded into the kernel, a kernel trace
> with 'WARN_ON(legacy_iomap_table[bar])' is dumped to the console,
> because the old pci table mapping is still used in '8250_pcilib'.
> 
> The old function have been deprecated in commit e354bb84a4c1 ("PCI:
> Deprecate pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> The remapping already takes or must take place in the driver that calls
> the function 'serial8250_pci_setup_port()'. The remapping should only be
> called once via 'pcim_iomap()'. Therefore the remapping moved to the
> caller of 'serial8250_pci_setup_port()'.
> 
> To replace the outdated/legacy iomap_table processing in '8250_pcilib' the
> function signature of 'serial8250_pci_setup_port()' has been extended with
> an already iomapped address value. So this can be used directly without
> io mapping again.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
> 
> v2:
> * The function 'pcim_iomap()' returns a NULL pointer in the event of an
>    error, so error handling has been adjusted.

LGTM now.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


-- 
js
suse labs
