Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742157;
	b=Xl5qkJ6/RoHAcFxJIfI7iVDcvrg+DGXbHR5wKrhMCWFY75lAEGkWe3rcLL+pBpTCi40G
	 x6sKk0aZzc6uZ8Dh9N2Bmyp5URYE2yJd41wN8bniXieeHK27UzIwEg3NH/at4yBbMsXw/
	 +LT3NQGUYGcWnFkabQIxwm5+moQB98gpU+Auj3STiCNI0q8sqtkXsOJIkcUjsZqTMclTV
	 yWyDHBLg8gMQY1pfR0FoZ6QPZZgn0W8DOXsq63UeBiSEQFtO2O68dNKStNBdTOImVEOzo
	 H+1c8sBWwUA0khO/QLKpevhfOBe2HyqPTNUrhxS5IIt6g5M1XZ9z8BDJGHvM9JJ253w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=azPPo8H7+DKD17rL0rWwBjVEKBbc6amwqtN9WdKwMgc=;
	b=TogbEyOcG/T4zIX0URwXWxyl2mn2PVTAwT15Nmf2E3ARE1Il9fUB2EZo0BHiBdG9m0g6
	 vX+TiD0rZgHlx1oS9kJh+NXmO229i2DJFGEv4y+uInSiZq+eKsMxGicmD1dvWvCk7Y686
	 UGMcbAfGNJz9L4aQgHPK4hmISVsslUczYE+QRPstlR/zj8qFkZzS817NXUpFNG5kPg5ep
	 LpPBTy34XmOhkp/KTP9a8ul7f6C2J8IQXSNvTYCtsbKTLfgmNqIbAC1DVPV2TfWmvlmLh
	 c2q5zBWbicgQRbAZs/DthzmUbSbMzoGNBx8DUIT4TlKlRJqw8O2txtvIkBv+KbuENTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uG0kV9tr;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A434606A328
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A434606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uG0kV9tr
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b244fb7fffso139234c88.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742155; x=1794346955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azPPo8H7+DKD17rL0rWwBjVEKBbc6amwqtN9WdKwMgc=;
        b=uG0kV9trF+tpH5NGG08X2nXLCYrNuuLYjRzsFhR+KujNcKwgdzFodzwzUBThLeO40q
         bFtlq26uYDUXkvc+hIE/0/HJE0PHd8x92/AmZQEDmueeUixdh1+ORtHEJtJym0HCvpbk
         O1FRmG1pWdQ+4Y8DQD9eF9sO1K4IZvEk2XebYJVfvCd2haUghPNIfioNcdJCeSztKlgH
         lx18/3kxQ6WxcLja3A8ZpVfnwCY0hBGaYu3BJhU7I4Pk/omDVcKwZ1WvjsK3dnLp6Jy/
         Rhpn4FhzTB865NMRltmKeeOwlgPwk3q+Xe0QazrIkT7TyVn53BjOE4Jd9dgRsE2Q0myk
         eESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742155; x=1794346955;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azPPo8H7+DKD17rL0rWwBjVEKBbc6amwqtN9WdKwMgc=;
        b=Tdvv3lGc4nPTFZSSz8eiXlJzrXguVdjUJ89nDzZvbM2Q1SWPyT0iGHyCn+O3cdgt0R
         g9c+lH6nQFmadT5kn9xf/Vgw1L+1bo2EDVA4aL7Q4hNKqhoxLKPmmkgVWR85aiI8E63M
         Z+7d6qfsBI87yQXW97ChW6zUPElU6hCBD/DdjhvSSNCbNeGF8yyiMjGY+iLSQ3AAFiv9
         vv6vW+GTeabXGfAzo/2rvQR0WzRVMRAGnHddVitoa+h1Pzm4iuSX+NBeDJmcPmxayskG
         q00J5f0SO471ZYLvOlHpYX7fRoGu6jSkXkpCKNRINXpNQV3Gc3RTuJjCOEhocnXJIT4F
         Wdtw==
