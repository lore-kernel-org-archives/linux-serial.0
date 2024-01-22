Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2064.outbound.protection.outlook.com [40.107.23.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A03A1DD
	for <linux-serial@vger.kernel.org>; Mon, 22 Jan 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.23.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920745; cv=fail; b=JWVRpnvRixIilpWtV3AE8brUgJvwRYbeO4ejPmxgMeLRb8HCk9BgGV9E3DgJVyuneOMv+ldh/PMg/pNRM/5rAXdmdc7nMHBVy3o5EMkhlAZKYHHtyhZgqgN/2twKZ4E0h/OjrZoyFZ65eydn9XXo764ZSoSbfzEjKPSfkbxNfXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920745; c=relaxed/simple;
	bh=p39NMtlH9M3+3qHcONMP+QBOBmegg57CRWNkV/EOWbI=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=Lvsj6AUS/UPYnITbQyQ87cdbFj0OjmSkaHTJeXTNTvtJgznD01P0F5tFNGc4AWrzx/F5BXYmBOp+dxTJid8G08pKY1auDfHx++y6OANvV1P8mr6j76txnnbLSbdYhYVay2BgW0AFXNMCRpPK5j4h9wYtpxNM/sZ47wBEwQ/H/Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=KsAHYDqQ; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=KsAHYDqQ; arc=fail smtp.client-ip=40.107.23.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="KsAHYDqQ";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="KsAHYDqQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrAsHJASy2EvpeK74ALHMH5rXYWOW3KhmHIc/I2Cw/uJkCGZJtlulSd1IYNH4d+WJW++FRK3C7B4a16oTPf0+GVYt8mEswyL3hQH1RRV8wkxeZBWHSujY0mNzMHGBbKEAfgC3gwJO5re53LA0funcF829PRg07o43PD46Re6cIdrmYUgQpnLCrksptjaNXD5IoDnRdHw4mZA/9z8mg26WhuFf5XiZ5b9Mumqbha0nChEj1+YEFtiaK6t5c6PjJDfgfbnAROM03nWIQQ7Xqt1hbyOzJrM3JDr9XoE8QVJV/+K4Pze4uV81HJmWxIbr5cl3FROnKZ/LrOnwK7ml+EdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UNtANk1EkGtFOkZ7NJroBtI0hOkg4A2CLcQqmGEUZM=;
 b=mlYL6R1pLeWts9jzT4fgcBd7HbHz/GGvgImKA1UgoEB92TeK0qYyAlQ3vZVsusPP846l9Vi3Pdr+cu7fDgWSjhF5FRlB3MC5QwMdxbe/wZFe3Im3nGVbUquLN0dJ/6mxzWQAh0sbzQWN1gFHgAqhKjJpBtrac4iOip0RfwxVUMLwC3XBPwAxCoy9XjLeSt1ppcMXaHHxd1qwy2/wxx/XDkamIRZMP7nttTiTPRhG0RWsYtN3vcrCZSltZbLl7QMn3ebRa4U6BjgiOOr5LiQtY6dOcyFytS4PDMW+nTG7HxTIK7hONas8PivaOU+SsuTc1bNa59IJH8mya8EH+RrMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UNtANk1EkGtFOkZ7NJroBtI0hOkg4A2CLcQqmGEUZM=;
 b=KsAHYDqQakjFT2gfFwqAmPAn7pbp3hxFp/ftuFBF9B/Huygj06Tb/j+rKkTZmMSQiHU8WeCQWgGnXQt2iG5/mOW6sHtAuadQEqiN0qSdvhvqdsVSAVJbhP/U3Y6qDKD3CPZk+rQQF7U20LmVlLDDf0FI13akKUgadqgyRHKBVNE=
Received: from AS9PR07CA0047.eurprd07.prod.outlook.com (2603:10a6:20b:46b::23)
 by GVAP278MB0969.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:46::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 10:52:18 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:46b:cafe::9a) by AS9PR07CA0047.outlook.office365.com
 (2603:10a6:20b:46b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.16 via Frontend
 Transport; Mon, 22 Jan 2024 10:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 10:52:18 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.4])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTP id D462AFC36C
	for <linux-serial@vger.kernel.org>; Mon, 22 Jan 2024 11:52:17 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id DA7A4FE7DA
	for <linux-serial@vger.kernel.org>; Mon, 22 Jan 2024 11:52:16 +0100 (CET)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=KsAHYDqQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UNtANk1EkGtFOkZ7NJroBtI0hOkg4A2CLcQqmGEUZM=;
 b=KsAHYDqQakjFT2gfFwqAmPAn7pbp3hxFp/ftuFBF9B/Huygj06Tb/j+rKkTZmMSQiHU8WeCQWgGnXQt2iG5/mOW6sHtAuadQEqiN0qSdvhvqdsVSAVJbhP/U3Y6qDKD3CPZk+rQQF7U20LmVlLDDf0FI13akKUgadqgyRHKBVNE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::10)
 by ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 10:52:15 +0000
