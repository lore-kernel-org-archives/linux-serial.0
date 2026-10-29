Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250415;
	b=ybxoP6UbpXhBbFBjKc3oYrBiLUKGs5ZpjhNTMjFoXwERaCxJwMTpVoUmQbmjTbwdSWPc
	 eI/HWLct32jeMS0f+yclTfsTXT3P2hnkshW3LyJIMOvkTAGJ2N5AjZrI3yxVPAXM0y9r3
	 MyGrMVngYBmiC3hdrZbeK2wl1a0pErQ9lVuxn6tnc+R8nIEvwJrPZ3+xst93UN+/P/Umh
	 iWTmFxSHYyS1vv63m3KYHvCeNmacyTle5apbtntejzXfkxC+Ekxs7bukICdLMh0+a1kQf
	 1TT78Cpu88gkLEjiEViZmQAK8DMzzqe4SxTh5Je2nPjgOilaT2s9jLnlG0Jlk+g80JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=P1HpC8OctDgrucLKXFCuwI9p/x3lA/iI3ZaNcaH9r4Q=;
	b=YWrae48iLPrkw4lFsgG/QuzSxUfhIK9ibcM1CwXh+HmiZQgnHX7wO9mwJOZopKNj87TR
	 0PDcvA7PU0Y2suHksZR/HzAuxbbFFGuvKACMZEg8OKR4NVUFsBUdjJ8NnDuflk4s42Qmd
	 RkRXz2wF+cxhaw7E/2CmEZFQ1tLun7LmCr1b5MM+m28UxvIw0URJAqBBO+anTMhayhJoN
	 2wc+cfkQ9WBC3/46ZpOpxxIisKY5Dnzo75fiuykqO28JThuJ2VuFttUfqyu3uKH5Bv8mH
	 sR1wQPmSQ+taB5bVjzYP4IfiprfpuDDF18VFaF0BpYxqgzBgDvgGl4kstbcWooMsgKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z6W48XXH;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0785606A323
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0785606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z6W48XXH
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e934c6c1c8so5377345ad.0
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250414; x=1793855214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1HpC8OctDgrucLKXFCuwI9p/x3lA/iI3ZaNcaH9r4Q=;
        b=Z6W48XXHoO9UsrPsmk143+ho2vWLYo/IKtMtiGauJTH2i+hXIRpZ4d0GS+YhVYvtU2
         0cGgxBLn97uVls7x5I6dis1fcVkOgKqyDgDbTnWRAJ5X5fyjNF1Tb8gk3U+yHDzLEvo/
         iBOeOv6RGgMmgHgFEnuc7zFqDbHLjh/a2I7Gq+u8cCAGcg2mv02nXLg4TgBaSleutauP
         DVNbZaJrYskygNvADx8Cct8txdezYdKJjVYi65RLFrzi/ga4/IhzuJmUAy0fCPYOLS/K
         b2RB1B8h6fjZZUCUWW8XWmS3zuvmCrWBRJzk/e/xmW6cVvTZWpcFs5RUwReVH0JEMrWA
         cbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250414; x=1793855214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1HpC8OctDgrucLKXFCuwI9p/x3lA/iI3ZaNcaH9r4Q=;
        b=oA3vZKFeN7CJFNXgf+4gb8ftdNgTmt3+n8du8GjLts8AZtJKYZXHqLhpAw4QwLgm1i
         RG+G+HBhmh9rzIek+CZWnTeXoxs4HdoiChz6EFPFdsdb2PoRl45YZqcoABvaivSOnown
         PeS+40helXPRmuwdOkHv0f5dKOj302dG/I4AbrdlN3c7PUtsYUWPdPRmJ/r12hlynZLu
         hU/N9U8NydYOvwvJNaST8fwMbkkfLjYJb5Lqoxz9uSwD5NuxwjfQ6JCf5zjeK+qKnsFv
         VjOewJPrGwqb4wJ9V+tvQb7fVZWPl0jbmynaJnP8zOGyJBuPPtMH7d5yTL40wuorkzVU
         yoyw==
