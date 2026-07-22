Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013046.outbound.protection.outlook.com [52.101.127.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E5C3E8357;
	Wed, 22 Jul 2026 03:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692022; cv=fail; b=K5UcpccAPLk0aRTKauQVYMCZGlL2A2zuna3Cd8scv0mQovLXNK45BcjAt2EhoCAzAEd0xjJ9JVQ3rq4gLiv4QElh12yGUT9/+hXQ2ik6jg4vinNckIMmUqkjNTzLud/HmUvPoArWFD+dVYL1WYNYAb2XQU7x9JoIi4IeavRv5N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692022; c=relaxed/simple;
	bh=8V0XQLoQZFuNI7gFIzJ+gpQXYIKO3xCZEIpu1qgmjdQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AZSW3rWP4XhO/GMNXRZSFHS5vDLe5j2EUSR67emsv1cqBBUSPCtEHgfQaMuUvx7rEmF142XrWs+DJtqQ3BrwM3W5EsHrpyanhVQmUNt9w/HrUscNFrOWApYDxYOIqC/SIG/XGaChN2L5kiluI4OEX5exB+LIzU+si5SZZES5sKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TdTc1aKz; arc=fail smtp.client-ip=52.101.127.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TdTc1aKz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phrvA3mL8+Ha/H+dhubcWPINkbi/q1g4AevVeRfH6+Yx+wxLV3IVkAgA//EbaNj3N9GXv/ROoq8NjswxxBFIErY56770WecnDRthQEqdsyA7H0ZJAQOtDzph4he6p+m2nhOJ3LtZUKZ4Md60KueaUUEUczsPHtYu9w+nlwGi7xM34JzDMDws7RSX2JE9Yu4aU+ZZqQwil9Or7FJBQXIRbx5wRwE+TcU3Q3w+accf1hMI+U34RZK3Rjw7yNWtQuOIu6V4QYo6cx13mkn8JBHqxUL97etUHRWkqxXF5dWscaNqpVr9JhvWHhmXR68KjxCh0+h2cJtn+/rCozgwiapROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3AlypvLYtyd8ZPK7lNMMBHLPTrgEUelntuPN/0zfXs=;
 b=u3KOm1TDYQAf/OZHbRFXZcTXRsq9gyu+gVeErL8pbtDt7IJBy9WcaC1axCaAsRfc+ux39BqZD4IAMLg/Gn9Nn3gOiRkFIrZP2QjTXkt0eSWfKhBQlDmAdcTh58syxKlZXSQ/rmQazywnBH43X375rd+splWGGthcbrnToLJNrzrj33/Et7ArRsrtL0eeYHam1bEozKoMoSgyKZRIZdaV+um6Qc6Wn4Q/lh31vw5vPL/LwQWJTqCB+he7qO/tre+fx/azVByVWgBoYzUCbBeMrZqBPcV7BGgn4knKTNihlMLLmEL+Mz8hxrdThl7ocIiSC9uH0EpIxUkfQWQE1TAv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3AlypvLYtyd8ZPK7lNMMBHLPTrgEUelntuPN/0zfXs=;
 b=TdTc1aKzEgVBN6Ar+g5Nc/3hprx12Lz70cG777SOZdNjm/BzAvvGzfggyf4E46imYapxW4CPmotQI45WD2rJvdfuKRW30PzXN09WUv7hsvaVR8ENQw7JqA/XXtqpbFWIf017MHeqt4NY27gJb195NqSCp6pr4rUJBrVkaGWOmrUO8jL0ohMUEoGjR1ybgoHfSEHFBMYuu2emAy/XDb21auQSCO9M1H1bBy6hFDYcx6Ktql2gbgXrmcLwCdpZFu1y0IyisYu9bop/Qd3PG0TGl6R2gOKLc1LSfgR+amEsSJFctm2Ko7J6CJ0KVja9XlJF9C4Hi7iNYvZCi2ff/nwECQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8988.apcprd06.prod.outlook.com (2603:1096:d10:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:46:58 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:46:57 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Pan Chuang <panchuang@vivo.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH 4/5] serial: mctrl_gpio: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 11:43:32 +0800
Message-Id: <20260722034342.316755-5-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722034342.316755-1-panchuang@vivo.com>
References: <20260722034342.316755-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::19) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUYPR06MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: c22fc2fa-f94f-4665-010a-08dee7a3e0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|52116014|376014|38350700014|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	we2CfLMb/tGmIz8/n2Bs/Ot4i0/diAaotGI2bQSrsirp+lYGQ1fsIiy1TqJsNSxI+zBul5sxJBVG7GpmXtK3SEuuj/nlvHzX970gsdV5Jo6Ed+224i7nfkYudb0cAEFewjm/Qie5eowQnchlVFG9OO+qHKamaQO2IQUmjuro1iB0a9TbEIkDoiMRbyqVeHOtkEW+l+Cu/h8Rbx/PQl+/RTU2g+8GwamL1EGOnDDwJBL5qlSI3SohRLEDYDs83ryM9Nd6XCeRANl1dKF3YDmw6sKIcjFEi7I+7PvOYD8pVdX0sATGg6m2ZoePbOnXFOxOUnlUBcbsaKpvsXOlpOfR00w2FEz9yHKIf09XeyADSViRe9CM2TAKMzgc8PEifz+kSOuMPAOw4X6XAkuHbwxYqFLNmOK4AhBUE8Pn4Vc6JYLdgk4185+TpCaSw4xgoOgGwriY+AW0Ue27aoGUQMhj7aRhBM90W6OTlcat1IDc0kJgzu8w3kouu/xVltMYzBZCinriUsKCjbX2YJaQYn6s0DqETL4bHLrQ/y/5+Igx8Yq8QzyDHRLpvHrPRCqzK5EjBhCbSkED46T1EixJrSVDj2qcreBF5CwK4sJslpjE/TOkQ6ujI2Tk8ja7X9aMM8mHvbGV+tNWQyBhFq1y8KS6ci4U/V8qw/5YF8wVz7o3OuVRwAt5uoPDUryR5LlL2kxVTH47Hg9u4T1kfmIRvpgSQGySUMXkB4CJ6uyqGyo7KcE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(52116014)(376014)(38350700014)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q0hGa4ZyyMH8jc8Kn1WWI4y/SR23NWGPpQHqA+DAMYg21O71mkZUgR7tNwZB?=
 =?us-ascii?Q?yBzoA/oOFqrzOb6aRIohNx24f87Qz2YUeP7XCmtDaUdqiHjbkp34bYGxJniQ?=
 =?us-ascii?Q?/RxZLFP6t5opDUQuVT8MexeqSILpjfNt8VoyR+oFBtUZU5CjImopuEzfSlqk?=
 =?us-ascii?Q?BRlBS6DTI2sesrl+eQRZx+34EnIB7VsuhQ6yU0kwW3a2UVL0mw3nL2svGlt1?=
 =?us-ascii?Q?oPxsffBendemwIDGPOvp4haE/8MtIIiu1RtOTY+XFrF6MIa92FGvHmh92/vb?=
 =?us-ascii?Q?3fbh9v1EJvuozwyu3Zu2WvIs+U+MA2C3M30o6Z92en8ax+eURbFIR0GfSTe3?=
 =?us-ascii?Q?nyB9kdXPecFBVGPbxG2yW0Om3KdvrtV+Eucw1HwS384RNjhFlcQur6T/w5vl?=
 =?us-ascii?Q?DurwDv1Jj4dCbxlkNu1VGrvWwnt5d0H17/62gBapHI83s902UURdNRIn8Fg4?=
 =?us-ascii?Q?BlpFO4T4R9EdPp2IxDqXaz7QVKUGbf6Go5HHCl3UPuo8NdHfIhOxqehy5WDP?=
 =?us-ascii?Q?G4rr3zG4eZcAJ8oyRWh2pjkpxhOl5nX7hukBItdJf1B0vXHPfYYycPB1WdNj?=
 =?us-ascii?Q?/ptgssflWHXHhPiLL6tZa7Aq/UpAOwE2FbbEwhGxhXwWzTpmrgzGXpmWNyWd?=
 =?us-ascii?Q?OCubJ+/b2JButr6BgrwPLNSIn3RPhs4lOFJ6kx/TFFP91LLGgOUHnALov0sg?=
 =?us-ascii?Q?/v28b2c/d3X3d+jKyHtMNhp+a8SrEi9KLKcRtEzKcT0brb35Oe5qn6qeilwv?=
 =?us-ascii?Q?5VJmowfEC4CwLDdyFZQ3Vb4MC0ewZ+MyAU5C0R4dbUlZoRxdKXoUiFzMyfKY?=
 =?us-ascii?Q?nLWhucOPmqgMB3dD/JANokPW72mN+T8rhQ+KjSR9+Dx9NsxiCcY/pEBIcT3n?=
 =?us-ascii?Q?NAlPoyDGayW0wAHXg0f2u8nl05XhDrCQGY4vJYVSznUKt6Mo2xGIS4BicXjA?=
 =?us-ascii?Q?rYhHw5UxZLqlBOxlUzdGm4emv09079rqK38D6Gz8wakXwviX70JhToeIxA/S?=
 =?us-ascii?Q?UjFChuXjBJ2lsZO5Uw+mEtAvptrcqOcIQ5Hh1rq/jQj1swQGPKZXQlKcL+f0?=
 =?us-ascii?Q?Gk9zsMUv4O3lW3anbHwp3kHECR4dc7yFkW53hq/xWSFiWISLqpZWF65bmkBy?=
 =?us-ascii?Q?X/m46/hB6ApkMLe9yG58Xrg06NbNT5TF+8KJvhnVkkdkirPA7XnSytJ70aIP?=
 =?us-ascii?Q?yfVZ16yFqE6JErjb77qTv4741zz/03U9XXQT6LSSfgNizDUlnrQr5Y14Rx3/?=
 =?us-ascii?Q?AY+GyBo5hH+FcH4IBDmsHWhJnc6IYeZNwBCCLCl7fxRCDoIgLb7oA64y1mZj?=
 =?us-ascii?Q?oNGlTy4+GPjjFyGTzzPuNrTqyDCQWOTZ1Byt29n0eUc1QUj5uAUTg/WmH3Df?=
 =?us-ascii?Q?dqSEByemmHUHend12+qfdoW4mGX01Pt8vZJ4uBHOhqgKjHD8thrLqMl3L/OZ?=
 =?us-ascii?Q?rXSYWtxfRAFcOuTXogcmms5P1ROB3vZ2rNp6hddMWbNaWnRvEsL1E1tjT8Fa?=
 =?us-ascii?Q?A8/Uj3go9YuU+YnBDTlX+4zTJdXsquid7mA3jybLyaNDbc0r7m+1/JN+jZrE?=
 =?us-ascii?Q?CCcLluE21BOwVy1TEDgzwqtmB/Zmw6uHNnqTVslAnVXrJ8LN6hzn68HAgMoo?=
 =?us-ascii?Q?U0NchcfGzwc4ni14ipWcQ0qe17d18PPsRfqouhaej5OhyvisuiI/OZOWvDEa?=
 =?us-ascii?Q?/PpHlIZE94QGMB8Dwkhf8evTrc/66ju/3jb/BP2zjEYy07PWLNbL1a9wSRZp?=
 =?us-ascii?Q?LCmlUl00+w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22fc2fa-f94f-4665-010a-08dee7a3e0ec
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:46:57.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaSGUEimlMH9iCnIYAhemgR74XRyWNgNPxd4N/1YUWSSVcCUX1iSRv2yjcLh2VCzP83+Y1IAD3ZnICqn1x46wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8988

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 7b02c5ca4afd..dff13a9f2614 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -256,9 +256,6 @@ struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, unsigned int idx)
 				       gpios);
 		if (ret) {
 			/* alternatively implement polling */
-			dev_err(port->dev,
-				"failed to request irq for %s (idx=%d, err=%d)\n",
-				mctrl_gpios_desc[i].name, idx, ret);
 			return ERR_PTR(ret);
 		}
 	}
-- 
2.34.1

