Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C33C097;
	Tue,  7 May 2024 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114626; cv=fail; b=Ua4GGKfLmWyW36E+PB6b9+JGj0GbPfa1evBQCjslV4ZR8b2UDqJ9ed0O+OBz7qo+T1C8m1IjRcJmqHDnTGuYEmWVPs0gvFaeak1p0Rz4vMyWpBgTBZxHnAwvKTOb4bWzN5FiRQzGpSZVjiXnpNKdQrGXSFUKe5litlk6o7RzZ0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114626; c=relaxed/simple;
	bh=Pu2py3MzeHWKZMrHR2Zye8AlThfwK4m0Da4QqUYO0w4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T83A5wI/lhi9Qkg+hZkSIxp+MZCFDm6kIbzrq+KP78+uaT3LuaBfdyszRw64AvQ55okMuNSyvP2nbefn7bXyyYcKcqUVJF77b6n4e73NNmoYlBfLLn0lPu7rjjKQ1Z6qqm1/5FIBnZXQ+P3/HKRl7xFd8aNst3dH4I37tkr/6j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H1Br0AU7; arc=fail smtp.client-ip=40.107.247.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H1Br0AU7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aloHTKyuYhSZkJU95OZiBY5v/0Rq4Dz5pvsOsJtKxsXK4My/xMXtSAdsvkrQ/4HsSPAdt/CxIpKwZdcGDSjTQncho3ufpAFm2+PiTxsUg9yyqVZ4XMtsegoZUPxq1UGpzdJlgRyRbDBRSTXmYJgu5PT0hY8J/btR/2QReCcPmBYciH158P6CL/CCps2ne/VfZ7smPyeL5oL9HvKKNvxNnCrA9U6WiUxTq9dHmti0vRcHc0Sz34YOGsqwysfXBWHApTE4vcUBsJoSodxwdw7Ynmkl4ms3H6kEbm8hYgFb95Ujv17N0VOERwTNGrgtkuNWtE9X7905IClENeiMcRqLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcoW8o6oEq2d9mnm2NMy6isoGC0GF0nEtBDeGxk3UXs=;
 b=B7ysaw0tT21oiJ5KL/xvbk9Yyni+aWD6KkZ3LIkdvUBiAsq73qVJOn5yMhYLQDNcGj2JqCTEkg1liLA6jsR3boK+6I97u5s4mEyR6Fq1VXamFV3VsfMK7QkX+0p4W+9iMzlvhqLC3qVqyo3Ks6FKmYplR81qjIFSgO/z2vr3FqiaYAnglu7KUV880qRvtDoMLRP+uZeWa45epp5Q/aqEMbYGxmrr1jST9pOp/ATAz7mX0YAmWcVPcump73lebJwZmNae/pUXR2WEsOb+wmPwNKuJ8hsrRjl87myJ77dNSK/eWbA5oFm+dqWOyHmNVCdm4lz6CjcK/RncYQPVQqaaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcoW8o6oEq2d9mnm2NMy6isoGC0GF0nEtBDeGxk3UXs=;
 b=H1Br0AU7QLW428YP9avgwnCcoRmcOM/XXtjbVO8E7f5IxMsqyCi+7sPDkEIHteYRBk/gYLDiAzsqV2CARrjk21ukSHZnxSCnwAc56TtnG6hpdVJR6V7bQCSMCEzTl57Pyt1eheNZVxzlqW8rTMpDxQJ6TN/KTmPsBQhvEMrz8zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 7 May
 2024 20:43:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 20:43:40 +0000
