Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528092AEF5;
	Sun, 15 Mar 2026 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773565780; cv=none; b=fr6/XLZPBfNNO1ZsAmkT0a9zgqaoO1wIay1xSTc/27JP72xbgh6xS/iwq6j0yzh/asKBR8O68S7ReHnGnjh1CtkP6WVlPorJnqKxnUGcUREiUm4x4FdhbFO2Av3HJFu4WbocP+L3fnKULU8j2nJu8zYqStNd4y3LvlZ8TGxy5Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773565780; c=relaxed/simple;
	bh=ZIbwSNyXCHsWNZpwx80jaK1r2K54qgDpNHqrLdy6exo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0ljgDq2fFO7kkBJO7LRiRmdSYyp17MftuS/aZdM+krswjiXqYEtvPyLUkXk4WlmmrZ/oxFfLmm5YKGWJLJPOt/W8BtFUuQOIm83qKu9Y8skG29BWVB4GRCTpNrfFA9nmwbd8Ba/NAa3haKnhL70VIkAvmmRudqUiQQqlyNRp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snapgaNK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snapgaNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A243C4CEF7;
	Sun, 15 Mar 2026 09:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773565779;
	bh=ZIbwSNyXCHsWNZpwx80jaK1r2K54qgDpNHqrLdy6exo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snapgaNKcdcFVnSBCKmmBsbMKvEPvE1syrls0YnoEOSqz/sYV0SRuUpVlIhjl10Pt
	 p0NsZgGahsvVlIptsL8AgJWWB6rs2ysHHgCiXFOzu2Hh6ukCDDKnTjcRjU0wx4Q71V
	 6+iKqzJwICYxBem1thsUTTqPOUvVdlqjfI4n3uUen8CMadBy+Q+WFFPAISQxgDszLk
	 YhHlmF6in633w8IYCsWo+qD2PLECFwEnxc4x9bQgQKa2wWNEM2Z5psRzBJBqV9OV0H
	 PjhoGuO8cwUt1Kb3gxvzcCRiAnt12gvICxFFYP79Di1u0pv13cZizwOZZhJcMolooZ
	 1kjxByLE5SduQ==
Date: Sun, 15 Mar 2026 10:09:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rong Zhang <rongrong@oss.cipunited.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Huacai Chen <chenhuacai@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org, Yao Zi <me@ziyao.cc>, 
	Icenowy Zheng <uwu@icenowy.me>, Rong Zhang <i@rong.moe>
Subject: Re: [PATCH 1/3] dt-bindings: serial: 8250: Add Loongson 3A4000 uart
 compatible
Message-ID: <20260315-bulky-important-goshawk-affcf9@quoll>
References: <20260314234143.651298-1-rongrong@oss.cipunited.com>
 <20260314234143.651298-2-rongrong@oss.cipunited.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260314234143.651298-2-rongrong@oss.cipunited.com>

On Sun, Mar 15, 2026 at 07:41:41AM +0800, Rong Zhang wrote:
> The UART controller on Loongson 3A4000 is compatible with Loongson
> 2K1500, which is NS16550A-compatible with an additional fractional
> frequency divisor register.
> 
> Add loongson,ls3a4000-uart as compatible with loongson,ls2k1500-uart.
> 
> Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

