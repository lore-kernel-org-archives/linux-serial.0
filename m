Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023082.outbound.protection.outlook.com [52.101.72.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27728135B;
	Wed, 27 Aug 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298016; cv=fail; b=Ul8Xmh8nKCvaH8GVyxks9q7+yAHCtZ16SpbQrqA8z+pC2uCUfN2RbZb8d/o1Pf2c73Va661d6vELiPp/2HuGqkmCK2Nhtm6dkAUHTuoeSco17kdR+1zyhQMfxglbli70BPu59m3CfbZRwS1epEgDYFFPMK2fk52RLjymh2xzpxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298016; c=relaxed/simple;
	bh=dgO9KfJANjKeWgs9zfzFCATCgGi0E1nGRqTbGIx7ib8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJyShkO3n6semtGIJjlvjAIbO+4qMehsYtA1suE2QxQoTxXL2SSzlgh2G4OKSlPGbWYZnnZ9XwUWPn44ljryLy45J0mz0BxpQABhtWyDJUkmIrzFM7j/X2vNwKjG1FKj9442smReFNYKfKfrICAQ4ykHqHgsPVoNbd2c+3m+nB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nordicsemi.no; spf=pass smtp.mailfrom=nordicsemi.no; dkim=pass (2048-bit key) header.d=nordicsemi.no header.i=@nordicsemi.no header.b=ycqFY24U; arc=fail smtp.client-ip=52.101.72.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nordicsemi.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nordicsemi.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nordicsemi.no header.i=@nordicsemi.no header.b="ycqFY24U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vA+snZpKLhJASMNHFXCh5nifWMS39amIjftIjqx4jBSNyI/DtSOHzBZ55yCQZgl83NINka7Bw5NDn+LrYPfdOx4OWvxG1TPiEe8zNKkEZlOz4FU5l3bnAMeFzPE9E09UonZTsoebXXwsOtnsZrrTsuZo9XklUT2+c5UthPNcPB0l00+mYbAzAX9HvyZlI/bJutXpEFN6GIlcLO1ai4oCivfsppDT2pYk7HEAEWjA78bbj831jRF3JRSZ4Sa+QH3JXjNKTkayao1jC34YGAoLajC+z8fo4rlGQXAiO+EPqnuwbQhBIP6HCd0ZcTFsoA27X2HadUr/KZK3BgDbM8EyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFYigNKe2nfI7y/2BAS2oKoT84d/TEI13I5uE9WHIyw=;
 b=Qcj+RQ1ZYogNfG+tO276Fxm+IIfhOrxWupnq3cM3Mtv54Rluia9ozncA/of3+IcstsaIBkH8PJ0oGaQFyYcLYjgmoYI58Agcju72wf9nuYztWr4qQ1Wl1FJFrObt6MToWua1WbBxeGZohT/fBA5FM4MxBOHR9h8mRUOyRx9Xm/duUs8fSNfxWaV5XMIcixk0K2A21BBeJIBIidasrJSEflrKiydMt2SLlHKEpS4mOKg1TLVrLBhNsBkr+TOdch2DD+NrP0A2Pg4c+KVzepf2hUlK/RzQztzHwCFKsextP4RT6CMf7iT/fNew5lF8uukOxBQ7V+7YzWPc+eij9BN5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.19.86.146) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nordicsemi.no; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nordicsemi.no; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordicsemi.no;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFYigNKe2nfI7y/2BAS2oKoT84d/TEI13I5uE9WHIyw=;
 b=ycqFY24Ur5kUyRVGMfIeEkZUpQwYnb0PsCbJgui3ucXSaPDxFjqLhIVYOs6W0d1hMr8X2mssjRc04PvEYh58sEsq2fAtnuIgegscXADGjourdvY88lQI8VxNTX8MVObuC8vnLJffyGjlti6qD69KgZg/oM3EKFeEfH6eCTT0roMDxhts0t70GZedjEOQh4itg/fTO0ULCK+HdXoP5xZ/MsZj6m1yrYUfOy5g0d6x6GScS4qMsDu2r48NxWcO9pPVt9lbIn2cmNKGsDmiIctQqLulISoU6tB0id+8GzoWmYKwlv1HxS+7ywDOl2pwkMgKPz875qG1dTPnE7b1BDiZvg==
Received: from DU6P191CA0033.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::8) by
 DB9PR05MB8732.eurprd05.prod.outlook.com (2603:10a6:10:2c1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.15; Wed, 27 Aug 2025 12:33:31 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::2d) by DU6P191CA0033.outlook.office365.com
 (2603:10a6:10:53f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Wed,
 27 Aug 2025 12:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.19.86.146)
 smtp.mailfrom=nordicsemi.no; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nordicsemi.no;
