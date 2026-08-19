Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5748A2A9;
	Wed, 19 Aug 2026 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158017; cv=none; b=XkxNnLkXGa22Bq+OR0SAlkulTXlQQP3QbxIVvj83MVq3jvWTLywJyOk5JRIWOHlum9yAY0W/qr/LcYAOVVqyiSM1JRsbRNIvnYUngZl1yFhhoaIjnBu6D9myTRuNf1qxhdMii9olQ/l9hx37hMSL6mFncNP5Q0Xdwy7jgDpxebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158017; c=relaxed/simple;
	bh=t4WY1SZyOjTB00Qv3JqSZhT4hew4iMx4qlIkKMqCixg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i2r7qnNa/8msf1GA3KPt5OHVKKi0XYn8FW9dq5cDrMRoYoJyRh68FBuam5sUJpcCPAtsIXAIavKS+4NcHoJrSHehA4B4KpBy1zVbt68L0zutYpWj71Fjh3IhHxzTqURxlJ28O2jrgRIWZTDC87hjZs2Reo6KHuxdb2kawTAdnEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3s6Y90T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3s6Y90T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD2C1F000E9;
	Wed, 19 Aug 2026 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787158016;
	bh=gDwETqbehTA+WSxsmLNqku3KFpowN3JsHqzKFU+pEy0=;
	h=From:Date:Subject:To:Cc;
	b=Q3s6Y90ThXWXCDzJdGlQyDIFtju+A/MHb+Xgs1OX8e4ZYCmdlfBPVFoQPjjUZL538
	 0uMo/4Re0Z0Eeq0ZFe7SwGRkG39gg4GOu/xtp1l81IJDydVnkT9s+uKxn1SCNgABQl
	 5gANFOZxeWwNDnwS1YtODR/KC3PhboelKCJWn9wBVLduz1b6lnWlcmtT19QTaVRXTy
	 Ak/74EEyNWnOjlKVXcbNG0AaW7Yv7TovUiauHxxFVncJb0cNDCmSm6H9mF4M6bBFPl
	 KW9zeKFfFhbABxB70XdbFkmxp+2SIqwUkpcyzaYQMKgTcB6axFTR/3aVoZH3pQesYh
	 f82h0mZO2Yy7Q==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 19 Aug 2026 18:46:47 +0200
Subject: [PATCH] serial: qcom-geni: keep registered console runtime active
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-topic-geni_console_poweredoff-v1-1-7f7bb3aad8da@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQrCMBAG0KuUWRtI4l/0KiLFpl/qiGRCUluh9
 O5GXb7NW6ggMwqdm4UyJi4sscJsGvL3WxyguK8mq+1BO3NSoyT2akDk1kss8kSbZEZGLyGocNx
 2O2f2zmpQPVJG4Pfvv1z/Lq/uAT9+U1rXDw6VAeyBAAAA
X-Change-ID: 20260819-topic-geni_console_poweredoff-f73b4815820e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787158014; l=2948;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=vTBGxYlsnzN7flm5ABJf0KVHH4ytKurSM1HT+V9rNIE=;
 b=JkN/sjSz+tAJP+wK9ebIZQbHL7BDRVcfn6vRQ7MkJe43kWzynY5g858yE4o80ZY/EBXoBk/JM
 6NH5l/QxMziAKjh7VF1H9Q+Blesoe6SUYJ80ays1+mpUYjJxW0xW98q
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Commit aee1f94dab13 ("serial: qcom-geni: remove .pm callback, use
runtime PM in startup/shutdown") moved runtime PM references from the
serial-core PM callback to the port startup and shutdown callbacks.

The serial core used to leave the console port powered after
registration, but after the callback was removed the temporary probe
reference is always released. Console writes are not tied to an open TTY
and can run from contexts which cannot resume the device, so a
runtime-suspended console can stall. This was observed on a Qualcomm
X1E80100 CRD device, as the boot console became flakey across boots.

Acquire a runtime PM reference when the console is set up and release it
through the console exit callback. This keeps the device active only
while the console is registered and balances the reference when the
console is disabled or re-enabled through sysfs.

Fixes: aee1f94dab13 ("serial: qcom-geni: remove .pm callback, use runtime PM in startup/shutdown")
Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..92858bcdebc7 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1625,16 +1625,37 @@ static int qcom_geni_console_setup(struct console *co, char *options)
 	if (unlikely(!uport->membase))
 		return -ENXIO;
 
+	ret = pm_runtime_resume_and_get(uport->dev);
+	if (ret < 0)
+		return ret;
+
 	if (!port->setup) {
 		ret = qcom_geni_serial_port_setup(uport);
-		if (ret)
+		if (ret) {
+			pm_runtime_put_sync(uport->dev);
 			return ret;
+		}
 	}
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
-	return uart_set_options(uport, co, baud, parity, bits, flow);
+	ret = uart_set_options(uport, co, baud, parity, bits, flow);
+	if (ret)
+		pm_runtime_put_sync(uport->dev);
+
+	return ret;
+}
+
+static int qcom_geni_console_exit(struct console *co)
+{
+	struct qcom_geni_serial_port *port;
+
+	port = get_port_from_line(co->index, true, NULL);
+	if (IS_ERR(port))
+		return PTR_ERR(port);
+
+	return pm_runtime_put_sync(port->uport.dev);
 }
 
 static void qcom_geni_serial_earlycon_write(struct console *con,
@@ -1751,6 +1772,7 @@ static struct console cons_ops = {
 	.device_unlock = qcom_geni_serial_console_device_unlock,
 	.device = uart_console_device,
 	.setup = qcom_geni_console_setup,
+	.exit = qcom_geni_console_exit,
 	.flags = CON_PRINTBUFFER | CON_NBCON,
 	.index = -1,
 	.data = &qcom_geni_console_driver,

---
base-commit: 6a746cd265aed59107ebdaa9ce039bb832922969
change-id: 20260819-topic-geni_console_poweredoff-f73b4815820e

Best regards,
--  
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

