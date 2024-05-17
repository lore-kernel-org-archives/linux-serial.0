Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2101.outbound.protection.partner.outlook.cn [139.219.146.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B134404;
	Fri, 17 May 2024 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715927609; cv=fail; b=gEy/DIlzoAVtj83MuqC8lwQU//wbhvfWkJ7F2cbrTq+AfTfCp1yvqmE5p1rTckqiYegk4hfOJYnGBAP6B1YNXgbLBnZRMum0IJcLDBdDWm+8x3nshBKhBgiY8V5LsPH/HTl3eXQYOIxAEkBaFk2zvAlraP5uOTxseIHIgHx5ews=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715927609; c=relaxed/simple;
	bh=r2UqC70KrqVWdlWdqPn6KKzkK9izA845qtEZiHrGBQs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dMe3WSytWSvhSG0H8O5Jgxx2JpAm+2Ngw/PfAJL9Cg/9bd90/i3QgJA7pvxBQuT4M3iwuWA3jcaOdlb160vOq5SlltBf3PBaM42UlcmiGhA9v42svCLP1NcffgSHL6TFD8Eg5NzG6RcADmSLUSoSBrtyGDkdORqsxXvb1pc+f0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCODFjQCIsci/Z4lW129bxNA4JNL2Y8qI/Onr3T3sf6Llhhj+/8RJz+1rQy1EOIiBAnvnbgPeMXY02vAn9915kgw+xhXFdZWRFfVwQxtv9ppMsTUqLf+WrErh65VlNigZYrlKtzgJtsdBXDvGwdQ2BAmLAEyAPVZEjwqQpZPTJQ2Zw7svkc3ZPJKiS7gwK7ACv/9cfm1Afm4DqIiIwvb+7JQnTDwQU2jO5e23p3fBRhoGrTZM9GS1wUyCvrZlv0MQTXLiky1sX9Pr7X794k5rrHJ77SsUGexWwDZpJxE+9mw2s9+ZtOL7yODVPKRK6VyCLQludlSQ+3fWkv6BeMSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6Tih7vkpntM2JZIpBPkQty3njo7thVYiUmFvqckrJg=;
 b=Ko4WgYMRK2hAn/BDOLE0APa3DaXUPTtPZxH+NjNIU46YMT8nieWla4I7WnXMHAp5KT5LhOVDBWwoHhx0I6i6gKcvcph1e+tzWqmDaVHfxfmNUU5BC5aKuMJVA5Kbjus6zhquKHaLjUAvlNWf0gC85FhM1YYKn8zZq7UWXf52AzoWEUMlcaH0UdJAu8WcVLo/fGLkB6NPhBg0WYZozCLe5EZFaPtZ94V5Gu6uEhlF+1Doib3H4fBhsfdwElq0slBQOEU12TQOs+u8GwZkPf62CPJIE3sB+1hjKzuzMvNqa8dWbNUjbLJ09o/KjYfTvzEF8D8O7QEfMQQ3zYSql5mYOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 17 May
 2024 06:17:20 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7472.044; Fri, 17 May 2024
 06:17:20 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Add the core reset for UARTs of StarFive JH7110
Date: Fri, 17 May 2024 14:17:10 +0800
Message-ID: <20240517061713.95803-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::24) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: 122dd484-3aa7-4ea1-9d9e-08dc76390266
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hWfM8a5fXU4LW3XsisYOSgk/3HMoLkZZioTuTxgC1pCrju/bhegNAxbrzJmhmufXrfFgvPmOiKmmsG78nzKFR7RWJQDQ/+M/D99HceIiM8LYaCwZCJozKUASjubMyoy/r/DGwYfhr8/MNat+7JL/Y36gzz3ZCwhJro+1wdlEWRIPA5oblLs1WVa8nOo1gXEKx2U9mZ0VTgZxCPhAeB1kwnXko6swoSnQQ4l+AtKBtXdYqUyvIxQWDWqlOmHh2aPxvX/LlSukEJgbVDl+SLdQSGNI+qoZVH+vaP+s3LpxnjQEMA1IkoWRpsX9bEzexikZjZx71nNzT9jf6sQrY7McjCO8JYDz0JaKclq8Ht6SwuOGrSR8rLwktWSARbjGYg6BxlGV+EHcxG5ZpCh3LTwvTOAovGAF5Mw4YODJ+6dPbTOHKT3Rjbr7w/QgedVKxl/uT+UWnSe/NE5v6cgJUI/5eLxmsybjGKqDV0zHdNrxu1gEI1JPQwPSecZRx5oieElqDOEAn5slqoEAmRYDwbOTlwlIIkS9sFczPtFPMKdH2jcMnt0iIMtmyXpVKKuDmOdic3PEUZ4Z596wBTd8a28yhUDa/2tuOiGTFTX6EV1jAgLSkiYGKG4HuetRu1nxfKYwrJ/LobMLf6X4+INFyU3v8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(41320700004)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1iuc1zH1FwWBYrukmDJksmVdpYMt1ZQmHhFYaxzZ5+hMhsnxjothO9cC5vW1?=
 =?us-ascii?Q?zsXqTtzuO4UIhWPHLpnXADvytb0jenFs4TeCf45bniQA6aFLm0Zz8OtNb0tM?=
 =?us-ascii?Q?AQf8rwQX+y4BxI5OrGaqKdVU7NWQZz2/uFBehRG8SM1fZxaKR4JPbCDXJKLj?=
 =?us-ascii?Q?DDSi6zKdj4YdoNDfOIs+eAhn0S7oEqhx1XGBt1osAE0e7dELD+zxpzfCUMtD?=
 =?us-ascii?Q?gYXNOe+lS4yGu4vl4tFCyY2YdKkymKBxUxU4E4pm8dmLhI7ND9Xka1L20RE3?=
 =?us-ascii?Q?xGvnhzHjHIV2HXmXBfdZ6l7KHYi+pwX967kMCtY/lrVzB5SoHnTh5HmZyPWA?=
 =?us-ascii?Q?/9H9bgWA0O/udk4ngASk/Jsap4wPsv2MSdRaWB4yW41ifrkfCaM/PooNxLo8?=
 =?us-ascii?Q?hP5ylDehlwCENS0pdk2MZ8D3m0N1Gv1UU+DZoA5edxED6KtOrdZ2bCdqTmzJ?=
 =?us-ascii?Q?T9nbbEb/rbu55v7fchBaWbaWWOo4++Nb3xkLz1hheCvmoa60jPA7rOn7Qd1c?=
 =?us-ascii?Q?4CymywW0ja7N2fKBHkDPFSZut6I/oics3XKsvWz7+jLMBwp1s6r9beLq70yj?=
 =?us-ascii?Q?FZyD03Fn55Td+ri6c6JpNJ/O6V9kqYeCRqZgTL9xpETDfgPlcxvasD63wu4P?=
 =?us-ascii?Q?aExhYb3oyUY8pH9eQH260+K/CDBAe7zXvo6I3becl3/w9wFkW17IvKLwFcr+?=
 =?us-ascii?Q?UsgonJU00YaaWu71pV1hVfDsCy35R48RorxEmNovJoa8TPAR8/ViXHVNzSt3?=
 =?us-ascii?Q?Vi7MMoEwnAP6bnvwZJNSxeC5PUaWzuKpFEMKdQyoiUHsC600psJZuJhySDMi?=
 =?us-ascii?Q?56KGh7//y6WhlrdGTc3hKIDJvQZozpAAoOcK8ueCt2KitjkeXoaq1KyIkc3q?=
 =?us-ascii?Q?lKxQQYALPvRfHw7tguG3Isw0+U7d6oI/WcdmIQC2YJSrurpFhCuAetDCj7Qo?=
 =?us-ascii?Q?JOIrLE7p9qe16Ft7Vkx8TiexJ1puJRdpFiJNuIWYPxZ/okWrs58h7IqDwvow?=
 =?us-ascii?Q?OUPuop7VkEznU+RdTIJmZvZbh+k3iz1XhJi56+LRmTfvUxQA5Yw2MgOU2v8M?=
 =?us-ascii?Q?iikX3Ezry8wd7MtQx4RhJFErNns88wnERLyeTp90YWLg/VTatzb4MqYn4fFW?=
 =?us-ascii?Q?wsBKV5Zbc8t+3qKZsQ6C4hOqe/ZmPcLBavcS1M63P+ZD7s/YQq09/PpA9CNj?=
 =?us-ascii?Q?IMWGrOxxs6ItVyB/giOd5sFFZubB4r3AtGNEPdThPWSi1ouiKIRTguoHD0S5?=
 =?us-ascii?Q?7XytG1IvJ94dKdIlUoda0kT51GFwGl0GUUEIZA/uN4uZYJhF3vHVb6BSZw+g?=
 =?us-ascii?Q?tmD+OpbdV3F3M5WQvjEZzD9Cc0SCX1i4JNFkKgjJcdy8Ei+GsHwPJTcYYF2n?=
 =?us-ascii?Q?Rmb/ylkkzvI3GoWDbNhaPnCiF4AG97MkHfzBLkm4JaI7j1W8ctUOG6JeGqDQ?=
 =?us-ascii?Q?LV+OC2D7zH0aqjaH4ZWJznXIdqgWbXBD+Plb+4H3s7VR7JZ9bmWOGn5snTcy?=
 =?us-ascii?Q?NI6UDz8MWQ9U39ORCTQmjAk1R9KUxe61DqTK8VPXf+5M72kQ+ewIlFeBDTy+?=
 =?us-ascii?Q?7ThFiDgjseCWYPn8/iGMWL4z5yaGw8B1n0xQdYAxRr65KMg3W3R5BjJtIVio?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122dd484-3aa7-4ea1-9d9e-08dc76390266
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 06:17:20.6574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MR5VcgBhUz+QiaSRKnFCFFhioWZqmIGbASIrx9+CZGQDj9BDAM9sbx9Bc/7h/+diVgXHkRByuvLykmc2NEMsObMtFMQblAfKcynNvZtzYrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164

The UART of StarFive JH7110 needs two reset signals (apb, core) to
initialize. This patch series adds the missing core reset.

Hal Feng (3):
  dt-bindings: serial: snps-dw-apb-uart: Add one more reset signal for
    StarFive JH7110 SoC
  serial: 8250_dw: Use reset array API to get resets
  riscv: dts: starfive: jh7110: Add the core reset and jh7110 compatible
    for uarts

 .../bindings/serial/snps-dw-apb-uart.yaml     | 14 ++++++++-
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 30 +++++++++++--------
 drivers/tty/serial/8250/8250_dw.c             |  2 +-
 3 files changed, 32 insertions(+), 14 deletions(-)


base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
-- 
2.43.2

