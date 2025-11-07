Received: from addi-data.com (firewall1.addi-data.de [62.154.208.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC12EA498
	for <linux-serial@vger.kernel.org>; Fri,  7 Nov 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.154.208.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538824; cv=none; b=nxbi0QURxSHOa4JYU9qESg/IOjebvGQWO5zdENMv+G673OwM4GIwWYHPW4T6dsLu1KJghnqEsOYWVzR2recfN/parxUj/sHYi8Y3J1et+pRlaCUMe3YHtJJ7qaefvo7bNYdVuRIlQxBzw6UbjBsDNsoTB5bkwmRizeeJjcLqcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538824; c=relaxed/simple;
	bh=3eKoYNkdBNWA9Ydl1wLppBvObLdANulzgwbgCahU8mo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XIWjasHHxpMBYVMc17cWeAkvlQ+k3CaYte20TjSn+jTBUVddQPQ7QKRHCloNySZQBoyibVRyPhDpsWbCrtyDKWQezKMJWhuX/aQkwWfDGLIybZqS4LKQt2JqQqIko6I7UbignK3SzV911yqyRKWOWe+DeoVqMRha6PBTyu96PI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=addi-data.com; spf=pass smtp.mailfrom=addi-data.com; dkim=pass (2048-bit key) header.d=addi-data.com header.i=@addi-data.com header.b=J4E5NoE7; arc=none smtp.client-ip=62.154.208.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=addi-data.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=addi-data.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=addi-data.com header.i=@addi-data.com header.b="J4E5NoE7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=addi-data.com; s=standard; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LU611krJwy4s0Gw7PlrNL6eLuOaiJgjUKPNctuF0vBY=; b=J4E5NoE74aE+FU0/5M59Hwk+kX
	1OZFlUqmh73sa5Err0aIC4geC29EOfZJ7GI30i/dPo8KfELGoHAjtw7vLsa6Q36JjcHZqmjnpb4Rp
	mUmbUaqeTWjAfeIoQmT9OVRY5OvBHux/HPh/VjEKu7Hugxvrm0sRIXXm0M2Oj+3b7SxYQSpfemqyW
	Goh+7Y6RFIVmZU3Pd+3QtBNBUYPJic0nnSpMn2gpEYFopCYsZNdf44h5Mvw0Jg2R5dZ8x1YEHI8rN
	9j6e2MlMPwnqFtOETg9wuFcnZrSx08to+1JNMiQYhRNL+KvzC40FIsBnoxYybHE1jfDFteX/MEE8O
	W/JWrgrA==;
Received: from [172.16.2.41] (port=56090 helo=security01.addi-data.intra)
	by addi-data.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <magne.bruno@addi-data.com>)
	id 1vHQoq-000000004y9-3Kfa;
	Fri, 07 Nov 2025 19:04:16 +0100
Received: from debian13.addi-data.intra (unknown [172.16.7.7])
	by security01.addi-data.intra (MTA) with ESMTP id 4d36Q644Mgz5Hjy2;
	Fri,  7 Nov 2025 19:04:14 +0100 (CET)
From: Magne Bruno <magne.bruno@addi-data.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 001/001] tty/serial/8250: add missing CPCI cards
Date: Fri,  7 Nov 2025 19:04:09 +0100
Message-ID: <20251107180409.76288-1-magne.bruno@addi-data.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-agari-authentication-results: security01.addi-data.intra;
Content-Type: text/plain;
    charset=ISO-8859-1
