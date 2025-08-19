Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E47627E060
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616030; cv=none; b=qX//UhOAK+MVRqq9VnWQW4W8DbEfZ4F3ZwLVR9ZFrS5IMFlZfx9oV9nIQiQG2cRWaze8WgRizftxESbyOKOVV97aPl152EGut+2uXgvTKhXfELLaArygv71dh1v9hmfVtnRJ+1KS+3yaGRFI7AZFCyB5USdJxOeZ4qgoWc6zEfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616030; c=relaxed/simple;
	bh=KyjmNrorBbzUQ9oeCduCeg6t9FMthLDNO69bghqrlV4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LumEXMJkUyT956YFQh2DbOd7kuuk6wfaC78ODuohmdX0/6FuID3zPuKTNZ/IkF3L3KpBJvLNAKR+fo6mrRILr7VJtophRbNfFaV62K5J5Gc7qdlH5/eBAUdF9NeGOz30l6/uSwyphnJsYNYwx4oltNK9rYuxpUp67tR4DU/xSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=NYu5kuNm; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NYu5kuNm"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30cce8c3b06so736965fac.1
        for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1755616027; x=1756220827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a9Ls3g12QaPZhkK6UgjJ7QnZ38JdbJNjbf81v6tqkPI=;
        b=NYu5kuNmvObIcObOezO/ZLIuB0Hl7CpB1O/x7UHhirV3/wBsz7vkBUkAn5X5CqnMAI
         Sfo4bKwOiJZOSVxHQcGG4FfYxXJNjwosUS9we3m0GniwBI/IlHaawNpZzF+YAe8AkFOT
         eZqlcengsiGrM/XokdhwFyktiTnhJFhJaBDqolIYcHdE4ZgfrYyoam6V9LRO7Xla+45s
         JCsOA0zw+e2z8EnQWd3th5YNvi3gJvYxUkHbZMmWgLSiBCy7Tx0sprcPCiBHyUzSowg3
         OzuVOUvYQIxAoY06+OcGA7wA9KnJWGULQBLZUAWYE0VLwMdL/Ttrj0QntPjeIHd0kVdt
         H9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616027; x=1756220827;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9Ls3g12QaPZhkK6UgjJ7QnZ38JdbJNjbf81v6tqkPI=;
        b=dMVMLeUSrZyaetfj9FiK3CHfRwXXeWU6K+NnbIF4g1QaYbgBxI+auzKpp3FJ/VD34E
         TY5vknAErD3Csc5h0dNjLPqR22kvspHTMrlIjHxGfvxNJUOASvzQoAT8LA0E/cSJUjKx
         k2VxuSppiKOxFj+prKkvbHMT2SF+FHVp509kFd7BKif5+u7s5XG1ppLC8L0EIcROKEnX
         wbxkGtqvupjiaY/TlS+dXha5wE4+Ji5gC7EkvGvqLi2qMCkvVODazkRcSx67UStM/Rid
         PQ2ZT0uS0C00Vv9Tx75OeYAXAJZeVpQgCz/0KiLjHTVSJFJBu3bE2B6fYirjNEwZMnMY
         1QnA==
X-Gm-Message-State: AOJu0YyLZUTVA61LIZXgiE6feRsE101uOVRPa1KiI5kSuzcGMKQCVSlM
	8wvlaE8J8nPzj6BWNc260VShBuWYCU+aRlgw6VvFwDewgW0uv2SASol2a+4U4B6l8Uf3m0JFcFU
	ZfK66rntlv2K224pxESJiKT/tH7FSpi5VpDlshAAw3l5obFKGO89SMg==
X-Gm-Gg: ASbGnctzGb1KMebXjMjhOD1ojhdRSyLVO2cTfoClHTDZOyUNzwwKXGtUriiJm0z1J5V
	U2gryfYn3K6YgDX6FK6xY+PlJvWzf8pL0DYvC5U+L3/6tMYskMb3o6t9llwrUN1sheIir3HDaG0
	EDPdOgUlbgPr91BfQ/Jxk2Xbm4d+SlPgeBsCqrOX1rYY4CwPN/EPAHGg9YaByWhQVsW98YOr/th
	YQU+lSP
