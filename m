Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAD1DF25C;
	Tue, 11 Mar 2025 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741661767; cv=fail; b=QKP6wYtMbSocsBpkhjfYpXouxpSUHxPryBtuOtpGpJdLM7ye3d9wEarSwuSuq+57lGlgAxUG7wh6u9oWGmQVIG20QSG/2O9+0UVFMwlmPY+n34V0GW6BsUBLEe6C877PiRalIirxoeS39D0174K2pVrWkHwFJo8sI/EkozYuYwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741661767; c=relaxed/simple;
	bh=KOc2/Lemt/6xW1IQNl13FuEK6j5I4JnZuGh22LyqEjg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CT2IDHQnIC/+eOyCs0y0+v+EIO7AiBZjXvjqkTQnNZb4ODdZf1RCvb4rKENVhupj5+ARkNedlhs4k/sabmXaA+QwA+PgKTdR6gjC+7e+2hwFet1FLZWhgFICHrnjwdaZA3psTFRKre2buuVwFnkAbaQOwHzWBv4RqLwZ8DdvQmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MSMScBYw; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MSMScBYw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPj7vrmU+osNzX+U0uBuR/OnKWODl7hy2D6hNjYkq5ZMDJOx6YGzwBcbWeK4Aa7ksG5hpPyyuEgIllxD6qF2Ubeg2UR/Ol//0jIG9otzf+1oGvHZKU4RoKm7nsLiQIRut07mhgi/bbc7uBG+FkwLdkYqh38rScMQTLiw+UWhKDps5tNj4t8PByXPUy2PIF1SHgJ0Bq0sEV1n7wlD5wvDFLAwmBlXjcHRbWCoaPs4zB049ZxbBSR632bzU0FwVGSskVhn4dCQFb6GfHhAJVD0oUZXOb/CNpmbkbS63Tkrv2WDOBvwPuMBbqk0z8i/rK6RmizQiRFGxvW5C7k2hKIZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1Dxq5OFSN7FfF8y0sbGRpJARnUbDtlCKbpXg1QZtYY=;
 b=DVHvxa7V7PzuSvcS5F320xxmPo1he907ey2+/fGFD+QboU9BUKpH7g7Dd/A5MavHdsdeB5iFleZa3mROLPaNzU/s65cxZp/aYL8b+avEruo3odoRh8j/kroo3PLCLzF4REeoQn2q11XlnqyEMTw2NEqBCOxXxUJke28VaFYP5h62jcvAf4ZTfVIGzJvzvXvUYBXpn0JryS+tbWr792tBtblobSgEsWA48UlkVDNwqO3rxHELUQqn7P3cxt3bbe8QUjO2KGUzCDMlQNpfu9jNX2byxXjiIKASxrY6ztFqdrPciHbU7M/jzU4KW5mSd0n0NJn8HezvA9JR1yj4MWzirg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1Dxq5OFSN7FfF8y0sbGRpJARnUbDtlCKbpXg1QZtYY=;
 b=MSMScBYwxU3UsDDQL8Xs8g48S7I9VFgnJA0vSguL69Wst/CLuStWc47s0ZSDeMJStgVJsL7pk32D20vwT1AoTmxWoGtEAKQ3TcN2ABYPf4Iw6E7lIB/FIuew3PyccG192HKr3Lvojdqt6fmnryWermJKcwbkWs4vKI6sbC+JHNZmrXG/kmMRl7fLgolXf2mb1hPq7LS4whO8Bd4IvtVLNk/KBIrOOOUNKpdA0QN8kZmp57rxuzsw2YsJ57L1VJ5eZvWb+r0UbO1gmiCxFycIBpLgyR4rh5mEqMsLoGqyxZoUICJ3j/EO9KIyMYV03Dr1J2qZsVjTZVZ+at8qxENC2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by VI2PR04MB11098.eurprd04.prod.outlook.com (2603:10a6:800:293::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 02:56:03 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 02:56:02 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com,
	frank.li@nxp.com
Subject: [PATCH V2] tty: serial: fsl_lpuart: disable transmitter before changing RS485 related registers
Date: Tue, 11 Mar 2025 10:55:50 +0800
Message-Id: <20250311025550.1243569-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0166.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::22) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|VI2PR04MB11098:EE_
X-MS-Office365-Filtering-Correlation-Id: aacc7262-4070-4468-d7e2-08dd6048427a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMoXzzJmaqKSD6x8YJz6tM1oOcLnvdOCXaba+8xbLrOFngs1ZiYGHlcHMapL?=
 =?us-ascii?Q?3tNvKExIkRO4KTp0RUvkJzLAIiMDWysCR7UHusgOP1FcK2hgyDBJrMI8BLM6?=
 =?us-ascii?Q?AaezSEfMO3arH7tnDai5bHku3czlC749e7xY4Y5HbZmk0CIrKOIjrkhNdQRT?=
 =?us-ascii?Q?Mcbyj52wRqN4viXRvvwwIOo4zInm6hH1WOFmXh3rN2yVDQf891u3TCry9LtT?=
 =?us-ascii?Q?8jVYOR8HQYX/ac1JsABYnrpjuiXOKg2IvEWu3gDnwFZPetDqKcipwyK3IWQv?=
 =?us-ascii?Q?gtk7Z0EJe2o0U5ZBddPtr8P7LnQVT51UsahXMzAHx+3pYLmEOljW2Vmsk7z7?=
 =?us-ascii?Q?FLtGB9NIM2dOJ3+USyHuW4QwUMwu7481WHHBAXdmZosgRoNWCckS5Dm3YomW?=
 =?us-ascii?Q?tsYY96K/9ZdeK1Zp+PRGMiDZtfWShkYlYZlKFLQV2o0GVt4U4HIL5GV5f3xm?=
 =?us-ascii?Q?GGmLotG5Y2tLd6p168KwGmbVFaeYPbWuWgsvSjJHR1IABJiwAODjSw56DLCG?=
 =?us-ascii?Q?ahfNn1Dm4ZqdfxSJytzgi0oAQ0rOVclGYH1jF2HfGiZKj381PzMVCgWYaAL/?=
 =?us-ascii?Q?gDySlw80FI5WJnfV3diNlGOFl9oTFmXKFh6doD15liRc7Jcrt13UbQhMsD0A?=
 =?us-ascii?Q?NK3w2S3JzjjVOGkjKLNSgnNp8m6hNp5PtWhAFxx6brsUlkBjV+z2Qn1OaDQJ?=
 =?us-ascii?Q?naPrjR9mrz7+s9y0QuNGZWlZL1nVc9bpvOhV1y2BN1ejLLaUd71aBNKscoNX?=
 =?us-ascii?Q?kPjwcyneV0kycafA0mTjDMpKdwNM72T9efhaP9D50KnsNlfuQMM/v8dpxR9t?=
 =?us-ascii?Q?+WiNdjkP5bBWeuSfJ/JmCjQQ5vSCm0VYG7BVEH7N9TY+Z/rb6MBoFU6zIcDh?=
 =?us-ascii?Q?Y6mNmPyBAn3EEsg7641lHlJGgSyUma/O1V6V1RyEcLvQ3UEI/sSCD5yOl/MP?=
 =?us-ascii?Q?MjyMxl7hB3IWgQHzHcROvXvO1iCfyy5JlW8Hhkd+vy7razgz/AcfJAdYS1RT?=
 =?us-ascii?Q?Gert5dTenJotXVBv9FpW9Yk7pxVIztrQseu1tLcoRrdFygtchEtunCgxD8bs?=
 =?us-ascii?Q?SUwlfuh+dURGqQzbhEmbP6nE2afPdlYwwRvwTWzKefyC4xD/XEcksdMTvX2/?=
 =?us-ascii?Q?ETpu0K9JFFd0ZUv9wJIkvhTAJU+b5CCiDqzzj9NufS0DwXSvuIj12jBEp73o?=
 =?us-ascii?Q?LvV+NrvnFEjBHaztGhk4eCyrVnzWk2yZwBKgj/M2zBiBpbojheog1JJvZI0n?=
 =?us-ascii?Q?y9KWG8WrIRzv8KRKSlb/oqPUn0gAPccfgJr2hTHUiKzrjmLqCd+TNDWUsb1J?=
 =?us-ascii?Q?5bzfglXwVlxINNtEMrgYGryNnBwySPim7WOrH0jdbnAKKAnSq57MbBQWJMLC?=
 =?us-ascii?Q?ggjT19eJ4DYatmBCzvcPVX5/uHGrXUOaa/hai3DBV7ccIdXanjjRvw0OHPXl?=
 =?us-ascii?Q?tED6zhflnbbJxFSXHPvbyd01UZBVYdBs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9iGKq3UiFHFnOQCV/NiMDY1FT5D5JkVQaBubRbkpbcK9A3LYNiZvfet1XIA?=
 =?us-ascii?Q?7VESoHUelDE0/8oZfve4ZasfeUtL0bpvVBK8MP+dSNJ23dB4SMB75WHHIWQH?=
 =?us-ascii?Q?4LTWyQk+/rOMkXHdqjU+8F1cG+q29gJ1fm7N1XH//ovIXCL2vMvb0kM4nZjx?=
 =?us-ascii?Q?LgCUyLvw+xpeNLUmugnmSFPbEFlTlJO0i7HijiXwUxyhWhZAditXwccluwn0?=
 =?us-ascii?Q?MOKtCMcfE8TrrQ7POVdl+EuUQXUQo1E5JoKov9uWlpy2IBJ6ydU+fb4THV+D?=
 =?us-ascii?Q?I/1IDF2aj67srnapBbZKRy1qkBE97hYUj864dlih04hGRSYY6X+5o/4tFzPQ?=
 =?us-ascii?Q?bdOaoCjH4MYWgxRCtlWBmEum0era8zarcMYjpwxMEEfSfVd5qmsRphugpZX2?=
 =?us-ascii?Q?4W53mKdcSur+vJumIMUKt1QlxWPVM9ItSMKkHDUxCNh1BW4yg+ABCdPOc4pm?=
 =?us-ascii?Q?4/1l6QG7hbUeWuv+E3wv5YVt7zUJuPGSlp/g74qlcs8Gp/J485+iyj4RUaU/?=
 =?us-ascii?Q?fk3uMGvJ2SFFuUjL3EgZqu5UqlT6h/xfo7n/05dCyt+zZgQrcGCjJfqFT0IN?=
 =?us-ascii?Q?DrgaHQZUNbExRPqqK0bUwMVNS8q2xvfpvItXRg3A4GXt5U74xZ5NDmgWYD60?=
 =?us-ascii?Q?LsnYPMizTJzMYgnch18nfCw9mVM850ZLnmeXMsNN3kV0jfS9lNTmIZwEBVQs?=
 =?us-ascii?Q?pVWCqp7mTrPh9OWnyWwF5JMNZp2NhKlqNwHhJgIlF/fZF3EoumWXS0BG5Hhm?=
 =?us-ascii?Q?i+6AJRKK17SO1Q7ZeZe+CrqfSZbpmaUxeLdIq0zpb1h8vnsRWnsqAfQCdx2l?=
 =?us-ascii?Q?OvU/aSf7SADb8m7vOKKZlzBNCsI9f9bbqcU3hDG8FVKClSWuAkShqT1ytT8y?=
 =?us-ascii?Q?YJ9ijaSaPUkfYPBlsCyC92mKlBGZjHFopIl47ZpsIc7Coqrb2IJNDHHWTWvu?=
 =?us-ascii?Q?o/N9PayKlb0cbQ5ZXrl5YC+LEtaZML5h98RTye4uIAecJxDm7Qd67guW7QTG?=
 =?us-ascii?Q?SY1UaqmsMmDXaw+j8H4jqicCnskzR8bdTGX2+GOctg+EL/U1D7qMvceW/eg+?=
 =?us-ascii?Q?/1SyNcsObJWHEF5TovDiC0DhOWeXjdkXNEKjQUGIF0iw1sgFiyPqriwxiRT5?=
 =?us-ascii?Q?V20WfoS27xHS2AcrRIxSgMKKlQ2H1dc5nyLlkVOufao1Vfr5pmSqbX/wHpy7?=
 =?us-ascii?Q?wXPXroYh+/zd87JVluOoKHGadh+/0WPbQ9kFtwtiiclgx2RF636dsSoZX84E?=
 =?us-ascii?Q?YUEayIblOj5KK2NNTPH4GBMTTLLInF3Jc35mqn+eL0yuHcPoLRGW0peRvZc1?=
 =?us-ascii?Q?RdnliEbzkii9+PDaDnjemOPnN4X43cwA6bKupajSiuaRw+JvHhtl3kKpTnWn?=
 =?us-ascii?Q?ZZW3YGHEF6jRoMDJFo+4OTBJNBgUfzDBalb4RLNXVMHl2aakSS1rJ0H9ETm1?=
 =?us-ascii?Q?lLHed8JD/7ZakrwJMjaTWRDtx+Y2h+Dqyb+JLbDZBuU1l3wsDoYlhXM+MOgU?=
 =?us-ascii?Q?1LSlQ7UiAHT9weVKPIrROtgaN9VWEImzAP1S3uZDoZb60JbtObGwKGijXDjf?=
 =?us-ascii?Q?XqStPpUnSDvUyBOYHF4T18e0pVZsPhE03QXCDADf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacc7262-4070-4468-d7e2-08dd6048427a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 02:56:02.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xYm03mqVgnHgsVbxgkFTHeaZcYmxQB+pP/ASBijYR7EcC2RC8rArGRHAT4xFTBr6dH2oyKgCqtNUPGWWlUV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11098

