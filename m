Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681EF35949;
	Mon, 16 Mar 2026 04:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773636001; cv=pass; b=uOZSlYhvDySxGG44yeMkkAwK6vIUNlDvzMfjPfmNOQRLiobJ5MUYi+/OqYDJfWyj+2E7Qs02SJ02nYUCW9cLtBwSBgXQVj57lf2DfkCTZFn7UcjTBqaCYPrSTcUF5JvgnLmfKR5E5dhjUwJQUAYZZdArVS+FZDIWKPxOEYh4FH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773636001; c=relaxed/simple;
	bh=pjc2+m477vf9uVO2xPjVo/79XM/qXhACFwE1k0Qe3b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qidNl9xAAYaPdPiiTD7rzMWnwO6oEUumKR45e/yWGQii+ZG1zNdryjXLr94ZL/q4y9mGENfHLzltjH5akRA4i/v+qbezc1dxjHfOpzkeO6T6ulOt1qZYh450BUymrJ9p+32a3UL0akkzFn9gXZUQFSP1f1/LATkNtWTzEkbA14k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=Sp864g1T; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Sp864g1T"
ARC-Seal: i=1; a=rsa-sha256; t=1773635972; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y0YonvlMH6Gy+1iJMq8amZVq5POOik94Pe42QsYGPqTIzzr3d2dyu4YfIpm88Zdpb1Gzh/9HAdJv+6MPRrkMi14QCWJnwesAbWbSx7+iOK9CbRo2XiAt5KlmwghrHYZSKWKsv1Lw8roJPga+QNq2UoeULamUC8PDkICP0u3ZPS0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773635972; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kewINodiHkLlpvPQfzNJPAoWR16xstqEHHybSvNdxOw=; 
	b=jW1aIvlEMfrfm4xgADMiI5b7oeGQT+JLYyGhtcTLS6oJCFlneUoPNtUtmoLhEreywvGtJV1ZPUH+EO4YoB3/Qdx1nTodfiqyivBFcjIgGh8x8uCKXod4w35s7m4sogvXNlnc6UK0kWVFEOFI2HADJ6A1bYGFS+g36c6BZqtoLtA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773635972;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=kewINodiHkLlpvPQfzNJPAoWR16xstqEHHybSvNdxOw=;
	b=Sp864g1TA5So9qkbPIPIbwb8wYbNKBiNBBkZYm1kexV3oT3UyrTTu+tD0SC1DIQQ
	18QBv6jrwO2gU1cf9ps724wcImO1gOuhDV8piYyUQ9RUOdDgph7VAHH2PErpApVd+1F
	L3OVi3eUYZpJpXKoGtykhDR4IOe70r4ODtOcHU6I=
Received: by mx.zohomail.com with SMTPS id 1773635968727532.6997193656666;
	Sun, 15 Mar 2026 21:39:28 -0700 (PDT)
Date: Mon, 16 Mar 2026 04:39:05 +0000
From: Yao Zi <me@ziyao.cc>
To: Jia Wang <wangjia@ultrarisc.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: serial: update bindings of ultrarisc
 dp1000 uart
Message-ID: <abeJHQPJpXIANdzR@pie>
References: <20260316-ultrarisc-serial-v1-0-c464f3e933a5@ultrarisc.com>
 <20260316-ultrarisc-serial-v1-2-c464f3e933a5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316-ultrarisc-serial-v1-2-c464f3e933a5@ultrarisc.com>
X-ZohoMailClient: External

On Mon, Mar 16, 2026 at 09:36:19AM +0800, Jia Wang wrote:
> Add UltraRISC vendor-prefix information

You don't add any new vendor prefixes in this patch. This commit message
should probably be updated.

> Add DP1000 UART compatible information
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

And the dt-bindings patch should go before the driver changes.

> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Best regards,
Yao Zi
