Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978184;
	b=kQHME9wjRhzwxHUsC+Bpm0T8oEacRBP1doIEqi8gww8aCJOOyJp9Ucg1vv8TlRL18rLP
	 V5t2C9TVHR6x7C/HFjwsQXlyEHp8dFqKbFvYRKPlXvvNeiM6SGNphx97tyJ4R9Om3qZZ4
	 xKuPPNaZ6/6xBbNt9LvsP4gFF+S3UguFlofbqQbuYAYLvsYVeNcougIi7kSU0dvB1VDHI
	 uie8KGY7jpaUqQsa52MlkGrV8xhHWXc0Qv5fDO+/AXaljNI8FXwSCjwESaG4a+OS2M0Fw
	 2J3VNbvxa/MkjMEIUCCbARH/siFlGR9sQxvjOmMKKHdxldvjCw972E9GJgT+qfxvePw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZBDIYs4Y0It7dcl6v419n3JeAweftEEfsMmrD17e+80=;
	b=nwqNU5g92tvox/ftU3PNtGUnQLJGLMm6dPVZHFekVKHVQ7RlOb3j+9vVoRtrLI5pUnF2
	 gbQxd0orSTw9M3HRaxKIfIpJAuDblBNjGnGltl6nnE3zKQyLxTTxBtMuWP3Th0wKfJvjQ
	 WyNHrs4xvchjV9zRqeW46b869m9h1W+z2B1XvenTNcLFb6j+3/qkRVnMb7AYa6jOBc4SC
	 SecVzJij9Lwqx8H2+TvvaG3//0+Th+6LfE0E4+xrBsiBjB1oeg/dOwJbs8hyYllisKUpH
	 6zA8eVaB8HMPLi5n37tvDXiYdZyMkrQB4RWeYbjwEPUz5cOqKjdvNwGKv9ya7F0R9Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxo8erlB;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B9606A331
	for <linux-serial@vger.kernel.org>; Fri,  6 Nov 2026 15:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E29B9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxo8erlB
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso3812655e9.1
        for <linux-serial@vger.kernel.org>; Fri, 06 Nov 2026 07:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793978182; x=1794582982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZBDIYs4Y0It7dcl6v419n3JeAweftEEfsMmrD17e+80=;
        b=kxo8erlBylITXb38m1wEtnfEDV3x/yMaJ29j0q0YIFU/H5cyQrsqLj5K598Wy9weJQ
         A0DJbc4I/TN86jX1fGLlvJLWjkhURO4cOxuuAKH3apDJBtQTlXy2Qz4bO1avMzj8VPOf
         uUL7kHWf2fTP9uFyfKLeCspQFLGH1ANd+tisjKG+IgGewKu52tBELtyTjX66BlA+4FBj
         P4ys4PblaKABcVgEPv+IeHdWFIE/o3yZ0zqeQutuhpbbrCAV3N1kpXvFMBUL6v6aa0dT
         P0STpQnsN0JpWBIWLbxZUipI6nyhf6kzfxKIr0c7XQ0L7LcBGKJ1P3t8gjHWzHgYrEm/
         QYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978182; x=1794582982;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBDIYs4Y0It7dcl6v419n3JeAweftEEfsMmrD17e+80=;
        b=jP9qUkxMt1KHkqbz1yLeD4q3M/h6pdBgNURLjUFuR8pPY7zPW2wtutS3FT4eJnvsuq
         L0iSxda0ZgOAp+2reYD7MC2dKcySqmsQvacAS2Cvx99w4egX8ZIxGRk0hy/ElbiV4dOl
         u2TqWpve7+uF74BaXLHyxZOhMR/+HyrpxCz/S14KuFesrGzivB/NPuvZ9S24QfDfUq6j
         ZtiUOHwmzqjDiLb5Dn0YOl+QoIkjaBlJZSV7rNRg6CMf9GSU81An/gDsJ5Dis+mCLloM
         44BMuknWCLA9gHKEjknyyYkGmRpM1qmIe712MNmxnzMiHIar0iPwRXm5zAPJ5wjoSfpQ
         qRAg==
X-Forwarded-Encrypted: i=1; AKwUvBxICq7Un0lzqHwWhLigLwkC6sKX376krcaz6qDfSXcmik+9HgqgKnT9miTom8ZQUJeF00r4ml4NJsCrNnA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KGY7PvX36OyTzLCQpEKpj6213MGUDLOcqymfhh0CuVg1v/YsA
	R5A/o0JNRc/J5Kt0s8bw4qZzD9gvXO7FxUfpYDlGy0vzmUJWVHnlDXgW
