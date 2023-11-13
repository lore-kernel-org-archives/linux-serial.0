Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5F3C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 09:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjKMJlc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 04:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjKMJla (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 04:41:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B79410D2
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 01:41:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fE6gW35dHJmuObAlK02wPVdDYMpXegS5xj5vW8/TDk5O1YozGNHx7K9nLG7YZ3mr7yN7mrOJ1WTg/URg8SI44GcqnzbBj9oizZwsgvdpf55+jKDKKplAROlq/BGu8X+bCHT8woLGMHmqmdxBFCsCpJaif6V+udpuZHdlDvtfdH530Cj+dCVM8hSWMJq3h7fA/gDP69UpXt8sdDQgF/cKYmTD2QOXI81Q3EITpKb8/rS9vhm/nfyVhF1lOJtFZRbm87+43jEYyOGYH+uK9QNd9CGU7BgJEZpahQsD85u6PzDp8OwhYefrYxYKkH+Ift8lVUm92P6oUEjScKN5e4pvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dWFXnPrR6JNiKh4ezu5BDmicR3TO71krVuXwe4deME=;
 b=dV2BEQ+XecWM2w4els9Yjn4JX0k0FCTONP71AfbHJmEWMX6REWQFHL6jjXSp16u9kN5rWktOKuaEOcYJEMFDwEw8pDd1RkO1hswHaLAIgJPtykU6227CH0tPdjpmTX9R60tARt0BNSjFpEnWlCdxSFBstVw6k4cKiLHOXFiUQUhhrg8ZLRQqcmSaBeo6aR7YAiUdfGoeJqO7qs3cHeooghPj5wjtfKmM3urKZBWsPt/RCBEquo+M0oWEN3aOz0hMsnvrJOQtTtQpTWJ2oEugViYHD6NNR6dNq0YzST9LY4x0sbjVMZA3S8mbQSrIwgGYLH821U2EoCHqFKfnRKUjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dWFXnPrR6JNiKh4ezu5BDmicR3TO71krVuXwe4deME=;
 b=KPnEET0rg7PIWewYpKiapvkWUFtgZ2WQhwnFg3NLMR3bNxtD6Q3Ya56rVwbKP5c2joaI6omfhS1hyezEuknVBtgyqeV2jashCEwODeMT4ZYSSyDAlIryyhlPinBISFls8Ii0Pw1q7jcvxafUW8kl4voVfoKDGuDNqKYAW827i60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 09:41:23 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 09:41:23 +0000
Message-ID: <15784357-6557-4431-a1dd-128152b48160@amd.com>
Date:   Mon, 13 Nov 2023 10:41:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 52/52] serial: xilinx_uartps: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Julien Malik <julien.malik@unseenlabs.fr>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
 <20231110152927.70601-53-u.kleine-koenig@pengutronix.de>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <20231110152927.70601-53-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0245.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN0PR12MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 589e4887-ea22-41b7-f656-08dbe42cb2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsNkqs9FNcsm+CEmfoKCndCI/eAOkf/7uDLgjlIbu2Q34qeZGSWpZv53nKVYnyTtgXmCnCsKDG6Ql96HZcjy0HimlJx+blX0BvLRxFOtenJhEPkC62cdH3hsZjdj9Pv9d0GfoKkR6JdvNIHIIAS/qDwarR518flyzpADPMJPXbxWDXRnVk6CjgAJYdIdO6yXI0AWju/VJVj+thSsiHgeswFUPD9j6DWRbXoBRtZnX5B3d+6plNodH1gPQmafO2jJQA8d+hD1e3gQOvGvF53SHEZAAuIsqurN3yngRkk2+BgayU+NKuaOEipqUvNxtm85RTKGfMQE79yfUDEuKZvWIoIxh6phrBBH1cvMuGVL+6BtBHmzCNufl7ZqpFbcDCdqMaMYg/uS08JzrrYo/mW9o7RZILcUCCWasbCijIWoUFQy3oGFUleKxOiTwibljBLShZ9yYkVbKnkqBQB4OKdA3vTZ2XulWm0UG1hMh7VcS1qLNIe/gDS6g3SQ8f3mpd/OP2dF5FLIt6Bo2XLLFHt1BduxOwrIxUeWpbqrQJE9it0vtiwQo8cdq7Bndeq4+j18Tm0ItiGgHVJs0VFvVmhEQww7NGu6a1etl/6tGQE+wig/4/69pvnRTdtlr4TOXXNoSA+b6yt0x+X59L6zFZZwVkfI6Fh4BGbC5h1ft41Wh9Phz5WJwVxSEU2AoxSS0kry
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(2616005)(8676002)(8936002)(4326008)(44832011)(53546011)(6512007)(6506007)(83380400001)(26005)(66574015)(31686004)(6666004)(6486002)(478600001)(110136005)(316002)(66946007)(66556008)(66476007)(54906003)(36756003)(41300700001)(2906002)(7416002)(5660300002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJZU01PQnlmcXVSOUFxTDhwTDZ6bWVOZ3kzZnhuL3N1LzhBd3ZOZUQxUmRC?=
 =?utf-8?B?M29CVDVJWk9vZXJiNHg4K0JZRXNtMlBHRVJDd3FLVVB5VWszZXFBQ2g2RURF?=
 =?utf-8?B?MXZteDVQRWZUZWVVeUlsTVNSUWdPWjdnTEZuY3VkSCtjK214Qmh6UmZFalBl?=
 =?utf-8?B?ZWg5YjNCaEdvNjgvayswMWtQaXRXK2IwNFMxMS9qM1BwajhOd3F5dGQrc2Q4?=
 =?utf-8?B?Nk5JWURGbFBTbnJqeW5IVHFIY2k4RTZITDRRbDNiOUtITXZlTm1zMk1qQkxB?=
 =?utf-8?B?YzJ1SDVWQndIVXdabjJTMzkrdjdxVDk0QVN2Y2xBdDFOb0ljc2t2K1krOVo0?=
 =?utf-8?B?cFRGbVRrbHhqWHdNcmNpbFZKUmVJRzV5WWVQbXV4enBZNjlDcU1MNy9mSG5h?=
 =?utf-8?B?R2VHUkNnbkxvS2tJaUxPQUVJTXREZ0pyekhpUXZCbnpFTFozZ1dJZ2F2ekxJ?=
 =?utf-8?B?YXZNT2Q2WCs3TkFhMEx2WXpMYnArcU5MNjdGcWFtSUFiOGZWQlpEbUVWc1Zr?=
 =?utf-8?B?LzlIT1BRQU9zVU9CeEpabjRic3RqckFVekdsYmJ5N3NxTXdwOW5peENBV2NB?=
 =?utf-8?B?UndBRDhlTjR2UnB3WHBRd2RsbWFWU1lvejNBUkVpdlh0VzQ2OE9mcVV2bVdR?=
 =?utf-8?B?VlRzVzR0YTlKNk5FMGt4QVRLSjZLWUpiUGJXNDBqalZWZXNuY2tpQS84WVlp?=
 =?utf-8?B?QWNhTEIyUjlURElBYit3SVBoYzc4V2ZUVFlBK2t4M3RPN0VEZ0pLdU9NWFlr?=
 =?utf-8?B?SSt0dTVYVUNzbldiQ3ZFcGZPMFgwWVk0bVVYWmRJVFJMN0hEMXNOUzZLSm8z?=
 =?utf-8?B?eEEvaDIrVndMSlc5QjVsb0RRU3E2RXhWd0htV3RyYy9BbnhpWHhtS3hoeTFE?=
 =?utf-8?B?VWdFMkdRNzlUOVhZanZQcVg3M2hFNGlxQ2F6M2NqcnREWU5YZk9XdjI4NTFr?=
 =?utf-8?B?akZ5REM2ODg1K200bFdlUnBZbzNHMk1heG9uREE4Q0JoYTNrS1pVZmVmc3pz?=
 =?utf-8?B?OXpqR2pSTDdLVk1xeGFvcGVtRlQwMmRScDFrVjFiTjRxTTFkYklmdTdHQU1X?=
 =?utf-8?B?Qk4rQ3JnZW9DYUNabEdJRk1wNDg2NEFEWVBoa0RkSFNHRlYweUF6SS9uUmE3?=
 =?utf-8?B?ejgxWTRQeStSWlhaWDlXVFRKYmFQREZxc21PSlNnd3hPMS9seE1kNVNHY21x?=
 =?utf-8?B?ZVF5cEoxOE5XUU1ncWJaemREb3dBRXJOYUVRWW00ZXh2NWhVM21tYkpTc3BO?=
 =?utf-8?B?V09PY1g3MjVNRTRqbnZmNkh2eTZ0UUwzKzlwbHpJRmJ2UzlaNmFjaUNaVDZh?=
 =?utf-8?B?S1BOZ0VMRFBEZ1JONmYvMTdkcWNwRk9tUFU2aGU5S0ZCcXBGSHlKNHM3bDBT?=
 =?utf-8?B?WFhhMlpCL0t0Vml4NzlUU1ZPQzFDNVdtcGtpWTV4QkZ4aWRhOU5mUXZWNWJG?=
 =?utf-8?B?L2ZKN0FuazZ4RkdhcjV0RjBlMzFBb2E5V3krWGhoT2NNSUlUNnlxTktyM1Nx?=
 =?utf-8?B?WjhleVE3OXIrSnEvRkppcUN1MHJDUkFYbmFoRjgrYkZpSjlVNE1KK1FYZko0?=
 =?utf-8?B?bFdyQUw2bW5iWkJmaGttVTAzbDU2S0llSDFWUVI3bzFqSGk1RElaMncxOU5q?=
 =?utf-8?B?eDdUbDdtVVVOZjFYemIzbG1IUm1oVXcrTnlNSXRnckhuZVRla3JIZGFZc2xj?=
 =?utf-8?B?TGE0TFZoaDY1M0hqNDNWZFc1YWFBYWZ0S1dNMjdVY3VUdzdKanlQazJ3MEIv?=
 =?utf-8?B?UVB1cG82eFZVdHV1VUYvREhVN3UycmR4NlVzdWg4Zld1VG9FaWJzd0FveDZW?=
 =?utf-8?B?TlhENzRFeG9FWFQ5TTlFb2hDUWcyYTBTbmNJOEY1Q3hsSEdpUER0WUJtZHZx?=
 =?utf-8?B?LzI1b1FCSWY0Sm9LZjlacXBSWjZMcDFWMjZrcUFiczFTNHlzRHVzVkRYRGk2?=
 =?utf-8?B?bGx0eUdKVll2Y3RpNU9pYmYxVFRIckR3YkE0TitQQmdFUTd4amlSOUxGL2ds?=
 =?utf-8?B?bFBaejNFNE8xQ0NoamFhQzhVTnA3V0lucHBDVFYxSVpKQkpzNklqL21wZEtB?=
 =?utf-8?B?cVZkeUI2RVpBbnVHZjNNM2tQdjhLbThhOU1sVkI4bTRZTVlNbTVkdFZXb1JI?=
 =?utf-8?Q?65zmhvwSaTpMLH8YXgzfgFuKl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589e4887-ea22-41b7-f656-08dbe42cb2d1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 09:41:23.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQu+B6OQDLcpDD8tWOmW85l4jJDafGKIP+1Lq+8Rwh3aGrGfxyzbKK/lHWo8+HKG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/10/23 16:30, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/tty/serial/xilinx_uartps.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 66a45a634158..6decf2b13340 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1666,7 +1666,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
>    *
>    * Return: 0 on success, negative errno otherwise

this line should be also removed.

>    */
> -static int cdns_uart_remove(struct platform_device *pdev)
> +static void cdns_uart_remove(struct platform_device *pdev)
>   {
>   	struct uart_port *port = platform_get_drvdata(pdev);
>   	struct cdns_uart *cdns_uart_data = port->private_data;
> @@ -1692,12 +1692,11 @@ static int cdns_uart_remove(struct platform_device *pdev)
>   
>   	if (!--instances)
>   		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
> -	return 0;
>   }
>   
>   static struct platform_driver cdns_uart_platform_driver = {
>   	.probe   = cdns_uart_probe,
> -	.remove  = cdns_uart_remove,
> +	.remove_new = cdns_uart_remove,
>   	.driver  = {
>   		.name = CDNS_UART_NAME,
>   		.of_match_table = cdns_uart_of_match,

Thanks,
Michal
