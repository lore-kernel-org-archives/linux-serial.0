Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49265680
	for <linux-serial@vger.kernel.org>; Mon,  5 May 2025 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746469141; cv=none; b=AnghNygUYPqynin+9+v7Oj+QsxZhg1wzAensQ2/wrOXPZ5DdZQwx9FUFOjolS8ZdTQhHiEva2W8SEAsfu/qdNMG283bAroYqU2P96ft/sErV3rJRFqQTCEq6d8oyFYJHaJderV1Hmvvxw7aoAWhTYpE646Y1wIQ5D3quwd2WeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746469141; c=relaxed/simple;
	bh=H0/0r8fh/Lz4GD5rVvLW99z5nPS9+ZfkvMghxxGAhPY=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=cT5o4RUT9DMz0EHzCONlzPlfQOUzkTkbL26YRb4sa7vr8fbsKyeZWmGwg9QqGOByastYbI3jKzyqmBJSQ4jJ1dJP3TiYpj8Yqa2IPOPkfUddpgBZSRnb47lKHgxp4kXGg6b3+0/vQsO3BbYBwQToDbE8qVXdezYF5p6dQwAl9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=null-ptr.net; spf=none smtp.mailfrom=null-ptr.net; dkim=pass (2048-bit key) header.d=null-ptr-net.20230601.gappssmtp.com header.i=@null-ptr-net.20230601.gappssmtp.com header.b=3WV74vPa; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=null-ptr.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=null-ptr.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=null-ptr-net.20230601.gappssmtp.com header.i=@null-ptr-net.20230601.gappssmtp.com header.b="3WV74vPa"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af579e46b5dso3193968a12.3
        for <linux-serial@vger.kernel.org>; Mon, 05 May 2025 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=null-ptr-net.20230601.gappssmtp.com; s=20230601; t=1746469125; x=1747073925; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvgoLybnGiN1FvTaaTTQOMntbm8RNCgnSX6ZliyEdoI=;
        b=3WV74vPajvrPmYzKCdIAtH1pg1njBVJX84T53txNGfBrLbSSkve5axAwiGDuLi2tP8
         I3zWDKcvxoTHstUkTBMZrah9Mb97r0XTUB91zmcnY9qgXSju+h4uND6Y+UKy3PWM95oZ
         x9EReUuf7kKnuSXAW6Bcu1ibM4hG8fQwENR2+hONNCa7DY5oaIFoqgrBvpGC04gSIuBs
         iRRRx6XtkHtN6QTOjmlNlFIuDg3Vuq9pXGTAZzERz7t6f9oVx7r9asRKGAB/jO49cIrT
         4UfecSxpVcal3EEsqJvwF9wTfKZMps14U9sKR1kBWIR3Ce2Or6o4CJ9wqlPgqQ1CUNtn
         b2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746469125; x=1747073925;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvgoLybnGiN1FvTaaTTQOMntbm8RNCgnSX6ZliyEdoI=;
        b=BlXF/4t570w7cDJ/WMpBTz8WjEDVbE1lc00993w3YRcIUvEHM3LUV2Ncqd1olLATYB
         WfJx2eULPrf9W4mLDKMkXlNskxv6LHT8TLjs9bI+XFNvBYhZIFpPzJeMoZTEjlEBbiKO
         /q4bj967uZD5Nax4UuVAzrYb5x2OsEksjpyq3EndS7kDUV7qfDSwcWei+XGU5sjXNHgM
         4kR1fbKRwH+N/OvVQac72DMeFUzfI64vlP+B/QNOnP69L5Qy7u+1q2qpbpdYoakYSkme
         owyX1GhfelCMLRFBgdIx+/eF8nzj6nX/fS19QpS4wZ6F92TLb7p4bnkqBAki/8ZhWL/H
         4QmA==
X-Gm-Message-State: AOJu0Yz+NxXWqDwI8CklN09u+nVJl8HcB7Ri8bRFSUhxFF2XcU8fFYuR
	UI/mGYXNAgJvBoSrat518fT1/gqufgnuELLBholHBKC+3xIMspnGnMaCHh0H53lB+Js2WKssemz
	B
X-Gm-Gg: ASbGncuPVpcfeRUq0jbxlPH8vAnu0DO5gfyelIcf9GLeQAIQ5o6ENs0AmPsmY48Y9vR
	MA5AAazEVbeow7Tg1AsVUTOGMf1cz1mnFdUTX+XObN8s6swhIZ2mNu52AUrCDrbUSCIEjQx+WyA
	aId+g/jST3NJx/p6Zw60/FZMEoEHY56HH8rOuSDX2MDB3OLYpySvqeu1apE1yS1mLVKslgw9CiV
	zEcn3xzN8hlWND/hHV8sjiK+FSx1/PPrK7JE5XLXtBsCzr1dFbJ+wnP6dLmubGB0TwVLi2KBx6K
	T6mwQK1NVPdfkG4oyr9BzDNE9WKCotKVjaNSyw5uGQsLmNjWJZBuiIc/Qj1chdUE/w==
X-Google-Smtp-Source: AGHT+IHtPxVgzfStN6MQa5GKQ3HdFdZEpz9osSUawMdkS5R6e/qUrZpura6F7KYhhjpxeyHNCidCIg==
X-Received: by 2002:a17:90b:3d84:b0:2ee:ab29:1a63 with SMTP id 98e67ed59e1d1-30a61957f3dmr11318397a91.3.1746469125466;
        Mon, 05 May 2025 11:18:45 -0700 (PDT)
Received: from smtpclient.apple ([2601:601:600:19d0:f0d3:974f:304d:7663])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fc49sm58016545ad.134.2025.05.05.11.18.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2025 11:18:44 -0700 (PDT)
From: Dustin Lundquist <dustin@null-ptr.net>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: [PATCH] serial: jsm: fix NPE during jsm_uart_port_init
Message-Id: <613DBD1A-3BD8-45B9-BF90-75E907CBE859@null-ptr.net>
Date: Mon, 5 May 2025 11:18:34 -0700
Cc: Tony Lindgren <tony@atomide.com>
To: linux-serial@vger.kernel.org
X-Mailer: Apple Mail (2.3826.500.181.1.5)

No driver was set which caused serial_base_ctrl_add to crash.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to =
enable runtime PM")
Signed-off-by: Dustin Lundquist <dustin@null-ptr.net>
---
drivers/tty/serial/jsm/jsm_tty.c | 1 +
1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c =
b/drivers/tty/serial/jsm/jsm_tty.c
index ce0fef7e2c66..be2f130696b3 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -451,6 +451,7 @@ int jsm_uart_port_init(struct jsm_board *brd)
		if (!brd->channels[i])
			continue;

+		brd->channels[i]->uart_port.dev =3D &brd->pci_dev->dev;
		brd->channels[i]->uart_port.irq =3D brd->irq;
		brd->channels[i]->uart_port.uartclk =3D 14745600;
		brd->channels[i]->uart_port.type =3D PORT_JSM;
--=20
2.47.2=