From: Frank Li <Frank.Li@nxp.com>
To: alexandre.belloni@bootlin.com
Cc: conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH resend v9 2/8] dt-bindings: i3c: svc: add proptery mode
Date: Tue,  7 May 2024 16:43:05 -0400
Message-Id: <20240507204311.2898714-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507204311.2898714-1-Frank.Li@nxp.com>
References: <20240507204311.2898714-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3b8a72-1b9a-4988-dd1e-08dc6ed660b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WdfVDGFxXA14NiK7huLPIlouVyhLWUbfWBdFaPImG7mnZSsOLglVUgSnBCeD?=
 =?us-ascii?Q?JeE4h8XaRgA7ec0plgKG2PJ0UbxytsKKvxkUIyLLjAVyS9NMnjW7NISrTQXo?=
 =?us-ascii?Q?JWecygjf1mkUue1rITxt2dUkPHdr+A5BGlPgIPYTYz+DLTpLggwHyBKlbwfc?=
 =?us-ascii?Q?5hEa0dKOCgpDNxfmDU/V8ebuPCzbhiaOXEWUyItqyZXphl+px6UF9AaHBwJX?=
 =?us-ascii?Q?BcIH1Bj0SA7+euK6NA26CNTuykgaNykXsPJXiByLYly1hv2EhOQfy8ZBriwR?=
 =?us-ascii?Q?TvZiFDWxzr7PiMRDlBHbsceEFTJXt2gqqDoMe25dzi4mTf8TWwo2j7LfuX5y?=
 =?us-ascii?Q?FOMKO7kuYan06MBDSIfAqr8VvBh9QY4vOa9WFYNcZ+GEQL9p2Q077orza1+K?=
 =?us-ascii?Q?jhsRKJ/bOlA7zG0C3HjOcUxhJ6PTf95LsQ8rPpNFQPvxBGnfiJTsdNYKVPhs?=
 =?us-ascii?Q?S4cUAWy5EF3ylxydhCEtzsCHm7LzmnYz7Sd5sHf/hRX4qbH6cCneIqsfDVJf?=
 =?us-ascii?Q?8Vm4YE/jmMCsaYoZ9S0KOzXqe4+yJqKF42f7b+rrmDIuuzdnb2BCRLtVomDS?=
 =?us-ascii?Q?CPdLUfgQtNDhjAVjcU9gkPZp9W0wRl5+67Bm8Q41xPT95g/o036OXDIGgnn1?=
 =?us-ascii?Q?FtmXOPvSMYro6+RYxoL6ZOcWKgnDPhMk8Ba9qxx285AoBeW2p/SinKMYkOis?=
 =?us-ascii?Q?IleUIU5M6i7eR9aKkCCw+C576n9dqmwguw/o/XG5mzaIcQKsep17uLTntG3l?=
 =?us-ascii?Q?M30xTLVYggyk2uOaDNb7H2wkkXxQkpuGpXaMQbP2xFSlSZbRxhQDvQFFA95g?=
 =?us-ascii?Q?HRmAxtrxIB9C493EZzG9tRLUI3wA+nv+FB9s1ePBBJdFFWVO1o0F5vJRKQZh?=
 =?us-ascii?Q?XZOws4OdpJCvXSyorJMsAoE3sNIm6Nd+d6kyHp0RfQeIR7W6k/E58niMt11x?=
 =?us-ascii?Q?+MRtDWyRggNjJ3vociU98ScE2KI88xhPIjV+d3LRBf1+KCuDwk0LENE15A2s?=
 =?us-ascii?Q?TO52udKqu6DPuXyaUAexXvaF+C9O0G8YTfi+SbeJKkcdxhIL0pIGwqcKidcC?=
 =?us-ascii?Q?MQs/O9pdZC5LvuLQnOPDKPv2aGP3VKj9pyoJLxl2bnMUaypY0ACSnV4KvUOw?=
 =?us-ascii?Q?OoE13PvkB2l2ot6O2vR42BS0O1rn5Iz3ZRUAz8oqcZWuMtkjo7yobotieM6s?=
 =?us-ascii?Q?OGxLdY5u9u7nWAlz6gX55e+jU8U9V1cDyuJ9L/CuIcxhFcfjFqW1w93zTvs+?=
 =?us-ascii?Q?UVy2HboUWARvDIJdRtnnUTDBeI1sJazMwG5k2ds2qA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZCzd+eeL4FK0N/8SiyGGTLRDPT2dqkQI8e0QUE6lGFxrzK3/7GJ+tLwqqKe4?=
 =?us-ascii?Q?gpHMVrJPQ2RVd7H0exg8Eg8X8dRXvHGUhFpg3+YATw9h2GtF+FluzAGvJ/Io?=
 =?us-ascii?Q?Pofqh9sdw8CCnFUjm37lqF7crwFB3wRWq8HpEYXXlzMLjpYqVAJd5Hep80ko?=
 =?us-ascii?Q?nzLj977nGCL4IN4v7KOYGmOrWY+vI3TaXZ1ENRlBkITu6dl2Pu9G++1NZGBO?=
 =?us-ascii?Q?HatktU+364v/W21rp5P+rI+Nx5ZfboBDe1Jda32cYKxbcAL8xITuKSzqNb8r?=
 =?us-ascii?Q?tzGyUa2kwTXkDUKs4EJwEWll8ybBL7Vnt2Mc5uaKQhOoNq9bOPG9MIa7avPv?=
 =?us-ascii?Q?S/OPWjM9opb4z8D3Yn0CuxKNQA74T4n7h/p+I7zMHh55HrST7LXOrC52TvAg?=
 =?us-ascii?Q?NkopxNFG66pREXau6y39li9OInL/vq2aRGGfc/zKNiW82UhLjduefR19lzqA?=
 =?us-ascii?Q?4ZraNsMMPM8gmt8sFo7+oH46p2dCqxoaWJ78O+kOsrAxKAVfA7gKS6zkM6eH?=
 =?us-ascii?Q?6aCq2nb7Tna2WaDe9nc/FGv3suBD+jO9/ie/dM4c+fKymLZkkHYBIh8VCvN8?=
 =?us-ascii?Q?KvalEtCjGRqCItkErgaymJLyWyS30tbV+Jmo0oZ30ToTCRwnl0t8bqsoYmhU?=
 =?us-ascii?Q?C/PRlJ5lPtzFVSzFk9eDASPjBVJS8d+yN+f2PGO6GHdd+pKx5s8rVtzw/e4+?=
 =?us-ascii?Q?7t2qAxvnlJ1iG8KHr8iZhZog0byPirQl0nAiofjWmpMoReoMT76Qka+PPgNQ?=
 =?us-ascii?Q?dEFkM7upXrEhL9QPS2wnlbv4u/qxNgy1FiIEdvxoqPuamlcKIl0ZsgeIYQ1/?=
 =?us-ascii?Q?Vcznfdb8HvxK0YhzBo2q1zI9Tc5rPDpCKKPrR21vDRcnso0BUyWf2Q2T80So?=
 =?us-ascii?Q?lladVMYYm2VnGK839SyIOKsV8UVQQumxLNpIyiAS519W3GYheo5oA26hoqX1?=
 =?us-ascii?Q?N5+fcK0RVFVzYbQA1TQpHN3O7ZxZPHZIemrRtyDVRXimxf4GRxaN8o2wx9mN?=
 =?us-ascii?Q?weYZFHQZ4MXoIWaCuaXWBcV0Q2YjONWdgd5rn1uOHyR62hAvdySqNIfMDFXZ?=
 =?us-ascii?Q?vja8SZL/7wBqhkiVnJIQTFPxn35g1AUGqh3f3kAheDdopiHtq6I2HA9dCosI?=
 =?us-ascii?Q?8Uq17IPAwoy/l9a8vGSDBx+ODAzCB6MmXf9tsXODRupyEylBq1EXYrSwZKrP?=
 =?us-ascii?Q?e6+iaYjUddUQrGV8cWP4upzg8TAvTuYZaXGhyRE/COK/vJg2rqgb4+cn3kc6?=
 =?us-ascii?Q?9fRUltq4aziFvspUyiI8e3nbLoWDDEv/cwxOdb3YS2p0wkvC9oQil0wxZ0yC?=
 =?us-ascii?Q?cPSVR8YmznO/0WQON969t3BuecmPF/7J0rzZyRAafMca0dUhP6Nt7xu97JnZ?=
 =?us-ascii?Q?zi8fksXqOcFaivuoDLf5CBW4ZGK9buyzbRxHTVXSwU9lvC/O99KF+Xj8rpOo?=
 =?us-ascii?Q?8buzXNsOKO18eF+A6nPcJm5m2Dge6n3SBWrTwlQ/7gn/4FottFkqCpfjAm8s?=
 =?us-ascii?Q?U1tHjG55mZtygoi/VfjwhiXGmyLdz5vgj8HyvRtRqdJQr4QNHM6sh1x9l5am?=
 =?us-ascii?Q?xP04OLhtmmeF/i6QzSStNSXXNLOB0LbO9LkcnHV2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3b8a72-1b9a-4988-dd1e-08dc6ed660b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:43:40.5216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWH+GNITPZ99dakvjDbTvd7OiH9hS2oJQwRmbr/IlB7RrZv1gMI0+aKpGnqLicsWJH8TjzI5SfucvK2PlKszOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576

Add 'mode' property to distinguish between 'controller' and 'target' modes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v6 to v9
    - none
    Change from v4 to v5
    - add Krzysztof Kozlowski's review tag
    
    Change from v3 to v4
    -fix dtb check error
    
    Change from v2 to v3
        - using 'mode' distringuish master and target mode

 .../devicetree/bindings/i3c/silvaco,i3c-master.yaml   | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index 133855f11b4f5..3af77d143f018 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/i3c/silvaco,i3c-master.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Silvaco I3C master
+title: Silvaco I3C master/target
 
 maintainers:
   - Conor Culhane <conor.culhane@silvaco.com>
@@ -22,6 +22,15 @@ properties:
   interrupts:
     maxItems: 1
 
+  mode:
+    description:
+      Tells Dual-Role I3C controllers that we want to work on a particular
+      mode. In case this attribute isn't passed via DT, I3C controllers
+      should default to 'controller'.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [controller, target]
+    default: controller
+
   clocks:
     items:
       - description: system clock
-- 
2.34.1

