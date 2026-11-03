Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722586;
	b=gr4OJLG+bS2d9RK11Tf5+d7mUAWMZ126HW3CZrQfQVCMMIPVjqTesKzK1W3iyf0VlZqM
	 AkCqclYOxGIrJPemGv6+l9iQHKyvl2tQsGlc3Sz0xAp/DcWRrPamXFKWpjw9cWLVBHLO6
	 29KhrzE+7hofUvcOXF/3JxI46OWD5ezarIWCUhQbY/dt3qWgUz5ie0MlSmFlrBnp4KZaW
	 po4lZnqXSPDjYs+MO+rgyZbPlEFjMUqt+gXog9WQQ+UTfwfZRw4uK5ocXP5j6p2vbj3Ui
	 XHOz6HiXdeZn1FbDhHHDZ7bpY/1et9L/ZoqwFkd/AJ3ptcYChlB8mzx5Lt82NQYH+7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=a5wryUwdVr5GvbYUG9GqKAxvh5aLU+Gi2pGInFj178M=;
	b=XJgGrQF0WBbOmTIM51vRNKuZC8fHq/GwMb5XywHNw377nL2KJHE5ViHuVgGVRi5pBN23
	 Q8K3V40w35dKUvIq31fKKzUNaJ2OcChZ22RBzO79k/j3nzSnmayIOo6xDeoBYY9YUA7qT
	 HfAO+3jgCK55G0vjfbYDu7y+hvqPrzEmcx2AIB2+ELV+QYFPB/OrF7KnLeDpYI6R5NA1g
	 6z0MIi0pLRF/DV4X0XOLmGziKQlRIzcCY7xp43kSIrRSzaOJoETWBXw/A0N0Vjp2cdLrG
	 wA/yeyThP1xfSXBSLZUYGmu7s9W4UeFe/Q+aM8srY60pJoXZ6/o4EeqU/jqTowe50SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tQWN0zn4;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D9C606A335
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 16:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D9C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tQWN0zn4
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso29453015e9.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 08:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793722584; x=1794327384; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a5wryUwdVr5GvbYUG9GqKAxvh5aLU+Gi2pGInFj178M=;
        b=tQWN0zn4mbc/nm7sRMRHS6zM7wV2ZWWPSgNW1OkEqrtl23h9nItJwLkqH8lOb8zVBK
         OFP2+lUVU1tTQPTvzkCWk/AhWnUCxwtwZQNEpQA53Un7I2YWf52NrlNMZez2j87xd6ou
         I1scCNTgRsPXSSUbELKQG92ntW7kx5wAST1Hjb1FgOMeR8MjMLQqipgXyLxKYrpkhm2L
         5PoKKqekeUAPusyF04z/zEHfCl+mjrHlK7kF8dfKniJbF29xRaygVOAVS5kDwf+zq3B6
         3Lx6ADdYpw1YoDBrYlDwOPZ12HBZfP5QKpjlegY6cKydTXYbA3uF4n2bysQHYB+0RqJo
         dbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722584; x=1794327384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a5wryUwdVr5GvbYUG9GqKAxvh5aLU+Gi2pGInFj178M=;
        b=ZGGD6koyXYcMTxWpupxKUNGj5bkTfC5yH2LWb4SUNufSH9wMqRN6MDphun3vOLaaqL
         eHej64YxUuWCHcEGk5gFpYhhJXkx/VHaR+KV3fLFQnBdaHlS5dYZf3ylaRGXGM+8dzwp
         e+eND4l9AEc46P8fVuVuUOq+Gi281mLk33QFDIEIfYN7h0mc6jo/3Yj4j4s+tGcVfjj+
         mhmY4hA13Y32AQ2onLhM3xVpWZCvGGQPfGO1PEs0sIDBjYSKPcmSluiI1RUI3kUUZ0HT
         hJFXto0ZFPqVjSTriX8d5dmJDyoITXHTsEe+dqKto3M8Oz6BiEM3ZxkzfPrGxTzwVs7z
         j+Aw==
X-Forwarded-Encrypted: i=1; AKwUvBy9WGS23/9aFdACSoJp5vhBmbAk7uez0wRkgTYN0x0D5A3IRhTB+My3wocUYUQv36Oplwnb/yIzmSklnlE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9S1k6KCwbVDXkFqQG9ycRZrz4U2yBxqlCyxXfcTd6eIagY1LIx
	AT8keva8t2+VcZBrCuI8UWz2GmiLPjwq/qIHjaG+ftVvqlwAjkOJW62n
X-Gm-Gg: AYBFou1v8DTqWFI3MCE3WQ3f9maVtlohU4J5Z6TT2Mn75AC4ZP6yoMS0kV54+P1CK4n
	Z5+8sAbN+XD2wMVxMzKSYNnefALtYKKB5ywLOr3dhUrNfZVTn/ZrfY0OVeoiqjwDfRZurK18QDj
	G6F1NUDw+CNdZDwhmYeGQTDrPMOG4eBBVWsmymofwg+juv8qQDSVS3uHsKclD0HJLAWU9tTRJAd
	IC00rVtopC4e8mhycDqTFre7UFPNwK3B2SGjjGip+XaYIb2rAXWnfP4YOt48uItx9CZF+5jTnpJ
	JKtosogkLrr2sldcBNNjz3oUkKVuBfM789ZXhHw7kt+iHFaFakp118NrryyuzvWKjidZie0AfdF
	t4uUcpRoCPQKRZRP9BeeE/KzCpm1CEXCNc2jclI2mopzRk4cZ15LtaLH6kjMnz2TWhEa2wBuAry
	XPaqRjC460bBF/Ul/YjNxfo2BI4kq6uClG6lKzsYVhapPon66S7PsY3SVdxY09j+xVyEf7WKwyk
	r2wQdpmL/qRnjOL8T3PyafInBWoT+qyLdwwp9vRPAqFG551yA/6eCYtlQMsYtikfjaNRGJzt0Uo
	b9V2ljopXwM1iRtfiBIgEGZxUaGzYKeVRG+iQDMFsxHiDaIba0ifLq/bgMFxskSG+oWbYOkz569
	0g9Fdx08jHQoPOz+FYzZWsfJRBIOgpiA7WwIBDEQGA0X5Odg7m1Fghe7PCty6zeWKGQQoLZ8N1l
	UabvJj
