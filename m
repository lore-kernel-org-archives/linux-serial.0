Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338EE321420;
	Fri, 17 Jul 2026 03:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784257486; cv=fail; b=fOJXrAcsGypsYWcwsaeafT0H9aT9rp/j+2pYBOoAMBZlaW9rRKz0WLFEkpUxoJr2qTrPYbpZGlezqPHwxPWEJzswf21K6KctUo1pk5VCEw8IKoxEloB04IOVvI1yuBlhPQWeU1uiWS4esChniKQbddjieO0D5ilqyuDAkeHk594=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784257486; c=relaxed/simple;
	bh=FAoqI8iY1f5ZWOxpaeyo0pD16X5FrT/aw2Or8CAY56U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jOMwpEBG0R+RWK2uQ8KnMimsN6qG9YOry9s89+qqr8ASYpvVp2YzewcfKxRzLmQK8bXDQuBITR8cU+Z8TIy6YE5sIxBhO/HZGFz3ONHVRe2nx+arqoVR4atNL+iTwoQ08sq1gbXL2nab7/mbM133c5K8Bd2Wknqhnt0Omi443+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=p6YVvO+A; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="p6YVvO+A"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H343ve296883;
	Fri, 17 Jul 2026 03:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=OYrSn1zaqR0rZKjM7lWgu/VQqXRhCLyRXwShvTw32+g=; b=
	p6YVvO+AcvZ5Dh/nvdBlsNWsV8wRNcBA3k6Mjq/RgksGONm/wfa5BpHX0mgw7JvP
	KGqFXogv3lPc9XAQgktqGRpXLuSICVnx8Fx5LnjVgNC4P7s2Fa7GZdFDQBBKLVVu
	xS5QaYzFrkFXaEOdDF5LRL0GZEpXBpP+NY5l++pLzw/giCWChrOluPg59QcLaLnp
	4igHABdvNpANwV7gATqs0XFGK+m/FLlmPDTJM+N1MvoYwSg7cBffkmGGHVjtUv8k
	c6n2p8rsjwXm0+IJfVIE8Hpml7SYbjQNqdLbYOZTQkUeNPS05kYJZDIeiSG54rSZ
	1iAEv+4yMAUOLyjmEwkoyA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fbcpn9cdx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 03:04:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stdYzshP0VtqKPVVOvfJXvYTHmVXVwIi4Ngev1vsRDOztGnpKw/evuOB0nRwZNpqkZpG/8qhxmMRaky7BT4Epzh7rtm7a6HRqCNeYIqys1Tr4Gd/HFyFZXgx4sQHp9i8ZPuw/O5VnZzjcc4Er+H4d+hNHlWkH8eHImyTm2cczkyXviAGZaWJCXhIUNoLK2mtlRmXMMr27RjzR+0ShoD9ZQnefMoApTkfzfa2572tWBalaBG6gORFD7Z0Q7ZCG5uokwbj4J82cJerHNFwn88x9iER8W+cCGo/V2sENaXvJGLEiuVTVlpMoQgmnqMMOveYWQCTFLApfkg1hehDYsUo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYrSn1zaqR0rZKjM7lWgu/VQqXRhCLyRXwShvTw32+g=;
 b=oojitQTRLreoagSIlczbNyttkFKIICKKelUB4EuUL775R+4PhIoqAzpBolbKdyDfLF3R6tZk3TSHj/AOSsF1NzX6bqT6ziU9V3VoaSRuzCf3sDIGBg/ELSPv4NK3//0PsX8Fv2CW0xvWr0IUmBM3MeVjOhH7AwTbSIHOv6s+LtkolrihRxW5NfmsjiIQtLAt0TFKHD7BtwPELhrTYg//GtR6l5DBUHswHfgexo2Ox9mwiVYffm/H86jUgEPFfUuLMfXItLl6D4JL+dl2hpPu40GszeZ8mQKQ87MA/Q9oEukcFnFJV3FLKJsQ37teBzcFiH/epYO+Pd0WNLHFZZRxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:03:27 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 03:03:27 +0000
