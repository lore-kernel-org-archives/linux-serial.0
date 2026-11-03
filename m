Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742019;
	b=qHl0e5FR0cXMnkkCE9EssAN3MLiWhbjI7U8rCe67RWLFSXJ9gQ6vHn2aE1hL0cVH2EVW
	 XCJ0PwFOAG7TqRKoqpU4EAfVrEhVh4WnShfw91DiogkD1ImQEffIeAmjFF0Q4xyJ/WG4l
	 TwnYtyqs+kP9/ceOxHQiyj33KJRXyVposiZJGjQeXmJgfTf0V3wokeJncPZG2nf5zb7i+
	 JEpsCPwzRpR6kDJujl17FvMjhaDb+uYCEcVIYdDEKu26aQ7t40ocNsPn4vPufz96tjtPO
	 9v3f68LI+pKLe5dFs2jKj4WnNaajq5sDqFQC4RTydYOwLk8fxp/bS5RfwA1heTmeUnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=M2rzwl/OUiuhx7dhKJQxUK0UVCKf7xbOI2dH9gpFv6M=;
	b=yf4LwfD/e58AHIcRQPJHDUcy/2uXI9xp8W1OjMrQ7h2Y+uNpiJPLAv2LXiraSuEa9V+G
	 Q1I0zG7Grf1tWNz7PEINSwMvnFwoZUuCYPk5FgC64dPs/tMRPoLOOn9PO+u082wro8e4N
	 X6PYkt3x3IjX62dnERuEwApFTy3vE/g/zJAKHx8ijshOnpzyELJEsxGcV3FUEJD5UV7K8
	 9M8ntxCiKOfs/i+cNHxiMhZMywG8w8p3Ka2bAWGZRHRb1qSKBFAO0RphyHvwX7BVsqd7H
	 564SqFlZZJWY9prgTeurXUdA6B/9nZeQdoI18KX8idNMzxBlJNZ15bbSi1brOGOTdjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mJQqhZj7;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEF1606D807
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFEF1606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mJQqhZj7
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4af81963f35so64402b6e.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742018; x=1794346818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M2rzwl/OUiuhx7dhKJQxUK0UVCKf7xbOI2dH9gpFv6M=;
        b=mJQqhZj7QB6/b23ZkeZPi6U2gWPLiOsUvniL/CVMecJNvKf9Y/3pCihLh7ZMU8NylB
         imJabc8c3A06qHiTin3azbLXEsmM3D1+XX+tERLhdbXjlJdpPvnjzISJypgQYCjrukZi
         /FL8pY+ltdAeGKqrDlOIAN1Bto3bBUH/KMb5UKmrib5fmCZNhiotRGU7jIJ/uES2lN8n
         F6Z82yErAnMduYILloPA5wryIjF40wS1eLJOd4hUmjIHRiTt03GjBISomLRhayzExT29
         HmniyLMCH93F36bKCXsXykCOutBubycLyBStjNqMQ47uQIjKfoqe4bAGdusPeZxWUfUh
         ohBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742018; x=1794346818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2rzwl/OUiuhx7dhKJQxUK0UVCKf7xbOI2dH9gpFv6M=;
        b=jTl2VTsvb5dBQT8Vym0/otwVt7Ugleaca1PWkKlK+wWh/FuMpt6NTNpQm5FkitKYYw
         ZuMucEWpv5wNHHKpZbLC2i0yxrg+FUWznjXLbgwteZOWvkUCBXJf7aEEoB2PtjYHdbOC
         RcNzuQBUA8SEUXsXmN1wh2nAUOarTcwnNIhsFHv1VZtFHMRK97gs53Dbn2WGdby9qtMs
         NnpELzrz/7Q9v/zINidEZcQzfP7pGzXE6o1/rGfLMhQW4QVVtSHbqJdmqHziIfM3Vs4K
         cUK14RwFPKa94SsljHjzJVCj+L14LGk3vhDNogLe2pQFGV1kgR1T6wdZAOCnzjOj5fzF
         mdZA==
X-Forwarded-Encrypted: i=1; AKwUvBwfqhVSwwDjLUkiG1lfEcqJ/w5BN4Xp4Qez7JCvOabYWIe+vxwCXo+FOiOaJJb2iKFtU3/qz0lTBVt7FHs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aLsUt3qngs2h/UeKMbl4CC88mVLYG2kkjYRZNGJfbcsUqsid1
	cdaNeJyvv5Xw8WQTJ4Gr+YRGYcbORxc6niG3ORDcVdRexmBrg7DWX61KOxL4qBe3