X-Forwarded-Encrypted: i=1; AKwUvBxqtcGwVPMahYBU2+6sW73YybtB57TGkoVktM5zjKaGkBK84cDhnQ+DIkWSmer9mx5ok5tY1u5R3Oot7bU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9VKtbE+a41uoLpW9WFn54mc9eJrw3h7LVooIaZxHunr9aKU6T
	x8/nwDyplkktGmBZvTj8EAntAVGmhQfCclW5NyJnMZ+OzHZpYylhrLVW
X-Gm-Gg: AYBFou3iSoBp/zgb78z1kRff6SUgQfuY8tADqQTR8SKbjFjLYCgd2WHriE2IFmx4fq4
	kx3zP8KZItaxtIbaIIskOugJPbAq8ph9tZMPuqWFSRQrJ63/AjKiXtIes4/vyyurQ45Nq7PcXK1
	c9qB4X4j1sMbF8Qs0KPAOBGEPtNboyBB9QPKJvlTgagog7ImSFj/tFj9+KAGwTsOelVfko3kMZQ
	+EQUrDTZL92mz0mJyk1MPcpeiFvGZnLq10OR4q0Zfus9EXoHz+vZ/OLLU1+ixWMnbX6g4i+JZkd
	/NAIBt58OnK6lJd9JFpWhatda9DVQynTyeWq9730M5BmTnZU67wlqzbAdowBXcGAQea73+SGn35
	WeJAaBEifDgbp5412IK0WJVRxQlYxOJBcWlRgrY5C61GWtO3dpki576klcUmIEi84nbCyFhKi+o
	hexSteQKtLaKgSkaW+T6XXJirhvi/RcwJxMDE/qDUQaJuO9BqNYO/POYTZhjmtKvQ/dLbHdwYKx
	oEkOwvGJLL/6SNg6QY5rgIFpAWXWi2O+wlBUWESiw2Umzi6p6DXgDkpRLHyw5nz051Jgmc7L7Lh
	F7NhVUtFm5B7yik4YgTJOz3XNDo7n7qeDarJU9/NxihQ056M+A==
X-Received: by 2002:a17:902:e848:b0:2e6:943:39df with SMTP id d9443c01a7336-2eb00488b94mr42201205ad.25.1793250414083;
        Wed, 28 Oct 2026 22:06:54 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:06:52 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Thu, 29 Oct 2026 01:05:48 -0400
Subject: [PATCH RFC 07/12] serial: bflb: Add Rust BL808 polling console
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
Message-Id: <20261029-rust-bl808-console-v1-7-b736ee920078@gmail.com>
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

Add a Rust driver for the Bouffalo Lab BL808 UART controller with polling
console support. Register UART3 as ttyBFLB0 and provide bounded polling
and newline conversion.

The driver uses an exclusive MMIO mapping and a baud clock supplied by
the device tree. Firmware configures clock routing, gates, reset and
pinmux. Userspace TTY I/O, RX, interrupts and DMA are not implemented.

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 drivers/tty/serial/Kconfig      |   8 +
 drivers/tty/serial/Makefile     |   2 +
 drivers/tty/serial/bflb_uart.rs | 334 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 344 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 9b17d451f19df6575bc8a4a08245065f9b8e3715..9f549c5033fc077e921f5b6f3e72bad2144f83b7 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -26,6 +26,14 @@ config RUST_SERIAL_ABSTRACTIONS
 	help
 	  This enables Rust abstractions for the serial core API.
 
+config SERIAL_BFLB_RUST
+	bool "Bouffalo Lab polling serial console in Rust"
+	depends on RUST && OF && COMMON_CLK && HAS_IOMEM
+	select RUST_SERIAL_ABSTRACTIONS
+	help
+	  Say Y here to enable kernel console support for the Bouffalo Lab
+	  BL808 UART controller.
+
 config SERIAL_AMBA_PL010
 	tristate "ARM AMBA PL010 serial port support"
 	depends on ARM_AMBA || COMPILE_TEST
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index d63b126f40caf55b44c9ac2e6a484a0c13ca1b57..36364fe714c85df5029f2ac95a027a3787f331c7 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -99,3 +99,5 @@ obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
 
 obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
 obj-$(CONFIG_SERIAL_NUVOTON_MA35D1) += ma35d1_serial.o
