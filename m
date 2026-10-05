Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021099.outbound.protection.outlook.com [52.101.65.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05520471D1C;
	Mon,  5 Oct 2026 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197522; cv=fail; b=NFzV7u6OzDApHygdtojm5OcyNh4KyzLVltch71euWsXM2O1yyLxpMOkT7hO9Gtl8QNmxDXGYgLPFNxKJPDE8sae3Xeg0RNvhv2/DCUE+ZGF763DRZomX6nOtr2SHuW+RonHhHLJHYQggjnuelhLewC5zPjhzgu8Yicfe5R/5AV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197522; c=relaxed/simple;
	bh=pnALeUrm6t9wiVrp8xFjqL0ouiwxut5o2XemZul1Rl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H7gRPtlDJXVYEjDRkfEOIURzfGbi0/QhJCIyTGhVAg+m+QJ3IqjrYbd/GdRQQunT19DqutCFlP9LovhiAUbCfhctLG0bX8h42SLrxQnFSb32cYpuLIiDNvvMTC9KHKVZ5kBGAei+nXym7Bace6mjvCb7hAfh1AOgkkbjpDJwX3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=UYvEMYsA; arc=fail smtp.client-ip=52.101.65.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="UYvEMYsA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l32Wuu8ZXz1eXl8qRE+8GRXarrZrlITNDmCKhYbBbDy6XHiV00pegu3TpYHgZbSro2/al1TuFy1+hMIQdSHINm15kYH6oS2lgMVfV2uFzdhhZoT5c9XynxMawjLUBGH6nE7aFHyJijOMEescBzqkdmEw8RmkZ7Op/2YaIFcKOsZlgl/Owt/akgVxEJOFrULA8pwxtlvgt421eRn7h/mgmkIqXtQmWx9hdfd/puxKH/ROv96pYqVXAJC47zjoS6/M95ZylaevLLirwLUiVKNKADoB2et77+9KIclkE0IWgqj5DHtcoAggc2HEMdCIrOVF0S28J0J2Y/nhHq8uA8A0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnALeUrm6t9wiVrp8xFjqL0ouiwxut5o2XemZul1Rl4=;
 b=ERbXuy16U54/2NdRJAWkx8y7QlQqo7GV4d8e5WEwnDqKmgBLfMKRqNk1ck8qM3X0I5OSUaL1sloX0O+IJJ056c6M0EfLyK9w4jzg4bH9CvqTDRSAs77L8EuBE67tu7/rFE+gdOHaOIjEFXnyEaOeOnZwYeqM0jBvTTFInhjn4taefubNvDHVp0EYKFIjkxy3xnlM5IwmkMcjamqn0Ts2J07qq51mimGQ1S+d8Xt7w9Adwj0Ldwqws6jfUkKknZ9NWnid0NNQ0FPgIfcGt0LQvSwUeOy0dNpQ5wO6rOTHhmkJsnQesOvZQCZ2gev50eD9WqF0IO265av8xT5Ez3WIkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnALeUrm6t9wiVrp8xFjqL0ouiwxut5o2XemZul1Rl4=;
 b=UYvEMYsA/HlWfhvMEIzKYb9X2K80cnAkVrmwSpIgAb3f1PMOataNtCcZtukQFQ48ZcG4zRHqzHB4GqwhHx3vKVnvyiv3ENCexcoEHN4zKm4TR/bF/vBzqJVVZfpng9uaEuNIYBR1VJJCG6RIYEQQfjgp3+rXw4XcuZ1OJno1b7DbV8BOOEFPhn/Vb1mgfRSH6P3oeBrNrFqIkkbiokSScgZEVbMGGypny861Qp3jwYVyeL0aO8iwnOgR2rZZVX+9AP07Fwz9JDVGcVaMh7oWqiD2bUVfcsvNDjv7/iRq9v5hJo+OH2YvusESawN4Z+ev+xnD4dmdzfcUhvk7+HjJyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PA3PR06MB9837.eurprd06.prod.outlook.com (2603:10a6:102:4aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 10:51:52 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:51:51 +0000
Message-ID: <b20fcb96-964e-46bc-b06c-0d0fcbf596d1@vaisala.com>
Date: Mon, 5 Oct 2026 13:51:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] serial: max310x: wait for TX to drain before
 powering down in shutdown
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
 <20261004-max310x-rs485-sw-delay-v6-5-3a0ef13ed9e3@vaisala.com>
 <GV2PR05MB119415B20C7D800FA6279CE4183962@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <GV2PR05MB119415B20C7D800FA6279CE4183962@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0071.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:15::22) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|PA3PR06MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0d6f9d-4178-47f0-6dff-08df22cea9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Rx98PvYNC83DPii5ZuaV065LrCnawhhF5Zv0FiOHvc/LBMReeyY0T5jHUXM0a8HtDEq4uzNA5L1MpHGXyBNNxyT3yCojLtj7APJb5D6gtOrqktMPw13Y3nj8fjPeLWfIXPlOUMt/YZqG7sX55QXRh32V07UpumJORsZqtjyxiORZbVQ/SSeBGmdqmUXNueu0VMtsO2R7uY5IhtgjjG+AptX2l1IeLp57b2HqZ1ov2F5Fh1WWPDLRnFY0ERdKjReXKwAEtsbbfg+F1uRAqsubZ2P2B30p4h2+JvpizYAhqnZI7xXW+/Iyb8pVvQiGDoNAYn1+8oxNQuBeigPukVF/kF+REAUJ1sB7aXrbtZZI50I1l8dmSiupfH9EUPQ+wjyp2Nz1FMuzWpDsznijogZEBHR2CSSEO5YgTGveDneOy4Su/K00uq3NcDHpZP6/L88nC0yrvnWZE+iRCAt9YL2oyU8oNXIsedBzYTWD2tcIDvlsnrN7pQtH7B3c76frDWZWtU6RGp9YgeuoGPBh8XMoA3bt7TUVS4RuozJxwhF6gclg9aLrb32fWhSchaa7WlckKK80j88EGHuwn2RMQCN6CMsKW4XV9huJcRbSC4GZZx+1PGQKoOlKVwE9HXk+rLUPHxXqnD+aax0QjgcdylKGghVOLvQJDpoKU0+Z7HJ/hdg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEppVzhoMEFyTEFsbjkrdEtEb3RBZUw0RFVxcEJpVzhhWlJHVUVmVCt4OWVB?=
 =?utf-8?B?TlRwSEJVRkV2Mk9KWnhubXo1SEJ6aUJDN1pUYjl4am5rcnRTdzhDdy9DNm1n?=
 =?utf-8?B?cDVzR1VXWThDYXU4Ykt4TGIvbVlUQmRITEJaQ0trd29VLzhDb0VKOERzUzBB?=
 =?utf-8?B?MWxvMm1QUmc4a2FNaUc5SHJWVTNTSE11SU4wRE9nVm82ZE5WZllUNGJYNzll?=
 =?utf-8?B?RURUT0VBQUpWeW10RkNwVEdaY0xlUG5CbytPYjJ3TXROZ0tEV1hWdk1qbUNa?=
 =?utf-8?B?dHJjN3U0bDMzczlUQzdueUZXeXVWY2xicy9rb3NSamI2ZEVycjNMek11bjhT?=
 =?utf-8?B?a0dDUUxKdjhqd29oZ1hJOFoyVnJVbWluTitDbnJOSFFYL1VsVUQxUVIrKzJT?=
 =?utf-8?B?bVZtK3dBYXgrQUFwQXJ4U1A3MSszUkw5a3ZUUi9BOWx5OU9qeVZZUEJJVW9Y?=
 =?utf-8?B?VFM4UjlwVUtwMmhaQmVJNWdQbG9GRHcxNm1aUHg4ZURmUUYra3BtN0xGVVlM?=
 =?utf-8?B?UHQ0cEIzQVdmV3AwNGg2ZGlsMW9ubTY3U1ZLZzRyVXdjY1VSNVV3bmRDT2Qz?=
 =?utf-8?B?K1M1ckRJNVFaekwrZklNUG9LZ2s5dzg5VmxMVUVydHVGT3BaaHhKQW5KZExk?=
 =?utf-8?B?amlhM0NrZnVGUFNBejN2NHM1V1cxbEFJM3c0QUMreEIwL1l3dzBBQkJDQktE?=
 =?utf-8?B?WndYYVR6Ujk4MXR5clpxQ2cxVVY3aWxaUHdVS1luNnlDaXNyRCs2aS9uOGZT?=
 =?utf-8?B?OENPVjBjMlBtV2ZRaGdncXBlUU9OOVBiN3lVWkp2aVZWS1RVQXBuV0p1V0dl?=
 =?utf-8?B?TzBrTHJsS0w3MzVBbGtzUURMWS9wSjFYdFllbEdIL20wWktkMnRQaXYxSEdS?=
 =?utf-8?B?UEN3VzRrWTJTa2pnVVhTbGMzeDl6ZWIrakpTZ0hWV2RoYi9oTVlPVzJaS29O?=
 =?utf-8?B?cFBSVTVHYkhkWTQwUEtkV3Ivc0ozT3Viemk1eHVMOGVEbzlYQVpHRndCaGtz?=
 =?utf-8?B?RFZQYkdRZUtwZUJ6a0lPdllQZ3dwRGJGNjJUNnRDSlZJMHl1MVBYbTIwSVZX?=
 =?utf-8?B?UWpzelNZbEpPc0loNXAyU2V6dGJadVdsRVozN05neGEybmZxNU5VUUF6L1dz?=
 =?utf-8?B?R3BBK3UyNEdkbkViK0dPb3V5dTI1MWRyN1dwOU92K0hnUFBaSVZiUE9NRTI0?=
 =?utf-8?B?VkpFMHh2cjVIbFNveDV1RTEvbEpKcGJrYjhQaWNaUFNFS2Zzb0QxTVFxR1dh?=
 =?utf-8?B?c3MvbkxQTkdXWGgvNWs5eGFHb1d2UCtrTDBPK21vK0ltaVNDcG1LN0tXMUdu?=
 =?utf-8?B?MTA5TVloRzI4bkZrWmtPNnJkZEsvWENPNkFRVHZtQWdKbU9QR3NzVkNicnFq?=
 =?utf-8?B?b2d4NnJLYTFHY2hMRFZmM0ltS1BjN0JBRWkxaThGRHRPTksvNmtNbGoyZ2or?=
 =?utf-8?B?OG50bVJ3YXU0M3l0a3BsSkJUZE1EVm9pOERBWnUrWklzT2crWndSL2ZwbjhB?=
 =?utf-8?B?WERuY21FZHlRaklQcytXUllIYWRZemZJdVlkUGRBZkdrRzdZZVV0STk5UU43?=
 =?utf-8?B?NjF1bXNDRVczdkZLcXQ5TUkrM2w3VzQ1RWJBVHpaYlVSNTR3OThlREk3bTc5?=
 =?utf-8?B?SVA1bkpKOVlKWFVHbWlncGI5RkxINUdPd0xpT2RPcjQxbUdHeEl4MXRhN2pK?=
 =?utf-8?B?c09zdlhVaDRZTmtTalp3WGMvL1NERW5BaDhkeVdxaUlxdENZYmsrZGRrWXoz?=
 =?utf-8?B?RzF0ejZRTlpaWWp0ODZoVXJtbzFWQzFGa0dsczNuRkJ2Wk1lKzc2OEY4V2kr?=
 =?utf-8?B?aUlvN3dwZkJYaFBLeFNUbmRuSHVKYUxVZVFWUWtxUUtNSTZzWXlMNGZrcDJl?=
 =?utf-8?B?UEVRUlptMnU5TUJqdWJFcENZUjVTbVJXTHB1YWZDUk9oUjZGQmxaZ0tWUnha?=
 =?utf-8?B?Y1kzeSs4ZTVlS2RodnZQTDRVZ3JxNjJieVhteVJYSnIrRVNycmxtL01vcTky?=
 =?utf-8?B?M1JmZWNNMEVubDMxQWRBQkQrMXJzRmVrZE5Bck9najlMblMrZ3didzBDVUVD?=
 =?utf-8?B?dnZoZGNDOHliTWpTYks2RW5FYjVTVmhsUUtkRkowT0V6aU8xcFd0VFFnd0Ew?=
 =?utf-8?B?RklIYnJNZlFkT3h2cytBRnd0WEN0MGROTzZreTJhRHhwYlVLQTdaVkx0OWhm?=
 =?utf-8?B?eUVlQWxCWG9NbnhGZkxTam1Cd0ZYMUpYM1NaSDUyYVlYbWkxajRYdnRYRXpa?=
 =?utf-8?B?dzJBdjFmUHFGdzVGaWtvT2k0YVg4alk4b1JhaWp4RzZBeEJMeXM5eFkvWlhB?=
 =?utf-8?B?ai91Q21GWFlham9XRUZCTXVpd3RPMXdrRkhJNjV1SGc0MVU2Mk5tTjhRWEhJ?=
 =?utf-8?Q?NioWgF94rLhdy9Bs=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0d6f9d-4178-47f0-6dff-08df22cea9d3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 10:51:51.9253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Gf9uzA/ivRX8vd+nh0oi8Z7CETIGMgGD1jpbP4JnlTVY6+JTfjKWY67EBwx6kC60czLId+uuVtGM5+QZueOdegl51Fo1Rwd1+H6iU8yaKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR06MB9837



On 10/5/26 13:12, Maarten Brock wrote:
> Would it not be better to retrieve the fifo level and multiply that
> by char_time_us to wait first? Yes, the (MAX3109) datasheet mentions
> its value may sometimes be inaccurate, but the worst that can happen
> is waiting too long. And after that use this max310x_tx_empty().

That would tighten the loop, but v7 drops the drain altogether - see
my reply to the review bot elsewhere in this thread. Draining turned
out to be wrong twice over: the wait is an uninterruptible sleep of
up to fifosize+1 character times per close() (~26 s at 50 baud, and
unbounded when CTS flow control holds the FIFO), and a close() with
data still queued on the auto-RTS path powers the port down
mid-transmission, where the stopped UART clock freezes RTS at its
asserted level until the next open - reproduced on the wire.

In v7, shutdown() stops the transmitter instead: MODE1 TxDisabl lets
the character in flight complete, data beyond it is abandoned (it is
only still queued when the tty layer was told not to wait for it),
the FIFOs are reset so the auto-RTS engine sees the transmitter empty
and releases RTS, and the power-off waits the configured after-send
hold plus one bit time. With the transmitter stopped the fill level
no longer matters; the remaining one-character wait covers the shift
register, which no level register reports.

Tapio
