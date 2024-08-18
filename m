Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FF347F69
	for <linux-serial@vger.kernel.org>; Sun, 18 Aug 2024 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724003404; cv=none; b=QjRgPPSoSNV6IB63CsJMGNx+ny+l/kTxlkwLY/0iWDJsTn84l0y4LiNb4o97+6WHrKlP2d15YQaWhu5p3l8mKQyaiJotNrXu2lZ2KAMU0oPTHp9eyvmVpd4fgorHo9JvJ+QLi+JS23wYg2Nqp2E4ohkIyaWXDK4ozWmTB7UmGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724003404; c=relaxed/simple;
	bh=CFLjSCt9NBnjIL42NUzBbYDEI5Xi6BFgVX1ej9/c9SY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gcd36JnkiRslAHEQ+kEjY4slq2zPNiAt+K/GBMdJbjZxWorK03p2bOWBTMDXYOQdUpF+SOoYqyV7SAayh3NdgNKddyYcJ95u9hVACLn6hHulT8SvBq0bJ6d04tV25mP/kQapCmnIZ/oc0/Cq2401EpBQKStI8cJwbB5kZErh9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=knbh2wsy; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="knbh2wsy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724003385; x=1724608185; i=wahrenst@gmx.net;
	bh=DiA/aFsI+FjQmh1iA//vKZvUfmad+7NHlR0IbRzXHPk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=knbh2wsy4Io4LCm7M+Q/Ig02ViptwVDXHYMdI6BXfRrDXW3hjNQifyHvdsITackJ
	 hERvNy1sf0hbFuiNaIVhKCRVtNiS2w+EzUCvQdXQ9cKuCveLwlllD8htWxazjloEF
	 paWEr5K41ES9Pkj+7B6HkuGRpF5g49xEFSuQIhtfxsYmD14odV5eGVkcA4O0LM7vu
	 1an7VRxQGlS1fds3CO7M2e25HTMqbkBHXNSzJ17IaJ/zlFOqf5h+8m2IoNGCY/r4w
	 UwpsmvglW6moE0eocTBFUvNRL56Qn0yG8pRxdm/OlLr+C8dy6FRH7j5xuGP5NNweT
	 k9W1o4eWAUT1jtOrnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzuH-1s9iKs1Ynn-00fciO; Sun, 18
 Aug 2024 19:49:45 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] serial: 8250_bcm2835aux: Fix clock imbalance in PM resume
Date: Sun, 18 Aug 2024 19:49:36 +0200
Message-Id: <20240818174936.88372-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r9hNUuSdz7hN68T+5KzHyprrl4GZvilH7Zejm0cvXgVtQdCiMR3
 r3bNsjJYZ9SXLTOdcgueSjRzBuFRpfk70PDDuA1kseQw4PL/35tz4QPiFw2JnGpznUEtLru
 mtr63iGmXySQUGS88yNHH3sTPErZxge1cfQKffkMx8FO35MpITyP35RQRRU9QKHpY0pS1BC
 fuJ69aIjTPB8nBo1hKaFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VaVAzzAIn7s=;1747lE/usUknmlBEGe6vElMyhvf
 0f8lgPqUPMuuaY8TLgfm4goiIDGrdx+Q+9QCn/SqopJFtyXT65cBtASof5a6B0BZRZV4jEtme
 tKOZYU2gz111aJyFAzW7bOral9zB+uVNzuFNajsKpq0XOiJT2mn7m1t0E8a3o7qbT759/cUDf
 UiK0v7V+8vrgTpbI+54JznCo3I+XFCYXoQlLim0tGlsNNHt2HDFukYDfiHfCztt07sQuKTb+s
 xwDWkTP29pUKVpVkTH5VUAofbNly6QOBwEdjDEcwjrU7k4erUTLCx5hD2Xf1Kj7BSK99xvfw/
 xYrQWMfPkuq3OW3X6E0SHz6YVWK5TSYye2rjwteqaQjh6srMrr5VltPDQdioy2QwissbFOVKw
 eVJk03uJodGy5Oh9K1lUqcpg2aVsdYFpAN+5R5r+X42P3aHwc1v0+q9s+ts19j/CAb3gA+8NV
 Q/+W0g0p7f6f3zCtLsk6orD+jwWGhVROUTmeu+YAnc7sTDxF1+h0UD3RFdqkwFNL+dQ6ACaGW
 NI0KwN0+K3bb086WmUxIvLMdb0wYcTUJvqttwVYMp8LWQ6ym1315Oxco2Be3vPwawxFsNdhp5
 pASegorSE23flpn/gJRhdkFGFWHVBkKHwJYWzJG90ICQMqpKrRsOzmQRxyYgI1q8Gb4YbAZT+
 RCdfNwptKmbkYP4ZPQ1CgAL5OPQWdGiYlIFxKhLHDnRty4hzAm00JEg/X+y3dSlnzl5iRQ7Zc
 6sq65Y7tKsy7GK+yf7bko5AtvMPyM8a8W06mxNpX9cXpGwcX/SP9sFPlSjhN/5ReZ3Qwn7S8K
 XiPkYypPzTXzukpkCgs/775A==

During review Ulf Hansson discovered a clock imbalance in the recently
introduced PM resume code. The driver should enable the clock only in
case it has been disabled in suspend before. In order to make the
conditions easier to read, refactor this into a separate function.

Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Closes: https://lore.kernel.org/linux-arm-kernel/CAPDyKFoJh3j8xSeXZ9o031YZ=
LTCDYVA+dgvURuwozjDpU_aauA@mail.gmail.com/
Fixes: 0e1d8780526f ("serial: 8250_bcm2835aux: add PM suspend/resume suppo=
rt")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/tty/serial/8250/8250_bcm2835aux.c | 26 +++++++++++++++++------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/seria=
l/8250/8250_bcm2835aux.c
index 36e2bb34d82b..e6b42ca6151e 100644
=2D-- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -214,17 +214,27 @@ static const struct acpi_device_id bcm2835aux_serial=
_acpi_match[] =3D {
 };
 MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_match);

-static int bcm2835aux_suspend(struct device *dev)
+static bool bcm2835aux_can_disable_clock(struct device *dev)
 {
 	struct bcm2835aux_data *data =3D dev_get_drvdata(dev);
 	struct uart_8250_port *up =3D serial8250_get_port(data->line);

-	serial8250_suspend_port(data->line);
-
 	if (device_may_wakeup(dev))
-		return 0;
+		return false;

 	if (uart_console(&up->port) && !console_suspend_enabled)
+		return false;
+
+	return true;
+}
+
+static int bcm2835aux_suspend(struct device *dev)
+{
+	struct bcm2835aux_data *data =3D dev_get_drvdata(dev);
+
+	serial8250_suspend_port(data->line);
+
+	if (!bcm2835aux_can_disable_clock(dev))
 		return 0;

 	clk_disable_unprepare(data->clk);
@@ -236,9 +246,11 @@ static int bcm2835aux_resume(struct device *dev)
 	struct bcm2835aux_data *data =3D dev_get_drvdata(dev);
 	int ret;

-	ret =3D clk_prepare_enable(data->clk);
-	if (ret)
-		return ret;
+	if (bcm2835aux_can_disable_clock(dev)) {
+		ret =3D clk_prepare_enable(data->clk);
+		if (ret)
+			return ret;
+	}

 	serial8250_resume_port(data->line);

=2D-
2.34.1

