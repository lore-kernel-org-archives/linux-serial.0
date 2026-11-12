Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470895;
	b=3AzIedsY1PbUHinuRvtQorLTbRDJp6IxnrO5bVU724FJ73YPuWr37hi3soZLWwdO31FW
	 ng+GAqmwpOkxhDZl0/cYyp3q611XaKDbwowkU2EzZE+Bz3lze52nyTlgMsuM0WL9pA0Xk
	 Goif7v4BiGvc88ksEZW1dSQy/YQrmcuDpdOMxVFTWZ6pfEQ7D6+3Fi/tzNsEUk/6AzbNO
	 V7pxYcWEWxA3saWc06EfUBucxMamhJLZd88RgkEp8DyxDcCKZMjpD4ZvcVO/TXbg9tJBw
	 9Dlnp27D5Ma4XIAR1hPtNOt7d4PXkysH9pPRJISuXqTvvfmwxJksgnBmuZH2Fl8eY2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470895;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=I6xLghz5H9I+4KRL0++50cP7pz5F4KKwdpL8TpdIoH8=;
	b=daw03eZIWlaaVVDOBDiLx6pf2kIt1jr4BXWK3KyJsWSWelXvTBYr57ATfokBN2JcJGQ/
	 e9/IFqX7RCDwz7Ag6kJqkdma1MFhbNPu1AppbfwFGEZkuih7/xETCAxRY4/9m4/t/wU8p
	 pYdvBj721WMnkwHlo77pWwW1ZTZJMKECIouR4MkYzQejdwhWdrHHK6XqT+0Bd8faU2i7z
	 xrBHu8alD10fEVI1MkV+Kko49vJVI8rAYfbM2G2u9y4Zwyn3rA4HWYbUsrzyQ8/FGrX3p
	 9lXfKpbVDrkGuWjPVYXifA9c7n/ryL+AjWuHgtIfENW7CWFeH/P+HJJSDIoA+xIwNkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=jlpTw++h;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848D606A327
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 08:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1848D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=jlpTw++h
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9606A1675;
	Thu, 12 Nov 2026 09:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794470885; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I6xLghz5H9I+4KRL0++50cP7pz5F4KKwdpL8TpdIoH8=;
	b=jlpTw++hrDxhhvu4ks0ockODMgBcFMoDa1eRm46nLmI8WmJYPPIjNZ6YvSXrXIRs/hC0dw
	qgfsNEcu/2PwSeRuDxjSCNC04KqloT+Ry8k2PWKrwnh1t4hWxu1d5vw8AB2qygCI7+vVRW
	omr2fFx2Dkmj65R71U323fUcdTFCUYLzgyRyIt0W/vNortPN3WkZV8DCqiMvR17VaxyrYk
	t1BXIQM08TDyHQHJZGzSGKaH8vpdctY8nGx9fBbeuzIZFKgz6Yy3JUJe4/PJDBVaTDQcqx
	vB6xnB0gWHfBsOorcPUo9nvhBJxrLVQeShI7lqGP1QHvIFPPviQa0TsbweUzXA==
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 09:08:00 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Dan Carpenter <dan@cryspen.com>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Kartik
 Rajput <kkartik@nvidia.com>, Fan Wu <fanwu01@zju.edu.cn>, Frank Li
 <Frank.Li@nxp.com>, Karl Mehltretter <kmehltretter@gmail.com>,
 =?UTF-8?Q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: amba-pl011: Fix divide by zero in
 pl011_console_get_options()
In-Reply-To: <6fdea544b2fb8f4226e296a952331cd42684474d.1794315353.git.dan@cryspen.com>
References: <6fdea544b2fb8f4226e296a952331cd42684474d.1794315353.git.dan@cryspen.com>
Message-ID: <3726053453c5abac97e4fe90bf40d205@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Dan

On 11.11.2026 10:23, Dan Carpenter wrote:
> When you boot QEMU with -kernel and don't set a baud rate the ibrd and
> fbrd values are zero and so clkdiv is also zero.  It results in a 
> divide
> by zero.  Most of the time people don't notice because on
> qemu-system-arm64 when you divide by zero the result is zero and
> everything works.  However, if you enable UBSAN, then the divide by 
> zero
> leads to a crash and the boot fails.
> 
> Return early when clkdev is zero.  This leaves the baud rate set to its

nit: clkdiv

> default value of 38400.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan@cryspen.com>

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