+
+obj-$(CONFIG_SERIAL_BFLB_RUST) += bflb_uart.o
diff --git a/drivers/tty/serial/bflb_uart.rs b/drivers/tty/serial/bflb_uart.rs
new file mode 100644
index 0000000000000000000000000000000000000000..4e34aa9a95cab665e18230453af5706b0061049a
--- /dev/null
+++ b/drivers/tty/serial/bflb_uart.rs
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Bouffalo Lab UART3 polling console.
+
+use core::num::NonZeroU32;
+
+use kernel::{
+    clk::Clk,
+    device::{
+        Bound,
+        Core,
+        Device, //
+    },
+    devres::DevresGuard,
+    driver,
+    io::{
+        mem::{
+            DevresExclusiveIoMem,
+            ExclusiveIoMem, //
+        },
+        poll::read_poll_timeout_atomic,
+        Io,
+        IoBase, //
+    },
+    of,
+    platform,
+    prelude::*,
+    serial::{
+        self,
+        DriverConfig,
+        LockedPort,
+        Port,
+        Termios, //
+    },
+    sync::Arc,
+    time::Delta, //
+};
+
+const REG_SIZE: usize = 0x90;
+const FIFO_DEPTH: u32 = 32;
+const PORTS: u32 = 1;
+const DEFAULT_BAUD: u32 = 115200;
+const POLL_RETRIES: usize = 100_000;
+const MAX_BIT_PERIOD: u32 = 65536;
+const MAX_BAUD: u32 = 4000000;
+
+const UTX_CONFIG: usize = 0x00;
+const URX_CONFIG: usize = 0x04;
+const BIT_PRD: usize = 0x08;
+const DATA_CONFIG: usize = 0x0c;
+const SW_MODE: usize = 0x1c;
+const INT_MASK: usize = 0x24;
+const INT_EN: usize = 0x2c;
+const STATUS: usize = 0x30;
+const FIFO_CONFIG0: usize = 0x80;
+const FIFO_CONFIG1: usize = 0x84;
+const FIFO_WDATA: usize = 0x88;
+
+// BL808 UART register fields, named after the reference manual.
+const UTX_EN: u32 = 1 << 0;
+const UTX_FRM_EN: u32 = 1 << 2;
+const UTX_PRT_EN: u32 = 1 << 4;
+const UTX_PRT_SEL: u32 = 1 << 5;
+const UTX_BIT_CNT_D_SHIFT: u32 = 8;
+const UTX_BIT_CNT_P_SHIFT: u32 = 11;
+const UTX_STOP_ONE: u32 = 1 << UTX_BIT_CNT_P_SHIFT;
+const UTX_STOP_TWO: u32 = 3 << UTX_BIT_CNT_P_SHIFT;
+const UTX_BUS_BUSY: u32 = 1 << 0;
+const TX_FIFO_CNT_MASK: u32 = 0x3f;
+const URX_BIT_PRD_SHIFT: u32 = 16;
+
+kernel::sync::global_lock! {
+    // SAFETY: Initialized once in module init, before registering the platform driver.
+    unsafe(uninit) static SERIAL: Mutex<Option<Arc<serial::Driver<Hardware>>>> = None;
+}
+
+struct SerialOwner;
+
+impl SerialOwner {
+    fn new(module: &'static ThisModule) -> Result<Self> {
+        // SAFETY: Module init runs once per load, before any access to SERIAL.
+        unsafe { SERIAL.init() };
+        *SERIAL.lock() = Some(Arc::pin_init(
+            serial::Driver::new(
+                DriverConfig {
+                    name: c"bflb_uart",
+                    device_name: c"ttyBFLB",
+                    ports: PORTS,
+                    default_baud: DEFAULT_BAUD,
+                },
+                module,
+            ),
+            GFP_KERNEL,
+        )?);
+        Ok(Self)
+    }
+}
+
+impl Drop for SerialOwner {
+    fn drop(&mut self) {
+        SERIAL.lock().take();
+    }
+}
+
+#[pin_data]
+struct UartModule {
+    // Fields drop in declaration order: remove platform devices and drain their
+    // serial callbacks before releasing the module's serial-driver reference.
+    #[pin]
+    _platform: driver::Registration<platform::Adapter<Uart>>,
+    _serial: SerialOwner,
+}
+
+impl kernel::InPlaceModule for UartModule {
+    fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            // Publish the serial driver before platform registration can probe.
+            _serial: SerialOwner::new(module)?,
+            _platform <- driver::Registration::new(c"bflb_uart", module),
+        })
+    }
+}
+
+module! {
+    type: UartModule,
+    name: "bflb_uart",
+    authors: ["Kwanghoon Son"],
+    description: "Bouffalo Lab polling serial console",
+    license: "GPL",
+}
+
+struct Uart;
+
+kernel::of_device_table!(OF_TABLE, (), [(of::DeviceId::new(c"bflb,uart"), ())]);
+
+impl Uart {
+    fn register(pdev: &platform::Device<Core<'_>>) -> Result {
+        let dev: &Device<Bound> = pdev.as_ref();
+        let mapbase = pdev.resource_by_index(0).ok_or(ENODEV)?.start();
+        let io = pdev
+            .io_request_by_index(0)
+            .ok_or(ENODEV)?
+            .iomap_exclusive_sized::<REG_SIZE>()?
+            .into_devres()?;
+        let baud = EnabledClock::get(dev, c"baud")?;
+        let clock = u32::try_from(baud.0.rate().as_hz())?;
+        if clock == 0 {
+            return Err(EINVAL);
+        }
+        let serial = SERIAL.lock().as_ref().ok_or(ENODEV)?.clone();
+        serial::register_port(
+            serial,
+            dev,
+            serial::PortConfig {
+                line: 0,
+                mapbase,
+                clock,
+                fifo_size: FIFO_DEPTH,
+            },
+            Ok(Hardware {
+                io,
+                clock,
+                _baud: baud,
+            }),
+        )?;
+        Ok(())
+    }
+}
+
+impl platform::Driver for Uart {
+    type IdInfo = ();
+    type Data<'bound> = ();
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+
+    fn probe<'bound>(
+        pdev: &'bound platform::Device<Core<'_>>,
+        _info: Option<&'bound ()>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        Self::register(pdev)
+    }
+}
+
+struct EnabledClock(Clk);
+
+impl EnabledClock {
+    fn get(dev: &Device, name: &CStr) -> Result<Self> {
+        let clock = Clk::get(dev, Some(name))?;
+        clock.prepare_enable()?;
+        Ok(Self(clock))
+    }
+}
+
+impl Drop for EnabledClock {
+    fn drop(&mut self) {
+        self.0.disable_unprepare();
+    }
+}
+
+struct Hardware {
+    io: DevresExclusiveIoMem<REG_SIZE>,
+    clock: u32,
+    _baud: EnabledClock,
+}
+
+impl Hardware {
+    fn registers(&self, dev: &Device) -> Option<Registers<'_>> {
+        if !core::ptr::eq(self.io.device(), dev) {
+            return None;
+        }
+        Some(Registers {
+            io: self.io.try_access()?,
+        })
+    }
+}
+
+/// Keeps the mapping alive for the entire non-sleeping register operation.
+/// Unbind can revoke other resources before the serial port itself is removed.
+struct Registers<'a> {
+    io: DevresGuard<'a, ExclusiveIoMem<'static, REG_SIZE>>,
+}
+
+impl Registers<'_> {
+    fn read<const REG: usize>(&self) -> u32 {
+        (&*self.io).as_view().read32(REG)
+    }
+
+    fn write<const REG: usize>(&self, value: u32) {
+        (&*self.io).as_view().write32(value, REG);
+    }
+
+    fn wait_for(&self, ready: impl Fn() -> bool) -> Result {
+        read_poll_timeout_atomic(|| Ok(ready()), |ready| *ready, Delta::ZERO, POLL_RETRIES)?;
+        Ok(())
+    }
+
+    fn write_byte(&self, ch: u8) -> Result {
+        self.wait_for(|| self.read::<FIFO_CONFIG1>() & TX_FIFO_CNT_MASK != 0)?;
+        (&*self.io).as_view().write8(ch, FIFO_WDATA);
+        Ok(())
+    }
+
+    fn tx_empty(&self) -> bool {
+        self.read::<FIFO_CONFIG1>() & TX_FIFO_CNT_MASK == FIFO_DEPTH
+            && self.read::<STATUS>() & UTX_BUS_BUSY == 0
+    }
+
+    fn write_record(&self, bytes: &[u8]) -> Result {
+        for &ch in bytes {
+            if ch == b'\n' {
+                self.write_byte(b'\r')?;
+            }
+            self.write_byte(ch)?;
+        }
+        self.wait_for(|| self.tx_empty())
+    }
+
+    fn mask_interrupts(&self) -> u32 {
+        let saved = self.read::<INT_MASK>();
+        self.write::<INT_MASK>(u32::MAX);
+        saved
+    }
+
+    fn enable_tx(&self) {
+        self.write::<UTX_CONFIG>(self.read::<UTX_CONFIG>() | UTX_EN);
+    }
+
+    fn console_write(&self, bytes: &[u8]) {
+        let saved_mask = self.mask_interrupts();
+        self.enable_tx();
+        let _ = self.write_record(bytes);
+        self.write::<INT_MASK>(saved_mask);
+    }
+}
+
+impl serial::SerialOps for Hardware {
+    fn tx_empty(&self, port: &Port<'_>) -> bool {
+        let Some(registers) = self.registers(port.device()) else {
+            return false;
+        };
+        registers.tx_empty()
+    }
+
+    fn set_termios(&self, port: &LockedPort<'_>, new: &mut Termios, old: Option<&Termios>) {
+        let Some(registers) = self.registers(port.device()) else {
+            return;
+        };
+        new.disable_mark_space_parity();
+        new.disable_hardware_flow_control();
+        let mut tx = (new.char_size() - 1) << UTX_BIT_CNT_D_SHIFT;
+        if new.parity_enabled() {
+            tx |= UTX_PRT_EN;
+            if new.odd_parity() {
+                tx |= UTX_PRT_SEL;
+            }
+        }
+        tx |= if new.two_stop_bits() {
+            UTX_STOP_TWO
+        } else {
+            UTX_STOP_ONE
+        };
+        tx |= UTX_EN | UTX_FRM_EN;
+        let Some(baud) = port.baud_rate(
+            new,
+            old,
+            self.clock.div_ceil(MAX_BIT_PERIOD),
+            self.clock.min(MAX_BAUD),
+        ) else {
+            return;
+        };
+        let baud = baud.get();
+        let divisor = ((u64::from(self.clock) + u64::from(baud) / 2) / u64::from(baud))
+            .clamp(1, u64::from(MAX_BIT_PERIOD)) as u32;
+        let Some(actual_baud) = NonZeroU32::new(self.clock / divisor) else {
+            return;
+        };
+        let _ = registers.wait_for(|| registers.tx_empty());
+        registers.write::<INT_MASK>(u32::MAX);
+        registers.write::<INT_EN>(0);
+        registers.write::<FIFO_CONFIG0>(0);
+        registers.write::<URX_CONFIG>(0);
+        registers.write::<DATA_CONFIG>(0);
+        registers.write::<SW_MODE>(0);
+        registers.write::<BIT_PRD>((divisor - 1) | ((divisor - 1) << URX_BIT_PRD_SHIFT));
+        registers.write::<UTX_CONFIG>(tx);
+        port.configure(new, actual_baud);
+    }
+
+    fn console_write(&self, port: &Port<'_>, bytes: &[u8]) {
+        let Some(registers) = self.registers(port.device()) else {
+            return;
+        };
+        registers.console_write(bytes);
+    }
+}

-- 
2.47.3

