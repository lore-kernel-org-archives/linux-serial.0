Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944B30FF1D;
	Tue, 18 Aug 2026 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787031145; cv=fail; b=Li6F2MLzq+x/AKntfUdqLkx7NEZaJMmm28lXivt9DXdil87ek6/bOw6Frd9oI+GjrwnQ3aqmZaCxlT5SfUCP0BMaPWc9mELW0z8lp7t2fQdgbDqPFuZOevk2pj+d9Vsh/xiKdfNZlmjVNdjuMK5LHvFqaiL4Vko6Ww3y//2mmgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787031145; c=relaxed/simple;
	bh=rnI7v/JkFvMQq8TK9Ttry+2cs/6KfAaiS79sWbzFQU4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tlMHXd7ImOb2Skt0BKWWyfUrOWFEenz4osD3rXTHIK5vWlgheVT5gf6zwa/oyNqGfMPThN0QaGhjly1voL4I+lwoyqqwOlouc6Levfd69LviRmOQ44+IvjkzLNu/0ZEDDR97CcQg7W+yhO22gUNXHtDdgSRyAvmFOqM9npsBKDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J8ejSHLD; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J8ejSHLD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aG8yQrInGZPRzX3/Q4dLWsxz/mj4Edirs4B2cyTE7wu2jtZzKPoZtVBdKgSASQHfjJIzKWTXnpaTzSenq+/lk1rEG+iw4SWu296eDf4x/da5/T7QYevW3FtsXMMaM5R10eXdoX+SvNIgl/F0O0V3Qeh2y5S4FIUP6ctG9XoFemunRRFKlXAs1Lku+5d2Iq7W5mbV31QTw06aTHCoba1oFdE5fhAwe0rqYgmZlQ200JG+1UuS3mVwqcui+ra/x72EQZQ1NEg2pPpGrwIGtOMwDEYWPhvw787RAJzSii48yYM0yelU01mMu0EZmMhj3cNBpmsmNhUMPdSR9LW9mgmRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiUUxI/SyFBdRaTZiUcYuxtnyojmQgxyLZmQdQgjxto=;
 b=xYEpc25+2/YxZZ1W652TgD8mKBRmcIuILgDqXGmkmaWgvGDpFvUE4x6e40EHazcbRFMWVlPDtfFf4X/e6gU02orYxtoB8J09pgqftCBMbYo4CyPm7qr1hWTSWffTpOQG1VGPi6Q0mmpIHagr3Iv61Oi61lIG+uaDlaChDXZdqyBywREDEpZfht9YKJ4ewQXSJ0RcqhcALAHXFZG+f5Y9vqsj5rrL3C4a1pIPXSt3mUJa4QnKLwgAiTFjpo4zrO71vm8Nw8oPhR8mRvNMn5Z8jC3BdooaKBT0JgdAEkWr/k+odDquzNxB8xsVgxqTc61OaZXTFeOTu+hljTqyEZHzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiUUxI/SyFBdRaTZiUcYuxtnyojmQgxyLZmQdQgjxto=;
 b=J8ejSHLDzu+WPwqDGcB9r9cASKxcwtnkZ1drkh5NFcKxKLXImaOC+GrPpljEyKlMxcA6LcAxHtwkRyf6iOkD/JSpUm9DwM6HCI/DIjJ7yoJnfVcE6awuUOyaEksfQ9HFIi4jNGR+L1HWPs5UpI7Otw5E3BHQL+eY2I65y+yic7O98JCk5blEHHKBRQajK7pQYesEUeLh3KmYABoQF9SB+jpXTm6f7xaDT6/TN3n6PPkOmSChFZu3GCyZrBDEC53urzOy4eFByOdxJ/mVMSVqAcK5m1fYabsOzqZCie+bfS0ARn8jBo15FL52+IF7gZG3mujc7OGDwbxPj+A0yQCGsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 05:32:19 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 05:32:19 +0000