X-Gm-Gg: AYBFou28Bzd9s+evVjXszrOhuM1ZgiiFrbJv0VvUYN+kyPR4UGxZ/0k3rwzGHf0opXz
	j46fa5FNKo/LYqdVd26Dy9MCwWiRrvVlsxmHCD2pVjq9lFmFzHnHCKVxm4IIjllA0qjXyFdwZRc
	wx5kJEurkKXofC6/8LnXAYb1fmGMg0KMl9d996m2zZqp5uOfjhUCYaH+pMVtNQ1Shm30pfnVCk3
	wLUDchZLaEvOIGOMcNSPWcnLYVXzVvcRPdqfo+XWHnjo9RoO0MMUYhmhsV8vMDE7FxyDB9O3mJt
	lOFSymOWXprGhu7m++DKtmrSgUT0VSZd3fL2z+s4tDhF5gZRmJNC5FQHUWehW60ImHcmB5Zq4cX
	btauZnRLbu/oS29hzvGOLKxHphIToeQXbIwRCiov3YA5CmPHjAaVp+u91i7NcwyF5jO1Qko4MB5
	eJVUblUVfHQ+d6uATudqBh5sCkmmihkxVc9dP+E/OA+5/57f3lN3TRLSJ2vfhxlh0OOxPB91Cc0
	mYpJvb4YjsY2cwE9tUa+joW4EMkeKn2LJdN1SVj4g1JCwVXY8SvrPFDn12zB4zdelxOlntjeQWj
	/dO95k2Yzdu+jYDTdvT6CQG8LzvjYpMuGBaLh0UEe/CbErhTPAS/EsvI0UJZGH7IAlCK11/c0Ag
	2flYBVB6yRiT87qjv6KpICvMOVXuKIDlYHWV6CbPG6f3yAEj21zGKQ8btCd5m
X-Received: by 2002:a05:600c:8509:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4b6e091f195mr44253705e9.34.1793978182055;
        Fri, 06 Nov 2026 07:16:22 -0800 (PST)
Received: from Lord-Beerus.station ([93.146.104.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc6162sm4124688f8f.47.2026.11.06.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:16:21 -0800 (PST)
Date: Fri, 6 Nov 2026 16:16:19 +0100
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	luan.r@variscite.com, alifer.m@variscite.com,
	pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fugang Duan <fugang.duan@nxp.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 0/3] serial: Support driver-selected TTY wakeup
 defaults
Message-ID: <au3vQ7sSi6O3_hqv@Lord-Beerus.station>
References: <cover.1793719239.git.stefano.r@variscite.com>
 <au3diCrF5jPYH4Tu@hovoldconsulting.com>
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
In-Reply-To: <au3diCrF5jPYH4Tu@hovoldconsulting.com>

On Fri, Nov 06, 2026 at 03:00:40PM +0100, Johan Hovold wrote:
> On Tue, Nov 03, 2026 at 04:51:24PM +0100, Stefano Radaelli wrote:
> > The initial goal was to enable TTY wakeup by default on NXP LPUART ports
> > marked with wakeup-source, without requiring a userspace write. Instead
> > of keeping this entirely within fsl_lpuart, this series introduces a
> > common serial core mechanism that other UART drivers can also adopt.
> > 
> > The new tty_wakeup_default field in struct uart_port lets a driver request
> > wakeup to be enabled when its TTY device is registered. Each driver
> > decides whether to use it. This series adds wakeup-source to the LPUART
> > binding and makes fsl_lpuart the first user, setting the field from that
> > property. Other drivers retain their existing behavior, userspace can
> > still change power/wakeup, and serdev wakeup policy is unchanged.
> 
> This is a policy decision that should be left for userspace, not
> individual drivers. As documented in
> Documentation/driver-api/pm/devices.rst:
> 
> 	The initial value in the :file:`power/wakeup` file is "disabled"
> 	for the majority of devices; the major exceptions are power
> 	buttons, keyboards, and Ethernet adapters whose WoL
> 	(wake-on-LAN) feature has been set up with ethtool.
> 
> So no, this doesn't look like something we want. You should continue
> enabling wakeup from userspace on systems that need it instead.
> 
> Note that the "wakeup-source" devicetree attribute also describes
> capability, not policy:
> 
> 	Documentation/devicetree/bindings/power/wakeup-source.txt
> 
Hi Johan,

Understood, thanks for clarifying.
I incorrectly treated wakeup-source as a request to enable wakeup by default,
rather than as a capability description.
I will drop this series and keep wakeup enablement in userspace.

Thank you,
Best Regards,
Stefano
