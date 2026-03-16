Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C516B3542E1;
	Mon, 16 Mar 2026 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648731; cv=none; b=DBIrRCBEKij5iLRziV0SieYm5qPWYF7WFqREnvIumb6mwGZWEb54K+mo3Syta6J1mR/odpD5zeYg3cfI9wWus/PB8jvTOteS7HVyfSY7tRqaRTVgKJav88tIlYr0IWpD9grSiJa/buCb5aJp/A8prf2G/xbkKXBDcNG9pHO8OQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648731; c=relaxed/simple;
	bh=Li6cPmP3RADkGfu5yAIhyF88ZWDgiUQMDxPls8Kxlv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Levfv5WOqakMSp94X6p+6CCpWJnjHe3g1z/fanI58Lk1/v4Yu9i/7hquMObrxPeqEJIxdkBWOSd4RDQgT9qbacihhKcv4Uqf7fXTvBuXxWT2iD6H6HpOb5rKTsWkylXIbeM9zR0pB4jNjm6G/oO+QP8CO8pwkFgFUUer0adxxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxseuR7p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxseuR7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2C8C19421;
	Mon, 16 Mar 2026 08:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773648731;
	bh=Li6cPmP3RADkGfu5yAIhyF88ZWDgiUQMDxPls8Kxlv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CxseuR7pdRwz12lNYmtyJiKwmH4akmAh3zXHQmGTonNPNEC4rbaN+QdpukkpEdrko
	 e1HqCv0B2lVGscz3lc+lyp0fJ49EdurstIHEhMsPDfqB3mhnKC6H3HMOvCfOEp5U9F
	 AHf1iwiZqooSuG4yJ/ShCs4e5RVtQoD9TeyhqkN8Qne7HWtfvCY5WEQGpZBOoe5v7x
	 a18vfaESXgxgQAFMWLxEcXfa91zw8nIjY6DaP2AVIWj4uJT9/6ACI/oH+VH81B0+f2
	 yqKmzFXttfau3EU6pba2sSX13yZXrT5ya0TYRgktv7s8QA2mrdRMkQsN2UPptg2/l3
	 Phc54JoGaLuaQ==
Date: Mon, 16 Mar 2026 09:12:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: update bindings of ultrarisc
 dp1000 uart
Message-ID: <20260316-upbeat-aardwark-of-snow-30dded@quoll>
References: <20260316-ultrarisc-serial-v2-0-6ab3e7fa891c@ultrarisc.com>
 <20260316-ultrarisc-serial-v2-1-6ab3e7fa891c@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316-ultrarisc-serial-v2-1-6ab3e7fa891c@ultrarisc.com>

On Mon, Mar 16, 2026 at 02:33:22PM +0800, Jia Wang wrote:
> Add DP1000 UART compatible information
> 

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

And anything can be "update". Be specific. Look at other commits how
commits and their subjects are written.

Best regards,
Krzysztof

