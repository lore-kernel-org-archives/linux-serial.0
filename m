Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A063C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 28 Feb 2022 07:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiB1HSV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Feb 2022 02:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiB1HSU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Feb 2022 02:18:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B946F10F2
        for <linux-serial@vger.kernel.org>; Sun, 27 Feb 2022 23:17:39 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21S6JX3A008194;
        Mon, 28 Feb 2022 07:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=QS1Krazakw4BeNhEGXE2/0jzcCJZrQcUugWGkE+gQok=;
 b=pVxxJiYuBZOHFOALpdT1HiIAPUz5jGSBIvRWPX5wZOKQxuf59kDAoHvgK4oToGVnyvqb
 Z3yXw4Ca4sE1tIl7zMPtHcObscDQamSWmg55eJjmRqGV5xq1tf2R9nVi+i32yiNwTeIP
 BC9BqJVx0A6owd1XD6HpHQAnSHc3DqTypyCJyLZR4AxWey33Mkqa1CVyD7FIjVwSNr0/
 U+qBcWvxgDugzDr0bLWlC5Er09vmmMppmwLLAYv0ggVyzy0okLzZfUOz77hWeb1WgS1Q
 K7/McxLXPPksSWaPpuzQD7NMtGs2dKRokjby2sCUQuIYY30nTYnEjsmq62vZzgEfXaLp gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efb02kbv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 07:17:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S7G0Rw005412;
        Mon, 28 Feb 2022 07:17:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3030.oracle.com with ESMTP id 3ef9av0x8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 07:17:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW2NgVHHvx8YlE06nhJc4kdJuUH7pqb82dW5gk4yTmNDXnxUooHn6L5RRMWWWujb4PvIvJjv2FcG9H4wgqrrOZ+IwUROvCZpGMaAujVMyGquDpqCg2ZkmaqhY5CAmimyIVq4TyM5EtDM/lJxFXm5AUmuJT5pTy5G7zM/CNwwi1Wa+bSNz9JziryjOHg7eQixEjt22lNwAGLeYGwvpjc1yFhYIvraCANiv8FY7zj3gUJPmCvPmTiPp8jxP74kgNe/Ah758TtihtHDPdLKF+wKwHII0xrnCCjbdLKV2Lq1PUln6hIHYxauAdcoMKQIRaiPGeTra5ynZDPybW1/sVGhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QS1Krazakw4BeNhEGXE2/0jzcCJZrQcUugWGkE+gQok=;
 b=jMThHcZlS9suLLafKe2A2t8aIZgIGxP0rE/bro+HMFVEnM99CzyueLREgE8jUSiPa4U3Ln+ySGUsayz3bGl6W2dcG+BUKfGHP0JKEpnzu4rIXgU99a2tOuo2F9Wjkr6TGzOjTXXU68WLkH/pFj/mLsT8LzFyStviCjRq/UgCtvVNQvohxVwGPsid54lo4T4UoLlkDilN8NRq6IGXeefvhblTqO/lmpoQELUhIubMg/V9XJOc/egaSq8G07jh3Edihj078Hh8B7LnN98gJwj4OLIBWUwq4EF1XgyfGZsE9on2CEyRIfFMgQSMiHXc9TdpArVBFSEzCPmY5rkSrHhljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS1Krazakw4BeNhEGXE2/0jzcCJZrQcUugWGkE+gQok=;
 b=NvDQp0bOmTx914KRnypoHtXHMtZ/uG5aw+f4QdGmtggq0no26dI+thxit9JdOB0X8iYu/0j5xkv71/Ej2gEzQCsowuLdO5nV+wV/OtAy8E/EvvsfjEqITCpI7T/hsOucUvt+X7DmzjHvpe1sjhqu7DDzgkQOsZci/WfOZMs2Eyc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1627.namprd10.prod.outlook.com
 (2603:10b6:4:4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 07:17:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 07:17:31 +0000
Date:   Mon, 28 Feb 2022 10:17:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Yu Tu <yu.tu@amlogic.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 30/42] drivers/tty/serial/meson_uart.c:832
 meson_uart_probe() warn: 'pclk' not released on lines: 779,785,790,794,799.
