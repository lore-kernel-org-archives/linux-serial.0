Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721119;
	b=IpEmCRIc94nuACgijMC9GSLHdTGmbrZl9JEVBWwrMK9fYTCFYL3DqTiGTgWT4/qNNOdq
	 nzhjtvCk4pnqSwl0mT4jt9kau1ZBNMxN6YYWxF8DaYCR8UnsoYyHWMhmKx9mO3lvv1E7r
	 if2qb+1r17Bwy2+8tygTS/e80GJdbj0nh2DQowPxBH02kMO/sfbd2NezGm5orjjACB8p7
	 S+A8jJjuNyuJoOBl1UgfUcZb9jEJDK0kY0e5ivbJtAG6zsmI2TmmZBWHjwGkedjs3pRxh
	 SynCwgQY079m/tPzr6dlnyN1DdRygzIb3zN4cESoh7WAgI2ZRIqbhi0/ST2RwQ7y81w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H71gfqYcryivhuQjqCzDbHCn1oc9iWNIE78g3IqBiAE=;
	b=sg4LVo5ScziGxLsBFT/tMLaeK9t3RElcS9r5Rcwds1767ktEB4W8Pgar7yYNdJKQ9/eb
	 1zz6GjXUA1DrgdYNsVnDL/L7LA/v2/+oETVuyksvNPuDIy2+iB+pGJ1Wu2cHVL+f/HMmb
	 Lal8iHyd3GLXZZikVmk4JOZDtHde8fBdqYV/3oy1RevRfOoQFz263iJEkBWZ/puZiJxnD
	 JP54ZsgCcxPO0IXo7la5MIksLi1xqlYLzaK7hPPjFgUYETi0SojmcOYScPaGSbd6LcgPU
	 MAB4JdPge+ytzcIiLzJ5BC0DC2OjoeLomAI6wPxLK81P/XH8bg/n+m24p53YCy5sL6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ey4MhMEh;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F699606A327
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 15:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F699606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ey4MhMEh
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e09aa5264so2209632f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 07:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793721117; x=1794325917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H71gfqYcryivhuQjqCzDbHCn1oc9iWNIE78g3IqBiAE=;
        b=ey4MhMEhJLG/7pgDAb5MNxYJcWkTt1QNfCLrq0lK2KbFrJtWdKv/V8mEbZF3qp3VOd
         NPMpv84Eg3N8AkZtgIQlP0j9Q8pfs73XXnrEfl6ZrwPBJxS1LsjEID/65NeTfbD4Pqon
         T1t1B6gZZZWEjrwuX+kdPRBUzo2q6uNaTBQrHkTB6ElumWDrcc9hnXCRksOsRAk4AfPk
         A46w/8qmvUnZ2eGBYwxZYOhpkeuaElMkA9ravstpAz4qayu3hzxE/xf/7kr0sIKwLkG5
         bqQEuKAHPKI1xx7cWbzbXMDL79fwhGMV9yKnXGM32Lrt1YzE622UJiKSBh8PAaetVksZ
         mRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721117; x=1794325917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H71gfqYcryivhuQjqCzDbHCn1oc9iWNIE78g3IqBiAE=;
        b=tz7FAWDLtsHrsQemu32jzs5M1u7EVBwFczvXn/QTmkwvxuWa5DFp+HU1sr65tWgY1c
         BkVLqSi8EgSvIGvDP8E8yM8Ex7v2VWtEz1GRj/60K0F7SFMLjUnF+430B1E5lLBM5qq1
         S2sbNaNyQMkQAKpzDapH88hNJaL32txkdWjtrO9C4Z/0yeJCCDmvSvkMBtlZInvNo0zY
         NuuCgEIRMDmusIT7NnIVRWJ1Ocy3GuiYQUM6loY6T9UyhSONz1MyMh+J98HlVjhGyvRY
         IrbqhGdbfSZnLowjcIZkOJWRDibiyYRHYnovpt38GxUiwiUgqfUT+VJCyosG3e1BaPGT
         5Wtw==
X-Forwarded-Encrypted: i=1; AKwUvBwOVWlionALXp16h2pGmT6yP68Q0IuEoMsFg5CzqG1X+xRq2XwlSKrDdqUq7lLBBIeTohdZtYBS4FqHJrY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VJ8GD29OvlUHtkhjjBmVVW3L94kP4gWwyLBGEh+81bTMdj7vA
	KBTElIys1AGHui4JAwdsmvq9sQxN/CsySIE37VbfVubWreHqarUhSLCl
