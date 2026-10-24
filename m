Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879637;
	b=4KMrDIIXcSJmidvsgnRj7ge4xF0leHMge2hTHlrV6xMueFSpW89BaVhc6JMKTmnYWs1I
	 WtQ9kEWB7EnY36q/Q++hXnigd4qiAX/RhDtxH1GsKmRpeGayKr3TkChXjKIMJ/hXAOpOn
	 VzxXNl4OsLNioqYpxMLgotkhRODcgZ5qt3GTjk+dpKXTKcRPuuzYsJU4H7tmdiuGe2Dg7
	 84YUsNgpS+9HOm1oY12H4AZ/DockQrLEt6cXc7rgcNPthzIk+BhbNvGE5u09xg4Cg8az2
	 J63hU8GIqHIccAVijIc7nLuIRr99MLn3iFt9LHdECFEWKwysdVIyGwfAzhvMHzJOiIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=McYURVHSivgc1y7QO81KCrd/LSo/Pg6FF1ntLro9Qvw=;
	b=w9XqB8m13IUD5usIhK9xr0BABnIOEuOReSWKkPne9FldodYrdBxV30VZTr+Hv9PwQZkX
	 MQsRVoX0v5BwSRXtCbLSoWC6nhRgvRZ6jrRlAcMq/6VRGQXss13zh/Lv/mdvxo5CyVzv/
	 a3up3OW9gGnmwWcn/2j1i8GpuQAJag0dkbCeEo/evvYcaoaZrOwJA+R0f0MAfEWlII2f6
	 fX+OczgjlojDNnHtxFE1A00ZpzfXviaZa0hO0PiwvIboIEkgvu8QFCX2ZoKBloTk1xa7F
	 b9l7jGVNmpk2cw6JvmuDpn0G6pt9m35OPWoOX9jmL2P2YApIjOWmuXkhnPR7wBf4kpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="m/Yiaxx0";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101F3606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 22:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 101F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=m/Yiaxx0
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a208d93758so20817145e9.3
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792879634; x=1793484434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=McYURVHSivgc1y7QO81KCrd/LSo/Pg6FF1ntLro9Qvw=;
        b=m/Yiaxx0FIqI6y8cI2iuR0zdNsFeLRnz0FOtHgOsrzW+5KCuuPQugZ93Ke01QJE0CX
         bgEDUwewvdImvccpLlwzLdHkfPZWi2K/DoFq/lsKSQv0yIyu6uj8Svv8UWocoX/ECUi7
         Wv6KiU0K2hsSfxOzPqVVRrI+BT0H3JV3FlRPM0NckY3Xn3lnAdIWdBftRG/rBpPP8cbs
         8oJiQc4RsgtjfL3PzpAMPFlqZPHOD0V7FTsocJv8o7mW1CqfE2O+QX0+8uFQwxTd3ZgY
         Tj5hJwq8B/p2U7kBtr7+rtkWpbVQevAwMYQFJxGeWh61fK17emqcVXjCer/HZlmpxtTE
         WIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879634; x=1793484434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=McYURVHSivgc1y7QO81KCrd/LSo/Pg6FF1ntLro9Qvw=;
        b=MCQMDBY3zokeRvkN4b5Qe/zg++Io32rVcuDb8Cfb4oYXYpMa6gagdRIpK6lKbPk9HC
         xFTFDLW1hKOG/bu0dBA/8O+MjIcRSPjIiu+GufZP8dboDpdI16Vg8SXdis5dyjIRQ9s+
         bHBp3bh6DBMfTiBa5sOj1xvLGm0fTUn21bHXHXmMQPaRm5Tfg13rzgsz9DCbWkZg/1JM
         9pJWNuFVRXNxkQAOHCPGA7l78y4GfNMmE1VQZ3rvVMzK7K8wvPgtePi4M1Xz/JCF/OLI
         c13/jFtOsD+ziGZouyVbC51L0d2t8bd1d3UnI21Tw3+nSGfg8ymdXPv+UA8Iy/Bgip5K
         0pfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkIer1ftE2BQYy7vHBcCDoFm1/Ra5Ze7DGPjseQCYukwVnGC/HFaNVnJp+1DrguEvZlMu3ynutf7Xlisk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJ7X20p6Q2W3QYhCs4ooBQ9eUYtMpl+ORB9DJz7iQWf7rlZ2ce
	FMlg9xIA1+DGzHzy67x7NXhAmvT009T1YFMU3nPxeJu9RMJm/+9cOHFZj9Vq6vhIvPQ=
