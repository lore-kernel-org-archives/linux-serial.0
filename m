Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2122.outbound.protection.outlook.com [40.107.24.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7F2C696
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.24.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593710; cv=fail; b=R2Rjt21rC6YhSLWW8prRViYbwTAQX4uv6VVGTkRCSB311G1+NbsCk4MfW40QMiGgdPEaVf5NowDRm0G+lAZyGv8C/6edUBd4X8zhVKUfiI1SHJ+yKYSPFOz/uP8U/rGJk6BOwBRERzxBAV+r5++bKSyrZFmnbU06jLau0cGyUJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593710; c=relaxed/simple;
	bh=ytFulEgGjS0360fAIGHxgPQenQl680n2Fr1MfFnHQPU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PCqXdpBxx4T/++hDMWLVExV6d5n0bgXKDLdeopKWt1Bb6lH+VgXhv9P9U/WTokjs8z2SKnasSGDyyGm26GQYD/eSEnfdzm2b8QWUPpBgsoNzn8GmSGJYONV6aHVfWh1dZQqRQs7fprawgd5e2lOEc+B9B3LeiXs+Kd42B8lrd4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=C2NUB5ti; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=C2NUB5ti; arc=fail smtp.client-ip=40.107.24.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="C2NUB5ti";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="C2NUB5ti"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuP/PnYJm9v+Tz+twAgqj/aaD9RWh9yT0h51kuYiymTfHSkAWdLfpoS5Av6B3vxG3jBoHzr2Xz0jkb0GNr4kpiT57yJhYPfsLQUP90TMPN7/Ix6J01MQOtjFsJ3poPNHIFgJ1HJQdfuhva+geU/Xfl6yJDlkqmDi+QtTjcwXPrzhSEo8Wtu30OoQMvopq/vegBNgsXGQFHXkm49sVJeGjTunf8ZFf1c1HhyJ+SzR1A9euqQ6R7tn0Bs5BOfAlFVa1uR6AErrXEUNVwBV6DZRYlWyFWSl84TSFgAvC8xI1/Qo2IARkT41TPtzcpI8vgFfHShuHiRKRRQqGq8vImXY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlP4lCjyJ02ue31SdqfYtTFbuZW1JknFFV7StLDu/4Q=;
 b=nAbYEA6BjUkfk70zT+7KyabFmHyvCixa5NDvpfDYT4nMRg8eQ0dRNqw6zYYsge7O6fXpqp9ZD3B4YK6niz0geO/qyH8CGnMF5R89Oc7jM/sQdCWP+JrpAgHxdO/6jPn9Uwui2ko2qvcu/hCTV7A88muQeG3LrvvlvcU4RMMdvOq8uPPv5uDS1LWN6YU+CwPsUMfNFd81FT8AJxiIEAsz8NnGiLaxkoE5/xBKXe1Ybpyy+XGfcYcKRWmxRQoSpLk/5Vr3oHyy4LIwOZiU0C382vPKAeO69Vknv3VT7a+S98uasLC93/J7hAxqDPq/BKPfi6ooIabfJSSvlRAXb/i46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.2.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlP4lCjyJ02ue31SdqfYtTFbuZW1JknFFV7StLDu/4Q=;
 b=C2NUB5tij6B4cOYdYDZ0myGeeYsRZfwtNw/hNV1Xgb+a1+dD/UtcBY6Rxt8tS/jgF46wn26YV6n5q08UckZgk97DJCtT2sQXUkhKxwkVPRZvaeT5LIU675fUE7dSrDC/FuQkTC3DXkv7PY03B8gxBBGKyXmpB2Wgh/MYEo6Bvbg=
Received: from DB9PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::8) by GVAP278MB0882.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:56::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 09:21:44 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::d3) by DB9PR01CA0003.outlook.office365.com
 (2603:10a6:10:1d8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 09:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.2.244)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.2.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.2.244; helo=mx2.crn.activeguard.cloud; pr=C
