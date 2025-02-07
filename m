Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC263D;
	Fri,  7 Feb 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738927504; cv=fail; b=s+wv8Mq7EztWTkuGI7KwnCabLQZYx2uinzoqf89NtZ88zO5hHiHBjiwLZdUoDjKZhVhTaTO879zmK/8ci14Z8XcdJMT5d0ccajohW6rtgT5cGJs8+m4ne/50iukD7f3MnWwJNw+C9UyxIxHTsilepjg5mZG1ELC3d6RaTPKoOQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738927504; c=relaxed/simple;
	bh=WEyP2nLjmRVy2W9O8CJNNxHMFZul2vXETeu/B2eQsc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J92bL9cZ1ikANyfnAo098tT2n72opOHIjan+fWecNvTLo8rY0wLQzeoRoDut3zCcYKXAApwsNvDCUa6O1Bl6PVXlp6r88Ep6bBKCaLUS+kzbO4+NcONH6V1hBRCQKiOEHTArLJYths12+s0kcJguvU2HiRxNZTWW+oZ9pVsLyqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=fWoM7GR2; arc=fail smtp.client-ip=40.107.92.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="fWoM7GR2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwwDHeXBlmv0NvzkSIVhyoF3KwGNRM9fiK55GxVScwQdClAd4n3J2n+7YJFXQJBz8zKW2FmhQsRJ96+GN5CrtptD1Rb37WBnLmNkQlQYVmXv9ZZYH7ujbEWpQiMKiGgNVIQXHSce9/CkfOQVYHh4VBPqzqVo8rDKGFn++JfHvRiZRa5x9ZR6DoEkemX6zlLeyQhA1oXfW3dFSeaQewtKv8TmwOKRdoY64SGZNceh2OWY9y77ght/NgW01kVmEv+ULZFa5aF/zTe94wJWdjufKNDpAetE3oe6m/IQWYXgbgZaNOB4aHoThSLpz7WQa7VQmBvNuco4P6qBqyosa+lR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF+fKUasGQp4/4533aNFz9FUuWytYuSCiALo44QepBM=;
 b=tMVzv1YFwx40oIGO8j4jBsROzupmyjffm4+XL67Ze4q96QAK8eiD+VonfcNjOl023fjim27lGEf+UpwYlAz3PP/ZA20bTKt/3+L5GjTsurkuKcRimSydb1Wl3PRoIhHiGkBb+xF94ri4s2SAb2xF2vY/2rprraZHf/4++i53Va7yf51bAtK12ZQxySTHJyncDZmPdrgu50iJLPxn6Gtv911gHYUxHIJiq+IfDsXIOHEZrhxTVKtecw8OYLuqDLRygjEoVt1FQdh1AUHVwrHSa5BDbmwijBcUzATrwKmfE/WtE6uoWiC6NtuEWQdXHzrfpa0ysjc8vaontmh1Thg78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF+fKUasGQp4/4533aNFz9FUuWytYuSCiALo44QepBM=;
 b=fWoM7GR2k3qvBHK3BmabEi/0lUX22TsPcj1PIQ2hBrzu7yodbbPt2pPFPoVxUnT6pEf922S7Qb36G8bcrjnvUHuoKIAp3aQbfPToGB6LJDaf3Uq+PJ8Axy0swcFh+C7J+Tov/NZvIm88rOXKphLGyLPf41OifsNy0yvvFRw+QDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by BY5PR08MB6184.namprd08.prod.outlook.com (2603:10b6:a03:1e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 11:24:58 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%3]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 11:24:57 +0000
Date: Fri, 7 Feb 2025 11:24:50 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Matt Turner <mattst88@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <ftoth@exalondelft.nl>, Petr Mladek <pmladek@suse.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Fix fifo underflow on flush
Message-ID: <Z6XtgpGF-liq5I5z-jkeeping@inmusicbrands.com>
References: <20250206155555.85093-1-jkeeping@inmusicbrands.com>
 <Z6UFjU9SM4laZRyW@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6UFjU9SM4laZRyW@smile.fi.intel.com>