Message-ID: <202202270400.rQqj5xav-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0118.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be49a87-08b4-4ed2-874c-08d9fa8a6213
X-MS-TrafficTypeDiagnostic: DM5PR10MB1627:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB16276462A04EF2EB96EFBA538E019@DM5PR10MB1627.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: woJyg7s+q0hu3up2ykmQhGrMXNFsSzgqiO6Oj5mCn1vFOCclJKTTs3nGl2CEyYp0zx0jK8I+pGdAhvm/pwpyVb84HLT8RwIUhYC8Izb/zsoRZwZH8ohXD2xNCY+qPIUP5pMiyhJwRT6rHOLSDkGBp35OzLNct8xoJJn2JysEp730kKqZFOO4L+XkQUnn41L5Ftu3tH6eH5ATTDoHI3OGMoP7zdM12V/AQjLQ1MZBGBtG5bdWBdFw1CxlE04upWIPZuwAc64r5JGQV7CyO7LfJiUZSOZwwQMtjgFII6TOR852fN8PYPmjokzcvS0HQUoyykvj2hBNhLNIEivN3UVzWscSvKqhjBz6rd7/iJWfamRFn4KBl2QRNY/MOdwkA5uK770V9jSkVvIH942yxYby8TpNIdS3RLYPW9WN/un3vAmF9RmwJsUi/F0zdVIHnt9j75lHApC71EGdnpzFQE6ajRcL2WQOpdVSho10HGMwtzuEjY1PIaztbrBphFxrHU3QWDllqLzSY8mQIJRLf15r0zz9Bef5D5ugFn0a/p6jLKxHz8htYltu1dhe/B0b7AnC5Zy4Urp3XpaQN8CG6tTydKVzHcohd9fFBx9MKjyh/efG3W9wBJ7VdzAuSGXeeKdUblZoNKZJLgaYD5sHuIcshPjuFTkIuyj77us14Exe25UTv8kVojoVVO8lMRgQzfYM4SsgxDK6W62obsqxONaJaxBLUaHDGTRM5dH7Z04wSLKGKj5b2R+GjcWMXAfn5kMji14fOa8vqxCDsxMPVtTtR5NcZL174OobM3VgE8i4NdIg0NHEUXxmITysbIKcvseDsn+/tUDhV8hAuckZT5o55A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(9686003)(6512007)(966005)(6486002)(38350700002)(38100700002)(316002)(36756003)(83380400001)(6916009)(186003)(26005)(1076003)(6506007)(4326008)(8676002)(86362001)(508600001)(8936002)(52116002)(6666004)(4001150100001)(44832011)(66946007)(66476007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qDk6lUg5FuteDVPiPcFa+CUEc8iq2nMyu9t5P3mIRn9T9fX5X4+NFEbtlazR?=
 =?us-ascii?Q?XZixQ6Lk5GipP7QIo2Le/khZW/rliZDkoDYzbMjsjaJJ6bFNMrPcvUglzvPA?=
 =?us-ascii?Q?A76TOmHO+XDGxM4HCx64m3KEXKBPAnYG1r7TPPEGa17sIloACaQbI7Vh8WyZ?=
 =?us-ascii?Q?1djOdIL5McBihMnhehj6CkpDDDjT2lUz20xshlqwSuEf1ginnhf0EOgHFHob?=
 =?us-ascii?Q?MEXPwg00eSjVVRbDllHkWTpV340WQqVoPvP7TQlHzDmb+70OVEKED2KFhAHv?=
 =?us-ascii?Q?tcQ3JJOMU7aC2U700WhMu8zI786eNEQwYT3revSQchGMWe0zgqvP4jRBzLEb?=
 =?us-ascii?Q?iu5pqaCxlw9Yps+eNOF57+Rp65QQCGFqLr2oX3rdFs6qkbCRBUej/OzWDq+9?=
 =?us-ascii?Q?UUjdQjbxffU7DcUUgjYbFpwKrquCl2MUUnr3gO+gr3IbOTef1MqpkWmx/pLT?=
 =?us-ascii?Q?GNmvmvY4H9jLoW/MzvhNRBcRruTrWR57ed5UX4C1sOPSEoIsbFCoe6L3O3ua?=
 =?us-ascii?Q?XrP803DSzlUveIZ06FE40rJtDUmNbt51f3RSpkcYHAwuVG+qxLgzpkfwwdYp?=
 =?us-ascii?Q?qrqwP0PewmKc392+x9v/7E3VXqT7a30klM+e+OVOTgTaUYRuI0N3TyPklHLI?=
 =?us-ascii?Q?eslxGEQZQw8ExQS1wRAJW8PCM+k32yiunhkQUKpxKzgpi51queyXk6Lzi7Ip?=
 =?us-ascii?Q?Z454HyUP4wY2wMAyof3htgU1ZjX1efryFNagilONMUWB9pqoeCKRrGjkOUAR?=
 =?us-ascii?Q?OuJHg+MyD0KryRHPMJV5C1yQ/QuahW4FUMBzYfKbMmv45TnJvW2WijsT38rr?=
 =?us-ascii?Q?g4hlTXFnWf7aQOgMGaAczRyfHiGwol6bz4d0L865YKhC0Kllh2HIwoHE7jtk?=
 =?us-ascii?Q?9YBUN3jSug0XvjcngoBFIYBa6p3RuwuCjfXusb9SRLp01F/hi6TB00r7ODOY?=
 =?us-ascii?Q?xGL7odL+szd+iSD9/28JvrjotN7pDpZgkyEmHlArnEly0hgGlbrq7jK7FHQ/?=
 =?us-ascii?Q?f4DZkpF23XUj+VuCbRu/2Wvk7O3sIYZbaElP1GWAPbOVOYOnnmHutGyKxYTm?=
 =?us-ascii?Q?olnHSrVza1N23keojfTI5rjvdeSZDF0gHC8RoorEH0RLNBiToeASHEtqP28w?=
 =?us-ascii?Q?TBfqK/9Mzqs5FSkO3CA/QP1jxnvTiIpRC2Amjnva34S+M1kdIyCZkxv8PCUj?=
 =?us-ascii?Q?Rz+oBXB0D4BKhjQI8jpNZCC3DQTwbl/+XZ3+R8DeGd64tfNgrlVR9q2vyFIX?=
 =?us-ascii?Q?UyruiUdPFmatkI1QFUfNeT8kksxJc0a8LD798WDSwfGGvCn6c++ouY3GilQ8?=
 =?us-ascii?Q?Y9iWMN4bdvn8PW2XXfefihYM3GlfJsXP/rM8nud+Q+nBiMlzP5LEFr2Jcf4f?=
 =?us-ascii?Q?TXSAAwZTnWuG9HHu/aA5Uf9t3OjJEqLWMBXK4IcDTeHdLB3P0LqH2yKL+2Bl?=
 =?us-ascii?Q?7NDg/5PEUcUW/Lzl8NoqCcQE75nZ4a2MFi5wsXTeYST2FMC64nyVVzSR46qw?=
 =?us-ascii?Q?KxU5ECqpzWCtzgwa+VSc8bczprOz6TkaIg3wzs0SXfW/a4Sopb6wq/LHHlG0?=
 =?us-ascii?Q?q5X5hSCrMqt+vqg1+dE7eJu36FQRXLI7AM8bq2It4D5Ss0idTG99l03PD70f?=
 =?us-ascii?Q?K/GDsoNDFQXzKj7iirJOp2riup29P8uWyQtvxQu36pWwZnqjNAYCpPuVTrLW?=
 =?us-ascii?Q?0yaaZQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be49a87-08b4-4ed2-874c-08d9fa8a6213
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 07:17:31.2357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcGNsw9t2Rjlcpx4JhLALh+tpAFvbJdF0xY027Ev3LL9jbSPR/5dVjAFBln6JwZOiF2oDwHNI0x/im6ShGji/t5cGSUTLAaB2o/k8eAu1pA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1627
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280042
X-Proofpoint-GUID: kPhJygfB_JhjXB-KhPQGkNNJF2xP_doJ
X-Proofpoint-ORIG-GUID: kPhJygfB_JhjXB-KhPQGkNNJF2xP_doJ
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   71404f653cf7858fdbb81dd5419a8a4ac4ffa20c
commit: 44023b8e1f14bc72bb773dd84dc3563fc912d210 [30/42] tty: serial: meson: Describes the calculation of the UART baud rate clock using a clock frame
config: arc-randconfig-m031-20220226 (https://download.01.org/0day-ci/archive/20220227/202202270400.rQqj5xav-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/tty/serial/meson_uart.c:832 meson_uart_probe() warn: 'pclk' not released on lines: 779,785,790,794,799.

vim +/pclk +832 drivers/tty/serial/meson_uart.c

ff7693d079e58f Carlo Caione    2014-08-17  737  static int meson_uart_probe(struct platform_device *pdev)
ff7693d079e58f Carlo Caione    2014-08-17  738  {
44023b8e1f14bc Yu Tu           2022-02-25  739  	struct meson_uart_data *private_data;
5b680619834714 Lad Prabhakar   2021-12-24  740  	struct resource *res_mem;
ff7693d079e58f Carlo Caione    2014-08-17  741  	struct uart_port *port;
44023b8e1f14bc Yu Tu           2022-02-25  742  	struct clk *pclk;
27d44e05d7b85d Neil Armstrong  2021-05-18  743  	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
ff7693d079e58f Carlo Caione    2014-08-17  744  	int ret = 0;
5b680619834714 Lad Prabhakar   2021-12-24  745  	int irq;
ff7693d079e58f Carlo Caione    2014-08-17  746  
ff7693d079e58f Carlo Caione    2014-08-17  747  	if (pdev->dev.of_node)
ff7693d079e58f Carlo Caione    2014-08-17  748  		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
ff7693d079e58f Carlo Caione    2014-08-17  749  
a26988e8fef4b2 Loys Ollivier   2019-01-14  750  	if (pdev->id < 0) {
021212f5335229 Colin Ian King  2021-04-26  751  		int id;
021212f5335229 Colin Ian King  2021-04-26  752  
a26988e8fef4b2 Loys Ollivier   2019-01-14  753  		for (id = AML_UART_PORT_OFFSET; id < AML_UART_PORT_NUM; id++) {
a26988e8fef4b2 Loys Ollivier   2019-01-14  754  			if (!meson_ports[id]) {
a26988e8fef4b2 Loys Ollivier   2019-01-14  755  				pdev->id = id;
a26988e8fef4b2 Loys Ollivier   2019-01-14  756  				break;
a26988e8fef4b2 Loys Ollivier   2019-01-14  757  			}
a26988e8fef4b2 Loys Ollivier   2019-01-14  758  		}
a26988e8fef4b2 Loys Ollivier   2019-01-14  759  	}
a26988e8fef4b2 Loys Ollivier   2019-01-14  760  
ff7693d079e58f Carlo Caione    2014-08-17  761  	if (pdev->id < 0 || pdev->id >= AML_UART_PORT_NUM)
ff7693d079e58f Carlo Caione    2014-08-17  762  		return -EINVAL;
ff7693d079e58f Carlo Caione    2014-08-17  763  
ff7693d079e58f Carlo Caione    2014-08-17  764  	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
ff7693d079e58f Carlo Caione    2014-08-17  765  	if (!res_mem)
ff7693d079e58f Carlo Caione    2014-08-17  766  		return -ENODEV;
ff7693d079e58f Carlo Caione    2014-08-17  767  
44023b8e1f14bc Yu Tu           2022-02-25  768  	pclk = devm_clk_get(&pdev->dev, "pclk");
44023b8e1f14bc Yu Tu           2022-02-25  769  	if (IS_ERR(pclk))
44023b8e1f14bc Yu Tu           2022-02-25  770  		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
44023b8e1f14bc Yu Tu           2022-02-25  771  				     "Failed to get the 'pclk' clock\n");
44023b8e1f14bc Yu Tu           2022-02-25  772  
44023b8e1f14bc Yu Tu           2022-02-25  773  	ret = clk_prepare_enable(pclk);
44023b8e1f14bc Yu Tu           2022-02-25  774  	if (ret)
44023b8e1f14bc Yu Tu           2022-02-25  775  		return ret;
44023b8e1f14bc Yu Tu           2022-02-25  776  
5b680619834714 Lad Prabhakar   2021-12-24  777  	irq = platform_get_irq(pdev, 0);
5b680619834714 Lad Prabhakar   2021-12-24  778  	if (irq < 0)
5b680619834714 Lad Prabhakar   2021-12-24  779  		return irq;

Do we need to do a clk_prepare_disable() on error paths?

ff7693d079e58f Carlo Caione    2014-08-17  780  
27d44e05d7b85d Neil Armstrong  2021-05-18  781  	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
27d44e05d7b85d Neil Armstrong  2021-05-18  782  
ff7693d079e58f Carlo Caione    2014-08-17  783  	if (meson_ports[pdev->id]) {
ff7693d079e58f Carlo Caione    2014-08-17  784  		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
ff7693d079e58f Carlo Caione    2014-08-17  785  		return -EBUSY;
ff7693d079e58f Carlo Caione    2014-08-17  786  	}
ff7693d079e58f Carlo Caione    2014-08-17  787  
ff7693d079e58f Carlo Caione    2014-08-17  788  	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);
ff7693d079e58f Carlo Caione    2014-08-17  789  	if (!port)
ff7693d079e58f Carlo Caione    2014-08-17  790  		return -ENOMEM;
ff7693d079e58f Carlo Caione    2014-08-17  791  
6436dd8f9b25ea Yu Tu           2022-02-25  792  	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
841f913e770f3c Yu Tu           2022-02-25  793  	if (IS_ERR(port->membase))
841f913e770f3c Yu Tu           2022-02-25  794  		return PTR_ERR(port->membase);
841f913e770f3c Yu Tu           2022-02-25  795  
44023b8e1f14bc Yu Tu           2022-02-25  796  	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
44023b8e1f14bc Yu Tu           2022-02-25  797  				    GFP_KERNEL);
44023b8e1f14bc Yu Tu           2022-02-25  798  	if (!private_data)
44023b8e1f14bc Yu Tu           2022-02-25  799  		return -ENOMEM;
44023b8e1f14bc Yu Tu           2022-02-25  800  
44023b8e1f14bc Yu Tu           2022-02-25  801  	if (device_get_match_data(&pdev->dev))
44023b8e1f14bc Yu Tu           2022-02-25  802  		private_data->use_xtal_clk = true;
ff7693d079e58f Carlo Caione    2014-08-17  803  
ff7693d079e58f Carlo Caione    2014-08-17  804  	port->iotype = UPIO_MEM;
ff7693d079e58f Carlo Caione    2014-08-17  805  	port->mapbase = res_mem->start;
ff3b9cad7d6309 Heiner Kallweit 2017-04-19  806  	port->mapsize = resource_size(res_mem);
5b680619834714 Lad Prabhakar   2021-12-24  807  	port->irq = irq;
1b1ecaa69c4f90 Heiner Kallweit 2017-04-19  808  	port->flags = UPF_BOOT_AUTOCONF | UPF_LOW_LATENCY;
dca3ac8d3bc943 Dmitry Safonov  2019-12-13  809  	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
ff7693d079e58f Carlo Caione    2014-08-17  810  	port->dev = &pdev->dev;
ff7693d079e58f Carlo Caione    2014-08-17  811  	port->line = pdev->id;
ff7693d079e58f Carlo Caione    2014-08-17  812  	port->type = PORT_MESON;
ff7693d079e58f Carlo Caione    2014-08-17  813  	port->x_char = 0;
ff7693d079e58f Carlo Caione    2014-08-17  814  	port->ops = &meson_uart_ops;
27d44e05d7b85d Neil Armstrong  2021-05-18  815  	port->fifosize = fifosize;
44023b8e1f14bc Yu Tu           2022-02-25  816  	port->private_data = private_data;
44023b8e1f14bc Yu Tu           2022-02-25  817  
44023b8e1f14bc Yu Tu           2022-02-25  818  	ret = meson_uart_probe_clocks(port);
44023b8e1f14bc Yu Tu           2022-02-25  819  	if (ret)
44023b8e1f14bc Yu Tu           2022-02-25  820  		return ret;
ff7693d079e58f Carlo Caione    2014-08-17  821  
ff7693d079e58f Carlo Caione    2014-08-17  822  	meson_ports[pdev->id] = port;
ff7693d079e58f Carlo Caione    2014-08-17  823  	platform_set_drvdata(pdev, port);
ff7693d079e58f Carlo Caione    2014-08-17  824  
00661dd855b5b1 Ben Dooks       2015-11-18  825  	/* reset port before registering (and possibly registering console) */
00661dd855b5b1 Ben Dooks       2015-11-18  826  	meson_uart_reset(port);
00661dd855b5b1 Ben Dooks       2015-11-18  827  
ff7693d079e58f Carlo Caione    2014-08-17  828  	ret = uart_add_one_port(&meson_uart_driver, port);
ff7693d079e58f Carlo Caione    2014-08-17  829  	if (ret)
ff7693d079e58f Carlo Caione    2014-08-17  830  		meson_ports[pdev->id] = NULL;
ff7693d079e58f Carlo Caione    2014-08-17  831  
ff7693d079e58f Carlo Caione    2014-08-17 @832  	return ret;
ff7693d079e58f Carlo Caione    2014-08-17  833  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