X-Gm-Gg: AYBFou04Gl/ePPS2yHkxo+UJWuMmA2NiMm0EoLRMN6LCJiBiWAqnuTdcBX1iJQM7wHF
	MBKsBD/E/IvIgr6GKUXKKAbo0i9IMCcg46IJdr+QPtVTQE5NLRmHlKXQ+1siypweLT5SFbFYuo0
	77gPTcMxaBFrdTFiAiVBzD5t49cV/PBFzYOEOJyDknkC2wmU1ic+JHUWroy1oIvcN0BGxJaoxdk
	8pKNuib1KaEGjT5vzsw33tETgvx5jmprYSaHyEFupGHqq+iovirMliXU7m1q8CNPvNfbV08m9Bp
	HzFStqge4SO8bknt+oAz1L31oylVzlAJfq8lAfKDsol7aMgY4jkJlz8XZjRasvqRZRrlSkd7wb5
	UfxazmNi41DzaaDtkJ2yx8Zm2J1Epwv5vIxNYIjaj6xKZu0077mL9xXzWT9+nQ3D8m/ihFgWpq1
	5hTekdBfoKQgcH894YI1kRNrbY1iEnMqb++wweVPyn6OHIWj7wsD7ThdwCeVGUXRHqCFpAshb7n
	puBv+07MKYtM1ptmIVWRD0nCwQeOz6oZVSmbGXcWNb6s3D3vkFta5Ww45lwEPFwVdRxxa5HA23a
	0qjEcNH1i+TJ9HnxB5dpSmeCS7BGvxqJMKHUA0C+H5w8ZeRHzl3e/tNCUyK9kZCva+h22xnWyWF
	NKLlyb+I1ETEKZTOqr965dFJxRrxhG2H88hYS9TMTqfXuIL/xIefh
X-Received: by 2002:a5d:4d82:0:b0:48b:a21:87f7 with SMTP id ffacd0b85a97d-48e6e4f4ff5mr23255855f8f.44.1793721116508;
        Tue, 03 Nov 2026 07:51:56 -0800 (PST)
Received: from Lord-Beerus.station ([93.66.71.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm25680750f8f.46.2026.11.03.07.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:51:55 -0800 (PST)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luan.r@variscite.com,
	alifer.m@variscite.com,
	pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Johan Hovold <johan@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fugang Duan <fugang.duan@nxp.com>
Subject: [PATCH v1 2/3] serial: core: Allow drivers to enable TTY wakeup at registration
Date: Tue,  3 Nov 2026 16:51:26 +0100
Message-ID: <b73bdbabd8d8fba2a2ff5d8576261bda6d8b0b5c.1793719239.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793719239.git.stefano.r@variscite.com>
References: <cover.1793719239.git.stefano.r@variscite.com>
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

From: Stefano Radaelli <stefano.r@variscite.com>

The serial core marks registered TTY devices as wakeup capable but leaves
wakeup disabled. Drivers whose suspend path checks the TTY wakeup policy
cannot enable that policy by initializing wakeup on the physical parent.

Add tty_wakeup_default to struct uart_port so a driver can request that
the core enable wakeup when registering its TTY device. The field only
sets the initial policy; userspace can still change power/wakeup.

Apply the setting only to the matching TTY device, leaving serdev wakeup
policy unchanged. Drivers that do not set the field retain the existing
default. Warn if enabling wakeup fails without preventing port use.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
 drivers/tty/serial/serial_core.c | 8 ++++++++
 include/linux/serial_core.h      | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af4..aa18d0820060 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3121,9 +3121,11 @@ static const struct attribute_group tty_dev_attr_group = {
  */
 static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 {
+	struct uart_match match = { uport, drv };
 	struct uart_state *state;
 	struct tty_port *port;
 	struct device *tty_dev;
+	int ret;
 
 	if (uport->line >= drv->nr)
 		return -EINVAL;
@@ -3196,6 +3198,12 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 			uport->tty_groups);
 	if (!IS_ERR(tty_dev)) {
 		device_set_wakeup_capable(tty_dev, 1);
+		/* Serdev clients manage their own wakeup policy. */
+		if (uport->tty_wakeup_default && serial_match_port(tty_dev, &match)) {
+			ret = device_set_wakeup_enable(tty_dev, true);
+			if (ret)
+				dev_warn(tty_dev, "Failed to enable wakeup: %d\n", ret);
+		}
 	} else {
 		uport->flags |= UPF_DEAD;
 		dev_err(uport->dev, "Cannot register tty device on line %u\n",
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4eeb8253752a..d5a0666d782f 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -573,6 +573,7 @@ struct uart_port {
 
 	bool			hw_stopped;		/* sw-assisted CTS flow state */
 	bool			cons_flow;		/* user specified console flow control */
+	bool			tty_wakeup_default;	/* Enable TTY wakeup at registration */
 	unsigned int		mctrl;			/* current modem ctrl settings */
 	unsigned int		frame_time;		/* frame timing in ns */
 	unsigned int		type;			/* port type */
-- 
2.47.3

