Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F53081C2;
	Wed, 25 Feb 2026 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002794; cv=fail; b=nygjinaAVEwdeMBesUjXA8UlTWqNOwdYtw8KQnjnrtsIyVUwlzVf/HxHk6TNxjNvEMXNF8C9FSOpiqWBmNkF885p8nGRJoL6y0QGZ8Kix2eDP13RaamFyLCpIl9wVoT9AZLBTDw5UJxrkV+GeIsNcrgTT8h7VXsLP9laQu/7aSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002794; c=relaxed/simple;
	bh=k5eX4Ga4TP2U7yuKpcUUB3bxdpIZ/LM6DYQBdKPXT5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvmiOfTpIQU44K7ySOHRGbQILml5Yi9Q9BTKd1dfeUHCr2Tn2QK07jbVBleUWiNBVeSLfYvjZpGUTcJnLNIvCj1frock8loXHqK+u2a9ndJxqRQ/HEUjPT0+9d26sYp6ok6tOy7kIuenfXzq4mCJWim+PrWyE5kRTPr4H9ufhVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XDwA2mMO; arc=fail smtp.client-ip=52.101.56.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XDwA2mMO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dP83JGLqMIxIqvPht4pi4LJRMczRvDTWAzjiMlR3ErMRZ59sginDHHlaTFrDoi5YUkBDhVth/z+PaPBR9sssoiNk8NukK1VfpXNsB2YzH17ggMuJsDt4RnGRSMDvpaIYYnK+tCoXtoH7dC0xOLYZIm4MH9xUZiT6cQD3rLHoB6pIDYS1x05O27E1SMtXMmaKLBxuIPc0ZQW/lWWNsfuq1wY+IgD/7ktky7qQDzur2k04dB0YBlOYrVmWDhsm/HXtrDJ1WTltI3+m40BgQsmsUluyIgIo+/BmJBqNGskjvlHPcZ81JR1/zhtCTNSFPgxpy0hcqla4274DMJ3RBVBLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmI0fp4WqiOCbfvsh2VCnwz5kdR5zYqQQafVmq9a4wk=;
 b=c7ZAXNoBZPbmC3ZQkLGatZ81XDLfZkienyrbzhRz0ZmSLxnUIxetg9dsccJUJ6g9FS7w67mTDkz2WJVfFJ9ecFsqR8Za+Dj2lmeIN3nzGqkvgHZafwyHV3aQi0nJxFnUGD7un9Jrzgo2ICNrnZSLyYSMuzuXDTofILSodLjloRuCuGpL5CG2wradZf8KlziAV7NeSyJFlUeTgN6adXX4NHOInbU7QjbD1ytHc+H/iIL9l3zBVWpA0VbuixEWGisdtm2jAoKRwMABYSqR055MRovrIxav2JsfDfqjVq5U38Fp0ITFmS62XdVaB24snS59oBaoMri4OuW/AwrkCJTzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmI0fp4WqiOCbfvsh2VCnwz5kdR5zYqQQafVmq9a4wk=;
 b=XDwA2mMOoxxgMmTtmF72NIzIgVKo0+1zMwqvfqcsSnSx3NmQvoT/2dscSqyUdr69dhKTmVud0Ddwl5ul2DLyKt+mzUOJiUjl85FIc21xgE/CWYuaWgNTm57TydU2FZ+ThNgKBUIZa5gQtmzTsWCWVWtW+RNoHyUY88M8ngmlDC3P/5C8u59nXe2h8WlPYRcRS1xRTGYypurwQobJZfSrGEAgZPOgph+kr4gnAGVcZBgvY1iFKlC8Ps9DVgvgnjCCk3OkHc0cYkiQWQdgVpYYfM8bg+rJqb1j+EnxdgBt09Nd4O+LEQTRmbeDVQ72C/TMCclf6rC31ymtEu7li3JV5A==
