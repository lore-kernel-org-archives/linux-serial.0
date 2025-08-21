Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB470275B06;
	Thu, 21 Aug 2025 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799145; cv=none; b=gl53G22xz33OPvTuqN6lXu5lrNEEnDa93wGGGjFJb6lZNNFY2ehP0XPqFhsAYAkIb4WKMzr533pNgKplpQQQmSDydbSo++IBvYX5eMKYA9Zll0LFzPcCn7uwW6v1MgqR2fyRkDX23dHpMHOJNZqdTTG60JF8Z8C6wnqp2zel4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799145; c=relaxed/simple;
	bh=jQoAmKygf4wigCtyyYmJVlUTQpWM02rCOK+0eXdZsRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mt3WVrnspw7I/tA0x8Gj93CR5MsZI5vrSZRgvrX4eXTwzFEhOvaiuGHLOP9wWIns+gSosRpZIiqZZ7y0+80h5DvI7lrhxZQQf/436dMK44wjCSfP+wZt4kL/xW6m3xpPK+tGs+jvo0olWdJZm7c2tp13CEKOvKv8OhA2KyfyYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJvd88tp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJvd88tp"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so2685001a12.3;
        Thu, 21 Aug 2025 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755799142; x=1756403942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzWslUIcKMm4pzLPKKp3UOSdTMmH1fUOcendkUjM6ew=;
        b=cJvd88tpUEExKTXF/TpGn9jJgO+rxz8iZ8j9w18ouelokp0m01QEeu8Y54tHq4VHl9
         fnwajsS4Hvw8JKJlureadHdfpeiS9KGZTwZX7FSmTzrLwNa+2G/8AdVAQmXItXfGHZVE
         TpQuc08otDTqkzL9tXdhJ4u1jvbRrh9U9EV8U0RQakdr980kIaPSN1XZBp8ChLSQEeq1
         CwPoYwdasKKaR1N+OrGM2vwBsw8akp+Az5nE69kCSa3YJKDnXA0Jiy+MmEUkvBXS/LxR
         RYURHr/7HkLsL6HteyHYZ/6lTju2MRkJUJcpEm3fctjroLhnUM49C8vu9p3bSAmQdnF4
         vM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755799142; x=1756403942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzWslUIcKMm4pzLPKKp3UOSdTMmH1fUOcendkUjM6ew=;
        b=NTrWfY9bwWtMazsGEFZ1+Gez/aS6SvkUnXvgeO+KuxiPT/OhrDzWV/lJTsRDpxscmv
         OpCuFXwJuujdPeSy/FZFY7WJCcpEvMjy0oZq7/hCvCR8Ierb34qGNjJvjhPBYKtwIBy7
         Lh5/joCcC6yB5MXz7mVJdYjxGp1wPs9EMivw2ZqT+AC/+yUanPO1lCdA/KICEa+bM7KD
         eAu3VSWfzm1+GNj8ahgmzALspt/SPu6n1lWoFXcHAuhwAiqmwByzwOha3fUszcByfduT
         6Acp4uiDdWGjJ+zMLkG3zH2Qp9HhoCUnvFPCIjnvs7CQjunCfTPtBB5lxG9y5+9LbMRs
         U2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWULMe08jSlZDvkXkUpIZA0EGYmM6atRbmu5MF07OKbJJZxt6GD3UATNBsu5wSMFCMtCZ0+CDWIgGPYyg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXVAfK/S1zweSqHpmOOssSzGvp+mbK2ICUe3U41ewzoInbXWJz
	ksFfwnDaW0gGziiOVhOFXZbOfhxbm1F+zlg21GAcYVFaLeEEqg4eUQ7C
X-Gm-Gg: ASbGncsR5vep5f6gQZzmv9Cr1G//tSLofwbcw+x3epom9NjpYoRHiVeM3y2hEaTYgTe
	WJqn7eJDfZrU8oqhP1927wsyVe/kGHfpcDEwMAqYV0c+U5UkVkbEwXclT7aOGuWOc9SDIHHOGRq
	Nwu9wperXXDaLRiN5fGq3B+Idny1UIEY8pmEhf5i7oDJMQrHK3jb8WMQgA/A/lUEmAklTh82R84
	HTuD6ZKfvqZjB7LawxmbGhyO7dVH7oGObFcc0kvGvrtZkx0SvjaH3b3ebotj6ZqqvAV+TE14rMw
	NeyuE4AEsw1A32x5vjWGxcKn4YCg8ndffxFb5X6vCtXM7D3Nq9pAYK2khcmHxWKJDEKUstVuiHi
	yZxYlnn0DjucgxbH2GlJHZrFY
X-Google-Smtp-Source: AGHT+IE1Mp+BDJKSG2h6UdBHyeuWwNpn1jBj0G0i5bb0XI9lq6H4YwijSDhLAWX0ePlTRFcvlGJQlA==
X-Received: by 2002:a17:907:3e13:b0:afd:d994:7d1c with SMTP id a640c23a62f3a-afe29748869mr1150466b.65.1755799142033;
        Thu, 21 Aug 2025 10:59:02 -0700 (PDT)
Received: from XPS.. ([2a02:908:1b0:afe0:c1c2:807c:915b:ed9d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2bc4e9sm435492566b.14.2025.08.21.10.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 10:59:01 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mingo@kernel.org,
	john.ogness@linutronix.de,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] serial: 8250_core: fix coding style issues
Date: Thu, 21 Aug 2025 19:58:56 +0200
Message-ID: <20250821175856.22957-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a few coding style issues in 8250_core.c:

- Remove redundant NULL initialization of a global pointer
- Add missing blank line after a variable declaration

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index feb920c5b2e8..0d1d2eed2a5c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -307,7 +307,7 @@ static void univ8250_release_irq(struct uart_8250_port *up)
 		serial_unlink_irq_chain(up);
 }
 
-const struct uart_ops *univ8250_port_base_ops = NULL;
+const struct uart_ops *univ8250_port_base_ops;
 struct uart_ops univ8250_port_ops;
 
 static const struct uart_8250_ops univ8250_driver_ops = {
@@ -773,6 +773,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	 */
 	if (!has_acpi_companion(uart->port.dev)) {
 		struct mctrl_gpios *gpios = mctrl_gpio_init(&uart->port, 0);
+
 		if (IS_ERR(gpios)) {
 			ret = PTR_ERR(gpios);
 			goto err;
-- 
2.43.0