Message-ID: <87ea3ae8-8196-4f6f-bb03-d139f2f6c806@windriver.com>
Date: Fri, 17 Jul 2026 11:03:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
To: Greg KH <gregkh@linuxfoundation.org>, sdf.kernel@gmail.com
Cc: jirislaby@kernel.org, socketcan@hartkopp.net, linux-serial@vger.kernel.org,
        mkl@pengutronix.de, linux-can@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260716064719.1401892-1-yun.zhou@windriver.com>
 <2026071655-steering-cardstock-cd06@gregkh>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <2026071655-steering-cardstock-cd06@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|SN7PR11MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: aabb0545-4fcb-458e-5c86-08dee3aff8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|7416014|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HU6pBclgqFOIr/kkEjLfYaDlFmXlAmbCKO4dXeHuMHYe81E8s2v9Z/pBaSLSgANjU7VQnq/AtLUsZ3nzMwC+pTXfV79rLVMLrlRM6kqQAnybEhFVPrtSxCjjRbUd48lhyE+4rb4jLU7ySa3BYLmfD8+w/zua4rFLJX+2jlcxlv/nLedlV03WvSqa461t4zahBXLDIyS5rDL0AaoLgT3azj1Cq3A9mNEb8uTcrRhKwvOEIpW2Nc+ofKUnCsHZNHTid53/SMtQoSgwryB0pKhscRG3FF3S0hEFQZjw3gg2i/puNJp6kHJd+SBVnDxcgq3AkOhvlh2xzLOo8xZTQUbJ5U0i2UQ85CmDoFWJ+hg0zy2iZs4oDYLX2Tk6LhZsdyW/zUDBxDbHiHLiSbrRi55rT5BBvOYxjjBWzstkxR8z7fI0r9h9RLptZkK9RSTK0ds8C0FOPoUaw5uw5/VfkkO4tZiNtFzLHMUkKk5q4XQyGFwb6yR1ZE7l8wS2EPi3T+Ud4USBRn9KzrEzyUBBUSEZuUvC9jPBVslBbpMXOQPdPsvoid2N0kKHdrEt++FUnpwy+TEx8zg126LK9bbAlYQTOZoLL9FhiJwh4XSj3v6K4GunmFf4StJGkCxdI9Ssq9o1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(7416014)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2RYSTFwUXJTNmVIKzBwMlNpYUlxRWR6V1M3aDkySWtBSmNSWmZFRzFsQi9H?=
 =?utf-8?B?cTBiVGNieTV6Unk3dXZjM1gvVURvVnFFZU9vUnN2c0E3QVlEUHM5em0xSGxU?=
 =?utf-8?B?akdENWFGVjRvUjQ1Wk1HZE1oei9PcWtjSWUzVlZ0UHQ0N082eFJ5YWFBZ1VP?=
 =?utf-8?B?bjBIbUFLcmo5YjNtcnBGKzFFYWpQaTliNjd0WjVRL1Bpa2laU1JsSFdsNHM2?=
 =?utf-8?B?bzhZVnJleHRPT2g2aDljcG1EY1BWVXc2QysvbGMwZlNpMHhmeGp2MythdWxO?=
 =?utf-8?B?bGlxVGpzYTFrYkNlZWVaQUVESkxzZVEvYUg2dXJqVmlFQWNxOTkrWnVjOExa?=
 =?utf-8?B?Mzg0Rll2NVNibU53VUdQTUIzMkdMQ25JNmlTbFZvTXpYVVZEL0dNRnlLOXJq?=
 =?utf-8?B?WFpTV3hPUUVGTDh0MSt4ZzE5bkJNa2R4NGRsZ01RdkxoQ0hOT0xSVEhYN3hG?=
 =?utf-8?B?U3dWR1Z5eGRncVA4eXFUWmUyLzBUVlJzaXN3d25SSlRsZE1yZjlOOExjV0hx?=
 =?utf-8?B?WTc4bCtYK3h5b25keUgwYW41Nk45Rm5rQnNKWXhOckZURTFGTjltNzRWZUVu?=
 =?utf-8?B?QVlLWkFqQ2hrM2pBSWxhOVprc1U4N2ZBQStpY1BJR0xFREoxWGcyVm1wNGNt?=
 =?utf-8?B?RmNiZHowL3g4QU55UjU2c1ZrS2lHMm5IM0RkSWxqSDlEaWtYajNzMkF6aS8x?=
 =?utf-8?B?N3RndDJnQWxtV2JDYWY2Vlh0YkxqM0lWOXFwNEZSRVBYZkQvMVJuMHJFcHUz?=
 =?utf-8?B?MVhPblM1d3JST3NlbmxqRFJsb2NyaWQ1SEwwWC8zbDBWSTAxblRiQ2c3MFlQ?=
 =?utf-8?B?UHRla0R0dUFIS2VpRnZKTHo2dUthQWt6eFVuR1dvdTFadkdLaUhhV3ZVbENw?=
 =?utf-8?B?NEJ6MXFQbzBNV2l2OVBQdFJDTzJicktJTm14eTBGYTJ2ZkU4bGlqVnl4Z0NO?=
 =?utf-8?B?VzR5YWlRdVFybDRrT2ZyR3ZpV3BRZ1F4UEFJWndyZldjRjNuSkhoa3JBUTNL?=
 =?utf-8?B?MXB0WUZKRUtkejZJZDl3M0w3M2JhQjJKM2tjcHc5QUlrcDBRU1oyVExrTi80?=
 =?utf-8?B?STl0MldkcElFUzRqeEZncHY2QmZ3MVp1bzVDUVV1UFRGdjlzVEVYeld0S0FY?=
 =?utf-8?B?S0RNODN1c2w2UUxqUlFNSkQzOGdFUmJ5Z0J0dmovdTJUNUUzQXBVVjZvTGlr?=
 =?utf-8?B?ZGFTNUN1c3pmR1YwL0Y3UGRZMnR0b3V0Y3hOenhoSmtVQ1pySGQ3MUhsWDgw?=
 =?utf-8?B?eXBZOGFnWndsa3Y5bmtQdlRGSTdjRTh1ajhRTzg4a2t4cmdXUXFDZTYwcHl4?=
 =?utf-8?B?YnJSbXROaTZxdGpQcEF5VWp1a0swQmltMmhkNk5PNkE5Z3QrU2taNUdoTFFz?=
 =?utf-8?B?UG9kZHhPMUtnTlZtdVRVOWYrbkxBNWtLUElGUmVpQWhNaG1KT0YwSDZTREx3?=
 =?utf-8?B?dzV3NVh1aUJzVEU2akJNeTNuekIxdkk1dWRXakV5TmJGaCttaTJUSXlKamx4?=
 =?utf-8?B?UWFLSXROTzlEOVNCTU9USkpsVXA1eFlrUUMvd1dmNlpyUkw4NHcvaUZSUmYz?=
 =?utf-8?B?Uy9aSklOaGd4amFiZlJDU3JzdENya1Q5OVBxRU9hQ0xHbjk2TkVTZmVDSjVv?=
 =?utf-8?B?MmphTlVNb2dCbHpGcjRGNklRS1Vmejhwb3FvYnZmdXA1OUxqNkRPanZ6c080?=
 =?utf-8?B?YUY2YWxNV2srNkRJZ3BiMStQd2R0eVJuejFUczZMY3c0YzdTSlkvR3VhWlQ2?=
 =?utf-8?B?eGYvTWxJNWkyeHZlQndjZm1iZjlscklzYktIKzdVR3NEamt6K2x2d3VKcjNW?=
 =?utf-8?B?L2p0WExJSHNCK0E5MkMvT3p6TmM1eG9OWTJMY21zcXZFUkNaeU55YlJIbmt0?=
 =?utf-8?B?QlArNFlvQzMrdVpQRHBuSUl4ZUJBcVVWYS9XVDcySkNsVTZjSklTMVNpb2t6?=
 =?utf-8?B?NnF5NWdDUUVPUlNQRmFXdjhPKzZKSm8xb1dyMytENWhZZ3dtekw5bjJ2aHdj?=
 =?utf-8?B?blNSU0xNTWRkb2ZkLzk2WVRpWHg4cTdlSTNqWWlRQXZkV3RlcGtqK2ZoU1gw?=
 =?utf-8?B?SVFNQVpVSjlibXh2MUFrb05pT29KQkNiNzdtMTI0c2RUVm9OMlorVWVYYzBp?=
 =?utf-8?B?WUVDQXFhVUZ3dmxlS2xKNTF2SEJqeTBPZXFYeDBleCtIN3d3WURKNzZ6cFZ2?=
 =?utf-8?B?RVc4UEluUU9HY0IwVk8xMW95UzBJZ3k5SlBVb2I4S3k2THYxSjF4UlNsRUh5?=
 =?utf-8?B?dGFSQVphK3QyTmRrL1VQZ2MxWUpER3ErU1FJekZTREd5S2JWSFAxN3hHYkRG?=
 =?utf-8?B?alZjNGtvNlFlSWQrZVhqL3hkaHBDZjdMSnBWekpZV3NJY0QyRXdxdz09?=
