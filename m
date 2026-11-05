Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.86
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793862791;
	b=BrloMPnU/YFBjHD1b9HwJAgAYYUBwRsIbWMqnISsMGIUSaQRZiA13bk8ZG/6p+v1J6Qi
	 zkPNJ/ATowz30Vrq1deJXONLKPIiNt0lB5xvX9AR4/UyYkJdrebnLbyoukesJ+qY/sJhi
	 M54ACLc+mfv+LmmbtYD+PtNf4vviaxdnknGiHwnTwRUiVMdm2qlBcEU4pbz28sUH56dZA
	 JXaQE8N16VralQA1i7fPYeYthXRjikf3cbSa5DJkREGQpwcqK9V+H+wmuyyVXEj7mB33B
	 2ICEXKbKuSJEuQC9XE5yGrjUdCR5H1ZWjdq28Xc0Gc/zz99jKIte8mR5yspKRahz63g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862791;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VLD3S1pvnvayU8UANz6NSPgC30d38FpHHSTHX9Ku/j8=;
	b=rY2idS45xGCnBVx92Bub077qed3EvcLvioaylKZFwmNPzz+3vwQHB9o9n9jrLE2jFmN+
	 DOU/Dm77zyurw6Ge/qiaskm73/a6yPcfTkiG9WEMBOXyKnabW83IzFeskWylWhXxUKI5v
	 UnXGdD8Q5mAS2wdOQi2MKopDcyygkONbtWhgshFzHtQgJtpABivIm70ikhhMyPOYNead2
	 tTM+KUi3EAb8Wpwib17ogI0XhSCoEnTZL4s+EIOymJmpdAFHaMpCFrZUyTnlJMw/8KF/z
	 myj8C63c3z5tl63bGn3A17cWgUG70KpL7ha7eWBbT4Yk6EdHdaa7nRdVL6pZPQ5Dzcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=TyGgZksQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.86
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023086.outbound.protection.outlook.com [52.101.83.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11320606D804;
	Thu,  5 Nov 2026 07:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11320606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=TyGgZksQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODPjEq2v37JPw1iGzt/z2DryZgeoY1fVayv+8uGXNa3myqKS+KXQCMw+ThlwMzdqAsknMBMQUgqcY3YnpPB75gH0B1IGxjvo1WVbB81rtQnoD8vl1uNd4NUt8yGiVBNX8g8u3ZKlNHm1W5HC/QUE7nCkk+aj1sR+mFIB/GgYJxHYGayoYUiSCkP55fmr1Qo7ExXS0BjpRkuHKNDbBTlqUoQafNBWpHSgAT5CsYoA/EVjtGMTrtHp/zhmjutE1+fifY4RlAHUaWRDbfF04Koewwhnss3DUpTRZ1RQdpWVmLkVKcNa8RMFKnUYhsvS0URSNyrAXYFIPjF2XQurcuGdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLD3S1pvnvayU8UANz6NSPgC30d38FpHHSTHX9Ku/j8=;
 b=yvgaRmqopXUcaeRxNYPC+Ym9tqKq+CpXIUwYfc9Pc0K4G/CPDKUfdnz0fJaHYuokoja9c7474pcYyK1xZKTZ8FtZD0CF4+vhiZKEncdw3BErweYytAIWx4DrXrExDSYoxEB39ldq6vaCwYz0hCd2gyJp6vIOAaqI0GVvOs7IpIDfEt2O/ks5V9e4+8zeUSZ7kbdvmQ16FuzVPaj34PlatV4z7rj0t8tvYTpXG2q1kRHqyRreo2YFWh238XeXJjDdJYe1fwnu+fjpNoyEpLtTuKwoyFoQ86VszarMy2jm3YW0D4MUDu4rWmk/WGkRNxeVboq48c/ajPBnF7gLfxBKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLD3S1pvnvayU8UANz6NSPgC30d38FpHHSTHX9Ku/j8=;
 b=TyGgZksQTPNfSXYvOynXtKC8QGEEZ/WSGpINtxkbt0nF6lPMOQXo4spmiZk2I0JwexJ1M3DeUCKhn79dYi8wCrY0+5wa0+32Oex0/8efnRgpfgyZULOa35SQk+fRTo3E/evyIWOSBH+bHA6/vziVOt9lD8T6Xf1BFK3BufhmbXmJ9p8P/JpxdY+UaINR/bjgXRK+uGavf0lCGihvLXUL3FOqc4CAA9acBg6oYMHPDKKuoMbJH2J8Hufk1ZNxVAJQfNLxMR3MUdvmBoOEbu0C1mRId/6pUVGSIB1aB8nCP+f7vGof5mewrKiyfOSuB8QSfqGh9V5auRDRHMPNtmHq5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS8PR06MB7877.eurprd06.prod.outlook.com (2603:10a6:20b:3c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:12:53 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 07:12:53 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 05 Nov 2026 07:12:22 +0000
Subject: [PATCH v2 3/3] serial: core: Drive the transceiver interface
 select GPIO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-serial-rs485-mode-gpio-v2-3-027e5348892f@vaisala.com>
References: <20261105-serial-rs485-mode-gpio-v2-0-027e5348892f@vaisala.com>
In-Reply-To: <20261105-serial-rs485-mode-gpio-v2-0-027e5348892f@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793862767; l=7233;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=G98c9yvhGNxj1XRhzOKqtGzSNZC9fllfwRQJFQqG6T8=;
 b=VCesDIZ6hlGwvoAOKQEnrCYqS36gEsjsbHgfB1oI0/D0zEXsebKPmDxV4q6xjAYi4/WIMpkRR
 xBG5vaPSVcuDuok5WzOHWT6vRnKNuxXOK0Vm4gUwh7dAWJkO+m2vjdG
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV2PEPF00046789.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::25a) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS8PR06MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4bce80-1131-4c12-6b71-08df3b0c3544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|38350700014|11063799006|56012099006|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261102130727099003|261028144727099003|261026121527099003|261026140227099003|18002099003|10067099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	tjRW+fMOZePso2kJGuBQL739sZ6+ucesCS0azPpvb1+R2giFEMc0l5k3if7lbPD5SmqRVCADoHWBmu+yfjVSeuHVesfgFlEvjItcTcc9BqdVFqvgUn46j8Fl9aLbf7sHuj/FyHp623BKuWuqa3KkP96sz+vX1fSGvgOe7tgAQDkusmLLY0mrAceQukGmmF69VoadYmWlqRy6ZOIK6YEDuxG7N0E++blrC08lUzRr/9qZmYFHGaH1iF3ouzlbjt9beWhMH8c04539y1wYmXvolBfuFBq55JX8rzVmXkMhPHuhoCsmfVl3juLsIkhsVerdq5ZDA2bQU1NE/Cxyf4C9zqTfPnMv9ZsKW0hrhPlueMOkCgH7Ac8LtgEqxuSb1xNTttMFlRYLJMM46Qi32UyY19MbmrJ5edNKPo5vJR4zm0zDOhaVRsMxt636nY/uxmGuTe/hS/FrVdtNhf0UI47r/YrgD9PsWwXcOXLVHWlKvWC1gqqKcACKFeZLHV0HoFZigujP+fJVtQnYj2Ojfnajcc5QzP4+Xboec0FTfBNWO+Ftwr46Vpi7Ja3xRDlCrS7EYMG4pjTwtktOE/7d+mIRj9YrlLpy1WrWF3PEyVvMe2iaIGCeP5nLlpAmTjMswmcSDe9JKc65o67IBhZt3e03hPUHhWG5qf4yNvKMBuaRxEZ++TaXjBUGI2d2KDQw1pDP89ozoKmFBO0pH0jP+GdMO4aYwX0OY+zEZnXeDkbFflo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(11063799006)(56012099006)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261102130727099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(10067099003)(6133799003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDhuYi8yUnloYmRvOXV5Tm95eUxxUzU0UzdUU0lzeE96QTdVZVg3dThQR05M?=
 =?utf-8?B?R25oejF2STl3WEpRNGk2Wk4yaVdETlpicG9FQlg0a1RFTVJ6VFZYS3FxQ2hx?=
 =?utf-8?B?Mkw2RU9tVzVWS2VTVzhsSXNUeFYraWV1RitNaFNuTW1wbmliUVhxRnlvbzRn?=
 =?utf-8?B?NWFGeFg4VWlYUW42Rk43M25lWDBNTjh2MDRGVFBOOVMxQllkQzlLUFhqOW4v?=
 =?utf-8?B?dk5PTzNmRWtyVUdLNGpZTXo4VHlva3E2eDNqYVczS1lyTitkVXJmY3g0djNB?=
 =?utf-8?B?blVlMEh4a2Y3QjgwMlhUMkhsZnM2enoyRHBhTm5Vd2l6cTJEcUw3TjVodEdn?=
 =?utf-8?B?MStXcVFEaWVRNmpPdHhOd3RVQ1pkQWdhQWtNanRqRmhMTGNLa1hYYWVobnk1?=
 =?utf-8?B?ZDJxVG1tZU0yc0tFTlJlc3I1OHNBQnBCR1F6NjZidHdUbXBSYVJaQVl5b0dT?=
 =?utf-8?B?Q1pBTWpBeWxoQWtzaUE1ZFJBTUlZa2dEKy9EYWtRNW1zQnJwSllvTXFsY2Zh?=
 =?utf-8?B?T3ZrWFRTOEVuVkVhNHViRUJQb3U4eGNQUk41Q010b0dLcVNmdzY0c0Z5Ri9Q?=
 =?utf-8?B?OWhWOXdwQklib0k0dmlMeXRVL3JzYWtlZEJZK1VjSFdVbXB1SUh2b3IyczFY?=
 =?utf-8?B?RCsramxtUi9vaTJ0ejFmaERuUEpvMXF4V2pLNkc5aDNrRXVzcEpsSTRobmMx?=
 =?utf-8?B?V2hSRzNyNTAyMVZvNjZIU2FOTHd6WXJjYytpMTRWZXUvSHEycW1mNlgyWVhZ?=
 =?utf-8?B?L0xkWXlTMUczRHl6L0gvam9MYU9GaHRZMGt5Tk02bzcwZ1ZHRXBGeG1wNzhD?=
 =?utf-8?B?elZERVROeVpiTE4vTTFKaVEvSWtnUUJ1OTd3L0dpellLMUlvSmRBQ29QcE1J?=
 =?utf-8?B?RSthd2V3TlNQdnp4cjVHNXhpdlFadnJoZ1h0MWw4bC93enJGa2pEYkZmUVVp?=
 =?utf-8?B?RmVqV2JJY0hDNkdiNGkwOCtEL00vc0hTSjhYeXZwV3B5YmV3Ly82OE9lMmFV?=
 =?utf-8?B?aEhpa2F2Y3Y2WmR6c3FRbUtLR3BWKy8xWGl3eENsdElpbmw3V3NQQ3M1UVZE?=
 =?utf-8?B?NWlDSTZKZDk5aExBdGxvTE1zNUp4d2Y0QUV3ajA0VXZtMzd6akVhdUM5Ukw3?=
 =?utf-8?B?UWdzblFvcTdqQ1libWtod2VOaENkKy9FUWR4WWVVMmtVejdUTHJxK1VnTHE1?=
 =?utf-8?B?Y012L1FNYXBwVG9HRDF1YVE3ekNGLzcvNHAvT0o1VXFxQWVUSXEzUGxPZFA1?=
 =?utf-8?B?SXB3NVN0dXIrK3NMSmdsSXdzUXNSdW92R2tRSWYvU2RvRWtjQ0ZCZWVqRlkz?=
 =?utf-8?B?NTV0bUlFaXdReG9nN2tnV3NlaklJU3VKc05vd2tsMExWSTFEZGh1THZUUTIr?=
 =?utf-8?B?SFdYY0tTUEt2ek5kazRaWGtrSWQxN2N6OTlXMnhIYy96YzZtWmxyaWhIS2k1?=
 =?utf-8?B?TGlKeXF0KzZWVHpTKzFYQU1RYXlMZlpjMTBoNGpoRy9QWEVSZnRFOHRqOGd2?=
 =?utf-8?B?bm0rZWM4cm0zT0pQMG1yZ3Z2eWVHenJwRDd2QS9adGdVUUc1N1pBMTRPd2xu?=
 =?utf-8?B?bFQwaW5GaTB6OFFUbDhzcCtoRndaTDcvUlZrZzA5NEFTZUJ1d3BGWUJTN1dD?=
 =?utf-8?B?bkEyY1RMWWpRekdVREpaMGp0UENKMWZXakIxdWFjTnRYaWFKUzU2Z0VvNjM5?=
 =?utf-8?B?aVp3WEhaOHpEQzJjVExtRURsc0tiNlUvY0xGWS9aQklacklJQUMvbEFwclNY?=
 =?utf-8?B?eUNpU3owUys5bFRVVFJ2Z3JxZW5qOEx0dnFjWCt0aStSUkthRWVaeVdHb3lz?=
 =?utf-8?B?Sm1rV0hGRmViaHV3aGUyUzV5WkVPQkVaMWRMZnRBb3ZDR2JySDlRUks3bHAr?=
 =?utf-8?B?NEFVTWxlQkU5elNDbEdINm9TM0o2T21rdXNzNkJPNFZkcE4vc2NPUkZqakxH?=
 =?utf-8?B?NGJuM054c1ZSbFZ6RnNjd1orSkZvVVY3NDZmWjltejdFMkUwKzBFNUQxVVdy?=
 =?utf-8?B?YVNpQm1UQ0hLdmpWMWVnRXFWRlBiOWVtTWtWRm5vSjB2aEM1citKNUNQcHZE?=
 =?utf-8?B?K2FUWlltYzcweVN1NC9BdnNjc0JFODZMZ0dQSXZUVHZPYll5cjlGUFpjMUNG?=
 =?utf-8?B?aUVYd3pCUTRSUTMyUWhOUTJna1MxUHdiYmZjbnFPZTBaSkYyUldUaitJSU4w?=
 =?utf-8?B?SUt1OVVra1FxSlVyOWpYL2VNNEp2cWRoU0lXMDR2Smxqc2czZWQxQ0ZmOGVZ?=
 =?utf-8?B?eEloMUJQVVFSWk1EQUwxaG1kblpXL2FoZENGVnk5MTR0SkJFV25pVmtzVERN?=
 =?utf-8?B?dE44aHhGdTZQQ1lYTk0yMGxJbTVKT2JUTUIyMVJvTW9tZ0xhUENsRFhDVjdC?=
 =?utf-8?Q?QweQcvDLTaCzX2S0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4bce80-1131-4c12-6b71-08df3b0c3544
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:12:52.9825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s40+rYr2aLpIVUGE5wuCFvNlNnvB3X5dbhNLl96zTpE6XOcRbQBNCsLAIb2P3xejAK28D15dof6p+T9nPvBESzZCTF/k+UaYm/unUXX4mO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7877

Multiprotocol transceivers such as the LTC2873 provide both an RS232
and an RS485 interface on the same bus pins and choose between them
with an interface select input. There is no generic way to drive that
input today, so a port wired to such a transceiver is stuck in
whichever interface the pin is strapped to.

Add the optional rs485-select-gpios property to the GPIOs acquired by
uart_get_rs485_mode() and drive it from the RS485 configuration state:
the GPIO is active while RS485 is enabled, which selects the RS485
interface, and inactive otherwise, which selects the alternative
interface, typically RS232. RS422 is a mode of SER_RS485_ENABLED and
therefore selects the RS485 interface as well.

The state is applied in uart_rs485_config() for the boot-time and
resume paths and in uart_set_rs485_config() for the ioctl path. Unlike
the termination and RX-during-TX GPIOs, which only matter while RS485
is enabled, this GPIO must also be driven when RS485 is disabled to
return the transceiver to its alternative interface. It is deasserted
when the driver rejects the boot-time configuration, restored to the
previous setting when the driver rejects an ioctl, and forgotten with
the other RS485 descriptors on failure and port removal.

Unlike the termination and RX-during-TX lines, whose level is harmless
before the port is configured, the select line decides which driver sits
on the bus pins. Driving it to the configured state at request time is
wrong either way: a port strapped for RS485 would present the
alternative interface during probe, and a port strapped for the
alternative interface would select RS485 while probe code such as the
8250 autoconfig still toggles RTS, the driver enable in RS485 mode.
Request the GPIO without changing its state and make it an output at the
level it already has, so the transceiver keeps the interface it was
strapped for until uart_rs485_config() runs after the driver has placed
RTS at its RS485 idle level. A line that cannot be read back, as on
output-only GPIO controllers, starts at the inactive level instead of
failing the probe. A port that boots with RS485 disabled is switched to
the alternative interface by uart_rs485_config() as well, after the
modem-control lines have been deasserted and without involving the
driver callback.

In RS485 mode RTS is the driver enable of the transceiver. The GPIO is
therefore driven after the driver callback when RS485 is enabled, so
RTS already sits at its RS485 idle level when the transceiver switches
over, and before the driver callback when RS485 is disabled, so the
transceiver has left RS485 mode before RTS reverts to modem control.

Drivers calling uart_get_rs485_mode() need no change to support such
transceivers.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/serial_core.c | 45 +++++++++++++++++++++++++++++++++++++++-
 include/linux/serial_core.h      |  1 +
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9516f50a72139c73d70826f4bb0627aed2d3d310..6c0a6d9dcb851b6db0acd91143e651bcb33ce5ae 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1424,6 +1424,7 @@ static void uart_forget_rs485_gpios(struct uart_port *port)
 {
 	port->rs485_term_gpio = NULL;
 	port->rs485_rx_during_tx_gpio = NULL;
+	port->rs485_select_gpio = NULL;
 }
 
 static void uart_set_rs485_termination(struct uart_port *port,
@@ -1446,13 +1447,22 @@ static void uart_set_rs485_rx_during_tx(struct uart_port *port,
 				 !!(rs485->flags & SER_RS485_RX_DURING_TX));
 }
 
+static void uart_set_rs485_select_gpio(struct uart_port *port,
+				       const struct serial_rs485 *rs485)
+{
+	gpiod_set_value_cansleep(port->rs485_select_gpio,
+				 !!(rs485->flags & SER_RS485_ENABLED));
+}
+
 static int uart_rs485_config(struct uart_port *port)
 {
 	struct serial_rs485 *rs485 = &port->rs485;
 	int ret;
 
-	if (!(rs485->flags & SER_RS485_ENABLED))
+	if (!(rs485->flags & SER_RS485_ENABLED)) {
+		uart_set_rs485_select_gpio(port, rs485);
 		return 0;
+	}
 
 	uart_sanitize_serial_rs485(port, rs485);
 	uart_set_rs485_termination(port, rs485);
@@ -1467,6 +1477,8 @@ static int uart_rs485_config(struct uart_port *port)
 		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio, 0);
 	}
 
+	uart_set_rs485_select_gpio(port, rs485);
+
 	return ret;
 }
 
