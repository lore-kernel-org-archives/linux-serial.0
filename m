Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F19C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 16:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AAC61185
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 16:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhDZQeR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:34:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50590 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbhDZQeQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 12:34:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QGTVnh161258;
        Mon, 26 Apr 2021 16:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Mi+yG3kq6rVsz7OW6hIQ212zudjQT5IvQmL1+26C7sQ=;
 b=ukOuaJIOuW8zRi7xkFCNPSITLJ1YZyMMQe/wyx+0FecK3momztre/guPfs2vsxXmsm6M
 X4B4shR0LTxy+wGm+quH+oYSKdQV7MmJh2PpaXPVkWT1mZCNxPnixca26d/gqGA9TfaP
 Z5gVxuGNq68/nM5ufj42QqGVKy6ZzE2wh4G2GXJPp9khLcw1xcnxSq2vD6JjXwjPnQlS
 eQD3EZwG3415Zzbz62VADyQ473CIMGomtLcJoT8RXz6pyK9xPEJeTHjlNg6L8cLMz7NV
 bqmetBYZ9y4AHu+hAy/ZfufpCk8fbselZprGFmTdme6hzW0HZW++GkmhDCJ09Maz+cMh bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 385aeptpaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 16:33:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QGUQ75090673;
        Mon, 26 Apr 2021 16:33:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 3849cdeesp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 16:33:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asYzBg6nTGFO0WeEEeNP5GyFl58/otUK1wC+OJ426tccgBz0BXvm2ha/2NO8iXf5iYq6ZX/+Z7V0cwTlklVga8NZyB3mkDDixC8blWoiNkUNzKNY/5ditblOrLpuisPXY4QZwbcPyEzTFtaudI3fgDn52yGC+s3aYaNWKx9gEcs6CSvVkfCoICLA6tFAl5fpieW9ZLjWz5m1B0cWZ7x4V0fDlqCf0kTYAE3c6+pQV07pk0cY1j+g7gyDP3ZsbfgewrSveirEMXT0XsO0UmrZ4PjtkvRYhR35uf0vraeE0B3YLINB2vKtVrTCy8vnbSxilhoeVUBKiwlhxRi4EodoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi+yG3kq6rVsz7OW6hIQ212zudjQT5IvQmL1+26C7sQ=;
 b=dF2m3jdf/3LqmDxAkD76izA9kcHDnQy5Pl9HlbkAxLX9d1BLn0wMT5ukUxCGjaNRHaMTTRV9z/AyjdeqVmla9JBmlP61Lllqt5OWpUDt1L3mTiTubhoymwYrhAgGbSMuITRKr/WD6EpcJhKZiv8PISyBFbrkfrUFNhWaPE3dd8BdDn5McPsRikine8ED9Y0YlJRRxfHRkwsLb8VnVki31VQc3rj+0Z1cfqQLOEfrwKSwN5Y3+DMNFkQQxyW/wVa8dobEfQdXHe9/Yd1zpQGVpjF+ieNtLw1MGZtgnmMZi7aakrY/DFx2DF7lKU5tNDYrBUrMswVDS6ZTaiJKDte1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi+yG3kq6rVsz7OW6hIQ212zudjQT5IvQmL1+26C7sQ=;
 b=lG+5ynStpNms1a5IMIwHwHWzUVNupfWedfan+BwGQYNT87xLVyd5701vcdHLoyDmIq9Hrk18TrkH+odPhM0q0Z2GcmRnimgKGPxv5cuoQKtq1188+GXxs8eaRAqULd4EvNUhJzaAXF6gJMpHcpYA3Tby8q5KABTc1haWrRCpkDk=
Authentication-Results: connolly.tech; dkim=none (message not signed)
 header.d=none;connolly.tech; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2133.namprd10.prod.outlook.com
 (2603:10b6:910:43::27) by CY4PR10MB1464.namprd10.prod.outlook.com
 (2603:10b6:903:27::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Mon, 26 Apr
 2021 16:33:14 +0000
Received: from CY4PR1001MB2133.namprd10.prod.outlook.com
 ([fe80::40a:b796:4a86:d0cc]) by CY4PR1001MB2133.namprd10.prod.outlook.com
 ([fe80::40a:b796:4a86:d0cc%3]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 16:33:14 +0000
Subject: Re: [PATCH] serial: 8250: fix NULL pointer dereference in
 serial8250_do_startup()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org,
        syzbot+4c7f1a69dfe24c6b3aeb@syzkaller.appspotmail.com,
        syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Hurley <peter@hurleysoftware.com>,
        Caleb Connolly <caleb@connolly.tech>
References: <00000000000044a65205994a7e13@google.com>
 <20210426161433.20829-1-vegard.nossum@oracle.com>
 <YIbnq2ljdQzaN8gy@kroah.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <e3617587-7ff1-720c-00ab-434608705652@oracle.com>
Date:   Mon, 26 Apr 2021 18:33:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YIbnq2ljdQzaN8gy@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.217.245.67]
X-ClientProxiedBy: MR1P264CA0015.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::20) To CY4PR1001MB2133.namprd10.prod.outlook.com
 (2603:10b6:910:43::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.13] (86.217.245.67) by MR1P264CA0015.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend Transport; Mon, 26 Apr 2021 16:33:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c3b30cd-438b-4f92-5343-08d908d0fd65
