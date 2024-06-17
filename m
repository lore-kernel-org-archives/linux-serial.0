Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999F54907;
	Mon, 17 Jun 2024 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605876; cv=fail; b=p1FJfNr3oecsghZD2E4xXAnZNXSoLhN94mY3+v1dP0VgAZ+gnPHWXGxiYQXUGqsxtdxFpCTcaiBnobvOn4wAzen8L+Ackp9TomkQaZyWlqqzs8laNg4b51j9ay8u0aDg0d/v6zwSgISHpCWwMCWp55e9l9zdCEWzsqHOz+Moc2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605876; c=relaxed/simple;
	bh=cKW5OU+mxedd7gngim5CjJobY6tZJZKXADuNAeAO+bo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DtquQMEGIh6aKENfOAKBJQtydVltFh1QLJ5qoILBxbdcbTpeTdrA1JSOPW7OAoej/3LkrSlKV/pno6jbsC5ejq+0uHcF6XDUAqmsH2BQs27Gf/2h9LI6Ej1EbHJZ1ZMYmugRmeUqMa4V7YJHcsvBquTeGA7uNaeSKWK3QQ52Vg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Dik4C6z7; arc=fail smtp.client-ip=40.107.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Dik4C6z7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx1F5TWEparfd6tw6b5pi36Vw8hUKIVg1IvYYsAIo29A78RUHcaEDxeNgnJEgw//19MyzDo9H7ytL8yktsyfutt1iQkPVY1eGYVIDiMahtm93ywoVrHLFbhDyIgmQnzDbb/NEV72T9X2a2/bqgM0IlDzGhn688cc6UB0IWHtiiUcn3K69UWqX1s/Zb8vqGQcCGAwaApc7Z0NgB4jfepM7NnSnmzFscGxWxqB5I4epyi9xIooxC6V0ceB7jV1wplSGCegFEYqPbaFbVNY3BDF1f7wLrL9nVqtIdpN9D8WEgyN+0J79BSYEL0xkXtwZq1dVENTQrUmC6tkrELZNZP2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HqkOHotCOKWJgYLnUinpLWzaawV1Vz4bq/PLVxSC7Y=;
 b=hLrmsY846RRvNMVzy+KuHaCaDxcqu4Jg1ZPLBTSdsNm3Weo0ADliPr7bw6ZyANzI06SVxcQ49OSBD7il/b/ASB/bLoZeA89S3zhgBiBXBe6WgLw7LBOJsK/yydmYJ/ZWNDh+brunAxb3rHU44qWsb4p5+opN0ktAsFZ3KH2VvGy2dCy21l0ZXmrepIzpjjox64mHA+X1qTBdAHOpH1uLYl72Giy1Q71xJgtMdowt+In64SwuNyU/hrOWpBFCtwthmZi80iyHRKu49Mvt2Cv6uENrs0MM0Slyp6FRSK9vXVwpHkU+R+Vk9IASpCVMDtXNQgLhBhyNHHk7VzNnrvrWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HqkOHotCOKWJgYLnUinpLWzaawV1Vz4bq/PLVxSC7Y=;
 b=Dik4C6z7wIq54rvNHHRjnJRtNjIdc7vB/gH6q5EUyv7bjRiZ5wYbPCEywbFwThxTDMmVXkqhlKmdsES+9qHoc+W7uC9E0SsL/psO56zvW/4yv9P7o+GXOpwcmdEjnuiwQmnJhwb1CiF+zSMA160/lmPJdrNHzQZIdF/hhAo78p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY0PR01MB5409.apcprd01.prod.exchangelabs.com
 (2603:1096:400:27c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.22; Mon, 17 Jun
 2024 06:31:10 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 06:31:10 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2] tty: serial: 8250: Fix port count mismatch with the device