Received: from mx2.crn.activeguard.cloud (51.107.2.244) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 09:21:43 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.5])
	by mx2.crn.activeguard.cloud (Postfix) with ESMTP id 3E52F7FCC3
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 10:21:43 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
	by mx2.crn.activeguard.cloud (Postfix) with ESMTPS id 30B397FCC6
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 10:21:42 +0100 (CET)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=C2NUB5ti
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlP4lCjyJ02ue31SdqfYtTFbuZW1JknFFV7StLDu/4Q=;
 b=C2NUB5tij6B4cOYdYDZ0myGeeYsRZfwtNw/hNV1Xgb+a1+dD/UtcBY6Rxt8tS/jgF46wn26YV6n5q08UckZgk97DJCtT2sQXUkhKxwkVPRZvaeT5LIU675fUE7dSrDC/FuQkTC3DXkv7PY03B8gxBBGKyXmpB2Wgh/MYEo6Bvbg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::10)
 by ZR2P278MB1052.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 09:21:40 +0000
Received: from GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c0ba:1ca7:d3b6:a040]) by GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c0ba:1ca7:d3b6:a040%6]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 09:21:40 +0000
Date: Thu, 22 Feb 2024 10:21:38 +0100
From: Federico Vaga <federico.vaga@cern.ch>
To: linux-serial@vger.kernel.org
Subject: Re: serial:support: Using 8250 driver With MOXA CP-132EL Device
Message-ID: <v7jpnrrgmjqgmtwrahwmd6vouv2opuhwxaeo6ouimojql7lv3j@zqhwaky2lqki>
References: <zmry3u7l7dzh2iqqonxyombv4v2nzpr3fccoe677laxc2jn6nm@mo4afecdt45o>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <zmry3u7l7dzh2iqqonxyombv4v2nzpr3fccoe677laxc2jn6nm@mo4afecdt45o>
X-ClientProxiedBy: FR4P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::6) To GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:3b::10)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVAP278MB0230:EE_|ZR2P278MB1052:EE_|DB1PEPF00050A00:EE_|GVAP278MB0882:EE_
X-MS-Office365-Filtering-Correlation-Id: aeeb6d6c-5c5f-4b55-6a23-08dc3387af80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 ucMkFkG3vz3DpmvO9Q/fdhCZrbzjUaYnIMzc5itkmGcky0eo1STH32EOvtuLk+BMdupyK97DdCiZgbInc///FWePRblP0GkSk4qwmC4eTLZASIs5MO43OV6IlSd+AHQlfHzD80SdEqHiT3EAwxWQG/VY8HGXIHTibiPZ+P3+crE5WA9SMngJi1/sp4cpJNlNNho935SXsepqkCL5mc+z6sAQ/eCHn9vAkg2ax71uPA9H7rDt3AUfLKMVEDK5XxLTOM1veiINMivfaHVa3UrbBqksG3w1Ns5lZ8InjWt3ySUEBqZpL8xmgXg3CVB7t4ugg5rGbLGz8OjaiKpy87fOTauqw3I+tPnx/QZteEdfsL0sxllsS0z7ThJGGHopZfeSsfFFNjkYIVyG2yOTOskbmDQSGmqAWvosvVZh8Jt2o/a9mvTMzXoei/cPnI/s5ECjstUg+FsFgL5eHt1IGiTEiJwilwOHbkMp966dxNyiqJeo9nLVuXULhRiTx87LNCWZzVLE+u1RKW9240b9TYtFym2fw3qVY98sHi6p4plhHLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1052
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e5dc9270-86f7-4eb8-aff6-08dc3387ad28
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3NlIparvgjhjgwiohrkH2X0wcinSTO7OSlcXenjp4lk/7AAK7MEQkE7rKLCCnnbAwiWZxTBuTbTPE3SR7qZNA0AewYoXwzzz95C2q3In2hFNlQzgBrqjapKok+uvCBxqNSjIrgYx6A13T4SQdpui3zikda0U/UCRuQTDGDGRMjNXCxL8oeh/RHM17gTQE5021S/EjDngaR1n3rB+7PaBXAFkJ2Tup73AKDAVasUHWq6UUeSkZ8VTCEYs7LAguj3AT/UYEv4XrJ3dgR4cbertIGeWXJ+8myYDNn7ezhcjrvMRL+Cng7n23m3nFCIuYpllxAg8IOS7jj1ErC7LxYJ7TLiDILziJZnevN5JiqxFCqbSZm469b7WYah4kjjlUB5wKm7Hnhe+zkexrTuFFTzR2Ttmn4231w5W8Lz9rN6deRoOfC+2zorJTaUzkbZFma0lzKME5ZisvulqkmmZcCJawKvpVl2gmzUdc5EcYyTpYDkxcBJrLkTK/nNglpICmdVjOFUzTGO9dertcaaGv2kaEKKtI28WPCj8Nn0s4++oV06dkk4qsd7XHnx4hWaAuqDbzm9YlbTNCW8ZLlBdRPxPoXYjHZLDFz4kGqXsEfyqa25oJ/OttSmSFiBD4REnt30wgWacv/eXeIqdIPijT+vwChIrAlZzHUC2I6AhMytISPk=
X-Forefront-Antispam-Report:
	CIP:51.107.2.244;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx2.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 09:21:43.6547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeeb6d6c-5c5f-4b55-6a23-08dc3387af80
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.107.2.244];Helo=[mx2.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0882

Dear all,

My previous email might got lost in some inbox. Allow me to retry to ping you to
get some help in configuring the MOXA CP-132EL using the 8250 driver.

On Mon, Jan 22, 2024 at 11:52:15AM +0100, Federico Vaga wrote:
>Dear all,
>
>I'm having problems in trying to use the MOXA CP-132EL card with the 8250 driver
>on the stable kernel 5.10.192 (but I also tried the 6.1.70). It seems not to
>work. As a note, to do my tests, I have a loop cable connecting the two on-board
>serial ports.
>
>I see this device should be supported by the 8250 code, in particular this
>appears in 8250_pci.c
>
>```
>$ git grep 132EL drivers/tty/
>drivers/tty/serial/8250/8250_pci.c:#define PCI_DEVICE_ID_MOXA_CP132EL   0x1322
>drivers/tty/serial/8250/8250_pci.c:     { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL),    pbn_moxa_2 },
>```
>
>At boot time the device is correctly discovered, and it matches the driver.
>Indeed two new tty interfaces appear under `/dev`
>
>```
>$ dmesg | grep 0d:00.0
>[    0.196175] pci 0000:0d:00.0: [1393:1322] type 00 class 0x070002
>[    0.196350] pci 0000:0d:00.0: reg 0x10: [io  0x4000-0x403f]
>[    0.196448] pci 0000:0d:00.0: reg 0x14: [mem 0xb0100000-0xb0100fff]
>[    0.196534] pci 0000:0d:00.0: reg 0x18: [io  0x4040-0x404f]
>[    0.197474] pci 0000:0d:00.0: supports D1 D2
>[    0.197475] pci 0000:0d:00.0: PME# supported from D3hot
>[    0.371301] 0000:0d:00.0: ttyS2 at MMIO 0xb0100000 (irq = 16, base_baud = 921600) is a ST16650
>[    0.371832] 0000:0d:00.0: ttyS3 at MMIO 0xb0100200 (irq = 16, base_baud = 921600) is a ST16650
>
>```
>
>The communication seems not to work. However, the communication works when using
>the driver provided by MOXA (``mxupcie.ko``).
>
>The interesting thing is the following. Binding back the device to the 8250
>serial driver after having loaded first the mxupcie makes it work. Translated
>into a procedure:
>
>1. load 8250 serial driver
>2. make a test (FAIL)
>3. unbind device from 8250
>4. load mxupcie driver
>5. unbind device from mxupcie
>6. bind device to 8250
>7. make a test (SUCCESS)
>
>This made me think of two possible cases:
>
>1. mxupcie applies a default serial configuration that works out-of-the-box
>2. mxupcie perform a hardware configuration that the 8250 is not doing
>
>
>About option (1) I used ``stty -g`` to compare configurations right after
>binding. But it seems exactly the same when using 8250 or mxupcie from MOXA.
>
>
>``` Using 8250
># stty -F /dev/ttyS3 -g
>500:5:cbd:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
># stty -F /dev/ttyS2 -g
>500:5:cbd:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
>```
>
>``` Using mxupcie
># stty -F /dev/ttyMUE0 -g
>500:5:cbd:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
># stty -F /dev/ttyMUE1 -g
>500:5:cbd:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
>```
>
>This makes me think that probably option (2) represents the problem, but due to
>my limited knowledge with these two drivers (8250, mxupcie) and the device
>(CP-132EL) I can not spot the problem in the code.
>
>Therefore, I'm asking you: are you aware of such a problem with this card or
>others from MOXA? Is there someone in the community who is using the 8250 driver
>with MOXA devices?
>
>Thank you.
>
>-- 
>Federico Vaga - CERN

-- 
Federico Vaga - CERN BE-CEM-EDL
