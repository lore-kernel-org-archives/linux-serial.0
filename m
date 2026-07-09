Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AE33B7746;
	Thu,  9 Jul 2026 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575254; cv=fail; b=GrQvajuNQitQIDcKXvKB53+1jrORPBdZn6o3zU3rgB7lqOdcRuMbzJtAUVu+QoasMbiXItsTqz7F/VOoFWpI1p7UAgFeAksl1B3tcKYUeNU5paCtkYnDVN7zXYZQgnI4dWz5UOLlwmt/uAJyozLHDgZO6k9inuJc/XcnWsZLaUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575254; c=relaxed/simple;
	bh=ErjzWskfVhU+16Iba0n5yygzqvW4UUkRFlVPO01HVxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gPO9GvvkXuCLCP31V1Oc0cBg8JiRbW1lgpzwndPgL3Ysu5xT5wrA+Q8e7SXdUUfCiz8YeiaPIph+qVkAf8FDN6ZZ3HXb1RZDuhvVQ9hKHtiGk3kNXTNC/RvIhhXmNhmAs4ZiFymOiLiKCm/w9dOfeXeWqnTGaIZasCkzGPXO1FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=ECKyT4gV; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="ECKyT4gV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PN/qpHGilOIekDo2Sho/U+XxtiY4bxjZBm+TOhU2dTW+oB06ywXDkPsy7riEiSoG/Ecr7t/gZF5IsiKgIE+Ffw9OO+d/6jhCn+0B5z/F7Dw6Ddep0N/9eQ/AV+YOVuqK8Yjsl0b+tQZLLvA8Q4jPsgvqJc8oHLcRfNa0hwe6+cZysGUbvzf5hUHmYrEm2YcnUipprQ12gprh40f3tCsZUAl6w31m1D5iXzkD4qzjFCjRUpEh9HnvIkezyaUTN3X2umDJtuFMxZwPUOeglhyPZNoN5zoAondpvWZ7VqzeV3SmziFlUF0xnTbGibgqOEYl9f37lGdemLj8OXFPxnff9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0C4gTLug8NCyQj+CFz0bP2GdvkulKYQpFL9ab2J1i8=;
 b=ia7MIQjFMjFTRlmSLPYMdTpKope1kkx5CHbO1b98UrTgQNudr9SaUqt7Gd4XwNaDOyUcHfsHbDlS38CMXEsaf+chxCZTvEKaWTnG2HZGDDyD6zJ2MhWxjwKGLRCfpVtyr9IRX5gWNUpV9iA/NcOt+mpNgYlyWbwUjwBj160myTvB9XRBnMby3Vpi+1C4+F12zw63/WNsPusIi7nkGyv4NS2slnIMaMN2yUGUcrMTvG6zX1XD6RwQiN8oY5+kFMKe6lioMDw37prjed7Apv65XOkmQnMexXmVIysW+9wYZqW8YUIytpx5INLaGsnsLfi8DLr49qQ7s5DDxrjoVeT0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0C4gTLug8NCyQj+CFz0bP2GdvkulKYQpFL9ab2J1i8=;
 b=ECKyT4gVJ2fHzHIbCIGEca+IIEuPe3Ly7/mQnvGP74kPsMIDpPK+9A22ubZr3JFQOWI9IBlF3rUGXYXh6L0cXR/dRZ6598jK/f6ItIlsRbdYUGPKS2kpkj4jNtTneV4Q77vA2wNE55KH/+IiU/u8v8DTM9zUkki9p8HrySKjWx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:59 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:59 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 12/15] serial: 8250: allow low-level drivers to override break control