X-ClientProxiedBy: LO4P123CA0617.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::18) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|BY5PR08MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bad1d6e-d5b7-4e33-5e6b-08dd476a0cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dBoTUgavwPg1rIZkAgbxuYuAi0LOLkamolV5Da1EzeHo4/UN+9CtS4QNRHa/?=
 =?us-ascii?Q?zR80XWm3MCIsQ4VueTXepR7W5mBeyZwErN8dAbi2Zu2rYqvnFfdBtKh8wqxd?=
 =?us-ascii?Q?vjqXkVl1rFKFfNRxKTN4NYV2hOMqxfbLFLEqKYJtZMBUYfubg+iK3WpJpNMM?=
 =?us-ascii?Q?Jw58GmbpDKM0hMjhWvHjzcx+3nAbS5q5Eb+5CCE6MYUekKLGtgLDDPPnUGLF?=
 =?us-ascii?Q?kDMeoFYIZRMwfYOz7RMCwCdedSJHuHEv3FbZPp1P7oNmfHCox+CbuvD0+p/x?=
 =?us-ascii?Q?dfmDcXVU0ce6YcO+gxFyQnE5MUKi8Q+Bu948FI7rduAXNEW5ZPH7hV/k3WO/?=
 =?us-ascii?Q?8JFdUXGCcUa7WZ/29e+FwJYB+95+agw3OKzw7r8jsTgw18KGvtF8f6pG5Jx1?=
 =?us-ascii?Q?N7B76PL/SLeBvsivRRn4Dn+UxSoZqrzKu6lu3T6pl4FF5rz7mo6Jj06c2SH5?=
 =?us-ascii?Q?2qeHfau768RE1o5YPz57Wo6tggJSfxnLKOAs7SQwyotkOye+bPLtbC1ft+AC?=
 =?us-ascii?Q?uNXcm8pYxrYB/+R2ilz72+qPqUm2AcpHEG2d4yGNa7QvNBNmUr2WQfcZMJZ7?=
 =?us-ascii?Q?knkLZuITDMP0F8FKyaAfbwbFoqQg7zwZFE9g00QM4p5QDRuUU45Y2VjTU9Nk?=
 =?us-ascii?Q?WJCVZAMyFYFIO4TUr3IQB7KwPb8YWpAhTTp8Hrb1svO2x9OvQEGqMzNSkUpC?=
 =?us-ascii?Q?i8AS3btBz57evTXCB24qIpdPJt0K/hjejoQb9jWS/r1cfg42YksrLvbyj7qO?=
 =?us-ascii?Q?Gjx6huj1risLxxrJvP1+RPAczAh+nMi/5Q/U7c6QjtM9bVy9cvngQ6PZ7+Uq?=
 =?us-ascii?Q?wnc8XbhTbmtH5UHwaZiAAyxyRQfJ3rrTYaj9a2tCcGYqxgB1wD2NhVGrXqt1?=
 =?us-ascii?Q?7wuw1eLNKNS5PRZ6xXtFArhSniIzohCwb9e1nF6UIvHUv7aaIiXJ1MxKioyL?=
 =?us-ascii?Q?qNNVwfZDelkgxagfk0V04OuFUKpbhs+L4cNWFTxiGJtVb3gp1KRuHENf/G3I?=
 =?us-ascii?Q?37kNeT4ZP50UqdeWzLfpHCrHM7aHZoN4e1pe8v5IQxqT01oi7CFb6niBnLbU?=
 =?us-ascii?Q?Q3XgV9oUxDiOJJgKcsvY1LiAKEetduZJ9RbDbakiZkQoR2EZoV4/9FBMXRCr?=
 =?us-ascii?Q?QIjzbMqJguNaad94vhIEvU5gFhae20ZSsY8PwpLPZXFFxpBdhKUC/+bBsA6k?=
 =?us-ascii?Q?rKVFqy2RJbuL1mMpKL+966hEW6HAsyHUdruaTTio2hUR9G//mdohPXfeZcJA?=
 =?us-ascii?Q?JXjrt2/Qc46GWMy01gx/gW/PMy7O0xpIExJUZk0MnppJqQT/3Te2iaN8U7GR?=
 =?us-ascii?Q?4Gez89PAzjcdYrSOf8srAxzgt0iW5mZe8IKhvAExbIt5Wm7Yl8z71zjZ6OXw?=
 =?us-ascii?Q?oSI1X3p4oxjqPEhM+okJL6uwXbvCfPc6LxPFINNMv5IJkzRNN4y+EyY612cx?=
 =?us-ascii?Q?Edn9naXTibRs68U99rRSbU5nbMgNYUCS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2f7etlRP/rt8rXjmXW5aA+iZqwR8k+y3ETbyQZMt/S8tez7bbM3abHx1HsHW?=
 =?us-ascii?Q?PcvLrpFEdwXdmyxMMvGgSWEaQWDX4IZI8Hg9N72+K1Mnpz7Vco6oSiTqB26C?=
 =?us-ascii?Q?YPZWU/A8wx/Svg29v/coR0A2osq+gZ/qEN9BVjW8fcqhhmuXUxPpShOwYBOM?=
 =?us-ascii?Q?1tud1McBpy1WOtkBFofR+u+x8HZYGobEOCJZR3CWp4gRCrBUGhQ7ykP8eu5+?=
 =?us-ascii?Q?E0sjFpK0jGMDDS8gOnv2WrDhHnAJm0t2q3C+dSJ/yb8xL1/yBGJIjLY4lUQg?=
 =?us-ascii?Q?2c2sMAiDgYc2nfUFIzJC1oE8nDQQX746N7uojKdZF431qJIn7lpyCXoF57pM?=
 =?us-ascii?Q?0NrV6//sRPiad0Cjl/F1m75rNdRQJ3OGesxCj4Ma6puBuCxO9WY07JSd5Jln?=
 =?us-ascii?Q?9YULYhn2fLHe/S0VryDgaBgx8hWAacRzX5ZuugaobWbnUrBl6zjtSIOSOG2T?=
 =?us-ascii?Q?1tJ4MLT5VwMCEnstMXcn4p3Y0JjLQTGUhrYu14isvR64v74rfbLVTZaDLbWu?=
 =?us-ascii?Q?LVxbZYvcjYm+SmZduff8eep/cSUtEzrJQb8ZNMFDgLt1kxf5dF5YALsNhod2?=
 =?us-ascii?Q?Uj4sUL/DGWUGQRRwZV2VU8+YRSdVKavQL754hLz6w5T0zVeKbv7i8KPsQ63U?=
 =?us-ascii?Q?yi/oILLcCyUIHM3A3IGr6oP1gNsTPbfqeN905pjy4hvqu8sOx3YJ5aiv2rhi?=
 =?us-ascii?Q?CSJmfUsVYatLvpisCJAKfcpm1dJcY03C6zwwErhtbz0vCFKSijAvK5XT8vAC?=
 =?us-ascii?Q?IEulv6gucG0rP55zzQ9fxeWHR79yjPz8pGyZobJ3Y/tfkAiMOSdXwN6Ubuxq?=
 =?us-ascii?Q?cFeyRpSRgj8Y1cAj4AYmhOp8bEje/sMGwAs2c6Bs9bTYkfdkfoNXQVaxOWWF?=
 =?us-ascii?Q?BJN5kdEYsjMJCxblgH/dqSfKf9muPDM7YiUDoY1OPXKNv7mkL0zvYlbBcy2y?=
 =?us-ascii?Q?tFL53HhtOCPkktvBTEFD6jDaEjZqat8t2HvdUhENeJjVCfGWerKDajq79/13?=
 =?us-ascii?Q?0uyFJ/79my0h0CMp2IR/0JABt3ZYPnWqgepC6FHaTG/8suRCggee6IrWICNA?=
 =?us-ascii?Q?+xPcsW1gavqydDsuJa/p+FZyc1qSiwA07EtoDIjofEpqbdtvg9t9lzGWJamN?=
 =?us-ascii?Q?F9z5BiFduu7kF4QlZY1OrjiXybeqqXrfhzCTXf2n9cxpoNG4ysXGoe+lP1VJ?=
 =?us-ascii?Q?WXsukSfePtLPBYb0NGP1JRqYgtb/NFW5jlABEff8esesKRUlh0CikcrjhkvY?=
 =?us-ascii?Q?QPRVZoSFnmEQTP8VgCAaS1b/J7AC8c7kBELl6g5mQPr6ceT4KopJ1EBZECYv?=
 =?us-ascii?Q?gF8kJCE0AhaGM0BfdgLKqdPfkiHghuRzejSl4kXA1ZNUmrgHBJghmiyg7MYE?=
 =?us-ascii?Q?nyXokNL7YNMLxT57bn+5wuQ4TKAswVrNp9UnNsoW0ZltZaP5uP99qhCANrdJ?=
 =?us-ascii?Q?pzlDKg9+WH6bGvvY9CHz83yKLvGqXmajVikfHHPqmUCe+nn/3tHKKeOohdq7?=
 =?us-ascii?Q?CDpg7k6xSZytJNLmwODlAU2rhaJJMntk69mVGlUGBD59iHTin2zZLAGArNBg?=
 =?us-ascii?Q?w3FHQ+rZmQLlWJFGoVmrqvbZqYqSnq+Af8PWGXC+/iEcbMjF1n8c8gNT3Jzo?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bad1d6e-d5b7-4e33-5e6b-08dd476a0cfd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 11:24:57.7134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axnfE6QjyBFiEM+Qp36MFBW3URML4JcTHJqZuqvkGkL3/zzY1WLYLUpALnNi/6BefkRwNdK4Xa4SSUVhVRX43OYV+lOkE9tzD8tHAWMmPBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR08MB6184

