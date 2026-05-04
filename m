Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013071.outbound.protection.outlook.com [40.107.44.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771C4347FD7;
	Mon,  4 May 2026 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884669; cv=fail; b=CCL3ztT1ZZS8dCV1oewldWxmqhTRs63rWezve5G7JpnUolgQCTJjIEam6/lrZcA3dENusIort+vfIUv73Y8wY9wuelB8oeo9Nc6VvW7QQFMmaUqkgj5qbOIcqnARW4QHsWfJ27QATQri64pCx2kWzUlAqzoHvL8Ppu/fyHB0rIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884669; c=relaxed/simple;
	bh=iwC2we07umoCEyfe3XnXxHT1DAmB1Ne5yI+a24eCyeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wk+TPkdf37rzzx7Lkb1TWS4rk1LHRPrhHT9iq1nrv4oIO5YpOjboMM3PLdCZaiTyK6InT8zLMjQGBjkNVXb0p4SKoamPR7You7OXRHQn2ZwLzfX87Gj2RNbd/acDhEVWh5iKCRBLy01Vw8zneECIY7QXrZGaEAPFoOdzLU+tajQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=g/PFcwzV; arc=fail smtp.client-ip=40.107.44.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="g/PFcwzV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5NstC2qqccy02ncsOwtFkpu8NmhGnj7vKxgml3JkA//D0EDCAOJ079Qp7Kn+vVH9a63qzKbrmfftDvJ8y0HWDJebkFJWvtb5EgKt2bln91ywHXNZmqgxvHzj7cG9DwTn4wI0BgN5unvR9ors7CGZsrlBZIiI2u7ItouabKu2BK7fJxg86/Y+Ymn1vSHMkPmPRsERqbs2Jl79Yf0m5DAsxitYAJhkKDRJO1739AuOyDVgfOWkLPjN7yzlVzlOFMM89y4hFuQ32PHemDklS+T5tzEhl1RsBWuNljRaRr1wE6LJUiGdkxaJbyWIPfronbB1TU6Iursui9DwMcYvTuCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umOW8CWkjUIaD7mFYAycK7dVoQDUmcgsmWy/Kh7J9I0=;
 b=dAyG0ajSdfff3epSfR/Df9KP8SOGxOHIap2WVNdi0vyUGIjm0FYTG9KC6NLnPWcSwWx/NbguI/FdRHmE410ypRFQN8gBuvDfqy7n46XHHECs0tr9FtSWfGGRHOwKO2ovyQJ3chdx73KYniIZlRdKIcvUlCFvGedHBU9qxIO00P5OiK98/MPm3qeN9N8vRTWIqB3jmqPFvpr4jTeJP+48Gq4GMc9i0JmiVTtU2vq9ZBwQzffYu9Fbsj64NpRUyU0AzQacZpKj+IGYEdsHvlgPz3rGhW2qET3YjYkjNDAYKmavE30KOFQ3tRBUFdOzktwe38roJ84P8wKI7PSZKKuvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umOW8CWkjUIaD7mFYAycK7dVoQDUmcgsmWy/Kh7J9I0=;
 b=g/PFcwzVk2TKtbly7I4hEDy4iZqH8XCiBl5OoofpDDEdupAuSMZ3fHmjBghppokV3rajF5HUaMb9Kwo4hCV+EsJva4/PIHZeFqgy2rcRNDQwKKO2Mxa6q86JYP6kTA6m75JNCiscf87Q04XMsdeGqmC23Xt+vy0JaRlCsSfXJN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5516.apcprd01.prod.exchangelabs.com
 (2603:1096:990:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:51:05 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:51:05 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 14/15] serial: 8250: allow UART drivers to override rx_trig_bytes handling
Date: Mon,  4 May 2026 16:48:59 +0800
Message-ID: <20260504084900.22380-15-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|JH0PR01MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: 78488d16-f8a3-4cfc-05c8-08dea9ba4726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	BaNkKVRgv3wNG3yulfMweGZvzX7HGy9fZZpwiPQsPiV25CnmVpg2RLcW0rJkxkCgH0Umfm6zIoltfy1uJqxxEQnWkv9hK2FRkegrWzPGDtG35jeY9GpCslh+a1QYNHWZTDw8yLL9PwvzxqvqF+MyegGkSt2vDD8vXqLywWeMKWrbx7HTG/tFVL/bLa1ILdEEZVtGuDFMiTx2zy/Z3uFaVUlirvcSRAc5XCy1QFM/yacbSDBolfTFgjzD9wPqMm25Z1/toFjO9AIK9igbmEZQiJPkYsk48TEIda7wBBeSHryo71mIIaBMcFZ7UUQTrKanVAdmgiqxPhyRBLPwBYDjXOzNw0S7AKwARIG8My/AldKjtHHRD6a5AF9D/3t2sfrwh0ftDD3O9xUxxwcYjxI+DXEUwFLKk124YpJbNCEGdl4mIGtdO1GiBwbhm37kDi4yU+hS7HL7nMvykHYdC9+8I0h7PzMRm/NgxiSnks5UKXfOOY/DB+EabrlfIj/RbMKKqxis0ZxDZ81m7cI8+qMoVhlojLZOaUPcd4sJZsOnCDPoWqh2Okt7vG2APO1n6UWOfg5+l7dog01r3vCzPLGr3PyvhXm4Pm4JwlQ2dcJr0uJLZUpYkRWv8LJpnwYy9LSNQFsOK6RnP+kqP8XsMOe2ECg24TRqBpWHr67l5jDll68TMHE8OMnjEYROxtfBTHQtJzhPgA4+f/UA9EQBDltNEtWyl9zNkADrGYQOC2ruX+iRbOgntp5LU/PROKMFPzy5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UULQ5JLjnsoG4pkhWzxGLL1TlXVIHGle5Rw+h1ZNgvgh7VERIBXsO0Rptm5u?=
 =?us-ascii?Q?kPKqFqpwM6oeUWJPgg5b08BWD8djth3YZnVAwUV/NBmUI4ZxFkdcAd6+9Qlm?=
 =?us-ascii?Q?mC1HgLlDl1NBCmwX0B2aS+JiA8GRdR500zRTNhUjvphS4vqsvU+pRXomaL7J?=
 =?us-ascii?Q?bvzbzBBHHASTDfTLE+KnJ2szaZAZA99pX/8giunT7W+CFiojBQf/cJPELfxB?=
 =?us-ascii?Q?NDHqrfnwI7fiMGJ+b2FC0UN56rQqNucPPT9dwoWM9t/XUaEHoas556LoIz/o?=
 =?us-ascii?Q?Fdg+9fdINhMFhimAnsNQrYvuSreXvSmN/VFmyceDJ0ZbGqxT+/1FKDry1X5y?=
 =?us-ascii?Q?ZeSQsAWlPp3dFfWSL8U6Iki/7nB+P0Jq84gs0wtmqoh48ln6ixPcbliTEOky?=
 =?us-ascii?Q?hKISY+3pKIrxBDzsy6qlg7Pznm+tVTqRiAQwq6CFPFt94bmVa239VR5aVH3G?=
 =?us-ascii?Q?aWwqou+JNAjdzb5Cpv0FLR1lCFjPDxc7lBUFHH52V/zPI9FFx66b3GaTegJl?=
 =?us-ascii?Q?IVIY11agTnw3UHsp2qeIsT3btyc3SiBeyWOzbHERAPGnfSOLN/MFk6Up5n9o?=
 =?us-ascii?Q?VXPqo1kaewcZDXHbIT1sR0wN4NSTpcWQlxrKHIMZdlFeofB1ZJ4VuURVnm0g?=
 =?us-ascii?Q?XRCW9fdfRJXYNKex20g+koz8ATugLVvaATog6EQPFgiVoQeV6H0TxlVrrBhE?=
 =?us-ascii?Q?3cu1x/7PyaYXbz+3fn/s5IU+gAqeNuo7NuiPbS08mUsHcU9PVr0CAExQXkgG?=
 =?us-ascii?Q?lsEg7/U9/88KkZ2cR4fAu4OS/D/IVOuo8eqrfcIlM87EIuWfNGjKBZ8gB3Wu?=
 =?us-ascii?Q?dG+cXhxJfbn+ofCk03RqbQO4Z5tnHbGZ0ctKiH1xbiE4iQ4aGHWUnTLtPDsL?=
 =?us-ascii?Q?u0axzBjUr1TT2kxiDdZFu8ha/ZCKHse5CrjGWTI7WGisPOs3u6z1hYY5lAoX?=
 =?us-ascii?Q?TL7jid2a+DZ0024aSWQaNJKGOUzn6L8Ak+MGiWSN0Q5f73Ludm0ysx0iLWCv?=
 =?us-ascii?Q?lNZp6WU+NS63XMDBTazRtSSm2XtJIE26LJPQxVHC3dhXXgOBZvr11isxx/4e?=
 =?us-ascii?Q?Rc6c+9iuLsT4brP9m9UawFFyObklH5yGPPBGu40C51GbNcQZrYDbp7CjluhL?=
 =?us-ascii?Q?Bo7f8tnK+aWtYaUkjAZAM4klmJ/SVrdDkC+XjLzzGf1LaYdY6lgRiQWyjM6x?=
 =?us-ascii?Q?QSmMwuv6JMSdmVHnOggUFZfOdSc1AKDdpDbSfPcnkqvCIPPx8/hSwcnixyJi?=
 =?us-ascii?Q?MojFMxNR3IhU1LT92sBryYs/VMGocaxwSQ1vygIwuGAWAH/1BHnGrYYVYzEh?=
 =?us-ascii?Q?oXkHYyuskQhI4xd2HSTB4nNY4lYPTiaAWxg5N5iPl7O5xinA4PfClxGTXki0?=
 =?us-ascii?Q?fd7bRHEIDypFKYOTvfWsDaRvjQP2I389THWV0bA4ATF+hc5oDdJp2rI+0Qy3?=
 =?us-ascii?Q?UA37jb6qET8luhaJkdKVijWjWvg+QkvuSIqpIz/OP7cieeqySakaf1/eFWqK?=
 =?us-ascii?Q?8OEQlgPNeHfjo1qxnxbEpMpTy+sti8qvr25czdVJ6k50Ct4b7PtUESWHEGKC?=
 =?us-ascii?Q?TK7VIIuzNSUPw8GBhSEETv0t6dXdL33WxO1ZjwwKRRzZGvrw9wUveSClUSwS?=
 =?us-ascii?Q?v7jhVBgx1ciZ9N0B9/6QOmllUD4IXmpFEKmKj7WdfPkhJk2ohxqYx/zTO2u4?=
 =?us-ascii?Q?GG6t+aTa4Sc/xbFsEuAk/g8jzxC7ZeU4rvyio/X53R/1wI58xu2qFf2ok7Nd?=
 =?us-ascii?Q?weabcfu1IdQ2VSKVokfSKm2DOp9kKis=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78488d16-f8a3-4cfc-05c8-08dea9ba4726
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:51:05.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvHFyis0NZK5ACz+XZWYTCjw0GQ3x+wXwg88FvPUdGlJ6lVsOwEdzsRfY9qS4bUntEwYUsuCPvphV/ud2waw1X2XlvDUzEk0Uh8lNF9AxI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5516

The rx_trig_bytes sysfs attribute currently relies on 8250-internal
helper functions and assumes a fixed mapping between trigger levels and
FIFO behavior.

Some UARTs provide hardware-specific RX trigger mechanisms that do not
fit this model. Add optional uart_port callbacks for setting and getting
the RX trigger level, and use them when provided, while preserving the
existing 8250 helpers as the default fallback.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_core.c |  4 ++++
 drivers/tty/serial/8250/8250_port.c | 14 ++++++++++++--
 include/linux/serial_core.h         |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 0a3355eb4bc3..a0a53b642d6c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -802,6 +802,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		uart->port.pm = up->port.pm;
 	if (up->port.handle_break)
 		uart->port.handle_break = up->port.handle_break;
+	if (up->port.set_rxtrig)
+		uart->port.set_rxtrig = up->port.set_rxtrig;
+	if (up->port.get_rxtrig)
+		uart->port.get_rxtrig = up->port.get_rxtrig;
 	if (up->dl_read)
 		uart->dl_read = up->dl_read;
 	if (up->dl_write)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 72ecc0112b8a..2ece8af5d149 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2999,9 +2999,14 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct tty_port *port = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport = state->uart_port;
 	int rxtrig_bytes;
 
-	rxtrig_bytes = do_serial8250_get_rxtrig(port);
+	if (uport->get_rxtrig)
+		rxtrig_bytes = uport->get_rxtrig(uport);
+	else
+		rxtrig_bytes = do_serial8250_get_rxtrig(port);
 	if (rxtrig_bytes < 0)
 		return rxtrig_bytes;
 
@@ -3044,6 +3049,8 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct tty_port *port = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport = state->uart_port;
 	unsigned char bytes;
 	int ret;
 
@@ -3054,7 +3061,10 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = do_serial8250_set_rxtrig(port, bytes);
+	if (uport->set_rxtrig)
+		ret = uport->set_rxtrig(uport, bytes);
+	else
+		ret = do_serial8250_set_rxtrig(port, bytes);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d9e5e3d02003..bba6223d7b12 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -468,6 +468,8 @@ struct uart_port {
 	void			(*pm)(struct uart_port *, unsigned int state,
 				      unsigned int old);
 	void			(*handle_break)(struct uart_port *);
+	int			(*set_rxtrig)(struct uart_port *port, unsigned char bytes);
+	int			(*get_rxtrig)(struct uart_port *port);
 	int			(*rs485_config)(struct uart_port *,
 						struct ktermios *termios,
 						struct serial_rs485 *rs485);
-- 
2.43.0

