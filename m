Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF3FC83F15
	for <linux-serial@archiver.kernel.org>; Mon, 28 Aug 2023 20:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjH1Ul2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Aug 2023 16:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjH1UlN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Aug 2023 16:41:13 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazhn15011014.outbound.protection.outlook.com [52.102.133.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AF6199
        for <linux-serial@vger.kernel.org>; Mon, 28 Aug 2023 13:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQD8G1flduzg2pmCKyJ4BMvLWmLtRIUoV7uk537PVKEnZt0IpCTzdluwVbu3z5DDp8U/8dvmuzhQ3bKe826WnPeyO/FFoxl9iBbkNaH2VVLbUaSIR2wtZa5z3AWmGnSuxBXlJtOUhOsu3q9TV+X/H5SXJ5DA2Re0jGzogqmk4WdVQqbox26rFzBUcMWgDCSBjnpvuXxZor8NB4h7RhK2GlRHAeeaxJlpd0eHO3fLrKtT7BNsUtX6pMelhUVYQ0tbvsKHESzbhethbuOQAfKgtew8YYOTo0HuOu8wcMUf/tw351oFSE/zt9uctNg7r4pD8L4cRPwkV+KuP2kY9yC6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErfDFvqc24cgD7MxmD8mlBI9ef2YmAr8BlzevsR6vg0=;
 b=kaSkPEr5dO3k8nnndvEPQD9Vo3/C39jtElXR1+Nox8szPYoVJhneqXsdCFS7HfQPc0eLEHo/3SsVW/4GSGFeArE4NNgIEV/Ugr/joSmxw5wwpCGwnPH6LZ7Zj3VdT4J2Bfirhl+SDM9YwwnEhXVRjid7aX+JrMs6XEv/wOFRyaDwGTIf+8LRcXRr4BiEhhiEVBurOft5k16e27BNIJn4GtNknLy6kiw86uSQBhDZ9uRc9M1dMCwRFcVcRfqAD+gISN9LLavUH9a/JdYYiEc7b0OqTpy74Q6/5tNXuQVoKUqa/LmOOWi/A1lxw7QOFcYn3PLE1W6g1zeWfL7ZDY9e+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErfDFvqc24cgD7MxmD8mlBI9ef2YmAr8BlzevsR6vg0=;
 b=HHoj0yWZlNgavXft953g+krl9Za6p8hD//rpZLK41gxbIxoFtltw7oD6LYMxeH57UD2z0lwfgCULT2i2sCtZG0KJEPk6dT3OYm5PhKcr/gDl8tjPzDgBZkxU0oF+qo1ezBDLGUGL6mwbGmX4Zt5NqkKaSCGzP+xMSWWloqZGiQPnMXINiRg2iQHw6I1hAVUPtOBujnq2Wkahx/TS/0Z6RRVaBfTVuYCBU9q+jxbjq/x5w1SeyaGIfKaBFalhpaiz8D2Hm2pjUYacERr+0M2MSH36T4JrglehsTFpqpoOVVs/8z+e8lgx+tMeF0Hier6c9qCQl7Vjpg8NFeqkBPLK0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by IA1PR05MB9550.namprd05.prod.outlook.com (2603:10b6:208:426::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 20:41:03 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 20:41:03 +0000
Date:   Mon, 28 Aug 2023 16:41:00 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     gregkh@linuxfoundation.org
cc:     linux-serial@vger.kernel.org, tony@atomide.com,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: [PATCH] serial: Revert serial: core: Fix serial core port id to not
 use port->line
Message-ID: <98a891fd-5a1f-6568-a12c-28577126a42@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::13) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|IA1PR05MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b99887-1728-4fa9-d951-08dba8071873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7lrhGHlrLxv1anB3jjTYafJpd89Q5alx1Ru244YdEP40ndF6SS5XBHOGzTAr?=
 =?us-ascii?Q?/P8mf8LRM0cAvLhMAV8L996ZgPrgDJ0P8OO+NUbltzxPEsZl7VWWFv+wP5S6?=
 =?us-ascii?Q?mX7VNoALABESPeJmAhJpyrNkDXU5MIpoDmjE9X5iJDEJ6E5vIVcHbz3Ocdnd?=
 =?us-ascii?Q?rukdUeNp0pXmrJpdKKYVZiT9WHVZioj5JoKB8BPcZoVoWPOsAchAt5FmjvTA?=
 =?us-ascii?Q?5btThp+xKKg1C2qe13ukfhTgo67iywAcHZY95ueDtr7/dTIJF7MQUjQlLQpu?=
 =?us-ascii?Q?huLCt/JdRr5E14gGvMmTpJfyxrDZmBWLqOk6sA06LdnHwQfgK5/j3jVJjmIb?=
 =?us-ascii?Q?DcAplD2f48R2QMC6009ghQ3aCrtIU9l8hrNYsOFjIS2GU1UQEkUye5snEj+b?=
 =?us-ascii?Q?peXFglZwZuEq4W3KqzPIeMMltQ6aEgYBi6Ekg+km3bcSepGxzNHqZMwzVkrF?=
 =?us-ascii?Q?CAJNHwzO1SIuybu2A01zl88RGkNA6mQrewwvZsdwqLMqymZQRGqV8P6/ZOWK?=
 =?us-ascii?Q?UyEPqrFRm8ZIWWKEW3+ZeYbOkfASTHVosEw8KJ1xkpn8r+vQtq1/E8w32fBY?=
 =?us-ascii?Q?WxaPgI83cQFgEyFSrpk4ZawmnR9MtxVng+Y1HMoSN9LRoTu8JZopdQ9+1RK2?=
 =?us-ascii?Q?i9d6aiDvYXiJea1Ej6B/2a9SB/672ivWlb2cvLgxgpbq8HPzgYYAeQlkauX5?=
 =?us-ascii?Q?rrKVqLyIX3a2h3CcGQNuFQT3DMvgsbbEqzHC/apWMqC+32co9fITMy6b/7KR?=
 =?us-ascii?Q?fMRn/BOfPHpqRbgtKbgxT3L/Xc6se+D1QSXoXVxTd+CXNRVQhRPH4xDox6lX?=
 =?us-ascii?Q?Eny4mI/Abkr/uBaoaK2T1fabQzB2PHNN0TpEH6LRVYpMdl/UeCtDSSEJH90V?=
 =?us-ascii?Q?SZsqwvd8/yCPUVtYxeVR/29nArsDiymjOrzJLdIQzyMZKNZHZXNrsUM20RVN?=
 =?us-ascii?Q?D6CzbrmGTcyB7+AGypqGJJw5jLDCQ50kIAKco7Ng4OwZvVbPt+rPiV3EVfBU?=
 =?us-ascii?Q?LRNbrtPlhGCjXYQ3wIBmXDbksztjQXxmMegmR2ImGW59e1qOVOLHH/Y42ya7?=
 =?us-ascii?Q?GkICVd5e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230031)(39850400004)(346002)(376002)(136003)(366004)(396003)(1800799009)(186009)(451199024)(38100700002)(66556008)(66476007)(66946007)(478600001)(6916009)(966005)(41300700001)(2906002)(6486002)(316002)(8936002)(86362001)(5660300002)(44832011)(4326008)(83380400001)(8676002)(6512007)(6506007)(26005)(2616005)(107886003)(36756003)(12101799020)(58440200007);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?njBSSYztNnXN86ZWAFlVpO2QiGfPGD0CU6cMDbuKqC4K49MiHrmeVUzMZzGX?=
 =?us-ascii?Q?7Ugvm3WdpRZyDAXouU0S7hoZwRbXn0qVIZMi9DuLp2OX/LJoi7o5shsoG+Vp?=
 =?us-ascii?Q?ew0HgfT8xLlqbMa87YJRZTkVZ3zQQ0LeSQMLkgrizURK35l1pAdd0WBCTHLz?=
 =?us-ascii?Q?yb80KYBfCT6FK2aWtGv87nChLmD++Yb96EhL7IGPvcUO5L5PA1jwxE7Se2Yo?=
 =?us-ascii?Q?EJReDofk26yMq2TE4xUan2Es091tziL7+6Mep1Evn1ynQw0b19yEvHYCtopW?=
 =?us-ascii?Q?TAeUV2P70KEzz2xUtVs1gnKBlF2DuZH/DH9EUW6fsqTH99LvwL0VQzuFPP73?=
 =?us-ascii?Q?bFfKiGhsAUdrEp/7/qv6R79OMVT7hZBs5OpvQ4JPhUAnzAZSAvBMw4ZbMQek?=
 =?us-ascii?Q?j1SH/PQcyS/y9ic0UlbYVJPAjj50sA96zric+tEeDyczj18R00kC3VG5siXB?=
 =?us-ascii?Q?UPvM8V1Uy0OrMhSM0+OVXs03Dnx3s8dl5frwRoY9PxF92jqf8WqYGCw2MDTZ?=
 =?us-ascii?Q?G7ADiOKSAAXMa0+Wc6cNFtZzKuPlymtluGE7uOETp0RcpvxpuPJf4FkuxdUP?=
 =?us-ascii?Q?FI2gK17Lr6HAfj567+g2EAEm4ZDHjrV7SREue/xGFsbvmxKErSJFK7zp3uo2?=
 =?us-ascii?Q?0CiNcOTaMuecHvoUrGPa0ASvLnTSNH+nD3rGr3rhAi5jaf9BOf9BnwLfzKXh?=
 =?us-ascii?Q?yRpq4JdKo0bT9QjLRgw5ZcaSJtZ8pngpXntq75S1OH6y0vjE+1OQfXGdpeya?=
 =?us-ascii?Q?O9MaQvqC5MHrDYBASUOR59H+nkTspePHq3gIvgxS/GSWonqCyM9blyC4zSuh?=
 =?us-ascii?Q?QrqNZKAD3mCbYfErmcxcPuYFMJNmOTmRMYkhdVKXqJeL4diP6ePqQ0uHwcrS?=
 =?us-ascii?Q?Bp0u5zuDDlgr97wtUqbvN43HKMGj31MWS8eJaRWjX3DXT7GVzvfVLYzvjjrb?=
 =?us-ascii?Q?CL24VSXEWnAuKApCqNDG5wRsx2j6MWFXEwhbnJy+dQ8EhKQLezTSeDIEZHYt?=
 =?us-ascii?Q?Vbejt4O96fBIcgOOrH9qSCbB0vfbJK4W1JaWZqlU2+rnSs5l3zkMzk2pHlKy?=
 =?us-ascii?Q?h076kvG1bkSGr2etKeVJ6MH/JZbj1NYJw9O/2NOOohnxnracJCMTlyRPBQSz?=
 =?us-ascii?Q?JiXdkkCyWCZRBjI1xZNpXf30L8LhvFWx9cdhI/wRDdea7+9niqI73REePfBZ?=
 =?us-ascii?Q?7z0rg2MTClDlfCo6yxYJightFavuTAMWkPgq9Do3Q0mOrWj0scMJK6/3jExG?=
 =?us-ascii?Q?rlKzFC+4/+hSZkxeA8us8NG5V+LaBsp7S1QWc+SWmAArX/Rkfb/wn0LuspHL?=
 =?us-ascii?Q?TKe/6IIpVrHuyOunf5MmUGDrIL2NI92XlQR8kth2FcpOBemiABG/qURLAhPw?=
 =?us-ascii?Q?Czkxq7QkER130MS69O8nyiMz/AEYq7/3T+Q8j7/lkfB1L1Lck7lxHoZLiRHm?=
 =?us-ascii?Q?+nPjnrecw5h6N5tJos7rdB68CzPlc55+b1Q/ydWh9p9ewW6zucAmTRnCeqEU?=
 =?us-ascii?Q?62uFjwfhIh5u/AKxABnJL8VIqfFI7twX0C0vZMB1tQLxl7V3veePvQc3N+UV?=
 =?us-ascii?Q?7ACNNepsZECsuEIu6ryHo1MKCY2saelrXCVJ41o7AjCU2wJVHJqHVHjYC4fF?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b99887-1728-4fa9-d951-08dba8071873
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 20:41:03.4222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKHigulndm6tz/lAaaNc2cTzeOtJCTPSgUZS+OR3TfcxUlrSuf8JLu/vJ0TkwBULOeDmWH4QyvYejeLSrfcCT1le+HDLLNgis5wBzk/P344=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB9550
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>
XR17V35X cards seemingly unable to register serial port. Confirmed on 
Sealevel 7202C, 7204EC, and Exar XR17V352 reference board. 
dmesg states: "Couldn't register serial port 0, irq 24, type 2, error -22"