Message-ID: <3023d7d7-c8ab-48e7-a0e4-e18cc4ea0b9a@nvidia.com>
Date: Tue, 18 Aug 2026 06:32:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v9 1/2] serial: 8250: Switch to nbcon console, take 2
To: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Petr Mladek <pmladek@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
 Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260724103654.133654-1-john.ogness@linutronix.de>
 <20260724103654.133654-2-john.ogness@linutronix.de>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260724103654.133654-2-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b65575-00e1-4263-55cf-08defcea123f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	H2NXT5jwUuDfKGmDjXoAD6TGJG/tNlknLvyuS0ceFyJaUSg8XhgBNA7pb3CnzusP20hQm0okorPcsnM0Jz0YLB4Ibg6XBzimnlEKLn7rubed+OloGzSlzlT6JuQfQbcZ8JDKIZD9xEk8zdiOqzrTj91Sl2VSQxf1YTHyifPweQk091qXdZFHqNCJtFdHaZJIlc1PnJTKBXlc4ka9TbXCcd8FARwnIOQXtz8/X/ohObpXzl0qJGbe+Kjc4WQ9FGtK8wmxlONeTVWSRrytRkWR9oMiT7neXiGEEjch39b+BEcIV+rKLxoEJcivOjpEz+gSUlKfwQchBeOu+sNhmfYcm1xN+dSqO8cwIZWxBhUTCmYb4Y/OPBd2q6AiOt+XKXNZXPmU3H0nO05O3DLZVk2Xp9YQvwkXR0bAH//YDLpfyACOP0nyv+K/pAP3hsQZmjuuMkdpEswnc+vjUYg+RyXiv/FoCeleOmLMXN+R2SHZ1glay99Ae6J7Jpt7g3rEMytGmHR6K/AGx1vr4WgQ28bRVl3FUyl5z/f8eRDKRF4mQBmXmOmntjkNoWKMNGXyQlqdQdYKVDvj/o6+MicWajs38uej+eHvyLy739TGJoWa6o1daCGUIp09A5Oi9Y04u+ssYPwgllg49Syf1Ykh86Wt28keLCcPIxGqNtLUjdNQsqA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clpiQmg5bFVLS0owR0VRM3UvL1A3WUNlNUxUckJDRWw3SWlVd1JtQ1doU1Zr?=
 =?utf-8?B?TUVMd0lpdFlDeFpxby9nK3RnbVBpNXc1c2tJcGh0c2w1WkxCS0RhNHVCYWlx?=
 =?utf-8?B?Qys1dWhscGJqRGVvSkwwZ1hZOFp1cC9MNzlpR0tHU1JuZU45VGpOMmZpdmt3?=
 =?utf-8?B?R2tJODRMenh3S0gxendHU09qMnFXVzYyQ1VWZXpGakRUUzR6djJ5MFJwTzNR?=
 =?utf-8?B?QXozV09kMG41Q2RvTFlrTGNxVWJlWjZXWmhjM3NhQVFrUmNlRFFqdk9XQ0ly?=
 =?utf-8?B?dXo3aE13TUR6MEZmc2FxZkRuckordlI3dW0rYnlhN3pPc21GZHphSkJPb3pO?=
 =?utf-8?B?di92M2h0NFhUOVd1ODRoZVZiV0VEMm03OENrTzFiaW93QUIycW1nRGdZRndZ?=
 =?utf-8?B?Ukk5UnAwWmJhNHpIUGxKaVVxZzArYkFvcnM3bTRGbWxwa2ZCWHVYUEFubjhs?=
 =?utf-8?B?b3IvVWVOME4xZ1hqdk9yU3NaUDQ1K2t3d1F4ME45MjlMWjg2L2h1REFibllv?=
 =?utf-8?B?TmpOeDQycFRQZGdhZFY2eWFyYTRkVlU3M0NrOGN1NEttNkt2dW5lSDAzTStu?=
 =?utf-8?B?NVFzRWFHbG9vSUhLVno0clcwUkxsSnZwZG1MUW9sRzhkSFBLcFVlR3R3bWMy?=
 =?utf-8?B?bTNqQVdSeWtBZUZkc1pHWHRqZTBuZkYxUndHdG5MU3B6VkkrWGpMOTl1aGsx?=
 =?utf-8?B?dkltWkdJc3JDaFQzY2dqT1Z2S1Fpc1o2ZWFsbWhHM3NjVEl5Q0dhb09aSzFQ?=
 =?utf-8?B?R3VIbHVlVUw5YzY4NzFWcmlyRWFla2I0Q0JTbzBlWlRvQzhZb24yWUlpdkl6?=
 =?utf-8?B?aTBFWUoya080SkpjVG4vK3I0RmtJaE8yTzlsZ2RQS2dqblNsc0JBd0t4QlN6?=
 =?utf-8?B?c1RWdzk2cXpINC9ValI3b0NIZUFkLzF6TWRBUGQzUXhkME1IYjJKQ2dMUFZz?=
 =?utf-8?B?U3EyRnZMN0hYaTRLRDYzTnBHUFBsS3pmYnhCZ1hBQWhHVFU1OWVoTXJiN2lx?=
 =?utf-8?B?MU9nSXBDUnd6b1M5VmEyOVdXL1YvU2xRcEJkcGRwcGhDWlJXK280am5qQUFw?=
 =?utf-8?B?NENuM1p6L1lvQ1FYdC9iUm54amJoTGhadHRMRUJwZTEwdUIraW0zM2VkUUxh?=
 =?utf-8?B?ODdrbmF6QXBTQnpmS0xKZDdPaFRYaDZ4U1I0akV3NEl5MkcvbE4zZTlnTG8r?=
 =?utf-8?B?cmlXVHg1cFB3eHlRblBqVzNmUjB2Qnp0S216ZWpZZDJRSDk2M1pDeTZ1dlhh?=
 =?utf-8?B?M2ZQSUF5bTJzcjAzcGNWUXZuTUx2MVZuZ2E2eFhiM3dHdXF5MlpCWXYyWEVH?=
 =?utf-8?B?cktwc0w0ZXpEU1Z0aDE4bEVUMzVNNDEraDJWNXpNbjZaS3M0dEJwZW4vaDd3?=
 =?utf-8?B?T2NQNHBieG1XRlFSOFF2MTRZeG83a2dzR1BJTGVMMjdzRlQ2aXZXRXRoUFJa?=
 =?utf-8?B?ZlVMNmNLUjFtcWJiRFRNaDZBbmczTmgzc2x6bVNleUZxRzdVNldwcGh2Q3da?=
 =?utf-8?B?TVljdXhtYWg0QWVxQmt4bFNkSE9BYy9ZSTFuTEZXT2xhS1pIU01YZ2NUa0VO?=
 =?utf-8?B?QkRSUW9ybkE4dHRQbDF5WXZ5OEtsSEd4aEY5QmFGWEJMekZ1ZmRuYVBpZTJr?=
 =?utf-8?B?VlF1TlZyYy9iQ252QkVhbzBmaG54SHZ0SmsyQzViMGxneitNb1FoWDNidUFP?=
 =?utf-8?B?MGM2RTFlbm1EN0R0SGNoT0lWeG1QRW8weGNwZXJaQ2hoTGxyMmtHQlRtcW5z?=
 =?utf-8?B?YTZlcHY0THR6U2plczVSQ0Q0ekRQbUpOSit5ZzA4L0pPbEhwY1U5VEx2QkVv?=
 =?utf-8?B?K1hmblhiMmVVNDZtOEFsL0NZSWcvZWpPVC9rUUJoTzlGa2VCVi9GUXpsU2xr?=
 =?utf-8?B?OTZ5YlB2MFZscXNqbG50MGtaU2x2YTQ5RkVQS2pqdTBMVzExNWE2UkZlQ2Ez?=
 =?utf-8?B?clpTck5zSXdLck1qc2g5R3lwUTQrNFN4dDRMdlVsKzhwSGF0RHNUelBlYWlT?=
 =?utf-8?B?YU5aTzREV3FtWlpIVmdIU0dXNXVMSHdhK2t3WkR6c2RkSVcwaURWWWM3RWk0?=
 =?utf-8?B?WHFZMDgrdTluNHBzTGc4L2JUaXhEbjRxUVl1Nmw2a2Q4Yk9pVGZOTWoxWTN4?=
 =?utf-8?B?QzlISE16bkpZS0JOcUZ3MlQ3TGhwenB3RkZEZGxENDZSZzJQTThkekk5dW9h?=
 =?utf-8?B?MXE1d2FDRjBqdTFub1ZqN2RVbUVNSkc3WmdWUHQrOE5EL21FY3FDUXFBeThN?=
 =?utf-8?B?ejZuTEtFbTJwVUdaYmo1OVZBcytBdTczdjF1d29UZEVmdUhERCtGcHR5bVJM?=
 =?utf-8?B?VDJnbzgxelE1emZoRDArc0NCdXE2VHViemErSHpCUXdScHBzN3RNS3E1d2Ex?=
 =?utf-8?Q?dDKMVxyV96i+HrIOQCOSQiKNpl346Yfus3XjUZti9z9Zu?=
