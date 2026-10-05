Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022080.outbound.protection.outlook.com [52.101.66.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387348B37F;
	Mon,  5 Oct 2026 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206474; cv=fail; b=KzwRsnZrcrOkeAduWoX51RR/gPITjXEp8qymfy+nTX8dTUexGPwJ2UZ+i8d5M+Bk+p2hAaSmTITJFZ1bGuBzj/O/RZk7MsyBsTE8y1Ts39Zgi1FN5niMg0rU9gMSxFaC4Q+Ar7nsA7tpM/S54LIqJGbUM3IBjt7hpcIWs2q9lpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206474; c=relaxed/simple;
	bh=PdLOMwp6EK9w0jElHyf3mZq3J5zhzx9wDoD4vh3LIto=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iJeRHdf+Ox3N22LJ2srZg0XqeDe2Vt4zTP931ou7HYjinwolO47Ux0AspZCNZtFoeHm9n4LlEf3JI2EdZK8WroIHwJfCGCXDQTsFhsCI+paIvslIy2UWF04+dOdc2eJZYl/cQ4RaNqyl9UWLs0U/Wbo5tRhz41SKnJwgsm/IwIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=H7scdS4f; arc=fail smtp.client-ip=52.101.66.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="H7scdS4f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UX+cMLbikgtQjw5gRUzPk6Gd1Sr3iGoWqC0mMJNitZ8hzqbK7Jh8AKEfSZBnN2yhgBfPbH9FdW29mT7GJRDBbQ2Gb97EE+qeqJNJnsfTUIJBgacWFrih5PiCqBBp3UDdNWlLi4GOsiXqhIkSJVQiAgsV9t6LlDpvBNYBRf4KCoagIPmurc12qvRyE0UkwxE6myR5mMZmRUQJbpx8E70WLhNbsiYZC8i8ITgAtUS7qC4zmqgAvZSs/WdCnY9g9cQFDe1neLUdVOCQPzRrVH34IvIvtr/JwVFT2CZY2fGDqKYysrhHuYAQjxAcw8f6m3oeF7y9IrrrJ8VNMpHuIxTngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnFy/d19nVKI2iDgW0YQnzZewt5hBOlU9FqKyol3LKA=;
 b=rBSDrZiqK8UoVBsNZQv0g3SG8uWMwLIBdD9cYFR+0RWmtIhPstkCAvk/JOoiJdkEPAUMd7t4v3D11+rJ6gUR5HBDYJA3zlu71f7/TnOpCzNj93yUl4mcnBsdcBrxO27pee5CnJOj+HOFt9/9edKFxVOTJwZc+ePFZywf1ZM+8yr0yXjHL86SaxoYUiAdxjsFDj7T/LaJ+NqkWIbxhH7uaxKLegvpfU7hZtWE/nuxykKBh6PY2T3dBQZxpaBc9XDnRbL4M2t/1b8735xj3yvxO0YvnWjGC3wVRTPiwwetVrVlTfckMVIbO8LwTmGRTq/aqa2HwLiJRj3dTbwonGFfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnFy/d19nVKI2iDgW0YQnzZewt5hBOlU9FqKyol3LKA=;
 b=H7scdS4fCZLAwo6Mjof8i2ueC0ft+QuqISTTBmg1XM+jLNRhB5KWf5CPNqp8cZfCz83RsNv/BmRofNx4gppffI933I5yyxOLkCu/NsgmslJjfimQWExoXAvDWwVCGzQ7SZBgnsaSao/OUlK6Uvtz/5c8rU6aftDZXL6meB+vrhvoT1tJbRmQVKP+vzMkdjKOBDq0dOKMQfwzsnzAIP8cr/si0nd2jjqirDJl9DNnwIUUv0/GH/pC5nEmzBYo67C6ZOB0UgiyYTr5oW9CwDutqyuHSXX7S9ef9wt6nOqnAHfrLcQ6RpRzR+5V4ppZkF0L8K/R6ybsHi32jfX2z4lYTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DU4PR06MB10187.eurprd06.prod.outlook.com (2603:10a6:10:622::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:19:59 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 13:19:59 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 05 Oct 2026 13:19:37 +0000
Subject: [PATCH v7 6/9] serial: max310x: support active-low RTS on the
 hardware path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-max310x-rs485-sw-delay-v7-6-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206394; l=3681;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=PdLOMwp6EK9w0jElHyf3mZq3J5zhzx9wDoD4vh3LIto=;
 b=CRDX09jAx+IC525SJZzOSb95BMChM1zG/4gKZJhIyu4uSXXJaDUfSS1K37747HQfen5m5X7iv
 KCYd5im1amwAWulirfAbD/7HhCRfo1gDSEJ848EJvHUNLY4/5LYL4Mi
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
X-MS-Office365-Filtering-Correlation-Id: a657be11-0283-4eda-7d01-08df22e35ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|22082099003|18002099003|38350700014|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	0qeTQdW6IeCUwrAuQOH4MwnuJLUTtrdPgoa7YSzqbVUNFwN6fFabAJHkkf9oStv71KjqpTVsXHSmGl8Z8zY2+SL+JmY4u5agVQqUNDgneIK8JSw/EyMYOe3Pg3jalSiXKbMyhtxjn+Ny3gUDd2yH3zikKW2ZREcyIkjQ5XQcrFSGAK6iN4HbsQd2JZvAhRshTcxezYwaAvnDvVwB8ezoiyvyZletSYNlD2W7SHatWEL//DMN+86GOrbCGsDGjTrM0r7e81d3Fxxy8ZR9cX48BoAgAunyqUDAV3DJS7xnYR0KMCrmLi68HhGWoJmF5ZCIM/YqH0/rWwvuwHmEX34Kpnwcay9wWS2Pm4/Tcb9oLKXrs/vr6sERHl+FHccz00hWv8hoYHhVw4RWZjzU2omA1Mrp2IdZcfiHdsItk0Av+4RqeGKA4bNGJRgpx8jRN0+4e1S1X57X1f9W+nDKRXXXRorLIIfHhXGDCDrMz216Rv9fK4WCp0335td9U6nYaHKH7LLGR3ZzZ9LFD3p8aZF03qeEDW0eboKpDHTGsFs3WrwNyfi3SR52DXCF6IVMd80+bb14n+AO0zuZv4MQnVlSjA+RfbyrRsKQAgGITNP216073xdcj9V/+KcIT5HaNBF58EDAWwLG8VU9ZVLlUSwBPihX6dPPDrJCM3ctLPc+cTnqoaVvos77B53xg45ToKMDF7YUp44X8K4DmyE8QEF1Yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(22082099003)(18002099003)(38350700014)(10067099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWw1bEtUTHhCa0h4VlJBQXJhNjBPbkpjSVNydmpjSDgvOC9QSUpCMVpIMkNy?=
 =?utf-8?B?eHNUTERBRUFGeHdabjZJM1NGUk1zTlJUczNkQS9qVkM3MHpEV09mTmhGbGRa?=
 =?utf-8?B?Rzh1UkY5YyszUlpNMkRydm9QdCs1dldWZnY0eWJwbUxoNXU3d2hIMFMyMXcz?=
 =?utf-8?B?U0FKa21xNUp5QWRzK2FGZDlNbENEV0ZTeTh6N2dJamNtZnJXRXNSdHA3bSt4?=
 =?utf-8?B?SHNnVEw1Q2dSckh0VUhhUC9rTWN6OTRqRTZ4WEgvTmFaOFRUZ3pOcmFvaWJi?=
 =?utf-8?B?SS8wY1VJVmVrL0wwWXZ3ZjUzUVZyUmNJdmZPVzh2dG1DajZ3L2F2Z1B6Z1cx?=
 =?utf-8?B?QkpSVzVsQjMvSE00aksyd3lsdEwvQWJ2NmN2dDNhVm03WVAzTWNJMjVIdTIw?=
 =?utf-8?B?N0F6djJWZE84VlFSQ2xwK1lBVlpsTm1qbnVmL3o3aFUvYXVGZkdHd3FUUWJM?=
 =?utf-8?B?N0p1REVSd091TE9oeEV4QkZlRWFaektTRmJlVVZwdzJwclVVdjQ5VFNaQS83?=
 =?utf-8?B?S3Q0cXprcW9kOEh1SlN2S1ZSMG5tQmFacFV4Zld1V29ERGF2M2dSWVhvekVT?=
 =?utf-8?B?NVFNNEJFRHcxZnJGZTFRZ2VqMGRwMEtOWnZZT3dTUEV6Z0c5REV0dGZuWW1N?=
 =?utf-8?B?b3FhemFQV2IzK09iVk9jalRuaU9XMm5qaWlpUWE1dEpiMHo2Y2txTExXOWRs?=
 =?utf-8?B?RnMwS0VMTmFVUXB1V05jK28zUUJweXlSa1JublNUMlZSREdVLzQyTFRtQXUr?=
 =?utf-8?B?MXhEVjFQSzR3ZVd2NXVTWDBUVVNiWkM1L1lBNkordytiN0QyMWR1NnN6TW9z?=
 =?utf-8?B?NEdZL1ZhVkFHTXJCZU5BMXo4TGZWeUF6UXpBeXJFV0FVQ1g0UVhVeGt6MmRX?=
 =?utf-8?B?c3B0ZjFGM3RhemdkK1kvUURsUlBNMjVOVjlQVnF2Tlp4VVh0S29US1ZRYVhL?=
 =?utf-8?B?K01FTUVJQkhueXV2Q0QxdGdsaE9ybHlWTDhINnVzU011dEdHVm1RVU1rN1RF?=
 =?utf-8?B?Y2xqQnJ1YzBNQWE1a3RQUWlVcFJXSTVHd1FHSTVocTdHZU1sM21LT1NYMnRa?=
 =?utf-8?B?TytIQUxaN1ZmNFFaSkN0aktxbjMxYWVzcWtnbzdYcWV0NE1FSSt0YitJRk15?=
 =?utf-8?B?eHlEeCtDOU1TVk40WFNHekNFcE14SkpNaG5ZamoxbGJESXN4N2RSUE5qR2FW?=
 =?utf-8?B?RStIUkg0WTJJMjJWcmhLYTBtdkVaZW42S0krSXpKT2RmM1R1SkZzQ2dtV3Y3?=
 =?utf-8?B?R2lFSHNPbDJMUXFtT0p6ZEREQ2Y3MTR5WmNCa1FFYVZkc3ZJMUhTcm5UZ1hV?=
 =?utf-8?B?ZmdacmlYRHFlTHJMaEFDTVFOYUluQjNtd2hyQ09jRWEvSG53c1N1WUNmZlRr?=
 =?utf-8?B?ZVhaV2IvR21ZVlgvRzcrWDRvTlhqcUgyaDNRakdiU3BOazVZb1FWWHhYa1ZP?=
 =?utf-8?B?S2JTTDM4OVM4c0xNSXNCMk4vbkMyQUtWTkVXUEhKNEFiVXltS3FYSlNEc016?=
 =?utf-8?B?Q1Vua01PNWl0aFhXd2U1U3ZLbFM2Y2lHZjd4M2F4NXI4TE5PNTE1MXo0Sm9O?=
 =?utf-8?B?ZVVKWlFDbEdPM040WERWbnZYbU5VTzBMNnI0NW9rUUp1VUlodDdIR2JRNmp5?=
 =?utf-8?B?Nzk0RnBRdnoyR1E5aWNlZmt4dzhvMm9aYUlQWmwxei96QzBlM2tPN2ZXQUZH?=
 =?utf-8?B?QmZYM2NZRWhNN29MVzFPSEEzWWhENm9RdmpxbHdDQnFkTExBYzYrRUpBWWtl?=
 =?utf-8?B?dUxBZ1pPcDNFUDJqR3FNZkZFZUNuSlQ2ODRWaStxOXB6TUhpT005bzFkWWpo?=
 =?utf-8?B?UXpYSGEzcm9Bd0FtTHZ4MnBpd2dGTHdLSmRyZ2VwSzVFOWMvNVVONVVQQ1ph?=
 =?utf-8?B?TE1sWGprd2VHOGE3WXdBaUJzYTBhWkM0dFgrNTNTc3BDTStQaW1jZGppU05G?=
 =?utf-8?B?OGNXbmhqU2pqSmlqaWJJa1dmcms0MzM2R3hFcjI0QWRiaTRaZzEyWVBmS01o?=
 =?utf-8?B?Vm1LTXJiaEZRcVNtVlBwTXFoRklQM2J5dGY3SUZXa0FDclhaSmNGTGZlM2Vm?=
 =?utf-8?B?aGIrRGtoY3dscll4ZDN1THNkZk5ubkhGbzY3L3hTRTZQQTFObGo4QkpZNnZ4?=
 =?utf-8?B?a0JSeU1MaTIrMGJFY0pSTkNRbERsc25YVWNSKzN2NVZ3MDBPVVppTWdyejBz?=
 =?utf-8?B?ZmpaUjJRdDVyc0Z5UVNuM3VJbjRMcllXTnRXS0xLclFuek5lMmEwRUJtQVIy?=
 =?utf-8?B?N2NhTDIzNHpIVUF6ZTN5c1U2dndxeXo5Yzh5VjVMd1lXV3NoT2dkY0gwY212?=
 =?utf-8?B?S0RrOWZIZmY3MUkwMkRpVE56bmEvZVdqSnNvMjcwWUtXWVl6SU90bCtHRXJS?=
 =?utf-8?Q?iXqF6P10oEczVnyE=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a657be11-0283-4eda-7d01-08df22e35ab3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:19:58.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZhvJ4pF3acULew2QFV92UNplMLcj5GrWDnRYLzPYp9vfo0YLjQGmFvRIfShZq2FVxk56gMktIlR3kd50jQON90M1r8ZhTjmxzKSn6trwpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10187

The chip's auto-RTS engine asserts the RTS_ pin high while data is
shifting out, so a transceiver with an active-low driver-enable could
not use the hardware RS485 path at all: SER_RS485_RTS_AFTER_SEND is
not in the supported flags and the core normalizes it away with
"invalid RTS setting, using RTS_ON_SEND instead".

The output stage is invertible: program IRDA.RTSINVERT when the
requested polarity is active-low and advertise SER_RS485_RTS_AFTER_SEND
in rs485_supported. A break already drives break_state onto the RTS
bit unadjusted, which remains correct because RTSINVERT inverts the
output stage itself, not the register value.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index e08e506360d72a3ef4c0ebdca2e60d864973f909..0c40283f44ba1df712607218aef24cb642ba3918 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -164,6 +164,7 @@
 /* IRDA register bits */
 #define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
 #define MAX310X_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
+#define MAX310X_IRDA_RTSINVERT_BIT	(1 << 2) /* Invert RTS output */
 
 /* HDPIXDELAY accessor macros */
 #define MAX310X_HDPIXDELAY_SETUP(val)	(((val) & 0x0f) << 4)
@@ -951,7 +952,7 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
 	const unsigned int max_bit_dly = 15;
 	struct uart_port *port = &one->port;
 	unsigned int setup = 0, hold = 0;
-	u8 mode1 = 0;
+	u8 mode1 = 0, irda = 0;
 
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		/* Convert milliseconds to bit-times, rounding up. */
@@ -963,6 +964,12 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
 		hold  = min(hold,  max_bit_dly);
 
 		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+		/*
+		 * The auto-RTS engine asserts RTS high on send; for an
+		 * active-low RTS let IRDA.RTSINVERT invert the output stage.
+		 */
+		if (!(port->rs485.flags & SER_RS485_RTS_ON_SEND))
+			irda = MAX310X_IRDA_RTSINVERT_BIT;
 	}
 
 	max310x_port_write(port, MAX310X_HDPIXDELAY_REG,
@@ -980,6 +987,8 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
 
 	max310x_port_update(port, MAX310X_MODE1_REG,
 			    MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
+	max310x_port_update(port, MAX310X_IRDA_REG,
+			    MAX310X_IRDA_RTSINVERT_BIT, irda);
 }
 
 static void max310x_break_ctl(struct uart_port *port, int break_state)
@@ -996,7 +1005,9 @@ static void max310x_break_ctl(struct uart_port *port, int break_state)
 	 * The chip's auto-RTS asserts the transceiver only while FIFO data is
 	 * shifting out, and a break is not FIFO data. Disable auto-RTS for the
 	 * break duration and drive RTS manually so the break reaches the wire;
-	 * restore auto-RTS when the break ends.
+	 * restore auto-RTS when the break ends. For an active-low RTS,
+	 * IRDA.RTSINVERT already inverts the RTS_ output stage, so break_state
+	 * is driven as it is.
 	 */
 	if (break_state) {
 		if (!(port->rs485.flags & SER_RS485_ENABLED))
@@ -1416,7 +1427,8 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 #endif
 
 static const struct serial_rs485 max310x_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,
 };

-- 
2.47.3

