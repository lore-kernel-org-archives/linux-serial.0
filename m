Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89937C91E;
	Fri, 24 Jul 2026 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875372; cv=none; b=CFT9ToiYZGPjP6S/QyIBhHvKhI03GBj4bJylTUmykaJV07h5Q5U1W2ueotUOoQl8MdZhfvQEhBWAxXYmu8jJ22Jn4bla4SxyM7FBM+wj6YhQri8p2nh0dLLlzdsrEVcZ1R5yIMvmHZ7PpCB+WTyi3zTt4XcFnO75M5hgssAU9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875372; c=relaxed/simple;
	bh=rbHMg7meORFPZCFrphP6K9iLH0FHl6J5aPrXKqnmSrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxNEHQ0p344mKNyQaUHbrUa/NKzhutolQBYlzBz1jOL+5zz2tk7XBACd7NnkqXrPw+UG8vSAgzhZoDHKilP+wdwomRRxkrtQpFSrrD8m1LLrdr22O9NHqE6rLcY0/DXSZyNy7TraDDtqKqonEFhcHOo56OULC5MKpnrfjLnriJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptvpp3F2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptvpp3F2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69D71F000E9;
	Fri, 24 Jul 2026 06:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784875370;
	bh=fFt6up+caZWFJ0oLSrURO3q5OjP8+JoeVblpcy/X/9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ptvpp3F2ELMeiE8KIDalhiQLpKaaYaqtRlUXic453BmD8AtHcUWRcJkONCnFOTLoz
	 WhTIWoYUmJfMFviPqEscyGs0Ive5Yd36D018sOch4Ydxpo0pI5t+33iuqHr2jfAn4F
	 Zs9YhD/RjrfxMPfMfsa4iZVS3yIuRiMmK7tAxvsyExztENkfqljh7OoQlHuBq5FeQc
	 S+ElRYag6dDLf9mH3IQ5djrWJ8/XV6IPSB041Dd97Oor6XUvCe2k9qjVLqjN05cuKx
	 EGQquEM5mKzq2tQg/Xk8Xxwd4UUCkNE7CcEpNFfHWm0tilJFahkvqq+vXs9DYfEwxB
	 OmRjjcMIPhMJg==
Date: Fri, 24 Jul 2026 08:42:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	soc@lists.linux.dev, Douglas Anderson <dianders@chromium.org>, 
	Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
	Brian Norris <briannorris@google.com>, William McVicker <willmcvicker@google.com>, 
	kernel-team@android.com
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: google: Add dt bindings for
 frankel/blazer/mustang
Message-ID: <20260724-abiding-resilient-elk-1fc92e@quoll>
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-1-3abae9717feb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722-contrib-pg-pixel10-initial-dts-v2-1-3abae9717feb@linaro.org>

On Wed, Jul 22, 2026 at 10:55:52AM +0100, Peter Griffin wrote:
> Add binding documentation for Tensor G5 SoC (Laguna) which is referred
> to in code as "lga" and three of the boards that use the Laguna SoC
> Frankel (Pixel 10), Blazer (Pixel 10 Pro) and Mustang (Pixel 10 Pro XL).
> 
> Additionally update to use a more efficient and scalable way to express
> the various names a SoC is known by.
> 
> Co-developed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

