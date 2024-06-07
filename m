Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D218D1C6A1;
	Fri,  7 Jun 2024 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717801842; cv=none; b=PH66id+JxdFzZRKOrbzBFkAgtr7bvsaWJyJgOSq4iD4gy2k3bYbIRPd3p06Et/p25wTCN/yJznlwkmKYTJnfm0rj7aAal087ZlU0FvXBxpcsI2czkxpqSBEZKsh2lug7EPgaqiTD2RxY9tI3z1ot6imUQvpPqyQdYvaSLSWfz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717801842; c=relaxed/simple;
	bh=KcRUThBuR5QNs+vXJjr2HlSRy23gPY2N/ly3/vJIUAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=YcnLqdj+IWwrrO88/R2g/jZy30QGPCyHv/h6TpGgwa/x82DZ1sddTMl1iwEZDcsYwCBwXkMd8azSxr24L1T8Zadcs5jtpSr+qxE76vdDcSqFmon9O2uM+Mgws2ZWn2wAXsOiR6rTh8KVdIwyfcQpIJxc3tuSgEnTCmiVCgFKQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GV5rTm4W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GV5rTm4W"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457HZpg4010206;
	Fri, 7 Jun 2024 23:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1BOu5b63kmJJ0cXnevJLGT
	smnqAF6DrUJxjUPNnnbA0=; b=GV5rTm4WsLqEYPDfgNbkFII8woOcRMHKbI4FeO
	fw5K6zq6IUMhspTg5XBa4Dcu3XbqEhYkXcNebBvhSp8YYWMyICD0cXxQ9wQomEKF
	aVyMPtADjKAQoK6o9lvdDUqIPTVYXDUBaEEIQdNOZU6bKAcKaTYbe7FxMy4ggRse
	lrDuRqYTK+NZScF5j0T+uW00cSGMTHha3uW+ndZOVqnOoUm0sscd1sTjjPsSpL1z
	MAs4NMF9BR6EMFgCQYtXyPssLI8zS1EylLu1nUqKRyrDM9xClxBymY0g13ApF1ze
	fo1+Z34GqIYzkClrhVhKyBwcSo4N1/soCkEqGK70F2aumeLw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjk89fvea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 23:10:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457NANVU011407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 23:10:23 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 16:10:22 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 7 Jun 2024 16:10:20 -0700
Subject: [PATCH] tty: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-md-drivers-tty-v1-1-50a7efb8bed8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFuTY2YC/x3MTQ6CQAxA4auQrm1SRvyJVzEsClOkiYymHQmEc
 HdHl9/ivQ1cTMXhVm1gMqvrKxXUhwr6kdNDUGMxBAoNnemCU8RoOos55ryi1Ec+XUMciAKU6G0
 y6PIf3tvijl2wM079+Ns8NX0WnNizGOz7F5qLGoZ/AAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-parisc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-actions@lists.infradead.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fU1wOBfN5rbKVGkvaH0Z_XRRxLPs3Qme
X-Proofpoint-ORIG-GUID: fU1wOBfN5rbKVGkvaH0Z_XRRxLPs3Qme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_15,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406070171

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/serial/8250/8250_base.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/serial/8250/8250_pxa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/serial/8250/serial_cs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/serial/esp32_uart.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/serial/esp32_acm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/serial/owl-uart.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/n_hdlc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/n_gsm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/ttynull.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/goldfish.o

Add all missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/tty/amiserial.c                | 1 +
 drivers/tty/goldfish.c                 | 1 +
 drivers/tty/n_gsm.c                    | 1 +
 drivers/tty/n_hdlc.c                   | 1 +
 drivers/tty/serial/8250/8250_parisc.c  | 1 +
 drivers/tty/serial/8250/8250_pcilib.c  | 1 +
 drivers/tty/serial/8250/8250_port.c    | 1 +
 drivers/tty/serial/8250/8250_pxa.c     | 1 +
 drivers/tty/serial/8250/serial_cs.c    | 1 +
 drivers/tty/serial/esp32_acm.c         | 1 +
 drivers/tty/serial/esp32_uart.c        | 1 +
 drivers/tty/serial/owl-uart.c          | 1 +
 drivers/tty/serial/serial_mctrl_gpio.c | 1 +
 drivers/tty/synclink_gt.c              | 1 +
 drivers/tty/ttynull.c                  | 1 +
 15 files changed, 15 insertions(+)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 8c964da75f2d..37164289277b 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1660,5 +1660,6 @@ console_initcall(amiserial_console_init);
 
 #endif /* CONFIG_SERIAL_CONSOLE && !MODULE */
 
