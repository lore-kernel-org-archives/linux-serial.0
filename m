Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9B9C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 12 Jan 2022 20:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiALUFv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Jan 2022 15:05:51 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:3023 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237944AbiALUES (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Jan 2022 15:04:18 -0500
X-Greylist: delayed 1283 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 15:04:17 EST
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20CGT5Xb010873;
        Wed, 12 Jan 2022 14:42:37 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2057.outbound.protection.outlook.com [104.47.61.57])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dj2j2g3r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 14:42:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLQAJmugdsP5QQTmQHqIjemG/USds1PxWdEUpMMRh0QdYXUEdQtmE38KMKIK6+ip6TrfMqjAD4fypEGZAO0ZClBzKM/n9O911TYZyd69Vgu/zUCFOOupMPRW3BJVgizDsFxcvH/27k4r6RAfhajO8tzhJ9IMOtKDvUIe/nfFdYQyw613EeGv+NVq1zJJwZ9AiqjYPZyktBzgwZZg5fpQj5ehDYK9ye8THdBz+/tVzkhJtcy2acvq9RGwb698d6XBn545UWjivFft+UFQ7rq/wkPICFlBcuafoHt1gfzlDm5bdJ2sfZVUUIfYL2OZ2nage08hcQ0QHrwZaecBNFRpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkutaZvUNyJ1webbd6gh7evridph5UBe5meEY+OcfMQ=;
 b=KM69yd5mYfwESFEJyF9BgEiTweZ0rOF0ehd69kyewFwOEfQKyamOH8UbVHnKLXzDbl5gnus6xw2Cc3yApHkuLWDj7vhPYgrl66n38tPldkKnBQtuJZbn0K/OL/lTtSy7eYmcWwx5diE1qQlmfvvAonVi4hAFJCcGW60EMhx2Qd4715PHdLTf1uslTU1Ltb/YfIBCoQymUYRywCdHGy6MA863vJi5HmvipAVvxVjMOywniWpqFGppL4Ct9fpqeFheHS5jECYAwvAF4JEseECQ3z6FA8vXAJ3WPnlvUZf4zhuV+4Ste7ndqyQSfKtht9TeIZWZA1FmipCJiW+X2CpQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkutaZvUNyJ1webbd6gh7evridph5UBe5meEY+OcfMQ=;
 b=YwjJTuLEbBxrx5vyZ9PFSu+q5UtxGmLF3vpld6xl8tyUqzV9nUW6nZ4B7t+IsTdPaIgZk3ZmQLelQngxfZoe7vSiFlYr3E9HKAS3CgZN7ly9uj5St2A+snwBqn+Y471+IevtjBoiJKGO4HvB9MxlOD1h+E7k4Ts7j3tcebUVhjs=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YQXPR0101MB1541.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 19:42:36 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 19:42:36 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        john.linn@xilinx.com, arnd@arndb.de, jwboyer@linux.vnet.ibm.com,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH] serial: 8250: of: Fix mapped region size when using reg-offset property
Date:   Wed, 12 Jan 2022 13:42:14 -0600
Message-Id: <20220112194214.881844-1-robert.hancock@calian.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR17CA0078.namprd17.prod.outlook.com
 (2603:10b6:300:c2::16) To YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1d67914-fdfd-4d05-4c34-08d9d603af1b
