Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22B24468A;
	Fri, 25 Apr 2025 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579603; cv=none; b=JB9A4m2N+x7HHmhgnQipBZplGyFHkhLmoSxHraclQInvOp82Ys5gJSDnM4Ot5XAI4h9fO5nvSH1DCKa7MdDd9lezXBUUNGqLCeN2dtTQuv8tsQqdATh3y1MKEIXZJCdX0ENEyP0VOuXvNVnYJgEjrXGQjXZq06h4Zp3rrIM6a/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579603; c=relaxed/simple;
	bh=ssThIJKeGvl3X5SWalgKQopEkvTDLH+DyEpRuPXOc18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGjm4rWJ5hAwN44JQ49NhRbWy+dZOEhTpcs4/CeRY+sMXMQZBUnkdTuxvrN7D6Khk+yylhJaUhxucuk3n1SmXjheoUvk4l3pDk20yAg6eCEVXxnOnKqiO/7g0pLqXGu+WmTFxxxe1Uq0J2j8gTKVYoCu27HuzwmgNb3onSnSQDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjrUYXFw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjrUYXFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FA5C4CEEB;
	Fri, 25 Apr 2025 11:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745579603;
	bh=ssThIJKeGvl3X5SWalgKQopEkvTDLH+DyEpRuPXOc18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YjrUYXFwR9JpqZP9S7TLq5J5fSAmOX6pwU47j7rJkbsBvFPlz76WB27iPclTJ/Be1
	 exe+6/1Xzu9OoLOLNv9j9WkSyvARyQAIFL1ef6vqahMJtK70An14Sox23mJRJzY5CE
	 yA9+VZNC8Z7rSihTcECgdVUkRjd6Wyf6icNeiSUB10Us9ih1wveKT0o90Ur/qqvR6c
	 3QBz6WljoypklaXy4f4qPaYn1VXfG4ig5FPOc3kMTn8r+zG48dUg55d6VdVX8EXCUk
	 0PH7XM4dN02Z9r0fCVmbjoiZnCs9+4gHemIRsUJCuOuFcgMwc3WhPsF0kfioDJBv6M
	 M2LEyJutNeY9Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 3/6] serial: switch uart_port::iotype to enum uart_iotype
Date: Fri, 25 Apr 2025 13:13:12 +0200
Message-ID: <20250425111315.1036184-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425111315.1036184-1-jirislaby@kernel.org>
References: <20250425111315.1036184-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inline-defined constants look weird. Instead, define a proper enum
for them and type uart_port::iotype as that enum. This allows for proper
checking in switch-case labels (somewhere, a default or UPIO_UNKNOWN
label needs to be added/handled).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_core.c  |  2 +-
 drivers/tty/serial/8250/8250_early.c |  2 ++
 drivers/tty/serial/8250/8250_port.c  |  4 ++++
 drivers/tty/serial/8250/8250_rsa.c   |  2 ++
 drivers/tty/serial/amba-pl011.c      |  2 +-
 drivers/tty/serial/fsl_lpuart.c      |  5 ++++-
 drivers/tty/serial/samsung_tty.c     |  4 ++++
 drivers/tty/serial/serial_core.c     |  8 ++++----
 include/linux/serial_core.h          | 30 +++++++++++++++-------------
 9 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 5a56f853cf6d..68994a964321 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -461,7 +461,7 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 				  char *options)
 {
 	char match[] = "uart";	/* 8250-specific earlycon name */
-	unsigned char iotype;
+	enum uart_iotype iotype;
 	resource_size_t addr;
 	int i;
 
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 842422921765..dc0371857ecb 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -77,6 +77,8 @@ static void serial8250_early_out(struct uart_port *port, int offset, int value)
 		outb(value, port->iobase + offset);
 		break;
 #endif
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8ac452cea36c..8d9bb91d4bae 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2993,6 +2993,8 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 		if (!request_region(port->iobase, size, "serial"))
 			return -EBUSY;
 		return 0;
+	case UPIO_UNKNOWN:
+		break;
 	}
 
 	return 0;
@@ -3025,6 +3027,8 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 	case UPIO_PORT:
 		release_region(port->iobase, size);
 		break;
+	case UPIO_UNKNOWN:
+		break;
 	}
 }
 
diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
index 82f2593b4c59..4c8b9671bd41 100644
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -43,6 +43,8 @@ static void rsa8250_release_resource(struct uart_8250_port *up)
 	case UPIO_PORT:
 		release_region(port->iobase + offset, size);
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 11d65097578c..421ac22555df 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2476,7 +2476,7 @@ static int pl011_console_setup(struct console *co, char *options)
 static int pl011_console_match(struct console *co, char *name, int idx,
 			       char *options)
 {
-	unsigned char iotype;
+	enum uart_iotype iotype;
 	resource_size_t addr;
 	int i;
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index fe5aed99d55a..dff6a6c57b5f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -403,6 +403,8 @@ static inline void lpuart32_write(struct uart_port *port, u32 val,
 	case UPIO_MEM32BE:
 		iowrite32be(val, port->membase + off);
 		break;
+	default:
+		break;
 	}
 }
 