X-MS-TrafficTypeDiagnostic: CY4PR10MB1464:
X-Microsoft-Antispam-PRVS: <CY4PR10MB14648B348121F0379F860BB697429@CY4PR10MB1464.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kreSewbPzkXsgoiCeoCpQNPZXWE/1PwiaekL8mEjZub/HB4iDnT5NYgD+Md4iZu9X4JlsEHgHvbbHhfhwaIgkR6Q+TwyYLrG1Z8dpdpBkJtgc/fbHNM+LI5Mu28hF20QNaqG7w5TsqVrDJnVhOBFsy6NOAA6r9qx0OfltJqxc7SObL0ui+Z3QkGsoihsTowwnflUOzWQPOnwAgp7+9CDk9nVbdnwuxAO62WUyA3W3O7AeYlTMjVv62j2cDiu0fwaavr2nih6WAAKo+93aabAYJGlLRqIfYFaysOXwZMJnJ4qww1u3FSbAzTcRjC38uFXrAWLcYa3+8v4PBQ5IFc7p2kkY7I8etLPhQG99rKg+HUbYlb2a+XIgz2az9CklBoIPtQkZO+eh0Q9ywuYUDr9Rr6ghKj2N7aIfEup/x/i3U73BWPi6jTrmcZTcy2n3RSXCcUBZonpagQ1Fbx6XWID+uF3fBoHebRsgVkP2Uu4TqgMDRvuHm3QQkqsihvwHvwxGoqydj1RVVqPAmqsNZJ2K4LgAEBYioPYr1W4LUi/8R2z81R9yhrU++Q2UThRgYI+RARHy9rrMQvVSL2dUEvtMsUAL0vVEknNzv454Yw8QMynoFqndihs3+DNpRkPajw2sN1MQm1pP/2qrgY8CBMQ5g4PfpSK74bZvONGjUVJHDewJIjqGCtj+8JyXPXx0p5QkGBlOq1OI9CRDIXbqRYJgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2133.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(346002)(136003)(376002)(54906003)(31696002)(6666004)(36756003)(83380400001)(478600001)(16576012)(316002)(31686004)(5660300002)(6916009)(4326008)(66556008)(44832011)(66476007)(52116002)(38350700002)(16526019)(26005)(53546011)(66946007)(2616005)(6486002)(38100700002)(186003)(8936002)(2906002)(956004)(8676002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dmRhb1lJVVYxaUk1Sy9hMVg3VUltamRjd0NreEdBb21pK3l3VUJDemp0QW1M?=
 =?utf-8?B?cnlzQmpTdWUxSVFIOUI1c0kyaHpZWEd4WnlFeEtHMkdWUjd6cjNTdnA4Y3ox?=
 =?utf-8?B?K3kvMm1DTXY0YnQ1L1FPck1FVTRWQnkvY3dVK0d5QVJucDZjMG9hSFBNVGpR?=
 =?utf-8?B?cDFyNUd4Mlk2M09nd3hrTnpPM0o4NFlLYmZtemJLYWpNS0dTd3FFM1dTbDB6?=
 =?utf-8?B?b2s4S0lVRUN1aVJYaWZhaFlaYkhLWjdpaEthajU1Z21RV2I1bzlxVnYyZ2Z1?=
 =?utf-8?B?akhpc1hNUksrcG0ySHRaR2VlVEZFZUZFbXU0SHdvclNPci9Ua1dsNG9DNmg1?=
 =?utf-8?B?N2ovblNodEZtYm1yazlLbkpESTAyaTY2SDRNdnYwNUVJaDdOVUowTG5lQ0ZW?=
 =?utf-8?B?T0UvVG42MjQyelBuN2V6clhoVVFqQmd6MEFsa09TZWEzTFJnRDQ5R1NvZzdj?=
 =?utf-8?B?Nk1IMForRUVmYkthd1NJVGN4VEhpMHB0TVZBQjF5V3R5QlE1UktUMTEwRk13?=
 =?utf-8?B?ZmZwY1ZnelhpTXA1b1ZGUGtSZ1ZBU3EzTDVCWXBTc09KdnVNa0dHVDI4UGxm?=
 =?utf-8?B?TkZGWEdGM2V0M1pyVWRoU09ETFZyeUpWd3Q5VFJCZmRHd2hUWGx0TE9TOHNC?=
 =?utf-8?B?N1owWVArc3U5UUNjVVZkNFFTaGw1UWh3dVJNYzJwVm5iQWNzSWo0cWFNUEw4?=
 =?utf-8?B?em9ZVXRsb2x0dkdaWGYydnNqNVN6MklqOWYvQlR6TG9jTHViS0haTERPTEFU?=
 =?utf-8?B?VWdzeTQxY0FjRlQ0Q1VpSS9kZ0ZYQXNGaWV0K3pDOXR6WjJUS2hxVmNzY3BG?=
 =?utf-8?B?eWZCUDlrVnFXbGlBNVczTnAxZGlPd3M4TFNTRmJsOFgzVGpBWTlLa0hRSjcy?=
 =?utf-8?B?OStXZjBtRWw3S3o4NTJWSzFRMFJiNjNLcWxFZWZMOTUvU05NUktETktrNjMv?=
 =?utf-8?B?THpBdDhyQS9sSFVrYXdQdlM3Y0FVQmJxSEk0RmRyWkVjWmxSdkxzNkh1dVBs?=
 =?utf-8?B?eXhNUy9xZWdVUmRNME9DbVo0M1NaMHVSMFZqTlpCM2RtUmljTUdQbVFDeHdD?=
 =?utf-8?B?WkU3VHpOdERERWN6TUpUcXMwczJ4SUZFZ3Q5ek1pVHBaUkhWd28wTkZURXlk?=
 =?utf-8?B?UnFLQzV4NTdaNFN2WDkxRzZRV2l4bkYwY1R0Z0tMTC9uM1Y0NUx0TUZ0Njlq?=
 =?utf-8?B?aGYvL2lVZGV2YlZ3M1ZqMHJPTDdmSXdDQXJsaTZXeWo3UGQ5c01nUDUzUUwr?=
 =?utf-8?B?M1cxNEh3MkNHL0FTNTc0OEhNN3ZJZWRtZHFzaUZBRmxQM0N5UHVrMWhLRGtp?=
 =?utf-8?B?ZVJCaHVFWHZMZlZyTldBVWZLeUkrVnorWmxkY1BEZ1JqS2tMdG16ZjNiQmVY?=
 =?utf-8?B?UVp5NkduQ0cxM0F4OVdmcUFBMndrWU1SMTB6UTdjY28zb2dXS3FyNDAzT25h?=
 =?utf-8?B?N1BHVnk2ZXlTbWZJLzNPRHIwdUt4eTBpcUxJYllXUm84OGd0Vm4zODlpdTNa?=
 =?utf-8?B?RTIyY1krNkZNV3NMY2x0YWFpamE3UnpDMytoVmFHa09UVjRjRUdWZTVnWUh0?=
 =?utf-8?B?VUNtaVNQa1VsMmNXYVFCRFFHcUs1bElMdnZuanJWQU9kNXJkVXNQcUFRaWNh?=
 =?utf-8?B?cXg0Y1lRbmxzbGprSTJ4YWR6THFtZGNNTEE4bXVZYTR5RGdBRmpsSUwyb245?=
 =?utf-8?B?UU84U216TzdNWHBNbnZIeGFYSFdqczNaQ3BWY2c1WDVJM21XYWFJYzFrSXNI?=
 =?utf-8?Q?ChxEAQNKbu9uOZW85saHuLQNwYVkoB2AaGSv1xq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3b30cd-438b-4f92-5343-08d908d0fd65
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2133.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 16:33:14.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXDjFJbStsh22wfMCaFa8hwHchb4zvFwHWD4Uiv9PlLV+mqOa7XowbNoOM50MavGBvi3phiVJOIOXR3tyQAkQQLSUzyFGAF4ws+jAotcNxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1464
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260126
X-Proofpoint-ORIG-GUID: SgPZf6lpFm5sRexD3QcqM6uqDqNAStMX
X-Proofpoint-GUID: SgPZf6lpFm5sRexD3QcqM6uqDqNAStMX
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260126
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-04-26 18:17, Greg Kroah-Hartman wrote:
> On Mon, Apr 26, 2021 at 06:14:33PM +0200, Vegard Nossum wrote:
>>   static void set_io_from_upio(struct uart_port *p)
>>   {
>>   	struct uart_8250_port *up = up_to_u8250p(p);
>> @@ -2151,6 +2178,11 @@ int serial8250_do_startup(struct uart_port *port)
>>   	unsigned char lsr, iir;
>>   	int retval;
>>   
>> +	if (WARN_ON_ONCE(needs_membase(port->iotype) && !port->membase))
>> +		return -ENODEV;
>> +	if (WARN_ON_ONCE(needs_iobase(port->iotype) && !port->iobase))
>> +		return -ENODEV;
> 
> These WARN_ON() will still trigger syzbot.  Are you sure you tested this
> and had syzbot verify it?

I tested it locally and the WARN_ON()s don't trigger -- presumably
because serial8250_verify_port() is called from uart_set_info() before
we get to serial8250_do_startup():

         /*
          * Ask the low level driver to verify the settings.
          */
         if (uport->ops->verify_port)
                 retval = uport->ops->verify_port(uport, new_info);

[...]

                 retval = uart_startup(tty, state, 1);

At least, this was my intention. Although now that I look at it again,
it looks like this check may be skipped in some cases; is that what
you're referring to?

I didn't have syzbot verify it -- I thought it would do that when
submitting my patch. Looks like I need to push somewhere and ask syzbot
to test it using this?

#syz test: git://repo/address.git commit-hash

(I assume I can send this privately as long as I use the right
syzbot+...@ To-address?)

Thanks,


Vegard
