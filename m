Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E62FC07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 08:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4690613AF
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 08:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbhGNILR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:11:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3236 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238343AbhGNILQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 04:11:16 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16E81YoY003626;
        Wed, 14 Jul 2021 08:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=sP+gi1YeQoq5lXNV/bCjjei80BFYJX4fXC5JRtbqkmg=;
 b=JsHpC6Q30t+O3vryX2WKEjZ7vcvkLWFEnWJX6twieKDvRjL8AQbf7AZwjU3pg6hqJjXo
 n/TzVER3ZCAS3jVT5sJqBX0lI2RKjYYXJc7nb9LQi6/qMH8IBZYVkCe5+dNgWt38Y77J
 Uk1C191uYI+CKlqWw6XKJ6peZ86r5g1I/HVbphtBKPAJOa18wtpY1cgIOa4dMgG1ZfXk
 0GqDxSqyFU4S7/Weoa/EUQW980bjqKeW5VVeg0Zdwlwm56FAXsTaZFhCR6UapSEVZ4gr
 7o2335VBNGeUzMmEJbihHNMXA61AnjF7w2wioRd4BG700237YhA4oQmxa/s3iSNZ8fdN aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39sbtuht88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 08:08:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16E80vPT004487;
        Wed, 14 Jul 2021 08:08:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by aserp3030.oracle.com with ESMTP id 39qycyyrme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 08:08:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1qXEkQoHjR53aG0GfFPMLYv5W67Ht2o05TK3h8JQuixxUUrwe88kUmje94qR/9NxfFJ9oDJN+VbT74UPp1pmjR9P8Jrj9aX6rMERIxbocPWJ/qudaSnXJll26pVgqk5dtzQtikOkFiz15ZE6BavI7A+U9HU5G7GYVA2my02EWQHL9HuK9QGTxgUl/uhvk2vozXFHyHbfNBsduVx/nLRZCVO5vKdMXJBPupoaBYAPfTEfBJNjZEctMQ5sqZ9Smgr7JdUsLL4px8wh5P6ZxPf1mPnq1955/XnuYNhxlnGHNeuCYXT3J1QfyKLVi3Ge3cjF183WNh16s9SWenFqrveGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP+gi1YeQoq5lXNV/bCjjei80BFYJX4fXC5JRtbqkmg=;
 b=lRh0O+uewEC32iZtczpdfbpjlK/LuhoE8W44oMzNN6M+dC0x50SZZWCIJimUHR36PIuidPmrYLIOeK3e/z5sD/Pbd1RzP2v1KcLkyBEQtYwAJQ7xVSTkaoTn5ntX3zAaLBMnrrZn3oKhOWvWeQq2QDmAJsR6UB1NvOoU3qN9idUX7TpaqGek1asJWHWV8559Xw6ow+9x4lMh2ofjPYmUQkuhXwXl5hGrM45LZBXYN/Ty7Tbb5LuWxrFN/0AMwyuGvpGKJcGddD7WQHrCoidCZa/1o5NTFJ7LvYAO2Hsb1uzEsuCz9rWNnVkvXRLDhZQXxNVXhHtXFjVXRxgFzV8e8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP+gi1YeQoq5lXNV/bCjjei80BFYJX4fXC5JRtbqkmg=;
 b=xinXD4I0+5KwgpLFBo/y7Uzxtt8NyZy61zeu2X8+s0AbkJskz1JgTrIDL8zOzXDRT1mIw9HY48t7nzXEj0Ec1R2hDMXa023BDteWtWWRCDcboy7lEJGBoMPyUsX97B9oxekbpsr68wkZugy5dlenpWUD4ZVghtkEA0sp9EyvX58=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2397.namprd10.prod.outlook.com
 (2603:10b6:301:32::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Wed, 14 Jul
 2021 08:08:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 08:08:17 +0000
Date:   Wed, 14 Jul 2021 11:07:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/4] serial: 8250_pci: Refactor the loop in
 pci_ite887x_init()