I first identified the problem when I pulled down 6.6-rc1 and I was able 
to trace it to d962de6ae51f9b76ad736220077cda83084090b1. I understand that this 
commit is noted as being reverted in 1ef2c2df1199, but I was only able to 
resolve the issue by reverting d962de6ae51f myself using this patch.

I suggest reverting using this patch unless someone more knowledgeable 
about what these changes actually do has a better suggestion.

Revert "serial: core: serial core port id to not use port->line"
This reverts commit d962de6ae51f9b76ad736220077cda83084090b1

Link: https://lore.kernel.org/all/20230725054216.45696-3-tony@atomide.com/

Fixes: d962de6ae51f9b76ad736220077cda83084090b1 ("serial: core: Fix serial 
core port id to not use port->line")
Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 3449f8790e46..ab4da98332ab 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -497,7 +497,6 @@ static struct uart_8250_port *serial8250_setup_port(int index)
 
 	up = &serial8250_ports[index];
 	up->port.line = index;
-	up->port.port_id = index;
 
 	serial8250_init_port(up);
 	if (!base_ops)
@@ -1041,7 +1040,6 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 			uart_remove_one_port(&serial8250_reg, &uart->port);
 
 		uart->port.ctrl_id	= up->port.ctrl_id;
-		uart->port.port_id	= up->port.port_id;
 		uart->port.iobase       = up->port.iobase;
 		uart->port.membase      = up->port.membase;
 		uart->port.irq          = up->port.irq;
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 3dfcf20c4eb6..53ae87ae337b 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -169,7 +169,8 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
 	err = serial_base_device_init(port, &port_dev->dev,
 				      &ctrl_dev->dev, &serial_port_type,
 				      serial_base_port_release,
-				      port->ctrl_id, port->port_id);
+				      port->line);
+
 	if (err)
 		goto err_put_device;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a156d2ed8d9e..201813d888df 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -460,7 +460,6 @@ struct uart_port {
 	int			(*iso7816_config)(struct uart_port *,
 						  struct serial_iso7816 *iso7816);
 	unsigned int		ctrl_id;		/* optional serial core controller id */
-	unsigned int		port_id;		/* optional serial core port id */
 	unsigned int		irq;			/* irq number */
 	unsigned long		irqflags;		/* irq flags  */
 	unsigned int		uartclk;		/* base uart clock */
