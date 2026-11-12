Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497654;
	b=VKEiNhV8pwg/TY4AlzM1avp8jGrguFZeXZ/4dL+rhGtVm54CQREk0vA1fTTq2XyHaGun
	 Nsa0m7jjHRKXLQzdM+ikRCiYvd9wI1SFEjt8JXPcKKYyI8pJ8qvwB+UA9N3Qm0T+fMZom
	 dVKvNiq4a+r5gBWlae2wPoI5IphXXORs6m8p+x4IXK7zgJW55a68Z0IPrnd6Z/lxvKQyw
	 Gp9joKe9n9CJNY14mtX6GDSkIaaVec4RJ1anixCc7Y0hvzKG5WsAJFMdgz9HlAo/odBTP
	 giCh4mri+BsobQqXR4tFq1u+4RAMCtYRqOe2WAyoF8nBx5sQe74t03Vk87UpDrRKRtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Z786jydQGlTUZe6eFhOSbcyh7Kt9O55C4cUyVpre+Gg=;
	b=2sfOc3kDrqV1ZVOhY8FtlNrxn916NGDQF9hVGeLvXir0HTzDBnpX8XrFfh14zmjqLkc3
	 lTfEtm35g8leJLWyk/fA1Txd9LAUqpWYPJ6UPu3tUXQQ7x8mEGq0ALxb+9jz91eK2ldqO
	 fICH6R7h035JTXwRAnpM/OTR+WuYPRrtHIhInd9tgWZA9W1QOkPCC4D1XWQe1P7A8FjLB
	 cjbibdblvnHgYyolpn+yrG74DLgvzhXDxcTjlqhUIqfq0fuS4LxEd7grvThpUVndnGhfp
	 SVghjx1yOWVGwoPCggHs42fWDZjpFH1N4iSWFZMdOZESKzBfCVOSAA8MOMwgAuOlMIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxNjbwmZ;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD64606A332
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 15:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD64606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxNjbwmZ
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so46741425e9.2
        for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497653; x=1795102453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z786jydQGlTUZe6eFhOSbcyh7Kt9O55C4cUyVpre+Gg=;
        b=sxNjbwmZPaQyz+cBwcCUG/xCJj8iBZiKeb3p2u1UTSsQbYc29isVuWPu7oefWSAQkU
         MJgvbvhqxRkt6r8tr66j5UudouwUcD03S19gbhncBpgZa5jJlUhwt9Et8N1Oq3oKTtNG
         6YHmPaftP9DgVcPd+6qLm/CxGS7XROmekVuWR8gEfIgFiLgHmQq42UaHUHaaPBYR1fiP
         4+Ws/JD5tza3DW3iY88EheqTzQeH0voyeijOs2Q+xBt+aNwGg0aUonjtAGnafFNKn3Bb
         nkAYQormY0SfWsBFx7xADXnjZjahbU/7tW+DhODgmzXbG113IEJ63HlN/nw2iMgegXLz
         dOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497653; x=1795102453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z786jydQGlTUZe6eFhOSbcyh7Kt9O55C4cUyVpre+Gg=;
        b=rhoffMKxRiyv5EmKDUJIFBe48WETaqrJNDzzfXL8gt+mD4sLZTK2DqHPo1R0p9+B/P
         TJ4RDfBi7D9tiyiptLFuuGJN1gmy/EU9f8nqErtRmXSqbGKYEMifEnkJi0EuCvd1e58r
         QJsvYpffNXVXjKgRJuLAVdzr1vyCFqo9NoQMIuKZanAXhLAaHaRi5L/NAHqvuALlwr6c
         FMGTYB8BAmcizeeBoiHcSXXLXXYebLDoFN//vKy5Vhsm+7AC1waOCc2wM3NC6xqneFNx
         qNfI/RAzDwBhxhjWjC7fzSsjtUXKsq9kD3f//JzTDEeO9hnKKAU+pDHkKx34/rdtlYx2
         Hk/Q==
X-Forwarded-Encrypted: i=1; AL+hErEmTjUhr0ZqbsqIPukhG9cgSdrMfQpRuDEzbTWcI4pj4Ss7cvT43P9IG+x0YGN7yIbfGQ1tXXrXplG/apM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AwDWQp4StnZ5MEiUBW5xeTjJvMEQN/wd3oStRTEI8sHeL8SLz
	ytJHvCkBAOiE0+zDL5ru2lr9uG64V56jnU+sfOQgPVCJBslOWXrP/Yvr
