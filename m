Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141290;
	b=tP3+kDYNGSiS4Zn0UiNew5g4wkNd1VMNdi8MmFrlzA4c7dZvqeBQB83bK8mQLFJWbmjD
	 LwChCj0+sZL8Mg4lRBirCa4bcZxeOtP/yYsMHjDeU1ALl5INU9/sRz6XdCTxa7rFLMW6k
	 WspVsbXpAeLhoA9elLco/YVKBP9MrOZW+p4w28l4L46UGhagsu65wFZW6GNTzf1lHj+CJ
	 6vxVOsf/8qVMf0CFK9/K1wOHv6MN0xfe/5pj7L7M1UXcdb4GwtRJbRkcW3BfcQk2gwv9/
	 lmn5YjvPcjS63R4IWj7XEW7A/Lr5Jha1yARJ4q4dk21NyYmCXSNqTKTV5gRySoRd8gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141290;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PpKy7i455kq8X8Z/yAP0URWjwihBWOIlXzAYuU2cxns=;
	b=d0BktHC/ovCf1Ra4Z/YRWyS3e7dVw5PvzjjxKCbcsY6wu6Z6bWehYfjZmu4NuQEFAnKU
	 J+CORXN7QG5e+U5j/lqbTxMIh6Q2jpWDMWNC8B+MteenDqXDCviSdA686DgWTbgkxMgBK
	 +heNnuqsaUe03PKnW/9EsBdrfr813vEMpbs7UaVg9rQY/cpGea+0esECCuqwOXJpM6HhQ
	 mjmEEXiLQ3ZxGF2rj1G5ro1eV743Uzt0ZSkAnt4MxEHn2u8MP6g+nrC3VbR1HH0P2Q8jd
	 wyMNw/ZEO8CgROpEVpNbeU3lZV0Bq2saizrcc2Zqlgze1XCNepXPoGLk4E8kXu8IMWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=htplDUYZ;
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37C606A31F
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 22:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B37C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=htplDUYZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793141285; x=1793400485;
	bh=PpKy7i455kq8X8Z/yAP0URWjwihBWOIlXzAYuU2cxns=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=htplDUYZLXP+d/4jSZHlOaWJpD1RWTNmAAdO6hrUO2GDeFKhmvABLVblM7gdTHt2F
	 9Amfdm0bnZJMnyUFjHoT7fv3c0RqubEjNXviqBG1cFmDVF7FNJkZJBQ/SwRFl3Edag
	 h73jwzqSqDckXOz/ogg8jial0CZYTFqQLWb6J6fNMP31xMu/vpEOtQFenRmw+hsQgN
	 3QeuSq/Jk9N89qCxv7bv5SGSZth0qspO6bjs06tVbyeQOZAiCHHD1xr0GuAEYv/rvP
	 lWah+mBiky6fZqG2kz9XnQ1vXN9vxXcI9Q2EOCWz4rfH/i0K78oluOOknmwVxgDZZA
	 FT05CPUcPLH4Q==
Date: Tue, 27 Oct 2026 22:48:02 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] serial: qcom-geni: Set the serial engine up again after hibernation
Message-ID: <20261027224800.86418-1-birk.skyum@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: b7fb55564b6cb7b44c2b5d7bc9115818957fc008
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A hibernation image is restored after a power cycle, which resets every
serial engine. The kernel that loads the image only sets up the engines
it uses itself, and on laptops the Bluetooth UART is opened from the
root file system, so that kernel never touches it.

The restored kernel still has port->setup set from before, so the
startup in uart_resume_port() skips qcom_geni_serial_port_setup() and
the port runs on an engine whose FIFOs, packing and transfer mode were
never configured. On a Lenovo Yoga Slim 7x (X1E80100) the WCN7850's
Bluetooth controller then never comes back: every setup attempt of
hci_qca's error recovery ends in "command 0xfc00 tx timeout" and
"Reading QCA version information failed (-110)".

Clear port->setup in a restore callback of its own, so the next startup
sets the engine up again. Leave console ports alone: the kernel that
loads the image sets up its console when it registers it, and setting
the engine up again in qcom_geni_serial_startup() would run without the
port lock while the console may be writing. The other system sleep
callbacks are unchanged.

Signed-off-by: Birk Skyum <birk.skyum@pm.me>
---
Changes in v2:
- Leave console ports alone. Clearing port->setup on one made the next
  startup run qcom_geni_serial_port_setup() without the port lock,
  which can race with console output (Sashiko).
- v1: https://lore.kernel.org/all/20261027203136.95971-1-birk.skyum@pm.me/

The change from v1 only affects console ports, which this laptop does
not have, so the v1 test still applies. It ran on 7.3 with the other
hibernation fixes for this laptop that are in review (pinctrl, PCI,
smp2p and hci_qca, linked in v1), on one build with a switch for this
change, each a real hibernation with a power-off from a fresh boot:

  without   restored after 112 s, Bluetooth never comes back
  with      restored after 89 s, hci_qca's recovery sets the controller
            up about 18 s after the restore and a scan finds devices

A console that the kernel loading the image did not set up stays as
broken as it is without this patch. Setting one up under the port lock
before uart_resume_port() would be a separate change, and this laptop
has no serial console to test it on.

Built with W=3D1 and sparse on tty-next with hibernation on, with
hibernation off, and without system sleep.

 drivers/tty/serial/qcom_geni_serial.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qco=
m_geni_serial.c
index bfdc155c1..5a3bf51a3 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -2131,6 +2131,22 @@ static int qcom_geni_serial_resume(struct device *de=
v)
 =09return ret;
 }
=20
+/*
+ * A hibernation image is restored after a power cycle, which reset the se=
rial
+ * engine. The kernel that loaded the image only set up the engines it use=
d
+ * itself, so set this one up again when the port starts. A console is lef=
t as
+ * it is, since setting it up at startup would race with console output.
+ */
+static int qcom_geni_serial_restore(struct device *dev)
+{
+=09struct qcom_geni_serial_port *port =3D dev_get_drvdata(dev);
+
+=09if (!uart_console(&port->uport))
+=09=09port->setup =3D false;
+
+=09return qcom_geni_serial_resume(dev);
+}
+
 #if IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE)
 static const struct qcom_geni_device_data qcom_geni_console_data =3D {
 =09.console =3D true,
@@ -2168,7 +2184,12 @@ static const struct qcom_geni_device_data sa8255p_qc=
om_geni_uart_data =3D {
 static const struct dev_pm_ops qcom_geni_serial_pm_ops =3D {
 =09SET_RUNTIME_PM_OPS(qcom_geni_serial_runtime_suspend,
 =09=09=09   qcom_geni_serial_runtime_resume, NULL)
-=09SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_suspend, qcom_geni_serial_resume)
+=09.suspend =3D pm_sleep_ptr(qcom_geni_serial_suspend),
+=09.resume =3D pm_sleep_ptr(qcom_geni_serial_resume),
+=09.freeze =3D pm_sleep_ptr(qcom_geni_serial_suspend),
+=09.thaw =3D pm_sleep_ptr(qcom_geni_serial_resume),
+=09.poweroff =3D pm_sleep_ptr(qcom_geni_serial_suspend),
+=09.restore =3D pm_sleep_ptr(qcom_geni_serial_restore),
 };
=20
 static void qcom_geni_serial_sys_shutdown(struct platform_device *pdev)
--=20
2.56.0


