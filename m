Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2040.outbound.protection.outlook.com [40.107.117.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91961482E3;
	Mon, 26 Aug 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671989; cv=fail; b=hF5rUL6jwRUVUycl9spc8JAAVdVQGE9Zvvp/IjDbQX3wGmd0ZsDwKg8snbiXy47JdkmCeJPbR6ZuFSZEIv9Cutn250WKLDorwpevs4zwTKiQxLlSolezOdpFQ1XGhmFzJIdy0tdnzTSQcYuMy/rvYLVwXqH5GahH9oWnMKuFE/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671989; c=relaxed/simple;
	bh=t5UYAg+IcB0hC4Pa7chpX5zN1uloccVyugy90eBVd1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxhPqh5BRKh/Jo75VVHn5Nd0UrRPNmjA/n7Z44o8lOah1g1gkxPKJrLv7l+2rIQzuAC6A6GWcsuDttE2cARvPjXt2uDg13s37JJMpDNViQhlTslo2cNmqBc+H+TfYCpnSABI8iAoyBkkvhcFGY5yommo1hJXAt00/4zUae+tN6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ky2X5paH; arc=fail smtp.client-ip=40.107.117.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ky2X5paH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kExYuXNiW50Cqmx5vGYV4gfnQYrDHZo+fizarpeK+u1lWuX6KY5C9qXoKAJNwGCI+dFCl47Lcn/46VzxPF7YMCDcnZ2yWcWupRTaRXg5MsQUhQK57JzWct9osKM0ilIrQiEzfueNa2xTITJAKAeq7fJ9c78Us0bF50QMTJejW9JkHxc/cTauYznQViLdtW6r5m+Xs5JKxlKy/UwspZtTlLFHwTD6GRQM4NxefG6CRb22lXNNkHdI5dtiFaZkKNfbuXNrGo0Man0xrXYMD4NE99EJj/5Y6M0k0Sdh2LTas6Wi1qFyBAlYIOKi+lo208x96Flbimk2rNcsg4pINU01hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpF/ZRXxznWXnDGBAojA1le7WyXvlVDIX3kKIaUGpxY=;
 b=zMGqi+KHrZHo+ljdjroUB0WHWeHWMm0caUM6zkYo2C3Xsp//19S3dX6Np1gf1q3bODyDxu9Khx5mZPvnWGbZVfAkyj6VCSwmOIAAN3tzJXLEGhFlaHENcIZ/dBfW0xMTrJ6CP2AdJHjYawmaB6l4LzdA37maMnClnTqXtRaZYvT64frh45m0Tl6Y08Mm57LAW5CmZ5RbOZauxXt6UPw5rzAx5OJHYhS8DsF1aniLxiYhp4IbczxjuLqpN7UZDUTYn4iWVPm61cc/J2j/wgGQZPrYh1U4TgduxikBKabI1KYQqXudFvueRITbdcStEmvAznRe0BPuCupDK/oAWGvqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpF/ZRXxznWXnDGBAojA1le7WyXvlVDIX3kKIaUGpxY=;
 b=Ky2X5paHFlbVDeJ9RB9nfOgE4QJ6hgMUNQwVSYNi5HdVzB+Ywkx/BWTUJMWqAOrdFzxXhAxGYtDfhJByxeoOZrK2RHBMsLvdMDvdpB83+hjdZ1JE5PbnssEFIyI4Sri1GgxDLYhNJv2VMDu+ueUkqnKXocSL7tHZnxhMpa31O7jCA80V5/I7K/tkYHOZByky2d9Rd+H4RAhFp0cgOgaey8gH4FxXMM03Ywi0g2DNoQTcZNo9Hv5x80FPq17J87dvcweZGin/URmrdULkg9k4gUNgnEqNimtljj41Pg6EfynXOUAjJGGym2bXIQJL+DNGcMl+2eMw0swwbgNpw052LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by TYZPR06MB6466.apcprd06.prod.outlook.com (2603:1096:400:45d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 11:33:05 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 11:33:05 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v2 3/5] tty: 8250_uniphier: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 19:32:53 +0800
Message-Id: <20240826113253.7322-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826112933.7249-1-liulei.rjpt@vivo.com>
References: <20240826112933.7249-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0180.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::20) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|TYZPR06MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ba5c1c-94a3-496b-3822-08dcc5c2d9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZI+FieCya0yX6eMU2iZ6JftJ/5BYq86l7dHwGp7kA8o2xsT4Bt+ARih7eCzT?=
 =?us-ascii?Q?Y01CJ74iIO4OeobnWqBV31SgA0ma1aq734NUQo89atXkcfPumXnnvcEbHJaY?=
 =?us-ascii?Q?9kAW9b0EQhaIYIuE9NlAcA2HhG2oI/wfLY2qvOiZnhfSmwZIMb2c7adpvLkF?=
 =?us-ascii?Q?2ntYHcD45QLySFheTQKJZ9o7WAxNwnC61hVxD1D4JKvlsZNjiuAsymoPaXVH?=
 =?us-ascii?Q?CNcoB880pD0+CfRMONsJ6653Lp7E4j2vJrUJncRNVGUj4r5PjYfALRKB32t+?=
 =?us-ascii?Q?HXQkBCCwKIp9uwyZ1xTeUUeb4i81Ip3BUW7So++TWur+tLsM9q7wHRjEV4so?=
 =?us-ascii?Q?0i2XmdW2WnO0OMHXXcIiSi1oUiNheUO3QFxubvYOF5txJ+qmzOQoDVohaAZC?=
 =?us-ascii?Q?fkQig2FTxf/Q04zaBRPf0WyTrFTpMNSCvhEhGkcZMnAVvKoJQhHtS96J78hQ?=
 =?us-ascii?Q?Ab7Sjo9HByYRy7UqCdJnTDutMgnEriiBBW6U6wlrLkoNi3fR0GnPWWwwKIq+?=
 =?us-ascii?Q?RWWFLBM/kzbX31i8eOrcIP3FGFG9n8VlGI3h2HdvnAqalCo0yfBlfVBXbhfm?=
 =?us-ascii?Q?hWpuAek1omgCFJHrmqFfWsKPZFlBcXRVRW8Wbdq6VUwouvTrJ2HtrmJUCYc6?=
 =?us-ascii?Q?puLW3vCePPuv/mwxuIvH6vpEtV7Ix9dO0QvYnUIVSI9YyxqVKvO8xz5kz1xO?=
 =?us-ascii?Q?cYTTsdVeX8k6+EyYr1sBEn/NGhGFWpLzDYDDXvl2QiFkHKcJjGBOPIMHvaH9?=
 =?us-ascii?Q?vshNaCRfvEu+xIlBRLbF2/8MMt+5i6//c12yuh3Bq5MrJ+RynAHnrYskByg4?=
 =?us-ascii?Q?pTRyD5ZZsN+O3gGL5kgQEQaX280h1zd2FxtDPZw7auOap5ZTVcGOOm0IdEEE?=
 =?us-ascii?Q?QA6Snb495fsKUZoIZFqgcfDNRS+GDHSuy6Kn004tdrb+xVmDZH3/ZtpQI5px?=
 =?us-ascii?Q?cP6pSwpt9vL6bpTrARu4Rq7AUzTalHqbB9A7CSD6uXm2bqi9VX/HO+ONskyl?=
 =?us-ascii?Q?+fDdiDeFYBx0dtYPLsZFrPHBptuxXa4Epz4IM358NGTWWwSXwynEcuTExRIi?=
 =?us-ascii?Q?h7IDFBN2r+zFqCfGJUGn1SquUkLU4y4pY/fGCvjeaIEE6Z23LGqxh4IyVOVZ?=
 =?us-ascii?Q?O4THkZWpsHaWQDvieqCCutyRUY/44xGg4NR9wJzMer9io8iro3gRwp7AEiun?=
 =?us-ascii?Q?WC4O5FSw8K3v7cH+gd/scRd9fvi5vtNDLXwvPiRzOXq5O6IruoBk0a7NjK6Y?=
 =?us-ascii?Q?VthF92z9nZ8GQ+M3pskZfmS2SHnJO4G8CiDny5afdDzg/scS1jC3OfVGPNdT?=
 =?us-ascii?Q?/Y4l69mdGJLwxT7N4kd60u6KtPrUY4Ja2l7GjOZBHF/0voQ0PiS3zLwqBuMK?=
 =?us-ascii?Q?UEPLWjUAMzXWlNY9n+0ZJo7fUEoABCZkPJ9lV84QppcbJG95gQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sibkuop+GhPvhnVzWjHu7h2e6T5oMmZ8tWgXfkb9cVX1HbRWRfVKPmAS576B?=
 =?us-ascii?Q?oR/nkvSRafMRdVUizIbcKehPsJ2VO+6ddwb/8KIAtxyN+yuB+64D8Wf6o2Nv?=
 =?us-ascii?Q?otE8wSOjMDKLefmiJVUXQ4JZb8vhkaBHfNaJcbYfhsVJJrysX+nHOyRiylon?=
 =?us-ascii?Q?KRDGUAmYLiPhjZC/PVu3RL1oTdxvRZLGhUHoIuygJISQS8GQo+NgVn+t8XtN?=
 =?us-ascii?Q?2THAiXfb7ImU6EaMTmtZ5q87KD9RKRpmw/v3Uyb1vi9ghAAQQakjhmOlXHyQ?=
 =?us-ascii?Q?GUj+W7i0/QdGvUDRlQyXYxaCQc3TvdMRGlhvtYrZIjsxpThECq/mUUUQW2kY?=
 =?us-ascii?Q?jRx93dSma6C7ilRLvz1HnUtKfF8W0+lbs4h6/kIQ0Hj2sCDrAi55aczO2y0O?=
 =?us-ascii?Q?RbspNzQ9SPF94c+5huMf7Vm6PMyGUSDddfy5rVe6up0hM2oOM+TCx7ESdLlY?=
 =?us-ascii?Q?kMgSp/JOv3FLUOEXa+L3b1sa03YrOZpLyuKCeFoxNW0BJXHYyJrgnrSieEtH?=
 =?us-ascii?Q?Bv2vzeln8o/VKATMkpNu/XHl1iq98qxOzdHxnJr/in8kadsifp6D7kPQahar?=
 =?us-ascii?Q?Qv+uPvg2kppvNoTrf/SxxVkTVWIATkwbGJIGI2USC7n9BFUkjb6vBK9JDev1?=
 =?us-ascii?Q?n/clA544rmJjIJ/oVfFX1SBWdIP09VZ+cNNW/4yM+TGLpnkuh8wuff0uwbKY?=
 =?us-ascii?Q?Cjs9qxsnY5/Hq3AeznQT63sna6unQyJJWVDBzId7zKqqfEIMgKrlrgmdrCle?=
 =?us-ascii?Q?3I0boub5ET+T4cwrDnL8Roci7Jd++/NZRR9IH23NQLmzRm1/a8tszlGDdIA0?=
 =?us-ascii?Q?MlXZaWKsLuS5z9P6JEHzOupCrJa7Y1XKeRrOuJdcoE2173avmtWHjeAA5XSU?=
 =?us-ascii?Q?NvII2G1GDzNNsf5K+yroDN+GWOSviEqX4FsXpaOtCRMioTcORKkJ7ig2Z03F?=
 =?us-ascii?Q?FuR0iH/+OlB6BRIGzq0XdRo3qhRcr6oYZFURDhVvGNdDFO4qv1DXJUUkb0SE?=
 =?us-ascii?Q?2HTsTABQ8UYahN7bNLZLecbtU9BhIOUO7z3IFwqMhJ4RdkHrrQ9jdUy+1cGO?=
 =?us-ascii?Q?/vG9NawqwJ2Fi6IJKqyvujB5DdBcazipwquU/vN7/Qu45Ix9V2Kuv2vankco?=
 =?us-ascii?Q?DMbcf1MjVLvIPOu4rB3yVgFqQ8148kC1fnzDez19beX9U6TxepOUfAqcBgfU?=
 =?us-ascii?Q?AQqsvtmn2S3yUqUv4ceWL5yT6ybCH2VlIV3qTpP63mESdb/Iv1TEpixIft3H?=
 =?us-ascii?Q?IHxgdhGBBzrLjAfYt3LGryZ3eRec7R0WOVFbnJ7WX7CDhD5L3nOBwemHmtls?=
 =?us-ascii?Q?KfGaLSqrxJzJ+5XKVy/d2rcRBKsYUWmbHd8IyoxJWqmz5SH1nOBuXZxA8nzV?=
 =?us-ascii?Q?+dTwMQQnA/N2Yl9bfwDF7wakhhS03cAmkfigbH0HaivQ9UlXQqcie1te/YNh?=
 =?us-ascii?Q?1Dtqqn6dLUSyg9/0vs+ld2oY5rBv4xZCPeSof/etPJfOvqIDDPhUyA8iE3uM?=
 =?us-ascii?Q?1CV/mpKn2fWjj3KitgdoW0ZIeSztFtJ2SgIFX8ftVJAbThd2YxxoEMK2Z+8P?=
 =?us-ascii?Q?ZNe8TV1MUUMXKH8RGmqvv6qGBgw2OGQvusSTEK/n?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ba5c1c-94a3-496b-3822-08dcc5c2d9fe
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 11:33:05.3412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMlnouqcBYAXPB7O7QfZ7tGed5V4/cGdiAL00Mb9rQljtcvQHiKyAVKwXQ69Lbe2TohXCZwcbAiC4xDiJbuo3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6466

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

---
v1->V2 no changes

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/tty/serial/8250/8250_uniphier.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 670d2ca0f757..6ddc4262d22b 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -180,16 +180,12 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 
 	memset(&up, 0, sizeof(up));
 
-	priv->clk = devm_clk_get(dev, NULL);
+	priv->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(dev, "failed to get clock\n");
 		return PTR_ERR(priv->clk);
 	}
 
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		return ret;
-
 	up.port.uartclk = clk_get_rate(priv->clk);
 
 	spin_lock_init(&priv->atomic_write_lock);
@@ -222,7 +218,6 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
 		dev_err(dev, "failed to register 8250 port\n");
-		clk_disable_unprepare(priv->clk);
 		return ret;
 	}
 	priv->line = ret;
@@ -237,7 +232,6 @@ static void uniphier_uart_remove(struct platform_device *pdev)
 	struct uniphier8250_priv *priv = platform_get_drvdata(pdev);
 
 	serial8250_unregister_port(priv->line);
-	clk_disable_unprepare(priv->clk);
 }
 
 static int __maybe_unused uniphier_uart_suspend(struct device *dev)
-- 
2.34.1