+MODULE_DESCRIPTION("Serial driver for the amiga builtin port");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:amiga-serial");
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 34421ec06a69..c60745f8e621 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -470,4 +470,5 @@ static struct platform_driver goldfish_tty_platform_driver = {
 
 module_platform_driver(goldfish_tty_platform_driver);
 
+MODULE_DESCRIPTION("Goldfish TTY Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index be35f7334ecd..5d37a0984916 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -4634,5 +4634,6 @@ module_init(gsm_init);
 module_exit(gsm_exit);
 
 
+MODULE_DESCRIPTION("GSM 0710 tty multiplexor");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_LDISC(N_GSM0710);
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 1615f074ab86..4a4dc58b866a 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -822,6 +822,7 @@ static void __exit n_hdlc_exit(void)
 module_init(n_hdlc_init);
 module_exit(n_hdlc_exit);
 
+MODULE_DESCRIPTION("HDLC line discipline support");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul Fulghum paulkf@microgate.com");
 module_param(maxframe, int, 0);
diff --git a/drivers/tty/serial/8250/8250_parisc.c b/drivers/tty/serial/8250/8250_parisc.c
index 948d0a1c6ae8..4ba05a98791c 100644
--- a/drivers/tty/serial/8250/8250_parisc.c
+++ b/drivers/tty/serial/8250/8250_parisc.c
@@ -127,4 +127,5 @@ static int __init probe_serial_gsc(void)
 
 module_init(probe_serial_gsc);
 
+MODULE_DESCRIPTION("Serial Device Initialisation for Lasi/Asp/Wax/Dino");
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
index d234e9194feb..ea906d721b2c 100644
--- a/drivers/tty/serial/8250/8250_pcilib.c
+++ b/drivers/tty/serial/8250/8250_pcilib.c
@@ -37,4 +37,5 @@ int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(serial8250_pci_setup_port, SERIAL_8250_PCI);
+MODULE_DESCRIPTION("8250 PCI library");
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 893bc493f662..2786918aea98 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3473,4 +3473,5 @@ int serial8250_console_exit(struct uart_port *port)
 
 #endif /* CONFIG_SERIAL_8250_CONSOLE */
 
+MODULE_DESCRIPTION("Base port operations for 8250/16550-type serial ports");
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index f1a51b00b1b9..dc3870026bc6 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -181,5 +181,6 @@ OF_EARLYCON_DECLARE(mmp, "mrvl,mmp-uart", early_serial_pxa_setup);
 #endif
 
 MODULE_AUTHOR("Sergei Ianovich");
+MODULE_DESCRIPTION("driver for PXA on-board UARTS");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:pxa2xx-uart");
diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index 2056aed46688..58e279ea7ee0 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -864,4 +864,5 @@ static struct pcmcia_driver serial_cs_driver = {
 };
 module_pcmcia_driver(serial_cs_driver);
 
+MODULE_DESCRIPTION("driver for PCMCIA serial devices");
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/esp32_acm.c b/drivers/tty/serial/esp32_acm.c
index d4e8bdb1cdef..85eb0392e379 100644
--- a/drivers/tty/serial/esp32_acm.c
+++ b/drivers/tty/serial/esp32_acm.c
@@ -455,4 +455,5 @@ module_init(esp32s3_acm_init);
 module_exit(esp32s3_acm_exit);
 
 MODULE_AUTHOR("Max Filippov <jcmvbkbc@gmail.com>");
+MODULE_DESCRIPTION("Espressif ESP32 USB ACM gadget support");
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 6fc61f323355..8c86cf9cb763 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -775,4 +775,5 @@ module_init(esp32_uart_init);
 module_exit(esp32_uart_exit);
 
 MODULE_AUTHOR("Max Filippov <jcmvbkbc@gmail.com>");
+MODULE_DESCRIPTION("Espressif ESP32 UART support");
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 8b60ac0ad7cd..ecec483d4d59 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -761,4 +761,5 @@ static void __exit owl_uart_exit(void)
 module_init(owl_uart_init);
 module_exit(owl_uart_exit);
 
+MODULE_DESCRIPTION("Actions Semi Owl family serial console");
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index e51ca593ab86..8855688a5b6c 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -385,4 +385,5 @@ void mctrl_gpio_disable_irq_wake(struct mctrl_gpios *gpios)
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_disable_irq_wake);
 
+MODULE_DESCRIPTION("Helpers for controlling modem lines via GPIO");
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 8112d9d5a0d8..bd8d92ee7c53 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -89,6 +89,7 @@
  */
 static const char driver_name[] = "SyncLink GT";
 static const char tty_dev_prefix[] = "ttySLG";
+MODULE_DESCRIPTION("Device driver for Microgate SyncLink GT serial adapters");
 MODULE_LICENSE("GPL");
 #define MAX_DEVICES 32
 
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index e4c4273993bc..6b2f7208b564 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -106,4 +106,5 @@ static void __exit ttynull_exit(void)
 module_init(ttynull_init);
 module_exit(ttynull_exit);
 
+MODULE_DESCRIPTION("NULL TTY driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240607-md-drivers-tty-e13a582df002

