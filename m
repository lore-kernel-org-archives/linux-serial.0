Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560326A1AC;
	Fri, 23 Jan 2026 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189284; cv=none; b=HapdZMIbBMzy5dtfLGp7cKqHm0swNWPhFfddreplwfD/Jmcu8h9FSwNDM8+z19BpfNk6fXUh5eApZVRzp0oIuL3GB+Co5xByrJySsA+9wtevrRHOLddamzGGs1mPgEIJgboenUB5djPL3ffasi9/jPS05nx3uXeyh3+EbgP4QHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189284; c=relaxed/simple;
	bh=Iv5i8DsD51z255Wp5efjY/QB/u7emfdYZlwRjTJIGZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFkjZZN9GMatKGBBRc8EmYx1NmPw3Ob/RsV4gM58eMITrPaKRKECbYxOL6+yce2diKzrWhqJN0BRb0lAaeM1P3zzpuvO9V123ZF2vsfPzYvywmrCdHRlYhLvYPHZH1touK1+LLgURH2edGzhWwccdrNB5M5Dt2QdVjez+OmdCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kv+Y0bKW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kv+Y0bKW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769189283; x=1800725283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iv5i8DsD51z255Wp5efjY/QB/u7emfdYZlwRjTJIGZI=;
  b=kv+Y0bKWtabsEIysGUimk4S3rFJ1PcEBo6ZMS2yI4GdZ9TBdlRMhWpcZ
   m70EpApucG/r9oBKeTcS2urFGBgUTFRPdhVWCSs/71JjjGORJnnacOz94
   4VfcAuDhynf+7Exn5IyTNQAdtMtlc154/G4rNQTIiCUx5QJ0Lk9oVpfsz
   eM6lh9vnABRB0efFXuJszgPYoKp5LTbHx31JUY28rh/WvDaCg6+iLbZsJ
   xyNh2jytFjuiymwd9bcB+Vqmuxjp5DhfVXlLdO9FQnuXmdxTLHoSamG3C
   YIt/ol0SyHspoak8J7yD769hP3V8IuRhj/achN46P8hZ9oF0y9IrzNRDe
   Q==;
X-CSE-ConnectionGUID: tHblm7aFT4moe1YKGyrfmg==
X-CSE-MsgGUID: VGCG6VQmQpqdz+kMkhlbvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="88020906"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="88020906"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 09:28:02 -0800
X-CSE-ConnectionGUID: VVgv4me9QXWgnn7hPnjTxw==
X-CSE-MsgGUID: UIc27FmNRAimXXr3echXIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211580928"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.164])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 09:27:58 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>
Subject: [PATCH 1/6] serial: 8250: Protect LCR write in shutdown
Date: Fri, 23 Jan 2026 19:27:34 +0200
Message-Id: <20260123172739.13410-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 8250_dw driver needs to potentially perform very complex operations
during LCR writes because its BUSY handling prevents updates to LCR
while UART is BUSY (which is not fully under our control without those
complex operations). Thus, LCR writes should occur under port's lock.

Move LCR write under port's lock in serial8250_do_shutdown(). Also
split the LCR RMW so that the logic is on a separate line for clarity.

Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..f7a3c5555204 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2350,6 +2350,7 @@ static int serial8250_startup(struct uart_port *port)
 void serial8250_do_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	u32 lcr;
 
 	serial8250_rpm_get(up);
 	/*
@@ -2376,13 +2377,13 @@ void serial8250_do_shutdown(struct uart_port *port)
 			port->mctrl &= ~TIOCM_OUT2;
 
 		serial8250_set_mctrl(port, port->mctrl);
+
+		/* Disable break condition */
+		lcr = serial_port_in(port, UART_LCR);
+		lcr &= ~UART_LCR_SBC;
+		serial_port_out(port, UART_LCR, lcr);
 	}
 
-	/*
-	 * Disable break condition and FIFOs
-	 */
-	serial_port_out(port, UART_LCR,
-			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
 	serial8250_clear_fifos(up);
 
 	rsa_disable(up);
-- 
2.39.5

