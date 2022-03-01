Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD7EC433F5
	for <linux-serial@archiver.kernel.org>; Tue,  1 Mar 2022 06:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiCAGEe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Mar 2022 01:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiCAGEd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 01:04:33 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 230ED60CFB
        for <linux-serial@vger.kernel.org>; Mon, 28 Feb 2022 22:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1646114630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WmHnGKDpfxRG075uPnPWe79FKEmBo7YEr+pB7l1Bteo=;
        b=ij04ex8vU9q6Uo9lUyvicty2teGn/fUB+/Y8jlI4+fLq/09TGGuG7dHgBBNWXsra5xHY7b
        e0wQPA7T7rRH3q0mqELrA/18ckd3ikOUiV/yfwrmma5/+Af+rIO1XZqyNP+zLyTX1gkmm+
        R4WaJ3Q/6tUTrBCJAOjtM4tMLTHy4lM=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2058.outbound.protection.outlook.com [104.47.20.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-59-XHf24MvpM_S2DD1zqP1I6w-1; Tue, 01 Mar 2022 06:03:49 +0000
X-MC-Unique: XHf24MvpM_S2DD1zqP1I6w-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB2948.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 1 Mar
 2022 06:03:48 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 06:03:48 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-serial@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Daniel Mack <daniel@zonque.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Subject: [PATCH RESEND 0/3] sc16is7xx: Hardware flow control fixes
Date:   Tue,  1 Mar 2022 07:03:29 +0100
Message-ID: <20220301060332.2561851-1-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: LO4P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::11) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b91c494f-c47c-4329-e0ce-08d9fb494075
X-MS-TrafficTypeDiagnostic: CWLP123MB2948:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB29485B4FB08F0C3B12E7112192029@CWLP123MB2948.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: DLAzD+8nc8gjtDGCbhDu1ZeKWPqUgD7lzssm6SaWneTpq3BSqtuzf0w4lshRPtASpQ+xjmzQq/OMYXaIVYgTU0ErT4lxLFK9ogddSC01IEt9eHifZ1Kaoc1sg4C3+ekkVN3htgJ6wIWqSL4jfC/wyGYeQILpzLoSjQVuMkRUUnMZn6lhS36steWHGZ2VH2EmpRrkwwng968K0RpP3DdJjRwbOKjZoXSnwKMsJNIJ4ZNZjNjmS2DNif4R3sMrmDagClKBypQ0stPkuM6Hi70Apu8n1s25g3+OwM057r2XocF9dzbbRCd60SNomFe7gVg0KsGcXt6XZU6caG9cJ8QDLPFEJ5SaBgmx1oxfR73O9e1YK1gOVvfYoOK1vZ1q6/SpQPe3apocA8CIrEJCHkpq6qfqi03ilccpzQyjGa8QxvqZRmzBBs5R3kTNWfNBIH1CvOrruQc0Swfec3AatJCo889YSAn8Eazkx/f2t5Bw0OetQxaLYJ5Mdc3p2YnWuwUdKcdHwQueNPExdGpgZLtO+NTqDRK0IXZKJzowe6IojJ1k361npvQITH2/fMH4s4cL9pwp8UtgY/YO44sMSM8kEyTAtkDTN6yYFnqxLsrIYOfOMgKaq6+qy4w+IHnvr9ylN8VDLhzaHb8tDVvTkFWPit8Dgb2YW6skNi2nsP6UuQh/THlEf4oKDQrmKsD4otWpctsTbNJRXLrFU6nZSiNt7uXNy7oMTctZQCKmt1PETiAQBU7MybYPGe9HNa6/vKTwlvNMx1b/8FVs5odbQurhek5yLXyKZD7j2Cu88pFP9C8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(966005)(2906002)(1076003)(86362001)(26005)(186003)(52116002)(2616005)(6506007)(83380400001)(8936002)(6666004)(8676002)(4326008)(6512007)(66556008)(66946007)(5660300002)(66476007)(6916009)(316002)(54906003)(508600001)(6486002)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2u6FWzd0GRsTewuGUpqgwnpT0qpSsnLqkgVcDRl31vxUQyh7699QrtxIvHTR?=
 =?us-ascii?Q?ZsiMMEdb6Vwcl0oVvymVjG/K+m/21cyW1iNGQhQpEVa696l3gsrAUCeFyyJh?=
 =?us-ascii?Q?Avi6o0zNeBG7hAlahlaf8O5k+ds2GAbYIz514l+HCZCU8Z+ASb8jgswqMm6e?=
 =?us-ascii?Q?oZ4FoHZ0rtsvt3fAgCq8zXrd7HmSWzizql4prx0GcGGtsZdkhp9WZxKZhUUs?=
 =?us-ascii?Q?pr2kc5xRk6IgF/4/gA/wJ9sIgrPnSubXHXsTs6FRjQWCnRCCB71tCikyIyyZ?=
 =?us-ascii?Q?6FSl0yrpBnqO8k+yQ/PaUDQ5QaGfh6YS/6ea6JmUlz1pEF/gk/sOPmdNhZQ3?=
 =?us-ascii?Q?+2I3SJtlasQZfQn2FnlgB2UODwHA4om+DBuKzNKq6INk75bY+/J2G8qtJ/Wv?=
 =?us-ascii?Q?xhDFXUMpcazsGLBj6iKM7b0lX13xZH9V+ChN3KPdkiRIcRRZr+ZrJ8SiBFQc?=
 =?us-ascii?Q?OEC8Kw1a/QCwbhoCcWh+iO6XRTapFyYZZyPRNCnQ73stctXrpMniYz2aShCE?=
 =?us-ascii?Q?ua5/jJX8lzQmRJKQkVz0JPSAuh8iQOofBUqbW7Yvp97W3m3ol6H0y6jZgTGk?=
 =?us-ascii?Q?eeh0zJdrZ545cRQltAK9+4REFdwRhBYSPAFK5zCzNeCUJIQGv4l3HNqgZw+2?=
 =?us-ascii?Q?yKkskMr5GUI1xUbp0P0qOK/kMdhTBq/S75R55N9e06oEp1lbHeuruMsEjw+t?=
 =?us-ascii?Q?Lg7RONQzgMBI/WQDGH7Q7E08ZadShodERcs3By4zPc9rXfK3LWeGQaY2yk/V?=
 =?us-ascii?Q?RDc3VFDeF3edPan+aze6Njdvapx6N/wUgZIAnjjpn+SJQndk18LEBdovREMS?=
 =?us-ascii?Q?ygXpR5l/jDSojI1Gpt/0SjwiatPXqCb8NQ19qXjRQ0KALPzUqSminMLaF2Kw?=
 =?us-ascii?Q?0c0A7jiPRgMCfZO7rCpNIXBxZ2qzweZ085V5tMTJvqruFQpEcw8OSrGYxoo6?=
 =?us-ascii?Q?gnD0cr3rYQ1/VHx20cKyI0xf6Nw3PsO06U87VH1CsN8FgRaDlbQgTvhMhkxC?=
 =?us-ascii?Q?yLuhQQ+YaXgpUJUL4YORryzeduEguZW53mJqwBIDJfDMRSkvSqGJ+sQ3E/uV?=
 =?us-ascii?Q?INqgUTaYe12bmxTx+3DZcSkVs2EY27D6aRIFtBdxKHkIbU4hTBNpu1jLQg0K?=
 =?us-ascii?Q?lt5IiEaMTweDOKbRxwMwwjIwDcj1wt0PEOh9n757105RlIA4GdIN1Vawd80x?=
 =?us-ascii?Q?XJen20oL9Ux1l/IeG34QXK8qo3vjT0EgGPmH5scPiwxMov8bjNnb8aj1rDmT?=
 =?us-ascii?Q?g7nabD5viJzrXWrkaeVACPu3sHXy4OjbG2sPH/dtpxr0G0mg7aWdQjCCFR8Q?=
 =?us-ascii?Q?QbGISnbuA1WT+NQTmyWZYfwM3ULpk2KzmcHCSC+Wj4SGARnjZodsNe9PqD8U?=
 =?us-ascii?Q?tffTpvtaaRpiSXoCgCc2NoVht/6FCKnLxad29Q4xipTilfgb2AcauTQbiXZL?=
 =?us-ascii?Q?rlM0nS0wVSL/1efbGO8gLc/i1cbhPPcXTIstxS6VlVz8/17MP0ifEhpPFgeP?=
 =?us-ascii?Q?dW1V/06ezAndbaGSQyvktEw3jONTFZrqkqD9JXqKJafyGk/1mbmCt9VAUqtn?=
 =?us-ascii?Q?CcHMsHvcTcCdhVrXM5RWtjsKf5/XyvdNygqbHwKH70KnU9MELD4UQhcUTgRc?=
 =?us-ascii?Q?SkdKW9qrFHRsss4jzEsLCJiyi/W3bCQdURkLZeohGbXw0A9UJ7l7FxF9p8HI?=
 =?us-ascii?Q?Nlkhwg=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91c494f-c47c-4329-e0ce-08d9fb494075
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 06:03:48.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXafOVg43HkK1VqO9FnY1tLA0VOGQnRrzz6hUKEVvqYnxr6K3DjenutBdkicxJzQ7yS4mZr8aBqOrgNutEoEmC/7u6xpfx+SAx73os4kLJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2948
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series solves multiple issues present in the driver. While
the patches are fairly independent, there are some dependencies. The
"sc16is7xx: Properly resume TX after stop" adds IER bit set function
that is later used in "sc16is7xx: Set AUTOCTS and AUTORTS bits".

Patches should be applied respecting the order in the series. This is
resend of the remaining patches in original series [1]. The resend is
needed because the "sc16is7xx: Fix for incorrect data being transmitted"
by Phil Elwell went in through tty-linus but the others did go to
tty-testing. Now that tty-linus is merged into Linux 5.17-rc6 and the
rc6 is merged into tty-testing, the patches apply cleanly.

Patch series has been developed and tested on a board with SC16IS760
connected via SPI bus.

[1] https://lore.kernel.org/linux-serial/20220221105618.3503470-1-tomasz.mo=
n@camlingroup.com/

Tomasz Mo=C5=84 (3):
  sc16is7xx: Properly resume TX after stop
  sc16is7xx: Handle modem status lines
  sc16is7xx: Set AUTOCTS and AUTORTS bits

 drivers/tty/serial/sc16is7xx.c | 194 +++++++++++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 11 deletions(-)

--=20
2.25.1