Received-SPF: Pass (protection.outlook.com: domain of nordicsemi.no designates
 194.19.86.146 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.19.86.146; helo=mx01.nordicsemi.no; pr=C
Received: from mx01.nordicsemi.no (194.19.86.146) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 12:33:31 +0000
From: Seppo Takalo <seppo.takalo@nordicsemi.no>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Seppo
 Takalo" <seppo.takalo@nordicsemi.no>
Subject: [PATCH v2] tty: n_gsm: Don't block input queue by waiting MSC
Date: Wed, 27 Aug 2025 15:26:56 +0300
Message-ID: <20250827123221.1148666-1-seppo.takalo@nordicsemi.no>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025082617-unjustly-dust-4976@gregkh>
References: <2025082617-unjustly-dust-4976@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch05.nvlsi.no (192.9.200.30) To exch05.nvlsi.no
 (192.9.200.30)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9BF:EE_|DB9PR05MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c701e2-b5bd-43fb-ea39-08dde565ee71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J5DRBJDAVtXelJhpMxYX/vQMOJRf0Q+FafX4YejqpI8kuLQnakSscM2HWSjX?=
 =?us-ascii?Q?wJbb8A1LSVvVOuYive6dTZSv6A4uBfKfehbDRtJMpc7Ary7k6lFBvPwTYyBe?=
 =?us-ascii?Q?ZE4NHw/LWs0Aha+e+TuncIIy5g+Xv0xjH5aUaBJ5D1ZnOaLVktbchLSGGMWE?=
 =?us-ascii?Q?sZFs7eZkPK6b5bdA3sWPq4hDKJXHVJf5uG/PangMPAdlX7w0XOYcpE/aAmED?=
 =?us-ascii?Q?r5RFbaIwI7J2RgmxvcZSV0VREHP28srnKi0SxG77wzc5DaH1fnz+2l0psjQQ?=
 =?us-ascii?Q?s12gjNkoCY/CiOazOakLWXds8oXcBwxW0zxLpEF40veqbppTCqhgUHC+qvin?=
 =?us-ascii?Q?wCBF220j8GkTytjqt//gJK+ZeKznA4kb0OhRpSU3tRcCLExPDL7cEMeQUADd?=
 =?us-ascii?Q?PGrUAx1WebqHo41z5Z1/B7W9DFt4ivZxMF8xlXCUpFsuavxeDMSeJx6q7lNi?=
 =?us-ascii?Q?NhsopW2M6mEzQw9/FS3CkE57QcWyt1ry6d4+O0OjC0ncNP4FYczSoxURIvDz?=
 =?us-ascii?Q?eWxSRGDYRNmn6ibk/1vgRjnPqjNnFwgt/bBrgo9PrqhpAEjzMr4cXDkbbGU1?=
 =?us-ascii?Q?y6sH2+AENSf0bAWZQNU4/y4bDemWEU5Zp6i9EHekwOTAys2RyGzaCRd1vpGS?=
 =?us-ascii?Q?tE8dhNTvl7tJxUYPEIsmdIRGeibfP/dbKWIUjJTFZsQOwNmNZ+W79w1sE2Mr?=
 =?us-ascii?Q?HlWD4pwb++jVv15VeN1OTU9w2Ft0PkZ276/TmfHWOnGSQ+ZY6EDFwZOY0RgR?=
 =?us-ascii?Q?gdb1eopb9Z8DOfe8L2VwJerEnelfzXIHHFqdidTXLBI2uNCInCIGbHFxlrR1?=
 =?us-ascii?Q?kpsTzhFKt6FI9xGvk+kuQ/Bo5beb5yd4z1AUHstol08Stb/Yn8veB+UY5MrJ?=
 =?us-ascii?Q?tG//LswJv/m0DgmMu2hFESFvahovPGhODdjS1ldnDjNmr26C5QQLmaFhEyoF?=
 =?us-ascii?Q?M+PglQxpP6tMgtyC6t2n6G1sNaEAkWHUb8/0GaH0k1PpVA4Vu1koKutXjAzq?=
 =?us-ascii?Q?j8Xj77fz+SxioYp0dGDA92/ttCYJWB00xB3ORMBE++gE5zqCuYUYG/fMGkKS?=
 =?us-ascii?Q?30nJ7iD7l65XWfqUwFosToyHBpJxZpR37pkOw6RcmfSpz2hae4ByxLgqzDuk?=
 =?us-ascii?Q?+eq2B9tMUEAM0N4H/O/Nn752F0uYkYpD0/KsQKOru/XVRP5/eMUKMBJzManp?=
 =?us-ascii?Q?lfYEcMiqssCwtHbPbBgvCLXMr/0ykBhJ6FmqJYDyS74cLcFGelttCLIYF4tV?=
 =?us-ascii?Q?G7aToErAkuPloDuNqB0BaDI6K5AOx0Bzzc6m0cjjRdGsGcijlkIU5Wwa+iOS?=
 =?us-ascii?Q?reUr9Oce8Hppv5VNQVn3BfsJHtgEsmjZTfY5nYbQHyUtFgwDExJHbOMM49wS?=
 =?us-ascii?Q?DcfLav4KpXg5tDQ4ymCRloATxU+zjef2O+w4CR1GF9XtjfPHvdlQxt3gkyC9?=
 =?us-ascii?Q?dDohOAkdBV5hq5y1SA1DzAcgiHocs/TaqYZ1qv0VLlVlVVzSGyFhCQ50spRo?=
 =?us-ascii?Q?iIAq+VIpKIC6bQ5PsdUFrOqpPTnPh+i6+Mpi?=
X-Forefront-Antispam-Report:
	CIP:194.19.86.146;CTRY:NO;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mx01.nordicsemi.no;PTR:mx01.nordicsemi.no;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: nordicsemi.no
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 12:33:31.0444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c701e2-b5bd-43fb-ea39-08dde565ee71
X-MS-Exchange-CrossTenant-Id: 28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d;Ip=[194.19.86.146];Helo=[mx01.nordicsemi.no]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8732

Currently gsm_queue() processes incoming frames and when opening
a DLC channel it calls gsm_dlci_open() which calls gsm_modem_update().
If basic mode is used it calls gsm_modem_upd_via_msc() and it
cannot block the input queue by waiting the response to come
into the same input queue.

Instead allow sending Modem Status Command without waiting for remote
end to respond. Define a new function gsm_modem_send_initial_msc()
for this purpose. As MSC is only valid for basic encoding, it does
not do anything for advanced or when convergence layer type 2 is used.

Fixes: 48473802506d ("tty: n_gsm: fix missing update of modem controls after DLCI open")
Signed-off-by: Seppo Takalo <seppo.takalo@nordicsemi.no>
---
v1 --> v2
- Removed the proposed "bool wait" parameter from gsm_modem_update().
- Defined a new function gsm_modem_send_initial_msc()

 drivers/tty/n_gsm.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 8dd3f23af3d2..532027370dff 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -461,6 +461,7 @@ static int gsm_send_packet(struct gsm_mux *gsm, struct gsm_msg *msg);
 static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr);
 static void gsmld_write_trigger(struct gsm_mux *gsm);
 static void gsmld_write_task(struct work_struct *work);
