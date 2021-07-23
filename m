Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96823C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 22:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F79060F23
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 22:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhGWVvn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:51:43 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:51343
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232301AbhGWVvi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 17:51:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ3iMW16dz+kshCjPo/AT+yVc0OY2wpWQLa9CIa/bHKnw+A9D/WchauiK+w5sWB3uJMbfSjOkV+4wuZMz0Ub2MNMB2Pjnpy5XJsd2SITvJR1A5NHldYVxo67F9XTzu2kh7ITpsV1rjzJ2iZPo4QQcV9UsNv3xRI4mpxsfaQvPpuVPbuA7fQFP8swceLl0r8pPbpk5VohpeV6tSIbDXNNv8vUo6j9KDXg8UPhWy6vxIgpMJlm7EV3S9W+sMHfnG/fhhU27I8EAWNS5io1TTLRfhLyElzF9+kV3+ksa7Y4rpnOER5mIACZgVpB7VzQsk/3JlgntTPe+4Tup42TqFmloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euxq4rPLYIPF+HBCvF7BS4X/iys40/GCtqU5gx3Khsc=;
 b=m14wBhKw3zQLb1JwodI4ZLyXtkTxB2BLDObM1/6IaTT1s4hLKor88Q5Dk8ZYPA2yiap0U99+tnDvDfAa7lk5ujDSA62GYlTYMHLu+8HC9DH9CoNyyBBnJNHMb/bDtEskQCba6RT4iPyqS6onLySuxOBAunFuaSpI/25xcqd4R0eqYb4EwIaoGEn8NwuGLg9Lm44/1ZPDpiFi6kXIjY+QC+ZuEYOvnUYAvHxKvWpcBNX4b9d1RQxUX/ItOOuawt6dyoXhR2j2vqP0BgD/qDuWYFo4K4bgAAulU6QEPO9oQ41AMyGrZUvu4xiI6zmopgJMsSS22FlB4SIvJ0uCDvUrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euxq4rPLYIPF+HBCvF7BS4X/iys40/GCtqU5gx3Khsc=;
 b=s9Whd//yxMRAwg0kexJPxj6CqzfgCSkz/OpoPtTMNLAvLwH1CnZk3KiPqrQuZVpwlKYXP8FresKVyDpHkGtu2J69G7w2Pq6igTbtYyua1+nX3n5pZMcJ0z43PyjsVWdf4K5l1iUA4KeabR0PK0R8C7blBPPdw4gIUlOoCw92X0U=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB7068.eurprd03.prod.outlook.com (2603:10a6:10:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Fri, 23 Jul
 2021 22:32:06 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.025; Fri, 23 Jul 2021
 22:32:05 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 3/5] sh: j2: Update uartlite binding with data and parity properties
