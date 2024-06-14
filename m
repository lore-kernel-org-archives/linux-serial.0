Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E5192B9D;
	Fri, 14 Jun 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355823; cv=fail; b=O22vh3emDLe4z2zJBZMVxPezUYiiLpWZjvJUzSsTvlZY8vxsXEWFwxCwnddnjksMeFHOdV0OmjkyHPe69Mvdu2gY/ZtrmnibVNR3kHN6OAORwv2SEyNuXNlBozVByjvg8/nD35MOFpSpxvJsJcOHGqYsGo8+iEDsztWrh6fenso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355823; c=relaxed/simple;
	bh=u0zAHyAxW0ArytTJpmDP69GWog/xFGwss8Kv0Dz+f8I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kLZLkczt7w36N0rSdT8WhxcFzhoJtG5n0h7viVSSu2ZIA66Ic0xf3duKN5VfZT/QGEkziIKODiHqg+O2jSa04rx6OzfYIvMuiJMglJ3CWyeq0Ql5qMN0/HvseNmdrX2QU4P6r4ChOQq41k8WIDCpyxaUkZyzh5oumaScD0fRx8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=aCtzUszt; arc=fail smtp.client-ip=40.107.255.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="aCtzUszt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhlDZImtZgs43UlWQGoYMvtbx5uvkS7ushLNLZULuqKDqRGVAimd4Z39qeS7oOOblklCDBQr8L5fkHfLp+vfcYdkDRy4qSxGA+xLYIrVtB/PO/Wrs4Z7aiRSChTA/bkSJAOQUGs4llpdudFmNaO0vdbnzWzVK/iBGkqopiZORk2bxYCHm8Y0Zpd0Hrc2rBwtvgNB/UPoCvrlld32NRx0cFbsN0Qw56QxMYmUeHVZF2tm+20laLp8P8sVYDKkm4fvCBEzSOf1D/v/E9Ed9yaHJa7Olt6bOB6lLIc6tOdbFbqG//F/cik6+qlOQMOUIRiMY2H/nDPCKex12oRyMTNhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqycyrf5RVtVINt5+f9e/TlA5YTPaEyKoVPmQO0LCOY=;
 b=dnPmydzLqtXGTIDhCFMOhhERpEtUfGIeOSlWFL5ujzsZ9IFQgXbisxO9TK7PizO+2yf9a15lEfwsFpK2x8u80V6urtBhfARJKSowIDQvaABiqRTsrs6bAjWhJLgX35ncv+NBzpDq1LEDC4GyhfmpA8o10ZwDcz53LgTYYvkzKKrheHT0bDIcgZL3UIF1b5KxIfJMPgeIzxWBF4jVfj6Sycy1YZ3j7rE4ydveJehupRk3LNJ4d31DoHt4FnYPy94qWcIahhCSB4G3lhdCCCQPO9b1nXF38jwvJonxUuB31Ny0McdodzZHP57jjsVSYPDHyjOJiiFzJ0my8k5wlZmrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqycyrf5RVtVINt5+f9e/TlA5YTPaEyKoVPmQO0LCOY=;
 b=aCtzUsztIiWVqKQ8NW+Zy6Pjr9Igimq7J5CW7q0bBLmmFCtmrWHEsD60fBMaKmnZOCjf4+ZtR599UJT7aqOkxZb4LalUu4CZtMuaUK7915D+6gCfvy9HcLRLMApj9w0iMtBHqcNzMoCTVrPZclTDClDEcV0EZAiPExSYhz2PSOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY0PR0101MB4820.apcprd01.prod.exchangelabs.com
 (2603:1096:400:278::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 09:03:37 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 09:03:36 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH] tty: serial: 8250: Fixes: Fix port count mismatch with the device
