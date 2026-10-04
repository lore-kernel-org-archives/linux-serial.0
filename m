Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021077.outbound.protection.outlook.com [40.107.130.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EFA440A3D;
	Sun,  4 Oct 2026 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116228; cv=fail; b=IY6F/nEc/+H64hqYwRuBnxepWdttcOCsvlqzvt7crkqDRYEOZ1/2XxHtETEwBSeM8CqBeE6trjybDfyK0lDoWCidmFTDWHj15R9n3/5nq+7qJcchhwTTSBzfb4B8/KPpgJaUxS0Ux8BLyBDZ1UdXoaS5qLIlMf/AfsJrGVz18bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116228; c=relaxed/simple;
	bh=jQ1bVJfrEcbkKarsKUGzCVtAjVx8KW+X/Gi7j1/jysc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=L8oUuj8AhhBIE7z0TT0zEYleeZvOQN2GS9ji9X0PgRo2Dym890Y+ymNANF54cY/RX1q2xNjid2MoneGJE8VzoksZ03K6EKU6RbTavE+RsaZ22b/yo1OyzHAuvIOBltm4yvYdwWOqhK1fVUvoE8Q6oJRQ3peBuzJKNYSAKNPEC9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=jzxMa4QZ; arc=fail smtp.client-ip=40.107.130.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="jzxMa4QZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWUPqjhrpsPEZCUABvkj+gW+OboLIreTgECoymg3/U+mhtUVHQlYyXqvbG6AKoFaQw0sm/DwKIXQh8D2WG93mwofcBlJOsDNHKMPZ97P4LebMevkdWuGbG/yxCNd+FAsz71oWDMzelkjb9QWvS14VeHb124Dz4d7shjLLvrW4Oqk5FxRsFiBFbu32xtC34Hk5+ZYUNvQK0JwfkOvJ0ZDZbFy8rRhduq9l5GUwSHPnA5sZaaKb3o9HfFhoyP5SLp3X1Owx82+jEW+Ujz/jMFvCD60K8nhn7O+D+MxK1If3A/lIL43HeRsAq/gvsiKsXIem2tRaoYtnyfVAfT55b3eHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/ZytCcd3ITVvpqLFyWNXW9c+L0dUCwAFfJx/b/MQLc=;
 b=RCtLCMJaHkwAiNyl0EcVC+s3D8mSy/YXzugeGMxV6dm0ITL910Eaoq7r9jEad/o0iTU62b23iMw9WLP3HY941KKmLasLiOAfoJIJVxYbaqJ1457acydNpKqqaoeYPcZmfSAvLPVrjhLLtdV9eFwajzaZ++UWoyBuO4jyaRxgcDtBtpPnKTBxPy1X4PNSSOLUsN90GzQJNA1Sj85a5hHLBwPsWQ6KaByOOrOI3jnFy1cjnUR1Pu4QsXYtuWlc3+38bZrC6+kYrd4+VpJrdVjENMcdCi3iYu8JRNu+cjpFWYPFhagoHuFXGwp2ynTjAsGwPf+EhE5ZKo++pEX+9oRjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/ZytCcd3ITVvpqLFyWNXW9c+L0dUCwAFfJx/b/MQLc=;
 b=jzxMa4QZ6LR8kSAd9g5ZdQIjH+idF3zzjQ5QqVhk+jGaPukK3a15rBQICmIQa0F+YV9ZxAHXsbK2WpUwUBwfMTwWvnri6YMZuGl7YVoBapklValCTeL2YhF5rCdTF4OY/z73kdm9e47wrDiLyHV1hxTSWMPocon87kIPx+4rFR6yNH37lzR3SnV0pv5jrYEJj45TNlFmfQYc+BQPtjIOnaHDehQG5YCIIiPxSVC6mkAFWURFocKx3HdUy43z1UictVhU6E5RRG8Rgjq6UdCB7YHM5Nb1G6+JwYUVPlJSY0gwdE2nsi8U/1Q+C0kIlEdQTBF5OWZKjdNR1khJzUP3Ig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by VI2PR06MB9239.eurprd06.prod.outlook.com (2603:10a6:800:221::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:16:39 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:16:39 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Sun, 04 Oct 2026 12:16:27 +0000
Subject: [PATCH v6 7/9] serial: max310x: schedule tx_work directly from the
 IRQ handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-max310x-rs485-sw-delay-v6-7-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791116192; l=1761;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=jQ1bVJfrEcbkKarsKUGzCVtAjVx8KW+X/Gi7j1/jysc=;
 b=UkBiPNJbJLtAo0iAB683I26bPVVUpTQ17SjWdQkzMf75r08F6dveHRepj/jd5qgMQWi+cc1KN
 k3ncE7ETVW6D+MChHtZnzTpjyA2tTK2Ba/NegwSREp/tCYmvZ2Mfxaa
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0005.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::6) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|VI2PR06MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 169feebf-05ee-4782-7b54-08df22115793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|52116014|6133799003|18002099003|22082099003|10067099003|56012099006|38350700014|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	InI81uZ3f+tvD+geO8fbgMvwMXA57XOFu8+LxGZuaRw2+z266oJVMBYPIr3Nah11fnKSwSWmQxFJpw+vsGteSJrZ0WXoYU0fXLAU076FVAWseMpfyfpTinzchVBRsNF2T/OEroHomCy2ow/RR4dw10evM7xCTClIi6GLr8Myk0uC5fQ4dDOAupTPJR+wpb9pFKgbFHwaaCxV1ysL1IpgKbzbCQtBJT6U6XaGsuF002hlcncSuItX2LFPLNvjVbKHOuk7NWmI3Fd/NNzTLUYy179grxjrxwYYKwb2pECR2nuqFcZCunbPv0gpPwNq2HwO/Bq3l+IhFHPd7lDUZ3mUVcmogr5zQJXvbj6+UW7/cqdgRjkKCD0xy8QY/Nn0uWKVsPpb0YrJhTFAGeQHUV9zmnGMXnQ2poBNIYl6WI/YZzzCw0oxvjpdGxVuLaayz2y3/Kkei7ZtEYelCgSIScabhB02FBNjex6IXzauLOoTwpMlPTB3MWJdDvkqm53eK5ALqLd/0VoGz4XoxTUNGN+ABezIWKhODO3+65VNTC1JvB0uu3q41P5aSUobkN9YYVmGxWgFSlanND9R9D+JpXeTkQpSW+h/34LFyJ+QuolQ7XMO+74gRCVcPARjG7kEtM64erXm4EnIIYRdLPhFgwlg/xPQlfX3Icso8YrdPykhDLu0WZKZv5VCr2oi9hpwn9Gex4Xor4kWFfa9EiArAGV2UeF4S6iFBM2p8LyQn5iGCg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(52116014)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(38350700014)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUVMRFVCZUx5SzBwSHc1NmJ1T3I4K3ljaHFyODhRa3V3aTBKVVJhTzNocnI2?=
 =?utf-8?B?dEtxekdCMktkUUF0QWdJYkxRemUzcmJMKytDc2RsQWV4OHlldDFQWVVPSDdq?=
 =?utf-8?B?a0UyU1pocC82WWlwTjgwa0ZuaG9GTWZUMnU0UHltTUI5SkdoQ3F1eUNjRGhY?=
 =?utf-8?B?RFE2U3NicU5OaWRwbFM1bEVzdW1pNW1PZHB5SE02aVFrTkxHY29aNkZta29E?=
 =?utf-8?B?SFNZcGg5Z2MvNEUvOW9OOGgyWkZ6NnhmV0p6VGlGdzNPaFZyWTdwMlI1MDRS?=
 =?utf-8?B?RzRTb1p5ZTh2WFJ4MDF3bkVYTmVSWlVFZSt2aW5TdzN6RUNqUmlXWWtFdWNa?=
 =?utf-8?B?cWp6dDUyRkt1UGQ0VTIyRWNoOVZtSGttUStkMCtBdDNVS0h4NUg3VkpUNVh4?=
 =?utf-8?B?Znl2UFJ0THlzYS92djhnbnA5Tk1LUTZEOWI0RnFzQlFsU1BkSXc3cDNqSXlS?=
 =?utf-8?B?SUViRnMyQWJ1Mi94bnpvTlRWMmRuRHR6Wmw2MVR4ZnNlRlppcVU1K1dFSVpL?=
 =?utf-8?B?TjlqMnRlWkF2b01JRFIyZ20wT2IvUEw1aDhEcGNzZWVKc0wvV2hOc0tQSExM?=
 =?utf-8?B?ekt5YUNVeEY1Y2lYOHRlODNOb0h4R0d1dTZzUGRURldEc2cvZm9hYnJUVkQ4?=
 =?utf-8?B?STEwbWN2NWc4VmUvL29tdkhCVG8rRmt3SXd5aDgzODZpYlZEVTZDVzZOdERH?=
 =?utf-8?B?Q1ZVb3NCcWFUbVBPWno4Vk1vQ29QeUpzQnJYRjFvWjFCSldUcG4waVBJMldx?=
 =?utf-8?B?TkJmUmNSblNPWmpmS3oyd3g3Z09ZcnQvc3J5eldsTS8ybk9jaGRVejQrcnhq?=
 =?utf-8?B?Visvc1dmaFZKOXkxREdKMGlLQVlLR3dsbVhtZDdzY010T0EwYVA3QmZjRWdt?=
 =?utf-8?B?LzNLU21GblBCckxFeXdlTkNrYkN5UVhiYVpnVzZBUXpGTGRMSldYem5HZHZr?=
 =?utf-8?B?aFhNVi9CSUFUZWViZ2N2QmNVY0R4TGFwQWo5dENObVpqR0k1UWIwbEZZR1Rz?=
 =?utf-8?B?S1ZldXFUSHR1d2RPOUM5SlVZSGJSMUROblp0Slk5Q3R3Tm0xeVVoMGVRZjkr?=
 =?utf-8?B?TVl6cW85TzFvQ1FBeld6M2dpRXIyS2VYdEFPeEcvbVcvUDMwWHUxUUJBSHdC?=
 =?utf-8?B?UE02QXNBayt6QTVJZUpnMVNDc0NkTGphUFp4a2NRRkd6c0s0ZC9JQXN0ZGNl?=
 =?utf-8?B?RCtqdXNJQ3NHRzNxcFZnaUg3VWoxYWMyTmlBeWVzREZKd2YwVXU4MVYrV21Z?=
 =?utf-8?B?QXlLQms3THdPeVRUVy9ubitKQnUrZFpUNmp6K3F4ZFhHeG40RDVmZTAza1RJ?=
 =?utf-8?B?eExZbCtuUjYvRUo3U0dGMTAvT2tDRW5LMTd4cU4yRE1iS21UbUpDZzUwMTRq?=
 =?utf-8?B?Z2Y5eW1PRnhYWW1lWC9Nckk2UVpka1JyOGtOUmhkT1JuSWZJYm9KbWI4SGVB?=
 =?utf-8?B?a250QlJRbUJ4c1QzYXVhSStleXppTDBJbFNKQjI2cXhTQmUzSkhSTWE0aUht?=
 =?utf-8?B?T2E2eGF1aStxOXZJenQ5S1VSWDdhcWFyTk5uTE9LamhvQ0hpdW04cUt0SExH?=
 =?utf-8?B?dzRORElaeDVkM2tFNmdEMlJydFMxOU5tZnNMRkhINXhBVDhIV0kwYzNiZHJL?=
 =?utf-8?B?RVNjS2RWOEpnYk9hR3FSeHhDOXlOVzdRak5KdVNUWkhsM2lkQ0ZsaHlna0RH?=
 =?utf-8?B?dWdVSWU2UlM5dzdmVHY2UDlzaHhFelJRbWZ5dVlHdjQ1UTlqbi9ISjF0d29j?=
 =?utf-8?B?TklOemV4dXh6Rk5QY0dKR0w3ajB1QkcxdFA2L2toVVdOeXFYd3o0YXVtL0NG?=
 =?utf-8?B?UXBUOE1RYkMzblVjeU5nOEE4a2x3YmwvdUZ0ZXRXMnBrMzRBL01pRDE1QmJH?=
 =?utf-8?B?a2xmazVDMGJwK3hpbWhDOWV0aXBaSWx1Z1FRMGNqQ3BpUWdwVktQTDZNVGhL?=
 =?utf-8?B?Z21HUHlpOGg4eGptMjhjTUpYaVV6WWpvam51MS9UV1REYm5SR0Q2eG5SNVJQ?=
 =?utf-8?B?NGwxWUpTdTZKREQvV1h6aDZFWEEzNEVqNCtQL1BpSEJ0YjZYdUR0ck1TZGJs?=
 =?utf-8?B?RlZmTVBobFhSTS9mWmRQTjR4T0FsMjFiNmRuOUVDZzV5UEpkY3lQRG5sSU03?=
 =?utf-8?B?RUhVd0tvSUpWUUFRbnd4T3c0UUpaSDFjc1ByWDRZQzQ4MnN0ZVlpYXpvTFl3?=
 =?utf-8?B?MU05dE9Db0JlOTdwTU1yTUgyZkJWVkRLVUZORkYrdXFhTXBSUi90WXhvUkZ4?=
 =?utf-8?B?TjJldXdyUVpjN2RCVE10MGQwdWZSUU5GTXM3d3o0UDZiSXVxVWs1MnlDZDFq?=
 =?utf-8?B?b1N6V1JRS3BTTitxdVh3ZzVjR2FtdHpYanpCUDBLVnYraXdJZGVVV2RyMm00?=
 =?utf-8?Q?AObD8EXkSgVsRFLU=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169feebf-05ee-4782-7b54-08df22115793
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:16:38.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjco2rxY+EFpMvx1dUq5/ExdCkadr5DY6L7DHKGMHcv35kPYpBLeX2mKhOiyfctroJ9XZGCENkH4vQHWy7iywSRIE0x1WX6Rf7c2miqsD8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9239

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
index 810b749bfe9ad9b4d75a7b158ed8013a5a4f2078..baa499c16cc6a7651d804e8af07390b50ae66367 100644
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

