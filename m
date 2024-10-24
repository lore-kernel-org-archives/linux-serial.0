Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A817333D;
	Thu, 24 Oct 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754300; cv=none; b=VO1WXqrSnreFEeORDcFkTdKOfj8bj9JcQUpppXjDisyZ2sr1g5My8nk670FHy0kAARclxWM5vTsGpJjuVGlfgv/gOesXV++KeKAz1z624+20yfuK/FeBK0gZoGR1LYAx+vyLOSwPtHiX2yTVaKqMhVLedRw1HReSMunhe4lFAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754300; c=relaxed/simple;
	bh=6UeaeXS83H3EfjYnXzNkQfOq8oJCVfd9ifItcwzCAj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8fn8SMH5mwcasyTaQpeuTXdjAMYpssxyaOohHJQrN73Dn8u0NU7XuJdAT3r2w15YVw14ZhhbAQTxXBtS65oaUfASQ99zv0MHnCLJ5Ma0f0/nMzcyJsKodjtwdknSPHNgyej5HwQh2y3+V9s072O7yHpcpJ/fi7mGthABmlV+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCiNa24/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCiNa24/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFF5C4CEC7;
	Thu, 24 Oct 2024 07:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729754299;
	bh=6UeaeXS83H3EfjYnXzNkQfOq8oJCVfd9ifItcwzCAj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCiNa24/tWOebxWaLUf8m69aJlzWRi06GEBUSgAYJLJUTw0g9SFc8Ank1fertoh7k
	 ZvC86ViDuMdrRu3mWjNNCkqrBZQH6a/dkqcV1P0i2jtyIcpg3lvLZfu4uDyWSxmfO+
	 lV/ge+bD1u2qOcCqgCFJRlj8he4M2dpMWzNnXOQwznAF3ViQhOm44TtVeVXaX7Rabg
	 FRY1TNWG7GpFxaHoRcE9qxLlq7jrxIj4rrN8cg5Qez5TOI3IIjqiJ5H1WcMam4Rwom
	 FnwN29Z7bHrAVtmOk6SX3fRTUSVxQUblfn80SBt1rE5huvZxOQtKE5xk4+jMDq2tMD
	 mQE3Xk55cevAA==
Date: Thu, 24 Oct 2024 09:18:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo
 SG2044 uarts
Message-ID: <jm2t45wnp4gp7mxdz75rd3wszqnfnqjvw67p4wjq2hodatrdwd@6o4spqafmu55>
References: <20241024062105.782330-1-inochiama@gmail.com>
 <20241024062105.782330-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024062105.782330-3-inochiama@gmail.com>

On Thu, Oct 24, 2024 at 02:21:02PM +0800, Inochi Amaoto wrote:
> The UART of SG2044 is modified version of the standard Synopsys
> DesignWare UART. The UART on SG2044 relys on the internal divisor
> and can not set right clock rate for the common bitrates.
> 
> Add compatibles string for the Sophgo SG2044 uarts.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

