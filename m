Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79427414A02;
	Mon, 20 Jul 2026 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550093; cv=fail; b=u/wC2lYwhWSOvXhMD/S5i/xRYHJwX1/HjqNJpdR/IVE+0fuK76hadgorOTkVbyyh8KA2fjetUBSbbDJB964bNR5dNHRFLgq4WTFPvHsEteA+LZqqpN8PfCGmGRGILbMuruW3TTl01tuiJwnvvy2mGvSABr31nkrYpohyrIhK0xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550093; c=relaxed/simple;
	bh=u0u6DoLLnceX9+XXJuyn7XqbzjUlHhIxVho4qvP36pA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5wggX5xAWARJM9gisbgW1e+gX86y7TiFnwit6SzR2E0C9ibBisS2cpsNU1qDZcTJXpcMOi/Exre7CCyfzqtvXzUnDEymIoNbRnWXaN6K0eno4yhWaGtig/V5CVeh7YpKtfeP2DBurNuWtfEn4iCVEf6fXbXEe0IgjzDi+s4qvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=GTCsIvvQ; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="GTCsIvvQ"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KAt5tw4115137;
	Mon, 20 Jul 2026 05:21:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=mJ8h98dxaYAD5cr7I0OHqtMj+smcsSIQf/VtkbcI4uk=; b=
	GTCsIvvQsoP4yj5/YYU0bk3a2enSN+XzMRloE1vaY+WVCgGHdabLb/9ztOhBHAVk
	ruxGBpQBx23MAQ7/KAu9FT+w5PL3qk5WzPYYOAcsgQ2utqt6nVahCeYyQnNcUuTP
	xtdhohW9x/pyBDrkCyGCGpi4hLEqu6D5gxxcMOYhU59v+3yCMz1zOClISYQhJYEF
	i059XNrzXe9TioOhl1o8ZMaGWoeI12UoaBiUmmL/EsDdsMIHUNbmkdW9m9o+WSXC
	JeXXEruMpnTepqMMqS5rvRC67VTOpNSk2qYug02bhLHVzjvEVpVursou5k1bxxRX
	bWLNJOVBkXO3EPFxi1N95g==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fg4ryj6yp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 05:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdC9PSHalrF39jIfE+6e1Eq83QTkMUjKeLpd/0lsbbLUW4wSOsw6OfvDFRzFJivTA7h660GZJX4dOz4cx8yo4a7z0L7P+6XGa+n38hQVOaKI4jqXW7Ic9nE+eZxQYlZARsjooX9X0En42ciDYZg5hAOb5S8ka1GrKux5+G3TH2YPdmZ4ohwbFk9ZMIt5Hyfml5zl++TEKDRPbYZLOt14PymIgCEgvtrmncB3emJ6QoidofMJEALbzzu/ZMtyHzMnpxzFrMLYkwA3ED6rPqGkujQMR9hjQGMBvhhMzWTgnXVJb8bhHY1xPAoEiZSuagCiyrfFsmgvARxXSpCj6dVHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ8h98dxaYAD5cr7I0OHqtMj+smcsSIQf/VtkbcI4uk=;
 b=GZ1OMCT+IE4qORja4bB22PbtLNqdITdn6nNYF8y2hObZQV1FAh5iwNlNPhp87WPipfpGvj58D7gNhkzJvUZsrKTQRSEFuQfQRN+g+ZUIsQ4EZGKAKj1EzGgSjCQ9SnsyF5c5FR1HWAHCK+qlD33lpQCsrvI4L4VVt8BG5aHvWiFaIUYakK3o0B0ao3fO6wQoysKVWX6e0cJG6fFIrIpeHfvXyKSk2oeCixUc6RSZCMFEU4JUtPacghvdvInqr/c7i9NEngdEHutbB76tEdn0hqvzQbnGpI1KOC3UmlZfga7S35uum7FwhiKwjzkk5pd5H3OMK/fYoKnSXfDRQevayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by SN7PR11MB8264.namprd11.prod.outlook.com (2603:10b6:806:26c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 12:21:08 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 12:21:08 +0000
Message-ID: <fed8272d-dbd1-4da7-94ac-8427bfa75c04@windriver.com>
Date: Mon, 20 Jul 2026 20:20:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, socketcan@hartkopp.net, linux-serial@vger.kernel.org,
        mkl@pengutronix.de, linux-can@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260716064719.1401892-1-yun.zhou@windriver.com>
 <2026071718-yearbook-bloated-48ce@gregkh>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <2026071718-yearbook-bloated-48ce@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0015.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::9) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|SN7PR11MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f54faa-0e52-4098-61b0-08dee65960a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	0xjNboiexuQAH+SZeYiYvjY77hocVRH1Lmw2FBPCRTmwF0eKDxPV5TrdHzoZbqqzpTqaZq/kH614iE/Br3ODU/NEqfAgPr4tHq8cUgVu6YikgFJUdg8O/qOcJXMPxvJvfOE2WSr5BRTIrmW2PlCc5lmkZgfYl1aYgHNOQCLIbP16BSOdOlHp5R1VarzWUf/stjG7tkkT1WVMcKtQ6HtoPXwzN1zXg9w852UGGpUh6/jzafRxHT3Zq0HFb+GFFAlw6EsMZO6H90bMLcxyP9ubNR1Zjw9L/xEj4rFS3VgpG5CwK+KItzKnWx+TG9WURwodz0URoyVSh5oOtmYGiSlxShqYQf88aVXNIOOXJbgsTi5lIaD2mx8FS5UUD3R9wNA0XdqA64ab9b393nY1xki9pTI0WGNKDb2MuCqKLIlb2jnA+NiCAQu5Goihs1nBEHB4D7PRRG7569IZU/SqLlFWvUVLEcAubZ68O+9o7ADr9ZDFIe3fYmLOkb2+LP4SYxFTBiFbd7tzlu2UeEWNYJA85YKYVT0/N/r6xRT1Om66dTRQsHIoxRg1qF4j+4AsmBpyBobyiIUgFzw7d5omX6/SSuDFkBu4Izchvin/k9OCag0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elljUUdUeGRqVDh1dDBjeUF1cDBxRTF2MTcxZmxYbkZENE1NVkJPNnBsZHU0?=
 =?utf-8?B?SjRmVzdtT2xvOXptb0NZWUR0NktjUjZiMUIzeGZBOVh3V2hKRUdVT25PT3lU?=
 =?utf-8?B?bUhVbWlrRjZlT1pCcnp2YUJVenRXWm1hcTZaaEkwcjNMMFlVeHViSHRxZWg3?=
 =?utf-8?B?ZThsb3B5bWRDS1dWTFd6UkxMdUo5LzdPSzNEcUFYMUUwYmI1NFFyMkNrdzZp?=
 =?utf-8?B?dk9USENzVFpxVHlxbVp5dXFkeUx3cHlESDkxNjZ1Snd5cmlpRklIN20wbUhJ?=
 =?utf-8?B?ZjRMcVFuK0RkRXJXVE1iaXAzZGJWbW1PNm5VTlAwU2ZXeE5xY0JYQmlUbmJN?=
 =?utf-8?B?bXk4eUtPZWlINGJDTlV3QTBFK21rdGI5YVNNOEsza0pBUEY3a0VNQ1FzcWFo?=
 =?utf-8?B?ZVUxdlBBakJHNzFmUnIyVTJIVVFBdERoWlJtREo3aVZvSDMySEhTaGVLNUFi?=
 =?utf-8?B?WTVjczMrcDhWdEc0ZnFDeFZoa0pneUZvWkpod2orWG1oM2Q2SmdudWZVVUJG?=
 =?utf-8?B?Vnp3WWNUTm9HOWZiKzVaZEtIcENrZytkeE1Ocnl1MU5sYlhGZ1ZEYnNsYlpu?=
 =?utf-8?B?VXNpU0VyaHMyUld6dkFHZThoeHN6bnJQeVRpakJSaWdSRHJjbW1oVkNiSDBV?=
 =?utf-8?B?MlkwRzc2SHRjTFZBVmVXS095a2RnRE0vOUZacmd0TFFwMWRneHI1aHY0enR3?=
 =?utf-8?B?U280N2ltQ1VOTzVqTWRGRzhOM0xYcGwvUnkwUFBrS1VQMnNRb25XQ293ME9Q?=
 =?utf-8?B?VXRkSWZON29UTVZLM1lxdE81QnVTSmZuOUlxZjFRc0U5Si9pbElwRXp4b1B3?=
 =?utf-8?B?ejNMT3BBcVMxVFBraFVOUUliVDRRMXRiY2c4ZFpEYlpqaHcwcDlUMzFYRUl0?=
 =?utf-8?B?bFc0RVJ5dGwwOVZkWjlacVN6VGxaTVV4R0VQMEd4QUZDWVZKSHd6SmR1Tjh1?=
 =?utf-8?B?MHhaZHJDTUR0eGxuZlVpZEx1eXE1ejZHTVRNQkwvR1F0aGNuWlB6Z2JZWHMr?=
 =?utf-8?B?Slg0aVdZMVNPZ2lGRnhvTWh0K013bFdyRU5ZZ3MrY1pUM2FMeWxua3ZZYlRy?=
 =?utf-8?B?VTJ1UW5VRWRtVDVTdzEySDNNR1BMY2pXc21SbmRwMG1BT3c0Q01ZVTdQUGRl?=
 =?utf-8?B?SkNoU1dTTm13d09rRjRDdkdWbGtSQU9FU00wWlU5VHlvRWhlNTd1dHF6aFBv?=
 =?utf-8?B?cExzaWh4aFMrWFovWjlFQWtITHZpN2pVdnNuTnZON3VRVzJiaWpsSVJncHhV?=
 =?utf-8?B?Sk9mOTdZZWNRbDFqWVU5YjVKUEJ2UDRBUzlsRG84TE55QmNZbHNrWGtoRFhv?=
 =?utf-8?B?b1BRdFk3cGRVUENhZFBnT3ZrMnZxOUZRc3JFRTJSNjRWVXM4bUpzZjlPbE04?=
 =?utf-8?B?VVRsTWlMMXErUjUrNHdtOVFpZjMyVVhCU205VldDSkdNOWtmNFFrVHdmUFkr?=
 =?utf-8?B?eVdvMDdXb3BVSU9Ta1llSjkyS3lENVRkaE8xNldYcnlKaHR2QlZOajA2b0h5?=
 =?utf-8?B?aGczOE11VFVaMWZtdEhpZm1XWG9BelpBU0tKYXBOcDFaTkJxVnBhTUlUYWYz?=
 =?utf-8?B?RHJwNklzZ2JDSEdBUzhLMDlwUDdvb09XWGJTTm5TbGdXMXd3empHVDZLank0?=
 =?utf-8?B?SG5wc2ZPdnhTdDE3TW1ZWGdoSXZzK0FQcEhHS3FnbjRjcTFkUDJ0aEZvV2pS?=
 =?utf-8?B?VGV3ZkRtZU9wZjJra25EL2hqV3ljdG5WNXVSWWVpZFREVDhFWEFsUXFoMXRP?=
 =?utf-8?B?NVNJYkhUYjFPcDhzYUxWcXhFUlNBeHczTmZkMWdZZmNVNnRrT3N3bkliaStV?=
 =?utf-8?B?OUxTdnJzbkFhM0ZaMUo0Vm1UazdWVFJEU2lKVXFUS0twakUyakVrR2VxNlBD?=
 =?utf-8?B?Q2hjYkhNRkszay9teDdkb1FNSFpFWXMxdkgvUUN2djUrRlhRdnY4Y3JMQU0r?=
 =?utf-8?B?QzVyQlJra3A0YUg2YTBrODJhSEpVb3p5NUtYYm94MUFoUG9BRzBLNjJ1K1Yy?=
 =?utf-8?B?cXByaDhKZStudjNKaURHbjJObEtRb0lVbVJKaS9oOW54V1Q3VmhjNjhhL1gz?=
 =?utf-8?B?aEJiNW5UN0R3N09IcFc4emc3TmtoQnlwSTU0aHYwU0t2ZDRHK3RoNW5vQ3hO?=
 =?utf-8?B?d3hSWkdUZXNYOXJlTWJJVHBsMWNDYndXaW5nc0drRTFYVDJWSXBseXB1ZUIy?=
 =?utf-8?B?aDVzNEhtNENnZjNQRHhEQm1MMTJQYW15WW44VzU0TzVxSDhmaW50Njd6ejc2?=
 =?utf-8?B?aGZnVEQ2L3lFRm1hUU1jT3dUcG0wVE95dDlJZUtlaTNXN1BqMVQ4RjN4Q1Yv?=
 =?utf-8?B?bHpZcjIrNng0Z3BiZElDcTJrRDd2MEpMSi81NnViblFFZlZ5TVZJZz09?=
