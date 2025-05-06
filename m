Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C451917D0
	for <linux-serial@vger.kernel.org>; Tue,  6 May 2025 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555540; cv=none; b=m4MrSgjzaF/rqPwEu3+AQLFVVY5Mb5V4zVTmYqJp2XSkNiYNvRJW+gmlA+va4dzurc5QwWDf9bSdlACSUQ/jezSBzDPkgMaRORBLozzaU+XX7RUwxD0AigzBcWEoOdMLYbdEMC2csEnxXjKc5NccLQHtIR2BtUKzlWh4hfPrbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555540; c=relaxed/simple;
	bh=21H/2Gghp+g3J/NYDL4TWX4KeoXUONEA7M3KuRV9gf0=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=P+NTEcyn/8W0LdIc6I44pdEI8mVSWOjCwhqlI7P6K3ywZRItD3wqxtsx2AxUkf4Cl189M/yJcZOhx/pm6KKWCrMBVgdxQrE3niTQpdq4T5df1rCJddXXQTpb/LpDjU+Q3wzDfWh4O9N5p+N1krlrc9tMOw/PWonslOjOm6RwNo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=null-ptr.net; spf=none smtp.mailfrom=null-ptr.net; dkim=pass (2048-bit key) header.d=null-ptr-net.20230601.gappssmtp.com header.i=@null-ptr-net.20230601.gappssmtp.com header.b=trJKoeId; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=null-ptr.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=null-ptr.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=null-ptr-net.20230601.gappssmtp.com header.i=@null-ptr-net.20230601.gappssmtp.com header.b="trJKoeId"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fb0f619dso72381515ad.1
        for <linux-serial@vger.kernel.org>; Tue, 06 May 2025 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=null-ptr-net.20230601.gappssmtp.com; s=20230601; t=1746555526; x=1747160326; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CMieWpnO6uMgKvWj5gEh/NIYb910f8NAysONdzarWEc=;
        b=trJKoeIdQi+X4JYzDE+sgYQ2sByzBF72sIsfqrmtWgMyFzuysYZPcmqhv65ARE5CqK
         9esWHJJQPHXxIKIwDBm/SZooECON+qcbtX1V4MHlqkoGuA+vF6eUjy8i7VcOiBDpMGT8
         V0RTCUNoO+MMBeDH66hX88kiuiQjpTTMOPgcSZ5toIlZPwB5IKLPA9wng5M0m7IjS2bQ
         fBg1dxlN+Ck0nvoa98iiimcnaJ+yeSmHd/+IADZcKvhEBflWQ+wW73NWSs3vUbVqrzpC
         cV+TMPIAwNC7oAlgpLCB2BWFN6Rim/1VcUh6WbpM43dAFbgNJSChvU2+dc0SUCKfHg6v
         cnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746555526; x=1747160326;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMieWpnO6uMgKvWj5gEh/NIYb910f8NAysONdzarWEc=;
        b=Gr7+r4rsmU4cDE5ud635UnEP/oq3ynraflGwWhjMzTIwyH2zke6nG5csmUzFEV5iJn
         Yy6u7/Ngt1T6kaJrJFNKeSIj9QomKtHiQ/v7hDW5c+qaTqys35zk0VtLGQh6sBxZlDdK
         VnqaKNNjbNVB6XKSXkTylkUcImvRALM+T0PV+JQCiLwMDIj032hc6x4zPDNTYSyWATIt
         rPDhgiaLR77T1w0tvd0ohqjZdLMc4BhiaOxDgq9A0CY34HaEO7rY6HCVjXOuv64g/NH/
         s0qcgnVc0aojf3WzXPEKw6c3Ipv5++okawrh8xiFG7HH3h0uJ8j+afWkflhpgk8qD5uM
         4VeQ==
X-Gm-Message-State: AOJu0YyYeeiI3SdVHKxwcrEi0N5yRF6KnkHdGMh9viBSaM5q20zILyh8
	iP1UZCGkwwcD38t8h4DPl/nhPQ6+MXT2QZsxiAICe4uQWJEc8s7Y6a3KHQF/ywYAQxjNxGHpssT
	S
