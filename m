Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4028370;
	Sat, 12 Oct 2024 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728760108; cv=none; b=LGNsqsYflAYPr7wqA3aC6WVMpzCLPu0uVZYvhdJqyCC54aOOHQjMJm+bpZsLe8/pfjY4byRzT33ySAWaLm/Dbe67rUhj2urdApzyBSlnxK2ibf9Y6vpnUJhmdEWHorN9KT7NoU8SN791hHrs1iQ7tN51vuzGfVdxIocFaUi/+ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728760108; c=relaxed/simple;
	bh=MU2rDYI6hAUrAK3e6aRTc74RxT27Yq+1WZfEi7j3p/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNiKiQ3odjV8ApIYzg2ViZC//whaiRX9tDryq+IAns58fE+v/lLs32HtIUcDbl249Kc9FwpHKN+hTEhCBVNjWj8Kh0vMCgH74Y7qQtk9ACMOgnBu90djWFNAdjv2u6DNsyCsxCXMcf+pExlQNKlue/Nuh4D9mnQ0xBkFiOfwFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wjsEJBvd; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wjsEJBvd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ic9XVUBHDGFbjKjFR5Akyp38Oq2AX1aB/FbK1DvjEds=; b=wjsEJBvdw3FCsJGoOZFcciJYLD
	eDiCundW7AQ7TOB+Wb2SSCPUuEwXbJSkHDMNVUokutu0hFfSsmonTU0VPHPdeBee2quM99lyjuavQ
	E1O1yEfF1xOuxPmFd2/WpUMAeUMjqgojb5bJtz5LAl6T/YHDjnynzoVJiuvLUKkFKiwN4KbpAz6x1
	7YR5jGp1wUlvIRAKW8ZMzpkhf77O1FL+EwZCLFWeVFDKU/JttmHPSYpt2l6NOldedx/pGZNrLlken
	RuNYUhQYCL8FPoQj+gFiL2a6H3EiWswDh+dWkn0Uu3vxiPKCb2dZU9TnzUeD+qHoEWeYI/SzGK0Gz
	huIMNwkg==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1szhT8-0001UY-N3; Sat, 12 Oct 2024 21:08:02 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>,
	linux-serial@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>,
	Andy Yan <andyshrk@163.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jagan Teki <jagan@edgeble.ai>,
	Tim Lunn <tim@feathertop.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	devicetree@vger.kernel.org,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: (subset) [PATCH v4 0/4] Add initial support for Rockchip RK3528 SoC
Date: Sat, 12 Oct 2024 21:07:59 +0200
Message-ID: <172876007504.42219.14344131285317910319.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829092705.6241-1-ziyao@disroot.org>
References: <20240829092705.6241-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Aug 2024 09:27:01 +0000, Yao Zi wrote:
> Rockchip RK3528 is a quad-core ARM Cortex-A53 SoC designed for
> multimedia application. This series add a basic device tree with CPU,
> interrupts and UART nodes for it and is able to boot into a kernel with
> only UART console.
> 
> Has been tested on Radxa E20C board[1] with vendor U-boot, successfully
> booted into initramfs with this log[2].
> 
> [...]

Applied, thanks!

[2/4] dt-bindings: arm: rockchip: Add Radxa E20C board
      commit: 0c6f259d56c035523a4ce3d49764b9ade0859f1c
[3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
      commit: b5494d5a4434fcbe6271ef2d7ba64fc5027f3cd8
[4/4] arm64: dts: rockchip: Add Radxa e20c board
      commit: a09bbd747f383e8d0b78364f06553fcb08951e2d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
