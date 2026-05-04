Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013056.outbound.protection.outlook.com [52.101.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF03290BA;
	Mon,  4 May 2026 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884583; cv=fail; b=aaQGjPykprRZ6GOsibbfGkrwr6ldiUHo7XtK0RmuXA81KtEt6ZrcMQrPE0bbJAGEn0ivoOhwVdBcehhY/4CtBZ1hyRhEJBOWjvpxtQVhoMbQTlV/3vMgLmeMih3hHHXagaGL3t2bP3MNJxgf7pFJ+4/l/q84R6/f4GZBDX1C/No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884583; c=relaxed/simple;
	bh=83X87eWQkGPHznMHBP4cG8SpWvRkQgDS7KUtnQ1kGdI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uNzZwnjEL9HhilotmjkBLuvVKA9u/9X1IgD0hWixaEJmGEnONE9juJBCnzUzIE4HXT/arzq4ZfXr+SepMUhdjC/olfisTRXVej0bwLV+yAQOYXRRNtOSnDeVkZRqdv0sBbPaVEyncyXG1ZkrG5shcCIKaeVUAejIoQtSSPj2/mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=DWULhoau; arc=fail smtp.client-ip=52.101.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="DWULhoau"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJiatU2z+pBnBtTHm1/8HaSh6FAnFpqaepmEBvDxWHGFgVFsDKrlMf7IxPbRPM5W2LuhFJLXA/mTpd2uD6gcmFfZJ+C/HoezgCOCj786/br/B2Uwp6tzRsmAtVJIx0ATCLuu67WPLrEAlco+Mk/AmYInuS2jH1zs6n6fsSWID8fFFAyr05nDSRAznx/spUBftJ5LBmrzHiQIEnP7Mxr8/tOGh/15WgIX3q92E9Q5Lz4fEBYi0UKwFXjobgAKI7DodBlKugWh4mmOpUyl+lBbtOyflccFm5essYA16joMl9tfsIC0X+M2BP5/az4aYDmUJKqyH8y1S141+tuSNZ32Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uozyx3D3c6zhGL2fFtUle//qN4Z5nxBeH29V0CjW+H8=;
 b=BgX1NuETG2elFoHlWOaYTOjxDRS55r2nPtgqbDByU22PJ8l0NFv/ClNtnF7K8Hi+fx2pHKNqcy1siboSazs7U9XcqmB9qHmgnK5b4tOT2tbPgg5c1kxmmybgb3tgA0YDTlz46Mr6C66G85lgAKYDRyrg8d52zW6l9VBnMZIHJqQ5zTtuPcucDIBfqT5/2YR05O9+4MJCJPScfZreleiFbTTwA+APUX/zERtTqj5OaG4pr7a8wOumwMa+Xh6U8T+ma3T9LkV98D17Vh8laReBLUOe3sg8590Bfxq+Y1+CySpPphChk88zs+/BO0Fz8wZHRQHOs+g97VbT/oxBjjuo8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uozyx3D3c6zhGL2fFtUle//qN4Z5nxBeH29V0CjW+H8=;
 b=DWULhoauy4eLDIILe3RHlAbNLAyvka8bM9YEePWA9/NhR2hxCcf3NHr1WtRVAlEl7BFVm6H6qlESDq791IYl/y+kNLKyoubRrEQ7V3P85oQvCUG+853PJULEOcB4AHHNmz2HYP2pM3Uf0Wpff5HsanO6AzmxAEj/Ss91hJi47jU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4329.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:49:36 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:49:36 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 00/15] serial: 8250: add MUEx50 support for Moxa PCIe boards