X-Exchange-RoutingPolicyChecked:
	BjT4pUWecjadpaPLivpZ6DUHhFeYBxzO0dCBV0c1010uAJOSGox2Oe0tUDTb/e+5aZ8KcwmUZHC2530CicAljNCTByOz8itmqUhde/ApFWbpFi8Iyvu+Q6SHKT4OtQhIJZ6uor+XfhTMrPsGnsGIuXB2I38BBBGT+zBip8R2F5joCTZOFFyTUCWptTry4PsaGTKXV+j6RDfAPbKP5Cryy08CYh7mUTH8Izf0Vxmahh8EmR6E+IMyVBwSnFLptls7J/5N6io5fou6Oqk5XuNelKdoftmndigkU3EJlN4svLiYJegch8e/iDWhNbqjKSfcCcFUwhpmirdwv/ykHMojYg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f54faa-0e52-4098-61b0-08dee65960a2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 12:21:08.4425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnAmJC5RvxohhJ/RQp0uDJUv71BlTQwj6Gm1fypDTxAGfYplWg8nUUVtXU7XkIjGQ8nDYo6qsH2AGhP1w6Pg9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8264
X-Proofpoint-GUID: ZxVIF9sBfBvASyK-nufBbQ9moip7R4tn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEzNyBTYWx0ZWRfXzKbc0EBkLuFk
 itoDGidHIIo+h7ry312a3mUJIkliV4jZlSWCpdJ3rUlD8DFf5RSO8x6D3OfJEtmj0ZGasrMcj7s
 fRvj+f2/zvvMyqr+PsJUdw8Y/0yBJnzpsaedfz22n4r4W/QX/xLR