X-MS-TrafficTypeDiagnostic: YQXPR0101MB1541:EE_
X-Microsoft-Antispam-PRVS: <YQXPR0101MB15417F33425D78EEFC8A24E2EC529@YQXPR0101MB1541.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6BGBzYnsuoDyWmJ0+ke9UdydAWJxdcKvWqeNYwDRMqhVVmPNxX3T3NX1W5/8NK9rkzhYSdBIPODKZ9f9UI6q5YbnJZaZrZMXF0y44FPQLmfUcARzKDJLAgqNOcQNX2kd/oT0KTTMQDyneGHnPXTz+/PzUYuXBIzvTz9E1DUIJM+WfgluyrYuF4kGcthdBsBRe/gzBYxeSn3eI8SW9FLHX4vHj0aF6immxGp55ter/rvrQgBEgsz3gaHNCev7ICgBcIUVKyrZIAy7JutUeDlR9GBlaxp0MhCTXP2J9s6Vt8i3qrtcCNeImSsbQumN1R5GBDl+Tq+YBg5wm/gdvmbSRloX5KTrKQmozaJeTCK8aqEYZtk6aBFEv6+kkyKB2yld4izei7HSorj7TGcAK4rVkfj5sYT5xqPqINDJ4yxbtRWOAXAsIVHU+RsJNM+pFNlbFpWubhF+e6YJnP5RJJF+h3wZ6SZ6R6nuld22ULNMDp0BvsMkoDUdp7kCmH1i4aWLnGrz9XKpFJoeAIPhZzNNhW2BvsEQgI2tGNanHZpeGa//kTI5iFtk1F49mJbch465kwgnndcepfWk3xqdby0JzxFMGQuq1WHAVQVeL62RCnA5xqz7e1d67CaxQVrzcF0N87qdTyoxZ7Cff5I5CHkwYHAdBn3duUTWR4DP5Etc0fpxeiHSQVWOEIL9u15mq8Uwtyby5gnUPaGqRC3wlgMHGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(6486002)(4326008)(8936002)(66556008)(66476007)(38100700002)(38350700002)(508600001)(1076003)(186003)(44832011)(83380400001)(2616005)(2906002)(107886003)(5660300002)(26005)(8676002)(66946007)(6666004)(316002)(6916009)(6512007)(36756003)(86362001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pHf5pfUykdpwINXfGptB3F7K2TKzze0GplIc062jEBYOx7icE2T0fR1NSdG0?=
 =?us-ascii?Q?SmJWYyoKZpHPEUDTIY3AT6vJaLad6Ww8/wBXl6wTppbqFiM4LehP8U4fBqCB?=
 =?us-ascii?Q?DyPg3RQTnOGmj5t7MrCnBNHv9NBaFZES4UDFG3Be53P2gcl7FNgfSgdVU3pe?=
 =?us-ascii?Q?mmNDW6wktXb44PH8y8iioWMx7jGZwgxSzshCTiG8TtRzfzn+fYSewO5gJu3r?=
 =?us-ascii?Q?1wlPnvWut/4QCCler3a23nvCixiBN0LM6zI0RvAo6DOsbhE0vEnlLZ1Am67n?=
 =?us-ascii?Q?jwVGLckbqRrbgBSBugVOObYAq5UqViY4g7YTvoOV/QdB89TzLQzWY9EO7Brb?=
 =?us-ascii?Q?MXetzwDu/+2ZdwXbAYV2lekBersqBbTdrQ+A1Zo67cH+qUldrdBFLfjXqi3T?=
 =?us-ascii?Q?iW63YEptnwpjtyQSt0DBllorHsqMNCkfYsISbcZhk62z1oloPhuZvX9URjSR?=
 =?us-ascii?Q?7hG1AJ5M7weIYrpMLsa02+AMHzfWN3H8+o0quGdebuTr+V8RrKGBD4OdDwsW?=
 =?us-ascii?Q?IQUqUeXUIoeDOmbU0zn3bNIUDzH9d6gOegPrbvlFjqSttq/6hI5XXGDxWjj8?=
 =?us-ascii?Q?aDlElpps+z2/w1pZYDRAxcPvnSw5roR6aa2zdajhhTBU4GYHNIvIlPg5gdjU?=
 =?us-ascii?Q?dKu+RJn8KEQOaW5bVOP++U3A8mEwezjv6/BSX3/eRHDsAFah7FRv5kePPxs9?=
 =?us-ascii?Q?02HbsFiPd8G84M6rLqgEczdEM2IVNVbDfhtkYLA8ysidJ8EBWrZtmyutfuYJ?=
 =?us-ascii?Q?Ws+jNZL7x0BHcCAy34FMdc8Dr/ab6zz5z8hRyd+Q3POtjipv4D8RFihWjKPL?=
 =?us-ascii?Q?x6kWSt9FizhUCGNqPAYFUsew82f5BnTqhxL6hnZuRWYwOKDsXL3QxKML/Qa2?=
 =?us-ascii?Q?6aJeVo9ITwFfy51xBXnVdohTRs10/foZHvjHiBfSi3b5Foe0ZFHTq24+/QEh?=
 =?us-ascii?Q?KW9uI+bZtYwFTOqEntNjrsPFPcYxY8e7ARb1+jplSf471tiC9r/HhcBxA3+s?=
 =?us-ascii?Q?ja/iKc9Ko4d2qAIVxHHvnmrzXauAqbGRiAbvdO6SA3/fj4j8ZYbR40DeTViP?=
 =?us-ascii?Q?9o1Pz/h5oEqWwq6Ula/ug0TI6Pu4HxGAKZE/qIWe0NVVxmN7sTY0YlLxDVMs?=
 =?us-ascii?Q?AGVJMuqtTprGH1904L+andtcBd5DOkjcUXEfl26u9/dcsI2pqB8crPXeg2U6?=
 =?us-ascii?Q?eQITMvUtNzJX9iDQ/1d85y48wuVF14c4aMrZrxrzNezq3VU0gxlWPPZzFcMo?=
 =?us-ascii?Q?GJQ5DCykxYvvMsMLPy4dcZdnAEzNP2aVYU73gxCvnzOgHFRzVy55TsocbWEX?=
 =?us-ascii?Q?3t9JxwJzejaiVs78XOPDuYR1qncUs2VvFaTW69UXXyLHD3MAZIcPrt3ulqGf?=
 =?us-ascii?Q?Hw56Y+WK1+4E8HaHXB6xsAnCJwNKFZpMF20s6PqK3XkeWFMinZhhFBQppIPH?=
 =?us-ascii?Q?6SpAKeExhTXADRiH6h+SCaoHlP4LnuC/wNOi0gohN9gGuS5WTDi25es4xOwi?=
 =?us-ascii?Q?UAlKpfAzOVnwdHpBLcqCX/DH1/qdPixG33LBRRs1fRzDVsV+st5o6mSz0R16?=
 =?us-ascii?Q?XVrdb3gXszBqzNRdhBxqVtxucnFI4UNiGOFIxnSHZEPAdm+4uHWRQjF7o5Ag?=
 =?us-ascii?Q?PALRUTiGuL5FACw/YABdhA2duuRA3dTENtYxaDU2EZQOv3aNIFh8Zv6RItoh?=
 =?us-ascii?Q?PCG6M34mixf3udh84imdDdJ5tRQ=3D?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d67914-fdfd-4d05-4c34-08d9d603af1b
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 19:42:36.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOws7PrTQ6QHR0m9YUwLUbvDAg1Di5TWo8RYlzKbthFCO9Fv1QqywA1UgJP10h3MykvIoiMdc/5tNu1cYtsElVt2wfVsa5dLrVACb1mPFdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1541
X-Proofpoint-GUID: Hc-5nWIFTGimmeXKxo8YAl959mX4m8LA
X-Proofpoint-ORIG-GUID: Hc-5nWIFTGimmeXKxo8YAl959mX4m8LA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_05,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120115
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

