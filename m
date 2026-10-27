Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133105;
	b=SsHq4DMGOLzk8bNMDr0JS/36gJI+oWijTU+8l3cBE0VDWZmnO4fvG0RSvCgSCRQpPhuE
	 nWEvp/zBgDr0emuEyRlyx4Qs426w7W0i9ooYt33ZZRrdMCAnB3StbWOCwfM+zDq0kty/U
	 kRcF5QRSWCdvK/wW8WQ70kjnbaTPBvXTfIu0q/SkoFBQdPM+4eC8ZtmZrA/wlVrey33HZ
	 2cDjVU6UHXljqsBC9vYIIUZEcIW7eN9/sZo18fumAKFmo10eBsdVIKmkg2vNpPUie3oCR
	 gVSlAo87tpkhxnS5dTMsXIDCn8o5UdHEaErZUeD+tJ2zMrqvG3Ultnk1kNi0XqxSnKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133105;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ItOY3Vg5BOHo/uC07nNATgEJDvbeahAuY9/6a3jg9K0=;
	b=MUvpIe56VR7seubUWSwRF3Ym2kR0wr5kgbrBWNAshq6PASu6d6yq0oumH3wecVo4TSlE
	 jSwjeBoBQMtifY5m9Dr/TjzC2Sb3Z7ZHmL41jf+FIiGTEDGPlb6QfV/UQg4WoMLYigsXG
	 yQBbZIJexxa/UGCWZwo7FxR/qpEsAUBElvKeDDZNk8P7Bukr9ofpfpHdryyorccWmI73C
	 c+UYYvnWq15trz8fcMvL6Sp2WUFgG2FDsJfyL4OcbyHNfwHtM5KDMdlGYgdmUuN1CdudT
	 w1ZD0WKR0qiqRHYuICCMbZPFHxxig41iMW7XTEON4AJmYRI1pH2VYXTQnUP1lZo/xRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=TNP6XfRW;
	arc=none smtp.remote-ip=109.224.244.116
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22E9606A31E
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 20:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B22E9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=TNP6XfRW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793133102; x=1793392302;
	bh=ItOY3Vg5BOHo/uC07nNATgEJDvbeahAuY9/6a3jg9K0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TNP6XfRW0r6Gi8+sA3NB85f8TvH3QXPO5o1Mv7fMSt+egBjOcM9z08uapPa+XPspm
	 d+GWCir7eKtVZp2n7PQNehpQafWQxYCtp+qEKooSMo1pN4KMmCk67KnfgolvceSit2
	 5oCdNk/1EQQnx0aXTbVmyODKAOd53WN9ACOcfmZKiWt/lX5sadx4RPIDsw4/oCpX/b
	 hytZQm6y2CG/WlFQ6IiaycRIZRUT7uub04RMBPbZjc7JBCF3oerDzm9c3hYAqQdArC
	 ZELVJI9sUGtm+AeLHodL1UkoqONE/9/DtbwH5YjLNTYGE1ysDwv6X9SyVmL7C9yYRx
	 H6QvjUAesgakQ==
Date: Tue, 27 Oct 2026 20:31:38 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: qcom-geni: Set the serial engine up again after hibernation
Message-ID: <20261027203136.95971-1-birk.skyum@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 514362eb52f479d693c59884f7ec81f7766e91c6
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
sets the engine up again. The other system sleep callbacks are
unchanged.

Signed-off-by: Birk Skyum <birk.skyum@pm.me>
---
Tested on a Lenovo Yoga Slim 7x (X1E80100) with 7.3 and the other
hibernation fixes for this laptop, which are in review:

  pinctrl: qcom: Restore the pin configuration after hibernation (v4)
  https://lore.kernel.org/all/20261021210425.57066-1-birk.skyum@pm.me/
  PCI: qcom: Power the controller down when hibernating (v2), on top of
  the v6 series "PCI: qcom: Implement shutdown() to avoid SMMU/NoC
  errors on reboot"
  https://lore.kernel.org/all/179181074907.22199.10556821368232442334@pm.me=
/
  soc: qcom: smp2p: Start over after a restore from hibernation
  https://lore.kernel.org/all/179158127177.70185.5691100900886332545@pm.me/
  Bluetooth: hci_qca: Reset the in-band sleep state on power off (v2)
  https://lore.kernel.org/all/20261014180201.57109-1-birk.skyum@pm.me/

The test kernel had a switch for this change, so both ways ran on the
same build, each a real hibernation with a power-off from a fresh boot:

  without   restored after 112 s, Bluetooth never comes back
  with      restored after 89 s, hci_qca's recovery sets the controller
            up about 18 s after the restore and a scan finds devices

pm_test=3Dcore and test_resume pass with it as well; there the port is
restored without a power cycle and is simply set up a second time.

7.3 does not have the console pm_runtime_resume() that tty-next adds to
the resume callback. The port here is not a console and this laptop has
no serial console, so console ports were not exercised. For those, the
kernel that loads the image sets the engine up itself when it
registers the console, so clearing port->setup only repeats that at the
next startup.

Built with W=3D1 and sparse on tty-next with hibernation on, with
hibernation off, and without system sleep.

 drivers/tty/serial/qcom_geni_serial.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qco=
m_geni_serial.c
index bfdc155c1..4e5b0e247 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -2131,6 +2131,20 @@ static int qcom_geni_serial_resume(struct device *de=
v)
 =09return ret;
 }
=20
+/*
+ * A hibernation image is restored after a power cycle, which reset the se=
rial
+ * engine. The kernel that loaded the image only set up the engines it use=
d
+ * itself, so set this one up again when the port starts.
+ */
+static int qcom_geni_serial_restore(struct device *dev)
+{
+=09struct qcom_geni_serial_port *port =3D dev_get_drvdata(dev);
+
+=09port->setup =3D false;
+
+=09return qcom_geni_serial_resume(dev);
+}
+
 #if IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE)
 static const struct qcom_geni_device_data qcom_geni_console_data =3D {
 =09.console =3D true,
@@ -2168,7 +2182,12 @@ static const struct qcom_geni_device_data sa8255p_qc=
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


