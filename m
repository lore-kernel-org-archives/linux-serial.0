Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B8377ED7;
	Fri,  7 Aug 2026 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082434; cv=none; b=BOYAaIbZqul5cvOchoS4iVjnoxjZWikB5sudxEcIEWDb7XOofRbed9Oo3zSfBGPzQleszWVyMSbZqF6UTnbqBsIECE7Dt7DefFZHNmnR5QPTj5KKDY8EZXtD6il1TJDfgQ6b0Tmoc0XCb4aZTF0uJ5m427VYJyg4IjCkp8jlBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082434; c=relaxed/simple;
	bh=Io4sIUXznSJBo8m6F1O7A+RV5c/wESUSagXOPByjurw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhCVCrG8xrZv9T+ORBzOTsvIYwrXHDZtSdytva5fKIdCALn/yIRH1pZTdN/GCnk4zT0iFGHGow6xnAqeqMI1WfqZwPUlFI875xg+469GmbXOT/FFIZcTfvsz3XNLrgakeP1pEuOom3qpZoHx7hWLPKU9fAPX3zMqQpsp3gkC6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiDHhnF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiDHhnF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D481F00A3A;
	Fri,  7 Aug 2026 06:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786082433;
	bh=DTjw2XFDO1scXxZ466G8sTIU0IDoXYq5q8rl6tKiZRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HiDHhnF61cXktC/fU2PqLlG6QeF7DkMz1CQaC5A8ET1AF7LuXGBsKezuCgD9oox4W
	 y2Sx9iYyY+aoO0IYPhYr/vqAQwo9NevoenkwIhnrkwDneXA9BloNAgMf5K+h/8uemc
	 W2Qhlf8cFaOH+e9kXpf8T4vhvCbEpRe4dmzOxv13m3vZGu4d+wqdL61GgkcLKNVwzz
	 nNjoH/8QJ3euP2YWZbFHlPi4I051+2ZKFABewEgpiuDkrv6OJQswkiX9WEXEdzqWtu
	 tF/SccwVUtceMU5EcA1v92ftFGRqT0SbnGMkeKhyecvI4oLDiTk3J3T100Sh2RvYHY
	 p/D9wCGLUxPhQ==
Date: Fri, 7 Aug 2026 08:00:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Long Zhao <longzhao@ambarella.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH v2 01/10] dt-bindings: arm: add Ambarella CV75 platforms
Message-ID: <20260807-free-stork-of-effort-60e41d@quoll>
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-1-6b09707c5fe9@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-1-6b09707c5fe9@ambarella.com>

On Thu, Aug 06, 2026 at 05:34:09PM +0800, Long Zhao wrote:
> Add the Ambarella SoC board binding and vendor prefix covering
> the CV75 EVK.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../devicetree/bindings/arm/ambarella.yaml         | 23 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml       |  2 ++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ambarella.yaml b/Documentation/devicetree/bindings/arm/ambarella.yaml
> new file mode 100644
> index 000000000000..347148530f80
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ambarella.yaml
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/ambarella.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ambarella SoC platforms
> +
> +maintainers:
> +  - Long Zhao <longzhao@ambarella.com>
> +
> +properties:
> +  $nodename:
> +    const: "/"
> +
> +  compatible:
> +    oneOf:
> +      - description: Ambarella CV75 EVK board
> +        items:
> +          - const: ambarella,cv75-evk

This should be enum, it will grow with other boards, no?

Anyway,

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

