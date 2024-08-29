Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2057.outbound.protection.outlook.com [40.107.255.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987018C91D;
	Thu, 29 Aug 2024 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921627; cv=fail; b=SJ8WzLpatb5+/BVOSqcJqBc4NSAQmEVL+hAAMvGM03nHy9WFMYvKT/yD61HWkWnqHBO330K5csviTDnbqaPZzO/fviKvIJu5aevROBHbu96riQy0+ofTraqPbWZ3y128QdkbZYEzn29FKUR7bzDYk+LU42Np5/jPB8W9oUNJ1OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921627; c=relaxed/simple;
	bh=QseR9XIxFYcs9IA91uMEaLHQJxz2D7jpKiVrgf62+8k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fqACUOeh/e+HuRGTfiRFCq00cLdW7SCfxRpjgVybi+dDBry1iKHffFnMumvyv07UlOHiZaaMrV4kBolS1TNURee/TtuIktc1suriGhioZte/ZJdqRdUd9T592xfWQbgvVn3owoD504tH7p4ga4j/nIDURbOvrsOJuC+TnWHBmOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CO7eTIZ0; arc=fail smtp.client-ip=40.107.255.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CO7eTIZ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=st1VL0Y08GC5+439L47up74z0uEdw/aK8oAqfwWYTi8xWkrWbhvLOU80O6rDiqoN2B55V83dk5fxRBVnXiueUpgZ6CgFq7h93Sxg3Hcfu4UIEVjcXGR5BH5yH7YrTnpa9Z14a13gFPAph1ZrmOkEHooYMy6MvLXaf60pEe9HT8RURvlhD50SjiO+6oNLRBrfZh636vq/uD9JpFUnOqTDzBj+Hz2hFzkT40oYnUj0vM4Dd/fVrgsYGxKDmGXtRY7oobN8lHGjhV72qcYViY+ogxdPYeCW9LfZkgF6ZKkdTw7E7cy54COcKqzJt8jZso0tiM6CLGHPdC7aBt8mP86Jxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jslOOAygf6ExEFxZUEIrshT0/0QcWXbW47Zz4rVKLoc=;
 b=sTrpe0HQ47zX0spYkHjQzuZLcewXYUBDr0KcuP8tm+Ou3S9BPSm2nhwVEa66VTt+v9ChGYQsZm2IjOm/lcarf2N/wZb04bR+k3GtksXMhGeupxYTeptV1bwYFSVY3O01eWp5lthun0nEGS2Wv5Ve7dhSp7GJvlCXOf6o/sqbo2d5dijBh5t7UCJUVKRxALMzrA32XBGw0ui+Tca1BjR2RVqAX3hNtd6Z+hTeUM9f6OsLMiF3YkycWQ9aHfB3pnq4cJIz/JJeXPo/0RqtVT2ph7MrI2/sH2mGxVOWUA96/vYmM00JjV7c9lW4J4zmutouzAEV7ei/d+IJSVo3WxP8Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jslOOAygf6ExEFxZUEIrshT0/0QcWXbW47Zz4rVKLoc=;
 b=CO7eTIZ0ZgO5c00s7/uvUoa/cad3ezhsEuxDifA4oKWCZK78hIJZnxtxKYX8vg8VcmsarU6zO7VPcHfnv3lznrPdmIDy593zaoxK4/A27T2rJ4LmsIC4+CWh7/O4HXcnLgEwKREU/rZlzpYF8SqBaclRk/lvAx9tYe249c0ferXxYKKL+Vl7Xo9kFHJFFSRVUDcoCKOEfgNEVEBau0j/VhGP9qPgyeCqXRyO5UigVdJnoykzHy5S9LAlc507wqDnbpsEAK/86YKHwy+Um3ZUTn4f+H+9osAzKXMZ334GKRM47NrXTcRjyT/SPMZAyBhyavHkcn8IO5E2e4+8X9x9Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYZPR06MB5870.apcprd06.prod.outlook.com (2603:1096:400:338::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 08:53:41 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 08:53:41 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] tty: serial: ma35d1: Simplify with dev_err_probe()
Date: Thu, 29 Aug 2024 16:53:16 +0800
Message-Id: <20240829085316.3144246-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0049.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::7) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYZPR06MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c3919a-d44f-4750-afea-08dcc80814d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?37cMdPyECuP/2ORfrVflAWDH0Z1d96mju1OhDvYKOj62+Zt+x7OwsP5ynDbd?=
 =?us-ascii?Q?m8TI27E6tjIRA2ERjA9QvbgsC8XA/fCDJH49bYZm8WfV3su/XU9mjR8Xk8D+?=
 =?us-ascii?Q?I/AqEEd8NpHpZoclX4D+OmuiqQDQHvf2jjM6/qeB6qX1m3P1I+Kb7x3yEqvz?=
 =?us-ascii?Q?xZ+FSFcaCBIt4JTrknHddvkwashdeSIDj+wms2j/Wo/k+BjmR4rAZP7C5jB9?=
 =?us-ascii?Q?WIlDLcuBrB+ote0xov93IDJS4X3EPGJD+Oabn890mmSqMzkCfx2HRuG/ND/V?=
 =?us-ascii?Q?VQYtdRf3zfIuZr6HSwwf6ETvpqXNwSrzVx1RW3JQzZ4jZE48O8kA2fQGYgwh?=
 =?us-ascii?Q?rzHN49TuUe0Jj0yJ/lcrfn0Vg5oP8qit8R4DjLC+TVT9i6zXG3d6aNXz5aZu?=
 =?us-ascii?Q?jTzoniDb/rUTJKou4sH2UUKwlLc4PEvNCEWrkjBMvceiQ/vBEWHWkb4nWyCl?=
 =?us-ascii?Q?xtszvr+uEoziba5QOpKG7vN1mV9iMbV96Uv0YUADJiM3aEzzRhI3OdFx0Kgt?=
 =?us-ascii?Q?d59gi0aKDEUdVuhfFUude7q0QWl/qRG6p2PHRKm/6Q2jxxy1ZH4pPONWQFhu?=
 =?us-ascii?Q?TlnUq9TOK8nPuoRupyloA6ob3MIZyiZ+JlWk2HV0yAhHcnwnFrOrrMi3yiP6?=
 =?us-ascii?Q?DZ19hcU6OwbtfZ6+s8lXGuNtwzfXMkYEcXAiPvUH58NjV8h7Yo7WhdUyMbZD?=
 =?us-ascii?Q?TrwsZKjj+GVkGB6wpV/jsPtD7nHDK9QhZMjatjDq9Xy9LHFgxiEAlLBJEVFz?=
 =?us-ascii?Q?pPAjGrp1SmfWEZVUXICYoMmfeKgTI79VVc14SiHFc0OA0bj6jKbI+xytzIZq?=
 =?us-ascii?Q?yHtJUgU3qBCN9OHoPONNjMd3ILYoqEB7pQYVqUIrH/skqpsjzusREHmy1BeZ?=
 =?us-ascii?Q?LNCqhzLcrpdtcAQ9Xeap392twGLzDlsx2KuomvMTqqsmVAzrq8Jks5bTk62M?=
 =?us-ascii?Q?9jBeAe1E25OYGLZbomdWIafgawUGUCSZfOdJIwvOqtcDRYdU0fWNBCbIsy+w?=
 =?us-ascii?Q?1Kgt7ZHQA7IZtFRQDvvL47icBr9/7453qTwm4rrBcbjX6UMs6P8xhTEV2xjt?=
 =?us-ascii?Q?LW8vYmoN+fZNseS20KqRxT5M7SgUK92wggidnSIrITozpKI005c5EfPiay+o?=
 =?us-ascii?Q?uzwW2DskxIESck6LKSj27obPPb2ETA8+XKSaHJaVB1GBUVIq5C4kSvAj9w6s?=
 =?us-ascii?Q?gmjsjfuFbQNu93kk/WrYcK7pGNcYrL5Pax7E+gwgDhkXSEeBCKeEbD9j2DLW?=
 =?us-ascii?Q?Bn3oV8h2+kdFESno+rhLy14bdwcTO10r8+iYI5qmfJR4KTZmAmsvr4UGRbrA?=
 =?us-ascii?Q?cNnZDXiJkQO7NxVp4KPGR9iklvkrDxn0X+XEplGeBwElUDzgzmVH60CuwiAt?=
 =?us-ascii?Q?7W6hTPc2Zb8wnDiw2L2gq1Hmp4SLp6Hg/BfJvr5fWeynLoER7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6TfyQupAUqXlKRjOcBrV8G+Msz5+tXAjQcEqznwkSj7rQnqvB+0kP2aAvz4U?=
 =?us-ascii?Q?d1PTupMNb5dlirUVo/R6msr9g2eo7CNVp4R1LLILhfoLWHvx5MbOiJ2xyiLQ?=
 =?us-ascii?Q?bqsxM/67RVb02jPML2Jb/5hzJEgYOce43T57ZmNfZ2/G57XjgiU6ERIk7lTC?=
 =?us-ascii?Q?EVzswxSsZvm8tJBxibiQJ42gB+tMNT9+1A38gl/eznflYJXLHzE8BGjEvf2V?=
 =?us-ascii?Q?KiTCe+hjEAHumGtG9/qU0M8BAi4jT/i7efVwsuKbSgpjDc1OOM8Eg2H3vUBN?=
 =?us-ascii?Q?dEtmg2CojoKTR8zonhjjFopPliBreB+MNijvr8oDc/i0MSgBFbku8yLu/SgL?=
 =?us-ascii?Q?hytrPdzTR3+LWw8NB4mtI10g9gbbKVibSNa/huu2lc32RJzXET1qVAuDiyBq?=
 =?us-ascii?Q?gj0yLJ0ZqUa32mxcWYgV3Xe1r8t8M4azMsSmGGNP/XCrVc8YKX3cmFnVzUZB?=
 =?us-ascii?Q?ddFtSFXAiAjCveatv3TvuYjWwtQsG+S1XHLLE7s66S2Gqe7ypaRB+KbHukVd?=
 =?us-ascii?Q?dsHU4FTQXfemSBXwikrDE1E8Effsc69A2WkTKFARxjov4jGdhVES80Wi9jn/?=
 =?us-ascii?Q?0pSdDdJQOC2DYU27POLULEp3giNFUCKpMEZHbLXXzPp/0hqn8YexxtNofzAN?=
 =?us-ascii?Q?T6b2rjyILSf+XaUPc62OGs0ihAFmU4mephPaI14U06iuBcmJYWxzaKJpbzaj?=
 =?us-ascii?Q?bBRAvxNLbT4CtJV1ZkPMgwukWdo+kO3YCj2wFJJUefM8Amhk/vHtDEYPjWFS?=
 =?us-ascii?Q?D8zS7iOT5ZFC0ZOIbUh6cVA0V0TdY0Q2E9HRG306xlpT0pNxpwr/ByPdbtDw?=
 =?us-ascii?Q?0GSS3RgkDXQxnXWXiZA1HGQCWwfFPJ0h8vemfX7EenRdJT7s2zPU94qDpwgC?=
 =?us-ascii?Q?45HMXth0e7h8C3N7ybGvq6bKtH1zG/oYW1xvDbRAPNcZJ+IEUJ4YJupt1Sl1?=
 =?us-ascii?Q?1W8GjltjMgOopC0VxgoEezF62HYiac+ZhWe2sracNhqfe1Nz5ZmqmvI9t2dr?=
 =?us-ascii?Q?VqKL7x6dYs2oVCQ/2o22Msng2RGhFPe+gs0SXWqUedLMMgqbXSjxuabqA/Mh?=
 =?us-ascii?Q?RiKGP9XQPk6Q29IY1dLPkDIguXoL/zZwh9Cfx5qm4V3/2nX+bkDb7lwXyFYp?=
 =?us-ascii?Q?tABzfIVNhcANSDDH/Mxlm3pc1PlluY5hbNwXHFjGYJ8RD48U5qTPI7LEdmM7?=
 =?us-ascii?Q?3eFUmfdWPjYnoEawlnHyIelBzGvUxAJD4s4i3Tcao48emohrCkouCBNsvlVt?=
 =?us-ascii?Q?Bpmbj0iMeFOb0/4DRxYHVjUNwEsrw7rhRk1IwjoOThex3wsFn3sij915lX7Z?=
 =?us-ascii?Q?oqsyMJdo//p80+JRsDp0IFrZ5N4wxBa0QDr3v9RaRNckTHlCWaW8/swBmSiE?=
 =?us-ascii?Q?3FBw9rJWGPARkQq+fgG+aMxcLIAn/JcSe3HoRtuXGThDfjzNXFaCHXTWi1+Y?=
 =?us-ascii?Q?oKYyeM8BYwTEijbYdk+jDVrSnMk/MuPZZiOyEatq9N3YbemF6pK4fwZ1IgvK?=
 =?us-ascii?Q?CWRn6EWs2ZKUGkuJZ/df57tKNqtyt3kNwh0Cf5t36JBXkuNxqd83qIhBtfcu?=
 =?us-ascii?Q?yKzUUnjNbNnUlKnvgfweQmFW0FT0Uk9/UodxqBNT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c3919a-d44f-4750-afea-08dcc80814d3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 08:53:41.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xow49idZ1F9VxhUSnYc18FTnXu/glL+SacVh839qfQYRvDvVoZXiQWfiZxPAvZu0Qec0A4VXEWsQCK4pwQSqpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5870

Error handling in probe() can be a bit simpler with dev_err_probe().

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/tty/serial/ma35d1_serial.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 3b4206e815fe..09d42a4054b3 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -692,10 +692,9 @@ static int ma35d1serial_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed to get alias/pdev id\n");
+
 	up = &ma35d1serial_ports[ret];
 	up->port.line = ret;
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.34.1

