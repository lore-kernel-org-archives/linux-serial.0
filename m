Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F72528EB
	for <linux-serial@vger.kernel.org>; Tue, 20 May 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753495; cv=none; b=DEoIWu0xwcPSnaeSXCvmINIcfqIDh6uaU4Z90fv7CLuWFTEuQ+gH3VQeZELaIxos+2LYBMuGJf7qxjr065G7aDeWbFcCFfShdOyt5pvhm9C0MLwFCYUQIFgGlu7Vo12gZH7yBR9OxiJmKnJhDmcLXdTWoUPS7TNtB+urZoHR3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753495; c=relaxed/simple;
	bh=CR4qWjJ2rSzRmG6I2MqjQUHOJ2swJQ7HmUMMkmp8R2o=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=jRKdgwECB3M0X3JgAKX+72trg0tyjldvyt+rBebKkKrIa0BGzoopI7CSry169vNPBfHie2+1kFdGO98sKANmqrS5WCi5FG8FIf3mHCAtbY2nedeR6Ee/6ZToVyuOZjl3Nn7bEYHCFCVkPXIyYhL2a8M8Pn5YSO7jzAuLodUorKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=null-ptr.net; spf=none smtp.mailfrom=null-ptr.net; dkim=pass (2048-bit key) header.d=null-ptr-net.20230601.gappssmtp.com header.i=@null-ptr-net.20230601.gappssmtp.com header.b=YeiOoM6i; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=null-ptr.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=null-ptr.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=null-ptr-net.20230601.gappssmtp.com header.i=@null-ptr-net.20230601.gappssmtp.com header.b="YeiOoM6i"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c5eb7d1cso3689262b3a.3
        for <linux-serial@vger.kernel.org>; Tue, 20 May 2025 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=null-ptr-net.20230601.gappssmtp.com; s=20230601; t=1747753481; x=1748358281; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8qt2AMOwYQBn/iXfBtf2T9ZgjdnCumetSBveJiLr4T4=;
        b=YeiOoM6iXWIjvXn07bfNETGccoQ92pTQn1G+sIJ6cZuYUtk1gaIIFHnEd3C4tWXwuF
         nPmEw8SIqUIHHA8WIzaiPhVDfqLp0cx1U5xJ5njM0bfaKNl78NSW7TBIwrxRuniTUtjt
         c3SLUcFQEskjOh5r1UxCw1FRRabD+AM5o1cxaz4wGD4YD8a9VjmOzlJzkQ4sn8/w5KWx
         vDVTh+XpnEIQgfFFETxwItBPIslVgpDC+cKVEGSC7hfunfU+lxy8xuoI9VfaJtKvV/mv
         baD3heKXJMnibK56MdatfLpJvugkghYERbNu8exfRLApn10+q3zjvLTpAaV2olIQX+U8
         WNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753481; x=1748358281;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qt2AMOwYQBn/iXfBtf2T9ZgjdnCumetSBveJiLr4T4=;
        b=EXml/PfRZ0XeeXySwQQA7a7kAgBm05Xp+2vVy9fqf6Kcux77NvDg00ONJn92/S/osC
         oW2IH4k20w8RNP+nSIcm0BRHeyBgKBcFReC2lrMnLFLIUmWMLxZd5UmEODX5mVgy8+n1
         Ab0OIRniaHAVEQEe2x24iJCJhWeHtv6YBnyrKyiCZWFSURovLAmncl/Q96evxy2HPJiL
         4OGnfR1lvPeAoPPNLCBhkrz21bUIV2BDV8ZqoOD1hvxirBfaxEyFNOYlXE906xJZhrFo
         RdwSyC5b5NBUTj5dpwLvEeXhnfjcs2WOGlVfZY7O4KlY2flrABJIgFUUO3jm0IjUX2sr
         r+ew==
X-Gm-Message-State: AOJu0Yx4RZ35oDYXK7SzJFpA9UDJjm3QiQTAQ6nKqBxNPN/FnVn9TWjX
	eQHPOUgcyfLGvGlLSLuPaDT9vstdWUL9N8aCGRpO+QsH3cIss8u5axXmJiPBXyjHkXnc5blhYD9
	ra8JFZ3o=
