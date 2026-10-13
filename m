Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507313F484C
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874138; cv=none; b=FRzPPTQUG1Ry99h/UjwrgEiCKepKzwYpZhJpu5nJO0TTTCAVQ0jYFVtUxX2u5yjzF4o9s4/DjizUrLxeCSYUN1epWVRojZ36AwUkyfL5oKGg7/9/yf7bFVFrX1+Y9c0qldJbVtj1U8C/E3WaVAZZ9nHl2JcDGyJFWH2IQQ8XIgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874138; c=relaxed/simple;
	bh=KNK//ueGDBXfkCt4zDrTvv3nSS/qkRzFgWsYrHt9fKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVyJdKrV41jSSqm17ZCeHQBN6Sa25bJylQBusK65LxJFI/JbOg2SQhm8rAxLC2+h7wwW46FJ56FQfg/B/CLWEXt2IHEbXENDAEgbudPKONRrky+ydfKauxobBwBS4BebnNzNcCJQC5gcVnFFEG1XXLFGUrlWQAbKEh0dAoSNshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqKk0jNU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqKk0jNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ECB1F000FF;
	Tue, 13 Oct 2026 06:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874137;
	bh=OKhG8/011Fw+PAndLHXnYW8X/FS5Y8v7JHeZSmny5HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eqKk0jNUamlYeHWBCg/+QTB9sRVaqSIjT7+EnHYZM/J0sreHLhECE+kjzzAiWyp4O
	 HbHvyL/t8fWULHni/HCDK9nWRB81luLKvyBrzcQcfliMimDOkbpbxCZ6dkR3iIjeHJ
	 /xtwd6I8W7XTMY1rTMMnbF4CkrwLf/UdL1sxa3NeZSGonTycE2fSOFLk0gime1rTIo
	 a4o4dILqTS7JwOjrtmOokCRtc6Rp0ETYB7FCjwUzibbMIN8rq02sCW1yb3YYezN3IY
	 Xi89NV32fE3LA3d3nAyvP1I2lsYz2eNLT1uzRzjlxy6VEjTmjSKQV+/YbZ9lI/zh5C
	 IYCJaIMHDoglw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 2/6] serial: 8250_exar: remove useless void * casts
Date: Tue, 13 Oct 2026 08:48:47 +0200
Message-ID: <c9c3f096b01befa764c3ba75457a76a0afa5800d.1791873876.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791873876.git.jirislaby@kernel.org>
References: <cover.1791873876.git.jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

port->private_data is a void pointer. There is no need to cast it when
assigning to or from struct exar8250 pointers. So drop the casts.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Assisted-by: LLM
---
 drivers/tty/serial/8250/8250_exar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 836792e861bf..ad2e5841fbf6 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -799,7 +799,7 @@ static int cti_rs485_config_mpio_tristate(struct uart_port *port,
 					struct ktermios *termios,
 					struct serial_rs485 *rs485)
 {
-	struct exar8250 *priv = (struct exar8250 *)port->private_data;
+	struct exar8250 *priv = port->private_data;
 	int ret;
 
 	ret = generic_rs485_config(port, termios, rs485);
@@ -837,7 +837,7 @@ static int cti_port_setup_common(struct exar8250 *priv,
 	if (ret)
 		return ret;
 
-	port->port.private_data = (void *)priv;
+	port->port.private_data = priv;
 	port->port.pm = exar_pm;
 	port->port.shutdown = exar_shutdown;
 
-- 
2.56.0

