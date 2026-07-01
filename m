Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023121.outbound.protection.outlook.com [40.107.159.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3442343893;
	Wed,  1 Jul 2026 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924077; cv=fail; b=P7W/xkpW0R/8OKwmz5tLDfGyDN2D5Bb2rMpYOW66Rc0R66+l2HA/2QoW+ozLbWJ+fTiTyIFId4i7MkF4RaUMnWmxoiL85YuurggoG1iBdUaetodq6QGOjkesVO0o+PGVb2mqZ3TfgxfEbpuYWXvXYmxKOm75RTVwP8YD7G6srW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924077; c=relaxed/simple;
	bh=YLdBFP9NLdRi9MV0oQz+NcT2uJopQ2My+iDgMpNKSv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVGX8X+QAo0j5C6rGur3QUJGxid7vZWw1GH1Td9WN/JQjtE2wVMRgXAuEJXjmJxhSWeDPu95/wwJFsMH/hyb5B0j47ZBMIR2WqVLn3ZXSfskQqzZs7PivOBlUO4DYr6Al0eY0KLOXLJkzpinTgQXFedZb2OPidYvKyO3bduHe28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=g9iWU6wF; arc=fail smtp.client-ip=40.107.159.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="g9iWU6wF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srr4L5a36B/xGoyGwlkqZIaauwpX9sW8vtQeD/3wK4b61f4eZb3tzSh0glTmVUvYGxy9g2HpyRYEzLnemi9Ni3TTk1hHDhiVJZkBRUsbDEAl9a4w4CwBCNm1Q7q6vQfJkeMqys5fK70BOJFTMVe23jsiaGK1VQ8+glooICn+zsyvtwlLbH3umDku6ozixHMlsHxDbS5MDvO0EWlhj73QLkbo9Mcs4oKhFrE3Qulm5qsH4O6Igpoz7PYsyyI0aDETGRaRJ9SR1Wghamba07WOvIlGfQtlP1A+AU+Le9EhAEeTNsXbKw+2wnGIc2kXOOZLbKwz9sZdR9uGgx2ncVHdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WITBvTPkP9Nt0U1GkTzUGxXaDapkhiQhxlBB1nr60Mg=;
 b=i5mctWcAZh0AiSecmq9upG+0yY95phKbOJtPWQ2mzwdMqlkbp/7mcnirnL7Q47nyi74JQhDZhRrndhGSUvtHY7Ub96MXD6YZ/Uhh15VUS9ZeTrXacromOhz16mfN9ilIJqo0VzayWMlRTurg2VYNfiO2lWobbUJEHPwT3e7/9LSm8glwIykRD7TgfOAt4rq0w+jbwpaKq3Binx+SCMAlkTyx9AWVZIXvKsRD6WeUIbtXU4143lFKMj53YBbac0eJBoDLvVZyArUVHyhDfWzXze2Pj/og8NERTeBdYigZcvOIZXmK73nHAkRQizl6F1ZBfbkGeKb2wa/HU2Yl0SBQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WITBvTPkP9Nt0U1GkTzUGxXaDapkhiQhxlBB1nr60Mg=;
 b=g9iWU6wFd7AYeLeWS/JeyB2ME3VIdBwrR3RchZIQBxJK2WryEpeF0lB569qDNcO7gbjMv+YevibtyIjlW7EYwudaVx7yPMzwmq+eMz589kw8mJm0k3r44YEYTT34Z2TDcAbtvEC97HhmmKHSigMjhKsZte8Czknv21NnpalqrFM=
Received: from DUZPR01CA0333.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::27) by GV2PR02MB11471.eurprd02.prod.outlook.com
 (2603:10a6:150:2a4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 16:41:09 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::2e) by DUZPR01CA0333.outlook.office365.com
 (2603:10a6:10:4b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 16:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 52.138.216.130 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.138.216.130;
 helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 16:41:09 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.82) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 01 Jul 2026 16:41:07 +0000
Received: from AM0P309CA0029.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::20)
 by AS1PR02MB7872.eurprd02.prod.outlook.com (2603:10a6:20b:4a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 16:41:02 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:20b:28f:cafe::b) by AM0P309CA0029.outlook.office365.com
 (2603:10a6:20b:28f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.4 via Frontend Transport; Wed, 1
 Jul 2026 16:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.6.247.99)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 217.6.247.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.6.247.99; helo=mail.za.ziehl-abegg.de; pr=C
Received: from mail.za.ziehl-abegg.de (217.6.247.99) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.202.0 via Frontend Transport; Wed, 1 Jul 2026 16:41:02 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Wed, 1 Jul
 2026 18:41:01 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <david.laight.linux@gmail.com>