Date: Mon,  4 May 2026 16:48:45 +0800
Message-ID: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cba8d0-5486-4cf9-cb18-08dea9ba11d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	AosSp0VkRdh8jJKlDFfawc4WUNfPIdsuke2SxJHI4I+uDySGZjjrXK7r3jH7Ep1hFYk4X9fZNwi4Z0EjBzskGQLhTrdGZe4dZ73CO4Ceqb2L+zKj0o2rRzq5kcgFFoJRCPUCoGQg4P6k0FJ4doKgQ5LBoBPidXDLIQAZd3B2PIiWKZ4yCRsg7YtTXQHQz1nHHH7qxgvlAwtIE7ULzHQkbnmOJFPrFPsX6cUpZ2V8OwXSVHazJrz9zH0CcLDS/+ynYXj/NAaz7ojasJBVjQVv7vBiR3rHOZu+AqDGovTpBDLdrPGyhz+4Up5Zi7let7ar6oJUAS7gIjq8wRBsXjroqcBku7ez6b0seAU6zqS6WHnG6qWtKlw/7vkAouxlP0CmC5OwaaT/vY4OfLXlwtHvZQsGneFQ8rHL47l0tGhslW2zg/B3Cc9FLtewYmUbef4x3dbLNSlU8Iv0R0PGYiF/6HoXHqwPqhoGek41MeBqqcb+0cKECLcFRO/eVfLRWsLDGtMZtQCZBleQ4zPBDAqPdWlpyyqpZ+hgq5jQ/ESNymLSNYsyN1FFn2v/ERHPeLh9fxXan2wtr9ALl68PN5fdMlfWrvspqhPjijO6BxyMQGxI1cpQ+PT0zN278M00vdJJhpFlL6GN/TEtd8/x7KxpyMdWM/hWCj/CvH7wIUev7kQN2kAvx2876DVtcPGL0xBAs88d/umkCezwc82vwJ8cVKOQIbqwYOqKSHGMrwyS4DXZuoezrcP7MyW1zA0mHZVj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?elaaUDqy8pXg5PMjw4fTf2csIUGZnEKPOfrG/fdK+NYlR4ifkM4aqTncs56Z?=
 =?us-ascii?Q?+x5sRng6Nd2TQumClCT0MXrsLmYpwV1zvuNffsb48KDl9pAFAEKWOzprM1H2?=
 =?us-ascii?Q?Rlh4nswDn2iCnKpqTC7N0civdvPO3SasCvJywSpWyWTuuEdUn3x7rg9lGf1m?=
 =?us-ascii?Q?WuPR65/IcGRNqtmB/CgHl+fHSi7J7swgBfH2YN8zdPE2oIUMcfdrp1Z8RidG?=
 =?us-ascii?Q?Kanl6WSr1yrDv1Jv7aUhKIkFqkpIT+JVEdBJBDFpqYbg+DNdyscD7a7l3fPC?=
 =?us-ascii?Q?vdCcZAifynetmTAa6f8bEJ99tj0Pt7Fpa8P5zpyQULGK4rBWMbns3P3CVlN5?=
 =?us-ascii?Q?2nPAOw/oV5meCcl0swQ/ABMxso5KMVZvmWKquo9C1e6aDyJ+PJRAQ1pkadC1?=
 =?us-ascii?Q?qhHbjAfGolGS/KWgviVpiknKbirkHboU13RB3Aa4ngoLO8IWUvegh2PzydOm?=
 =?us-ascii?Q?d1l7prvDQxaBUsToyYF1OTg9DIkHcbD/0G9wWDbs3bTZ2Mo8GLQnQZtmMzt5?=
 =?us-ascii?Q?fkQJTm5hxXu6hOUMs+q5P2nhFLZZMWX0o1bVvQKSClbt4nV8n/NphGALMuEt?=
 =?us-ascii?Q?GrJYcliDTlFKTWucBw4MCagnw9aXp4YSc4cJVFPLj2RZuCez8hPFc/SWef/d?=
 =?us-ascii?Q?dh9DhMaIAfN4lnAzGnZk8sGzafajOQtq3VV/2lwSY2dOGeFVyeqFou1u+JhC?=
 =?us-ascii?Q?1c0mn9zzR04YJLh9yNrLzxxj0byqzy7JSzRpJu8V7YzOZA1zxnSLfQWaiFW+?=
 =?us-ascii?Q?uAXEZR8iNnaj9m5wU8t+75gYEBztV1GgqfkOVry2B/zohWko6rtDpYWwQytG?=
 =?us-ascii?Q?azeb9EofRsuifc5GV3C2PCC11RQ84DILdo3CGLfLhrYXKcLLoIFrrK2O445X?=
 =?us-ascii?Q?7tmELo+WG3gCZYZsp5Jzok1rZtk1bZ9TQ4GGOFGNP98xFp9SRtj6IJW5nZVC?=
 =?us-ascii?Q?XZKhuPiptDcGsvUbl8zLMVc2qV27CGYlP4ol0uEJYOgwWMWGI0Fxqz0ZX2d5?=
 =?us-ascii?Q?qqlwjQ2Is+YxGEFOWQaY+am44UPfh2/KccsJQYPNWBYuzitRaTvYvkIpk4We?=
 =?us-ascii?Q?PmnRUxPTJQziXpVp83q1zQaEX1hwJH3ZUvrFWtdT5X6FhXRAJbQmLO521QTW?=
 =?us-ascii?Q?5mE55/6ffBVqnDzz67rfYjsHa2WD6hblP2PM6kmcb4MKxCdCBJgFAvNnnaeF?=
 =?us-ascii?Q?nGZGCItf0c66w7eNy27cNijEP982092OaePdQcQf38unAS8JAeSKZnYdCh5k?=
 =?us-ascii?Q?B0x4RpcVm2T02RZ3azpkSO26sLY+XtEXLdG6FVzRusUvKidH/K6GsC/Zgobm?=
 =?us-ascii?Q?WbkoEGgkx1+kf/tw2QQKYk1l0v7M6irU2iJi2yNU1RjBI6DppbOWfdNB0bWP?=
 =?us-ascii?Q?o46bP0irEt19un7R+llUoIJpfLxn4WQIVLKhrMzCCcpHLEiIo3DEXzdw0A1k?=
 =?us-ascii?Q?H6fbMZxqlWBzZuppa95BD8XZ2MnX9Y5n0cN/yL8tle7/cOqPKiQpVsXT1toe?=
 =?us-ascii?Q?IRGHbYuldW1b48TNHORjsEBa3uDXsOs2GJUjBNJ37zY9W98Fdg7rNCwOEnNH?=
 =?us-ascii?Q?0AoIR0jfNWf3SKrCxpQfhEe2RaPkVTu3bWMK/S5GPora1X4RDcWxy5sMzWx4?=
 =?us-ascii?Q?TbYmzjth6HjQ54sCx6FQM750MnVfxJMoLVi/rfepc5u1IuWvZwcsj8G/6WAn?=
 =?us-ascii?Q?Hqjo4PR9lTYCE5fkhIZ3ku3vCowHlEkrk9dz0HES248D+5EIey5BzeBuFkzX?=
 =?us-ascii?Q?mEce6uLQXOSUGr+riHHHF5ykFh8n3uY=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cba8d0-5486-4cf9-cb18-08dea9ba11d7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:49:36.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRppVu9q0LbRTpq3+ZHyiZWSBA7VXGH/3jN0kHUM8pfbjTEl08woi0qyTh0n4aPNK8g/YdQw7L4cP9nc2HZEPETJHgIjdN2PIWPTtJQThF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4329