On Thu, Feb 06, 2025 at 08:55:09PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 06, 2025 at 03:55:51PM +0000, John Keeping wrote:
> > When flushing the serial port's buffer, uart_flush_buffer() calls
> > kfifo_reset() but if there is an outstanding DMA transfer then the
> > completion function will consume data from the kfifo via
> > uart_xmit_advance(), underflowing and leading to ongoing DMA as the
> > driver tries to transmit another 2^32 bytes.
> > 
> > This is readily reproduced with serial-generic and amidi sending even
> > short messages as closing the device on exit will wait for the fifo to
> > drain and in the underflow case amidi hangs for 30 seconds on exit in
> > tty_wait_until_sent().
> 
> Sounds not good user experience...
> 
> > A trace of that gives:
> > 
> >      kworker/1:1-84    [001]    51.769423: bprint:               serial8250_tx_dma: tx_size=3 fifo_len=3
> >            amidi-763   [001]    51.769460: bprint:               uart_flush_buffer: resetting fifo
> >  irq/21-fe530000-76    [000]    51.769474: bprint:               __dma_tx_complete: tx_size=3
> >  irq/21-fe530000-76    [000]    51.769479: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294967293
> >  irq/21-fe530000-76    [000]    51.781295: bprint:               __dma_tx_complete: tx_size=4096
> >  irq/21-fe530000-76    [000]    51.781301: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294963197
> >  irq/21-fe530000-76    [000]    51.793131: bprint:               __dma_tx_complete: tx_size=4096
> >  irq/21-fe530000-76    [000]    51.793135: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294959101
> >  irq/21-fe530000-76    [000]    51.804949: bprint:               __dma_tx_complete: tx_size=4096
> > 
> > Since the port lock is held in when the kfifo is reset in
> > uart_flush_buffer() and in __dma_tx_complete(), adding a flush_buffer
> > hook to adjust the outstanding DMA byte count is sufficient to avoid the
> > kfifo underflow.
> 
> Shouldn't this have a Fixes tag?

I'll add one in v2.

> > +void serial8250_tx_dma_flush(struct uart_8250_port *p)
> > +{
> > +	struct uart_8250_dma *dma = p->dma;
> 
> > +	if (dma->tx_running) {
> 
> 	if (!dma->tx_running)
> 		return;

Will change in v2.

> > +		/*
> > +		 * kfifo_reset() has been called by the serial core, avoid
> > +		 * advancing and underflowing in __dma_tx_complete().
> > +		 */
> > +		dma->tx_size = 0;
> > +
> > +		dmaengine_terminate_async(dma->rxchan);
> > +	}
> > +}

Thanks for the review!


Regards,
John