X-Gm-Gg: ASbGncsn3lEMOLR+oGSsPX2cE+6rIy7HfewcSXNEbAO0HnQ9FQLGQMPGkCktTP9zSV/
	EJEBV/WAEj2jtaiXrqTaIa7YheCgD1VQnMOu0FcvSua+fArxtrwxr69YTYUIGBEe339ZmgEdfUk
	dGCUbuICovxpjcO27ig2ZNN+hBsm+ltmRdBa5UVaIuZqYzoFtNcj4wRqvFK5Hco4u4PBwSQ6n61
	6FPmWEWqZPBBkaOLKU1qw1wuBxuuJfnxhyjiq1z7MgXg690nb3AW6zrxHWYC7Tckc3BpnC3p/HL
	X6uXjlHZPjwEIBXwuOFcW3veSrP1j6kqyo/FeKv15D3AahJosQWBVKwbq8mM6UiSOgzBnYKUQS4
	0DpGCbFJp0Dw0I6I=
X-Google-Smtp-Source: AGHT+IHUnZ1tmrsd4d4ov2wUOKLkS2xykDRBuz9U2ImOWJ9EgYi+XH0++plY+sMvKkwcXYxHO7/AWA==
X-Received: by 2002:a05:6a00:3c89:b0:742:9cdc:5cbd with SMTP id d2e1a72fcca58-742a98abc68mr20370226b3a.17.1747753481233;
        Tue, 20 May 2025 08:04:41 -0700 (PDT)
Received: from ?IPv6:2601:601:600:19d0:223:a4ff:fe0e:1f8? ([2601:601:600:19d0:223:a4ff:fe0e:1f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9878b53sm7983972b3a.152.2025.05.20.08.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:04:40 -0700 (PDT)
Message-ID: <624cb205581e6bedc205d07d633587e389ee1582.camel@null-ptr.net>
Subject: [Resend PATCH v2] serial: jsm: fix NPE during jsm_uart_port_init
From: Dustin Lundquist <dustin@null-ptr.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Date: Tue, 20 May 2025 08:04:40 -0700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Dustin Lundquist <dustin@null-ptr.net>

No device was set which caused serial_base_ctrl_add to crash.

=C2=A0BUG: kernel NULL pointer dereference, address: 0000000000000050
=C2=A0Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
=C2=A0CPU: 16 UID: 0 PID: 368 Comm: (udev-worker) Not tainted 6.12.25-amd64
#1=C2=A0 Debian 6.12.25-1
=C2=A0RIP: 0010:serial_base_ctrl_add+0x96/0x120
=C2=A0Call Trace:
=C2=A0 <TASK>
=C2=A0 serial_core_register_port+0x1a0/0x580
=C2=A0 ? __setup_irq+0x39c/0x660
=C2=A0 ? __kmalloc_cache_noprof+0x111/0x310
=C2=A0 jsm_uart_port_init+0xe8/0x180 [jsm]
=C2=A0 jsm_probe_one+0x1f4/0x410 [jsm]
=C2=A0 local_pci_probe+0x42/0x90
=C2=A0 pci_device_probe+0x22f/0x270
=C2=A0 really_probe+0xdb/0x340
=C2=A0 ? pm_runtime_barrier+0x54/0x90
=C2=A0 ? __pfx___driver_attach+0x10/0x10
=C2=A0 __driver_probe_device+0x78/0x110
=C2=A0 driver_probe_device+0x1f/0xa0
=C2=A0 __driver_attach+0xba/0x1c0
=C2=A0 bus_for_each_dev+0x8c/0xe0
=C2=A0 bus_add_driver+0x112/0x1f0
=C2=A0 driver_register+0x72/0xd0
=C2=A0 jsm_init_module+0x36/0xff0 [jsm]
=C2=A0 ? __pfx_jsm_init_module+0x10/0x10 [jsm]
=C2=A0 do_one_initcall+0x58/0x310
=C2=A0 do_init_module+0x60/0x230

Tested with Digi Neo PCIe 8 port card.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers
to enable runtime PM")
Cc: stable@vger.kernel.org=C2=A0# 6.4+
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Dustin Lundquist <dustin@null-ptr.net>

---
V1 -> V2: added Cc stable, corrected explanation, added backtrace

=C2=A0drivers/tty/serial/jsm/jsm_tty.c | 1 +
=C2=A01 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c
b/drivers/tty/serial/jsm/jsm_tty.c
index ce0fef7e2c66..be2f130696b3 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -451,6 +451,7 @@ int jsm_uart_port_init(struct jsm_board *brd)
=C2=A0		if (!brd->channels[i])
=C2=A0			continue;
=C2=A0
+		brd->channels[i]->uart_port.dev =3D &brd->pci_dev->dev;
=C2=A0		brd->channels[i]->uart_port.irq =3D brd->irq;
=C2=A0		brd->channels[i]->uart_port.uartclk =3D 14745600;
=C2=A0		brd->channels[i]->uart_port.type =3D PORT_JSM;
