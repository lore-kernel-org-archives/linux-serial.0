Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE91DDC9;
	Sat, 10 Aug 2024 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723325161; cv=none; b=Ty0CQDtzUs2kiuj+41oJoe4gUu6LHJXlUjD9vG3RLYEy8MBgGO6wjKuoKqO2HYZNf5x+iWiXsZQA5F2/ntl+pNldBqWyt0DeMI4gJDE3M8DO7aa7LbCmwkX+/8uez8lO6NyAKC0k77mC8A6tNh6q6TwoKbkuF3I1ZWBP0DukZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723325161; c=relaxed/simple;
	bh=SOYWIsTmURDLXnw3LdIIM4mBfItieaO8jtIxklwbAyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yp7yaMllfwaegLkBdgqUBf6sinliaDirk5Bf2M6XswH9GHvT0GqR7MlgSMPzQgYREfKcYuU7i/IpHW/bK+zX/uKsMzFmWVMLTtUxa/Y98tY8MVudKHnM2lYvDCDG7+2Am68roL0d6dDtUPKLwR9tELVRM3O8S2tbwzCHtrS2rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b02.versanet.de ([83.135.91.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sctah-0007cj-JJ; Sat, 10 Aug 2024 23:25:35 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
 Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin <efectn@protonmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>,
 Ondrej Jirman <megi@xff.cz>, Yao Zi <ziyao@disroot.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Yao Zi <ziyao@disroot.org>
Subject:
 Re: [PATCH 1/4] dt-bindings: serial: snps-dw-apb-uart: Document Rockchip
 RK3528
Date: Sat, 10 Aug 2024 23:25:33 +0200
Message-ID: <3241630.nGQf0TPKTz@diego>
In-Reply-To: <20240803125510.4699-3-ziyao@disroot.org>
References:
 <20240803125510.4699-2-ziyao@disroot.org>
 <20240803125510.4699-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Samstag, 3. August 2024, 14:55:08 CEST schrieb Yao Zi:
> Rockchip RK3528 comes with a snps-dw-apb-uart compatible UART. Document
> it in dt-bindings.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 4cdb0dcaccf3..4573044be189 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -48,6 +48,7 @@ properties:
>                - rockchip,rk3328-uart
>                - rockchip,rk3368-uart
>                - rockchip,rk3399-uart
> +              - rockchip,rk3528-uart
>                - rockchip,rk3568-uart
>                - rockchip,rk3588-uart
>                - rockchip,rv1108-uart
> 




