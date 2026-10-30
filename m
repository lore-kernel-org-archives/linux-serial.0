Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361523;
	b=Bz3NrKMfyY71rCRrHACDK8E39SNhmf6DFpXrrBFA1+fOwhXdgCPN51RTx0PrMwLFbHje
	 7aVvhu7WYIhsGpiXURKr2oE1VZoShgY4rnFWQsa3qKMLcWWCTtb1KLtE823qBaXIVjG8X
	 jLHG8yd5nXkXu3eeWEstMW8P/iNuFGAkWOp3l3BNJYuBt4Yz1fzcmcNem6xcAI3ZTD/7R
	 A0vFkZBlNytSNn+Kd7cdbgUwxzqsmBtHcciVcqfBcX+u6JTIr2FnTntv9JSn+BvWhbeKx
	 /uNPCPBB/Z66IKKO75n3T8rXp7tbdHzQpWZKG+UDmSF/FND/a8pX0wf9o9uCu3/fHzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5Nr1WKgza+AgQYQHg2wjswGtM7GwVueFVekAPuAhG4g=;
	b=yplyiMLg04ad3heqvYnGJW0fwgV2YR9fizUMpsZ0DONPd6WtT0v7qHeAYiCIk1RF2rBo
	 GDramIZnicwAkgrlEp9LVkIvP8jpB1ryt5OgaP1/p+lRKDhmoWutK28Gdl2a+I5/54EwJ
	 8tuZxozXf4nHnURkbxK7JAeNe7K61jpufxMUkMmwRTeNahJL6G8k3BLeRmCIJ6QoOCaGd
	 r2n06v0b7Vz9AgRKsYIw8lyNq8zk1b6CyP5Y4DnieWu1JWqj3Oy/lE45pJD9jtURQO/80
	 K6MK9K2XqkwBHX2oVBZBwIMwgwc2HJOkQUGiwV1M93rOf6PmQr/yGjvCX7EVmfFVw0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EzQjvSxP;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F802606A31C
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 11:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F802606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EzQjvSxP
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9d1114320so4711695ad.3
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 04:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361522; x=1793966322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Nr1WKgza+AgQYQHg2wjswGtM7GwVueFVekAPuAhG4g=;
        b=EzQjvSxPLHZXl/YZUNvhgfWaApbPxlLlU6lJhGVAvNMA4rNTgQOpyqeOVoJV7wz/Kb
         l+ASFxCoumgSCUkrwzDw/RTdHWAmjwsjPtBu1godxRU2UACayyhZ3c9SHHf+PL2nudni
         MgAdtl861Otv8vDOWivq5XgCEzu7N2L3YtUQy94Z9r6BbIkwFej5Lch0JH4K3e9Pt0xI
         Br6B/q66ATElm15E0KXrqo4kKSW6Sue1etWi6ajgVNCHT+CT/oIGbvZCr5nqA8EdS7Xe
         hMMFuDkmIt+MxFsy3eGgMo34KC5dVpGH3kccckKUqEnGTECHpddHz89LseuJkB/45Yhk
         04UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361522; x=1793966322;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Nr1WKgza+AgQYQHg2wjswGtM7GwVueFVekAPuAhG4g=;
        b=Nqp0yYkBTOXVSCtb8VrHK0lq1gsZzNQ02rCJYlPc+n+RD8INrxcVRwv499jOXshJNx
         G52ezPTFxFW0c0MYcO3bpzXwXSlyvCnJaTsYdHTq7P65ZBSkj4vYM3Wm6YF80O68K/N7
         IP7UbpMVfz1L8RcqT2g0+aB6+g4JSXSBPM1krSSdywGXaPRHYXKk9EYVckaPO1kK6c/k
         /R0HUzeZqukhvO4oixmRWZhUROdWI4VAN0L/iSn/h7rbDNi+TkXV/wAOh7q/le69mGw2
         eykpLHPnl80yOwYHsAuVmHZ0R+97EHwzgLQwswL2O8Ct+hxfB+BdfZxnprMcwAxh13oK
         TXzw==
X-Forwarded-Encrypted: i=1; AKwUvBzwTP1b4hSVsMVPgP5Y6f9WFNUoxCapcuGRlS70ZISv1PanZSkzYGfiFPrtk+FsmpMRO+KjyT7uKIaOck0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIO6zM77OUMXNKbHZj6ToFaYc1eDpFRNYw7/Lvt8T3KhgIgMygj
	615BdY++cj6HT35y2N3Un7cYBdOF8lWSpaawK4EDBGu58a+HSpVB/Ojd
