Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021074.outbound.protection.outlook.com [40.107.130.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7AC48C3ED;
	Mon,  5 Oct 2026 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206486; cv=fail; b=fjegIrwy0ppuLlcnJP8eBPA+dq4spOhxPgrX/Ga5BodCjlUfc33AFo2ojPL9Pxmx1KKXHQoY48xTatE5Ep5fTuc5ZgJe/AEsmnBq6khTMFvqijdJgK3DFZP8/bGp+qQtGlBEKTj+8sGQER6h373H7M1ynS9EIeXn2h92ZzeMznU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206486; c=relaxed/simple;
	bh=ze+nqhK1SVJtloL9Be7j55ofTH9g7XFiZwFWiSjaUaE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DZDd0cz6wfQ8j+NWxw27RLC9VQoMUq1R5Jk2l6ya0J3VIJU1wdu9HNexHpzkWfqyOPVNBPTrFYFIgPjz268PgrE/otn5RnDw74JJzIjLvKV9HwqtUa7AVa9YC8Xo+qUZvha5F89Lf+Fk+7DqwL2BDCe3ELAfZiTZ3AL6P36DSGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=UGcioVqS; arc=fail smtp.client-ip=40.107.130.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="UGcioVqS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v30E5FvDw8Y5DegrRpfVEmSKXmvq7xUclPW4V65PM4ZBurV8oG+nOj2+2Mrq43X/g9rhhL6AR+DsiOlnxnZhnTBGflF+QwZ4WqHHpC5DOpHlfnS88l+c30g4fbjH8uCvMt94EouLoD0GvZyiruYBs1fST9+TgTKR/3doT8G8xZDbYDFIpyu/v9OlHb4KKDGQCvz13DRjuTKjHTk6Nu/ATui8IvNKBt2yskzLR+b0Hyy/FqV5+ZA98IUFnLGby0HqGGRs4N/L5zdHlJ1CP5R+CgatJauawl+/N6GrLEATNHsH25cTcoQqp/7G7t4S/Q9yxweVittpwzqqkXPX+F27nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ0ljU5F7/Yi68hMdY9UCpdDLj14mW8Ako3HmrEALEQ=;
 b=VOxxUhkF0U7r/ORo+N/wgosQ4PETzQrNxw1LdCjFkeoeqp3cp32PsdCR539YbJzKvt58apQE78e+h4Y21cvF+udy1UOAfgBlas5rZS5YxnPpcQtj2YvA691FdE0miT1lvx6lXpHqz7/SGiV5Cb7bOAcKdfbZ87IAO1BFV4W4GpptGb/xWF3b4NRUSGU3VlCuv5ko/h0/OvUYIxNeGEjHQVC3jRJZzGFsDGkbDOv2nVERTY/ZlONAuksfAgEs2aVFu39z0Qh95CKm+T87eTx9cdD2TBAUQ6uh859+Xo0cJ+1ypVl0zCZYyvLCxPHW5lhTGnBTpS1ncGfAMEyuHEh/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ0ljU5F7/Yi68hMdY9UCpdDLj14mW8Ako3HmrEALEQ=;
 b=UGcioVqSj4YGG+TaI0eDZAdHjyEfIvitoiEHEC5JyPXJn1OFUyMrArUCQxQWcguisojua0/Pjs6/MEsehBerO4uwgg7ePye/KsmufaBI2IARWo0JtOGNroz8m2iCiIKTtnPgVhA28XXYHB/tZSeoccBmzWIC1AIiuMn9aRAWdC66wIHbBiyoCyhCHcmZfx/1L6Lf8M1eZajA/F2CktW7iF9nyC/xAAsYVMpw1j7pWGHjC2MQYZK86cup9lOTREjCGlpBgC8yc9pvZugstvJDZCdvOOfe4+ShGeeE2sRDtypToq1zFdZz7zf3MV1VWBDvHJ7ptcYfi+eMTO/OEzKVYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DU4PR06MB10187.eurprd06.prod.outlook.com (2603:10a6:10:622::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:20:00 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 13:19:59 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 05 Oct 2026 13:19:38 +0000
Subject: [PATCH v7 7/9] serial: max310x: schedule tx_work directly from the
 IRQ handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-max310x-rs485-sw-delay-v7-7-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206394; l=1761;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ze+nqhK1SVJtloL9Be7j55ofTH9g7XFiZwFWiSjaUaE=;
 b=YEKtIcpc313/XHMOpKYOKNgTExPOUCRSsFxqk/MI7j7KLgLYsZXDQSv+kXYSkSLRWHWJ7N/Us
 MvHfxeL6lfLDSZQoXmSmDxgUtq/Wpzfex6OLqNaWWUJoWfc19tjL6vD
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::16) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|DU4PR06MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8030fb-16db-47d2-9a23-08df22e35b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|22082099003|18002099003|38350700014|6133799003|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	hCbnJDSxcz6iklQU/GtKMmolaJurabRASv/AVTufYufpwlwuCue3Q2Lut2XIPd9gMCnrc9lQGxrvLdu50Bbp4uIeViIgTNiUwfidzgDzJXmWLcl3FIJDnBe/s5Q2T10fHTipYjcynPqmydYHIMoJzvhIJ6mPDXYtmo8obbJ6l1VpSRlMXD+xJh5KY1YjhNKTWCX7RMXVIO/Ik+XCVMQdGjexfGTLcAZOgUij/U/I/9P6oSHV9aBAsAgWyNYNdLFZpDzBS+QpDIUBjh7zKXjFhQW5gKTiIKFpH+PZ9I+geekRT/4UwgFyQ3KIa9vH6AeWT1s95FQczxpiqvh+98ah2MR2a0901KARdZWObk10K31XVh6LgZ03BtANDKNFUbWXXKwaCJuijSA6s/s1qcr3F6+LBG8m5jgv45hoYICToeAOaXwwvIxkO3G5po1ZlI8YeR2n4S5LNNX16W0oKmc46TWsN0iVpq1dOwfAJNMug13oYeVMT5W3Jos/JpWMR7n89yzF4uJ+NGIcOwcy3Rj7GtcfqIpvEZ4IcpforkUxkTQA/e8jG2SUGuwtJCFegrNlfjWpLQqqoehj6ab4WYCK8PDNoDLe2xtTQjXUCiXm0lgUUPRn16y8Wi3wd15h55us2z1sdlDC/+vRNHjVzmbASWX/prHSt6BG5ENY5lM0rOUt+qJ4uNPXyDl5Ew9keZx6KEch5WXX9RhxSOZFrUeUYRc8ot2iR1HKi/PQqnbYmMQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(22082099003)(18002099003)(38350700014)(6133799003)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2VGQ3hPcmtQY0o1UlQzNGV2TS9vVXhXbjRRMW1uUjdqMWlseGQ0aUpDUng2?=
 =?utf-8?B?SlZleUlXTzg1TkFTTklxM3RranJRam5kR2w0NnpEUkQxQUl0MkJmeTc0akhQ?=
 =?utf-8?B?SUtKR3pWOUdNSk4ydEhndi9EcEs0NWtkSWUvaG5NS0s1NTlaMGZzazVtNFpN?=
 =?utf-8?B?UWh4c08zM2dRK1RCejZNQjdkemx1WUdZZGJiejRRVTNpSzJIaUw2bHZVTEFT?=
 =?utf-8?B?bWdnWDZZQnhieGdwckZpK1VVd2YrWGprTjRTRlVVUjdwdHduLy9waWwvcmxB?=
 =?utf-8?B?eC8vNVA2VUkwVVFLTUFvTVNjTFozbXRyYW9DcDdSUnhGR2xndXZTQWRnNXVa?=
 =?utf-8?B?UWxCS0NySXBwRkE4cnFrSy83aEkzZ0pCdlNoSEc4ZUVYaVNxWFRrMmp6TStN?=
 =?utf-8?B?aVV2STNHN1llOXNJajM0S1R1cEFrNjVRa20vcDB6Q2hUWkMwWTBrQXd0SFhJ?=
 =?utf-8?B?S0E1dENUTjFvVUMvNDFCZStjRUl4aWVVR2Fub1ZvMUF0Tml0SWVYcWJUTjRl?=
 =?utf-8?B?a2xwTzhFQXYvYVRXbnZxUEYveGJSY29acTd5Z3pZVWxJWWs4TkpqZG1SWkFZ?=
 =?utf-8?B?Vm13azdxZ2hBYk5WbTBaVEFUVE1KUFFGOFVOREt1NjhXdUlFQ1ZNcGlDVzRX?=
 =?utf-8?B?VDFGUU8vVERDOHVQei9YYjFGZTJXNnhHclNDZ254bFFMRFFrZkpYTFVLajh0?=
 =?utf-8?B?enlUdXlsZG5YNUNhREl0cE1FTzZQZHkwMXZVdkFoclBVaWd5bVpVZ1F3MzZT?=
 =?utf-8?B?TmZVVWMwQXNxQm1IRGF6VFZqbUo3dThNZjd0TEFEcTFYWVFaTFM1YnVsejdz?=
 =?utf-8?B?WlNCL3JSWnhiOWIrN2JxUEllNVp3TUQ2RzhFNWY1aFBVdVhoMjhYRXpaa2NI?=
 =?utf-8?B?eVpjUjgwZkwxRTMxWjdHY2JzMjNIOWZDZkN4c25KQmg0dHZGOVJmcEoyYTdy?=
 =?utf-8?B?WTRvdHhyOGI2YjJBd1VZTkN1TGZUdlIycEJhcjhMV2I4S3NyeEhQOXNwRWgv?=
 =?utf-8?B?S2g1dWdWK3hnbFRpMEpraEtYSGh4bzN0VXhraFp0OGtNSEV5N2tCdC84VDFE?=
 =?utf-8?B?c2lXK281UCs1eDBmcW8yMExvcUw3RDRzcU1QQWk2VWZOQ2V3U0VtcmpremUv?=
 =?utf-8?B?MzE5R1dBMElha2hoRlV1QVZ5alZyZDZrZ1BiRUdoTG5SQmN1NDJwYVBZT1lt?=
 =?utf-8?B?REp3Zko4RWU5d0QvVFRqOGdQcE9ZVG54b3VwbHdlUGxvRE56OFlLMjRtTk9t?=
 =?utf-8?B?TU5MNTR6N1dONHRiVGtWWnRaSmVEQ3FUeW5ydTc1Uk1sQXQwUEJqVlB1M3po?=
 =?utf-8?B?M3YzcTRSTTdnZndiUUgvdndScFdnTmNjV2tJbzZRTW5rQ2NrMG5TeGpzdHhB?=
 =?utf-8?B?cmhEZEdaYXdlL1ppeXJxTWw1WjJuRFVEVkg0R053NVl3ZUd1Q2k4QjNFRHpT?=
 =?utf-8?B?K2F4aTVhYjFLRVVmN2xYaXlSTzVTclhPNVBOcE1qd3JjUVFJdmsxWUJJMjM3?=
 =?utf-8?B?dXM2V1lDTVBKQTRvUG9PaVYxQmhKT0ZFZGpPYUlNLzJUQjRQbU51eE9nMkFJ?=
 =?utf-8?B?eGNXZEN5N3dRRy9YMFNUQVU4cXBmWmhEWTNSTjNMMlRYNXd0UHNrOFBSUmMz?=
 =?utf-8?B?NFRRKzhUSlpkMkhCdHR6RnFXSkZ6M2Q0VDM4cWRZMCswUWljRHdnQXJZMk5u?=
 =?utf-8?B?Q3hjTW9LWS84NUpkTmNBUXNKdUFNY2tqUWlERU56MTloM1FhVlN1bjFLbkt0?=
 =?utf-8?B?QUhCU0xSaHI5L0Q4aGkzSTlyNWdDaVovVW01aDhiT2F4RlZuQlpvYVJ4MkVM?=
 =?utf-8?B?ZTV4TXNZVUIwbEhZTW1ZOXV1eFhJcHNMSmZ4Q0lzZlpHek91TG0vMEsxbVc1?=
 =?utf-8?B?NGpmek54MXQ5TDQwaThXV0ZJZHF4bmV1L1N3cHRQK2NKdmhWNitrTXhUV1M3?=
 =?utf-8?B?eWtNcnJTRTBoSHZ6bVkvN3dEdk52MzUvclZqRDhFSDFxQitPRDJNWjVQd2dL?=
 =?utf-8?B?aUN5YmhFVGRoTXJEblJRVmw0M21WTk9uK3ZMSXNhbmI4TU85dTRSSCtnNVE1?=
 =?utf-8?B?ZXQ3NjBabHdxczN0VTRhOE1SWGk2V0NSZ3pHZ3hITkEyOEVnRXdWdUFJZ0Js?=
 =?utf-8?B?NUN2M3ZKNGZFMzU0K1RWeWtFdUYzcTdWcFJsNHFiVzhDaWFGQXl6WXcwRk13?=
 =?utf-8?B?d2dWTS81TEM3RjR0bmozazF3UlM0MXRHb0lnRnhQUWVrUG5FRWVSOS9FaWpj?=
 =?utf-8?B?Vm9SR1p6YkxyYzMwYWlTMFpJK01UeFRHZm14Rkd3cXBsY3JkTDU0c3R6QkZN?=
 =?utf-8?B?NmpjclJwSG9HV0Vqa2hTOU5QUHJtb2JkUnNEV25EVHg1Rmt1NG03bHBtRDNt?=
 =?utf-8?Q?w3thdb6QMvagfx4k=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8030fb-16db-47d2-9a23-08df22e35b30
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:19:59.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsx7WDBAOQsw3g5Ov5sS7IeUTcEEQUuKiH/9WkZbt6pHm4tIYLo5lFkG+64KavHEFYl4hMtLOA08+3Nva9A2Q/ygKfb3GN5FzCTLcY/F/OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10187

The TXEMPTY interrupt asks for a FIFO refill, and start_tx() does
nothing beyond scheduling tx_work, so going through it makes no
functional difference. It does conflate two distinct events, though:
start_tx() is the serial core starting a new transmission, while
TXEMPTY can only fire for a transmission that is already running -
the bit latches on the FIFO's non-empty to empty transition, and the
IRQ handler's read of IRQSTS consumes the latch, so a stale TXEMPTY
cannot exist on an idle port (if the bit were level-triggered, the
handler's read-until-clear loop would never terminate).

Schedule tx_work directly, keeping the interrupt path a pure FIFO
refill. This is preparation for a following patch that adds
software-timed RS485 RTS control, where start_tx() also starts the
RTS envelope and a refill must not restart it.

No functional change.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 0c40283f44ba1df712607218aef24cb642ba3918..c1fe4ad8878392613cbe4d7805eb8ecb454176d6 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -858,8 +858,12 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 		}
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);
+		/*
+		 * TXEMPTY latches on the FIFO becoming empty, so a stale
+		 * interrupt cannot pump data during an RTS setup delay.
+		 */
 		if (ists & MAX310X_IRQ_TXEMPTY_BIT)
-			max310x_start_tx(port);
+			schedule_work(&s->p[portno].tx_work);
 	} while (1);
 
 	return res;

-- 
2.47.3

