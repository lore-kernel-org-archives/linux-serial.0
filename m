Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250407;
	b=EE1W/oBm1q7AePK3PrKp378Z2tyjLtCTkXe1EpN3gHaaWNPkjGXrbXizHn3Nixzvz6ZM
	 0K0LnrgTtQx7Gcu7GuaUol2dCTuwh+1ncbnDObPoNFNU8PedBuhXLGfxhRdxXHSKhCAve
	 IIbGoG/99/M/Ey0pJ8dM5zji7I0gSR/9h1W6S7yz3f1W/bXuw0VpRjwtMET1PrV+eOeiu
	 yd/0IDAOLLpiclZip/ars0zNgbXwHCQMUgqdsuW4bwCcjitQbtbFxvNoHQGskuu3A7kEG
	 zllUvzAK1i+D7I88keFUdr4p1IJodAHHrxZXazj5MjdeDFCQhe5+icyDmySdrWdYYow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=PrViROnApghslTphYj3fFZqU+wtyCMh82JuGBOo6+9g=;
	b=Rj7cFUB+aOJPEgujZdzKD/h/Feg/Bd8QLdjB2tYOlHdWO1YAq7CQYiES9qr9hc3+kJfM
	 1NwOjOaaIS8CcOZ4+g7uUscUjEKMUzIs089f/vkpNjOA0JPjTXrtZlCKaZR3hNKbYUqNa
	 uTUlV5kah0UZw5D3s5zxpeXr/xyYj+ZSLVH4UVp7g9/4zlsWIiT02iLytF1rdurdsP85a
	 tMGxrvWOG/yquKUjD7rd9RWu8xTQjKer/VevjxL5++ZSmwr7Sj6mRasE8sFA8XLauI++O
	 Y/LGIHh0+arc8GK7Hj/xg6f44d1/+FaAMoyVhq1Du2yOVvHxrWoBSKfnsE5NbWT0NQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WZTxGKyO;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C5D606A31F
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C5D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WZTxGKyO
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac5f801d7cso405156a91.0
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250405; x=1793855205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PrViROnApghslTphYj3fFZqU+wtyCMh82JuGBOo6+9g=;
        b=WZTxGKyOGwcZ5guP/dVCN07WP263NJOqjgovJqJ4I28OZCnnMxluKXFDLvuqqgdqS9
         bnFoJYoyUE6gloq0xM9FViMTCiDVnF3aV7t/rEE4S8ZlwVxwNMbUxBSd9XLezugvs/yR
         vqxcI15zKmx++J/Dgr0YIWGdMajNKwfRBbW3QLQsZ/TYpACZyUGmpzvRtRmcc+vSaMwM
         YM4FWTVdzK5oSnAxetDq0E9DfNBkYUcjfn06Kwh7yUQadqmZp42bZ8tHjpBhaRRFiUFU
         iEDDZ7C8n3vz91azCQy5EYDDiGNLY79noR35/K445p0XfAFDaCZZADjzipphWQWAt9UA
         /6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250405; x=1793855205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PrViROnApghslTphYj3fFZqU+wtyCMh82JuGBOo6+9g=;
        b=BhGTUDP3RcMOwZHZYa8dz5IzTB9U1D+1cbztRe8BsGKIHB3rAoR+fq4nAtScSYJEO1
         zGNra1h2bz0hdmGHcCFURkroxpc11ZOmdcvZ5VB3Qpkr91F6Xlz1NYk65GK3OeEHSZIY
         Pq+76teYg+ujM/2Ns6vCrPa4Fkcgk+e9A+SfseNEShgUmPVZKRNEmKZ9t6jo14Py7Aei
         KHO5wVtfQCCpySDZIxHRJ3NgaoDHv69ETP9GROPptnfAivqyKQp/T7xZwtqOvvrTi3T+
         fY3kYRlwyEw29uarlmbn6cgjAWBSYWuzu293oR8TeFtyiYGDwXPMHodZS/nxQw9MZpbF
         0AHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxg2O3ByqzvS9K+W04YBOSLUa3BLWh2ej/TsTDsLUepB05R2W4S+F941zTStp6V5mETsDT9IUzByVAw+k4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLZ3xMxFn5cC1YBpLH1p1t2p0BWBvo8weBo0LQBoBLiN92qJFe
	y4GQ0SPXmayKb0Pdzj/e6twqu7tfI9tzkXordbPQwRf8uL6R1Kqj/IW1