CC: <Maarten.Brock@sttls.nl>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <hvilleneuve@dimonoff.com>,
	<tobias.gannert@ziehl-abegg.de>, <joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half FIFO to prevent underruns
Date: Wed, 1 Jul 2026 18:40:56 +0200
Message-ID: <20260701164056.951230-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <GV2PR05MB1194183F888F21065CC596F3D83EC2@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <GV2PR05MB1194183F888F21065CC596F3D83EC2@GV2PR05MB11941.eurprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: vEX04.za.ziehl-abegg.de (10.1.201.108) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30040.007
X-TM-AS-Result: No-10--15.684100-8.000000
X-TMASE-MatchedRID: L8tZF6zWW2o53MvLYrUDiM8R4NzG9QOMUd1JKREWJmT7Bamin45J3HVY
	40dPvzCfkiR1hYKzLo8et2W2IEA45uxAkh/4iTFXNng0qv9OzMfEu6IYOQ1zFygRAX0MQ/gd/7R
	KIuPEJ7ko8MUoOsp8k5L5F9uAiy4tkjstfQbJrKcWYppa85zdYCd8voqopKNviGVApiRLArnrhe
	UxuzThE7+R6kwzFLCtp0yAPzOYH2PVRCka1GSheYOGpR5yhwqnqmoMFwwlqXg0ni78cctbeq+eC
	SMeOiOkFNPcKKOC8NjbyADE/9OzolYHXldrySG2FwZ0Ekw3W60CZlqQ/YU74UxvDO1Z0RBdK8mt
	WfWd2GxjhL0sYSe3oQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.684100-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30040.007
X-TM-SNTS-SMTP: B0A6780C6E3CF0AF504E19CB12419D5C479A476C97E557ADE2E96762263EFD4F2000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM4PEPF00025F9A:EE_|AS1PR02MB7872:EE_|DB3PEPF0000885D:EE_|GV2PR02MB11471:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e804fa1-36ef-407d-2921-08ded78f8e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 UrHOl8BDuL5LG+AHP3m9U25MMC63fjGMZcOoeMd7ilQ24f465uuGI3k064fihCbj6FGowEkXJiwuklO9UCFO/GpUtbX4Lub+FYn/prfKrFxkfzcdFxTKgHhYFflOFt1LmhHV59I59ZN5b9eBG8DESrrAsZlixKA0Qf6gv9H/Rm6GEwkZBi9tM1BK8aWL4fQqkwoZTypihgelD5jGNN6hnEhM4SzmSh7SkCvZciOw0lugIt1P3WSl3zq0LCXECtow4BlCipnSAbz1sJ5KsqmoaziCPxz7anDB7YjOH+x+CcxUMtrNKwT4n3xXwTd6UjVbSQyG67e7pA8iYkBklEF5MQUk6jVmnBf11EGFJ7OE4cILfvnnl8K0TgB+VrVcR++LYEaGaZzzHrFNiK+97z3iXzaMuIiaSxFzZ+Awi7zZMDQoxPWInbvh9sikz9CNGM2dRkfpzI4OrFtG9DNyiWV4ovctBZlqoicyouFVNQz9AzfYX53wJ6v0qZRDmidg7g5bRvyMXbt/l26OZmgGfKL33SIff5qXWaW3monhZBPJeCrSg5zThkisG5XQsqOeJStvwTSrqeOoT4sBwckMXcTyC2+jAxl5z9JCIitJAtDEnrmeqHqbpKnLmHUpxG7ArkrijhVsX7xpkGagMoyqynydklTARKU4jPwN7kKb1KfWNr/VcCru1pDJnxUV5ypX7hZM9nvfRWGS1AbTQnPqZg0bHQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:217.6.247.99;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:nix.ziehl-abegg.de;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: PeooyZibIdNtYSWm10thIbkSP5xKVOGISxl9FaWtwguQcIOl+V8M2vALAHHsqqmVZqWuVDau80dGTbiy9CkRA8hcp01N6OWfp/OYX79xzI8x6DCHHk/oqivJvhMhwuxGBDEz3FdFNj0avdxho2EP/tWCtHXKbAaujg7VTMYr8//zzDg3ohDD1dkfqRoEIgMEZpyA3OckuJt8z1YhLnJyWIsRcuzXARbUXzo+cbSHr+J9jh9txxW98Txgk4qNhhlL71R5kZUF0G3yicBuPyaioy9bWMn5nX+JzFtnHn0O6Jkozd0fTH4Ow+aGYaZVog5j+APUlwMLxwnoRddBpQVsSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB7872
X-CodeTwo-MessageID: 46a3ab7c-9f2f-46b5-a420-abf25f89c7e5.20260701164107@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1dafb978-7918-45a4-6f2c-08ded78f89e7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|14060799003|82310400026|23010399003|376014|35042699022|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cjTn3KhrURqZsGwPj0w1Z2Z1tHAgfGAFcq3KvDZAagno2ZhVMPI3MCsiUHOdzBHE9fPgNaNcfsPUMZ6/MIVqEVDyav1ZJl7vqX/m/IFumWLYI9nWx2ADPJAumYQisCZjqJNjYeUq+cVvmma/2EWlEEvA6d0GLUmRYazS/cBchUZVCgb5gA8WIE1LomEdlJHqdK4W/sXgLIDgE4Qu0Fw8+t9qbbwRXClNA8ieADpZYRhBdLdtq2aESU6xB+CO9xZ6JvCv+/YtLD71RLG9STyaff7/l+nmsLvW7eu3MpSkYrUClOHFcafMhVaKaY7IkAwoFcuO0UoKiJdQO0UEy/vXGNp1xPc0CRoROIQPTqjttMTjjTs+jdA4iaEkZHAeMvq8MECPAPR2W805/cS7GrselJQraOb6sOeAxdQLgwEd6hta1RJggz1xNg5jtGqipzP4OdlTU28y0RggR0uOR1tJEV8Gaf6TZRqWmClVqD/sLC62B3AULvpbdYZBYuXrxhoyPC34EcEp2j3CmPjmEKjXFzGo/hrAY76ZEicgMoTN1bkLRF1+PpIYbXs4a4mmg4+6Eh3nmnykbkgKK6CkPo0VzbgUMZO73HbM8JSOXa+m7LUcjts9ZXenmESBfuVsGQETSZOxOh1EOEQzPnT6fowcsHlkF0Tvav+XMV5KrATCu8jPhba4qsni5ICK/9+SRAUxiTVSa0UnGMXBJSQXSN/Avw==
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700016)(14060799003)(82310400026)(23010399003)(376014)(35042699022)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7Wb58LrFWOrVbZ0BTdyhtJ29w2rjpKo2HWIOdjANxu6HR4xvVt7F8SNu3he/JQHr8g7PqRJuC3E7YViQ4nldPlMjb15gwQN1/SfJHryYT7S8OLlCvC9JihCLh3nWAyDrMaDWNktLQY4IhfE8EiyvuCfFrlSQxL2YsAaKYsBLYiitA56cmIU4JMFiY8KBU8YNIwwcIUn8wU7a14JPgm9qPlPs53brQSb5b6EiZq4iYHm1F9sfsyQoWk2fNGFmRTm52IJpypi94dtdAV30ZsRKzgJRwe/7cdTjc958kaldfSwgKPLE3NsMuOyu1xXUb/ROSvPvsdEOBZWwu4ciEQiMoq7CMBaCT0hd+OXWX4zsiqTnGCVRrj/4dLeCbb2E5beMbsO3/iXz9Oqf/6kvitu9qyVxHbKz+oGEn6kBYJJfsBnmiykhh8MQHpvghujS6sNj
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 16:41:09.6291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e804fa1-36ef-407d-2921-08ded78f8e09
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB11471