Date: Thu,  9 Jul 2026 13:33:11 +0800
Message-ID: <20260709053314.435629-13-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To SEYPR01MB5387.apcprd01.prod.exchangelabs.com (2603:1096:101:d8::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f881d78-ba01-4fb1-799c-08dedd7bad2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	F9UjY4yj9Fqhx/CFjOksdjuQz1GAZB0l66muMqdPpk743RwmOIsn7vVQAbUFcpSHS6YHsBlTuGhBKoSmhN0zAwjxKi9VYMudDXgQHnV3vd1HsLQPlKV++MgbULNwK+d3uLVw2LaDuSm2cYznjC0ZKG6YAE3TA1qkz8Po+x6kwpf0fgVp7zF/K0E3keT/lL2TCZoDyN4ezEAHjWBYmKkPmgdHnjnsGfGMfsuB1YRLisps7IN/BbaAO0SGT6JGGDYqWtx09LMVKsDf55NWMYMbtYNONYt6fMFul5UDFekFRUsTB8u3pbzsWiEaQibQEOpHqevrzywNr8eMFXQ95Tl7QcMvIJ00eZ0/wy/3loRUNQE+HGhvvEczgYYBY5YzZgkBtsGm5tIjeodzxJVVrXrqdFryZiVRPuqy56pyRhMe+yLvNpqIm/0bPBQ7Um3kcs9wI1PhK1XTgM3kFHeGWaIduy5F4wf6pSJKITZAdcjOoLj9md6LC+EP3EOT4AsFidLzSyls0Y6ngMXqJQhAIynXvlnjZmImv2mqEfSfxZnsINFnBTN3lVyQiaf2ovxktKP/r1BK+HO3GXAu+vQAK9+yozxtpSSaNfX7gNsZNH2fvk7tWGrk+2F53MTKuw+UL0BOAHSPNccFb5/ovoA8cG2653VbewKbzjEfj+FMtNP7pmRHNlueUoa6UpTy6dlogWxBkYSjgXGDL2KFq7K6NbmgXfD2CZklhWjKoQYNssV1sOQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?14aQ/5mmUKxY7lrLjwJpEVC5DR3Pds5ERcDBH6FtezNTg0S5p54iz7t6E8y8?=
 =?us-ascii?Q?RE93fnubslb2v/sPxAK45n8e/HCWGWzGeemvY7jpdNX+kzn2VKNzH+rvJhJx?=
 =?us-ascii?Q?9mUus1+iQ/zQffSUQtLyqHUkcjADnV1Oi3n0ZmMhnx7HWs8svbI7luY7lK2e?=
 =?us-ascii?Q?0hQHAPPkt3zu3eC7qRgisTkSuArJINyynge0syM1mMe1GK+MIXVTo4Kf56rX?=
 =?us-ascii?Q?13dYvrw3bjR8z7lgLL7+ZJXZwqpDyZbsF9todsNkUbKRxYjcMmTwO621cdps?=
 =?us-ascii?Q?rk09xpX2Jqbro7H6njXtCaqkqlRkNxXWzbgAeuew95gS9uLwyy1O4vmkxh2l?=
 =?us-ascii?Q?OP1yFKwi5MsQv+AsVS3CiX2c3w1Sg1JUNlhp/WYNTAf9XnDalJq5szF9lGcW?=
 =?us-ascii?Q?1RF3Uu0yHMJojUi6+P5o7VBpn44B/x1uiHr2KXwB9IUyIt6CM68j0RW2qEGA?=
 =?us-ascii?Q?UYTlBdnVoYxMHjzPvXo29SsqR+q4TtnqewGWOhR1M16T6pLo6guKhcn80qAr?=
 =?us-ascii?Q?+oZB2Rq6A9YdY9j+NKUuJ+2vj5djwHleuAJgENbY1WqFX7YbhKBlZNPBaUD2?=
 =?us-ascii?Q?fvmJJSk8HgzYriPi1ogyXfvvZaUFOKXx8N50vQtXEXzMpP/aCN1G8rXt5ruN?=
 =?us-ascii?Q?0KJFFmfwfIZFrwVhM4p1HM0QG6ROxCWgPky/tnVeO/c8m/LLU5Sn7UFGkMhz?=
 =?us-ascii?Q?Ts3x+x9rag7LG5d8S7xDNDVphjH1SCTlll0cBJ8JAXQhgx/t3G4CQGtdki8+?=
 =?us-ascii?Q?vSl99Hy7FqvieRfcbT1Lz6I82K48jipvn+u+Lic4pEwno8jcexsuZhAILwyh?=
 =?us-ascii?Q?MbvLHscCi0utWINGgDrBDMOoAIFQhAi7ysBR1Xi0pnBcUfiBv2zPMIR8TN6D?=
 =?us-ascii?Q?czOCwqszhzfdRAN+QujK0rbffeYPoa0GpKN9MK6QBhrlWHhnu+9WSuu7HTAi?=
 =?us-ascii?Q?Iz/3Z1JVpvr11FSugVat5uTdcW3rmlz7D9FuJC8qqPjIXHRWjqXmd1xROh4X?=
 =?us-ascii?Q?z0Mf59UOTegWRZ7WFIRolBc77G0HjPuCnrYSNkqT7T7s6tbW6oirqJoIfTRE?=
 =?us-ascii?Q?h//VgY6FNwItPe+C4MyBUmVFgM7N1V2OK8B84a5BBfIaxNADsVECU3Jt/Kq5?=
 =?us-ascii?Q?bHwxdeeosW3DXeRoX+ojWMkud+U4SN6IThsAt2Pw7MrYRb7031pGDrK6GfVB?=
 =?us-ascii?Q?3NZ/Bku9AB74uHt+lpDkNLH4vRWSZ3XJjTKsVsSS3tt33bqCvLOShewSD3GI?=
 =?us-ascii?Q?XA+h114gWJQbCvEsETWVgI62lrpUygtNP2k6n0idxVxOaFDCrYKgg7f707sq?=
 =?us-ascii?Q?QyI2ILz9BszDh4ONWL59EB9ZxioUHR2lVa3TqkBPSfSSHj9U+ZPUeGxLzcMD?=
 =?us-ascii?Q?NtsVK1mbPtMZKLF28dbXtt03dGQD4j1soCugOy5nEXUcBneCqHmmlrtwcZI0?=
 =?us-ascii?Q?KC6CDapQ4Xha3UJ7qk2xa0uy8n0NgwFWb6fpnNyLkVUyWtNgtRwFjtjgw5EW?=
 =?us-ascii?Q?Qt0Z9rAS+BSipLCpows4dOqID2NFJVv+2Ti3RrTWaH72YTyjzwjBUcN0CmZG?=
 =?us-ascii?Q?Y3BEfnBKcI71z9ANNv92D1cyhKXKE3vvsvHdUHmyyiUdQg6w7LzavKqaPZEP?=
 =?us-ascii?Q?IK9C/UTaB6wlHmGtXw0w0vlcyW2qHTnfB+Tp3UFBtXtkNiP68FdNlXS5RH/f?=
 =?us-ascii?Q?Akt0Hi+NdqhXu3Iamjf3fZtZKmfH8gBxlz7e+ef6ibd9oCzerqgnUSnfGEIp?=
 =?us-ascii?Q?VCMAvgWCcCoAdzU3bskVfbgzinpGYic=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f881d78-ba01-4fb1-799c-08dedd7bad2a
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:59.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFv5yWCJ73pcEwiRLUIZldH+NRbRclKHSp8YMyNzyvLRXymOGRDk5EwQjbcNyupUbkyTaXRpUXqaQ3uWW7A8heqxKobWo38VMeg2pelrsN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

Some UARTs require driver-specific handling for break signaling, which
cannot be expressed by the generic 8250 break implementation alone.

Add an optional uart_port break_ctl callback and route
serial8250_break_ctl() through it when provided. Rename the existing
8250 implementation to serial8250_do_break_ctl() and export it under the
SERIAL_8250_PCI namespace so low-level drivers can reuse the default
8250 behavior when appropriate.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_core.c |  2 ++
 drivers/tty/serial/8250/8250_port.c | 11 ++++++++++-
 include/linux/serial_8250.h         |  1 +
 include/linux/serial_core.h         |  1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index bfa421ab3253..0a3355eb4bc3 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -796,6 +796,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		uart->port.startup = up->port.startup;
 	if (up->port.shutdown)
 		uart->port.shutdown = up->port.shutdown;
+	if (up->port.break_ctl)
+		uart->port.break_ctl = up->port.break_ctl;
 	if (up->port.pm)
 		uart->port.pm = up->port.pm;
 	if (up->port.handle_break)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a17fdb5d68d2..72ecc0112b8a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1937,7 +1937,7 @@ static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		serial8250_do_set_mctrl(port, mctrl);
 }
 
