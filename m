Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43FC436BC6
	for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2026 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662696; cv=none; b=TPtUINpOsKY5T8dx/TIYNC51/CnFFAkyXhEkTjXFHXWRwy5NsY/rcSm+0oEs5GKLFejIKVbtETAHpV+kPvRQE1wsav2dvbmlM30nyUMiy5qFZRF+d4EDXVS5xaF0bRz5YPHCaE1A5oDWk5jodpdPfABgV0fpkLb0p9uW6oduzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662696; c=relaxed/simple;
	bh=6M8b1p+ST8nuue596dbyURkJ4CV4UWHAuUCuKNISn4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qp9K5TqIdQS1NeDrhpbyh6Hc7I+jwIBMB03Y++TLtF8eFxK+htbo8kXblnoN5shWN1R/xak5cm6AeJebEUhJW9+u1NeJ+gvZ6il3MS8kmYFTF8pnKc+/hTveQhMycP7iweOiR/Ha1NOiEFFCKp0gPhWgoe1deIq3tVteAHUTpxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzVsGWO1; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzVsGWO1"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bfbbe5220dso2349614e0c.1
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2026 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784662686; x=1785267486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6M8b1p+ST8nuue596dbyURkJ4CV4UWHAuUCuKNISn4g=;
        b=LzVsGWO1uYPOH5XFei40fhfNGqSyTygvSSkwmCTwG5Jp4+dziDDSvOO8Og0qigp99c
         1xq1GbouPFijgUNwH07CVCiJS4U28gwGsUb8RPVa1rg3fqhCJqIvOFXl5et8ZP+1Zatw
         bVFGkP2zz7g4qffmsmzsKBgFBF9jJ16a2rysHV+sbBjZR3EN0H/M4L/nzQzvkCltO2k6
         zQWeiA0t1/WXNuwNhtNC7LzZ6K8ZO8ReSksMbs4T/3F/YQrzIcswaECcSpFVYLAFhllW
         k+vGTcGg0kuEA4hu0OLzXNxuDvKyllKU7Gu6sTqogu4HWSPmoanthq1UhAxKNzJKNd9u
         g32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662686; x=1785267486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6M8b1p+ST8nuue596dbyURkJ4CV4UWHAuUCuKNISn4g=;
        b=rGEtNILg/KU6/57sW1PzhRqtsSjmwaxefsn2Cl3GkaJDwXL6jALFRgiSgTXCVtuLqH
         QGHZfXeWVPt2YaI6S1tNCavo/bNhnUBRJEp6UCKpNx4ogZklDM7kKTkV9L9SNuH52JFi
         J5LXQknJVPBW9ZcFpc1fQgyL99EaFSq20U9BDjnauz6OangZje3aqnpFfn1GgU2nUqm6
         LdOQUGeBjolNb/29VYGtE+sIF/ALznN+tNcxhxIduTZqLOV6k1vx+Pnhnkr1l/S7cgSf
         0z6Av/QG0ECkJEMvcJdUqF8lFT+V/PDFeBPEirYMEFf510YcSdVHjG29K9UX1sBnYkWW
         noLA==
X-Forwarded-Encrypted: i=1; AHgh+Ro6A/p79+8Rs5PjjBX/64RK7MZkfgms/oDObGC7INH8sk12DJbyYN3QbO2K3C3BYLjBfQicRLXks3OQVt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rbLjlOyr1+Gz/LxpoPa1hedPdFVrFA4vE+tFJMWhENDhTnxB
	MNcQKopcSjEKOcE3bp4dl+okyvjM/lWfj1f/s2wyp8teEVrLaVmd/RM=
X-Gm-Gg: AR+sD13Ghv1n7GIenhEgp7xMHgh8UA7yp7G16xEqrHoARBRGtodRzycRXlbpmrRWfIP
	4bUajsniRcJ8lJbO/cgc0bk6ziXP6hJDWGBSdJQcBV1LjI39YICgrLSrLL5pdnDsnyi1FSEvFWl
	i1WdakSlcXKQxMnj5v7NCjcZmjrC26wQX9fhM7g2BK2j9TBThi3cdfXN7Galn5m1G48f+LdL7P6
	gSmPJMeQ10WGgiln03XQ8SLknRneZ6yO8o6A/DU1ZgvDzwYRlqNvw0BVSlLzcljfZLfE7CbYSM/
	8v9d2IFHH/Hf5tzDzQfdR1eNyj8gm7cjxlOwMwuk4n4GxwaquiXNGjPWKk5eawhJWW1XDSd6LXa
	iR9qVYIlEusWD5zNyRYOp9HfkHJKSgjdHJPjRZ9x4d43Pz/rm0rsi0EkxRBa4zlKwx4JJe1f+dL
	+QaXck9h8ZAJO/EUnyaMH+IVcPL102EoZ8h6+p7t7fRmKOOFvc38raK0g=
X-Received: by 2002:a05:6122:414d:b0:5bf:6d5c:8cfb with SMTP id 71dfb90a1353d-5c2c3be4ef1mr561179e0c.6.1784662685993;
        Tue, 21 Jul 2026 12:38:05 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c2c648944esm390996e0c.10.2026.07.21.12.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:38:05 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	hvilleneuve@dimonoff.com,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	m.felsch@pengutronix.de,
	rwilbur633@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250: clear a stuck RX-timeout interrupt with an empty FIFO
Date: Tue, 21 Jul 2026 16:37:51 -0300
Message-Id: <20260721193751.22760-1-rwilbur633@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c8a74142-5704-5ad3-3504-946bf3496cfc@linux.intel.com>
References: <c8a74142-5704-5ad3-3504-946bf3496cfc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I suspect Andy meant you should put this into hw specific file into a
> hw-specific handle_irq. That could be setup in 8250_of.c, it already
> seems to do something like that for some specific type.

Thanks. I'll move the fix out of 8250_port.c into a PORT_LPC3220
handle_irq, wired up in 8250_of.c the same way fsl8250_handle_irq is,
with the handler logic following dw8250_handle_irq's empty-FIFO
RX-timeout read.

> (8250_dw include check for LSR_BI bit and this one doesn't seem
> include that bit, not sure if that's an oversight or intentional
> difference [...])

The missing LSR_BI check was an oversight, I'll gate on
!(LSR & (UART_LSR_DR | UART_LSR_BI)) to match dw.

> So 3rd alternative would be to add e.g. UART_BUG_SPURIOUSRXTO but again
> there are the per driver variations. [...] definitely cleaner approach
> than copy-pasting this code around.

I'll go with the per device handler over the UART_BUG_SPURIOUSRXTO
callback because I can only test LPC32xx and I'm not comfortable touching
drivers I can't explicitly test against.
