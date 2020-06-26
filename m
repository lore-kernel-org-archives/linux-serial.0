Return-Path: <SRS0=sLvH=AH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C478CC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 26 Jun 2020 11:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1ED20791
	for <linux-serial@archiver.kernel.org>; Fri, 26 Jun 2020 11:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N4DXkoXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgFZL0Q (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:26:16 -0400
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:51685
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728381AbgFZL0P (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Jun 2020 07:26:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKwCxU/1woeI+MCy3hQ36El6ByV6bWEdO+HHwo3D7S7t6i7JYygH9OrOuXo0dIgSTggdUtjCrQmYg6Qz4eYSdsBJ0uj2lVoFsG/DIilP7c1HojIXSELeA4A+zSCEA0gDKy9ugS+M54i0+XoL+1yOmk5/tDWJSXXvOyUiP6QeYyAZLCuZ1CmnqP1zIYp+FDPbo9vfcKlma2aq8S8z1U2/wWLITEK32RFINkSiX8jptGlW6yCXFwE88Crg6JNDHXoAyj6IAsV7jHo4Y8Q+6yFJLoKhmpCOjqAa6kLdcKY3DPeogMB6zb+AAthppJ2ZOsliFFpWkLW1BVLjQMxTv+rqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0F7mIbZslTotpvzQxELAO/e4JCXtaEtUXdUu+vYoyg=;
 b=OWcwUrfDk848yBl4fBUNGWb0cyD6ICmuSsCiBj01CsdrR6gooNeWjsEirrzMlmXjiJjX3NRymmrG0OkcMfk0QVFwVpb43fXMY3Ud+QFLsLkbta+V/B3YUmMTYz7vPRGHFPl2jRVh+HCgpAb1soOe5m0BHjSPxejyvV2NJA4ZjbIIM8VVb3ftJpPp1AfWT+axgx78LRnCQe/PVqbcNoNNxVyGZ5XQy6gw0vRWf4KKbyOMUGcP9nua2x7ECIJkbXRGVf434C7shGlBpb2LbelUrYesHtV1P8TWPVb2n3bNUn23pXgxvVL+zOLlgd0bOvYfC4EU4TNY64V9S3+vCGvd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0F7mIbZslTotpvzQxELAO/e4JCXtaEtUXdUu+vYoyg=;
 b=N4DXkoXkJ4Y5G7uh6zzkNc4SMLyOTtOoOh6ko48ENUIAgOQ5rdSIuS2x1h2hBMc3S30sxIiQviv3V+/UPg1y8fHJUlFmL9SM+3UHdr/+yAbfAUtkVwSHKRe5R4Xr/D7k1sBkimcqB5KghK695DgP1H4KTWqVWCAHXeUEmMBncPo=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:5a::12)
 by VI1PR0402MB3919.eurprd04.prod.outlook.com (2603:10a6:803:22::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 11:26:10 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::1c58:aed8:bd10:6c9e]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::1c58:aed8:bd10:6c9e%3]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 11:26:10 +0000
From:   Vabhav Sharma <vabhav.sharma@oss.nxp.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     v.sethi@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v2] tty: serial: fsl_lpuart: minimum baud rate support
Date:   Fri, 26 Jun 2020 16:50:34 +0530
Message-Id: <1593170434-13524-1-git-send-email-vabhav.sharma@oss.nxp.com>
X-Mailer: git-send-email 1.9.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:5a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from uefi-OptiPlex-790.ap.freescale.net (92.120.0.71) by SG2PR06CA0220.apcprd06.prod.outlook.com (2603:1096:4:68::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.23 via Frontend Transport; Fri, 26 Jun 2020 11:26:08 +0000
X-Mailer: git-send-email 1.9.1
X-Originating-IP: [92.120.0.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2ea0ad5-963e-4dcf-11b9-08d819c3ba16
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3919:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3919E3C333B9DD62A0837F22B2930@VI1PR0402MB3919.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 64cyEayee3Fnnykd/Ammn6H0f27sKLusTewBtnjDgVoZVEkuT5jeoL0TYkdm1cx+CUJYoCgQkgRe/GvYlesI2xeSgI9Ir4oJYoK4AvygaLIRzfGkZWljpT+wrZKx0LVzkC++R7gPI6W+TUXoFysULJi4WnhoF/4qrveKY9AbcVfKMUnE0O+bEBHeszlvXe4VDnygkwqhRtAqgynUfNNr5JlURQjak6XuU1zycHPRJy/5mdi6ijgzz8PCPYVCMi0x1mSYDynGOnU8hd6ZbElss/+DIiCh1xRWkwxH4MaM7fvrNW4u1bqkpO7IAQGS0WZc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(4744005)(83380400001)(316002)(5660300002)(66476007)(16526019)(186003)(86362001)(26005)(66946007)(6512007)(66556008)(2906002)(8676002)(6486002)(478600001)(6506007)(8936002)(52116002)(956004)(44832011)(2616005)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: upLKRB/a3Sl9t1Ue/M+ml/K2q7RuGXRx1mxbDP4t6G4ldVmZBbTH+2eU5asaU5qml+Hg07JzSBvD1CNSyU3+Pqa4OpshW4y/f1B3zJqCENNAkpB0ez2hSd1NseYwgd7XHU8mNFN7lZPMRw9+uD86Ei73Hp8DQo0a6+RKxILfS1lOvIaA0e43PLTaB5o7HHQ1ZDldgMHAQ2VBNJIuN14cT7Od1JGQ9V9VRpHO0xqBevsm+hj7tGi9646uZvNwIXTDqhRKhhlv2jmyldu8h5+gNnnYnccy5tFeiSG6wQKEADoDb+lOEQYibSm+dAsxksUPIgX9TLaOS2eJqU1LrweTJ2Cps5yhJ9+GQ4RhiIswfYxiHsNVDXc5ZnJR5yqdqCLJmZTrsKRTNHyH5Tbo7TUhTEjtrzTBVBVyb3OlfaGSQU3wZte0N+JfIspdM0Rhxixp4EQUOSIbWvrITqetg+QqkrcuKFiMV2KdcCzJ68R2qHA=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ea0ad5-963e-4dcf-11b9-08d819c3ba16
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4800.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 11:26:10.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66xXmHhZUAI/lvf0KmzDSolS0ajbhDcBPkvpfyLT3lzJ8NCf1EEt3UQRIWWPykrqeVwDuTk2WyEiECj2uXUn8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3919
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Vabhav Sharma <vabhav.sharma@nxp.com>

The formula for the baud rate is
baud rate = "baud clock / ((OSR+1) × SBR)

Algorithm used in function lpuart32_serial_setbrg() only changes
the SBR. Even with maxmum value put in, OSR stays at 0x7 and the
lowest baud rate would be ~ 2600 bps

Update the algorithm to allow driver operation at 1200,2400 or 600 bps

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
V2:
 - Incorporated review comment from Greg
---
 drivers/tty/serial/fsl_lpuart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 90298c4..7ca6422 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1925,6 +1925,9 @@ static void __lpuart32_serial_setbrg(struct uart_port *port,
 			tmp_sbr++;
 		}
 
+		if (tmp_sbr > UARTBAUD_SBR_MASK)
+			continue;
+
 		if (tmp_diff <= baud_diff) {
 			baud_diff = tmp_diff;
 			osr = tmp_osr;
-- 
2.7.4