X-Proofpoint-ORIG-GUID: ZxVIF9sBfBvASyK-nufBbQ9moip7R4tn
X-Authority-Analysis: v=2.4 cv=CfQ4Irrl c=1 sm=1 tr=0 ts=6a5e12b8 cx=c_pps
 a=9JMNuyHA4Bc1wrbCcMLwMw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=c92rfblmAAAA:8 a=t7CeM3EgAAAA:8 a=yuMFhARStObQBeVZpbEA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEzNyBTYWx0ZWRfX7sfoFOFkNUPp
 Di8AalTjIT43Tr4+pRmPSuZH8cmOWEliQuxNVJRNXleND+5sQjyhDatNgGBRRgMvrsNjCuYGiwV
 3kW4bOJohZRdtkWebdNrNWiCZo9bCGFC3NKyxO9bRBRRECZiTuT4FSES8SIlAFUEXDKt1kwArmB
 5gY1779XuUyT0VPLo8eFmSgDkWE/WWmIcFEkZXTAOpw8dTkccqWCuzI7SSBx93wl7FhH+d9Z8HI
 S6rRUygCL89Ln+GxZO3tQ/BmCorlB6A2Jl2F0heA26Ln2i4cESM2Oq0YwhuEweKP8es2LXS74R8
 saAWr9VS0GL36n6xfP9XudVtEzcqRvlYexcr7Dn8t6bG7tcMCfl5M2/iJvvuZBr91qiwobEAHjZ
 uHQYz4V8rb1mRkQAUlJcunrjO2Qi+cRTS+Z1lOs3NE7F3ocGGG6YzluMVm9Dpy6OlXCAR3Oy5+V
 lacFMAgL9gL7McqbpXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200137



