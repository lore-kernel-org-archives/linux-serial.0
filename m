Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778766;
	b=BYOX0lwIcA2hgtbixqF4cSxYWCCf3LNuht8fqXuNVTW5Jr+08fTBbWdmH/nAzWpO27H4
	 nwrdFbsDZ+GkLviMwB8AV4hAHlKlsp7YyW0oCv2HABPxIcG0xQTr/0lCN1jn0erzwkhVj
	 0+mDiZIl3tLNUgpVeV37PYdTuooXAivJZMBVG2q2mQQ3HAmbiltqDS1P9NCI+OoO/y9lu
	 r4NTlSq+fYKaJC1Q21u8Gl66gHw9o6p4dVlX2fHvqmsJh3HeqIQAdAsQO3EVecOVNnH2O
	 X4cOdaRRCGUV8PHkv6MFrvsgGjtpD/5FXpeYWAGSfzM1P+iuzCHE6+YPgPAl7uHigpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778766;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam;
	bh=5os4Mh8dITDghekCBvG3QNvZpD+sxQ58nztZUkhlgKA=;
	b=yuqXByvBahrMj8LZc0JX8Z40a+1+KKr1ukomPzceaWB4jUWIm9U0Q7NCOHBqA422I6aj
	 RQViLVhCvpGd6+qe1u0+JJwRMYNTmlKSauzKJhc6yk59ugsEycoMYLRqXNyQh1Q9QcPUm
	 VE3sT9YYptdQ/qu8+bD9p5G0M+CkreLONFf7wsVfeS52pPZxaFYH3NrAyD2rvZR2lTpGo
	 9i1j8if/iKnEoY9Ve+AFLP1HcVk2/TUzlErQmM0Q8uufsL1NqL2eHycSIsImi0eKwqdLF
	 3Meh0RoQAaUE2QsO2HwNe8aFkUps/YD1iomQu1awtD7qnM07b7jSgiW2nfIsmnBLATw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b="iNyiU/xG";
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1E606A31C;
	Fri, 27 Nov 2026 11:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A1E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=iNyiU/xG
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id CD35A4C99A;
	Fri, 27 Nov 2026 22:26:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795778761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5os4Mh8dITDghekCBvG3QNvZpD+sxQ58nztZUkhlgKA=;
	b=iNyiU/xGeL0SXF2VKRPnpuTNUHD+z1DFMEbvgr28coiGDuOaqgbO3k5O/rkmtmRWtyz0GX
	TgoykyRW1haRG+h4cq8bSZDL2SoEHmTR9hhzBK8QBbb4GOqMpx+pTv5VTX5kURabisu4by
	bZ4xp1w+3/LUPEThvxfLBUIe6GzUNIripGuwjnBJT7DT7MJvb0YIOah8GRjDp7q7P+dxxk
	sJt7C4Hzf6J78mWdPeuuy7oEKwsEj6e0hZc+EP56B84dYsQCRDej84vAfwtkarogTVacwG
	Kau9Ai8RyzQxw1HN56C8xFVjQyVLp5FYujfs8cB7ifDEVqGrsbntuEa3NaROtw==
From: Alastair D'Silva <alastair@d-silva.org>
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: serial: snps-dw-apb-uart: Add Allwinner A733
Date: Fri, 27 Nov 2026 22:26:01 +1100
Message-ID: <20261127112601.2585536-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <09f3a181436e6f19317224e583c2fdaa787797d7.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <09f3a181436e6f19317224e583c2fdaa787797d7.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

On Mon, 19 Oct 2026 17:06:12 -0300, Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com> wrote:
> The Allwinner A733 UART is a DesignWare APB UART, but it needs
> SoC-specific handling so the driver can avoid stopping its clock during
> termios changes.
>
> Add an A733-specific compatible, with "snps,dw-apb-uart" as the
> fallback.
>
> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index e2ca126d58ba..532392dd54cf 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -60,6 +60,7 @@ properties:
>            - const: renesas,rzn1-uart
>        - items:
>            - enum:
> +              - allwinner,sun60i-a733-uart
>                - anlogic,dr1v90-uart
>                - brcm,bcm11351-dw-apb-uart
>                - brcm,bcm21664-dw-apb-uart

Reviewed-by: Alastair D'Silva <alastair@d-silva.org>