X-Exchange-RoutingPolicyChecked:
	owUqzn1LwF0V/V1nUBKct3WWQveWzoJb2Hm3lZepeNF4wJwkIoWxGltSe1epVAmk3P11X2+eJd926wP/dGsTAwppzfxOS5VHKtAYZcRoU8hDfuVCSVmepYH2VNs9MPCJ0yyAzTE84BWXoNWepvQcFEO88vKAXMlgodQnlh1GFTMA2w+YKptCpAZWZzySE3mf16CZs+sOW5IEEG6wUEb10XGhkR9GEVbX4mZrQK6Ebpv/q/Cj5xPLh4V4DmEeusxRJQfm59jAEJsCclmLUWS3hZOZ5QoUebeaWQo1X7KFTut732Y3F2TmllOcTROfgQtkJeXVj/1/R5cCuRCEiVPh1g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabb0545-4fcb-458e-5c86-08dee3aff8ff
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:03:27.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bu+WCWn+7H4n3O+fDZMMVCklnsqtp+I4UeFihBTRFmCDBiHQvk7bC/emeOZ+fnIosu6KysRY7EStymg8Rss2oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8282
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAyNyBTYWx0ZWRfXwGGM894XtMe8
 MioMEWl9BTJ8nglMof6FJOmx6CEcQX9Vcw7+6RcWzuTMpe2TRKMouPAsmhmOGS42ClL7S8UmF1u
 6J57KSDvNmKP72fKlTNILK3b9+Wo4bwU4eAeUqmIcqwAhv3uXy5cWdn/k14sv0cdxMZRecrzFt7
 FnGDIM7IJ+C4kVpbDmBXekMq7dUGHuiUEjDCxKXG1e0MMy8NQeSK4uISPZUy/R+/jt0YuQ/xbP5
 AaydmAZQa0oS0AUbZZUfJSNQL5XZ3VIx7IrfxJWw1cTmVZ4tX0vFBzjWc/WxIBENmC8QPuXNGEC
 NSuLsxMQRngvipopFHQDUWxNmtDw8TNLR9zUafPebmLsAMjNb87J63JWWjieyP7XaPjXcWzDPfG
 QrWHNxRRrND4b/aKGglKmiYnvG/IwFt/tlklhKuTCM//xTcDS2DPecMgSYSG4L8JWnOdKUiQ6VH
 CO745WlTYkwejLgkndQ==