x-msw-jemd-newsletter: false
X-Sophos-OBS: success
X-SASI-Version: Antispam-Engine: 6.0.1, AntispamData: 2025.11.7.165719
X-SASI-RCODE: 200
X-SASI-SpamProbability: 8%
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_2000_2999 0.000000,
 BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
 CTE_8BIT 0.000000, CT_TP_8859_1 0.000000, HTML_00_01 0.050000,
 HTML_00_10 0.050000, NO_CTA_FOUND 0.000000, NO_CTA_URI_FOUND 0.000000,
 NO_FUR_HEADER 0.000000, NO_URI_FOUND 0.000000, NO_URI_HTTPS 0.000000,
 OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, SENDER_NO_AUTH 0.000000,
 TO_HAS_SPACES 0.000000, __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000,
 __CRYPTO_ADDRESS_OBFU 0.000000, __CT 0.000000, __CTE 0.000000,
 __CT_TEXT_PLAIN 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
 __DQ_NEG_IP 0.000000, __FROM_DOMAIN_NOT_IN_BODY 0.000000,
 __FROM_NAME_NOT_IN_BODY 0.000000, __FUR_RDNS_SOPHOS 0.000000,
 __HAS_FROM 0.000000, __HAS_MSGID 0.000000, __HAS_X_MAILER 0.000000,
 __HIGHBIT_ASCII_MIX 0.000000, __MIME_BOUND_CHARSET 0.000000,
 __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
 __MIME_VERSION 0.000000, __MULTIPLE_RCPTS_TO_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
 __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
 __SANE_MSGID 0.000000, __SUBJ_ALPHA_END 0.000000,
 __SUBJ_STARTS_S_BRACKETS 0.000000, __TO_MALFORMED_2 0.000000,
 __TO_NO_NAME 0.000000, __URI_NO_MAILTO 0.000000

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 152f914c599d..924ea92d17d7 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5996,6 +5996,38 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0,
 		pbn_ADDIDATA_PCIe_8_3906250 },
 
+	{	PCI_VENDOR_ID_ADDIDATA,
+		PCI_DEVICE_ID_ADDIDATA_CPCI7500,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
+		0,
+		0,
+		pbn_b0_4_115200 },
+
+	{	PCI_VENDOR_ID_ADDIDATA,
+		PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
+		0,
+		0,
+		pbn_b0_4_115200 },
+
+	{	PCI_VENDOR_ID_ADDIDATA,
+		PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
+		0,
+		0,
+		pbn_b0_2_115200 },
+
+	{	PCI_VENDOR_ID_ADDIDATA,
+		PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
+		0,
+		0,
+		pbn_b0_1_115200 },
+
 	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
 		PCI_VENDOR_ID_IBM, 0x0299,
 		0, 0, pbn_b0_bt_2_115200 },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc4373f6d..221a83d4e1ed 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2333,6 +2333,7 @@
 #define PCI_DEVICE_ID_ADDIDATA_APCI7500        0x7000
 #define PCI_DEVICE_ID_ADDIDATA_APCI7420        0x7001
 #define PCI_DEVICE_ID_ADDIDATA_APCI7300        0x7002
+#define PCI_DEVICE_ID_ADDIDATA_CPCI7500        0x7003
 #define PCI_DEVICE_ID_ADDIDATA_APCI7500_2      0x7009
 #define PCI_DEVICE_ID_ADDIDATA_APCI7420_2      0x700A
 #define PCI_DEVICE_ID_ADDIDATA_APCI7300_2      0x700B
@@ -2344,6 +2345,9 @@
 #define PCI_DEVICE_ID_ADDIDATA_APCIe7420       0x7011
 #define PCI_DEVICE_ID_ADDIDATA_APCIe7500       0x7012
 #define PCI_DEVICE_ID_ADDIDATA_APCIe7800       0x7013
+#define PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG     0x7024
+#define PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG     0x7025
+#define PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG     0x7026
 
 #define PCI_VENDOR_ID_PDC		0x15e9
 






ADDI-DATA GmbH - Airport Boulevard B210 - 77836 Rheinmünster (Germany) Amtsgericht Mannheim HRB210433 Geschäftsführer René Ohlmann
UST-ID-Nr.: DE 143754253 WEEE-Reg.-Nr. DE 65862200