Message-ID: <202107140052.28NaY2ZC-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Wed, 14 Jul 2021 08:08:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3b561ba-3a92-4ab2-9de4-08d9469e88f1
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB239706032DA89CF45A6DB82D8E139@MWHPR1001MB2397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DkLARr+gGtVJUzpPl+9b/rojAoLS4ChpQeAH/qqf/bD4ODM5YUmf6tBLG0SyVd8jsqgjZz0/xA7Zy4SfZAM/cVCTMlvLjfYV08EByIzILp2t421d4/yJUU8X3mcMsK9vqGbaYtJodTI2SBkG9gFznCSbJKXr61H6xeQpTiP7sw7rIpJ3OZSh4JWB952QVhGhublv/9sYpQUjojnutsm2Pi7jPKF41kTg+z0hV3aAWjVDY5qIGRo694m5Y7vOqYjCdjKFjEjBlUJGVDSbkhz8nKicFXW3f6TrqAFXWLKtLpLxDN8KSZT2Eh0uVpIw3fi6PlYjLSibfSx3W4/1GviEcR8zrZtit18VIr6Zg7Qc2pXactlFfrfQFOqhlUukWhPSlypnxbObG6d5eei9bJ4GROgDbg3bcJE15t2nQCAuABXg9uaw/h2SkUCnM6oadpCifJ8ciXOrQGR4zrXVzfzwSfMCfEQ3poPEDcpCRn9PKwN+dmWaIEmEvtewgSUEvMbMl1mVR3al6B/sAQU6gp7w0zexKTA/DnqWaQW3XgqQgqsKXYyMiiytySdyrGMn6txYLuKsHPXUTOT5U2SYcFJK2m458hzWJ953QMgvVcmsi8V0L5kacCiShndlZ7xikBjQS6kGcTlsnYHcX361mrk+YX28jzHTGaO9gNkijOOY8jSlAhPc5toPnuCScr7/4cSiygAiD6/R3tNwK0iSmbWwXcrYXkufXo9PQZIEEXqVKBOnnUwZAeVaJacqGvj8vYU42mXWd6qiK5J5aCfnGN9UbOFrrz4JKgnHRGorbR+qLqRidHuojpcVq+nZSDTnv04k1WVNm+a4qWx8wTevX3NOXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(136003)(396003)(376002)(86362001)(83380400001)(38100700002)(38350700002)(36756003)(478600001)(966005)(6666004)(52116002)(6496006)(4326008)(8936002)(956004)(8676002)(44832011)(26005)(186003)(66556008)(66476007)(1076003)(54906003)(66946007)(9686003)(2906002)(6486002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tO9uPvIUhtJk+Me8Fw18WpK19tzbwoL7WVDf7wdTsRyoBNGVt1fEVmSMaawR?=
 =?us-ascii?Q?DXuaxRnJaQDADMEknyu3PfpQX+gkLFD6zzonaxdct9Or3CtPE5rtovMaFbIV?=
 =?us-ascii?Q?eiQpxpTSP6gUa4Fh74AoZwG3O0tQqK+NdO7UNSzRaUgfB5GlH2FeJSJtwAVE?=
 =?us-ascii?Q?hFfmV2IO/EIRqqmKhaIFqeB1kefVUEuWf5c/fAGonNyqL/ApDFYJFnNnKrra?=
 =?us-ascii?Q?IZTl4hDtlZqM6lJ2AMVKpSD9jHHwKv9Vf4XsHCLW+vf/2uOxYMSIdJLafYEz?=
 =?us-ascii?Q?lcqjW2IrFnTvkHDWnMYQUp4zUjAUnRcx/i63t6rvZ8rfitYMJRQ/SOC9/dix?=
 =?us-ascii?Q?K9DFTsOfCgGCb2eNNrEgIhyVQXEW/ioSwk+1W6C/BBAU011+nmD81+R9iHNk?=
 =?us-ascii?Q?cs6W1tbdAW6RUWM2mvc2AEAsVUeXL1A9aT9WO+9RTVpeWNY8ytJ7spe2uuNX?=
 =?us-ascii?Q?jeQU5a0gUFWJF3EUCxzlK/S7o8kZVFh5Oda8E/j3uer7pbMEjd93ytfQb3m2?=
 =?us-ascii?Q?CAK8fDbrw5kWX012qI53EweUl544VVFZxkkbaLCuNxe4pjVRCC+A8RIag8ux?=
 =?us-ascii?Q?4FZ4E6HIRjAouTGS1FKPjReXhu2H9EAaSNDxU+2Q6eAthZw1I6fTM+qcLark?=
 =?us-ascii?Q?MCDa+zEGxO9Hr/BYG3mmgmusER1Kxfb1Aq36WEu4r71usEIYM51+9DEqqJfR?=
 =?us-ascii?Q?ztHzI1l6NnHZVmPJtv6MrQBwpJ2iN+si7dN+g8IxFcDLMxw8TUUMTnEnb6pS?=
 =?us-ascii?Q?HplMrHAc0V/TxTcXJmrb7m1Lpvw9redFVXxn0CNaQuBH4m6wfWi4ZBp4L89U?=
 =?us-ascii?Q?O+K0QvZdexzf/Og5wrNevw4WftuY1GBVF7N8g/TeCDZ1VM6pnzt5+0PZ47yc?=
 =?us-ascii?Q?q5/BNN2zWAgKkvWG26CLjf7ruEv3DFve2r9nKaRA3f4BNmVz/UiMWTSSeYpw?=
 =?us-ascii?Q?D47XPn/yS4UilnuX4Xs6rcwL0sOhoG+wBaM0w6TyVZCFwRTYSh2q2//67Mcz?=
 =?us-ascii?Q?xLOe/2uB58KfBUgJ5DsqoDOgWzYU5pH1ezz8kq9Q+5y2K4Zo/IZBORi+xP1H?=
 =?us-ascii?Q?/onnkyEJkLOIcuECpNwgeEVdj4mhqMs0y+HB5OptPjHMtQ2izNusN4zansDY?=
 =?us-ascii?Q?Hw7McICQ9kfXUDU/JFK894B3/eslhenWwf5v9X/vpQ8JbJgVrDtgdB8u1+G9?=
 =?us-ascii?Q?mEo9JTXEwhYj66wDZ8AMT+1v+uoMla6iaR6zCTalTiVj1wkA9nDlJYSZOGRv?=
 =?us-ascii?Q?arM+zDlXA715Bb85bfmvfA0fIwVlXjVvDJC+Dc4lbn5HdCAvHOhxnVojg4Jo?=
 =?us-ascii?Q?C0ST2p/SYzKg5cr497XcwiyG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b561ba-3a92-4ab2-9de4-08d9469e88f1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 08:08:17.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xc4J9IDutgUeYmBrco1Di3fHKH5GP15Xjkr5DvYy2T4ebxXVahZNZ7eDqgpb/hlg8ElVnaCyczbd5roq5s3enGq6t/DaV4CK7LsMDcdiEcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10044 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140051
X-Proofpoint-GUID: 4H5Oy5Wlydt-xfagvqpIN9UnqHo1yKqT
X-Proofpoint-ORIG-GUID: 4H5Oy5Wlydt-xfagvqpIN9UnqHo1yKqT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/serial-8250_pci-Refactor-the-loop-in-pci_ite887x_init/20210713-184225
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: x86_64-randconfig-m001-20210713 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/tty/serial/8250/8250_pci.c:927 pci_ite887x_init() error: buffer overflow 'inta_addr' 7 <= 7 (assuming for loop doesn't break)

vim +927 drivers/tty/serial/8250/8250_pci.c

97f2398f0f6a89 drivers/tty/serial/8250/8250_pci.c Andy Shevchenko    2021-07-13  901  static const short inta_addr[] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1e0, 0x200, 0x280, };
f79abb828e1d85 drivers/serial/8250_pci.c          Ralf Baechle       2007-08-30  902  static int pci_ite887x_init(struct pci_dev *dev)
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  903  {
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  904  	int ret, i, type;
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  905  	struct resource *iobase = NULL;
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  906  	u32 miscr, uartbar, ioport;
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  907  
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  908  	/* search for the base-ioport */
97f2398f0f6a89 drivers/tty/serial/8250/8250_pci.c Andy Shevchenko    2021-07-13  909  	for (i = 0; i < ARRAY_SIZE(inta_addr); i++) {
                                                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^

97f2398f0f6a89 drivers/tty/serial/8250/8250_pci.c Andy Shevchenko    2021-07-13  910  		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE, "ite887x");
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  911  		if (iobase != NULL) {
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  912  			/* write POSIO0R - speed | size | ioport */
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  913  			pci_write_config_dword(dev, ITE_887x_POSIO0,
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  914  				ITE_887x_POSIO_ENABLE | ITE_887x_POSIO_SPEED |
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  915  				ITE_887x_POSIO_IOSIZE_32 | inta_addr[i]);
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  916  			/* write INTCBAR - ioport */
97f2398f0f6a89 drivers/tty/serial/8250/8250_pci.c Andy Shevchenko    2021-07-13  917  			pci_write_config_dword(dev, ITE_887x_INTCBAR, inta_addr[i]);
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  918  			ret = inb(inta_addr[i]);
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  919  			if (ret != 0xff) {
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  920  				/* ioport connected */
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  921  				break;
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  922  			}
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  923  			release_region(iobase->start, ITE_887x_IOSIZE);
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  924  		}
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  925  	}
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  926  
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22 @927  	if (!inta_addr[i]) {

Should this be changed to if (i == ARRAY_SIZE(inta_addr)) {?

af8c5b8debb046 drivers/tty/serial/8250/8250_pci.c Greg Kroah-Hartman 2013-09-28  928  		dev_err(&dev->dev, "ite887x: could not find iobase\n");
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  929  		return -ENODEV;
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  930  	}
84f8c6fc0e3b6e drivers/serial/8250_pci.c          Niels de Vos       2007-08-22  931  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

