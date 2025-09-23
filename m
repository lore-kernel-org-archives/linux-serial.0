Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9542C18A;
	Tue, 23 Sep 2025 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636740; cv=fail; b=BpZO1NjF3IErNpgzQ/AxI2MZjj9Re4IuWoWDFq2ryiM7p0ITrLSADS8Vc8xS4ZwP5SuDOHzFcUCZy+AApvvbARQfMzl7mM8+RYrX+qWQIlHTSwMW7efQwm2rUGdmU+lzw+1kYIU//q9cBqsQ8JunbCCyP3md84MH7UW3+KJLvjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636740; c=relaxed/simple;
	bh=298n2aeQCZAZUwj6EmNpkUhcIPa8qY+PpD11ViO9/lE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GPu59mg/45Mf6WoO9qY+WajkbfJpsZKzd/bO5yQOmFEc9s6zOckEncT7rePm/FZamo/7Ql4v3hepoFDt1i9/UL55i+wqfsG1jcvko01TuAp2tsIJO3MWe7rr/KMwPt4Qz6fQDnQf434Npc653rGj96wiW7J3OlrzxfByrx9BEVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SJYAaQdH; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SJYAaQdH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJcYyn+hsZ57ih2clc4gAMhsmOKaDUZ9zlsW/KUIC8mYkhoOyZuhVtWoAN+t4V3LTrAEpG+AF4L3sbtHuUeU/MAizDiElCRz5Esp9pW/7ohnFuBh78mMEcTDaUwIiN4uqvApRmCW84AVJsCNNroouYQcESpAwU2jezF/dsRhHqcmGzH2bcP+r8xnvrG4S4aKK778WXif34JRNbpQWVpBR1VbMGLxO14zfPzsLYpgCK7MO4cbMeHo9qwB7jdNVwf5/3jizwHDzhRYhvxZN5XUbs7lLczLZlXvfGU74Hr+QCGhq/tEo81srwdEHan99wAj9HClE5gimV6pEIoaLiE1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWcKlAVEuNjbSd8iUzzHxBZucXK824MgU7GYSAe9lZo=;
 b=kAySDYYHcEULRkdsLb6nIhdXS84IFSr5gUDN1SIaDenUfIdJBOleCPbdf5/IPO3mnGRpQF3ReFESQOKXwvnf4j2xHB57ipsqM9cpDYfZI1lnLUAENIkbaiXH5MbwJ6qllwB+TO1rAomX452ZqZZLZrYdW7AK0I2XtA4WJPSaLa/8N1L/coCs2chbTeO7yXQFbqnot8O7jEIMpzU5Q32/Vp9Hf0mtkjIqGKc7q/6uwy3OlmrglJC5qyHdWwqbIk3SOGBiqiH+/qT4i3mgkF73sknN2gz5Ik6ynh1s5B3ZTlNHwl2prQmw5LXWnfzB67Ebot7MQOSQhMWVgD799KAScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWcKlAVEuNjbSd8iUzzHxBZucXK824MgU7GYSAe9lZo=;
 b=SJYAaQdHS/vScX8Du2K9FV+jX31HLH2TnDUhb5pkK8kmN2z/+K7cGPUXDlXAYXRasqMHlMIaJCKL9qLSqvYqdYpEIykkS5C/TfE2zL4as3wntmAIzanTadk7YULX0xhwVEUKoSBbMg3iDsB9CaPThmcKUfNcm+h7jr4emnO/y6Fu/Ov+BwDwm3XPBfRKaJ2ugqLQxV9UQSzKzTM8C05xGXIen+Bj98xD745SQYyUJmjlHLwDZbzRE5S9cIE86zxOvlotBieYtm49hiNT2jV5Iw8MOncT973NYsn0wK/i523qk51JEDiEE3Urs/CQxlQonFWAPOinPXJ8Ew7YjLWQHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15)
 by DB9PR04MB11578.eurprd04.prod.outlook.com (2603:10a6:10:605::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 14:12:08 +0000
Received: from AS8PR04MB8418.eurprd04.prod.outlook.com
 ([fe80::99c9:99a6:e6f3:7a9f]) by AS8PR04MB8418.eurprd04.prod.outlook.com
 ([fe80::99c9:99a6:e6f3:7a9f%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 14:12:08 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	shenwei.wang@nxp.com,
	peng.fan@nxp.com
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] tty: serial: fsl_lpuart: Add missing wakeup event reporting
Date: Tue, 23 Sep 2025 22:10:51 +0800
Message-Id: <20250923141051.2508077-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8418:EE_|DB9PR04MB11578:EE_
X-MS-Office365-Filtering-Correlation-Id: aed0710b-4eca-4f2e-041a-08ddfaab2e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K2ep7EL7QnYb++nbxZ+8B09nkdx9UkIea5D+VFzW0sWBcRxfIFNuqWg9OqWn?=
 =?us-ascii?Q?oms594jPjF99A8jZ1N2aZHabE8eKnD7Umz5ShOkNG3R1sJPCXCLtBISPG+lQ?=
 =?us-ascii?Q?PgIJIaIocmLdVfF8wCDbMB9DbdQ36fwREAd6ZA+fLVzmTCqditaL0eRj73nB?=
 =?us-ascii?Q?BeaVuzzEn1Kl9BGnPCjfnScy7+1AAgL923Z+SEjFFbAIN8ve4qkTamW3Twkm?=
 =?us-ascii?Q?zx9xaXik1JJQ/AVqNPsHYVAVBfxj2oOsr8rbrkbA/6ygiRRugpX+qCxtpoNI?=
 =?us-ascii?Q?T3AgZqGZpcC8o7lZLm+s3+SoUqoXYrNm6++ONnAETSkjdrAvcioWGnixn+7s?=
 =?us-ascii?Q?HBL0flW5xhmgB9WJFcBLvoGrnYjvqPYpC3Ne9y4QFynZv8g+HnjT5vamWeBB?=
 =?us-ascii?Q?5XnJoVwZUXhAdbXBmATIgjBj02lB43DvUy87/RlD3UhaLrFFUS50nVYy2Zzh?=
 =?us-ascii?Q?BL2KGFGMgeYkyttKURtYtiVVApR427fu+9hOp2zFEJKCQqESggC9YYgFvDpS?=
 =?us-ascii?Q?KtGoj4+MruY7V8h4JHH7UQN3HgdxnFY/I75ZNoY+/ypi29N/rtSTr+9CcAHv?=
 =?us-ascii?Q?9M+MCHk+1sDxkoX68SUbSVFprBs/8/FM3ez5QcBviQU7lhqQ7n0ZTXrfKARe?=
 =?us-ascii?Q?HG9rtLlP4XQ5N9sTlD2crUnioYRotSxstrl+1DFC0T5RZ+BjWCruW5Hzm9Sn?=
 =?us-ascii?Q?WisTeMAHiXxM2EASfDMHbORqKEo+EbDTXBaLOfo6xk9+KGYmsIwWBJfQQnwu?=
 =?us-ascii?Q?rFJJQl/w3lm4pAcZi0YEt3R7or+W8shyOlkMQKZRLeNAQaTbIv9R4xmD/TlZ?=
 =?us-ascii?Q?10iWTcguX3T+Wj01dAIyXGMaUEd2VQXum/tI6P58tGnH6mOsafGmzVwxlBYd?=
 =?us-ascii?Q?lDNPLtea8jYnPGxB8t9hG67XTG/8yaTX8mILfy+GNirGokExKCMY2jfMHY/k?=
 =?us-ascii?Q?fJ4ObSCIXjDB3HJswRxXBU8k3BTRiBX/cWkt+Dpfwmp0wECvnLwRGiXL/ZHE?=
 =?us-ascii?Q?rdVeyOIfXemGyeRPao6Bhl0dTj7W6wdkeb3PMUdMIPE43pokjR0Ii7sVq0Wp?=
 =?us-ascii?Q?FN139JT88W6WGpTxZIU19Qu1GvM+0wbTBKq2L0UiY/5657qn4hC1mBgoFRyU?=
 =?us-ascii?Q?wSEdrk/G3lbobyVOjApf4sciiZ+uVO9kN+Slqw4LwecbEpSlsyJRlDRVrIYe?=
 =?us-ascii?Q?yioaNq7f/t+RqP2J7SwhftnxrH9xhJIYT7XvQivRX0g+3ATTwe41Xr/tx4/d?=
 =?us-ascii?Q?G6LZixEMBlDJordCrrXaNSvV5bmzZ5YPQYR38hcLvqR4d956+9skP5ZIbW23?=
 =?us-ascii?Q?zWrHVfFJ4DRsp2T6IALjlfGkL9NCLYN+sdr0JzOVLPYTKBSPSNS3rM5DijBR?=
 =?us-ascii?Q?KL2atkQsVT7bz86BviQV8MhLw2+ARsk/5I9Cx5TBicaKDocUCEnP557MQXwV?=
 =?us-ascii?Q?OLm67al/TLWoFpjz3q/dmUQwZf39neIO6J78vPg+wiwh9cY0gEVGmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8418.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+d377xegnzoI+s4FAILogILaRzSsED/ALDgIB3431KZzxWLeuATr9jUmKkdW?=
 =?us-ascii?Q?fAETflkstwMkHaUZUqAYxNv0jRGFyME6PTyJ3nHG62tmZ/mIA7SaIKP0iYZ6?=
 =?us-ascii?Q?nRSak6YTCQuAaioH7IcobCjhnA/1m4WOc9rwcB3IC8PRIQkmGFhGWv4ZqtXT?=
 =?us-ascii?Q?xPEsPMKa/moELP76cy19Ni2EU+sEvMjNQ5XIgNCWICRJ9JY/kETuN92wUWfm?=
 =?us-ascii?Q?DSgz+jR3dL+A0JxfSaYDWllXRnKcnANV3o40UQBGtAGBqqfKdayJJ9IS9+x6?=
 =?us-ascii?Q?nrGu9xJzJ7nRAbLaPzlLGyt0sORp7lRtoODadd9wpK5ZG51Q+DAkSKqQzvpe?=
 =?us-ascii?Q?VmIDd9Sm/peUXlA4f+TF7AEquSBZpQM1BPLouyu0gUQdgAZhyWufvH8Wk/hi?=
 =?us-ascii?Q?UrSlnwoWijZUauNauiJuYfVhEQTit1+CJ6G0x/EGQDUlOeZ284jIK89n7Ro2?=
 =?us-ascii?Q?wXq6YmGXooUXMCW0FhKyV5gXOtyx82F8BXtQyz7fkuJWQE2gifrGWMK8ywfi?=
 =?us-ascii?Q?mHW9ZdUOaxDqaMKVcxJaQDMWqndwCHTqd/BiMwZ5ySBID/IMkJcSGQDxSjCS?=
 =?us-ascii?Q?FYg3vFc2BA0329Jwdo04z1qhn3JuuuG7DfAx3Fmw8Of9ONy4z0FoKLibBdOZ?=
 =?us-ascii?Q?H/tANn6G6QXZnJ/3CPBxH+PoiQT4/+F1BPg/HLZkoKS3d4lLhHthhPdMkumR?=
 =?us-ascii?Q?kqdmPn2S1k42WgST2iwn62QUNDxqb1ztJOVP9NOF5hWgR/G1UOeNSdEnFgqV?=
 =?us-ascii?Q?CYC6TxbrW0BxF8XxdQaxkL+fIYt5Ob/wLzHJDWNVfzxCLipb9AShEBYdjg51?=
 =?us-ascii?Q?c6eHRc7Hpax07rDkkbPLk3sXb+hqK2E/EoJIIrXtwk1tpcl/2x19PHo8lbY5?=
 =?us-ascii?Q?IYvK8mgBHTm9T2HgUppIWD0aMdniTcS0K9Ufi3iuQbw9VwmYeTaY3QRgNZcf?=
 =?us-ascii?Q?642d1P5IE5yXtSPZp65rStZx53RTss8WsQyggoRzPYsQgpcHj9Pgg/h/b/UC?=
 =?us-ascii?Q?ixbEQ/i2STaNJKm3vz55Iu/LdQRBQllctWdUDePE7GnIQ8JBmltG7bRGIonR?=
 =?us-ascii?Q?+0agEKqtHLEAqWm+0l2+bGaYpcmAINc64hVlA33TjKAgiOCJ/GdlpLfqh/xB?=
 =?us-ascii?Q?HPFtFzPRXAGILGqkpZS8VKaSobLDPVModVcZ3HxfmmhNOzVKom4X2RdB4mml?=
 =?us-ascii?Q?DSSaRtBKmcGeg28SUXOBpf6e5NoPo0LZMYtMy/SL6bvBgJ8bBE7JcOcNpnUJ?=
 =?us-ascii?Q?ch8n41oyjWnj3xwlM3MiPFrrgdxSGEK63rtDMf28pOfHyojsdrGeyV5Ar0s8?=
 =?us-ascii?Q?hlzYh3tb1ETW/fFu9axaziUsAWm9KcY46GNWHsmrm38Qbmw3eSJDLUAb43QV?=
 =?us-ascii?Q?LEfkwgjybbeX5ZmQzmW2ye6YohefuPNB4UEI/F27osOxWSsk5/P/dm0yGAi+?=
 =?us-ascii?Q?8Jg28gHxOUjOlGvBvDYc+Sg/lGAVvfVOdvgcU3V7UxLirCXOXoBm8hkMscCU?=
 =?us-ascii?Q?v46ozo3uSzLzVapA2mgp4wYdDniU/ydsVwhsndGUD9eJe2oaAkhmvx3fQ5cM?=
 =?us-ascii?Q?z2gMJz0aw27Woka25aqRcsEwBdpmSGBd+y8qUXHH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed0710b-4eca-4f2e-041a-08ddfaab2e35
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8418.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:12:08.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sHQh4N6KFMRG+eTDsbJRQRboZvU+699CmHA5/GMlvEKeuLDnloSjlKe6/zEw2hYrqNt9WVIYY4AmrfwsyYRmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11578

Current lpuart wakeup event would not report itself through sysfs as
being the source of wakeup, so add pm_wakeup_event() to support this.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c9519e649e82..9625997758e1 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -3087,7 +3087,9 @@ static int lpuart_suspend_noirq(struct device *dev)
 static int lpuart_resume_noirq(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
+	struct tty_port *port = &sport->port.state->port;
 	u32 stat;
+	bool wake_active;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -3098,6 +3100,12 @@ static int lpuart_resume_noirq(struct device *dev)
 		if (lpuart_is_32(sport)) {
 			stat = lpuart32_read(&sport->port, UARTSTAT);
 			lpuart32_write(&sport->port, stat, UARTSTAT);
+
+			/* check whether lpuart wakeup was triggered */
+			wake_active = stat & UARTSTAT_RDRF || stat & UARTSTAT_RXEDGIF;
+
+			if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
+				pm_wakeup_event(tty_port_tty_get(port)->dev, 0);
 		}
 	}
 
-- 
2.34.1