X-Google-Smtp-Source: AGHT+IE0sKzxb6xUCjhrzl+OIEJVOa4TwswkH+jQC8uvgf/qdjyyhllAN25TZCa0uspNam1CpvnjvNNq2tW9vGuQRHY=
X-Received: by 2002:a05:6808:1916:b0:433:fea5:53ec with SMTP id
 5614622812f47-436da43bb65mr706402b6e.3.1755616026959; Tue, 19 Aug 2025
 08:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adriana Nicolae <adriana@arista.com>
Date: Tue, 19 Aug 2025 18:06:55 +0300
X-Gm-Features: Ac12FXxuSWeosJCWXk7veluzjCaDF2PwxYDs_21N_7oHQcHIVy48pjip182k7Ek
Message-ID: <CAERbo5wdG_n6sFnYjWL6oqfvDFz4iokhNz-H2XLHCkmfyMWOdw@mail.gmail.com>
Subject: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
To: linux-serial@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	Prasad Koya <prasad@arista.com>
Content-Type: text/plain; charset="UTF-8"

This patch is proposing a custom configuration for Synopsys DesignWare
serial to be used by products with associated compatible string in the
device tree.

The PORT_DWAPB config will be used instead of the default PORT_16550A
which does not include the UART_FCR_CLEAR_RCVR and UART_FCR_CLEAR_XMIT
bits for the FIFO configuration register. Having those flags is necessary
to clear FIFO when the serial port is reconfigured with do_set_termios.

Additionally, inside the do_set_termios we use the LCR (Line Control
Register) to enable DLAB bit in order to access DLL/DLM (Divisor Latch
Low/High) registers for baud rate setting. These 2 registers are sharing
the same address space with UART_TX/UART_RX and UART_IER. The sequence is:

(1) enable DLAB -> (2) set baud -> (3) disable DLAB -> (4) reset FCR

When there is a TX or RX flow on the serial while we attempt to set/clear
DLAB, the LCR write will be ignored and we will get a IIR_BUSY interrupt
afterwards which is cleared by only reading the USR (UART status register).

The sequence above can leave the serial in an unstable state in two cases:

 - if UART is busy while (1), then LCR is still pointing to the normal set of
registers, which means the code setting DLL/DLM is actually writing into TX or
modifying interrupts in UART_IER which may end with either a garbage char '\'
on the console or with serial interrupts disabled.

 - if UART is busy while (3), then LCR remains pointing to DLL/DLM instead of
moving back to RX/TX. The first transfer on the serial will be stuck because
the transmit/receive registers are not accessible unless the DLAB bit
is cleared.

The changes in this patch include a specific serial_out function for this UART
type similar to the one for Armada-38x devices in commit
b7639b0b15ddd1a4686b0142e70dfb122eefc88f with some changes in the tx_wait_empty
function to check the UART status by looking at the USR register and actively
try to clear FIFO to reduce time before a LCR write since the characters will
be lost otherwise after baud rate change.

The USR register may report that UART is busy even if TX/TX FIFO is already
empty so we will loop until all USR[0] (UART busy status) is cleared and USR[1]
TX FIFO is empty (RX FIFO bits should be 0 in this case).
Keeping the same timeout of 20ms as measurements with the 9600 baud when
the console was busy it took max 1.9ms to get the UART free state.

Signed-off-by: Adriana Nicolae <adriana@arista.com>
---
 drivers/tty/serial/8250/8250_dw.c   |   52 +++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c |    8 +++++
 include/uapi/linux/serial_core.h    |    3 ++
 3 files changed, 63 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c
b/drivers/tty/serial/8250/8250_dw.c
index ace221afe..337b9a8bf 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -33,10 +33,16 @@

 /* Offsets for the DesignWare specific registers */
 #define DW_UART_USR 0x1f /* UART Status Register */