X-Forwarded-Encrypted: i=1; AKwUvBxdSJPXlvGBlsEv0tfA8FYJpp8AcKaqEMcJsbAPi5CloLjZ1GsCr/LZ0RcB1hlKWcbLq9uCEN8/gv+yWtY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NefGo4vBXxQEP6GVwHDmjg3HbGiAiS0qRHRIfJhrCl/FQh3pg
	syXJrt75diZsHnF2lPwjAWLrF150exIOpzva0qKQYGYiQxH0t6mo5228
X-Gm-Gg: AYBFou2fjeJ7jFunmeJ7vo3T+DcZn9XsyjreMz7fa17G3BVnug0DHaj31QcBPLq8ITQ
	16Z4SBXWAElUCgbN7WLxiavSIPivrhEUCE1EMgVjeCJD2RGNEUrYLm85LIwHHzpVdvmsA3LM/zi
	zjwPco+sWBCJYoq4xHD01tlP/XbRQ72vV09uNFZUSZb+Nepri0DMGZSXX1KdwsHaUElqZN2s47H
	6lSrjJV1qiwa0ut0dnL7ypbr1KQPIzhvp76zyi0UNgVbjvA3fFGaDIO7Q5JlliDJQqW4zp38UTb
	Pn9fYbhtqhC8MlqbVaWWcOF282hbrRyU+4h4MnY6cURYOIVEsERqLOM/vMS1iM+4Ib12pZsb0hB
	PVa7cCVuIaQg1N9xDJAG1uqJg3cSzAjDz1KufLrHkpg7zrzBXL5SXx53laJaO7l97CM65KyuMrj
	YbyRobR5wT0VIus1RZ1S7ira/p1G0KQU4UjDqrP+mKW9hPe4XpnLNjtXlcWEOqleZfTfQYrvS7y
	dUJJekLHsw+2H2NgSk1TbHDv2uWS88q555Uo6ZULfd7/EXT+pm0Ee0I+ObmoKsz67aJthOPzOIG
	XyYkXnhh8Poq1kaKnCbqia5ofesDh4+1VxDcTlV7KdRZHXA6snGH0hQ=
X-Received: by 2002:a05:701b:4349:b0:1a9:d04f:1b55 with SMTP id a92af1059eb24-1ac5d0da4acmr20007496c88.26.1793742155167;
        Tue, 03 Nov 2026 13:42:35 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c69c3fsm1460505c88.20.2026.11.03.13.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 13:42:34 -0800 (PST)
Message-ID: <e211bf3f-d696-4bc5-baff-e27b933a89ae@gmail.com>
Date: Tue, 3 Nov 2026 13:42:33 -0800
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] serial: sb1250-duart: Convert to use a platform
 device
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2608060322360.55540@angie.orcam.me.uk>
 <alpine.DEB.2.21.2608060406470.55540@angie.orcam.me.uk>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <alpine.DEB.2.21.2608060406470.55540@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 03:54, Maciej W. Rozycki wrote:
