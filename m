Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18E37A825;
	Tue, 21 Jul 2026 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621437; cv=none; b=YH6WeE9nfnAKOczvQp0f8m9n1FAHLTkOhyU8ND1UQ8PC0vntoLW5BbP5l6ZA2ygRJgeSg5Xmqm41UtuBsiqHrFlC1R67nUWFtS+UjIB4L9taIp5nQbrCIkzkI8VIReJET2abEnOfTYWFLKbhTTlOTc0OcJYUSZIumxYR5k/bz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621437; c=relaxed/simple;
	bh=9/372LVV9XJYqAIAnpj4XWVCBFq5yhJcs/WQbZphc5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOjY9GyKZESWsYCzxE5eXpk29GMU3/yx48AakejACWjgvT0lgH/leWdcWHC4ODMbcipG0DFBaKLOMJNvr/LENGL0CDEE/nbJSGPy5Ljuwq/sejb9h8h0MTyDbNTo9riJ6FFyArlhKGAdCyPX7/NKFWbzt8LvIifa7man4DhjWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE0FmcWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE0FmcWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBFB1F000E9;
	Tue, 21 Jul 2026 08:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784621435;
	bh=W4hbMQnB46wG1SNw4jOcw8NZbJbNKlp5kLpoFurs4z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oE0FmcWHdyt01lzqjKv+miEXI14UaDfhiEf8WW3/x1cW8NhDi+nCSH0e7dm4l/mI4
	 9dWffgSoJpA/fZXHaG7TcLsglvEdlHTYITk40O4zZMf36a7IRtIY+PhOvrBYN6lXKl
	 7LnHacTaqTQQ+iCH954OICG6Q9n3+vqjeutWrC+9ib/zXYD63llatjo5Xylrp5r7sa
	 /+wUWcFNhLc3dKb/bhi50uL592kgws388s3lg4HyyM+1dAFeIsmxRCw+y+kNOfjZlR
	 YAA14IUvDw1W1K3jVo7Cnaj1mumNkpEjKtKuMzB81qzKb02KKZOwRmnhNOAGLXXwgy
	 +1fSSHPpG2bjw==
Date: Tue, 21 Jul 2026 10:10:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: snps-dw-apb-uart: Add RV1106
 compatible
Message-ID: <20260721-honorable-mamba-of-order-fdf14e@quoll>
References: <20260714132035.v2.1.c1d92213393f49330ec14d0c670a802181b4fcbf@changeid>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714132035.v2.1.c1d92213393f49330ec14d0c670a802181b4fcbf@changeid>

On Tue, Jul 14, 2026 at 01:20:36PM -0600, Simon Glass wrote:
> Add the compatible for the UARTs of the Rockchip RV1106, which are
> compatible with the Synopsys DesignWare APB UART.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