+#define DW_UART_USR_BUSY 0x1 /* UART Busy status */
+#define DW_UART_USR_TFNF 0x2 /* UART TX FIFO not full */
+#define DW_UART_USR_TFE  0x4 /* UART TX FIFO empty */

 /* DesignWare specific register fields */
 #define DW_UART_MCR_SIRE BIT(6)

+#define DW8250_REG( p, reg ) \
+ ((void __iomem *)(p->membase + ((reg) << p->regshift)))
+
 struct dw8250_data {
  struct dw8250_port_data data;

@@ -159,6 +165,46 @@ static void dw8250_serial_out38x(struct uart_port
*p, int offset, int value)
  dw8250_check_lcr(p, value);
 }

+/* Drain FIFO and wait for USR to be not busy and TX/RX FIFO empty */
+static void dw8250_tx_wait_empty_apb(struct uart_port *p)
+{
+ unsigned int tries = 20000;
+ unsigned int delay_threshold = tries - 1000;
+ unsigned int usr;
+
+ while (tries--) {
+ usr = readl(DW8250_REG(p, DW_UART_USR));
+
+ /* Check UART free and TX/RX FIFO empty */
+ if ((usr & ~DW_UART_USR_TFNF) == DW_UART_USR_TFE)
+ break;
+
+ /* FIFO is still not empty, try to clear it */
+ if (tries < delay_threshold) {
+ writel(UART_FCR_ENABLE_FIFO, DW8250_REG(p, UART_FCR));
+ writel(UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
+ UART_FCR_CLEAR_XMIT, DW8250_REG(p, UART_FCR));
+ writel(0, DW8250_REG(p, UART_FCR));
+ udelay (1);
+ }
+ }
+}
+
+static void dw8250_serial_outapb(struct uart_port *p, int offset, int value)
+{
+       struct dw8250_data *d = to_dw8250_data(p->private_data);
+
+ if(offset == UART_LCR && !d->uart_16550_compatible)
+ dw8250_tx_wait_empty_apb(p);
+
+ writel(value, DW8250_REG(p, offset));
+
+ if (offset == UART_LCR && !d->uart_16550_compatible) {
+ /* Check FIFO is left enabled and LCR was written */
+ writel(UART_FCR_ENABLE_FIFO, DW8250_REG(p, UART_FCR));
+ dw8250_check_lcr(p, value);
+ }
+}

 static void dw8250_serial_out(struct uart_port *p, int offset, int value)
 {
@@ -421,6 +467,12 @@ static void dw8250_quirks(struct uart_port *p,
struct dw8250_data *data)
  }
  if (of_device_is_compatible(np, "marvell,armada-38x-uart"))
  p->serial_out = dw8250_serial_out38x;
+ if (of_device_is_compatible(np, "snps,dw-apb-uart")) {
+ p->type = PORT_DWAPB;
+ p->flags |= UPF_FIXED_TYPE;
+ p->serial_out = dw8250_serial_outapb;
+ data->skip_autocfg = true;
+ }

  } else if (acpi_dev_present("APMC0D08", NULL, -1)) {
  p->iotype = UPIO_MEM32;
diff --git a/drivers/tty/serial/8250/8250_port.c
b/drivers/tty/serial/8250/8250_port.c
index 0cc4dcf23..d627d85a0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -307,6 +307,14 @@ static const struct serial8250_config uart_config[] = {
  .rxtrig_bytes = {1, 32, 64, 112},
  .flags = UART_CAP_FIFO | UART_CAP_SLEEP,
  },
+ [PORT_DWAPB] = {
+ .name = "Synopsys DesignWare",
+ .fifo_size = 16,
+ .tx_loadsz = 16,
+ .fcr = UART_FCR_ENABLE_FIFO |
+   UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+ .flags = UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_IRDA,
+ },
 };

 static const char *platform_list[] = {
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 851b982f8..279fc4c98 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -279,4 +279,7 @@
 /* Freescale LINFlexD UART */
 #define PORT_LINFLEXUART 122

+/* Synopsys DesignWare */
+#define PORT_DWAPB 123
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