> Prevent a crash from happening as the first serial port is initialised:
> 
>    pata-swarm: PATA interface at GenBus slot 4
>    workingset: timestamp_bits=62 max_order=18 bucket_order=0
>    Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
>    CPU 1 Unable to handle kernel paging request at virtual address 0000000000000208, epc == ffffffff8067f8f8, ra == ffffffff80666330
>    Oops[#1]:
>    CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.19.0-dirty #27 NONE
>    $ 0   : 0000000000000000 0000000014001fe0 0000000000000020 ffffffff80666130
>    $ 4   : 0000000000000000 a800000100e6f118 ffffffff8112cbc0 0000000000000000
>    $ 8   : 0000000000000002 0000000000000000 0000000000000000 0000000001a80000
>    $12   : 0000000000000000 ffffffff809fd488 000000004ddf14dd ffffffff00000000
>    $16   : a800000100e6f000 0000000000000000 ffffffff8112c1d0 a800000100e6f000
>    $20   : 0000000000000000 00000000000004d0 0000000000000004 ffffffff8112c1d0
>    $24   : 0000000000000001 0000000000000003
>    $28   : a80000010007c000 a80000010007fcb0 00000000000000ef ffffffff80666330
>    Hi    : fffffffffffffdb9
>    Lo    : 0000000000000035
>    epc   : ffffffff8067f8f8 __dev_fwnode+0x0/0x8
>    ra    : ffffffff80666330 serial_base_ctrl_add+0xb8/0x180
>    Status: 14001fe3	KX SX UX KERNEL EXL IE
>    Cause : 80800008 (ExcCode 02)
>    BadVA : 0000000000000208
>    PrId  : 03040102 (SiByte SB1)
>    Process swapper/0 (pid: 1, threadinfo=(____ptrval____), task=(____ptrval____), tls=0000000000000000)
>    Stack : 0000000000000000 ffffffff80cd5178 ffffffff80cd0000 ffffffff8112c1c8
>            0000000000000260 ffffffff806655c4 a800000100275bc0 ffffffff8064ac88
>            004000408112c000 0000000000000002 0000000000000000 ffffffff801965d0
>            a800000100786ba0 ffffffff80cd5178 a800000100786ba0 0000000000000004
>            a800000100275bc0 0000000000000000 0000000000000000 ffffffff80cd5178
>            0000000000000000 ffffffff8112c1c8 0000000000000260 00000000000004d0
>            0000000000000004 ffffffff80bf0000 00000000000000ef ffffffff80d171dc
>            ffffffff80d17120 ffffffff80d25658 0000000000000000 ffffffff80d50000
>            ffffffff80d2f928 ffffffff80d50000 ffffffff80d25698 ffffffff80cfcecc
>            00ffffff80b84428 0000000000000000 0000000000000006 0000000000000006
>            ...
>    Call Trace:
>    [<ffffffff8067f8f8>] __dev_fwnode+0x0/0x8
>    [<ffffffff80666330>] serial_base_ctrl_add+0xb8/0x180
>    [<ffffffff806655c4>] serial_core_register_port+0x174/0x8e0
>    [<ffffffff80d171dc>] sbd_init+0xbc/0xf4
>    [<ffffffff80cfcecc>] do_one_initcall+0x64/0x150
>    [<ffffffff80cfd284>] kernel_init_freeable+0x25c/0x30c
>    [<ffffffff809ff6e4>] kernel_init+0x24/0x118
>    [<ffffffff80112d20>] ret_from_kernel_thread+0x14/0x1c
>    
>    Code: 67bd0010  03e00008  2402ffea <03e00008> dc820208  67bdffa0  ffbe0050  ffb70048  ffb60040
>    
>    ---[ end trace 0000000000000000 ]---
> 
> -- where a pointer is dereferenced that has been derived from a null
> pointer to the port's parent device.
> 
> Since no device is available with legacy probing and it's not anymore a
> preferable way to discover devices anyway, switch the driver to using a
> platform device and use it as the port's parent device.
> 
> Use platform_driver_probe() because SB1250 DUART devices are embedded
> onchip the SoC and therefore not that straightforward to remove.
> 
> An unfortunate consequence of the switch to a platform device is we now
> hand the console over from the bootconsole much later in the bootstrap.
> The CFE console handler appears good enough though to work so late and
> in particular with interrupts enabled.
> 
> Conversely, only starting the console device so late lets the port
> initialisation code always use fsleep() for transmitter draining, so
> drop the other variant since it is now dead code.
> 
> Since there is one way only remaining to reach sbd_init_port() now, drop
> the port initialisation marker as no longer needed and go through the
> channel resets unconditionally.
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: stable@vger.kernel.org # needs to use .remove_new for <= 6.10

On BCM91250E (Sentosa):

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