X-Gm-Gg: AYBFou1k3Q1HQAt4e+qTNuhCZmHAH74OlAe1oQ71R9pCWgYBJZSPmR0Ixuqa+5Glwr7
	QjGJyUpWzbGRvj3/LcpMjgfttFOX3C2NXCLmZQ7Ym6yI++jFGLZxhYi9cak4ri5my6bPsQwxgGB
	yq1QU9iZeSqgkhBt84Jzt7HRp5kMT+iCdwsH8+kLWE6Sw4DJO/Hepz4ZKGHgJcDG93EtCubSUDa
	r5ID1cQKEyXQ+AJtrV0+Mfex3tgeyONGBjmHPHmu/yJ++hHcrH+BgYS1jeDXf4u9C1dojQlrYMm
	YvvuumUtgDLjsjPMo9sDeMh161qdpfZJBfuTTp+EcW8K0GksOMY7FZufEWGKu7GvQ2ExZcME9KJ
	wOHWVn7XGwi0L2bXi0zDmXit85bSvOEudn0+pI0zwrz5d5eAtZ7W0DXGUhaAwGqGjG8vW40QfFU
	Cdb7RwbSDu7j9JGJxz8EapaclxVEZtByRhP3X2Aqtx7jh9JXx6r1F6lhJN8QbsuyqCWL++vgL68
	mWy9A0yIyCwHv/c28yhv+9ALpbO2dazDlTWvwcODNgyu9qnc9jxiXDjcEpJ4Zj8XGcJ5xyiz7/L
	BE1PtSIB23gIDefSGOeXKw==
X-Received: by 2002:a17:903:230d:b0:2e9:6788:9372 with SMTP id d9443c01a7336-2eb36515de8mr22854405ad.62.1793361522377;
        Fri, 30 Oct 2026 04:58:42 -0700 (PDT)
Received: from debian ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3924c93fsm6175585ad.34.2026.10.30.04.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:58:41 -0700 (PDT)
Date: Fri, 30 Oct 2026 07:58:38 -0400
From: Kwanghoon Son <asdfkwang@gmail.com>
To: Shuai Liu <847807867@qq.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 06/12] rust: serial: Add minimal serial-core polling
 console support
Message-ID: <auSGbrP19XfI3S5N@debian>
References: <20261029-rust-bl808-console-v1-6-b736ee920078@gmail.com>
 <tencent_12B82162741365EE49D2A22CCDF2A04D6908@qq.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_12B82162741365EE49D2A22CCDF2A04D6908@qq.com>

On Fri, Oct 30, 2026 at 10:16:11AM +0800, Shuai Liu wrote:
> Hi Kwanghoon,
> 
> I reviewed the Rust side of this series (the serial abstractions in
> 06/12) and did not find any soundness issues. In particular I verified:
> 
> - uart_port.lock is initialized by the serial core in
>   uart_add_one_port(), so zeroing the Opaque port storage and relying
>   on the core to initialize the lock is safe.
> 
> - The set_termios() adapter unconditionally taking the UART lock is
>   correct: the serial core callers (uart_change_line_settings(),
>   uart_set_options() and the console resume path) do not hold the port
>   lock when invoking the port->set_termios() callback.
> 
> - The console callback accesses to driver->state are protected by the
>   ownership chain: the port holds an Arc<Driver>, the console is
>   unregistered before the serial state is freed, and removal drains
>   the console readers via SRCU.
> 

Thanks for review.

> One thing to consider: SERIAL_BFLB_RUST depends on COMMON_CLK, which
> cannot be enabled on x86, so neither the driver nor the abstractions
> get build coverage from the Rust CI (allmodconfig on x86). Something

I don't understand for now, COMMON_CLK not possible on x86?
or you mean CI not supported?

> like "depends on RISCV || COMPILE_TEST" (with the clk dependency
> handled for the COMPILE_TEST case), or splitting the abstraction
> Kconfig entry from the driver entry, might make it easier to
> build-test.

> 
> While reviewing I also wrote KUnit tests for the pure-logic paths that
> can be exercised without hardware. The patch is attached; results with
> kunit.py under QEMU on arm64:
> 
>   rust_kernel_serial: pass:8 fail:0 skip:0 total:8
> 
> and CLIPPY=1 is clean. Feel free to squash it into 06/12 or keep it on
> top of the series.
> 
> Best regards,
> Shuai Liu
> 

Best regards,
Kwang.
