Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099213;
	b=5ktPKkoA4rO/qbrtEsOtcEi9diJ7nVxcCiRysGBhZHx0ss2J+9CdPxAFOjj8vlHetygj
	 fXmYtRNEvYt96/2Z81JwftDR1hrtQrU/6qFOn5uLFQaDGa2xlNqAje9EgnuG2qbCat+HC
	 nxd/mjdjkpqZQEfk+7dZ8QGM/+SgXp2QZ5gWJNoK5ZR1bcfvEgwX7Fe3sQaDJQXwpCzxd
	 6kecS9Xxt3DASQkZiPtXNbEFd2g2VkgcNQCtg46ryfsKUScYgyUwN20Wx7aKss0pgo+bv
	 DqkKXoj0JZB9y4qk0lf3SEo91vSO6m3/sIf0DGt+I6EUuewzkrART4AEFShYacme3hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099213;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7vSKGraoDM2QV0JPe83DnNyE1Tt9SqdSFkplucLdPI8=;
	b=kPbWOVfF2s29ybh09/tyArtfj3iBjoO1BGgSCLtATrTWqs/HbrbJasxUpUbJBRjiNPFu
	 oEAlNzZjcl7MkQ+a+GdkGm1c5HNNTKwkS6bLAV+2Iag/MN18UZ6NMMw+WfLTI9kyvpreY
	 t/TUntAW2zK/115/eTXd2niwuYG84Gp5IaVHT7+877RPdyKHrBLcxjBcqfS3bFE9kSqim
	 M6LROWWQ7yF3tKaD9OveDt0XjvmOr3ivEYOZfLv+P/QVii/3sfDb1yAUKv7omY1KX56LX
	 7lORFXg6WaYTH5pYhhbO3Phqc3swK994Rb/Quyj9uKQnBwUfF7Omo0EYhFfM4X6dnZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xHFzn6eh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED8606A325;
	Tue, 27 Oct 2026 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xHFzn6eh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A5B1F01828;
	Tue, 27 Oct 2026 11:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099213;
	bh=7vSKGraoDM2QV0JPe83DnNyE1Tt9SqdSFkplucLdPI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=xHFzn6ehZOml2dVavmbMTSq/Q/Y4L1kSSMOD1LdcpGr+7nK3dDkAIMRyenaGBdBVO
	 a8mMH7xCNxMfK8VXD0C8zYLUHM1TsVfG+CvPkSy16PV4etDd6Gh89NY9s+AQZbcFrt
	 NbT4SWJv+f8RLWLoNEBerO5oD0tORD6YEiFRUUac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:30 +0100
Subject: [PATCH 04/24] serial: 8250: don't report a wakeup to a closed tty
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-tty-llm-v1-4-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
In-Reply-To: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc: Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Peter Hurley <peter@hurleysoftware.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Olof Johansson <olof@lixom.net>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Robert Baldyga <r.baldyga@samsung.com>, 
 Thomas Abraham <thomas.abraham@linaro.org>, 
 Kukjin Kim <kgene.kim@samsung.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
 Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=T32sy9olc55qU8t6c7E4l3KE2wqdvMjDebtTtCJxGpw=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWve21YdGXy1qOZ0zNfGadv133VWmk/be/pu53Pdhf
 tOalH1NHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRg00McwWkha8ceZP0KFzq
 1Oz21Jq7ZatYFjLM0zpwPzL/0S3mf9oZbyOsnxlsvhJzHAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

If its interrupt is a wakeup source, serial8250_handle_irq_locked()
reports the characters which arrive as a wakeup event of
tport->tty->dev.  That pointer is only set while the port is open.  The
port of a console is not shut down by the last close, so its interrupt
handler goes on running without a tty.  If the system is then woken up
by a character on the console, the handler dereferences a NULL pointer.

Take a reference to the tty, and leave the event out if there is none.

Fixes: 0ba9e3a13c6a ("serial: 8250: Add missing wakeup event reporting")
Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_port.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3d47f535d6f1..4afebd96e062 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1900,8 +1900,15 @@ void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 		struct irq_data *d;
 
 		d = irq_get_irq_data(port->irq);
-		if (d && irqd_is_wakeup_set(d))
-			pm_wakeup_event(tport->tty->dev, 0);
+		if (d && irqd_is_wakeup_set(d)) {
+			struct tty_struct *tty = tty_port_tty_get(tport);
+
+			/* A console goes on receiving after the last close */
+			if (tty) {
+				pm_wakeup_event(tty->dev, 0);
+				tty_kref_put(tty);
+			}
+		}
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}

-- 
2.56.0

