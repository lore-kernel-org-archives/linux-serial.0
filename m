Received: from mail-lr2-f32.google.com (mail-lr2-f32.google.com [74.125.230.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0840748E0E7
	for <linux-serial@vger.kernel.org>; Sat,  3 Oct 2026 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791045236; cv=none; b=HVaGmi1WF+5McWD4dODERnU9n4AB4Jz7SVDLhY+ugy33eusMjwmgDC3XAua/IS26C6qXiUaAdzRA9eMRtlsvmuACNvHCe8JO5+cyKwAgNNqLXtkfpC6VAZaZf0OJXmxO2vsOFiUzxn2CzliQRSE8pZ1APpGX5eegzy9No0uv5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791045236; c=relaxed/simple;
	bh=3YfD7rZuw88DMuwYczaiDoeSy3itfBMyP/2TnoBot/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mj+HdZGycP2hlPLlusiK3B/8nboPR0DgT6QWphLd4ZKOz+FR4oXVYj1lAVFpZnvj2JlKoF7gE3uK21kh4Bht3bcg0Y4mqkSexjNKm35FsT0fI3O6BqD3ABR+25vwHyCc3Mk92NMxqTbFWsxRKYubPb1FiHZ0MpJVFgSBguWC6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvqZBqbw; arc=none smtp.client-ip=74.125.230.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvqZBqbw"
Received: by mail-lr2-f32.google.com with SMTP id 38308e7fff4ca-3a96c7783b1so7022031fa.0
        for <linux-serial@vger.kernel.org>; Sat, 03 Oct 2026 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791045233; x=1791650033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V26bRrFo37kOD/3fnaNC94SFt25znV4xHPmGyUnh8ns=;
        b=RvqZBqbw4n0YXQu589EXJzx0nPG/+lz0XMwDTvAs/2WIzScatcF0WUNUN6lvslgbEh
         MEOfH0OCkOQlzJvcp5yU8YZ8m7fD0j5GUFyx5SFYY1+h7W0dqaXZZfe7CAfVZTlncgYD
         BmsmxV8iwVJyfYmQsSz0eS8lTFshsjSyzreUpZaeV/iFaUd1jEAcpBLbxyV0YbxwP5+5
         fpGV/tep7DnZYXN106Pc3FeYWyj93fNiN039A4e8vfLc016zEI49hEg6WHp37ybQrgkM
         4ayln15D5w/NxCl5NuzI2EtfLd0+TUpJPMXfRHK1cSyve4WfvxvkFzT0sIzQ/aDfrsPw
         G6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791045233; x=1791650033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V26bRrFo37kOD/3fnaNC94SFt25znV4xHPmGyUnh8ns=;
        b=nXQN2Q0svRrXRoZFf3pyoEi8vrmVtaF+l3NKJ2I3+atwpH75JoKI6o+Q+GAxEFcQ2K
         OOfKUn/gn84PkSv9vQ2vXvfM95Ce5JMrOjjjP+zKfHZ5/u1hNWZl86zFlOZLzXN9MP8g
         ldNppsls9HEQm7XD+idKYILPM9cmU75h+ifsYnCacXEO2wagGdLSR3PQcIea9exd3n6+
         BrkVvaKtV8THMG52zENO1o+/RQxeqKLPLW1iPCKDhUq3pWNMvuTJ/kC8jJlgMhJVeP5B
         0Z6BJZ5uKj2qk6KWa5zMBIFNRcQKN1PIzhb3qRHzPUSfuHEqBImGj/SRft4P5i2K0COn
         DZog==
X-Forwarded-Encrypted: i=1; AKwUvBy2xCY874sTq9mSBppI5YTtmy8nnk2ThrgP3AXiJKVZkJi7ln/I1MNQ4byjRFnmi9R8VTBHfpK7UuOb+C8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWEnfg/LA7Fizzf9c+5Ws/jPE21xIMdsHJIWqfHDMingS19P0O
	MaR+2a4xTPWWjqPRkychwNjlXTKEJJ/U1aSShTO1Oaf6kIM0ud9s4CO+PV6O4n41507pXHOe
X-Gm-Gg: AYBFou3UtDg4jmmreEyxg6SMHIPDfS18NnPDAZ9wIKxpJ+5hDUqIgkxKUyvPOA+L5YS
	WIR7QBqwNzkJk3hhYhYK0JMgkEZ3Vc1gFqcDRhBVxS+BXsBfhGxcTyzbzQhyReIdz05dIaYP+yT
	P2GDsF/T5/bTNbBx7/niMY+qkgrzpRyVYYLIzJyo7KrGP8TouOLJHmIdzxrkhCo61orU4NLA/kg
	bC4kZW7iYQqSAnogYXeOi2guQ+JDUZ4g9FLP+HlE03DG3qs1xTCbXaa3KwmvefeT5LGxwt6ruWB
	Y6I4hehFpYWUvxAyNu/JU/YzdaSVvPqarpPYCcI2SN74AvWSfFpmM6Qw3kT7y/AXbNddH+m6bof
	wGHijm16AhA4B+HMKJty9q5d6N8GNE8t8OGSkFweN1H2U64WfhH3nDjqJZsdfsDDeTqgeZ2aA1u
	3mws+R4nxpvpAZ1idNGOEAKzwFMweIEnJTu/+k5TnPurmG+YewhACSIrkvERbv74TXu+9p+4W/Y
	lXGX+6Leso3gH5pjOTyoQxlrrz/OM4sBXcS89XKbaydfd23TKyQxoqLwy46TUMfPI4rUuUnae0b
	Uc6eVuZQso14+Or8W2EPFCI=
X-Received: by 2002:a2e:a98b:0:b0:3a9:7520:172e with SMTP id 38308e7fff4ca-3a975202f06mr7157291fa.17.1791045232579;
        Sat, 03 Oct 2026 09:33:52 -0700 (PDT)
Received: from user-x870steellegendwifi (95-25-156-252.broadband.corbina.ru. [95.25.156.252])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e333cf3sm21627211fa.39.2026.10.03.09.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 09:33:52 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com,
	Igor Putko <igorpetindev@gmail.com>
Subject: [PATCH v2] serial: core: shut down initialized port on removal
Date: Sat,  3 Oct 2026 19:33:37 +0300
Message-ID: <20261003163337.45577-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924192224.3175-1-igorpetindev@gmail.com>
References: <20260924192224.3175-1-igorpetindev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a serial port configured as a console is opened and subsequently
closed, tty_port_shutdown() skips invoking port->ops->shutdown() because
port->console is true. As a result, tty_port_initialized() remains true
and the port's interrupt handler stays registered in the irq subsystem.

If the underlying device is later unbound or removed (e.g. via sysfs
driver unbind or device hot-unplug), serial_core_remove_one_port()
unregisters the console, frees uport->name via kfree(), and tears down
the port without shutting it down or freeing its IRQ. Consequently, the
irqaction descriptor remains registered in genirq with action->name
pointing to freed memory.

This triggers a use-after-free read whenever genirq accesses action->name,
such as when reading /proc/interrupts:

  BUG: KASAN: slab-use-after-free in string+0x476/0x570
  Call Trace:
   string+0x476/0x570
   vsnprintf+0x422/0x1300
   seq_printf+0x...
   show_interrupts+...

Fix this by acquiring port->mutex in serial_core_remove_one_port() after
console unregistration, clearing port->console under the mutex to prevent
data races with concurrent tty_port_shutdown(), and invoking
uart_shutdown(NULL, state) if the port remains initialized. This ensures
that port->ops->shutdown() is called and the IRQ is freed before
kfree(uport->name).

Reported-by: syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=843bf2f48f4d12e6682e
Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
Fixes: f7048b15900f ("tty: serial_core: Add name field to uart_port struct")
Signed-off-by: Igor Putko <igorpetindev@gmail.com>
---
v1 -> v2:
- Clear port->console under port->mutex using scoped_guard() to fix
  the data race pointed out by sashiko-bot.
- Verified without synthetic devices by reproducing via sysfs driver
  unbind (00:04 serial pnp device) and inspecting /proc/interrupts.
- Do not hold port->mutex across release_port() to preserve existing
  locking semantics.

Reproducer steps (tested on QEMU with console=ttyS0):
1. Open and close the console port:
   exec 3</dev/ttyS0 && exec 3<&-
2. Unbind the serial device:
   echo "00:04" > /sys/bus/pnp/drivers/serial/unbind
3. Read interrupts:
   cat /proc/interrupts
   -> triggers KASAN use-after-free in show_interrupts() without this fix.

 drivers/tty/serial/serial_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1..f6253cd30 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3213,6 +3213,13 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	if (uart_console(uport))
 		unregister_console(uport->cons);

+	scoped_guard(mutex, &port->mutex) {
+		port->console = false;
+
+		if (tty_port_initialized(port))
+			uart_shutdown(NULL, state);
+	}
+
 	/*
 	 * Free the port IO and memory resources, if any.
 	 */
-- 
2.53.0