Hi David, Maarten,

I rechecked this with ftrace, and I think the right explanation is
narrower than my v1 commit message.

The underrun trace shows the SC16IS7xx refill path running with the
hardware TX FIFO already empty while the tty xmit FIFO still had data
queued, for example:

  sc16is7xx delayed refill: line=3D0 txlvl=3D64 pending=3D172

So the conclusions for me are:

  - The driver can catch up if the FIFO is only partially drained when
    the THRI path runs. TXLVL will report more than the nominal trigger
    amount and the driver can write more bytes.

  - Once TXLVL is 64, the FIFO has already emptied and the TX gap has
    already occurred.

  - The v1 explanation was wrong to describe a 32-free-space trigger as
    increasing the per-interrupt refill window. It does not. With the
    default trigger, the FIFO has about 56 character times left when THRI
    fires; with a 32-free-space trigger, it has about 32 character times
    left.

  - As Maarten pointed out, the benefit is the other side of the
    trade-off: the refill event rate is reduced by 4x, from roughly
    1 refill per 8 transmitted bytes to 1 refill per 32 transmitted bytes.
   =20
  - On the tested SPI-backed system, that lower refill rate reduces the
    IRQ/SPI load enough to avoid the observed underruns.

The change is limited to SPI-attached parts so the I2C case is
unaffected.

For v2 I will:

  - rework the commit message around Maarten's trade-off calculation:
    4x fewer TX refill events, at the cost of reducing the time-to-empty
    margin from 56 to 32 character times;
  - limit the TX trigger change to SPI-backed SC16IS7xx devices;
  - leave the RX trigger level unchanged.

If maintainers would prefer this to be board-configurable instead, I can
look at a follow-up DT binding/property, but I would prefer to keep v2
focused on the TX/SPI case.

Thanks,
Paul
