Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FED2F50A2;
	Wed,  2 Jul 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476842; cv=none; b=q1AdYz1p5Qi1hmtakDRTogECMuWk6zqRaBPzAbByak/DGDNqki1cOgBmXrWP/8JrxESMJwdwrI3n0vb0TxVybbNdgjP7+VU+lY/hMraqcNJiEIHB5SfwqZUAiALAArbm+1yrFHLgkEOevBTLw83vS2AFtgw7ftO+AkOIhN+cQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476842; c=relaxed/simple;
	bh=u2KdsjMl87c02z1ElvoTqJJEGUWbL7jzufaq0GTNTrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjPFvScgfZ0Ijj0G0JCTsD6qiiIp5bXPavI+Q2nbcU7pZTWMplz3TOBZYu1zw0NaMFVzmtFzR8oDCoS0ZvCZ/gYN5QAGp7yO/47WCL2Kdz4AH5uWh9hJQuo4pRWD6Qp8I8XzLT3doPD8UAPGcI9gcN5H7hJZ5oG5zgwrc8mvo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AC5A22C7;
	Wed,  2 Jul 2025 10:20:24 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4FEE3F66E;
	Wed,  2 Jul 2025 10:20:38 -0700 (PDT)
Date: Wed, 2 Jul 2025 18:20:36 +0100
From: Leo Yan <leo.yan@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: cov@codeaurora.org, rmk+kernel@armlinux.org.uk, mark.rutland@arm.com,
	catalin.marinas@arm.com, linux-serial@vger.kernel.org,
	rmikey@meta.com, linux-arm-kernel@lists.infradead.org,
	usamaarif642@gmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <20250702172036.GC1039028@e132581.arm.com>
References: <aGVn/SnOvwWewkOW@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGVn/SnOvwWewkOW@gmail.com>

Hi Breno,

On Wed, Jul 02, 2025 at 10:10:21AM -0700, Breno Leitao wrote:

[...]

> Further debugging revealed the following sequence with the pl011 registers:
> 
> 	1) uart_console_write()
> 	2) REG_FR has BUSY | RXFE | TXFF for a while (~1k cpu_relax())
> 	3) RXFE and TXFF are cleaned, and BUSY stay on for another 17k-19k cpu_relax()
> 
> Michael has reported a hardware issue where the BUSY bit could get
> stuck (see commit d8a4995bcea1: "tty: pl011: Work around QDF2400 E44 stuck BUSY
> bit"), which is very similar. TXFE goes down, but BUSY is(?) still stuck for long.
> 
> If I am having the same hardware issue, I suppose I need to change that logic
> to exist the cpu_relax() loop by checking when Transmit FIFO Empty (TXFE) is 0
> instead of BUSY.
> 
> Anyway, any one familar with this weird behaviour?

To be clear, I am not familiar with pl011 driver.

For the first step, could you confirm the UART port is only used by
Linux kernel?

In some cases, if normal world and secure world share the same UART
port, it can cause the UART state machine malfunction and long wait.

Thanks,
Leo
