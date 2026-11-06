Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793927178;
	b=SmILrhbTlx/7eA0kRFgfYdImzL/CeJAMyKa7JDy1zsQExxIN809TiU9k/CIDYYriPs1r
	 MuD04GK5DAV6759Nc1ZAfpQ3nDz5mstqxsKqdJbCmZTTXAHHN5vJfSj/Miyp7pvopRrXh
	 qlgzC5IQ6apIqCsJRbKTRTxjevL4lw3RkVSw90XFSlg9SfdbrAVkRKQfUUsnKJ7ueiaha
	 iPzXgUXaPbsjOL8N80pIoPUpM6eu6CV0DSucgBNGcD6u1PhwNH1VJxULSQ0kFsGlxnRiM
	 KcW86Flz4Tkli+r+9L6trh81UWOLAOzpgrzLl7kAXdDCNbK77Ib6x3CY6fOoedP4U7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793927178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t2wSWUxJ47IKpjldIgoNYRsgVyXDkMkOl01ADtWY7xk=;
	b=ijzFjb0FKh4XK3z5BnSwLvg6oDhEH35vlTEriQH9kEyhuHRF2S/zGV1ALpqKWkNZLvhy
	 pNXLNrBabIm+V8NvOMSfqGDuowsmDAFej7RP8EIjaEyA3WjH7uQVKbKK82dpax2eMskWv
	 M2+eaa8DZCjBlAPnb3PPfsyu1dVkKqorryRoohp07uHXWJ5I8gPeL1OwUpHe7RCCgG5Pd
	 dIFmAGmbbx3xFEHJEuoy9cmGOBxHJi/0vg+PF7vgSiAYiJXh/2c0Yhw9kTGLRGof1ecEe
	 Lor0rvTip5CUEtv06mkI5pXHmOj2pekQ3hGHjpuBhVQh659lvLRRiEwxnK6kqrUkeVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ye05nwbv;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFE606A328
	for <linux-serial@vger.kernel.org>; Fri,  6 Nov 2026 01:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3CFE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ye05nwbv
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-917aca1aee5so1060876d6.2
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 17:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793927177; x=1794531977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t2wSWUxJ47IKpjldIgoNYRsgVyXDkMkOl01ADtWY7xk=;
        b=ye05nwbvjti7e8iBeIldA8BRklZC5Wc/5EyS56YLsrWp7mvFFxl9Pxz4KgIg6De4eJ
         oMBYn+c9rVX2/g9folCnC4pNxc+PM7uAK8+K118KvbgjBJHKCIMm+ygZ08lsAo6AW85C
         RR/YXMXPQvTPZuqtpzxZPXOpxZWmbqSB6uzU7wiDprKDq/OWj4ToP3dLq2k8bL9zPfhO
         BbnP0KX3XMO8LGoJ1gHOre+VLMkG1iU8turdDyZcNH243JrOrQ1Rdq/0cvDFq+bDpdGX
         9nubUSQ9UdXs0SfT0gCw65slOjN1OyA2nJhpXjRj96wZPQv7gQhWkVL8MJs/KDsjWlbX
         4GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793927177; x=1794531977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t2wSWUxJ47IKpjldIgoNYRsgVyXDkMkOl01ADtWY7xk=;
        b=MceEeAxEIocKuFG6P49yEneJGpYb9Yuhro2fZu2fsI0rGS8IHKXrOjVLdewF/xFOdA
         7B+eP+v5XCBFTkPgU8h87B6wYTuvo/Rf8rVOQnS3dT7e9Q8F3BGfTCbHCzCEsmvxscrJ
         TYr4gTURQh9zHrM0kcnRYAZtSVk0Ux4je5yM2KCLkvwlF0cjop8mnqeKwtmfpyUy7Vko
         dFriF06DzTgZ07mZw7Huwdw0LkSfPSf5JmJSAwhLH13/ihgVyRpTOeFEtd6qAGDEOf99
         hF6UPPJ8Z8xlEETEvCmBdJJ+/Ns/sLwp0b0CirXIq2NUmTO81GB5GKnF6wUy9QM1/vfp
         eSgA==
X-Forwarded-Encrypted: i=1; AKwUvBxcYBfkfTT+8XzugBSCmBauAtlNe+YN4zG3gM4hTKwg5ovp47AsEnIVJwDRe0f+bAmY9qFQNo2lshMhiWU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NIKCTfotHasBXGGcb5P6OmEa3/a3fV1j+DmASx35d0pZomNON
	ycIVPw3UFYiuTnN+SvMtKGpSxSAV6V93c633KGUa2+Z0v8h9BDN8vT/H
