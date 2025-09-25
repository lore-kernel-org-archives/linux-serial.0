Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484801BC9E2;
	Thu, 25 Sep 2025 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758772175; cv=none; b=Ys/P7mhMr4py7IWxLIVVN5XwjcZFa1VHONU77kFMrcj831oSe6M34xWIEelXCU1V7kZXy8I81AHYxl9th8/PNZd6bhod5RbYkUwp1E3GUouqGmDZMkqGliDk6L7EnEMUTeS8WYsDSOKxqO/B8vci0SlE2NaEu0y4aHwYbkU4wlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758772175; c=relaxed/simple;
	bh=ImaeZUMm41NDC9fTay6TMD1ZpgawaZnuHyS80Apz+vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVdyFMC+suDCvQdvhXhwK1Sgjz2d2cIsFJxYLSqSYfW1f79Wnk84Fm4mGxmclvR/hXw7hZmepLZhub17VI3N+/+7YVncuzxTgCGi4mDgJhHo3fVg4uXNTHqzgjjC1lEsPeKpD1x+mlLjPB89QRZMj0jqk0HCBZeiX61gWgGBFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YI2vyybW; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YI2vyybW"
Date: Thu, 25 Sep 2025 11:49:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758772161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBiu5fon2usO9/brRov2NJKkMhUctrYhM9cA/eD6UYU=;
	b=YI2vyybWXXnWShRtOGUMhbQc06uRwjbaXBGYbocLvsJKOUc+Tx/kTr8lF92hISbAzAnNlW
	JbJ16hU/82Rs8z396bh8Q1AZHlBgbrmKO/D9Npbg87ISGN6ttp/0zIzIUjGL4EIA87IDsq
	BOHWHDhOwHwr1J1CcUyLVr1+b4Tn8UI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: "fushan.zeng" <fushan.zeng@anlogic.com>, junhui.liu@pigmoral.tech
Cc: alex@ghiti.fr, anup@brainfault.org, aou@eecs.berkeley.edu,
	conor+dt@kernel.org, conor@kernel.org, daniel.lezcano@linaro.org,
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, krzk+dt@kernel.org,
	krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	palmer@dabbelt.com, palmer@sifive.com, paul.walmsley@sifive.com,
	robh@kernel.org, samuel.holland@sifive.com, tglx@linutronix.de,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH v2 00/11] riscv: Add initial support for Anlogic DR1V90
Message-ID: <aNS7uMHC4iTDHel4@LT-Guozexi>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
 <20250925030650.35694-1-fushan.zeng@anlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925030650.35694-1-fushan.zeng@anlogic.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 25, 2025 at 11:06:50AM +0800, fushan.zeng wrote:
> On Mon, 22 Sep 2025 20:46:30 +0800, Junhui Liu wrote:
> > This patch series introduces initial support for the Anlogic DR1V90 SoC
> > [1] and the Milianke MLKPAI-FS01 [2] board.
> > 
> > The DR1V90 is a RISC-V based FPSoC from Anlogic, featuring a Nuclei
> > UX900 [3] core as its processing system (PS) and 94,464 LUTs in the
> > programmable logic (PL) part. The Milianke MLKPAI-FS01 board is one of
> > the first platforms based on this SoC, with UART1 routed to a Type-C
> > interface for console access.
> > 
> > Tested on the Milianke MLKPAI-FS01 board with both the vendor's OpenSBI
> > and the not-yet-upstreamed mainline OpenSBI [4], as well as the vendor’s
> > U-Boot. Because the vendor’s OpenSBI is loaded at 0x1f300000, we have
> > to additionally reserve the DRAM region 0x1fe00000–0x1fffffff to prevent
> > overlap if using vendor's OpenSBI.
> > 
> > Notice: A "no4lvl" bootarg or dependency patch [5] is currently required
> > for successful boot on the DR1V90 platform, since the SoC hangs if the
> > kernel attempts to use unsupported 4-level or 5-level paging modes.
> 
> Thanks first.
> Anloigc already has the open source SDK at https://gitee.com/anlogic/sdk,
I think very few people actually use Gitee around here.

> and will submit it to mainline at suitable time.
> It is better that anlogic SOCs are long term maintained and supported
> by Anlogic officially in mainline and for customers.
> The code should be a full feature version after lots of tests, not the
> modified and simplified version from Anlogic open source.
I understand how you feel:
You want to be responsible for both the code and the customers.

> And we hope that there won't be two different versions code of anlogic SOCs,
> it may confuse customers.
This is almost impossible.
Mainline means simple, clear, compliant, fully open source.
Some features, like GPU, are nearly impossible to fully upstream.
Vendor versions are complex and implement full hardware features.
It also seems you expect only official folks to handle this,
which would take significant effort to maintain,
perhaps even requiring dedicated personnel.

                - Troy
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