X-Gm-Gg: AYBFou0cIppHVi+KjJ3INUdzmnSsJmdg5Aq2cKyKN6wqUw7RVdHHxA1K37ry5HD1rQK
	1eX/oRYzSWG2Au3sSEHeWWQm+aYg1c/y7UJ9I+BV1SJGLIvN9bkQqYfusOehMMIZdF1fYbKcEEs
	2RiyedCJHTGdqNmwvqTocZ4gj010m3zFc4ARNHZk/uDmVL0eyC0Q7827v9pFQsestpJDq+cQmmH
	yUT5Wj5Vr5OZtzmW5zXDhLo2uSReUBK1EWekUFEJLIpaTnADaYA3omoBElT73yC4vpKsP7EoYF/
	l48myGBAoN6VhN/egeGQQJIMf1snAApJ5aLOW81fon0+h2nVXy/7oYgqtlnrqJnokpDgfWaUTZ5
	0jYcXhlvRyNMR604fx06y90KgqlPOX0nJUJpN+UIjjZktkQ4AYLFiVLtV5wnRXzXdJzVciLXUjx
	CFJIRsg9Hkd6xY286Wi4OOXCMyxs+Y1ormqCO1CTjKkJeuV5NWrFvpTTwkwZboP8ncWEuGjRocG
	RdWQkoX4d9ZnJ5pCYYafpyqS7aA4cwIImQzp3wSDC8FrOhj8+zBuaNU/NSLyXBW8OVt16TY97g5
	HgWY02drNx5xWHb5QaLhiI42aalT
X-Received: by 2002:a17:90b:48c7:b0:3a5:133:ca5f with SMTP id 98e67ed59e1d1-3ae580e182emr3103882a91.46.1793250404877;
        Wed, 28 Oct 2026 22:06:44 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:06:44 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Thu, 29 Oct 2026 01:05:47 -0400
Subject: [PATCH RFC 06/12] rust: serial: Add minimal serial-core polling
 console support
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
Message-Id: <20261029-rust-bl808-console-v1-6-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
In-Reply-To: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Paul Walmsley <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Kwanghoon Son <asdfkwang@gmail.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.14.2

Add the serial-core abstractions needed to write polling console drivers
in Rust, including Driver, SerialOps, Port, LockedPort and Termios.

Use owned, device-managed port registrations to keep hardware data and
the driver alive until serial-core users and console readers are drained.
Callback-scoped Port and LockedPort views provide access to the parent
device and UART lock context.

The adapters acquire the UART lock for termios changes and normal console
writes. Emergency output may proceed after a failed trylock. TTY device
registration remains in C serial core; userspace TTY I/O, RX, interrupts
and DMA are not implemented.

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 drivers/tty/serial/Kconfig      |   8 +
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers/helpers.c          |   3 +
 rust/helpers/serial.c           |  33 +++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/serial.rs           | 505 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/serial/console.rs   | 107 +++++++++
 rust/kernel/serial/termios.rs   | 104 +++++++++
 8 files changed, 764 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3864cef711a667b294f3205c220b3ab34aa3d2c9..9b17d451f19df6575bc8a4a08245065f9b8e3715 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -18,6 +18,14 @@ source "drivers/tty/serial/8250/Kconfig"
 
 comment "Non-8250 serial port support"
 
+config RUST_SERIAL_ABSTRACTIONS
+	bool
+	depends on RUST
+	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
+	help
+	  This enables Rust abstractions for the serial core API.
+
 config SERIAL_AMBA_PL010
 	tristate "ARM AMBA PL010 serial port support"
 	depends on ARM_AMBA || COMPILE_TEST
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc73e9919e8536039b402a8f38b0378..65eb55b79b80d7e036c0b8eac58074871bce0fb6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -88,6 +88,8 @@
 #include <linux/sched.h>
 #include <linux/security.h>
 #include <linux/serdev.h>
+#include <linux/serial_core.h>
+#include <linux/console.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 #include <linux/task_work.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index d62c7be1ca7bd9cb805c8e2c46975d077b2918f9..b3074f580c2b6273499a0f46570e4f00082017db 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -95,6 +95,9 @@
 #include "scatterlist.c"
 #include "security.c"
 #include "serdev.c"
+#ifdef CONFIG_RUST_SERIAL_ABSTRACTIONS
+#include "serial.c"
+#endif
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
diff --git a/rust/helpers/serial.c b/rust/helpers/serial.c
new file mode 100644
index 0000000000000000000000000000000000000000..3d303dfd56207942e3579b1c81ad489521374db8
--- /dev/null
+++ b/rust/helpers/serial.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/serial_core.h>
+#include <linux/console.h>
+
+__rust_helper
+void rust_helper_uart_port_lock_irqsave(struct uart_port *port, unsigned long *flags)
+{
+	uart_port_lock_irqsave(port, flags);
+}
+
+__rust_helper
+void rust_helper_uart_port_unlock_irqrestore(struct uart_port *port, unsigned long flags)
+{
+	uart_port_unlock_irqrestore(port, flags);
+}
+
+__rust_helper
+void rust_helper_uart_port_set_boot_autoconf(struct uart_port *port)
+{
+	port->flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
+}
+
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+__rust_helper
+bool rust_helper_uart_port_console_lock(struct uart_port *port, unsigned long *flags)
+{
+	if (oops_in_progress)
+		return uart_port_trylock_irqsave(port, flags);
+	uart_port_lock_irqsave(port, flags);
+	return true;
+}
+#endif
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 1ab41129d557a97c09b4fb1bfc6aadb4250156a7..ef1c67826e6b131618eacb53901dd2e8c213e76c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -132,6 +132,8 @@
 pub mod seq_file;
 #[cfg(CONFIG_RUST_SERIAL_DEV_BUS_ABSTRACTIONS)]
 pub mod serdev;