@@ -563,8 +565,9 @@ static dma_addr_t lpuart_dma_datareg_addr(struct lpuart_port *sport)
 		return sport->port.mapbase + UARTDATA;
 	case UPIO_MEM32BE:
 		return sport->port.mapbase + UARTDATA + sizeof(u32) - 1;
+	default:
+		return sport->port.mapbase + UARTDR;
 	}
-	return sport->port.mapbase + UARTDR;
 }
 
 static int lpuart_dma_tx_request(struct uart_port *port)
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 210fff7164c1..73e2866febc1 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -190,6 +190,8 @@ static void wr_reg(const struct uart_port *port, u32 reg, u32 val)
 	case UPIO_MEM32:
 		writel_relaxed(val, portaddr(port, reg));
 		break;
+	default:
+		break;
 	}
 }
 
@@ -2713,6 +2715,8 @@ static void wr_reg_barrier(const struct uart_port *port, u32 reg, u32 val)
 	case UPIO_MEM32:
 		writel(val, portaddr(port, reg));
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 88669972d9a0..5bc145643385 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2178,8 +2178,8 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
  *
  * Returns: 0 on success or -%EINVAL on failure
  */
-int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
-			char **options)
+int uart_parse_earlycon(char *p, enum uart_iotype *iotype,
+			resource_size_t *addr, char **options)
 {
 	if (strncmp(p, "mmio,", 5) == 0) {
 		*iotype = UPIO_MEM;
@@ -3289,9 +3289,9 @@ bool uart_match_port(const struct uart_port *port1,
 	case UPIO_AU:
 	case UPIO_TSI:
 		return port1->mapbase == port2->mapbase;
+	default:
+		return false;
 	}
-
-	return false;
 }
 EXPORT_SYMBOL(uart_match_port);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 743b4afaad4c..914b5e97e056 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -427,6 +427,18 @@ struct uart_icount {
 typedef u64 __bitwise upf_t;
 typedef unsigned int __bitwise upstat_t;
 
+enum uart_iotype {
+	UPIO_UNKNOWN	= -1,
+	UPIO_PORT	= SERIAL_IO_PORT,	/* 8b I/O port access */
+	UPIO_HUB6	= SERIAL_IO_HUB6,	/* Hub6 ISA card */
+	UPIO_MEM	= SERIAL_IO_MEM,	/* driver-specific */
+	UPIO_MEM32	= SERIAL_IO_MEM32,	/* 32b little endian */
+	UPIO_AU		= SERIAL_IO_AU,		/* Au1x00 and RT288x type IO */
+	UPIO_TSI	= SERIAL_IO_TSI,	/* Tsi108/109 type IO */
+	UPIO_MEM32BE	= SERIAL_IO_MEM32BE,	/* 32b big endian */
+	UPIO_MEM16	= SERIAL_IO_MEM16,	/* 16b little endian */
+};
+
 struct uart_port {
 	spinlock_t		lock;			/* port lock */
 	unsigned long		iobase;			/* in/out[bwl] */
@@ -469,23 +481,13 @@ struct uart_port {
 	unsigned char		x_char;			/* xon/xoff char */
 	unsigned char		regshift;		/* reg offset shift */
 
-	unsigned char		iotype;			/* io access style */
-
-#define UPIO_UNKNOWN		((unsigned char)~0U)	/* UCHAR_MAX */
-#define UPIO_PORT		(SERIAL_IO_PORT)	/* 8b I/O port access */
-#define UPIO_HUB6		(SERIAL_IO_HUB6)	/* Hub6 ISA card */
-#define UPIO_MEM		(SERIAL_IO_MEM)		/* driver-specific */
-#define UPIO_MEM32		(SERIAL_IO_MEM32)	/* 32b little endian */
-#define UPIO_AU			(SERIAL_IO_AU)		/* Au1x00 and RT288x type IO */
-#define UPIO_TSI		(SERIAL_IO_TSI)		/* Tsi108/109 type IO */
-#define UPIO_MEM32BE		(SERIAL_IO_MEM32BE)	/* 32b big endian */
-#define UPIO_MEM16		(SERIAL_IO_MEM16)	/* 16b little endian */
-
 	unsigned char		quirks;			/* internal quirks */
 
 	/* internal quirks must be updated while holding port mutex */
 #define UPQ_NO_TXEN_TEST	BIT(0)
 
+	enum uart_iotype	iotype;			/* io access style */
+
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
 	struct uart_state	*state;			/* pointer to parent state */
@@ -1101,8 +1103,8 @@ static inline bool uart_console_registered(struct uart_port *port)
 
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
-int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
-			char **options);
+int uart_parse_earlycon(char *p, enum uart_iotype *iotype,
+			resource_size_t *addr, char **options);
 void uart_parse_options(const char *options, int *baud, int *parity, int *bits,
 			int *flow);
 int uart_set_options(struct uart_port *port, struct console *co, int baud,
-- 
2.49.0