X-Gm-Gg: AYBFou1ynwnIfx+ZBrii3zmPI85+q59zEQm39W8F3+XLcSKmSLxWSWBDPlrZ0hH2A+q
	b9vtNscFMoKuK8Bg5Glq/eggIhZBHk7B+05TfmzbQFQmHpuTGwP8QI9daV8dpw3UXzsqmvpC2+T
	DMrdH5ThjRa3rWBSUsp/kHXWOwHh7nsS7y79z29fabBJ+iAf+WF2hfVttwOzHoUAUIo5dWP1ENj
	5IqQeGiZ7J3rNWZlKrS7MUi+75fhCQ6JvlnhCQHdkakfa/jjIC/JrZhloHG9JbrWjR4dET9Wdyy
	lFwKeTZw8/JoMJsiVot1m8eXo93JufYyauCEabpixmIv1tSksf0GWVTC0GVDPTiaKxmQn2sJpK0
	t/hTnqTFsLH1pPGsSjg0r3QTh4FHKEOe9UODlW8XFBi8d+EhkA+KGh0wI85QUFM0HxUY1mtbNED
	m5tWuprIIQsJwZqojE7Ft9s/aPDl6/1LKdEeU1R+tBzpJgOYGod+mNRYnuLJtt/JlVmUyulUmjW
	immoWoKhs1hXhcSGjYIbAAh4WcS98HyjHl7ycBYv3Nchn8RHOfoieOn6mRYR2mJdFPBVXTlygPL
	hT3djwuJK2GlhKloPUAAnR+vLf5oPqgMy9ZPfKTnTGg5VZMNjkoe603BFoIngWk56p2IyybxR3V
	4CXqZhDyzkXZgDxYbWJRFlMUNJgRaoWNqc6JrBSdXGFr2eZs2NyICfClWd1yjDrRfGhrzewGLxl
	ic8cxQz/iQJNeeNHGgX7zHvIzPF3GzM/5wGTSZgS2NnxRRGS5BwIFoDtYrf65uZyU2n1NIXQPFk
	Q==
X-Received: by 2002:a05:6808:1997:b0:4f5:d3bf:edf3 with SMTP id 5614622812f47-5640e035525mr10789884b6e.59.1793742017956;
        Tue, 03 Nov 2026 13:40:17 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm27060b6e.11.2026.11.03.13.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:40:17 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 14:40:05 -0700
Subject: [PATCH v7 12/12] serial: 8250_dw: configure RX trigger thresholds
 for Octeon
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
Message-Id: <20261103-submit-h616-uart-fifo-v1-v7-12-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Octeon uses the DesignWare receive-trigger mapping with a 64-byte FIFO,
giving thresholds of 1, 16, 32 and 62 bytes. Its setup bypasses
dw8250_setup_port(), so it does not install the common trigger callbacks.
PORT_OCTEON also has no static trigger table, so rx_trig_bytes is not
exposed.

Supply the fixed depth from platform data when firmware has not provided
one and initialize the common trigger table before port registration.
This makes rx_trig_bytes available while preserving the Octeon port type
and register accessors.

Select DMA before filling in the default depth, as before when the 8250
core supplied that default during registration. Thus the new trigger
setup preserves which ports attach DMA and their existing burst sizes.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index cdd3a62dfa7e..063441923864 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -663,6 +663,22 @@ static int dw8250_setup(struct uart_port *p)
 	return dw8250_setup_dma(p);
 }
 
+static int dw8250_octeon_setup(struct uart_port *p)
+{
+	struct dw8250_data *data = to_dw8250_data(p->private_data);
+	int ret;
+
+	/* Preserve DMA selection before supplying the fixed FIFO depth */
+	ret = dw8250_setup_dma(p);
+	if (ret)
+		return ret;
+
+	if (!p->fifosize)
+		p->fifosize = data->pdata->fifo_size;
+
+	return dw8250_setup_rxtrig(p);
+}
+
 static int dw8250_sunxi_setup(struct uart_port *p)
 {
 	struct dw8250_data *data = to_dw8250_data(p->private_data);
@@ -931,8 +947,9 @@ static const struct dw8250_platform_data dw8250_a523_data = {
 
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
 	.usr_reg = OCTEON_UART_USR,
+	.fifo_size = 64,
 	.quirks = DW_UART_QUIRK_OCTEON,
-	.setup = dw8250_setup_dma,
+	.setup = dw8250_octeon_setup,
 };
 
 static const struct dw8250_platform_data dw8250_armada_38x_data = {

-- 
2.53.0