+#[cfg(CONFIG_RUST_SERIAL_ABSTRACTIONS)]
+pub mod serial;
 pub mod sizes;
 #[cfg(CONFIG_SOC_BUS)]
 pub mod soc;
diff --git a/rust/kernel/serial.rs b/rust/kernel/serial.rs
new file mode 100644
index 0000000000000000000000000000000000000000..f24c685d8592fe91e927a52c116aba9820378ac6
--- /dev/null
+++ b/rust/kernel/serial.rs
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Serial-core support for memory-mapped, two-wire polling consoles.
+//!
+//! C header: [`include/linux/serial_core.h`](srctree/include/linux/serial_core.h).
+//!
+//! [`Driver`] owns the serial driver and its legacy console. Each device-managed
+//! port owns its hardware data and retains the driver until removal completes.
+//! Registration failures release unpublished data, or remove a published port if
+//! devres registration fails. Removal drains serial-core users and console SRCU
+//! readers before releasing hardware data and the driver reference.
+//! Device-managed resources can be revoked before port removal; callbacks must
+//! use checked resource access rather than assume the parent is still bound.
+//!
+//! The adapters acquire the UART lock for [`SerialOps::set_termios`] and normal
+//! console writes. Oops output may proceed without the lock after a failed
+//! trylock; it never receives a [`LockedPort`]. Callbacks must not sleep.
+//! TTY registration stays in C serial core; TTY startup returns `EOPNOTSUPP`.
+//! IRQ-driven I/O, reception and DMA are outside this polling interface.
+
+use crate::{
+    bindings,
+    device::{
+        Bound,
+        Device, //
+    },
+    devres,
+    error::to_result,
+    prelude::*,
+    sync::{
+        aref::ARef,
+        Arc, //
+    },
+    types::Opaque,
+    ThisModule, //
+};
+use core::marker::PhantomData;
+
+mod console;
+mod termios;
+
+use self::console::ConsoleAdapter;
+pub use self::termios::Termios;
+
+/// A registered serial driver. Ports retain a reference until removal completes.
+#[pin_data(PinnedDrop)]
+pub struct Driver<T: SerialOps> {
+    _type: PhantomData<T>,
+    config: DriverConfig,
+    #[pin]
+    console: Opaque<bindings::console>,
+    #[pin]
+    inner: Opaque<bindings::uart_driver>,
+}
+
+// SAFETY: The C objects are pinned. uart_driver state is allocated before publication;
+// port_mutex serializes port changes. Each port retains an Arc until removal finishes.
+unsafe impl<T: SerialOps> Send for Driver<T> {}
+// SAFETY: C fields have interior mutability through Opaque. Console-list updates use
+// console_list_lock and console_srcu; active console callbacks finish before removal.
+// Driver names and callback pointers are immutable after initialization.
+unsafe impl<T: SerialOps> Sync for Driver<T> {}
+
+impl<T: SerialOps> Driver<T> {
+    /// Registers a two-wire polling console with dynamic TTY device numbers.
+    ///
+    /// `config.default_baud` supplies the initial default console rate.
+    pub fn new(config: DriverConfig, module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        pin_init::pin_init_scope(move || {
+            config.validate()?;
+            Ok(try_pin_init!(&this in Self {
+                _type: PhantomData,
+                config,
+                console <- Opaque::ffi_init(|ptr: *mut bindings::console| {
+                    let mut console = bindings::console {
+                        write: Some(ConsoleAdapter::<T>::console_write),
+                        setup: Some(ConsoleAdapter::<T>::console_setup),
+                        device: Some(bindings::uart_console_device),
+                        flags: bindings::cons_flags_CON_PRINTBUFFER as i16,
+                        index: -1,
+                        ispeed: config.default_baud,
+                        ospeed: config.default_baud,
+                        ..Default::default()
+                    };
+                    // SAFETY: The validated name fits with its trailing NUL, supplied by
+                    // the zeroed array. The source and destination do not overlap, and the
+                    // initializer exclusively owns the pinned destination slot.
+                    unsafe {
+                        core::ptr::copy_nonoverlapping(
+                            config.device_name.as_char_ptr(),
+                            console.name.as_mut_ptr(),
+                            config.device_name.to_bytes().len(),
+                        );
+                        ptr.write(console);
+                    }
+                }),
+                inner <- Opaque::try_ffi_init(move |ptr: *mut bindings::uart_driver| {
+                    // SAFETY: The preceding field initializer initialized the pinned console.
+                    let console = unsafe { (*this.as_ptr()).console.get() };
+                    let driver = bindings::uart_driver {
+                        owner: module.as_ptr(),
+                        driver_name: config.name.as_char_ptr(),
+                        dev_name: config.device_name.as_char_ptr(),
+                        nr: config.ports as i32,
+                        cons: console,
+                        ..Default::default()
+                    };
+                    // SAFETY: Both objects are private and pinned. No callback can use these
+                    // reciprocal pointers before registration below publishes the driver.
+                    unsafe {
+                        ptr.write(driver);
+                        (*console).data = ptr.cast();
+                    }
+                    // SAFETY: All C fields and callbacks are initialized. Names and module
+                    // outlive registration; ports retain the driver until removal completes.
+                    to_result(unsafe { bindings::uart_register_driver(ptr) })
+                }),
+            }))
+        })
+    }
+}
+
+/// Configuration for a serial driver and its polling console.
+#[derive(Clone, Copy)]
+pub struct DriverConfig {
+    /// Driver name used for serial-core reporting.
+    pub name: &'static CStr,
+    /// TTY and console name prefix.
+    pub device_name: &'static CStr,
+    /// Number of serial-core lines owned by this driver.
+    pub ports: u32,
+    /// Initial baud rate when console options do not supply one.
+    pub default_baud: u32,
+}
+
+impl DriverConfig {
+    fn validate(&self) -> Result {
+        // struct console uses name[16] and a signed short index. Its setup
+        // callback passes the baud rate to uart_set_options() as a signed int.
+        const CONSOLE_NAME_LEN: usize = 16;
+        if self.ports == 0
+            || self.ports > i16::MAX as u32
+            || self.default_baud == 0
+            || self.default_baud > i32::MAX as u32
+            || self.device_name.to_bytes().len() >= CONSOLE_NAME_LEN
+        {
+            return Err(EINVAL);
+        }
+        Ok(())
+    }
+}
+
+#[pinned_drop]
+impl<T: SerialOps> PinnedDrop for Driver<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: Registration succeeded and every port holds an Arc to this driver.
+        unsafe { bindings::uart_unregister_driver(self.inner.get()) };
+    }
+}
+
+/// Serial hardware callbacks currently needed by a two-wire polling console.
+///
+/// This is a subset of serial-core operations, not a full UART interface.
+/// Reception, interrupt-driven transmission and DMA are not supported.
+///
+/// Callbacks must not sleep or allocate. The adapters lock the UART and save local
+/// IRQ state for `set_termios` and normal `console_write` calls. During an oops,
+/// console output may run without the lock. `tx_empty` acquires no lock and may
+/// be called with the UART lock already held.
+///
+/// The parent device allocation remains live, but its managed resources may
+/// already have been revoked. Callbacks must check access to those resources.
+pub trait SerialOps: Send + Sync + Sized + 'static {
+    /// Whether both the transmit FIFO and shift register are empty.
+    fn tx_empty(&self, port: &Port<'_>) -> bool;
+    /// Applies console framing and baud rate, reflecting unsupported modes in `new`.
+    ///
+    /// The UART lock is held and local IRQs are disabled throughout this call.
+    fn set_termios(&self, port: &LockedPort<'_>, new: &mut Termios, old: Option<&Termios>);
+    /// Writes a console record using bounded polling, including during an oops.
+    fn console_write(&self, port: &Port<'_>, bytes: &[u8]);
+}
+
+/// Configuration supplied before registering a memory-mapped UART.
+pub struct PortConfig {
+    /// Serial-core line index.
+    pub line: u32,
+    /// Physical register base, for serial-core reporting.
+    pub mapbase: bindings::resource_size_t,
+    /// Baud generator frequency in Hz.
+    pub clock: u32,
+    /// Hardware FIFO capacity in bytes.
+    pub fifo_size: u32,
+}
+
+/// Registers an owned port until the device is unbound.
+///
+/// All state is owned and `'static`; no callback can retain a borrow into probe's
+/// stack. The registration is transferred to devres rather than returned to the
+/// caller. Forgetting a caller-owned object cannot leave borrowed data registered.
+/// On devres allocation failure, the registration is removed before returning.
+pub fn register_port<T: SerialOps>(
+    driver: Arc<Driver<T>>,
+    device: &Device<Bound>,
+    config: PortConfig,
+    data: impl PinInit<T, Error>,
+) -> Result {
+    if config.line >= driver.config.ports {
+        return Err(EINVAL);
+    }
+    let port = KBox::pin_init(
+        PortData::new(driver, device.into(), config, data),
+        GFP_KERNEL,
+    )?;
+    // SAFETY: All callback state is initialized and pinned. The device borrow keeps
+    // it bound until devres takes ownership. C retains nothing on registration failure.
+    unsafe {
+        to_result(bindings::uart_add_one_port(
+            port.driver.inner.get(),
+            port.inner.get(),
+        ))?;
+    }
+    devres::register(device, Registration { port }, GFP_KERNEL)
+}
+
+#[pin_data]
+struct PortData<T: SerialOps> {
+    #[pin]
+    inner: Opaque<bindings::uart_port>,
+    #[pin]
+    data: T,
+    driver: Arc<Driver<T>>,
+    device: ARef<Device>,
+}
+
+// SAFETY: uart_port's mutable C fields live in Opaque and use serial-core locking.
+// Data is Send + Sync; device/driver references keep their allocations alive.
+unsafe impl<T: SerialOps> Send for PortData<T> {}
+// SAFETY: Rust-owned fields are immutable after publication. C state changes use
+// port_mutex, tty_port.mutex, the UART lock and console-list/SRCU synchronization.
+unsafe impl<T: SerialOps> Sync for PortData<T> {}
+
+impl<T: SerialOps> PortData<T> {
+    fn new(
+        driver: Arc<Driver<T>>,
+        device: ARef<Device>,
+        config: PortConfig,
+        data: impl PinInit<T, Error>,
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(&this in Self {
+            data <- data,
+            driver,
+            device,
+            inner <- Opaque::ffi_init(|ptr: *mut bindings::uart_port| {
+                let port = bindings::uart_port {
+                    dev: device.as_raw(),
+                    line: config.line,
+                    mapbase: config.mapbase,
+                    uartclk: config.clock,
+                    fifosize: config.fifo_size,
+                    iotype: bindings::uart_iotype_UPIO_MEM,
+                    type_: bindings::PORT_GENERIC as u32,
+                    ops: &SerialAdapter::<T>::OPS,
+                    private_data: this.as_ptr().cast(),
+                    ..Default::default()
+                };
+                // SAFETY: The slot is private and exclusively owned until registration.
+                unsafe {
+                    ptr.write(port);
+                    bindings::uart_port_set_boot_autoconf(ptr);
+                }
+            }),
+        })
+    }
+
+    /// # Safety
+    /// `ptr` must be a PortData<T> port in a serial-core callback. Registration
+    /// owns its allocation until uart_remove_one_port returns; removal waits for
+    /// console_srcu readers and serial-core users before this port is freed.
+    /// Other device-managed resources may already have been revoked.
+    unsafe fn with_port<R>(
+        ptr: *mut bindings::uart_port,
+        f: impl for<'a> FnOnce(&'a Self, &Port<'a>) -> R,
+    ) -> R {
+        // SAFETY: The private_data type is fixed by Driver<T>/register_port<T>.
+        let state = unsafe { &*(*ptr).private_data.cast::<Self>() };
+        f(
+            state,
+            &Port {
+                raw: ptr,
+                device: &state.device,
+            },
+        )
+    }
+}
+
+/// Converts serial-core callbacks to the hardware operations and lock contexts.
+struct SerialAdapter<T: SerialOps>(PhantomData<T>);
+
+impl<T: SerialOps> SerialAdapter<T> {
+    const OPS: bindings::uart_ops = bindings::uart_ops {
+        tx_empty: Some(Self::tx_empty),
+        set_mctrl: Some(Self::set_mctrl),
+        get_mctrl: Some(Self::get_mctrl),
+        start_tx: Some(Self::inactive),
+        stop_tx: Some(Self::inactive),
+        stop_rx: Some(Self::inactive),
+        startup: Some(Self::startup),
+        shutdown: Some(Self::inactive),
+        set_termios: Some(Self::set_termios),
+        type_: Some(Self::port_type),
+        config_port: Some(Self::config_port),
+        verify_port: Some(Self::verify_port),
+        ..pin_init::zeroed()
+    };
+
+    /// # Safety
+    /// Must be called by serial core with a live port under the uart_ops contract.
+    unsafe extern "C" fn tx_empty(ptr: *mut bindings::uart_port) -> u32 {
+        // SAFETY: Serial core retains the registered port throughout this callback.
+        unsafe {
+            PortData::<T>::with_port(ptr, |state, port| {
+                if state.data.tx_empty(port) {
+                    bindings::TIOCSER_TEMT
+                } else {
+                    0
+                }
+            })
+        }
+    }
+
+    // Serial core requires these modem callbacks. This two-wire interface has no
+    // modem outputs and reports carrier/DSR/CTS asserted without hardware access.
+    extern "C" fn set_mctrl(_ptr: *mut bindings::uart_port, _value: u32) {}
+
+    extern "C" fn get_mctrl(_ptr: *mut bindings::uart_port) -> u32 {
+        bindings::TIOCM_CAR | bindings::TIOCM_DSR | bindings::TIOCM_CTS
+    }
+
+    // Required TTY operations remain inactive for this output-only console.
+    extern "C" fn inactive(_ptr: *mut bindings::uart_port) {}
+
+    extern "C" fn startup(_ptr: *mut bindings::uart_port) -> i32 {
+        EOPNOTSUPP.to_errno()
+    }
+
+    /// # Safety
+    /// Must be called by serial core with a live port under the uart_ops contract.
+    unsafe extern "C" fn set_termios(
+        ptr: *mut bindings::uart_port,
+        new: *mut bindings::ktermios,
+        old: *const bindings::ktermios,
+    ) {
+        // SAFETY: Serial core supplies live termios pointers and holds the port
+        // registration through this callback. No view or termios reference escapes.
+        unsafe {
+            PortData::<T>::with_port(ptr, |state, port| {
+                port.with_lock(|locked| {
+                    state.data.set_termios(
+                        locked,
+                        Termios::from_raw_mut(new),
+                        old.as_ref().map(|termios| Termios::from_raw(termios)),
+                    );
+                });
+            });
+        }
+    }
+
+    /// # Safety
+    /// Must be called by serial core with a live port under the uart_ops contract.
+    unsafe extern "C" fn port_type(ptr: *mut bindings::uart_port) -> *const crate::ffi::c_char {
+        // SAFETY: The registered port owns its hardware data and driver throughout
+        // the callback. The returned name is an immutable static C string.
+        unsafe { PortData::<T>::with_port(ptr, |state, _| state.driver.config.name.as_char_ptr()) }
+    }
+
+    /// # Safety
+    /// Must be called by serial core with a live port under the uart_ops contract.
+    unsafe extern "C" fn config_port(ptr: *mut bindings::uart_port, flags: i32) {
+        if flags & bindings::UART_CONFIG_TYPE as i32 != 0 {
+            // SAFETY: Serial core serializes port configuration.
+            unsafe { (*ptr).type_ = bindings::PORT_GENERIC as u32 };
+        }
+    }
+
+    /// # Safety
+    /// Must be called by serial core with a live port under the uart_ops contract.
+    unsafe extern "C" fn verify_port(
+        _ptr: *mut bindings::uart_port,
+        serial: *mut bindings::serial_struct,
+    ) -> i32 {
+        // SAFETY: Serial core supplies a valid serial_struct for the callback.
+        let kind = unsafe { (*serial).type_ };
+        if kind == bindings::PORT_UNKNOWN as i32 || kind == bindings::PORT_GENERIC {
+            0
+        } else {
+            EINVAL.to_errno()
+        }
+    }
+}
+
+struct Registration<T: SerialOps> {
+    port: Pin<KBox<PortData<T>>>,
+}
+
+impl<T: SerialOps> Drop for Registration<T> {
+    fn drop(&mut self) {
+        // SAFETY: Only successful registration constructs this guard. Serial core
+        // hangs up TTY users, unregisters the console, waits for console_srcu readers
+        // and drains uart_state references before returning. The allocation, hardware
+        // data and Driver Arc are released only after this synchronization.
+        unsafe {
+            bindings::uart_remove_one_port(self.port.driver.inner.get(), self.port.inner.get())
+        };
+    }
+}
+
+/// A callback-scoped view of a registered port.
+///
+/// Instances are only created by the FFI adapters. The registration and its
+/// device allocation remain live throughout the callback. Managed hardware
+/// resources need their own revocation-checked access guard.
+/// This view exposes the callback context independently of the hardware data type.
+///
+/// # Invariants
+///
+/// `raw` points to a registered port belonging to `device`. The FFI adapter keeps
+/// the port and its device allocation live for the entire borrow.
+pub struct Port<'a> {
+    raw: *mut bindings::uart_port,
+    device: &'a Device,
+}
+
+impl Port<'_> {
+    /// The parent device. Managed resources require revocation-checked access.
+    pub fn device(&self) -> &Device {
+        self.device
+    }
+
+    /// Runs a closure with the serial-core UART lock held and local IRQs saved.
+    fn with_lock<R>(&self, f: impl FnOnce(&LockedPort<'_>) -> R) -> R {
+        let guard = PortGuard::lock_irqsave(self);
+        let locked = LockedPort {
+            raw: self.raw,
+            device: self.device(),
+        };
+        let result = f(&locked);
+        drop(guard);
+        result
+    }
+}
+
+struct PortGuard<'a> {
+    port: &'a Port<'a>,
+    flags: crate::ffi::c_ulong,
+    unlock: bool,
+}
+
+impl<'a> PortGuard<'a> {
+    fn lock_irqsave(port: &'a Port<'_>) -> Self {
+        let mut flags = 0;
+        // SAFETY: The port remains live for this borrow. The caller does not
+        // already hold its UART lock.
+        unsafe { bindings::uart_port_lock_irqsave(port.raw, &mut flags) };
+        Self {
+            port,
+            flags,
+            unlock: true,
+        }
+    }
+
+    fn console_lock(port: &'a Port<'_>) -> Self {
+        let mut flags = 0;
+        // SAFETY: The port remains live for this borrow. The C helper permits
+        // emergency output without the lock if its trylock fails.
+        let unlock = unsafe { bindings::uart_port_console_lock(port.raw, &mut flags) };
+        Self {
+            port,
+            flags,
+            unlock,
+        }
+    }
+}
+
+impl Drop for PortGuard<'_> {
+    fn drop(&mut self) {
+        if self.unlock {
+            // SAFETY: The port is live and this guard acquired its UART lock.
+            unsafe { bindings::uart_port_unlock_irqrestore(self.port.raw, self.flags) };
+        }
+    }
+}
+
+/// A UART borrowed while its serial-core lock is held. Cannot escape the borrow.
+pub struct LockedPort<'a> {
+    raw: *mut bindings::uart_port,
+    device: &'a Device,
+}
+
+impl LockedPort<'_> {
+    /// The parent device. The UART lock does not prevent resource revocation.
+    pub fn device(&self) -> &Device {
+        self.device
+    }
+}
diff --git a/rust/kernel/serial/console.rs b/rust/kernel/serial/console.rs
new file mode 100644
index 0000000000000000000000000000000000000000..3562191eb7a937ca1b8d78be413c45f9de1d9b10
--- /dev/null
+++ b/rust/kernel/serial/console.rs
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Legacy polling console callbacks and emergency lock handling.
+
+use super::{
+    Port,
+    PortData,
+    PortGuard,
+    SerialOps, //
+};
+use crate::{
+    bindings,
+    prelude::*, //
+};
+use core::marker::PhantomData;
+
+/// Converts legacy console callbacks without owning a separate registration.
+pub(super) struct ConsoleAdapter<T: SerialOps>(PhantomData<T>);
+
+impl<T: SerialOps> ConsoleAdapter<T> {
+    /// # Safety
+    ///
+    /// `console` must belong to this adapter's live Driver<T>. The selected port
+    /// must remain live and its state must be serialized against removal. Console
+    /// core provides this through console_list_lock or console_srcu for writes.
+    unsafe fn console_port(console: *mut bindings::console) -> *mut bindings::uart_port {
+        // SAFETY: Serial core invokes callbacks only while this pinned console and driver
+        // are live. Port removal unregisters the console before releasing its port state.
+        unsafe {
+            let driver = (*console).data.cast::<bindings::uart_driver>();
+            if driver.is_null() || (*driver).state.is_null() {
+                return core::ptr::null_mut();
+            }
+            let index = (*console).index;
+            if index < 0 || i32::from(index) >= (*driver).nr {
+                return core::ptr::null_mut();
+            }
+            (*(*driver).state.add(index as usize)).uart_port
+        }
+    }
+
+    /// # Safety
+    ///
+    /// Console core must hold console_list_lock and supply this driver's live
+    /// console. `options` must be null or a valid NUL-terminated option string.
+    pub(super) unsafe extern "C" fn console_setup(
+        console: *mut bindings::console,
+        options: *mut crate::ffi::c_char,
+    ) -> i32 {
+        // SAFETY: Console core holds console_list_lock; serial core has published the port
+        // before registering this console. uart_set_options calls our termios adapter.
+        unsafe {
+            let port = Self::console_port(console);
+            if port.is_null() {
+                return ENODEV.to_errno();
+            }
+            let mut baud = (*console).ispeed as i32;
+            let (mut parity, mut bits, mut flow) = (i32::from(b'n'), 8, i32::from(b'n'));
+            if !options.is_null() {
+                bindings::uart_parse_options(options, &mut baud, &mut parity, &mut bits, &mut flow);
+            }
+            bindings::uart_set_options(port, console, baud, parity, bits, flow)
+        }
+    }
+
+    /// # Safety
+    ///
+    /// The caller must keep this driver's console and port live, normally with
+    /// console_srcu. For nonzero `count`, `text` must be valid for that many
+    /// initialized bytes within one allocation for the duration of this call.
+    pub(super) unsafe extern "C" fn console_write(
+        console: *mut bindings::console,
+        text: *const crate::ffi::c_char,
+        count: u32,
+    ) {
+        if count == 0 {
+            return;
+        }
+        // SAFETY: Legacy console writes hold console_srcu. unregister_console() waits
+        // for these readers before Registration releases the pinned port and data.
+        // Driver<T> only registers PortData<T>, so private_data has the matching type.
+        unsafe {
+            let port = Self::console_port(console);
+            if !port.is_null() {
+                PortData::<T>::with_port(port, |state, port| {
+                    let bytes = core::slice::from_raw_parts(text.cast(), count as usize);
+                    port.with_console_access(|| state.data.console_write(port, bytes));
+                });
+            }
+        }
+    }
+}
+
+impl Port<'_> {
+    /// Runs bounded, non-sleeping console I/O, including during emergency output.
+    ///
+    /// Normally the UART lock is held with local IRQs saved. During an oops a
+    /// failed trylock runs `f` without that lock: MMIO may race and output is
+    /// best effort. No LockedPort is provided, so locked serial-core state must
+    /// not be accessed here. Rust data shared by callbacks must remain Sync.
+    pub(super) fn with_console_access<R>(&self, f: impl FnOnce() -> R) -> R {
+        let guard = PortGuard::console_lock(self);
+        let result = f();
+        drop(guard);
+        result
+    }
+}
diff --git a/rust/kernel/serial/termios.rs b/rust/kernel/serial/termios.rs
new file mode 100644
index 0000000000000000000000000000000000000000..449662d9b6b5e634aacdd1e3b9016b0776a5afc3
--- /dev/null
+++ b/rust/kernel/serial/termios.rs
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Termios views and serial-core configuration under the UART lock.
+
+use super::LockedPort;
+use crate::bindings;
+use core::num::NonZeroU32;
+
+/// Termios borrowed for a serial-core set_termios callback.
+#[repr(transparent)]
+pub struct Termios(bindings::ktermios);
+
+impl Termios {
+    /// Borrows a termios supplied by serial core.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to an initialized `ktermios` that remains valid and is
+    /// not mutated for the returned borrow's lifetime.
+    pub(super) unsafe fn from_raw<'a>(ptr: *const bindings::ktermios) -> &'a Self {
+        // SAFETY: The caller guarantees a valid shared borrow. Self is transparent.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Exclusively borrows a termios supplied by serial core.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to an initialized `ktermios` that remains valid and is
+    /// exclusively accessible for the returned borrow's lifetime.
+    pub(super) unsafe fn from_raw_mut<'a>(ptr: *mut bindings::ktermios) -> &'a mut Self {
+        // SAFETY: The caller guarantees an exclusive borrow. Self is transparent.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Whether parity generation and checking are enabled.
+    pub fn parity_enabled(&self) -> bool {
+        self.0.c_cflag & bindings::PARENB != 0
+    }
+
+    /// Whether odd parity, or mark parity in mark/space mode, is selected.
+    pub fn odd_parity(&self) -> bool {
+        self.0.c_cflag & bindings::PARODD != 0
+    }
+
+    /// Whether two stop bits are requested.
+    pub fn two_stop_bits(&self) -> bool {
+        self.0.c_cflag & bindings::CSTOPB != 0
+    }
+
+    /// Disables mark/space parity without changing parity enable or odd/even selection.
+    pub fn disable_mark_space_parity(&mut self) {
+        self.0.c_cflag &= !bindings::CMSPAR;
+    }
+
+    /// Disables RTS/CTS hardware flow control.
+    pub fn disable_hardware_flow_control(&mut self) {
+        self.0.c_cflag &= !bindings::CRTSCTS;
+    }
+
+    /// Data bits per character.
+    pub fn char_size(&self) -> u32 {
+        // SAFETY: c_cflag is a valid termios control flag value.
+        unsafe { bindings::tty_get_char_size(self.0.c_cflag).into() }
+    }
+}
+
+impl LockedPort<'_> {
+    /// Selects a supported baud rate using serial-core termios rules.
+    ///
+    /// Returns `None` if serial core fails to select a rate. Termios changes
+    /// made by serial core are preserved, including on failure.
+    pub fn baud_rate(
+        &self,
+        new: &mut Termios,
+        old: Option<&Termios>,
+        min: u32,
+        max: u32,
+    ) -> Option<NonZeroU32> {
+        // SAFETY: The port is locked, and the termios references are valid for this callback.
+        let baud = unsafe {
+            bindings::uart_get_baud_rate(
+                self.raw,
+                &mut new.0,
+                old.map_or(core::ptr::null(), |t| &t.0),
+                min,
+                max,
+            )
+        };
+        NonZeroU32::new(baud)
+    }
+
+    /// Updates serial-core timeout and the actual console baud rate.
+    pub fn configure(&self, new: &mut Termios, baud: NonZeroU32) {
+        let baud = baud.get();
+        // SAFETY: All port fields are accessed under the UART lock. new is exclusively borrowed.
+        unsafe {
+            bindings::uart_update_timeout(self.raw, new.0.c_cflag, baud);
+            if bindings::tty_termios_baud_rate(&new.0) != 0 {
+                bindings::tty_termios_encode_baud_rate(&mut new.0, baud, baud);
+            }
+        }
+    }
+}

-- 
2.47.3

