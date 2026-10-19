Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C64A6CE6;
	Mon, 19 Oct 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403067; cv=none; b=TfuvQ4qwvxd7PBHXSk5gcDv37WJkcAtLI4IpLFiHcwWHYNBNWNZipOrKbo7hM1MM9DQm1bHeI40Wwbjv/wA9m7F/fOth8jOUQ19alt+QDpiRG7H11bznKHKZpFESKb1w+EYLVdGgnrAwf5SkEOFZL8aMO5Jn9mcw0Rs73lbcg70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403067; c=relaxed/simple;
	bh=j1LePCS7VsktOQshPU5lsocJiN8pX3yB4kAy6E97r00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIPSIKfMnaP2cinQupngR55R1MdofLIXw9msBz13dZb+nIiqn1whXrs4jSKnIFoHlTJTlsyZxkyxT0xQhhd1XxWUKa0zA6gMuy2MHwTod+RkApAAEGQADUOjEZYZVv2Fg2khdXW/QU2i3P90c2wk4nnUy7JcU78Cc4ivl3IDtBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd7yGmJs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd7yGmJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE601F000C4;
	Mon, 19 Oct 2026 09:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792403065;
	bh=vEQbfTHq4woxkjSkKI8PNLDzgEiv+PRgAM1sGErVRZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xd7yGmJsIMZdGXApleih8fbzna4kEqDO3fB52ZJb7NrAhzNy+V1vGo8W9kdwwU7E1
	 Edt2BnYl3q+bTiMbmWtZM4nwxAduGAQnEPeryPbB60MuvrDP8IULar/u8BlSPyblKu
	 3ScLYDi/cNZRKeAEFhBBbgzTV4kXf/cxW/qmN6xCTdv4UHr+/Ynk8gwFtnOii3WCg/
	 d5TgtFPiNNhmyXEy78pm8B1Jk8URg17Iuxtdly7KZWvemhKZ2cRbeYIaAqhq2oIinU
	 E8oohLft0PkH2PegkysUq+FD2nu6xS9YK8INUCUI0CI6ghH4qerMYYn/RgvLx53W2+
	 Z8eetD5GuabiA==
Date: Mon, 19 Oct 2026 11:44:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ben Grisdale <bengris32@protonmail.ch>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: arm: mediatek: Add MT8163 Amazon Echo
 Dot (2016)
Message-ID: <20261019-steady-dragon-from-wonderland-3dcf33@quoll>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-1-f2462b2d2437@protonmail.ch>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-1-f2462b2d2437@protonmail.ch>

On Mon, Oct 19, 2026 at 01:39:57AM +0100, Ben Grisdale wrote:
> Add compatible strings for the MediaTek MT8163 SoC and the Amazon Echo
> Dot (2nd generation, 2016), codenamed "biscuit".
> 
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