X-Gm-Gg: ASbGncvpaPm8wuU8quGrJkk78ZMhYUb+1Ssd+GEiiYKIuvWfPPvC9RhSpZsz2KOCAWa
	FDVh47XzAcNepVxXXdMBYdgKq6skkdxhXA4/wgsLrbJTX6nwlb2mIJjRLASKpdIaUV8FQ7+siLo
	YptrWzyGyKhzPrDlV98lv0e5HbWSdqvloClvoOIpH0sZL6uO9BLBxZjfl7FcTcK4o+hyghBCY6L
	dlmsp/WlJoqYc1PF6nP0dnTboOBF3XkyYPzkDMHTbTH8qXKrN1TUyJ3Cx9Unv7ztZ/R+bNenMjM
	3pq3AH++6TPDrXQ82COGCF7l+tm+tymELdMJH5oyl5Law6LzoldkIGNwxzbrQsjsOAXCJWqA7Lu
	vNCQYKnA=
X-Google-Smtp-Source: AGHT+IF3+OXfmsZvh+UKhQTzeiWD4U9HuUaIHdkYe8+mOWxp9j2Guzk/0XtWGmoyfzy4VKVNwRYuSQ==
X-Received: by 2002:a17:903:32ce:b0:225:abd2:5e4b with SMTP id d9443c01a7336-22e5ea78da9mr2765015ad.16.1746555526189;
        Tue, 06 May 2025 11:18:46 -0700 (PDT)
Received: from ?IPv6:2601:601:600:19d0:bcda:24d2:915:cb76? ([2601:601:600:19d0:bcda:24d2:915:cb76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e4a573ce5sm13222245ad.252.2025.05.06.11.18.45
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 11:18:45 -0700 (PDT)
Message-ID: <3f31d4f75863614655c4673027a208be78d022ec.camel@null-ptr.net>
Subject: [PATCH v2] serial: jsm: fix NPE during jsm_uart_port_init
From: Dustin Lundquist <dustin@null-ptr.net>
To: linux-serial@vger.kernel.org
Date: Tue, 06 May 2025 11:18:45 -0700
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

 BUG: kernel NULL pointer dereference, address: 0000000000000050
 Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 16 UID: 0 PID: 368 Comm: (udev-worker) Not tainted 6.12.25-amd64
#1  Debian 6.12.25-1
 RIP: 0010:serial_base_ctrl_add+0x96/0x120
 Call Trace:
  <TASK>
  serial_core_register_port+0x1a0/0x580
  ? __setup_irq+0x39c/0x660
  ? __kmalloc_cache_noprof+0x111/0x310
  jsm_uart_port_init+0xe8/0x180 [jsm]
  jsm_probe_one+0x1f4/0x410 [jsm]
  local_pci_probe+0x42/0x90
  pci_device_probe+0x22f/0x270
  really_probe+0xdb/0x340
  ? pm_runtime_barrier+0x54/0x90
  ? __pfx___driver_attach+0x10/0x10
  __driver_probe_device+0x78/0x110
  driver_probe_device+0x1f/0xa0
  __driver_attach+0xba/0x1c0
  bus_for_each_dev+0x8c/0xe0
  bus_add_driver+0x112/0x1f0
  driver_register+0x72/0xd0
  jsm_init_module+0x36/0xff0 [jsm]
  ? __pfx_jsm_init_module+0x10/0x10 [jsm]
  do_one_initcall+0x58/0x310
  do_init_module+0x60/0x230

Tested with Digi Neo PCIe 8 port card.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers
to enable runtime PM")
Cc: stable@vger.kernel.org # 6.4+
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Dustin Lundquist <dustin@null-ptr.net>

---
V1 -> V2: added Cc stable, corrected explanation, added backtrace

 drivers/tty/serial/jsm/jsm_tty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c
b/drivers/tty/serial/jsm/jsm_tty.c
index ce0fef7e2c66..be2f130696b3 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -451,6 +451,7 @@ int jsm_uart_port_init(struct jsm_board *brd)
 		if (!brd->channels[i])
 			continue;
=20
+		brd->channels[i]->uart_port.dev =3D &brd->pci_dev->dev;
 		brd->channels[i]->uart_port.irq =3D brd->irq;
 		brd->channels[i]->uart_port.uartclk =3D 14745600;
 		brd->channels[i]->uart_port.type =3D PORT_JSM;
--=20
2.47.2
