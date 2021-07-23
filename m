Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC6DC432BE
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 22:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3688560ED7
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 22:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhGWVvh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:51:37 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:51343
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232848AbhGWVvg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 17:51:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrlWRfbGrhyYFAPO5j4OhA7crZfE9hNYI/c1owkGbpj+5lOwezZ97WbcmMoO49AP8tfGfSIaD5gRCEKOJFL3rDoA3nHsrRBbUWqQMBIuLvOC/FHOVpGbRdRVMz+Cf7feR3MguEpx2vvXhF7Pc/Zgca6VFsRJvSHMV+8xcvMyN4pQu4a5kKkOM+dYiMKlbHszF35bJTsyWuN0On54aUMD8TYrUKqCkJ0Cd/hG8ufv7VJ756Pu51N+FSa4CVcBa5HGeiJ6/REkXk2neiwNhl7sBBeUa1XzF6qantL8C4RMT4ttwuhwK9CrYc08gqMVea0+1XvdG333xrpif1p/gD3lyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kn4Oetd7MVi77TxHQzbs3926LvqsikxwXRIREgwnJ80=;
 b=LQECZN2eeRU0WIgjikU4hE9mxRQTrZr2Ejrat2CX4CYV2iZ5a464tKPAQkCodFpLjGeHcmx5aFYagT38sN2nAW2Nb9/tKYCxetW7qq1L9ljwLSPR1rynWqPSffIwsBUBO/cjVtpzMJ5qZJpzIt9QpJYfQPem/xvoCxJEkvoFTOYQ1VZ0D5QUkf+nyahxcQSB2slP+NgnQh8BlJwExV8xJSK3gOf7HNvyqqECsazXqGVZ1PnXcXFa+vZQ4a0bGKv6EQJ6dQTXyIryDLxvd7ZRVLC/ZQ17FuU+hoX1P8w4bLPYBCdcQNrw2rZvahrxSDl7j0L98CXIGXEWJOKn+ZVpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kn4Oetd7MVi77TxHQzbs3926LvqsikxwXRIREgwnJ80=;
 b=tZPhcGgyv6L5M348zTz+mSosqoXPUeLJ8UsZpNVnRaDV1n6W5msyW4zACZ44j5IdVq36ZNWT6HUUEE6vGASr3JxmeRyBhm/mqgL3WEMd/5d627huSQabQghPXvEml6fBKIdUV6pOQGPQcOt86UGFDV6iFGOkRfuB7Sx+fjOTOKU=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB7068.eurprd03.prod.outlook.com (2603:10a6:10:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Fri, 23 Jul
 2021 22:32:04 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.025; Fri, 23 Jul 2021
 22:32:04 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: serial: uartlite: Add properties for synthesis-time parameters
Date:   Fri, 23 Jul 2021 18:31:48 -0400
Message-Id: <20210723223152.648326-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723223152.648326-1-sean.anderson@seco.com>
References: <20210723223152.648326-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::32) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 22:32:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e1fd1a1-1e23-44d3-d699-08d94e29b258
X-MS-TrafficTypeDiagnostic: DBBPR03MB7068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB7068B6D3D1DEBEB248466FF596E59@DBBPR03MB7068.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULuoTR0nbtenVH9K+8UIAfnn2CAJCp41ySoregR4Zow+nsFnp/QtW2/IUDKxs5tITy1FjOjaMcaNyHVoZu/ZlabBV/5MTO/47HlzAgRZOpBvY//HHNbalrPu3iX+M9tKh1DXx6Anpl0TdiUx4P+bL6qTWIc+nLC+STV/wBS6+6aXQIR9F2ruVK1k62OB6gGTs8GCoTPSAke969F4ns/u2Aq15TH7UijN3wNIBsjZhGpn9QQ9N7YiQE0q9e9K7WXzKK3ZQavHOG29FvQMg133d28l5A4NP3FPhkxo70vD7rqwdqEFRi2xT8tEK5ZJxAS9hwkdmkAYvzDQcpSk3wVRdtK2at/Avcumdc/1bfpoC9yhv19Q4Op3ayWJrdF1pLSAJG+0xQzYyXe3kNfo5hnOx4eBMR3O+Aq3ourSpZWYSf3wAbFn3WDWnMFvtuOSvaUraNA9St0/0guEg61uVC+bkQon6pSA5swSINq9d2SifW2cqYaHHyyOrnFuUYk/+kxGa+F2Tq/OQaAgIzcxTUiiYy7rRPgySpn/m8TCODOMbMn7YTefG6DXO1JPNMe3NTgAG2Fw/uZ0W7CpBfI4V60X7uSaJMDaBM99bW7sRRS7YRW4mb0bAIfaoQtEzTJ2dbFJXS8dNINg9UNPIIOiscd524vK5700RfAcyBG724gKrQQLe/X1dFDDRi1v4i06UZWnjJxVb2B1FLSR03kBD5iW8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39840400004)(52116002)(478600001)(2906002)(2616005)(6512007)(6666004)(186003)(26005)(1076003)(956004)(44832011)(5660300002)(36756003)(38350700002)(38100700002)(316002)(8676002)(110136005)(4326008)(86362001)(6486002)(8936002)(83380400001)(66556008)(66476007)(6506007)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6De966cIAuiehdBHdfSFuMtnInJwgS0Sf4/3kHBCZ2Q5lu5QMzbz9i7tupf?=
 =?us-ascii?Q?JvXF02lecJu8DUCikvLWwGRzcylbsHJzMbcYu6Hv7uf5wRD1ZJmhauRTPfC0?=
 =?us-ascii?Q?cNeTQcRGjtNNax0X+fnMywJG6j0Nxm9n+FgWPo0THJhaJ8iP7yvCBkrr9jj0?=
 =?us-ascii?Q?3mswwJ74Bo1TSKKxJriqzWSiQ0C4SjAMsqjEsr+MUcFDAgdZZbRTGcjc2BIU?=
 =?us-ascii?Q?cSLSoIs6AHA+TRkNvy/k/ox15Yq0ufJHOazO6/ArtZKsOhJs3dhoooh+Ayn0?=
 =?us-ascii?Q?E/+RY9IJlDk5Fa6gMyyGlajZWRCH1zt1CP1r0Lu6etdUonjXRiaXAswHvpxu?=
 =?us-ascii?Q?SXFNrYdLxJVG8HZj0N6yjrXTeIclXwrtaMIXnSab2hS6SmGqSvfzGkPnSE6k?=
 =?us-ascii?Q?IxPmn/Q5j7uysnYP76SWSBccUKHAF+o2ytMq4koM1zP4n6iFsNgion4xD/c8?=
 =?us-ascii?Q?hk/5L/6AWoE5C319fwNxmZ1x8wSeAjvwwiees5mfIiMhJNEtDC0nV4T7y8oa?=
 =?us-ascii?Q?HBa9LU91kKD7L7T3kjXLK/nhuha+QUkQSxsnm8ni7eFi4Sp0M2Jd/82N6a0b?=
 =?us-ascii?Q?w0Q2TyCtbYse3BWRZ7VFm9771liPAIyF8uvueKXRtsYM1hX3zbI2CUd+lPpk?=
 =?us-ascii?Q?Hh5HbEAWfAY7cN3UZn9Gq/TzTvxg0x5zBBOQZsUvxiHHdAoX7dz7UFK01xwC?=
 =?us-ascii?Q?Yy0xn1vJkKa2H14XBA6sk7vcCiraILngTkCY872c8kNkmccJbL1t+ATtQHnU?=
 =?us-ascii?Q?vge5Gu20N7YdqL2xS+Y31o1J/zqkNi5bESh+H6oLTiLjQLfQPOK2iyS8VzFi?=
 =?us-ascii?Q?F9lxBYaRNRGZpKksqASxLelWlZKjcg9uLwVA0Bu5G3aqr6zCBnFAaYOwmqO9?=
 =?us-ascii?Q?3HaS6k8jpt3RvnCp8DSxtZ7YMSiQDsS2s+BXbeqalTm3J4pABvZnB5ULiAPF?=
 =?us-ascii?Q?FeoGMX4gn5s2pCpfkDOu+HjuXjvEKY7mLUEjd+puxON85dIVvcEtQmBW/792?=
 =?us-ascii?Q?c+FQx+dqmKODPUqZz8Bgo/Q/5fBEImnre+yBu55XmKgLzWRRADd3plRT8IeG?=
 =?us-ascii?Q?0Lri2pLmJ0A23jVvFijnx8okuGpJxn9g/NLoO/D0Rf0urkBqLWWFlPT9dxPo?=
 =?us-ascii?Q?o2uUe2m9p3MhKUIv3s5cNucirRG6QwS9gcjftep/Uqo24i2lQetnkQfh1Tmw?=
 =?us-ascii?Q?emd1Ce4EDXbCQmY87Q42AFd3LST/wmBNBuu7BleB1HO7xwk4Y6194ntU/1aL?=
 =?us-ascii?Q?1l072gLzfcaEfk28yOE9qFEFJ5IAkcbfgx4mneI3fKfABSyYDjKyaluc7CRl?=
 =?us-ascii?Q?qFuP9A5o1DjbZh5FnXTw/g3Y?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1fd1a1-1e23-44d3-d699-08d94e29b258
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 22:32:04.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzY3SL0nNHEAw601kbEIhD6aGmXnikv9YuaPJ0+bEHpoOHCGPycZzH9mleOIeK6k01eORWB5xLesFuumWUIvqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7068
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The uartlite device is a "soft" device. Many parameters, such as baud
rate, data bits, and the presence of a parity bit are configured before
synthesis and may not be changed (or discovered) at runtime. However, we
must know what these settings are in order to properly calculate the
uart timeout (and to inform the user about the actual baud of the uart).