According to the LPUART reference manual, TXRTSE and TXRTSPOL of MODIR
register only can be changed when the transmitter is disabled.
So disable the transmitter before changing RS485 related registers and
re-enable it after the change is done.

Fixes: 67b01837861c ("tty: serial: lpuart: Add RS485 support for 32-bit uart flavour")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in V2:
1. Add TE bit polling read to ensure TE is really become 0 before proceeding.
2. Add Reviewed-by tag.
---
 drivers/tty/serial/fsl_lpuart.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 91d02c55c470..6b2f3a73a367 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1484,6 +1484,19 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 
 	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
 				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
+	u32 ctrl;
+
+	/* TXRTSE and TXRTSPOL only can be changed when transmitter is disabled. */
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	if (ctrl & UARTCTRL_TE) {
+		/* wait transmit engin complete */
+		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
+		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE, UARTCTRL);
+
+		while (lpuart32_read(&sport->port, UARTCTRL) & UARTCTRL_TE)
+			cpu_relax();
+	}
+
 	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
@@ -1503,6 +1516,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 	}
 
 	lpuart32_write(&sport->port, modem, UARTMODIR);
+
+	if (ctrl & UARTCTRL_TE)
+		lpuart32_write(&sport->port, ctrl, UARTCTRL);
+
 	return 0;
 }
 
-- 
2.34.1