X-Gm-Gg: AYBFou2V/nmpPVdVgOz9cjxlA5mP93CwFFGvIR6yFZRvP1JgI/rCNeyM6nqUeA9FuVh
	wpJMw7scmLQg1p7L4SRALumYusMm83+oWCZobL677dJr08MGjVcuWLkkqiwqqucb50kMV2FcIAV
	AUGRc4DiuXqZ7omhoayT9gjHwD0L0bI/iTCR56f2YZozBdVW4V2Blsj184oYFU5LFwcQnpT+bS9
	GPjyHnvzDttsSA5gahc3qMDjE8NFtzUi0AMXIuy21xYvNhIdYDh3aEY1kUWSBixcCZJKruI0F52
	2rH9nWWoFk4WVE12cLGD0XkINi57tw2lh2doIdAmhhD8kd0zn4j9BY/CGIESSRiREAzfzNfsRE/
	CANrkuPIHcq+2MWMBq34D9fYafYkXG06A+3xQ7kQNTYsVqW31DoNhJ8a9VnvSznSv8sE3OTCkcn
	/9prJ++fw4TxIBpxZcUwiY28Er/TQxcKMBohtCXFikOhfUA5XMe/DYbmR92mK/tV5gOcDlg3pji
	w/Ix+5qUjhsuz7vlSBskFnuA2CGQ4Rpe2uM3C6eRJnYHJwSeyjssY6tbNJvmPDcjvDd6q1d3zUB
	5fBKCSyGws5mcZ51nQ==
X-Received: by 2002:a05:620a:4449:b0:93f:115:7338 with SMTP id af79cd13be357-945f353bbf4mr138733785a.54.1793927176554;
        Thu, 05 Nov 2026 17:06:16 -0800 (PST)
Received: from linux.. ([8.34.174.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f5c1ea1asm20043685a.37.2026.11.05.17.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 17:06:16 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] serial: mps2-uart: Remove the ports_idr entry when probe fails
Date: Thu,  5 Nov 2026 20:06:11 -0500
Message-ID: <20261106010611.1708587-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mps2_of_get_port() adds mps_port to ports_idr, but mps2_serial_probe()
does not remove the entry when mps2_init_port() or uart_add_one_port()
fails. mps_port is allocated with devm_kzalloc(), so devres frees it
when probe fails, while ports_idr still points to it. When another port
later registers the console, mps2_uart_console_setup() looks up the
console index in ports_idr and uses the freed mps_port:

  BUG: KASAN: slab-use-after-free in uart_set_options+0x650/0x7a4
  Read of size 8 at addr ffff0000018c41a0 by task swapper/0/1
  Call trace:
   uart_set_options
   mps2_uart_console_setup
   try_enable_preferred_console
   register_console
   serial_core_register_port
   serial_ctrl_register_port
   uart_add_one_port
   mps2_serial_probe
  ...
  Freed by task 1:
   kfree
   dr_node_free
   devres_release_all
   device_unbind_cleanup
   really_probe

The stale entry also keeps the ID in use. A re-probe of the port (e.g.
after -EPROBE_DEFER) then gets a different ID than its alias.

Remove the entry on both error paths.

Fixes: 9f25e07b882b ("serial: mps2-uart: move to dynamic port allocation")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---

Notes:
    Found with a static analysis tool we are developing.
    
    Reproduced in QEMU (arm64 virt, CONFIG_COMPILE_TEST, KASAN) with two
    arm,mps2-uart nodes added to the device tree: serial0 without a
    "clocks" property, so devm_clk_get() fails after the ID is allocated,
    and serial1 with a fixed clock, booted with console=ttyMPS0. Without
    this patch KASAN reports the use-after-free above. With it, there is no
    KASAN report and the boot goes on until it looks for a root filesystem
    (the test has none).
    Not tested on MPS2 hardware.

 drivers/tty/serial/mps2-uart.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 2a4c09f3a834..c39aa534b822 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -590,15 +590,19 @@ static int mps2_serial_probe(struct platform_device *pdev)
 
 	ret = mps2_init_port(pdev, mps_port);
 	if (ret)
-		return ret;
+		goto err_remove_id;
 
 	ret = uart_add_one_port(&mps2_uart_driver, &mps_port->port);
 	if (ret)
-		return ret;
+		goto err_remove_id;
 
 	platform_set_drvdata(pdev, mps_port);
 
 	return 0;
+
+err_remove_id:
+	idr_remove(&ports_idr, mps_port->port.line);
+	return ret;
 }
 
 #ifdef CONFIG_OF

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