X-Proofpoint-GUID: eYt4MpBUJomrR7lIIZxg-TGI2VP3lblu
X-Proofpoint-ORIG-GUID: eYt4MpBUJomrR7lIIZxg-TGI2VP3lblu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAyNyBTYWx0ZWRfX8JL+IKkSAtZa
 nZEgtMX/cZHqx+GAM8HkYCxK8uRNROm3/fyupR+qS5MkbJ9ZbzZD8SEnQIsKmSdyyedNhLP01Jn
 oa1TzJKhk/HX+OYSFjyxeoWbymBBaW564Yl5EwW91m0XR4tdwDWK
X-Authority-Analysis: v=2.4 cv=JNsLdcKb c=1 sm=1 tr=0 ts=6a599ba3 cx=c_pps
 a=2TFapuF8m4VBt/+2R/0yYQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=cPVMXl4LuZqRGAXO814A:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170027



On 7/16/26 15:57, Greg KH wrote:
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
>>
>> The sequence becomes:
>>    1. Hold ldisc_sem(write): close old ldisc, set tty->ldisc = NULL
>>    2. Release ldisc_sem(write)
>>    3. Call new_ldisc->ops->open() without ldisc_sem
>>    4. Re-acquire ldisc_sem(write): install new ldisc (or restore old)
>>    5. Release ldisc_sem(write)
>>
>> Reported-by: syzbot+de610eeef174bd59a8a3@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=de610eeef174bd59a8a3
>> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
>> ---
>>   drivers/tty/tty_ldisc.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> What commit caused this to be a problem and why have we not seen this in
> any real-world usages?
> 