+static int gsm_modem_send_initial_msc(struct gsm_dlci *dlci);
 
 /**
  *	gsm_fcs_add	-	update FCS
@@ -2174,7 +2175,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	/* Send current modem state */
 	if (dlci->addr) {
-		gsm_modem_update(dlci, 0);
+		gsm_modem_send_initial_msc(dlci);
 	} else {
 		/* Start keep-alive control */
 		gsm->ka_num = 0;
@@ -4161,6 +4162,28 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
 	return gsm_control_wait(dlci->gsm, ctrl);
 }
 
+/**
+ * gsm_modem_send_initial_msc - Send initial modem status message
+ *
+ * @dlci channel
+ *
+ * Send an initial MSC message after DLCI open to set the initial
+ * modem status lines. This is only done for basic mode.
+ * Does not wait for a response as we cannot block the input queue
+ * processing.
+ */
+static int gsm_modem_send_initial_msc(struct gsm_dlci *dlci)
+{
+	u8 modembits[2];
+
+	if (dlci->adaption != 1 || dlci->gsm->encoding != GSM_BASIC_OPT)
+		return 0;
+
+	modembits[0] = (dlci->addr << 2) | 2 | EA; /* DLCI, Valid, EA */
+	modembits[1] = (gsm_encode_modem(dlci) << 1) | EA;
+	return gsm_control_command(dlci->gsm, CMD_MSC, (const u8 *)&modembits, 2);
+}
+
 /**
  *	gsm_modem_update	-	send modem status line state
  *	@dlci: channel
-- 
2.43.0