These properties are present for out-of-tree bindings generated by
Xilinx's tools. However, they are also (mostly) present in in-tree
bindings. I chose current-speed over xlnx,baudrate primarily because it
seemed to be used by more existing bindings.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 .../bindings/serial/xlnx,opb-uartlite.yaml    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
index 4ef29784ae97..28859e70e60f 100644
--- a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
+++ b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
@@ -32,13 +32,49 @@ properties:
   clock-names:
     const: s_axi_aclk
 
+  current-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The fixed baud rate that the device was configured for.
+
+  xlnx,data-bits:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [5, 6, 7, 8]
+    default: 8
+    description:
+      The fixed number of data bits that the device was configured for.
+
+  xlnx,use-parity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 0
+    description:
+      Whether parity checking was enabled when the device was configured.
+
+  xlnx,odd-parity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      Whether odd parity was configured.
+
 required:
   - compatible
   - reg
   - interrupts
+  - current-speed
+  - xlnx,data-bits
+  - xlnx,use-parity
 
 allOf:
   - $ref: /schemas/serial.yaml#
+  - if:
+      properties:
+        xlnx,use-parity:
+          contains:
+            const: 1
+    then:
+      required:
+        - xlnx,odd-parity
 
 additionalProperties: true
 
@@ -49,5 +85,8 @@ examples:
         reg = <0x800c0000 0x10000>;
         interrupts = <0x0 0x6e 0x1>;
         port-number = <0>;
+        current-speed = <115200>;
+        xlnx,data-bits = <8>;
+        xlnx,use-parity = <0>;
       };
 ...
-- 
2.25.1