8250_of supports a reg-offset property which is intended to handle
cases where the device registers start at an offset inside the region
of memory allocated to the device. The Xilinx 16550 UART, for which this
support was initially added, requires this. However, the code did not
adjust the overall size of the mapped region accordingly, causing the
driver to request an area of memory past the end of the device's
allocation. For example, if the UART was allocated an address of
0xb0130000, size of 0x10000 and reg-offset of 0x1000 in the device
tree, the region of memory reserved was b0131000-b0140fff, which caused
the driver for the region starting at b0140000 to fail to probe.

Fix this by subtracting reg-offset from the mapped region size.

Fixes: b912b5e2cfb3 ([POWERPC] Xilinx: of_serial support for Xilinx uart 16550.)
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 drivers/tty/serial/8250/8250_of.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index bce28729dd7b..be8626234627 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -83,8 +83,17 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->mapsize = resource_size(&resource);
 
 		/* Check for shifted address mapping */
-		if (of_property_read_u32(np, "reg-offset", &prop) == 0)
+		if (of_property_read_u32(np, "reg-offset", &prop) == 0) {
+			if (prop >= port->mapsize) {
+				dev_warn(&ofdev->dev, "reg-offset %u exceeds region size %pa\n",
+					 prop, &port->mapsize);
+				ret = -EINVAL;
+				goto err_unprepare;
+			}
+
 			port->mapbase += prop;
+			port->mapsize -= prop;
+		}
 
 		port->iotype = UPIO_MEM;
 		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
-- 
2.31.1

