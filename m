Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021086.outbound.protection.outlook.com [52.101.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1872377A9F;
	Thu,  1 Oct 2026 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790815206; cv=fail; b=OWxNJBSbSeWV7djWBYtMi3Q7ThCNHsXkJUt6yk0vCiWzjawqteAqHdr3aylr2xqYyRs9OKy9jGBE2u9TAUgxVU575KD5DNcAmfKeBnyENj774G6/JuiijURnNzf6SKma4BNhmwtpZhX8k/blPKngzl6tBVp044NPTr1rxx1mv48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790815206; c=relaxed/simple;
	bh=DHw+0QnhmJuPlzlgyKci+LWliCZ6FZ780D7bOHK3YXk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=fomDUojLEQnw6RsmnfUc2Rv3ALMdDxohLLbvo+BDJj/ZI9BRjd69VhcAxH7ciLC5vHywsR8XLr+EobgYjBSxR0vn1X+xOj/+is4O5r3tPe5EBrUppMotEAbnq6anxbiQUT1d5V3Eg1OdaIdAintKyJ2AsopotKHA4FsLSenFbgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zzoVbhlK; arc=fail smtp.client-ip=52.101.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zzoVbhlK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3b7dYfgoCdXeDYnJNk7G9YVEgCJOMBItnqHPnFgpyWLk7LuWyDlcA3MHhlS2AO6Yp0Zv3ADB68C95+Hpsxyv8nAC4RbhSf6ZpfZgT3aFYj77I7GaN3KEExs7MQpfy8bLhXTMcjd+Pc3juE55hxxqC33bJ86gwInbxIMZ7/sHm7E5Jj3WcFoiVcUJxcqc8D04cYjqGU/VZ4vXumJjU54+SZbRVL+6Vqixk6q3FARnTQKZp+qD3OtWaaxDKSxzPvN65y52ynXOV/QZB5u1s/7fRrWFz5nzkL7g/QSkQhx+k5FFLZDxsDh+AprBAKj6+XL+KTDTtbBtvvae/J58o1sYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHw+0QnhmJuPlzlgyKci+LWliCZ6FZ780D7bOHK3YXk=;
 b=ZJNIAheKldmdGT3zbqyj0e2vEyBzW1DkixGKBAdF1Xk+BqeC9uxXOWKNJ9WIOsoQeo5xQdj9+iSpBJZ1GGdIrJ8tPs6wa2clNx6C/NFKakvLlRvNCaYtUQWHoft+AUmZrAp8zTieoRm1V+EN/XsMDm+UZvjL4ug56YLh6r6TPFoyVNNi1cc8FD8oWPumSB2tZTG5tS9I8vNwiXD60fhTNSBxl/ybdjMcU+6CNH9lEoS5FZPu0j8t9jNa0mCdcDFeEzsMRInVjl9yXKy/2IVMArBkSauWcMqcQP3A2hwyR8B03H0OvOI+TQkJYwYwQMeotrEMFdsB2F1AM+HYq5iTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHw+0QnhmJuPlzlgyKci+LWliCZ6FZ780D7bOHK3YXk=;
 b=zzoVbhlK0BV7lnQDrO4T01UZVQUxAP6xsOmwLnVH27/DWONEBxMJUAg123ZKOi/AbNdC1HdWEht781qD/qVOVpLbJFa+s00tX/Ue5OdvMJCSz7IJxZUKS4jnivQyi0NqNE7bkvcGpJON/Qw4VsYICtiwb5oNVXp99LTmUIoX+uI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO3P265MB2155.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:105::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 00:39:52 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.024; Thu, 1 Oct 2026
 00:39:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 01:39:51 +0100
Message-Id: <DLT305M0I5L5.19LZT0V02L1NR@garyguo.net>
Cc: <dakr@kernel.org>, <ojeda@kernel.org>, <a.hindborg@kernel.org>,
 <acourbot@nvidia.com>, <bjorn3_gh@protonmail.com>, <boqun@kernel.org>,
 <daniel.almeida@collabora.com>, <lossin@kernel.org>, <tamird@kernel.org>,
 <tmgross@umich.edu>, <work@onurozkan.dev>, <linux-serial@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <fujita.tomonori@gmail.com>
Subject: Re: [PATCH v1] rust: serdev: use Delta<Jiffy> for timeouts
From: "Gary Guo" <gary@garyguo.net>
To: "FUJITA Tomonori" <tomo@flapping.org>, <gary@garyguo.net>,
 <markus.probst@posteo.de>, <aliceryhl@google.com>
X-Mailer: aerc 0.22.0
References: <20260930041339.1551129-1-tomo@flapping.org>
 <a8693eaa1f8eeb167ee334e7c35371832e43bb4f.camel@posteo.de>
 <DLSP8RHJMYFZ.3II53ESHY15IL@garyguo.net>
 <20261001.092931.734162860031900892.tomo@flapping.org>
In-Reply-To: <20261001.092931.734162860031900892.tomo@flapping.org>
X-ClientProxiedBy: LO4P265CA0285.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::19) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO3P265MB2155:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af1e3b4-a1c5-438c-c3d2-08df1f548170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7416014|23010399003|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cbTGSzGcTPq7yE8krOL2py9QPlnMTDzCu7Xk9tv69xxLN9UGkMhnPfEJd7alRc0Zo58v0vnhK0hFE891NcqVkf43psFuTxAoeM+Qq5X9b3oHB2VAIGFFrrE+sXGWGpAU44sAfnmjKgJ1iPqbvFj7OMsol6QxpSsQ9mtloIaXsdUOsYhV/pptgLymJzT+dLBHfPFB857ijZsskurEuxMmdnrESxiB/WtfqrXFm16MvKG2SVaSsgiQhTKF1W6FCKQkw7NXnQrgdlb2PBQOAESBlU+DYuUiSbnvJAkhClp+CqJy92L4DmpY5spdvYC5ehifjsf4h0GWOyDmBu6VIcnOwZnyyIIwe4JbAKiN+N+Ms1pMOldAP6fzMZc73rKH+h+DL8os4zirUceysGdw4pfhq7+5/ui6+y/M/vJo5ZKOzhJyH1mqEZqZpvT/yzHRhWU56s+EIASDG4GrSkaLnJLqXuPq5MlludsghBs4Wtr7WkHoq4XYHguiSXwSiVAdYL2IFmzUdCRsQHRNoUmPG04dNLgut1q9lBcrs+lfjXBWQbs5i6bLLfVVvEdKvfuG71YXc0ixRwYk/gKGjpntrZRF6tPyl+ywQM6HxwqMSlVNSXPm82g8wm+xZJCMpMCshP5bsBsFNpCUCtaknnNYNJB8Z5pBBQZR77BPg8KYkD22z5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7416014)(23010399003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDI4c1ZtNGh4aTdHL01VdkNlVXZML2EwM1g2MW9seW5jVTJsUFBuS3loUXlu?=
 =?utf-8?B?S3F2WlBjUnJmd1F0bUFGQnlsWHR4eWRmb2F3dkVXaE1qeStsbStIajQwOFpG?=
 =?utf-8?B?Z0lWNVVEc0d2dm1DbFFYR0ZySzhzRmkzbEMzemZ3QksrOEVPWmJvVzVzVzU3?=
 =?utf-8?B?NFV5WkNCTG1HTTE4dzgzekRWV0Z3L0ZaWmtOT2U5NmpobWFrV3NFdHFCRmJo?=
 =?utf-8?B?NkhnY1YwMTgwTTZhdUpPVnhVYzV3VjhTYkJld2cxUnoveUNvaHFMajVyVmhq?=
 =?utf-8?B?cVRvckVMSWhkUmt5ZEdUNURtU1E4WndwSW4wN2NTNElSUFBYVnZ2VDh3UG56?=
 =?utf-8?B?VXcxMGQ4RWpSRWY4dC9MeWVIUDBiRVZNcy9qK091OWtjVFU0YnFJT1crZFpK?=
 =?utf-8?B?c0Q5Z2ZhbWlSa0lTaktwZitwN0dNM214VVdrWjQ4OGxnMklqQnNWMENKektm?=
 =?utf-8?B?TUw2Y1ArcEI2SGdpK0pPQjdySnRUNWdaOGdoRkJmeThFbCtRRHpBYTNMVzRs?=
 =?utf-8?B?T1FRenlmTnU5dWtiUHlVV3pGeHZPQTI0OHNLVDE3SHVtZThPdzZiTHNrU1ZZ?=
 =?utf-8?B?TG9uM1pWb2dxOG5mNFlIUVFXWWR3VzZkcmFicjN1U2cyMjRWOEJ4b3pWa01H?=
 =?utf-8?B?ZGdEaXZqZFZ5Z1o4WHR6d2NseGdnOWkrMFVYaGhBTW5lWmdGRjlMQmhOeHF6?=
 =?utf-8?B?cUJ2aXZFU1JPQnE4YlFpRDNtQ1Q2aEtCbEFBRDhQWkVVa0FaRUtIbVJmcFNp?=
 =?utf-8?B?ellUb2V0c0dpTWVKR3hxMWlQc3Y4cVVCbzBUTi9Cd3RzMlFzT2tHVmlGaDI0?=
 =?utf-8?B?cWhwSFF1d0VYN0NWUEgyQzhqMVNuMlEwbmZsdk5rREpueGNLUXlMbG1kMzQz?=
 =?utf-8?B?b1RtM3pTMEhjc2FwQjFiOFhBclZPREh5TmpUUkNmTnUyQ0VWQUtOUVZFTzlz?=
 =?utf-8?B?Y3p4TTg0RDFaZ2xVRy9ucUtVMS9EekN4c01sMWdCWFZpVy9qQnJTVlllTlp3?=
 =?utf-8?B?anhIcUNELytkWk1ZVy9Dd3l4dzFLWVVxdjhpNEY2Y1ArWmFsSEFCNlR6bHRo?=
 =?utf-8?B?YzJEbE5BaGxIZGljdTRUVDRQcXJGMGVCQmI4cG82eFRleGtKSFo4YjZFVGhY?=
 =?utf-8?B?S0QzdEhxUkdIV2dyTkRkNTJyTkpiSTQxamNuejBwdmFrcmo1bWsyZFl1R2lE?=
 =?utf-8?B?N05sd2J3Qy8vcGpKVndDbnJMdm1FVzJDQmgrVW16aVNxeFVwRlQ4VGpIejZy?=
 =?utf-8?B?Sy9BQVZ0dzNaTHFPbk9HSUl1RHZKOWMzSVZQUEFCck9JYmVBeXo4TzVEUVJL?=
 =?utf-8?B?NHMzaTk1dUpTdHY5NjZvV0tZVTlZeGZlRGhSdklPL1hVN214MnFpbzREVEZv?=
 =?utf-8?B?Wi9Oa1gzdncxVFdxWVZLeHNrcVprL3hESVJIWG9VRWJHdFJSZEhPQVdKdEZE?=
 =?utf-8?B?cWJKdE14cGZVcE1RajRVblpFeENNODErT1FmV1BFMFdWc0IzMm8rSWpuc240?=
 =?utf-8?B?ejBsd20ya2F1UVJnRkZaMnFvRkpnQVRrSE93bVVsZW0vOGpMRnBSMzR5TGRq?=
 =?utf-8?B?Nm9yQjFlMHV3U3VwbmpsdnFYS3hjdFRuUjlaRE41MTF1eXc2Ukw2QWEwYUVy?=
 =?utf-8?B?VnI0M2hzd0p0cmFZd1ZzblV3cjdaRTIrU3h4ZUUzbUJmbXRxZU1WaGJ1d3d4?=
 =?utf-8?B?S3o1VFJLeFd5Ny9WV1dnQ0xDcm1kYm1LeGp1TEFkRmorNmtoMVJpZWxHYmE2?=
 =?utf-8?B?NE1PRTlpRTBxNXlhakxaZ1d3emhzQ3pGUWx1MGhkdXVDRjhtZGR0a3N5QmxV?=
 =?utf-8?B?eERXQ25oL3pyNkVqUjR1OHFtdGlDMTBuOW15VG5XaitDWGVDRDRwUWtBWlJV?=
 =?utf-8?B?OHRaTnZSbm1uYk0raityZEpSa0M5dnBEcldabWE4akxubG5VWlJRaytnVGpY?=
 =?utf-8?B?QUgxYVV2Wi9tNDYvekFzVWlxSk5lWFpTcTFxQXhOeWc2SEtFRzZ1N0EzeHhH?=
 =?utf-8?B?aEdpZytaSzl3L05rYmlPdUQzd3JtNGY0V3IxUk1Tb3YxeWJRVENSN1YxYlNo?=
 =?utf-8?B?MDVEZEJTMVlMbmNvYjIyK3U3d29zVU9rSlpoSGtoQzAzZmh1VU1xdGN0QUEx?=
 =?utf-8?B?SnVxd2wwbVpqMWQvWXMrOEt2STZ4YVNiTzczYmsrdjdWemdCbE9oTDE4aGZK?=
 =?utf-8?B?Tkl2REJabXc2WjJURDR1TVFQMXErMG9oanJCcFlZbVlYblhCWmZjeHdDNmNi?=
 =?utf-8?B?VnROd0ZtK0lDVExTYkFlZ2ovKzk4cTU1V1ZoUk1uR3lQSDNpOHdRcEFYbVMz?=
 =?utf-8?B?TUt4ek9XMmpLMWsrZ3o5c0swWWFzU2NabDZ3TExGT05qMVltME5BUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af1e3b4-a1c5-438c-c3d2-08df1f548170
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 00:39:52.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgicdMqo8Ec9YrCSPzQDpI3TXv2PfMaKexF4PIdyu3thH3WHV8GpKUuGe9j3t8bkxK05dFfPKR7qeTSPbjMjRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2155

On Thu Oct 1, 2026 at 1:29 AM BST, FUJITA Tomonori wrote:
> On Wed, 30 Sep 2026 14:52:50 +0100
> "Gary Guo" <gary@garyguo.net> wrote:
>
>> I think the API should ideally use `Option<Delta<Jiffies>>` for this cas=
e, and
>> use `None` to represent indefinite wait.
>
> For read_poll_timeout(), where a timeout of 0 means "never time out"
> in C, we did not take Option for the timeout. Alice's comment [1]:
>
> | Another thing is the `timeout_delta` option. I would just have
> | written it as two methods, one that takes a timeout and one that
> | doesn't. That way, callers that don't need a timeout do not need to
> | handle timeout errors. (Do we have any users without a timeout? If
> | not, maybe just remove the Option.)
>
> serdev is in the same situation. Do we want an API that uses None for
> "never" here?

I don't like the "using 0" to mean forever, because 0 has a more sensible
meaning -- which is just do a poll and don't wait.

This one doesn't even return a result at all, so `Option` sounds reasonable=
.
Alternatively, just use `MAX_SCHEDULE_TIMEOUT` (i.e.
`Delta::from_jiffies(isize::MAX)`). We can perhaps add a `Delta::MAX` for t=
his.

Best,
Gary