Date: Fri, 14 Jun 2024 17:03:22 +0800
Message-Id: <20240614090322.2303-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0282.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::9) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TY0PR0101MB4820:EE_
X-MS-Office365-Filtering-Correlation-Id: 9daa763b-8278-4e6a-a11b-08dc8c50e032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|1800799019|366011|376009|52116009|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TloJjzoGjIU+vF8gKrlvgShfEqlG4L5N//VI6bWhiArBoNTiBznWfALz3+oC?=
 =?us-ascii?Q?Tcn61NkxSDj/ZkWE6aqZaYfdQO+XV/rn+qYhvnXqzTxheb0ChDWKB3vDYCGl?=
 =?us-ascii?Q?KladVg2jsQx7dJehzAUL1GynGDZS1mZ0JdnvZahIKMCl20P02fU1VbhCdiHT?=
 =?us-ascii?Q?VG7ytL2t71NfFfkgmrCFihwIThZ1pm3Y/33+qkmZIM7PABcBS6c2RbZax5ER?=
 =?us-ascii?Q?d3/xA3gXCOOi0UEx51KPCZBTE7fKtWciJmg4wh1V2AJXD6n1grk1LEp0I6tz?=
 =?us-ascii?Q?h/MVH5J7IHwuATVIRgE9WPHJa0YDDn0QSWStCu7O6pprQefS710vAX5Z2w5b?=
 =?us-ascii?Q?/bvWNBvMQTwBiMsHjijzbStXUj0CWaNWz5b9hxlHldauGS95pNfA7OhjlP/J?=
 =?us-ascii?Q?TfAcFsxcmlNToE6z5SEwVJivS67LiuFRasZhXMXr7B4O018X5iCWN7YRDvuM?=
 =?us-ascii?Q?QnYKps+4wIrRIxqPNEYzRNavsVX5Qsz6Cu9hvuRqme9209gDCJjfRGvUGVNI?=
 =?us-ascii?Q?q/N10x4lpFplnzlEmTq6pIC0CzrctyCBY3wCxKmlpAXbF/r96OEKf/H0gKna?=
 =?us-ascii?Q?eOuav+UUpkGp0NDcrPg27rK0jAkUyToMg/7kIC01dBNByA+M0f2KbPv92UsK?=
 =?us-ascii?Q?b3rya8hOih09a858ET0e6WEyhOF3/NgqcoFd2IrCYrbBLxteWWs638Ht2xxm?=
 =?us-ascii?Q?HmbmrZjObvR9oS1a3z4CjPJv/r1BXpwBlerUqvnZ61/UiCHVDLGhs7NYF35q?=
 =?us-ascii?Q?LaOnY5A6ygfTWMNPeWf9Ke49iy0hmME0uzBxyGFk/f6L/0bZ3elgQZeLKQnv?=
 =?us-ascii?Q?g4m3xuyPSK3d9KoA9V0ssY7E9GwhKYOyPHFuBIoB33KN5eNwm7BHFfRERDxQ?=
 =?us-ascii?Q?vFkm76i6mrc3c8bw62e1SB+v/NrjAFzSkpQeHh+SuFfiNeVKLyqQZTucjj8H?=
 =?us-ascii?Q?yEWtb/A/8ELQPiaWpXrgsO375XnxE6wcATgI/862LEV4gugN8hMF382f/Qot?=
 =?us-ascii?Q?IxaTQJBKbwsoI3EMuST1/66tzqqium+eoLdSgjg/Qc2Q24/+5t+Df0x+XgmQ?=
 =?us-ascii?Q?JOuHeocBoW7GN1niBPY/44q8ElIrCL3YAP+dV03h3YiSnpgQtrEfkhBxB2OW?=
 =?us-ascii?Q?Lk4qGjl3JAEZY1xF3N+WinG5/+5nRd8fe9jjSdKGBSV8zJjeQrchU4QuOfz5?=
 =?us-ascii?Q?QrfuLPBGrcfYc56aNh7R5q72GGuGuqCmH2fBN6fMSPwlXU/TwPtgQAFPjuMS?=
 =?us-ascii?Q?UKTCP5HPnhLnAQHhQ36V1qC0xJHOmJZvGwCUZtvwEyu1bN4L1SNbiuowZHht?=
 =?us-ascii?Q?5jzWuKRKZ6JoQ/kWLT+EBl5WpyvwDFJMWJzJfqItOERA+9KWVF/UpEWlXQg+?=
 =?us-ascii?Q?1QVXdIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(52116009)(38350700009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KBGIIaNJGIZV+HwAlW71VnccvNm1zBtqMsjr/4zDR+AGjDe2uDw+YQax3QnQ?=
 =?us-ascii?Q?zXMRFjHpeQKcXtfYFaI+ciOxhJmBqWng4wqMwbKT2UfyExXoEqIEVS9ZOjjT?=
 =?us-ascii?Q?8soiJupGSZ8XlRCcVrF6PPmdpwBxh/DYypiIYQa7LKFMfbPUsGdUuTlbSigx?=
 =?us-ascii?Q?xODEhPwZvGMHCCcxBHJwTS482NBuUPLo5aCumPUcjvw+hW4RIx7AnSY5lvme?=
 =?us-ascii?Q?+eJMcKt06VXxfrusdJPoFFDZBF4CywE7g0xcz9Bz6gtrglldXpLtll1sZk+A?=
 =?us-ascii?Q?8GL8SagvQDC7TxrIB67w+mO28N5NNqLgiXtangV1sw3yR94L5bcVlCmm1lQL?=
 =?us-ascii?Q?t/KnQD5TchKfdHJS0FUfgy/spREdwfaVZfmDOYYblQmFOINTZ5JGL1HPVKMU?=
 =?us-ascii?Q?fNavDsrBIuJfWROKim2KVIqbZ2FtEcWH9YgZyEj7lG1dGa4GA4tgRciO8Btj?=
 =?us-ascii?Q?50qWNEYUrePEQw8a9om8NcQfODEOWk8p9/KnKKKklFGxNj3BNdOQ+S9JKNiN?=
 =?us-ascii?Q?w+K/LyoxZTiSk3fgkU7+zixrZyy3LhiOoPj3wX7fuw1wjH+TDzR3NW42zu5v?=
 =?us-ascii?Q?+fGqvVkIxLJblxKwxYIiFlAAFgLgQ2FISztN0cs09hJfE4vcgWHXBlQ67B3z?=
 =?us-ascii?Q?413Yej25KU2AvErMR9sgmp506kDWhN4ml6tfe6FUFNlHeaz8WUMm+1dQvMa+?=
 =?us-ascii?Q?oLRzQ5V37Jk1bvpmYYciU/qEKIJ7WmjsSWELxeUrQRyfN5McepdnJgE+E8Xs?=
 =?us-ascii?Q?4o5gdRVpT7pj2nTTzplt5VR+NXpXxDxvD1f8ACFZsxNlwPd2hLmg4IavDMbU?=
 =?us-ascii?Q?SzTCyF9GHCWybVJJ6wBUdWOTdTV03I1Tivjby1oC/YAstuhJmmyt4CMNtvnI?=
 =?us-ascii?Q?ciBVm9oAM1XzFXNY5XBJMsDB9H/Jl4CHWEdkZESFALoEEHWbQONxOZxft/Nf?=
 =?us-ascii?Q?8DTcuJkGciiO9shuuwYhigplrcoAT5GSiA259EECXzW/P3z4mh22M3ul/ZaE?=
 =?us-ascii?Q?Zgon2han4HCJwsbC5M8hW+/fGvD3Bqp5durCRxoWbqldOXDTBb3fgDHXZf83?=
 =?us-ascii?Q?3tn/vzDpwlca1OHnT4zUNYWfVZhFKfzglrdmip/pavhiCVveGGscPF4looDS?=
 =?us-ascii?Q?EHOdVyOkhc7sQA1WsQZbHe82WOEtf0AN0TP3fKaeAMPTAKiJQ2Lm6buXMX9x?=
 =?us-ascii?Q?twHbPVsSKI4y1zFgJ5dCoOQW2D8zgO83Xo8y+0UUC5a9nxgdqwBwLXKSPg0y?=
 =?us-ascii?Q?JUQArn9QaczxL30g0l3EadqKNj9gP5XjGJSLcj1rxaD3AQMUOzP+EaqOcJv6?=
 =?us-ascii?Q?kU5vnJ9NcNc/GOknr4X5W15Pz/it/BGcWR69LLQCxuFoOwDMNiErGIjdO/B2?=
 =?us-ascii?Q?B7tjku6+6FR0qjiNlIhiURKukKLQM8mOxYM5G7nxKy8oFEcV+jhsS4yA8Jrr?=
 =?us-ascii?Q?RZ0aRZzeEPdCUUg8yhZjxPaQlshCtcbrl+wU/YIgsWSfmJfkxnrAMFxuY6oo?=
 =?us-ascii?Q?b44+jF0SzOZY9ftp86phyCNSQ8mNP0IEy8qyKt+SZ+ESyI9Yn/KEMxdtbLSZ?=
 =?us-ascii?Q?Id803eiXcIi1dbOj6w2CQd5c5R4ud2o+Z6l71C+etxVsbQTH/Tep0pDi3CYO?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daa763b-8278-4e6a-a11b-08dc8c50e032
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:03:36.8282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOzkTxPnzQ0+vCSH9njCmckg30pRN3mmTxTfP8LoyAWKoPMMtyVPwkllgCnK9+wkixqaE7NYOtLN16eLhjvvOJJV/WDZ8f8DxGc74FeUwOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4820

Normally, the number of ports is indicated by the third digit of the
device ID on Moxa PCI serial boards. For example, `0x1121` indicates a
device with 2 ports.

However, `CP116E_A_A` and `CP116E_A_B` are exceptions; they have 8
ports, but the third digit of the device ID is `6`.

This patch introduces a function to retrieve the number of ports on Moxa
PCI serial boards, addressing the issue described above.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 40af74b55933..e1d7aa2fa347 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1985,6 +1985,17 @@ enum {
 	MOXA_SUPP_RS485 = BIT(2),
 };
 
+static unsigned short moxa_get_nports(unsigned short device)
+{
+	switch (device) {
+	case PCI_DEVICE_ID_MOXA_CP116E_A_A:
+	case PCI_DEVICE_ID_MOXA_CP116E_A_B:
+		return 8;
+	}
+
+	return FIELD_GET(0x00F0, device);
+}
+
 static bool pci_moxa_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
@@ -2038,7 +2049,7 @@ static int pci_moxa_init(struct pci_dev *dev)
 {
 	unsigned short device = dev->device;
 	resource_size_t iobar_addr = pci_resource_start(dev, 2);
-	unsigned int num_ports = (device & 0x00F0) >> 4, i;
+	unsigned int i, num_ports = moxa_get_nports(device);
 	u8 val, init_mode = MOXA_RS232;
 
 	if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232)) {
-- 
2.34.1

