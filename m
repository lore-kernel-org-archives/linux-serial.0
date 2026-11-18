Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035432;
	b=rKFX+IyFjMCh5UlDeEGnjWMhuHJNkzWCu4vN4/cM4rvzGD/+mcPn7dM3di+WW2B7z0ap
	 MHYUlMg2omIlE8OrhTIkUcU++RNX5y7sentSMf1QPk7HouzI2nCnk0Lcx0mi4S1YeXLHz
	 QADY5yelBpJ3tSKgI06HTeIOUnCtWghRgmW9f7Pu9BCy8CeegX/cBDKwyCimRAnXeh4Yk
	 3evAPbKrCWkFPVmYz7MvMOrHsxZZ9eAEs1+r3VTJO5JHBw+uA7xbjcZ1bRlTzXINiKAF1
	 Hpspaar8BpOPxWZSTe0Rr3a6i34I0fAAbt86fXid8jpISW0uM4e1cPcsmui66cdnqWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lwp8t8LUVYUpnfQ5EdPfzGcZvgUEwhtKxs66E4lRwbI=;
	b=YxPiqojKtIIOcM/ZqBU6JqQtAxJU6ey6SjmdlLpALEVCwkX18Wlac9ewAixJmk3PcYOW
	 2JFHsD6J1a6/yUH0sc5ZEV63kriF7IEb/avv1Qi7Dh36aCoUhlcFFo5LyJlzqKFgaAT0A
	 FpQu+ELEiDUCdJ50Pk0Doyvfeja0QCL5uZvR+xhtq4MrS3n1M/oVFaB/9qCzEx4QNxd8E
	 TwEoXDopM/w/P1I+AZsQuHj+9qJrDe36c6Ai3nqRsoTFwLmg2dZ15wVvHRFZP5iR1ZsZR
	 Hj8MB/10z8AdOim1pBVe1IOYRuGMGjUAYsQEcgxPDvipn12LGRbGetBAsXqrNKoQdxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhr7QSHD;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53071606A32A
	for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 20:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53071606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhr7QSHD
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso9723375e9.0
        for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 12:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035431; x=1795640231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lwp8t8LUVYUpnfQ5EdPfzGcZvgUEwhtKxs66E4lRwbI=;
        b=hhr7QSHDC+noBuScSbF2LvQQzrpLW7WgeqAIWQhbZoPIauDIjdUBAviukGLeTJLjPN
         YlppMNB+ds6MUhoUAftV1xvY5l2VQQ9/ytBiTRynV+vS4Jrokj8hIkOnE0nJv41FQTdl
         2rBVTd7cyZuWmcKA8wJNSlANIDA6Y25RVVp3lPEedeuHqYSqig9TYHrcNSQ2NnSS1yZD
         qQc6G61YuI1NUBAaWKwYsqAwVxpga93Zc5YUWgyU0xaFPkijnK3/42xNwG/dY+TUI+AD
         ydQmWh15XURrSzpke511lta8+c07R6LEitnkirzwMuXDiGm2scMjl0TY3vWF4lVQ4QVz
         7jHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035431; x=1795640231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lwp8t8LUVYUpnfQ5EdPfzGcZvgUEwhtKxs66E4lRwbI=;
        b=oxDSX3T5cKjsutNEZ0D2WTpSl6YoFpa3okQNLJhKFt3la2YyWCJVaYjD6+5dalSKI7
         mYFnMC+am6L4FpqVAIKFfy4kOq2xOBYUSwSWncpOh93aPscTv8uAfwV3r2GTlJCx/sXz
         7M5dIalppCIkY9MWri6ucu8DJiSAd27fw8gZzf5J6pam9m6a9lS01awvBhDI2DFZ+AHQ
         APsuj+vaA576JVOUMPJHzFIzCbAQpWnKXd2nYRvHLUvXHWCZTlt8xoFIjNVortWo0RZe
         zhhmJ+xnIPDM9KMym8TQwc42HnvFNTg6Q1ge7IGk/EH0V6dPM5cxiu0ZNEQe6fI40ln1
         i1IA==