X-Received: by 2002:a05:600c:4454:b0:4a5:1cf1:b7bd with SMTP id 5b1f17b1804b1-4ac1794032cmr319005485e9.16.1793722583910;
        Tue, 03 Nov 2026 08:16:23 -0800 (PST)
Received: from Lord-Beerus.station ([93.66.71.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bab1a8sm25631726f8f.57.2026.11.03.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:16:23 -0800 (PST)
Date: Tue, 3 Nov 2026 17:16:20 +0100
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 3/3] serial: fsl_lpuart: Enable TTY wakeup for
 wakeup-source ports
Message-ID: <auoI1NJgc3ky89jf@Lord-Beerus.station>
References: <cover.1793719239.git.stefano.r@variscite.com>
 <58d65b44ca054ea83eb835bf5decebd688cad04d.1793719239.git.stefano.r@variscite.com>
 <sashiko-outbox-195698@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-195698@kernel.org>

On Tue, Nov 03, 2026 at 04:07:25PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does enabling tty_wakeup_default at registration time cause a suspend and
> resume state mismatch between the serial core and lpuart_uport_is_active()
> when the TTY device is not open in userspace?
> 
> With tty_wakeup_default set, serial_core_add_one_port() enables wakeup on
> tty_dev during probe before any process opens the port (when port->tty is
> NULL and tty_port_initialized(port) is false).
> 
> If the system suspends while the port is closed, lpuart_suspend() calls
> uart_suspend_port(), which checks device_may_wakeup(tty_dev) without checking
> tty_port_initialized(port):
> 
> drivers/tty/serial/serial_core.c:uart_suspend_port() {
> 	...
> 	tty_dev = tty_port_find_device(port);
> 	if (tty_dev && device_may_wakeup(tty_dev)) {
> 		enable_irq_wake(uport->irq);
> 		put_device(tty_dev);
> 		return 0;
> 	}
> 	put_device(tty_dev);
> 	...
> }
> 
> Because uart_suspend_port() returns early here, it leaves uport->suspended as
> 0 and skips console_suspend(uport->cons) as well as uart_change_pm(state,
> UART_PM_STATE_OFF).
> 
> However, lpuart_suspend() then checks lpuart_uport_is_active(sport), which
> requires both a non-NULL port->tty and tty_port_initialized(port):
> 
> drivers/tty/serial/fsl_lpuart.c:lpuart_uport_is_active() {
> 	...
> 	tty = tty_port_tty_get(port);
> 	if (tty) {
> 		tty_dev = tty->dev;
> 		may_wake = tty_dev && device_may_wakeup(tty_dev);
> 		tty_kref_put(tty);
> 	}
> 
> 	if ((tty_port_initialized(port) && may_wake) ||
> 	    (!console_suspend_enabled && uart_console(&sport->port)))
> 		return true;
> 
> 	return false;
> }
> 
> When the port is not open in userspace and console_suspend_enabled is true,
> lpuart_uport_is_active(sport) returns false, causing lpuart_suspend() to take
> the else-if branch and disable ipg_clk and baud_clk while the console is
> still active and unsuspended:
> 
> drivers/tty/serial/fsl_lpuart.c:lpuart_suspend() {
> 	...
> 	} else if (pm_runtime_active(sport->port.dev)) {
> 		lpuart_disable_clks(sport);
> 		pm_runtime_disable(sport->port.dev);
> 		pm_runtime_set_suspended(sport->port.dev);
> 	}
> }
> 
> Wouldn't any printk() during suspend or early resume then call
> lpuart32_console_write() or lpuart_console_write() while the LPUART clocks
> are disabled, triggering an unclocked MMIO access (bus hang or synchronous
> external abort)?
> 
> Similarly, on resume, lpuart_resume() skips lpuart32_hw_setup(),
> lpuart_hw_setup(), and lpuart_console_fixup() because
> lpuart_uport_is_active(sport) is false, while uart_resume_port() also returns
> early without restoring console termios or calling console_resume() because
> !uport->suspended && device_may_wakeup(tty_dev) is true:
> 
> drivers/tty/serial/serial_core.c:uart_resume_port() {
> 	...
> 	if (!uport->suspended && device_may_wakeup(tty_dev)) {
> 		if (irqd_is_wakeup_set(irq_get_irq_data((uport->irq))))
> 			disable_irq_wake(uport->irq);
> 		put_device(tty_dev);
> 		return 0;
> 	}
> 	...
> }
> 
> If the LPUART loses power during deep sleep while the console TTY is closed,
> doesn't this leave the console hardware uninitialized after resume?
> 

The suspend/resume mismatch described here predates this series and is
already reachable by enabling the TTY device's power/wakeup attribute
from userspace with the port closed.
This series changes the initial wakeup policy, it does not introduce the
mismatch.
The underlying suspend/resume handling should be discussed and
addressed separately, rather than attributed to this patch.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1793719239.git.stefano.r@variscite.com?part=3
