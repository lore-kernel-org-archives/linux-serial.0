Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124590;
	b=4iHCZg65mg3Nfy+MG4JsSCTwrY9IlSGkk0c+fvFH+AnnI4OgT1k9E1pmVI2PRhi9+gdc
	 q/lXTN3YhhnmVNDFyvE0A0uSSFMVJOMqitAUjr46QuiB7VyBcUKl/07JaFvs0ZcRt1uiG
	 UyogBY9e88eTZqLJpEGrUXFff5Fb52DD+GaB3vKru3G+EIwln1gsVVVi+sc1GpX2PvuKJ
	 26DyIWxpT/AlVCB+lGf7jFBIM+1EDSNCW3m/puqMXwc4GH60Qv1XQ+BK7+ZPQBeCYVxPW
	 HaUAJ8GiFiwGfW1UJ1iOykGBLeTKPGPX4ACo5D5HnqROIoKYADVyNIGTA/Q688XTDyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124590;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=G+qXDtc/4S7/6lg93iu/z71dgy/oaBaNKnkmnvDGHyE=;
	b=sjkQ6Kym05H/8CfpcecCIU94oODhD4l/SJz+66Y1gv0RAS+kdsCSXRo2KRqNjbiOFdWl
	 Z7i2N38YQEk1ThWnSC3MkGnulmYvHk+8banOQ1r6n/eHigNNNs3Ei8sCymjV82D2vxEQZ
	 jdGFw70esoS/QnUhewgnvuoh3io/lCRdfkYBJ2spFE0HXFT9H9VsEqxpX5Tj4BZxtyVrN
	 PICTLWIUUPDXfCPychxJtmcvqQC7Llhuzso1lUqhNb5soAFeKoI3cGK0N+a6pQ8RyxIFs
	 PkqChpIGkjya4NVPdzXljKETUJVc+gIqV2hsNgeUe9SVJqRPhuCCgIcyh8whqyFOEeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlYEKohT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C670606A320;
	Thu, 19 Nov 2026 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlYEKohT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57271F000C0;
	Thu, 19 Nov 2026 21:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124590;
	bh=G+qXDtc/4S7/6lg93iu/z71dgy/oaBaNKnkmnvDGHyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KlYEKohTZSMePqRrApdWZVW0+vvOMKrMrfMmC5AcYGkGbdZCuZLJzddRhaldr5AGp
	 d5NQhtcAZxTQZ/SofosXZFsxbUi5/z19Lo4CcYbPMtVY2h/MJ0LwuFiOfcXdGr/q/o
	 8rEy8CSfdx8xgVB2Qm3umM8LsnlHV2DFZKcIDoZs83KhBXFB/6yDl/ZV1znHqSQS+f
	 MHXJJ5s1HVBBGQ/txVvqj80jr8kv2iPBL6cCnTw9xC2cxYm4ubdxk2OJ1NHsmAtf5e
	 jxbxw3Bf0y4KdMDpJF+7vHlQRulQqX7NEPDujFWneLE8y3dskrOw5LgYoLEVWIU4Wi
	 5E1ms5Zo2uC7w==
Date: Thu, 19 Nov 2026 15:43:07 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Jiri Slaby <jirislaby@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	linux-serial@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>, loongarch@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
	Binbin Zhou <zhoubb.aaron@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: serial: 8250: Document Loongson-2K0300
 UART compatible
Message-ID: <179512458690.756482.8940207161592274885.robh@kernel.org>
References: <cover.1793776192.git.zhoubinbin@loongson.cn>
 <cf76d5d46eaba55b832287d1193111c369bcf548.1793776192.git.zhoubinbin@loongson.cn>
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
In-Reply-To: <cf76d5d46eaba55b832287d1193111c369bcf548.1793776192.git.zhoubinbin@loongson.cn>


On Wed, 04 Nov 2026 15:45:45 +0800, Binbin Zhou wrote:
> The UART on the Loongson-2K0300 SoC is identical to the Loongson-2K1500
> UART. Document the SoC-specific compatible `loongson,ls2k0300-uart`
> with fallback to `loongson,ls2k1500-uart` and then `ns16550a`.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

