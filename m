Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4328C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 22:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16C760F25
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 22:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhGWVvd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:51:33 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:51343
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231742AbhGWVvc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 17:51:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfV6Pl1zsHBOlH8ODnuXLkGf2uSYQm04Q0OZeD4+6zh3b2WTAx7Hhd2kT8Sjl1Xf0Oxx4wRlQTbD5Z70rYyxmWl36g0O/tDMVzF4VT0uQB2QjYhiJyEr2DQu2eROkoY/Q9pm96YvKICRmqCXRtCRtPQZHCSWiIldd01IQlvK4aG3MX5i0V6GNyqARW/j3zkgCxOw1k6B7Nzlp6+PYTFKyETk/7LCJziE3VFGxvxdhM3TftD00E6aJqlZXZdjif0rvwR5GffDULDzisLB36JogNxVAk0uMU42UIPqo5xGS9+Llv6U2zFL0Uav2F1ZaTJHBTJgpGu2QTTcF+9nWScfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEHpd2iF9JzEb9VUQM0djmm7q87IWxsXdGHa7aozkRs=;
 b=TJKrw+NAu+GGb5z4dE11d85NbwqpxWbEMXqO8aHPYL5AsMO0cb7cONuwQmUHVJ7WiRewgvvQy9UOEmVxQHkbpnQWr1HGKlxsAirxTF3X2dNYCaCw8Nlwp6mq/Rk87mMg1onFXVIg8z6Fdffj3EMrbp0XZjy0gp1DQTMD1PmiA/6ZLt9XDgr+Yl+oMCxpivAw2E9JW94hDdTX2auFR/qRAIfvRnW9pHu+1c0lN9af2VWCfnTz8mlyF8nJZPdjWxeKgChrm+1A+x52UdmM+SwAsQU8jCP7fkoSypwSebeV9ZDGrGleNCGCqeuq6rVNv57boW9TqSc7Kxn+S4Am6Jcd9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEHpd2iF9JzEb9VUQM0djmm7q87IWxsXdGHa7aozkRs=;
 b=joHHfB7g8xzSKOybGkRK0DWzFvFVJ57WVMkx1PFCb0ttFiWGlK5d9Nl4FBS0rRIWjCduUjOSsaBjuPUVBm49hp8CjzTvdpNg46fS7SqnN70jreFfeRt0sP6Sr4Ndp97u9qRD8PqnppjNiRr9R7TmydQJEE9gIE0N+9TnzLOD2q0=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB7068.eurprd03.prod.outlook.com (2603:10a6:10:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Fri, 23 Jul
 2021 22:32:01 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.025; Fri, 23 Jul 2021
 22:32:01 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org
Subject: [PATCH 0/5] tty: serial: uartlite: Disable changing fixed parameters
Date:   Fri, 23 Jul 2021 18:31:46 -0400
Message-Id: <20210723223152.648326-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::32) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 22:32:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ae941fc-7557-4e7b-5570-08d94e29b098
X-MS-TrafficTypeDiagnostic: DBBPR03MB7068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB7068B7EF32F828E49100CF3496E59@DBBPR03MB7068.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGgyLtvLZo4WoCggVdnXkDnePCignD0FIYqCXIbasqMG5cPvtRLBpSYEKP0kjuhmFm+vhPhMNVamMzCAu33oQpABU4Xjvoi3Jr5Fw+wzvMMOQCLelQjpZiyV2SA2J7LLYsPC/lbTlyFYHQEczncUIwI5ybbQwCYHr6L4LXbYTzR8JALLuJb+Camrpe1hKkvlvISBAX3uUVn+pEY5a1ATRG9I5hz0upVAfog2Pq5kGjVCgmNd1EZTDsDPTJLSyXLlPeoG4byvRaFDRKCgyTfDtadqVPvHJn8uTSggPbba5pFveQI1zZ+ji29WXoWh+0Z0IwbT3HF3JLrlduIVSfmlR0dcjcMADucFOwRgX/R1VqWLo6oiFrs+Y3PELy8PT7H67+FAhqjsLQBKVWRL1LLhh7j/TMNkiC/3iuLLBWKa8kkNaZp00nPjQ6z6qzSt+qrjfVmxTesn9EPgfhy5FWDYA2xye3RChrYtvSq512rp0UromEJWxhySfTERSHg0bAvbxkXiNqQ7sgFHvDjBRAbD9QeBaXVzke/EbTW3oAfy5Dw3UNGG8GqPfuHI1dckr36oodN9fneNp7pye4D0ZEvg1gacV1N9RmkNqFhSm0IjpU/uTPVoPCnp18ChsLcOkzTPZQAcFs0XMfpWSpPJ4C9w6oLWQlzmFWOBM+xmbdKPvge0l0VRJ1fgbFT1YN904urnMq0m3CwPurAL3zIavUxEXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39840400004)(52116002)(478600001)(2906002)(2616005)(6512007)(6666004)(186003)(26005)(1076003)(7416002)(956004)(44832011)(5660300002)(36756003)(38350700002)(38100700002)(316002)(8676002)(110136005)(4326008)(86362001)(6486002)(8936002)(83380400001)(66556008)(66476007)(6506007)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b04QBCnrs+iJhi4HW/qeViwVp1/xs0XKbiXnRATBc7+OmRp4BCMEF21vNhPi?=
 =?us-ascii?Q?zYw8tdI9imMaXaoGu0YajIK9kd5arxFlsnYJ8Jk63nlmaqCt1M90hAcgRqOt?=
 =?us-ascii?Q?0kxyRMXEpuNEJKRgRavx78w8PnU9w7nYkNPaCBIqaApaxXhQZ66CThVAWWbs?=
 =?us-ascii?Q?AFhrNpCxh+M4nCCxXi2oQmUxQm+T5QccgL/pxcLOm5GMClISEauPTht7214c?=
 =?us-ascii?Q?W7kQUw5ntTh/BN08vETWM5agoxchXlHCO3GpsRavsTABrhCjpyseu+YHV9Gh?=
 =?us-ascii?Q?2AltxObikbDMU0c3qDSPmKyvt7snOwf6eTB8y2MqT9orLsR+mRmTdpQbrYdO?=
 =?us-ascii?Q?k4MyF5MuL71qL3KF1+M/FYWzyRKOoJqsj+Cx+c08Tc1aIXhO1SZ6n+03rJLR?=
 =?us-ascii?Q?+s7whv5v95po2+p67esb6XuCxTt/j+c8nCURMljM47WkZsdqGlx8cjNYuPQU?=
 =?us-ascii?Q?+Ub9PhUKWGxdbJvd8gpRbxNCvi2+kO9HtTECFr/Wepz6XCrOJzyftNwaPat9?=
 =?us-ascii?Q?aecqUnD1R0wy93sZQa0M6RoN1JBnbH5xGL2JZqUKG75WKsNBek4a5f7ZH1fB?=
 =?us-ascii?Q?ZhawvjC5xkjSHGNEiUSPqI+gOZOCS8M52EWHH4diKx/FDt2IjyStXK12dwba?=
 =?us-ascii?Q?enPaG4EbG8I+2IenwliD3cxqfLqx7CzRdH3we/+fYlmwCiA0vUss9MPi+uNj?=
 =?us-ascii?Q?kW6JdsIbSTG+QbDfi3GqFeHfP4JiQsCqEnvo0npM0kHg2h3AaaR3tAZThZ7w?=
 =?us-ascii?Q?4PgUajpCj5xRAc7VVyo5NIG9iOkpudPUK7ZXAGu1hIwl9R2UTy9yw/cKH1Uk?=
 =?us-ascii?Q?4VM55qfEB+ter9tSstQ5h3eSaP9QwSAeHAbOl3TWImW1NEbd7wwbqc5IJkmf?=
 =?us-ascii?Q?yAjyrReow5IOoHc1nLPJ6iEcHVIwZ/v5dVCOyPq7jX5RDnAiuE/+YiUIrADX?=
 =?us-ascii?Q?u8GlJWaBEFlp9XhloJtqskPYsWg5VJh3S4SSVhPeh/T2NX9wg01uWjTIdYML?=
 =?us-ascii?Q?h5v8D/rYfb8kUg2L/POJwQQ5CeYmigG0snC4QQXrhVbzCnAK7UlnkjyF6L6X?=
 =?us-ascii?Q?4wP3VoAQZbQgc/lwYB5oVkZ5NnyoASwDp6lt8ihZ9KtTb/kPQBEvpkb8jHYf?=
 =?us-ascii?Q?IFGTpzf47fJS0wx7TKRNqSkpVAcWEQnNR2qtDVNbBRQS8ItFnt1xYqv/SEYF?=
 =?us-ascii?Q?hGi82y3GWBhx4HnVUAAqzpR0YMVdU5wNZe1F/YhmyB5KPriL+QHptJIbDKNo?=
 =?us-ascii?Q?WZ/yxe7/dOkqC+qZa1jSPYYVT/TAw4UAQ3uDl8jcGIfmq07QaaLY+82McVyc?=
 =?us-ascii?Q?otsIS8kWA8nClrs0ab6D/YkW?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae941fc-7557-4e7b-5570-08d94e29b098
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 22:32:01.3774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWz1VbhXxstDJgdsJKyUBXvkyzHUVRg5yHfwh89L3w7C4roLzV+5fGYgPjwa+hIpnZ0G5PEofhpTMkm9E1sXjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7068
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The uartlite device is a "soft" device and certain parameters (such as
data bits, parity, and baud) are configured at synthesis time, and
cannot be discovered at runtime. Fortunately, bindings for this device
typically include some of these parameters (especially baud rate).
Instead of silently letting Linux's termios drift away from what the
hardware is actually doing, make the termios reflect the hardware, and
prevent them from being changed. With this series applied, the user
recieves an error message the first time they try and change these
termios:

    # stty parity
    [    7.221696] uartlite 84000000.serial: only 'n' parity supported
    [    7.222139] uartlite 84000000.serial: only 8 data bits supported
    stty: standard input: cannot perform all requested operations

In addition, the configured baud/parity/bits/etc. are exposed through
the standard termios ioctls, instead of using the default termios for
unconfigured ttys.


Sean Anderson (5):
  dt-bindings: serial: uartlite: Convert to json-schema
  dt-bindings: serial: uartlite: Add properties for synthesis-time
    parameters
  sh: j2: Update uartlite binding with data and parity properties
  tty: serial: uartlite: Initialize termios with fixed synthesis
    parameters
  tty: serial: uartlite: Prevent changing fixed parameters

 .../bindings/serial/xlnx,opb-uartlite.txt     |  23 ----
 .../bindings/serial/xlnx,opb-uartlite.yaml    |  92 ++++++++++++++
 arch/sh/boot/dts/j2_mimas_v2.dts              |   2 +
 drivers/tty/serial/uartlite.c                 | 118 ++++++++++++++++--
 4 files changed, 203 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt
 create mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml

-- 
2.25.1

