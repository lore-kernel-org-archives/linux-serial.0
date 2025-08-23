Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71981A0730;
	Sat, 23 Aug 2025 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755930994; cv=none; b=IbK6ssfqL/mfEMTgH66fm0gCRh1vytWc28RB3qN592gVAHeCsJ8N+oTnFGluQlVjl43IbQlE2Yauwwqik2GUW/GfDXZv2DSazPSHEycfQMOJUnYpZIwtdB8uD2i4yITh9vZv2MajcVNbBTl3+87+gxF/Ph47CS4JILJRiL1gqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755930994; c=relaxed/simple;
	bh=JmNf+0AG97IGYu8B7L1j0V46DCFU5/ljdv2ZVFoAVRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoKpNggfV+4vV2igZ+3iXg3E7EzCA5XSNzJY5AtmnyBgLPUBXnPwUnHqVtLE86t75nUPa3E2mEvmYkhx4CmOJiff0hpx/anUmQWWXlJuDIUHP6xDML2kn59jTg312+eiitx1UehehmzoQmCubzEZAY7R3yGNs9Z7NOT6hvwaC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qji+1rXN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qji+1rXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944E8C113CF;
	Sat, 23 Aug 2025 06:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755930994;
	bh=JmNf+0AG97IGYu8B7L1j0V46DCFU5/ljdv2ZVFoAVRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qji+1rXN9OIXfa1Z5HHnBCjZi9aYqDpsTOzT+G6SgOLe6hLfFrWSfXuyKJGwVUGWq
	 KhzXOf0FFXFVDhOFdhoJ3qsfnvB8yYOnExcZ7tn28GY2Y4NLNZJ+15/ebQX1dnBR2l
	 bZQ3+AUeijjqg4dVWImEEoQ3qxNhx3/+H2Wcw4UA=
Date: Sat, 23 Aug 2025 08:36:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Shah <hshah@axiado.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: xilinx_uartps: read reg size from DTS
Message-ID: <2025082322-speech-blaming-b075@gregkh>
References: <20250822-xilinx-uartps-reg-size-v1-1-78a5c63cb6df@axiado.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-xilinx-uartps-reg-size-v1-1-78a5c63cb6df@axiado.com>

On Fri, Aug 22, 2025 at 11:58:14AM -0700, Harshit Shah wrote:
> Current implementation uses `CDNS_UART_REGISTER_SPACE(0x1000)`
> for request_mem_region() and ioremap() in cdns_uart_request_port() API.
> 
> The cadence/xilinx IP has register space defined from offset 0x0 to 0x48.
> It also mentions that the register map is defined as [6:0]. So, the upper
> region may/maynot be used based on the IP integration.
> 
> Fixes: 1f7055779001 ("arm64: dts: axiado: Add initial support for AX3000 SoC and eval board")
> In Axiado AX3000 SoC two UART instances are defined
> 0x100 apart. That is creating issue in some other instance due to overlap
> with addresses.
> 
> Since, this address space is already being defined in the
> devicetree, use the same when requesting the register space.
> 
> Acked-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Harshit Shah <hshah@axiado.com>
> ---
> - Add fixes tag in commit msg

That fixes tag needs to go where the signed-off-by area is.  See the
many examples on the lists and in the tree itself for specifics.

> - Link to v1: https://lore.kernel.org/r/20250819-xilinx-uartps-reg-size-v1-1-0fb7341023fb@axiado.com

Then why is this one not marked "v2"?

Can you fix this all up and send a v3?

thanks,

greg k-h
