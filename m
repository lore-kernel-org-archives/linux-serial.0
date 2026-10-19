Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888124AA1CD;
	Mon, 19 Oct 2026 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403104; cv=none; b=Jwznd2HU2b3DqcnVmqscLKkpLdJr3VrR1O4u85AxZv9CvivbzyMmmGtnxSa3z3f5OREgbJdyzxWW8IfTr7mwKghTi2JZzAVzPRKsOQ0P3cfuqPAxOG8MiAwCgt5J7qNZbSMoWrti2ic3UlQOyNB7PzlRjBUGHlHMZ6BAo/Uyvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403104; c=relaxed/simple;
	bh=M+QcNK7DX+e18mhL/cqIPZRvOKiQdy810mPi8n7/L9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GToB3Gp2wLi6oEG8QqIX8HR/uB/wFrbHWShmg6UFX4BkIhMTYUW1qZuacasSiO8BnLEx2kiL7hEa6ztmP4nH7aqKuwNLiNxUbdlU8MtIbLfBWORrxEqU2YMoSHEroil3yCrYluEfSg2ZH6NwnKntL8Uxif52fNVYf+kpsqtarcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0IJ/Q3J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0IJ/Q3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975011F000C4;
	Mon, 19 Oct 2026 09:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792403100;
	bh=f9hUmKar5O02NFihv/eWeRprhOZiGvnEGK3mmjGeDPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I0IJ/Q3JQydV4fpFljS1CKzANgZRjBmUN5jkSaBePuo2vvHYZtL949kaI4oXtKVpF
	 Ibrxra4wlgFftp6lfT9oDbtnaPPjsR+M9L9qpwrr0YwPLaXTq6OdISIOcvPG1Y+q6f
	 WtMRwNXTZ3YKlyhQo9TLKeaBBEE15nWUiONThR6H068PwUOww8DtEGxcTcSNyIj+Ge
	 9yLMf9bqMv2dMajCH7IrxjpKnWxQJpf0V9CrCbZaUWz0X6zEI8DLt/FpyVmvAgnEA+
	 kWBgajriVYaVZa+taTaIfFvLpa/yGICU/MMSqlv3EeQB2bfjMTG0f/XPpt+H0Fv2FH
	 MqjKcctfD6cpA==
Date: Mon, 19 Oct 2026 11:44:57 +0200
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
Subject: Re: [PATCH 3/8] dt-bindings: timer: mediatek,timer: Add MT8163
Message-ID: <20261019-cyan-cockatrice-of-economy-adccac@quoll>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-3-f2462b2d2437@protonmail.ch>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-3-f2462b2d2437@protonmail.ch>

On Mon, Oct 19, 2026 at 01:39:59AM +0100, Ben Grisdale wrote:
> Add a compatible string for the general purpose timer (GPT) on the
> MediaTek MT8163 SoC, which is compatible with the MT6577 timer.
> 
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