X-Gm-Gg: AYBFou2KUbZ2M8xQBj4UGbsDoy0CKW4ui1n0OSNGxPTPD2xs7U74d1CTrZFuwYLRgPZ
	HCsXQlgyhlobH/YO1xw7DNcIcWVXz+sUz4KjqwtyCqEc7bNWB4QgQHrB70Bq2A/eTHaFlTGs6HH
	dX/o+ZB/HR7tT5pszBdpPu2MPyOfQZzjyzaIyPhHpARAeiGmryaM7bT+BHHV8f9p63WB6ZqhDlX
	JD08dze+AW3C21t1itxoV+Y2sqOBUZbuayEJevQ9SXvnfjM+RsaNc7OI2G0BR4LBVzefyCa50cZ
	7WR2u7am4gBzAtnJpz0Ij9AuTBlGD89rl9oqjH/a2ztD4COsYR531jUyB2ALoVlT//Fg0kb9Xqn
	TeSX4gVcztDTIh9AqA53gvRDsjPDxENePqNtnD2ngNEphXK2umFkf3uvNPw9SGPZFnaqMuelTEH
	5+JoFnvb2mmCJln6+1d/XhTHQRHX7VWjBrrku7GpLYqA1LrjN1uDVHvO31e0iJxUUxiHGo9SnPv
	dnba6Yv+X9ov6NxPvZhWOecOYe/nqasWzh+WuDmOIjwwd0gZyL+rRtmwNBBHEhjK41INtpEPd1M
	w4ubyVFm936myQgzxHbwk9fmJXyOZGWPATowynWu+49ugBINcCIXKPulJOYiV6y/8M24
X-Received: by 2002:a05:600c:1906:b0:4a1:7bd4:d07d with SMTP id 5b1f17b1804b1-4a35acc3f50mr41010605e9.34.1792879634534;
        Sat, 24 Oct 2026 15:07:14 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a06da5fsm53466635e9.3.2026.10.24.15.07.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 15:07:14 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v2 0/2] serial: 8250_ingenic: Set UMR and UACR, add the X1600
Date: Sun, 25 Oct 2026 00:07:10 +0200
Message-ID: <20261024220712.23250-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
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

Ingenic UARTs carry a bit clock count (UMR) and a per-bit adjustment
(UACR) that the driver never sets, so a UART runs with whatever was left
there. On the X1600 of a HiBy R1 neither the vendor's 8 nor the reset
value 0 gives the 16 clocks a bit the 8250 divisor assumes, and the
Bluetooth chip on UART0 fails to set up. Patch 2 sets 16 and 0 at probe.

Changes since v1:
- Set UMR and UACR on every Ingenic UART rather than in an X1600 entry,
  as Nikolaus asked: the JZ4725, JZ4740, JZ4755, JZ4760, X1000, X1830,
  X2000 and X1600 programming manuals all have them at 0x24 and 0x28.
- Write 16 rather than the reset value: with UMR at 0 the R1's Bluetooth
  chip fails just as it does with 8.
- The binding keeps the X1600 compatible with the X1000's as fallback;
  the driver needs no entry of its own.
- Rebased on tty-next.

I could only test the X1600. On the other SoCs this writes the value the
divisor already assumes.

v1: https://lore.kernel.org/all/20261024051515.55639-1-olivier@mgcrea.io/

Olivier Louvignes (2):
  dt-bindings: serial: ingenic: Add the X1600
  serial: 8250_ingenic: Set UMR and UACR at probe

 .../devicetree/bindings/serial/ingenic,uart.yaml     |  3 +++
 drivers/tty/serial/8250/8250_ingenic.c               | 12 ++++++++++++
 2 files changed, 15 insertions(+)


base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
--
2.39.5

