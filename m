Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B7E17333D;
	Thu, 24 Oct 2024 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754288; cv=none; b=umXf+EvfhuvAa4scDrJe7JMzku2R0fPV0x2nHD9NvKkIqXTntGM4aFTlis90zCzJOTvXFzSbpRok5GKycP7rsI1nDd7Z4XHBr8A43WA0b2V2RjDq3fq0dFp8fiSmEvGPU+CYSBbNqGN6/zpDl7Jaimtl14qyGw2u9PZ88Ct2kC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754288; c=relaxed/simple;
	bh=NL6t+0WOOqEim4x8DSe/Ot6FeYyEc1uFdXg1LzFfjjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOeaXlsxadNMRfhswvWhq1g7rVJ76jA3u16T9qAbH7ERZeG/Pz9VZuF6ZU98exD4AfbChf7BuM8FhgiaOP620fphBa99puzM/M9SVTLn29Edhs4KJzP4rzDjpdZ/mwp+dUTYnbPzrniqk6ZteBYicSP7Bmx1ni17qq7+6E8vwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmgrsvLA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmgrsvLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC15C4CEC7;
	Thu, 24 Oct 2024 07:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729754287;
	bh=NL6t+0WOOqEim4x8DSe/Ot6FeYyEc1uFdXg1LzFfjjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmgrsvLA5hthlAe2o0k13DsTM/azsKHeWqceOFTGlKXD0fU7gU1MeBBacEF7a0m2e
	 qrjneh8gFOQJv8WnlM2QwYBfux6PRlTRrf8K4O/syfSwa7UaHYQRXSxGMXMUvMwdR7
	 7YB4KTCtvG3U6ypm09plosqbhWhViFyW0B2pDwzkfeAUzvcSDzYdHCVzT36iavI0P6
	 U3Re8wfjvtIgkeWKA0KrR+9Y3DQ8EWysDDgwbe8ocehdWUFkJAENeRK3E8WgEhcVbv
	 fFjQ2xo3blwXzXe6LjlvUugCdMExSEZjIEGEHUwbZ+N4zK0IiqaK+WlFGbRVCLwLNS
	 9/XlVMRKYbCUw==
Date: Thu, 24 Oct 2024 09:18:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: serial: snps,dw-apb-uart: merge
 duplicate compatible entry.
Message-ID: <o7lhcbdw6ixqlkdies2tx42k6uoo7blbbeysdgs6fszitponqw@wq4cvv2vxjsc>
References: <20241024062105.782330-1-inochiama@gmail.com>
 <20241024062105.782330-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024062105.782330-2-inochiama@gmail.com>

On Thu, Oct 24, 2024 at 02:21:01PM +0800, Inochi Amaoto wrote:
> Each vendor have an items entry of its own compatible, It is needless
> and can be merged as it share the same base "snps,dw-apb-uart"
> compatible.
> 
> Merge the duplicate compatible entry into one item entry.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Suggested-by: Conor Dooley <conor@kernel.org>
> ---
>  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml   | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

