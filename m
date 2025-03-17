Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D56417A2E5;
	Mon, 17 Mar 2025 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228930; cv=none; b=Wy2bIOwH8WHbro84vuJmvCZSTcT6pf0dhpDHKJ3Da6+nPUD5/TBlskpj6FDqymYU47ijdgYFXNATH0iHTWqogNlSN+NSWqnCGNFX86dFCc8elATyttWMM1tPHv/wtvwnkJdEpIZh+2WpcburKBiWvUW9jc7IN42NSbTFPYkIufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228930; c=relaxed/simple;
	bh=XPfFKF+fFLO8s+Oa/5gdzWV1lUqv56azyZGzYd7AZdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIx+gdcki7QAVpJ0c1hI8gRCn14lqCdQ8YoS0HyI4XjWW6f4FA20M4eDDYb7UPuWkXIoBgpcTCbuWC/bUIf47HuM4TRLZKGPCVB1aI2YJ/GIjznpVNxEKDCXbvng9Lx2aY2ZHjE3YTig/aubnSXGx2vnBNVe+plCM9KFQtscV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcAoy11o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcAoy11o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71585C4CEE3;
	Mon, 17 Mar 2025 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742228929;
	bh=XPfFKF+fFLO8s+Oa/5gdzWV1lUqv56azyZGzYd7AZdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcAoy11oWtbs9tl2eGNBQQ1nGokJ4IzqOf+jUwoK95t5R2jCTOzSXBI8WEM9j4Osf
	 88KMO1DVkdcNflkshQ1n4kCVsIbvaiKaeEXo2I4DsMHx7W6jybxRxelBvjuNaLkeVl
	 dt5wQqslm2Lk7Sylpv9zCTw+lk18pBI2XYHRVN/N9I6dJft5Ywj3Tgzl6vLeAc6eRX
	 Hkf57mDhlr5cvWC1ejTRPYf2YIdg6M77j+NT9Uoz8G8P6m+zcnjwTf/8woGEn4LDyw
	 hdAfXoYv0Hx2/EA5kUGhwF5PJawUkpDBTJonoM2n1N42Vjck5ZyxkcMAVKCn/y7yL0
	 j3EEF/PonkRhw==
Date: Mon, 17 Mar 2025 11:28:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Jiri Slaby <jirislaby@kernel.org>,
	devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-serial@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/7] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for S6/S7/S7D
Message-ID: <174222892762.176016.11358063656665993798.robh@kernel.org>
References: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
 <20250317-s6-s7-basic-v1-4-d653384e41f3@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-s6-s7-basic-v1-4-d653384e41f3@amlogic.com>


On Mon, 17 Mar 2025 15:16:55 +0800, Xianwei Zhao wrote:
> Amlogic S6/S7/7D SoCs uses the same UART controller as S4 SoCs and G12A.
> There is no need for an extra compatible line in the driver, but
> add S6/S7/S7D compatible line for documentation.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