@@ -1503,6 +1515,10 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 	uart_set_rs485_termination(port, &rs485);
 	uart_set_rs485_rx_during_tx(port, &rs485);
 
+	/* Leave RS485 before RTS reverts to modem control below */
+	if (!(rs485.flags & SER_RS485_ENABLED))
+		uart_set_rs485_select_gpio(port, &rs485);
+
 	scoped_guard(uart_port_lock_irqsave, port) {
 		ret = port->rs485_config(port, &tty->termios, &rs485);
 		if (!ret) {
@@ -1519,9 +1535,14 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 			!!(port->rs485.flags & SER_RS485_TERMINATE_BUS));
 		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
 			!!(port->rs485.flags & SER_RS485_RX_DURING_TX));
+		uart_set_rs485_select_gpio(port, &port->rs485);
 		return ret;
 	}
 
+	/* Enter RS485 only once the driver has parked RTS */
+	if (rs485.flags & SER_RS485_ENABLED)
+		uart_set_rs485_select_gpio(port, &rs485);
+
 	if (copy_to_user(rs485_user, &port->rs485, sizeof(port->rs485)))
 		return -EFAULT;
 
@@ -3663,6 +3684,28 @@ int uart_get_rs485_mode(struct uart_port *port)
 	if (port->rs485_rx_during_tx_gpio)
 		port->rs485_supported.flags |= SER_RS485_RX_DURING_TX;
 
