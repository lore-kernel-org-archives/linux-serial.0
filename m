Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7EF2701BB;
	Wed, 10 Sep 2025 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492853; cv=none; b=H23hk28XM+2MPMIWPIBOdw5ltRzkeR1eqkln8tvCVHqXcKxQJLBszwp+pCR0vVwK7KIjZN01yxhATclHRgSNPn9agiAE7MGAY+4CjdClQYrAF9lqtyjiL15om7A9Eykn4TyFehFVROfs7YlW8djqEfkG3Z07x/5nuSAmlxaXqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492853; c=relaxed/simple;
	bh=IvzOtxbd+u9eMCVRCmDI3BtIPwICPJYHJNrwQij2YNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afwUCPzoyWNGE6U/lwczKVoGQ4UAJlQtMHcz6u4mPkqreySBRe1BDEYdCW4/W/wshFzorTVzn0mENXw1TMPIRHV0mNo0DGi/RhvvAZNebHp6fCNAWFsZqedj77oBWMqHUy3apuFacbU2DQ832bD3CeOAYTluzufljs6b8w3hHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxvwdo+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxvwdo+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC54C4CEF0;
	Wed, 10 Sep 2025 08:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757492852;
	bh=IvzOtxbd+u9eMCVRCmDI3BtIPwICPJYHJNrwQij2YNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxvwdo+m5fLeqqV/TAtYJ3CrtYMcNyRkPNWfPjSWgJ8OGT+y9d4SmRi7Q82oyMYqe
	 Zjtpx5rbnPsmkR/f1Ei+1Cf/2iJQVK1W4NN+TDLXrtKp3zAfHgUn7hU9VinrFX1wcE
	 PzozYAShxzlgqYsGOBZ6AmoD16kKfYKfG8Ck4x9gLN4OfaTk/Ejt08GgLYfmhgl/lF
	 DDXgcYPb5v6gaMIk/eEutfO7kCYHAHwY2yxD76TUEtGCggr3TOVI6l+fsdW5ILw6Dc
	 LjGriRdDYOAu5UVaIIQEd8+bgSXqRY+HWTPPhxhFB5lRJOm1obMFbZr6P/7qQ3Fbtd
	 zSg9N3cxZ+soA==
Date: Wed, 10 Sep 2025 10:27:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Haowei Zheng <zhenghaowei@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 3/3] LoongArch: dts: Add uart new compatible string
Message-ID: <20250910-fast-seahorse-of-valor-bf6c86@kuoka>
References: <cover.1757318368.git.zhoubinbin@loongson.cn>
 <2f93b8f20c6e93a15258888998e926814bfd0adf.1757318368.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f93b8f20c6e93a15258888998e926814bfd0adf.1757318368.git.zhoubinbin@loongson.cn>

On Tue, Sep 09, 2025 at 08:11:20PM +0800, Binbin Zhou wrote:
> Add loongson,ls2k*-uart compatible string on uarts.
> 
> Co-developed-by: Haowei Zheng <zhenghaowei@loongson.cn>
> Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  arch/loongarch/boot/dts/loongson-2k0500.dtsi | 2 +-
>  arch/loongarch/boot/dts/loongson-2k1000.dtsi | 2 +-
>  arch/loongarch/boot/dts/loongson-2k2000.dtsi | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/loongarch/boot/dts/loongson-2k0500.dtsi b/arch/loongarch/boot/dts/loongson-2k0500.dtsi
> index 588ebc3bded4..357de4ca7555 100644
> --- a/arch/loongarch/boot/dts/loongson-2k0500.dtsi
> +++ b/arch/loongarch/boot/dts/loongson-2k0500.dtsi
> @@ -380,7 +380,7 @@ tsensor: thermal-sensor@1fe11500 {
>  		};
>  
>  		uart0: serial@1ff40800 {
> -			compatible = "ns16550a";
> +			compatible = "loongson,ls2k0500-uart", "ns16550a";

You clearly never bothered to actually test this against own code.

NAK

Best regards,
Krzysztof