Date: Mon, 17 Jun 2024 14:30:58 +0800
Message-Id: <20240617063058.18866-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::34) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TY0PR01MB5409:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4b869a-2bfd-42bb-5350-08dc8e9713a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|366013|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LaZFfThgaKL/LWjegPAAFzApuWJ5Zmu1IqZe4tA0Ulgm9cppba5Oqe65IVxk?=
 =?us-ascii?Q?A7cwAfV/C3QSyqErOkVjdKwcOZ3obr2IyHTp4z0wphUEyuupH3amwWpiirsQ?=
 =?us-ascii?Q?9IRhSDWmseNH+XNda17aXic60PaxWp9lIwj2ABfT/u3onAKH1RnCAOiaJNsm?=
 =?us-ascii?Q?n9yLDcnn50N9RdRD6qd1tgoiC8XCimAgjz2WLk+r2a8U/SS2XYRs+MLBZskH?=
 =?us-ascii?Q?grpqBUJpTTuMLs+0QxabJk2tB6mgsxHprD1cHGhpafF6q2IFIF4bAQhGS8WJ?=
 =?us-ascii?Q?H6akXDXF7KhYdfZ+SkSQiBjEtNn2STEZG7ecMdBJNXxX2Eb261lj2ytBo9YC?=
 =?us-ascii?Q?dDIsL3TFTduE/8bUaSoU0Qc7jayfolXfrgzNPimsFsF4U7lfmmhIDg+hYJTq?=
 =?us-ascii?Q?Cy5N8ebsThqJt+dCxC6mLjfezJZmYWAhvlu9bn/11zxkf7gqYmEyiguGxoPw?=
 =?us-ascii?Q?MJgr7KvDVxdwo/14ra4TLt7g8RDosO/XC6IpJbgQ2bKfWhDZd7E32HnYYqeK?=
 =?us-ascii?Q?IT3d/GmPQGfdMkV/j3zTK+nYq+vebhuutMuZIWnDkKtXmxvpaljaOD/+tz7M?=
 =?us-ascii?Q?0YQ+A03r0xxEFTvmFVdQzMjtyaaPK2VpPwzfDYbl5H0NWNL/+BKT/LJ5i725?=
 =?us-ascii?Q?J0BCPtGtog/kqUAercXQLugE6yRk/e5DL4obfqA8xJnZkuC1C2m6Hy4tmkbm?=
 =?us-ascii?Q?vyB6+XYQUJd1Q0556Zh2Ms6wfjMdG33azIhg9GDzKKy37cnGpL9gykKBzs/7?=
 =?us-ascii?Q?ICJs1Bj18FI0jwk+AQ0KGxXM3+a1M23ucVpH6sMCMwG+htlVuqzfylBqFxNL?=
 =?us-ascii?Q?pf78Y7sfGj8Pup3EiHwyguiTJOILS8hhTg9oEPwr5sCxe7XTY422ddJmwRj/?=
 =?us-ascii?Q?ZRB6unmsqt5cm/qjEAMvadGrnkIGwhC990Wf9l4wESsIaOLYeWZTLP9Qu6OF?=
 =?us-ascii?Q?69CBcVdKkzUQSVrlEC+rgmrfvGWWEdgJtxdgLlV6QLRlP5Kb+WPiN+lV1rwD?=
 =?us-ascii?Q?uVJq6zTxCzPIfdE3M6SxHy+pSZtLfNy7wqfRIuH6j8vcObdAvb2B/bI/Geh7?=
 =?us-ascii?Q?DpvvvDsqC75Q8z3f3Jck+qtxYXWce7gMEGAMJCzh23DIeZAAGSgBrCKoGe6H?=
 =?us-ascii?Q?7FVdjW6X3x9y6ulhGdcU1fdF7mFDTsHO+2PQVBZ+JvL3iQPuUgWO0Ajmfm3K?=
 =?us-ascii?Q?j7vF9JeM9+fXo0tonyDao9xuzF0fIq+tJr696YcnT4/1MsJFoTZmUV7AMHwN?=
 =?us-ascii?Q?w6sNCdkis5j6l7WU+GHwszOjdOaCnoGCGJq474/EWOItnPb/V5/SImO1m4Kw?=
 =?us-ascii?Q?9Aq6Lovx/0HyfGROdN9+1SwPGty0G7IhRxkSdc3IHa1cJY0/DHDEBXXTk1m4?=
 =?us-ascii?Q?bwg/ww0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sX1oJDNdB7IzS61ZBaJznh/bMHScBkceItZ453YJIC6zUHftFppK/ANXSmPP?=
 =?us-ascii?Q?8M6tcU7/MivlXX9A5v2Cbv06AN/rwuHmZj42GE6gnIuISngPWmAA4hyTfAw6?=
 =?us-ascii?Q?szBiJ8cSASUapugPICLf8oTXzs64cJcHH3x0jShnsgT9qxivj2k1mHS+oPvd?=
 =?us-ascii?Q?aVoqx5FT17YIdGIjIo/Nbd6X0Wi0/kf1Vvrmsyolm/LJC1TJazIZ2Ya3cufz?=
 =?us-ascii?Q?EBaK3sd5PElTK5VffLaORQEFzAYKNxx5fS+vTIW8GR8Y9thI2u2ZQF3UulmI?=
 =?us-ascii?Q?zTZHRewjRMNmdL8SnR2GpELClseuAMYEQR7kBK3rTACw33atU2eJMeeyFZ94?=
 =?us-ascii?Q?zXRikxL6IECn+HX7rHAUgbobnzrFXyM/PCzMSkXCvC2EXAOXmKRe1PaeVhF5?=
 =?us-ascii?Q?vOvHzIJ3RYb9HV0sOsds/JLRfD6u0Ftyz+x/3PL8+ZJ+y5yqHHMg+ix6hMoQ?=
 =?us-ascii?Q?LohUbbuRnSBt9ODAyCWt3NIEQcA0QBshkg7AJRlvGqSKuMaAc8hjsWSzHmSz?=
 =?us-ascii?Q?+mX63BOZk6JOlpzMcBqvkRSfe5K7tAr+F89KSGxfoqN9szINeuvYWkQHdxb1?=
 =?us-ascii?Q?nc7SY02mfGxr/Pey00qnLaOusUcRczOdReMBQDMpD98q1tnh419NjTiBkHlV?=
 =?us-ascii?Q?dQ+N+vPGi39TYob8c3cPf5YwHD1eLPH3VU9OShEvQ63+2XhwxH1fzjM1X3pi?=
 =?us-ascii?Q?keQ+c/XrEyVpHzvpcXp8E2FU97UWo0Dx1JEQsGi73px0dwDry5XnVmcqxwii?=
 =?us-ascii?Q?Yz2zZB+usXxeA6jhyV1n2gi7TXvdkAZzXvgOyQ/ktaKZf2sdmrat78oeswX+?=
 =?us-ascii?Q?9Q6Tn3njSiGPsp3ksKtDo5ekGtqW4USkf2Klufa3xzF/uWxi7vKPvFXz/m8U?=
 =?us-ascii?Q?pSpS12DFbVWDo4D13vGJ8dqZjckWxGd+Y7XVelY+ZNSe5BqWhG80AQIJ50Gr?=
 =?us-ascii?Q?bbutL1hdjjYCgxhKRvv8zKC8DLsK5O7BScvRHbYy+4vpvj/DU7BmUiyHal7P?=
 =?us-ascii?Q?uqrftNYgKg5LJaYyOU6u/tCp6Cgj8brjczOUrt1a+xJ7qMQvKrvLlptyKqJr?=
 =?us-ascii?Q?SQ992cSF0lk/N1sNLvDX4F2rEUgdPMIck0QzdOwcWVI+MjHGwdUcUnpYdaQ+?=
 =?us-ascii?Q?CtY0mPBYVmDikmxUVfjnTX5Aszh+O0hizRxFm2iLOHv2SqDuipUWs1iV9iq3?=
 =?us-ascii?Q?FjTY4KwzJRgdWsyVmGATclkXu9F7xAGNQNkQSyPg7ep3vUYIJUlZn10LCgyR?=
 =?us-ascii?Q?EtYrM2/zvV9eheyyzrI9MFSG2y8GYzFMRqxCNFHwvAbXtaYjP2qT/PnlPPAq?=
 =?us-ascii?Q?zSE8ihvx4O2vE1flDwpoe5+DHIYHDYZfVbePWhqfBIIheVwjw+0r+fFMTCRW?=
 =?us-ascii?Q?mdrPnx4UU6eQWbArfKjih3DROU4JMuJhErHEIO4LL6c4NJns6h8Xj7wVI2bP?=
 =?us-ascii?Q?I3O4Tx7WRoHreEUZup+mAB7E9hIs/lq/TJSNzERZ5S8UYG9J41942PIIiGue?=
 =?us-ascii?Q?OXaFpmM8a1CwSVsiacQspCG36NTvQ7Ms5xqLYZvYiWNOkbolpKNWRxrwp0wD?=
 =?us-ascii?Q?Re9gvkXis0QPmKHZF/TzcAsw2A9/CGcpQFxNP5+Xd9x/9GHsslJCr0zi6kTe?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4b869a-2bfd-42bb-5350-08dc8e9713a7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 06:31:10.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa9lAU5ZxRboR5vhlg0l8Sutwd8ZRFkHH992/NYYf8CnV9Xomp3Yzq3r3+cZJ8qPKbzd2HAjQNGDOjqSSAd08NS3hqKHSJ5AE2O19TBIBrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR01MB5409

Normally, the number of ports is indicated by the third digit of the
device ID on Moxa PCI serial boards. For example, `0x1121` indicates a
device with 2 ports.

However, `CP116E_A_A` and `CP116E_A_B` are exceptions; they have 8
ports, but the third digit of the device ID is `6`.

This patch introduces a function to retrieve the number of ports on Moxa
PCI serial boards, addressing the issue described above.

Fixes: 37058fd5d239 ("tty: serial: 8250: Add support for MOXA Mini PCIe boards")
Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>

---
Changes from v1 to v2:
- Add the "Fixes" tag correctly

v1: https://lore.kernel.org/all/20240614090322.2303-1-crescentcy.hsieh@moxa.com/

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