+	/*
+	 * Keep the strap level until the port has been configured. A line
+	 * that cannot be read back, as on output-only GPIO controllers,
+	 * starts on the alternative interface.
+	 */
+	desc = devm_gpiod_get_optional(dev, "rs485-select", GPIOD_ASIS);
+	if (IS_ERR(desc)) {
+		uart_forget_rs485_gpios(port);
+		return dev_err_probe(dev, PTR_ERR(desc),
+				     "Cannot get rs485-select-gpios\n");
+	}
+	if (desc) {
+		ret = gpiod_get_value_cansleep(desc);
+		ret = gpiod_direction_output(desc, ret > 0);
+		if (ret) {
+			uart_forget_rs485_gpios(port);
+			return dev_err_probe(dev, ret,
+					     "Cannot drive rs485-select-gpios\n");
+		}
+	}
+	port->rs485_select_gpio = desc;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4eeb8253752aa08b27829e80a259c7db65728e8e..fe90a8aada98cacf5a80f20ec2a91e249c92d0ed 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -600,6 +600,7 @@ struct uart_port {
 	struct serial_rs485	rs485_supported;	/* Supported mask for serial_rs485 */
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
 	struct gpio_desc	*rs485_rx_during_tx_gpio; /* Output GPIO that sets the state of RS485 RX during TX */
+	struct gpio_desc	*rs485_select_gpio;	/* select the RS485 interface */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };

-- 
2.47.3

