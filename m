Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF61885BD;
	Tue, 29 Oct 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215691; cv=none; b=gDwuRwzca8mnOf3ez+fPK9vAlabDKnfr0b/rnbSp0Xhlv2Kexl/ouqROkcS+bGlp/b0PnBTdxKievAXxsFJHUts00SPIuJspGSOcsEg1wXjw6Hf4ZxpIkIog1ujfy2NXeHPX0etxFEo9XDVLCw8Xdph/TXEsoVxVU7cAic+e/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215691; c=relaxed/simple;
	bh=rAllKP1SjdLLcPDMzxMMcUjKjeINhv0CZda7SsQoPaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CRehV/TvGoxNToueIgrREzmtJzH/b0rUQ5fkqSDFQn2tPwXVHw/Fp2WrxvVQRil5vXCQSk6MXT7CywMUylPJjehGmDEYSUCpfidP+b8nsLJ7iLAz9+grV5Ayt+9ssm6o+lp47oexn9/Y1xtXdMkehFfvbnHqR90E0HD6vQOxdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0d2F8fk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0d2F8fk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFBAC4CECD;
	Tue, 29 Oct 2024 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730215691;
	bh=rAllKP1SjdLLcPDMzxMMcUjKjeINhv0CZda7SsQoPaM=;
	h=From:To:Cc:Subject:Date:From;
	b=V0d2F8fkBsAWpRG80wbVdDeOZwUNLCUfe5qv6w26Auzr9rrfg5hYjVIfXm7kUhVu7
	 4jgAJvAMSZqMjjFWy3Y4WQ/9Hm7PhD+6M9S3jzkqw6i4rn5JN2zDcjgh3jfddOx4u5
	 AllgcCVCbvkZ8isGfyoldYlM1keJctkoURixSfKaYMnaxWRYNCx1auHWizxGQkr0Fi
	 t+QaChy6MIT3HHk9EZyl8zyDIXnTHWu0Fs4lVtwHcfEgC4BLmTeqOJYtpBtPtL4Yx0
	 UuAil2ncyVeS2WWUcweg8J48EXsm1qU0z0+zL1Bi6692UwO+bKHLmJTA3rZwkQUmos
	 SF9nvWOs9NDlg==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: export serial_8250_warn_need_ioport
Date: Tue, 29 Oct 2024 15:27:34 +0000
Message-Id: <20241029152804.3318094-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added function is used from a loadable module, so it has
to be exported the same way as the other function in this file:

ERROR: modpost: "serial_8250_warn_need_ioport" [drivers/tty/serial/8250/8250_pci.ko] undefined!

Fixes: 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The build regression is currently part of my asm-generic tree, so I've
applied this fixup on top.

 drivers/tty/serial/8250/8250_pcilib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
index ec4d04177802..3bdccf76f71d 100644
--- a/drivers/tty/serial/8250/8250_pcilib.c
+++ b/drivers/tty/serial/8250/8250_pcilib.c
@@ -19,6 +19,7 @@ int serial_8250_warn_need_ioport(struct pci_dev *dev)
 
 	return -ENXIO;
 }
+EXPORT_SYMBOL_NS_GPL(serial_8250_warn_need_ioport, SERIAL_8250_PCI);
 
 int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
 		   u8 bar, unsigned int offset, int regshift)
-- 
2.39.5

