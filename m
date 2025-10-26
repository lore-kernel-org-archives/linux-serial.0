Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2EB1AAE28;
	Sun, 26 Oct 2025 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761515016; cv=none; b=WgXOd9ye8YxOw2lLwrSBTTq7AZWHO1upPOpK0lV9jufLUIs00Olh0NaH1zZC0x732V10oByyKUX8ICyN6n47qQZPb+inlQj+ZhBdXMXN3RvEsrCPucseaPdItXZf3kFrxybxD4cUe4BfIikAbbrcDR42IsvYkjPElbedV2YHr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761515016; c=relaxed/simple;
	bh=0JsaR/gVfYuPh5Cfn/iC3pjbAktuSznePf9ABPRGJoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3LW0gjbiBIc8LkV2JHUMWFBwK+0tJd/jo40/TxtnDZthV2wBW1gKPDiPFaNcq7xy/ZKz58nMcahyHxz7XItlH55ltyetZYndmgCPhjQM5DJ4i3zeNACrULBbYLH4pbwJkQiKXzAWDxNmsp/MZj6U+F7TMNqRyFwh41hHLXqGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+NgH+oq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+NgH+oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCD7C4CEE7;
	Sun, 26 Oct 2025 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761515016;
	bh=0JsaR/gVfYuPh5Cfn/iC3pjbAktuSznePf9ABPRGJoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+NgH+oqZEUs+k6eqHk7nYMsw2921LBoEq0/LJGGHdFyVe8fLSFVy697koLHqTEQv
	 AXQ4W9s1fkcIBKPAHtDUfJWy5cz+sXl7QtnOyEK1HVxi/m5AeFbY3kwXWWdUdpkLDq
	 NDLj3zOP057NFRZsrmhmKm5p3oA7AiHFt2nPK3g4Gw+lg/gowPJCn9Xgt40KwdqaCH
	 JLMFGF7RpXEMQaoLok8Xg0408WFQx5HqMDmS4htXz8qlyETbHosen6C73Flr6WQ0FZ
	 lhmqrDEd4AzMZ1DMsBWis0Mu+weoGYLfkYZCDA8LyrRVt7R4EJ5BNk5G8QhEzwUJUP
	 6K7BB2Lw5QHrg==
Date: Sun, 26 Oct 2025 16:43:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, sophgo@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Palmer Dabbelt <palmer@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <pjw@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 07/13] dt-bindings: timer: Add Anlogic DR1V90 ACLINT
 MTIMER
Message-ID: <176151501212.2988871.10069420018987162888.robh@kernel.org>
References: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
 <20251021-dr1v90-basic-dt-v3-7-5478db4f664a@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-dr1v90-basic-dt-v3-7-5478db4f664a@pigmoral.tech>


On Tue, 21 Oct 2025 17:41:42 +0800, Junhui Liu wrote:
> Add MTIMER support for Anlogic DR1V90 SoC, which uses Nuclei UX900 with
> a TIMER unit compliant with the ACLINT specification.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  .../bindings/timer/thead,c900-aclint-mtimer.yaml        | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