On 7/17/26 18:53, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Thu, Jul 16, 2026 at 02:47:19PM +0800, Yun Zhou wrote:
>> syzbot reported a circular lock dependency involving tty ldisc_sem and
>> the networking rtnl_mutex. The full chain is:
>>
>>    rtnl_mutex --> nft_commit_mutex --> ... --> ep->mtx --> ldisc_sem --> rtnl_mutex
>>
>> The last edge (ldisc_sem -> rtnl_mutex) is created because tty line
>> discipline .open() callbacks (slcan, slip) call register_netdev() which
>> acquires rtnl_mutex, and .open() runs under ldisc_sem write lock in
>> tty_set_ldisc().
>>
>> Fix by moving the .open() call outside the ldisc_sem write lock. The
>> ldisc .open() is initialization of the NEW discipline after the old one
>> has been closed - there is no need for ldisc_sem protection at this
>> point since:
>>
>>   - tty_lock is held throughout, preventing concurrent tty_set_ldisc,
>>     hangup, or close
>>   - tty->ldisc is set to NULL during the window, so concurrent readers
>>     (tty_ldisc_ref, tty_ldisc_ref_wait) see NULL and return immediately,
>>     which callers already handle as a hangup condition
>>   - tty buffer data stays queued until the ldisc is installed
> 
> Ah, but look at the review at:
>          https://sashiko.dev/#/patchset/20260716064719.1401892-1-yun.zhou@windriver.com
> which says:
>          Does unlocking the semaphore while the ldisc pointer is NULL introduce a UAPI
>          break for concurrent operations?
> 
>          If a concurrent process calls read(), write(), or poll() during this unlocked
>          window, it can enter tty_ldisc_ref_wait() in drivers/tty/tty_io.c. Because the
>          semaphore was unlocked here, tty_ldisc_ref_wait() will successfully acquire
>          the read lock but observe tty->ldisc as NULL.
> 
>          This causes the reader to immediately return EOF or -EIO, potentially
>          aborting userspace applications unexpectedly during a line discipline
>          transition.
> 
> Is that not true?
> 

No, the issue reported by Sashiko does indeed exist. I will fix it in 
the v2.