Received: from CH0PR04CA0114.namprd04.prod.outlook.com (2603:10b6:610:75::29)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 06:59:48 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::e1) by CH0PR04CA0114.outlook.office365.com
 (2603:10b6:610:75::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend
 Transport; Wed, 25 Feb 2026 06:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 06:59:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 22:59:33 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 22:59:33 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 22:59:29 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <linux@armlinux.org.uk>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <mingo@kernel.org>, <tglx@kernel.org>,
	<linmq006@gmail.com>, <arnd@arndb.de>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
CC: Kartik Rajput <kkartik@nvidia.com>
Subject: [PATCH 3/4] serial: amba-pl011: Add Tegra264 UART support
Date: Wed, 25 Feb 2026 12:29:13 +0530
Message-ID: <20260225065915.341522-4-kkartik@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225065915.341522-1-kkartik@nvidia.com>
References: <20260225065915.341522-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6fc96f-779a-411c-600c-08de743b7753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0BT5CPUPVWuo86J+uhGL/mP0OhBuqR9uRjmS6ovJ6fDMOQVZlBMDI6mDdd9E?=
 =?us-ascii?Q?1o+/z7LuYUw/SSN8hFNdyGA0OSKG6owt0D35ekT4N0mYuKlFnoSPF3qeXI+Z?=
 =?us-ascii?Q?aKy1OxZd/HTAEGaPxRYugRgG75DG8IEN23XbPxDPHHfkcSQIJlGDpgHDv+PD?=
 =?us-ascii?Q?XgzPMwh6bdSKPgr+zJey+mQmV37sCEKwFsp37defPH37uC0c5sqW1+gtVRSA?=
 =?us-ascii?Q?rnk6w4+JLLMoN5Zd5s0KuttfA591Iutx/qqGcMRLrG9xIs7je9PIj0OEi8MW?=
 =?us-ascii?Q?rRNqiyiF1x6QRzfMxLCjAzQjz4pzk8FfFfF8jxgd2Pm6Qom1eXt+0KZx0GId?=
 =?us-ascii?Q?DiFZiJwLiLaCjTMbbO62ZgR6u+YCGRbKJNfGvQB0Sw6LjI1jK7G1Ep9aoHiG?=
 =?us-ascii?Q?ajKJ/x4LTyRwiqGTYxOXGy1J+PE7Y2B68JFoCV8e7WaNr0JaCdRzDu/0Nnyx?=
 =?us-ascii?Q?zKk9NmzYwNnWAjL++Wbv64AN6Vhrz2lwigG5uy6ZIqPMRp1bojO67zfqrS7z?=
 =?us-ascii?Q?GQ1B7Z+XNJ/ZoHoHH6HBPvtT8jnndtHHW7ld6A6rAMfCoiSTMi4C3JHifatB?=
 =?us-ascii?Q?B/XOTJIo5/ygBVILllvab7CgnL7eGpEkK6pwu6W/oT/WW2UnZvcwuDT3bEGg?=
 =?us-ascii?Q?kajIqAxzq8Mmi8qnA1nvM2vLS+zDab4hX2upCwrDx8Uwp+fo/DVR9MHhQ9KX?=
 =?us-ascii?Q?2ddN5Wl1TBxTxBY8Psk1gAkK1wU6e2r0Pk2jp9DE0eyCiTHnTgKFykhXKZ4w?=
 =?us-ascii?Q?5rIAZykhzpuANy4hwLAmkoQk8WwxdwopBpxYE4UYYA3LdL4lMbaTPdW/mek0?=
 =?us-ascii?Q?2k4TvP2OLoIGGj6xNVL4rDCxzbeTd4mS27jrltx6Qq2w8hZpFhvzNr0Wn9+h?=
 =?us-ascii?Q?odSIiokHA5KNGYOYXvL+6623hfoQwiaV3G15ssP3y4Me3CkdE5yRAzsq5/zz?=
 =?us-ascii?Q?yLTUNN6uRDULjZ1nUoHmDOY2RdjLBXDfabQZQbrfvWdf2ZWftCfejLCIOGZn?=
 =?us-ascii?Q?RQINSFipOTQzxI7qN8kvDDqE48XDqeeEDgWJ0sB1u3TudP4ab1ZTTyj3Opf/?=
 =?us-ascii?Q?OvI9mTRl56tnwIr/zs2/sYqT4KZR0Fry1t7rHYi0tF2IAAsVypNAVIDx42vT?=
 =?us-ascii?Q?Xer3wpAMjIuEmN5Rk2PyB4utIjPkApGETTQaiVJmEeqT03SsRZ1NcXZToH4e?=
 =?us-ascii?Q?mlm0nE68R8ZifdrRYZ80zl624sNE3FfauoKHcWNHa84wabYDyFkCdrSfcIIJ?=
 =?us-ascii?Q?z39XEO20+B/bp4tS9OMlul4Bnnfe2esy9QY4iCQDuUTwuWqMT4HEZAFs9IRI?=
 =?us-ascii?Q?lfxjYqmP5Yd8X5b8zzJh3RA11l0OH9pNYSPDAhomNVI3iMmRHFXNyGC2403+?=
 =?us-ascii?Q?Vg1WLROIljQaNlrnmbI/qwfh1y5jQTl5Ei1nlKzoWTuoWaW6We8rjpFLB8q6?=
 =?us-ascii?Q?yN8JsAr+GWXewcmaIqUZJAsqjSHthfOWWhF23bO/i732asvjuz3vyeK4g223?=
 =?us-ascii?Q?HjOP1O3nF/SdXci1jwmJT3JKskpz78x/ht3r230lFXAvGSoESbyObE8DG8M2?=
 =?us-ascii?Q?jcERWpmSlea/L04Jg9hi3PI9RbRtJtXEe+tjT05m09jfpESw2fq4+B/SChl4?=
 =?us-ascii?Q?zWatdcl5/E5aqBpumO4w1nIc8jBmpMBkDtGcGnj/ofSslOjaROzWb3hCAwE3?=
 =?us-ascii?Q?wa9fjnF+jrYT5v4VtBwmYnuEQ0c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dh36eSJulBumw/c0AjTvuQSUJPw3ZFH8EaF/1Nn/S4JCi8kIrX2N0SKH9A2fxot6V35UfFK2cV+kW/IjPuBjVla8JoFw0xp9VI9iHqNvRQqpT25gWdmprcuJplJNF+H4gGMJyLxPDV3RLv6M9ArLbdaCRVO5blYG7iPsWhJ6ecCiL40CgUPPvPokCoFuBbrY1iKFogPFelZDSefPErFnqv0rGQGU/CBAFI+hg+Jbog4d7FoXDLRDnhYiIPFb++amETKpnBPPmnmgokorbyUTxslzx987Lm6DNEXRceJuEc6RCiFCJZMTeg+kTN8dVWGQKYMxd8rdmOdKQ//LWsLD3wBsLvuq8RGG5bvpjXio+4A0014CDrTHxas/X8iH+ZUdSIAohIPvWToAQd3fLTesEOsjdALXW1kxJLPgFJpQHTO7yF4JLmrJIc9DQO9vfoRF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 06:59:48.5627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6fc96f-779a-411c-600c-08de743b7753
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130

Add support for the NVIDIA Tegra264 UART controller, which is derived
from the AMBA PL011 design.

On Tegra264, the fractional baud rate divisor (FBRD) register is broken.
Using IBRD alone may not achieve the required baud rate
tolerance. Enable the skip_ibrd_fbrd and set_uartclk_rate flags for
the NVIDIA variant.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 drivers/tty/serial/amba-pl011.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index ad06dc4cdf6e..7f8deb30650a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -218,6 +218,28 @@ static struct vendor_data vendor_st = {
 	.get_fifosize		= get_fifosize_st,
 };
 
+static unsigned int get_fifosize_nvidia(struct amba_device *dev)
+{
+	return 32;
+}
+
+static struct vendor_data vendor_nvidia = {
+	.reg_offset		= pl011_std_offsets,
+	.ifls			= UART011_IFLS_RX4_8 | UART011_IFLS_TX4_8,
+	.fr_busy		= UART01x_FR_BUSY,
+	.fr_dsr			= UART01x_FR_DSR,
+	.fr_cts			= UART01x_FR_CTS,
+	.fr_ri			= UART011_FR_RI,
+	.oversampling		= false,
+	.dma_threshold		= false,
+	.cts_event_workaround	= false,
+	.always_enabled		= false,
+	.fixed_options		= false,
+	.skip_ibrd_fbrd		= true,
+	.set_uartclk_rate	= true,
+	.get_fifosize		= get_fifosize_nvidia,
+};
+
 /* Deals with DMA transactions */
 
 struct pl011_dmabuf {
@@ -3115,6 +3137,11 @@ static const struct amba_id pl011_ids[] = {
 		.mask	= 0x00ffffff,
 		.data	= &vendor_st,
 	},
+	{
+		.id	= 0x0006b011,
+		.mask	= 0x000fffff,
+		.data	= &vendor_nvidia,
+	},
 	{ 0, 0 },
 };
 
-- 
2.43.0

