Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA32DE704;
	Tue, 16 Dec 2025 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897678; cv=none; b=XvE0sWl1NtPbZKd2vDHv5I91se+3j5ySygn4lnBZrXQq2qgTEc9K+08+5BYl1aTO/xXAAi9FLEN7DoTuKixz8cHKHXf+XedVdylcjMWK4tJm1JAW9tiov9EfjQpulspetUaaWos9k3yOb/SpuZXJVoi7HPR/3NY6Too5hcHSvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897678; c=relaxed/simple;
	bh=s0c6E5IaP80ikEnHdus3i1oGbaCQpurU1nNFReZUNG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwOOiMCt1II9YKRueBifIkWJ4ADvWGyA6+lDt0t3zX0qx2uk8gWESUNVUApZOTxfBg9bZoeXL42V7jo7yN99QXnUyN/HHtZF7gSrcnsDFjpeRdJ/71RyMGxb/353+UcZaYvjDF/lqZ3TA2iCYpTMjlRV7svaC2jGSkdtTEUy1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 5975F340CF2;
	Tue, 16 Dec 2025 15:07:55 +0000 (UTC)
Date: Tue, 16 Dec 2025 23:07:48 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: riscv: add SpacemiT X100 CPU compatible
Message-ID: <20251216150748-GYA1937017@gentoo.org>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-1-a0d256c9dc92@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-k3-basic-dt-v1-1-a0d256c9dc92@riscstar.com>

Hi Guodong,

On 21:32 Tue 16 Dec     , Guodong Xu wrote:
> Add compatible string for the SpacemiT X100 (RVA23 compliant) core.
> 
> Link: https://www.spacemit.com/en/spacemit-x100-core/
> 
no blank line here
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

with that fixed
Reviewed-by: Yixun Lan <dlan@gentoo.org>

-- 
Yixun Lan (dlan)