Date:   Fri, 23 Jul 2021 18:31:49 -0400
Message-Id: <20210723223152.648326-4-sean.anderson@seco.com>
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
Received: from plantagenet.inhand.com (50.195.82.171) by BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 22:32:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8671c76f-af08-40aa-0c98-08d94e29b335
X-MS-TrafficTypeDiagnostic: DBBPR03MB7068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB706821837ABFC83F71B5B5F896E59@DBBPR03MB7068.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrZ782XWdtxDK20z5b9J+SmTFYygfyJAIpfICOQkBdH/2ReeiTeFeynvZHk12Cz3gfryODxoXDWqJbx/iufhwUtijNISF2yxhwHNv5ikctfH4yLnHlcTCy5I2/ZT/DmS3RlpnZTPrcwChxESNDLvp0ZmXo3gkZ5pDIK2LJxZRdeV/Ak9bJwLGagLOFd4xXar4BVxqdCcW5N40BURFsusS7juP6nGCy1BZ4vIU98vPud+yhpC1MBpMWatpQ9IrwtF+M0Y6wMsUZ4cpbORTL/+sIa5QWviftTnCWoOmBC9BG7i1hNzeR+jOBs37mDs7wH+BBdm6L1E9WAlB5JuvPaRytbKqHz5eHV39bFXowvht8ENtxSec1VLkCB9OjWwKNnaWCL/JPkqhV/5NUmW/h/G6TUVP6vRrdk9nFDKZSjspybgIbXLNhHBJq8juBGUwP58Gkobjg+gPVljDuS0KOONUgRQJ9xL4DZg8yA7AG6Kuz5vr5S3sgHhwzdUwm65djvZP9wR9OBazDOgv0hm1RfSUofXD8laTVflwiOtBAOjW6v6AMTuq06lE/gZgWFobRFY/KmiEnV7k2YRW8YuIPLEj6iWgtJ7wt4YDT6AOkt2uaQ8bfLWStjz5e+aE7mrUlx1FzGKiQi01iN2pJnGq/3K1WfPx92PYdhxRVJi+vRAlj6R6xEVst1SArUtyJkmQ+Xg7/AzhDfTD09zCe+ECTa95g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39840400004)(52116002)(478600001)(2906002)(2616005)(6512007)(6666004)(4744005)(186003)(26005)(1076003)(956004)(44832011)(5660300002)(36756003)(38350700002)(38100700002)(316002)(8676002)(110136005)(4326008)(86362001)(6486002)(8936002)(83380400001)(66556008)(66476007)(6506007)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NiCzpRQnvnedeGVj1BsGgMHy3h1KrY7zvajxw/PrtYJNy2Ltjyh0w/JGNzPE?=
 =?us-ascii?Q?9+VrHw0IayVJQq9UwWy3kj2Cj3kg9i/H2Wc4p3PAisY5BqRMYIokLcsGeQR8?=
 =?us-ascii?Q?ff6/H9vySV8A8Ut1bQRJm8jTiF2IzPYv8avph9ypBP6aywn0I5WUEvQ5j3lE?=
 =?us-ascii?Q?cUk3xata9RVyStLiW/dai+N7atmrS9wN66k1ADmbKk7zky1decY7q6wrCU1O?=
 =?us-ascii?Q?KWkSh+dw3VosCze2pY7mOOHOrtkxVt0Gl3JPdmhZ1dEXwir2j+OJZ9++6eWD?=
 =?us-ascii?Q?eeSGx6gh+/d6qmZvOO6wBa/c4OG4OUZSq04uFegX+vcDb8+p8I2dKtGf97ZO?=
 =?us-ascii?Q?t04WpOZ6Xzhz7N+y4p4Hg+AbrlnP0Pepv5XmoBWLiFuNz3j6BthpVERFHz09?=
 =?us-ascii?Q?UxiGhoutHJknRtjZHtgQoB9vTKnSFZuW0x29jcA9Xkg2naeo4iZQyXlHr7EI?=
 =?us-ascii?Q?Ly8GEMtwdxc3Ro4KJgoXbzNmQF7oriaqVPtr5KbBAE7c2HuTW5iRUd+AJbaK?=
 =?us-ascii?Q?A17ERacInyCdU5WK+xCwpDP0PGH/tovHDBnF5RU4YtUGzt60AOw4v1Bw9mve?=
 =?us-ascii?Q?QX8B1mzKPdltWPfpKIikJqu7vlQH7FbB3GgDTBP6+fhwUTkmZQkJB8PI97af?=
 =?us-ascii?Q?gkAd5gEsy57lH1ndkP8mwAqbTTzEo7e2g+ubZFXQhzQeM8ko1zdb3FZmznbQ?=
 =?us-ascii?Q?vyVTfMUXOyAm+pDUTWo8QlEqPcz1aN2UQe3G9aewj0PWt6fDE+gACt60MSpN?=
 =?us-ascii?Q?y9j+pvYPpMmAGE+pyUXOjkEfgRAosOBVouEQPv6f7hwHfYFzAhPIPHIIXh/g?=
 =?us-ascii?Q?vB2NuMYBVQYYGFSOXlTlgSfFeNm02SJGpvUUQ814IdAV0R9sHRfOvsISNKE5?=
 =?us-ascii?Q?ddo47On6ZU7nYOIqyLCU7F7KuGlgok0SKdmiVqJmXpyaX/IBk9OaAQdj40gB?=
 =?us-ascii?Q?9RH42sYTYRFuuz3W/oeNtJsN/v/6IzFb7bMuyL/wMD1nRqJI7vkX7jTOdviH?=
 =?us-ascii?Q?itVGfDL2IHmvImFT3HTHxcco7TCras5KykzI3Y0IqaSZQoXdMzpVRElVziDP?=
 =?us-ascii?Q?fI2sMl8KP+JorVFTAuLrVZxMe3lM+Nw7r67H8BPS7rqm342Us1Bg0DbhNjX0?=
 =?us-ascii?Q?+rF6ZBbfTCO6k5iOyZfH2Dzfref0LqzeOCOH+9Lgoif3kAuLOLpJ3y+YCrRf?=
 =?us-ascii?Q?R9z3cFHRYGkZitb09/edUtJZY0sZw8xwEUuyj56pGKwlq1Q5uKU3/ctdyoR8?=
 =?us-ascii?Q?Xdh0S4+jumdsLusLUDa87I81ObFCxqvfbGcn9dDYCg+LPcdHeWs6JChAA6P+?=
 =?us-ascii?Q?KSZBQOsmmB9CrsrM7+NKUXPk?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8671c76f-af08-40aa-0c98-08d94e29b335
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 22:32:05.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nZgL7cITV1yi3M1udTyMeZHGRlGDz9NVXNedk1kTV8xlKATWq3CJsWMNbcm5JAgLTN9Cf7MrM++S7DjEd/zuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7068
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These properties are necessary for properly calculating the uart
timeout. I inspected the J2 source code, and believe these values to be
correct.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 arch/sh/boot/dts/j2_mimas_v2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/boot/dts/j2_mimas_v2.dts b/arch/sh/boot/dts/j2_mimas_v2.dts
index 9f4742fab329..fa9562f78d53 100644
--- a/arch/sh/boot/dts/j2_mimas_v2.dts
+++ b/arch/sh/boot/dts/j2_mimas_v2.dts
@@ -88,6 +88,8 @@ uart0: serial@100 {
 			clock-frequency = <125000000>;
 			compatible = "xlnx,xps-uartlite-1.00.a";
 			current-speed = <19200>;
+			xlnx,use-parity = <0>;
+			xlnx,data-bits = <8>;
 			device_type = "serial";
 			interrupts = <0x12>;
 			port-number = <0>;
-- 
2.25.1