X-MS-Exchange-AntiSpam-MessageData-1: 5NvLtxgh+4NuSA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b65575-00e1-4263-55cf-08defcea123f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 05:32:19.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVnlTyOmjEfJHGOUR9nTILf/AiMxcagAxUwpCyiFWiPXuJUaWCgjGsQuwQqk/X/RIkMTNRe60dj0LtumUPY/oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

Hi John,

On 24/07/2026 11:36, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks:
> 
>    ->write_atomic()
>    ->write_thread()
>    ->device_lock()
>    ->device_unlock()
> 
> and add CON_NBCON to the initial @flags.
> 
> All hardware access in the callbacks is within unsafe sections.
> The ->write_atomic() and ->write_thread() callbacks allow safe
> handover/takeover per byte and add a preceding newline if they
> take over from another context mid-line.
> 
> For the ->write_atomic() callback, a new irq_work is used to defer
> modem control since it may be called from a context that does not
> allow waking up tasks. During suspend/resume the irq_work is not
> used as this has been shown to cause suspend problems for some
> hardware. Upon resume, any pending modem control is performed.
> 
> Note: A new __serial8250_clear_IER() is introduced for direct
> clearing of UART_IER during console writing (which will not be
> holding the port lock for atomic printing or KDB/KGDB). This
> allows restoring a lockdep check to serial8250_clear_IER() in
> a follow-up commit.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>


This change is causing a boot regression for our Tegra20 and Tegra30 
platforms. Reverting this on top of -next fixes the issue. Previously 
with V5 I did not see a boot issue only an issue in suspend. So far the 
only interesting thing I have observed is that if I add 'keep_bootcon' 
to the command line the board does boot.

Jon

-- 
nvpublic