This series moves Moxa PCIe multiport serial board support out of
8250_pci into a dedicated 8250_mxpcie driver, and then extends that
driver to make use of MUEx50-specific UART features.

The split keeps the Moxa-specific logic out of the generic PCI 8250
driver and makes the follow-up changes easier to review. The new driver
continues to use the 8250 core, but adds support for MUEx50 features
such as programmable FIFO trigger levels, automatic hardware and
software flow control, interface mode switching, RS485 break handling,
and FIFO window based RX/TX paths.

The 8250 core changes in this series are limited to wiring optional
low-level driver callbacks for break control and rx_trig_bytes
handling. The hardware-specific behavior remains in the Moxa driver.

The patches are organized as follows:

- split Moxa PCIe board support out of 8250_pci
- add the MUEx50 port type
- add MUEx50-specific driver support and optimizations
- extend the 8250 layer where MUEx50 requires driver-specific handling

Crescent Hsieh (15):
  serial: 8250: split Moxa PCIe serial board support out of 8250_pci
  serial: 8250: add Moxa MUEx50 UART port type
  serial: 8250_mxpcie: enable enhanced mode and program FIFO trigger
    levels
  serial: 8250_mxpcie: enable automatic RTS/CTS flow control
  serial: 8250_mxpcie: offload XON/XOFF flow control to MUEx50 hardware
  serial: 8250_mxpcie: add custom handle_irq callback
  serial: 8250_mxpcie: speed up RX using memory-mapped FIFO window
  serial: 8250_mxpcie: speed up TX using memory-mapped FIFO window
  serial: 8250_mxpcie: introduce per-port private data structure
  serial: 8250_mxpcie: defer uart_write_wakeup() to workqueue
  serial: 8250_mxpcie: support serial interface mode switching
  serial: 8250: allow low-level drivers to override break control
  serial: 8250_mxpcie: add break support for RS485 using MUEx50 features
  serial: 8250: allow UART drivers to override rx_trig_bytes handling
  serial: 8250_mxpcie: implement rx_trig_bytes callbacks via MUEx50 RTL

 drivers/tty/serial/8250/8250_core.c   |   6 +
 drivers/tty/serial/8250/8250_mxpcie.c | 691 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c    | 208 +-------
 drivers/tty/serial/8250/8250_port.c   |  33 +-
 drivers/tty/serial/8250/Kconfig       |  11 +
 drivers/tty/serial/8250/Makefile      |   1 +
 include/linux/serial_8250.h           |   1 +
 include/linux/serial_core.h           |   3 +
 include/uapi/linux/serial_core.h      |   3 +
 9 files changed, 749 insertions(+), 208 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_mxpcie.c

-- 
2.43.0