X-Forwarded-Encrypted: i=1; AL+hErEVn3UYQrEzBSFb/c/oJemdKRqHae+5i8Lo21s3mvFPnWTFkh+hyFkiK0WypWfO5vem1pgS9sy5Gi/UlUI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VUVxXmYXW5I/+1wp0bS6EyN5Bk/F7C9y/lSkjKWTAK1RMmgG+
	TGOwiD5e5N08xfHZMjKxXMKPXz824yuk7qYoZsQkZP3vyAz0kR/WzAFV
X-Gm-Gg: AYBFou0TemOAuaW85aWK9Np4UDsw2vFaJ+ZASU0mceY3CVX5FOPLGp/5UUCJtJ5PSe6
	a8nEyvOuKZ3AmdNnZTfsWR+0emPbRgchtuoqcIeFN32NkgKfq+48xSgfxVS5E7U2xEcUuu9Dk6u
	lWQ2bAd7ha6EnDViQPp0n5KvDLsiEyBx4GFfa6maPVORZwrmLn0mkC6MUFAHT4OBLJqxyFOwpSS
	Mwpjdtkm+eQoPiuRdWjb4LHu3rqQ3xUUPt7qV099LE3xKO2BeKyORTTMb4e39A/pZU15I3stGoY
	oDwe7418TzR0BC3ybsOnRQ8XcCxCGwl+xYjJX9iWXX7Oi6ihTHR+fYfi+itCBd36xDNm7pQv1q4
	9xJNbS91caR0oODNAkj0XKx5H/b2MZcfH/WQjP7MuyTRYamGAhVZ9V3DZNncX6OXak414VA51w2
	f2XYR2O8PKj/Ru60SNx0VMDc4mpfiUPU3OszWepBctlBGeiPWWfSWbkoH0xAHLWJUDtXXq7WALt
	ad6eClJk7bk52AoMHqaViFPziWAe3Tw5w8d25CisXJMhw4h12Ryh6Te6czKXY0emG0Kt+rc4LyQ
	5sF5aRDwPn63bm/MIb10tV2HEY54
X-Received: by 2002:a05:600c:1c03:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4bb7da1392emr80734155e9.9.1795035430450;
        Wed, 18 Nov 2026 12:57:10 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb7e577acfsm46582705e9.1.2026.11.18.12.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:57:10 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 02/16] HID: ft260: uart: fix serial driver
Date: Wed, 18 Nov 2026 22:56:59 +0200
Message-ID: <20261118205703.49167-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-219657@kernel.org>
References: <sashiko-outbox-219657@kernel.org>
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

On Tue, Nov 17, 2026 at 08:49:47PM +0000, sashiko-bot@kernel.org wrote:
> Can taking port->xmit_fifo_lock with plain spin_lock() deadlock against
> ft260_uart_write()?

Thanks, that is a real deadlock. kfifo_in_spinlocked() and
kfifo_out_spinlocked() take the lock with spin_lock_irqsave(), and the
other users of xmit_fifo_lock must do the same. In v5, patch 2 uses
spin_lock_irqsave() in all of them.

> Can ft260_uart_write_room() and ft260_uart_chars_in_buffer() race with
> kfifo_reset() and return a bogus count?

Right, kfifo_reset() writes in and out with two stores. A reader
without the lock can see one old and one new value. In v5 both
functions read the FIFO under xmit_fifo_lock, as uart_write_room() and
uart_chars_in_buffer() do in serial_core.

> Does removing ft260_uart_change_speed() from ft260_uart_port_activate()
> leave tty->termios out of sync with the hardware across an unplug and
> replug?

Yes, it's correct. v5 sets TTY_DRIVER_RESET_SAVED_TERMIOS in
tty_alloc_driver(), as you propose.

> Can publishing dev in ft260_uart_add_port() before
> tty_port_register_device_attr() allow a concurrent open to reach
> tty_init_dev() before driver->ports[dev->index] is updated?

It can. tty_kopen_exclusive() and tty_kopen_shared() find the driver
by dev_t and do not need the cdev. They can open the minor in that
window. I will take both of your proposals in v5: ft260_uart_install()
uses tty_port_install(), and ft260_uart_probe() makes the port visible
to ft260_uart_install() only after the chip is configured, just before
tty_port_register_device_attr().