Received: from GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2d08:941:5307:52cd]) by GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2d08:941:5307:52cd%5]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 10:52:15 +0000
Date: Mon, 22 Jan 2024 11:52:13 +0100
From: Federico Vaga <federico.vaga@cern.ch>
To: linux-serial@vger.kernel.org
Subject: serial:support: Using 8250 driver With MOXA CP-132EL Device
Message-ID: <zmry3u7l7dzh2iqqonxyombv4v2nzpr3fccoe677laxc2jn6nm@mo4afecdt45o>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-ClientProxiedBy: FR2P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::14) To GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:3b::10)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVAP278MB0230:EE_|ZR1P278MB1022:EE_|AMS0EPF000001B3:EE_|GVAP278MB0969:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0a293f-ae16-4cd0-35a4-08dc1b3833e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 gnVFfP8UMohqyjue7EWn0BMyGH5GiWl1/w/ux2veqWp72xwv7TF3ay0XGM1HqppdiL8as9vJGcOQc555tnFJnv+jb1zwKNovL+gE7y3+WNWXDYjtOd/wdKM5fVOy9oJ9SGsttMXMmDpSLdvyfVHIgh+xP3Lg26MRb01kNWG/R1Ubul/OwBxF6iYUCsfcGf1KPYUjz+jQlzW0HKQhrNCpQs03tIDVKdnwAYs1KtOXhlm0Ips2+1O8bplYhIH1Mm538MslODfuRYzdDuRb/hxvoJUxDNW5viaVKewapPa/wR3c9+trnq6r8SH4sn7Rp3+pvUTXpNc7tGL0Fkqil39YSH/JMO3kpHU0JkmhnkiRyqU9Lst6c0pYf5E/4/RH2XScClXp5L5+m9iUtXw7Dxa7cboQIBJOYPeaeSI7LtFA3vwUd6xN1di79/dA4tBVADht2YiCKSRI0lOT9bGFr+jvzZn2txIs2pDmkbDN74UQDFinVnIOCudwb6YQX+SORXy1+nRFizv2suSTIgJSa19WagpMw9ENGI5wQpXRo3Qwv84Om2QArYqDPdkZ0O044ugT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1022
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9d39a7b1-e317-4fcc-2411-08dc1b38323b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tOynzELdIrr4t7JVA/Nej06k2dhSDufrD/UmNIn70prast8/DZ6A/uSXBFW7vrbvbOPKC/eOVYvmh3snC0s9xQpgeCTp2wi5HcSmOw3VX0JfaWqEP2IxZ+Ac3FfdXgR5cX9VnWlkeuWOUokL5uMThSDtxVFyhilXuI53AengB54bt5mTO5+NHlminhiDADqou9SdslZuF4ZVb2S52dCwqHSCEfDa+iokUS9cc3jmfbogaFNdwgvxoWoVRLs6waYERLTlpBMEK64N1vPftGF7E9GbgVews1ZfCEXRuFDZMn7x4D4ICmee5L0v/h1QyoJeDMMWkAPIgc6D5WapNYdlCN8e7Y/qPG515cSK2IsuGCsArqtivBPZFDO7bExuGZk/qW0GRIG2ihhjIoTawivplEf1WdpMH7WoXlj8FM90jshwsOoipTKA7BBHGIVkhbQZCKzD42r8dNllw13KYiQW7A6HM0zXiqJArSvj/eIo8C8j+DX/u7M2FyJl504xqQPuWCgvkuvlnYyjUvkd7bHKhgKE5fo4Xu5OnUlj3oVYNriIaWm3X2bhJu8zXOeRu/P8hJe3/+bz667E3mJ0QnTk2ISkGXTymisLX8AJ+N4XvqUnJK+yxRXPj/g17KFTiG6cVh8R8LWbr5shv033UcPWlbyYJYqIuJ2F4nMVitKLqH6xIWx9vlj/0lIU947taa8p+X++TYcbRcW6K1ajwMO7ND3p3RZukaODl59Yoz1pS62MkEgZ+oFmrCkma5oYQX7MgHiwsH+EpXMsdEHFCNl8YA==
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7916004)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(6506007)(336012)(9686003)(6512007)(26005)(86362001)(82740400003)(81166007)(356005)(33716001)(41300700001)(44832011)(83380400001)(36860700001)(5660300002)(2906002)(47076005)(8936002)(8676002)(478600001)(6486002)(70586007)(70206006)(6916009)(786003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 10:52:18.1436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0a293f-ae16-4cd0-35a4-08dc1b3833e0
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0969

Dear all,

I'm having problems in trying to use the MOXA CP-132EL card with the 8250 driver
on the stable kernel 5.10.192 (but I also tried the 6.1.70). It seems not to
work. As a note, to do my tests, I have a loop cable connecting the two on-board
serial ports.

I see this device should be supported by the 8250 code, in particular this
appears in 8250_pci.c

```
$ git grep 132EL drivers/tty/
drivers/tty/serial/8250/8250_pci.c:#define PCI_DEVICE_ID_MOXA_CP132EL   0x1322
drivers/tty/serial/8250/8250_pci.c:     { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL),    pbn_moxa_2 },
```

At boot time the device is correctly discovered, and it matches the driver.
Indeed two new tty interfaces appear under `/dev`

```
$ dmesg | grep 0d:00.0
[    0.196175] pci 0000:0d:00.0: [1393:1322] type 00 class 0x070002
[    0.196350] pci 0000:0d:00.0: reg 0x10: [io  0x4000-0x403f]
[    0.196448] pci 0000:0d:00.0: reg 0x14: [mem 0xb0100000-0xb0100fff]
[    0.196534] pci 0000:0d:00.0: reg 0x18: [io  0x4040-0x404f]
[    0.197474] pci 0000:0d:00.0: supports D1 D2
[    0.197475] pci 0000:0d:00.0: PME# supported from D3hot
[    0.371301] 0000:0d:00.0: ttyS2 at MMIO 0xb0100000 (irq = 16, base_baud = 921600) is a ST16650
[    0.371832] 0000:0d:00.0: ttyS3 at MMIO 0xb0100200 (irq = 16, base_baud = 921600) is a ST16650

```

The communication seems not to work. However, the communication works when using
the driver provided by MOXA (``mxupcie.ko``).

The interesting thing is the following. Binding back the device to the 8250
serial driver after having loaded first the mxupcie makes it work. Translated
into a procedure:

1. load 8250 serial driver
2. make a test (FAIL)
3. unbind device from 8250
4. load mxupcie driver
5. unbind device from mxupcie
6. bind device to 8250
7. make a test (SUCCESS)

This made me think of two possible cases:

1. mxupcie applies a default serial configuration that works out-of-the-box
2. mxupcie perform a hardware configuration that the 8250 is not doing


About option (1) I used ``stty -g`` to compare configurations right after
binding. But it seems exactly the same when using 8250 or mxupcie from MOXA.


``` Using 8250
# stty -F /dev/ttyS3 -g
500:5:cbd:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
# stty -F /dev/ttyS2 -g
500:5:cbd:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
```

``` Using mxupcie
# stty -F /dev/ttyMUE0 -g
500:5:cbd:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
# stty -F /dev/ttyMUE1 -g
500:5:cbd:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
```

This makes me think that probably option (2) represents the problem, but due to
my limited knowledge with these two drivers (8250, mxupcie) and the device
(CP-132EL) I can not spot the problem in the code.

Therefore, I'm asking you: are you aware of such a problem with this card or
others from MOXA? Is there someone in the community who is using the 8250 driver
with MOXA devices?

Thank you.

-- 
Federico Vaga - CERN
