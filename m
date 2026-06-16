Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82AA27281D
	for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595885; cv=pass; b=pP+nLlRKfmLJ4KyiX0SjNmqPNtcI+KWhIrdtokAdjDSsK+ZOqciyhZhok07mk0Goe58PHs5UwSU/vUnbCWAoYOiKoi5NIkxgtmYq5KEsrZYNcGyVZgAaISXNpTRZmB7rpvaGWT5lKpKJU5Xw3cUq/5OTcrLlbAw5FI2EF6fFjl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595885; c=relaxed/simple;
	bh=EKKgLEUBytZZKMzwou9LmfldsnehMEcL8Z4xHKPj3Yw=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WWeKjkHglfdNpxEdyW7kRa5WkvsHv91Rsruo/zOGSNGFsM9ZjY6x7Xpr4raaQgu2bDZkBANr9ydm4GUYuZf5ZoRAvP6OY/78I9jrfIrCSGCv/tlvjwggHOh+op0ZLDp4tTl32LfOycoy5sx4awPCHzVGtEgJgUBmG04rP7bWL1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcqueen.au; spf=pass smtp.mailfrom=mcqueen.au; dkim=pass (1024-bit key) header.d=mcqueen.au header.i=craig@mcqueen.au header.b=GMQaTUSO; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcqueen.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcqueen.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mcqueen.au header.i=craig@mcqueen.au header.b="GMQaTUSO"
ARC-Seal: i=1; a=rsa-sha256; t=1781595881; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NDq/43ZYsENnyKUwe6/00sI/hAMmzsBVKNDh9p65CjTFVnl+U10BZi+Fr3uEw5sskKTpTYTZsEcOOtZnowvzKze7Bf+cSC1btLdqgC4U+1s467V0kxGmmP5S9mOO5IMJJiXW4hIl/Zu8o9LquuYAUuGSq3oBgiB9cPkyXfWENiY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781595881; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=qfkD8TgfTyLb2KIzLohBaCnVsFkNNHHaAxZJkYj37GU=; 
	b=hsP+6H6CmGt0VUILLwouSKjaMU7dm2StP81ptHS/+y8TEl5iWHU+7re/gHG/scibbWV5o7ekJ6b23FS+YW51sYVXdJf3UtkkTl9wKxCTcW2neDr40k8Ic9ZDC81UkaPySLPd8E5PusDtXw9LjugjK4UUscA0VkaUTMvVmHilDZg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mcqueen.au;
	spf=pass  smtp.mailfrom=craig@mcqueen.au;
	dmarc=pass header.from=<craig@mcqueen.au>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781595881;
	s=zmail; d=mcqueen.au; i=craig@mcqueen.au;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=qfkD8TgfTyLb2KIzLohBaCnVsFkNNHHaAxZJkYj37GU=;
	b=GMQaTUSO0f9cNunYnEHM/lpdxGGtdguariihMd8G17kC0i3q3ivo5T0q7PQX+P5f
	5PMrdA5dEgybwU470KNHTMVn2CfMTpqnY2TnqOo7ar8cdNJIlbMSGIKUO5J8Rld87AC
	HYAF1uR368CL1pEKEeS3PaHvov9vWqg4WnnAfkFI=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1781595879631723.809067637318; Tue, 16 Jun 2026 00:44:39 -0700 (PDT)
Date: Tue, 16 Jun 2026 17:44:39 +1000
From: Craig McQueen <craig@mcqueen.au>
To: "linux-serial" <linux-serial@vger.kernel.org>
Message-ID: <19ecf63b8bf.3059f90c1678338.4949518025835217958@mcqueen.au>
In-Reply-To: <19eba567d94.1f5854744141363.4614464714670279886@mcqueen.au>
References: <19eba567d94.1f5854744141363.4614464714670279886@mcqueen.au>
Subject: Re:8250_dw system pause due to IRQ load
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

I previously wrote:

 > I have a Rockchip RK3328 based embedded Linux system, using the 8250_dw driver (device tree "snps,dw-apb-uart") for serial console and other serial ports. I'm using Yocto scarthgap with kernel v6.6.123. 
 >  
 > It is talking to a microprocessor via a serial protocol at 921600 bps. Multiple times per hour, I see the serial protocol TX pause for 100 to 4500 ms. Usually the whole Linux system pauses during this time (realtime and monotonic clocks don't tick). mpstat shows high irq load. /proc/interrupts shows the 8250_dw interrupt count is going significantly higher during this time. 
 >  
 > I'm also seeing complete system lock-ups occur every 1 to 72 hours, with no diagnostic information shown in the kernel serial console output. 
 >  
 > Are there any known issues with the 8250_dw interrupt handler causing high CPU load, that I should try backporting to kernel v6.6? 
 >  
 > I've written some kernel drivers, but I have no experience debugging interrupt handler issues, especially when it's an issue that prevents the kernel doing console output. I would appreciate any advice on kernel facilities that are suitable to debug this type of bug. 

I have been able to diagnose serial TX pauses, using trace_printk() in the interrupt handler. The cause of TX pauses is many repeated `UART_IIR_RX_TIMEOUT` interrupts. The serial device appears to randomly get out of this state.

I see the 8250_dw interrupt handler has a work-around to stop these `UART_IIR_RX_TIMEOUT` interrupts when the FIFO is empty. But it has only been enabled for non-DMA mode. But for the Rockchip RK3328, the serial device is configured for DMA mode. But in our usage, we're still seeing this issue randomly appear.

I have modified the 8250_dw interrupt handler to do the work-around even in DMA mode. This seems to resolve the repeated `UART_IIR_RX_TIMEOUT` interrupts, and eliminate the TX pauses.

My testing shows that this doesn't fix my other problem, of complete system lock-ups. I don't yet know if that is also 8250_dw related.

-- 
Craig McQueen