-static void serial8250_break_ctl(struct uart_port *port, int break_state)
+void serial8250_do_break_ctl(struct uart_port *port, int break_state)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
@@ -1950,6 +1950,15 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 		up->lcr &= ~UART_LCR_SBC;
 	serial_port_out(port, UART_LCR, up->lcr);
 }
+EXPORT_SYMBOL_NS_GPL(serial8250_do_break_ctl, "SERIAL_8250_PCI");
+
+static void serial8250_break_ctl(struct uart_port *port, int break_state)
+{
+	if (port->break_ctl)
+		port->break_ctl(port, break_state);
+	else
+		serial8250_do_break_ctl(port, break_state);
+}
 
 /* Returns true if @bits were set, false on timeout */
 static bool wait_for_lsr(struct uart_8250_port *up, int bits)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 01efdce0fda0..5ae00dede026 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -192,6 +192,7 @@ void serial8250_do_shutdown(struct uart_port *port);
 void serial8250_do_pm(struct uart_port *port, unsigned int state,
 		      unsigned int oldstate);
 void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
+void serial8250_do_break_ctl(struct uart_port *port, int break_state);
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 			       unsigned int quot);
 int fsl8250_handle_irq(struct uart_port *port);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 110ad4e2aef9..f6ba3e7b09f1 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -463,6 +463,7 @@ struct uart_port {
 	void			(*shutdown)(struct uart_port *port);
 	void			(*throttle)(struct uart_port *port);
 	void			(*unthrottle)(struct uart_port *port);
+	void			(*break_ctl)(struct uart_port *port, int break_state);
 	int			(*handle_irq)(struct uart_port *);
 	void			(*pm)(struct uart_port *, unsigned int state,
 				      unsigned int old);
-- 
2.45.2