X-Gm-Gg: AYBFou3NX0hp3LCfHN03OW/W90ReAVtXfO5vAxG8ZqvVHjQH0LIZG0eyRPs9PDXLdmF
	E/GTXBRa6PP8py03+IAPQ8vvxEAWUeIUSIR9lQjx5f8p3Y1onnHnULs+ncpmZJt+ojxS589FnrU
	+deWFw9rWl3mZv7ygz3r8icKldUJZMRIbsjK+rafBzhkXI5Po8eaTQMxS8GxtmMiKV56faHk6bT
	s/CzGbpDU/M6b5VWKtPk/CLTkDSFM+LFx/5l/i3uLC5uTfXvtTLZbBo1yDm/etm6T09Z3bSLYax
	Gdi+ChSjXW2sDf3uEGsBnHoSPjyU7uSfXEUBAbSP5CCDM4nmlJog0iySFh/7qc59G0rL4oT6klN
	HXR1ZbapeVG/UWBhUIUAil8il9Ls+aihl0NV7qicQ4jMu+baqNd/bTXfpI0K03oJE0RByO/q8R7
	MvjslzwGBe2BVRZhhYEpWCRUlnWg25YtCMSl9tV7x6RYjt5bKMThyVk59TX/AHT6OR+O3Zj6aap
	YVY72usFftgPw1H/3F21ZtG3FYWxPJx30/D0zv6WIvAraMJml2ArviaJ8w+xcds+8JjjjFMArVj
	ZE+bqbx54D/hAAqHmiQZK1z/v65bbsqQ0Kl+YAtlxhLxbF1LbLJxdCuiHoipswxRp7KtfzKsb8P
	5a5OdtA==
X-Received: by 2002:a05:600c:a00d:b0:4a2:1a:a129 with SMTP id 5b1f17b1804b1-4ba093b7ffcmr114576005e9.35.1794497652296;
        Thu, 12 Nov 2026 07:34:12 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2593e4sm87105855e9.5.2026.11.12.07.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:34:09 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 12 Nov 2026 19:33:14 +0400
Subject: [PATCH v2 6/6] serial: vt8500: Handle uart_add_one_port() failure
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-vt8500-serial-cleanup-v2-6-36b258e0c0dd@gmail.com>
References: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
In-Reply-To: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Prisk <linux@prisktech.co.nz>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, 
 Wentao Liang <vulab@iscas.ac.cn>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=alchark@gmail.com;
 h=from:subject:message-id; bh=/WGEv9BtvlhkUu2E+CsLY3dFd8QUnBePGzr3E+nbquM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9veP17z5jzOYvTpkJb0xrDz56ee/dzoAVgo4cWs3TJ
 3HoKd8Q6ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqNzExMvQUmYR4zN+dtzf+5ffcF2lcUex5zfdiSzK+CVkfYXk35Rojw+wew89
 mbfOOKyTG2Iaask549vvYmi3Hlz3xnd/WfyRhAj8A
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Return the error from uart_add_one_port() instead of reporting a bound
device for a port that never registered, which would keep its clock
running for nothing. Let devres release the clock and the remaining
resources on that path.

Set the driver data before adding the port, so that the probe can end
on the registration call.

Fixes: 304e12665a4a ("serial: Add support for UART on VIA VT8500 and compatibles")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-ce64cdae-9faa-4109-b7da-29b8a8c99e76
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/tty/serial/vt8500_serial.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index cd5188282f64..906b8dd2f4ff 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -638,11 +638,9 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	snprintf(vt8500_port->name, sizeof(vt8500_port->name),
 		 "VT8500 UART%d", pdev->id);
 
-	uart_add_one_port(&vt8500_uart_driver, &vt8500_port->uart);
-
 	platform_set_drvdata(pdev, vt8500_port);
 
-	return 0;
+	return uart_add_one_port(&vt8500_uart_driver, &vt8500_port->uart);
 }
 
 static struct platform_driver vt8500_platform_driver = {

-- 
2.56.0