The circular dependency has existed for a long time - it just requires
ldisc_sem -> rtnl_mutex (from slcan/slip registering a netdev in
.open()) and the reverse path through nft_commit_mutex, epoll, and
tty_poll back to ldisc_sem.

The recent dev_instance_lock series (5326fefb9fe8 "net: hold instance
lock around NETDEV_DOWN/GOING_DOWN") increased lockdep's observability
by adding lock acquisitions in more notifier paths, making it easier for
lockdep to collect all edges in a single run. It did not create the
cycle.

We have not seen this in real-world usage because triggering the actual
deadlock requires 6 unrelated subsystems to contend simultaneously -
something only a fuzzer like syzkaller would construct.

> 
>>
>> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
>> index 27fe8236f662..248a6995cc53 100644
>> --- a/drivers/tty/tty_ldisc.c
>> +++ b/drivers/tty/tty_ldisc.c
>> @@ -556,15 +556,28 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
>>        /* Shutdown the old discipline. */
>>        tty_ldisc_close(tty, old_ldisc);
>>
>> -     /* Now set up the new line discipline. */
>> -     tty->ldisc = new_ldisc;
>> +     /* Clear tty->ldisc so concurrent readers back off during transition */
>> +     tty->ldisc = NULL;
>>        tty_set_termios_ldisc(tty, disc);
>> +     tty_ldisc_unlock(tty);
>>
>> +     /*
>> +      * Open the new discipline outside ldisc_sem. The ldisc .open()
>> +      * may acquire locks (e.g., rtnl_mutex) that would create circular
>> +      * dependencies if taken under ldisc_sem. tty_lock is still held,
>> +      * preventing concurrent ldisc changes and hangup.
>> +      */
>>        retval = tty_ldisc_open(tty, new_ldisc);
> 
> Now you are calling open when previously we were not, are you sure this
> isn't going to cause problems?
> 

This is not a new .open() call - it is the same tty_ldisc_open() that
was always called here. The change only moves it outside ldisc_sem.
tty_lock is still held throughout, so .open() sees the same environment
as before.

>> +
>> +     tty_ldisc_lock(tty, MAX_SCHEDULE_TIMEOUT);
> 
> Why that timeout?
> 
>> +
>>        if (retval < 0) {
>>                /* Back to the old one or N_TTY if we can't */
>>                tty_ldisc_put(new_ldisc);
>>                tty_ldisc_restore(tty, old_ldisc);
>> +     } else {
>> +             /* Success - install new ldisc */
>> +             tty->ldisc = new_ldisc;
>>        }
> 
> Does open cause anything else to be incremented that you have to clean
> up when done that you aren't doing here?
> 

tty_ldisc_open() only sets the TTY_LDISC_OPEN flag bit and calls
ld->ops->open(). On failure it clears the flag itself.

No refcounts or other state are incremented by tty_ldisc_open() that
would need additional cleanup.

BR,
Yun
