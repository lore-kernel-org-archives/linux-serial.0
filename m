Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011049.outbound.protection.outlook.com [40.107.74.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60D01EA7DB;
	Tue, 28 Jul 2026 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198387; cv=fail; b=II5DtBstre5Zfs2VhYvViSoAGk3Pjt8FZyDkMnNgRIaYt32f0Qna8jdph0ky06Ov8G8rpSIGtddjCZUVlxX46zjPJ3JPVm1blegtR7L+zEsqxnvxNk9VRU3kqHqK7nJtfyHGojW3/YRRPE8qzKr1DtJ2Nu5lrWljbuVFusxUw7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198387; c=relaxed/simple;
	bh=FN3IFFy4hyTlHCvsTwx2uiko5pMUhL2JSaTlKw39DUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hDu5G6UiXXHuwCo4PYFvEswGrI1HE+UFQfUPqut4ysKJxTVyXEZ4M4Cc2c9F3x4xr0I3mV2Sn7ezNwvzwHzYcKVePADzPb/PDXkipWZ+1+KsqaxC2o8bzt7+eeMuXxKw1NEwuRs54GH5TLGqpaZiKreemr9aY3ficqQq2dgejLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=nVuoCZ+5; arc=fail smtp.client-ip=40.107.74.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="nVuoCZ+5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jclxMuktUw4FhYdidEOLrw5zr+Z6i/0UyO/DcZ1BbNORKSAjfJclLOXN9vXK3mgbzhUu+CADVafpVwYUvrwedmWDqyGwbcqa/TbQ771e+DsZz01LhgM6bdzLkDJoskgx2f5u/uwFO1di5FQU+Mxv3Iknr/UuiocG9TgVTwOPLiaXqkMTGdA2xSo1LU1DRGgjASIHoD0WuMfRiVlTgKvHZdoHWPWZYcDnISW61WlDDCGi14wEvnmSIX7Hmnuv8gMW74NzYg8LpXv/s2bSswP465T9GM+wkjI8/I5JvaJKMcVXtJSNMU19/KL63/yJYaRxlZ4E10aybuO/aWsEscXdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN3IFFy4hyTlHCvsTwx2uiko5pMUhL2JSaTlKw39DUM=;
 b=e7x8Skusb0/fvaq59bYAEqsqlvVyoHcs408MmBI02BWvjBoDUDRdbr8rraKCgROywGd1GE9vScale+fr/sZJKfGjukd6IYv86noG4J3QvR3q/HZeg0j1tCNmMCzPmCFdvjShTETjX7zPOqo7j95X0Rwr1MgTNESCy+MGUlfqKcPQ5cOdW5XjusYvmajHW72rgg0GRiO97dp15qBtHbW4GW2bCSb5hmudrsL4sneKN+D8agvLWPziEHdEdwIUnEOZas8ekojVmEH32jbcRgVEOKDzLDazGI54lOJtoS+wM27gIcPokd9+AP//rdxKfryoiqZ//o1So6PNgxLjMhnf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN3IFFy4hyTlHCvsTwx2uiko5pMUhL2JSaTlKw39DUM=;
 b=nVuoCZ+5I/5xaVr6iUjgb9VWd3Dz3Ic/xapBlMA+2Nk1B1mkBQgq3iK1nJ4o9Kgoc+IbjwrJx0sRvgwNJAXrp/3vMm6dU2gvpY1q72OOd/trAWXI7O1fTiPYCaJhZYZIHQlBjLdQjva+chWUIFZ4057BTySk/mu/LtqIpSv77ypTBtwW2LJR4e7SDrC0zVlbKdgm5832kz9xw8oH7/E/DqjV5T0cAxsEnUfccWjs8Mb6YnNQA1tv9QC68QuKGQuPYOb4S7fNJn998SFD0+eeWtb3mZx/AYtYsXhETAn7CEBjrEQuo+YLgKfBHEXd4v7Q4jmv2Fr8pONGyCNQ4ON36A==
Received: from TYXPR01MB15199.jpnprd01.prod.outlook.com (2603:1096:405:276::5)
 by TYWPR01MB7450.jpnprd01.prod.outlook.com (2603:1096:400:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 00:26:22 +0000
Received: from TYXPR01MB15199.jpnprd01.prod.outlook.com
 ([fe80::26d0:293d:651f:7e97]) by TYXPR01MB15199.jpnprd01.prod.outlook.com
 ([fe80::26d0:293d:651f:7e97%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 00:26:22 +0000
From: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
To: 'John Ogness' <john.ogness@linutronix.de>, 'Karl Mehltretter'
	<kmehltretter@gmail.com>
CC: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
	<rostedt@goodmis.org>, Clark Williams <clrkwllms@kernel.org>, "Toshiyuki Sato
 (Fujitsu)" <fj6611ie@fujitsu.com>
Subject: RE: [PATCH v2 2/2] serial: amba-pl011: keep console clock enabled for
 atomic writes
Thread-Topic: [PATCH v2 2/2] serial: amba-pl011: keep console clock enabled
 for atomic writes
Thread-Index: AQHdG7Sg2kAzhTtuz0mZJQg666Kf+7aAqefAgACdigCAAKU98A==
Date: Tue, 28 Jul 2026 00:26:21 +0000
Message-ID:
 <TYXPR01MB15199BA6E24E2BED4287B2B09D7CB2@TYXPR01MB15199.jpnprd01.prod.outlook.com>
References: <20260724213348.77418-1-kmehltretter@gmail.com>
 <20260724213348.77418-3-kmehltretter@gmail.com>
 <TYXPR01MB15199DA567AF4541DD79359FBD7CC2@TYXPR01MB15199.jpnprd01.prod.outlook.com>
 <87pl0863t5.fsf@jogness.linutronix.de>
In-Reply-To: <87pl0863t5.fsf@jogness.linutronix.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NDJjNDgyNGYtYTVjOC00YWNhLWI4YjUtOWU3MjM2MWZm?=
 =?utf-8?B?OThjO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjYtMDctMjdUMjE6NTE6MTVaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7TVNJUF9MYWJlbF9hNzI5?=
 =?utf-8?B?NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfVGFnPTEwLCAzLCAw?=
 =?utf-8?Q?,_1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB15199:EE_|TYWPR01MB7450:EE_
x-ms-office365-filtering-correlation-id: a5dfdd9a-84ef-45dc-bb69-08deec3ed9cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|6133799003|5023799004|4143699003|11063799006|56012099006|10067099003|1580799027|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 rZiwDkDt0Tt+qcj/wpYdUWU1PitA/UeG7lyvLLyNalzaOgCFILCFJ4sEUYPXdR04SbWv5TqdwXXByRahgL9sYS8rqFFU2xTvFVBUg/Hr1dJC6WjMqDN/G/LMVzbO1y1VOx7ZTGt84UcsEdHtoB2g/vVI68kDzpXr6d5P016GieP+v2rgBN5iLeT3YHocdmyTQiFdwwWyD977TFMYtLyldT/RJJXiv3x8JIckZxf03oHaEyaN+YkkjdeOANp+P2PydZ5y+tA+N8QVxwzFhFrjZTjjBVA8JZu8JBXXxcpmVd/97tXHd0qNFL22NlE0jEYZYw+HHmfpZbzRlSHhLVV1tFIwAW9gkCZK5qGRiOU+AMy9DT/IniJ70spmLkOdSQa/hAnpVM5MJ7NVEEwrRqCs0hMdqb5vQAb+tew4OWAHwZKA+WDnmqt8ZHQ2ixV1sX/BZ6mfb6S1a9WWKbyuy+Sq589kaefQqoleH4FFiveg9c+N38Lp0PZm93n7cUp9v66oiIIxFx8PQW0uAoHvmz2fXGQUL2mZt2F+Oie7QMRSG0+GciOWlJwpJerQn53O8hrat5Bfaetkd+hyGfaP3Jf/gL4IVQ9vHctxCRLsK2SaKe3wxCeIlerXzKfwrByPx4eu5lgiWBk6Q650R4rNSYceIKNcoChDb33o5mf83ho/EUVBRyx1sTntiBPDKp01mjNnnLiGzBVO+u13QqGUQEDYfg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB15199.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(5023799004)(4143699003)(11063799006)(56012099006)(10067099003)(1580799027)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1VCWS80TzBzZ29TakxQRjNzbVJ4QU85Y21LRFI5STl6R0lzVHplWnZGbTJw?=
 =?utf-8?B?WmswWTJOdVBERDh6ZWtoakZBM2wvS3htRkIyRmlSUDlVNC9NRm9PejRoMnJN?=
 =?utf-8?B?QlRxcHR2YWs3UEtQMUhzeVhKZGNiRUtpcmwrSjlrdFg4QmN4KzRITTk1R25C?=
 =?utf-8?B?NjJIM1ZIZitzZnFPTGpxc1pXN0g3azRncTIxOXhMazl2RWljTi9OYkxZSHVt?=
 =?utf-8?B?ZFRGSEVqK0FlakFzREF2d09KdWkyQk1mMmZJclRnZW1wSEd0ODdsRHFEVnVi?=
 =?utf-8?B?REpwV2U4ZEU4S3lWWmhSU0FRVGxsUStPNTB1S3pNL2I3QnhUTFlnZVkyNUpD?=
 =?utf-8?B?dTlxN2NtWGtoWWs1WVNZLzZXQUtwT0c4cjBZd2M4bzNUTWxmOCtaSkFndGVW?=
 =?utf-8?B?MExyUGE2cm1UMXBNcUpGVDBUTG54SkFTem5aMWI1bUhzSWhuZGZJOFlXZzFy?=
 =?utf-8?B?R0IyTDJVRlRiRjlZSFIwT1lsL1d2SWFQTW1oei9kN2ZUZW1oRG8zVDFFTlJQ?=
 =?utf-8?B?YmlsM2UzcWltOU5KMmhiQXNnOWdLS1ZxR2NtSVFod2xWK3V0R0QwaTBVYWF1?=
 =?utf-8?B?bDAxYUNqYU45YTMwM0NJbW1kcnZYOW1lSmF6NUZlOGV6U0R0OGJRa0E3c1RM?=
 =?utf-8?B?Q2JPR0ZIdDhEMTJna1c5QTQ4S3Q0NlpGc1dvUE93SUY1dm84Qk5DOXBEUE40?=
 =?utf-8?B?MmNDNUlnZUtDU1lkL2F0aHJqN0ZQMkt0aVBuc2FsSkRUL0taL1NLT1psNW9G?=
 =?utf-8?B?c0pCUXZkWmhEbndzbXlvTE5jR01MenFjT1VXMFczcG42VVZvdGdIcFNqb0E0?=
 =?utf-8?B?cnRPOTZsUUpNK0ZvdlZTa2xhbXlEV29nYjJ5SUMrKzh5ekJBTktleGZMVUl1?=
 =?utf-8?B?a1UyZTFoUnFvd2Vnd3lJd1pmNU8yQXI1VGZQMHNDSE1EdnYxZVFGcjRCUm9u?=
 =?utf-8?B?dDFwMlR3dnVuWlhzdXd0R0JPbEJ0VFdsN1cycjBMVFI4VGxyQ3Q2RUdVUGRY?=
 =?utf-8?B?cktSRm11cXRoQnFtUG5vdUw0QjJ2U0FTejh5MDIwc3Bnd08wSTRVQVQweWRY?=
 =?utf-8?B?bDcvZ0R5NWRpVjY4N3VzQVdXWUt3dGJvcExBUkx4RU5iaTQrZ2tnZzYvZnBr?=
 =?utf-8?B?eUVUMUI2a3lTSWJJVUNKdHNSRVUrd0pJNDgyeVNBbDJFekhTL1pzMndzZEox?=
 =?utf-8?B?YWRUdnBlQVZzaGE0VENPNmNqRTlkbjBFVExpZ3UrcDdPQ1FQMWFCYTdCQmh3?=
 =?utf-8?B?QS94cWJ4am5PVzd1a2RpR0ZsMFF0dUY1VTVQUytzRklKSW42ZUF5YUswLzFt?=
 =?utf-8?B?c0FSWTkxeUdPQmVOQW5aVFhUeWF6bmIydWNITUUxNS9pN2FLbEFTS1FOQnV2?=
 =?utf-8?B?ZHU1L2NwUWUzNlVKbkFuVWNzWjdRc2JiSlhhNTJZSGdkZEpJUnRURUh4M2Y3?=
 =?utf-8?B?aEM2eUhiTFY3TXMvQU5jMVZoYkUwc1NDb3BuWmFWbXo1ZnIvUk9ocGRoQ1JV?=
 =?utf-8?B?NzJ6RDZ5L0hRWjBxWnFzNDNvWEhiS2tydE16cUNLUUpISmtYRkw1VmZpNVlV?=
 =?utf-8?B?K3F2NnpXbUhFR2ZWZ0orbUtkekFkMDRwZ3JvYnRoblV5azgwL0I5TkUwbFY4?=
 =?utf-8?B?cXUzSW9yMWVvcE9NK0FOM1RuWGdienlsTW5hNjF4ZzkvOVFzUE5HUFFsMnk3?=
 =?utf-8?B?eXZ4MENJOUdqQWcxcThZZ1l2a014R0ZGNCtzZGlSYVdVcFh1d3V6Z0dyNHpK?=
 =?utf-8?B?OFFXUHRRajBtbzhURDVQd3JvM29xaW9BT0ZSb3o5ZmtJd01rNkczd3BNQ1Zi?=
 =?utf-8?B?Y0dzd1JvbE4zcVdCY2lieTc1YnAwaWRzOTRrVysxa3pIN0NFNWhuWWxBRDAy?=
 =?utf-8?B?SGpUZjlyTzgzV1E0VnRWZnNQMWJoWFJ1VVF3Ulpxb2xmYVFTOGtmZUJrNGVR?=
 =?utf-8?B?L29vSWhFTUJLY21VK05pZTdFcFVIbEhwcXRFaVIzazdRaHNRaGs5RmdKclFI?=
 =?utf-8?B?SlJVVHg5aXdRLzVmZFhBdUhtV1FGbWJmMS9PSWNtcjExLzdYY3YzU0ZTZ09O?=
 =?utf-8?B?WnY5WVhJaHhEN1d4SG1GT2NuN2liWG1OZ09uM0JZa2Z5ZTBnQVdJKy9WNEln?=
 =?utf-8?B?UGt1dlZqUEJvRFc5RG56Rk1OUk1UQTFzdUlHTlhjNzV3Q1RQQmUwd0xJNkN0?=
 =?utf-8?B?NUtpcWdTVmRubVMzSE5lbXZydVdDU25UK3MwWEo0WjBpNFNGK0tvcVZZUmtD?=
 =?utf-8?B?ZXJvaVlMN0dvUUNXVUd6UGI0MmJySFA5YUlWWFZETjRBL0x2RTZYUUJRTkEx?=
 =?utf-8?B?MDJRQ01oSzFHNUhKUDZKS0VXQm9hMi81MUdzWHFWeEVadnU4K2REdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gPiq4ARG+qnWk8QUx1Vxka9rMuIB0N60SfMnJ9fvmPUsS07yiAVSxxK59lYPcIUuwmV8haF7R0ALYJKg729Yg8Qs50CTdv6jG6nBl0NFQPx5W1si9rDWKmU425JxKKSgpc4BddfzXDYAsVbwzzANabuVkbyRhlGhgH3oCwLzwtbrXd3UTG8tSBAEgbNICshVZg4pSu3hUbPPmpyXlJWY2XUxBZIWgCWriHR+W+ehrVe50CrIbYXfFFSbvyMbNpvaQ97HQHRZe0qWh/ebgMDSXfrZhMB9MV+B6wgc0lsU2dmCvfdNPTyyztoKkW+ODt3AEZt3v9noSQnfj/hLCXyjxg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB15199.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dfdd9a-84ef-45dc-bb69-08deec3ed9cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 00:26:21.8280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b38mdEQcA7JQTVtpDCtBItULsGp+SC+GvV9YHemWoEpyKm3BJgpxVBWmd1/wOp29/9jO99wT9zFQMacT/D1mQKljy885uy0K77TwRFYmpyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7450

SGkgSm9obiwNCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+IE9uIDIwMjYtMDct
MjcsICJUb3NoaXl1a2kgU2F0byAoRnVqaXRzdSkiIDxmajY2MTFpZUBmdWppdHN1LmNvbT4gd3Jv
dGU6DQo+ID4gUmVnYXJkaW5nIFBldHIncyBjb21tZW50IFsxXSBhcyB3ZWxsLCBJJ20gY29uY2Vy
bmVkIGFib3V0IHRoZQ0KPiA+IHBvdGVudGlhbCBpbXBhY3Qgd2hlbiB0aGUgY2xrIHJlbWFpbnMg
ZW5hYmxlZCBkdXJpbmcgcGVyaW9kcyB3aXRob3V0DQo+ID4gY29uc29sZSBvdXRwdXQuDQo+IA0K
PiBDYW4geW91IGVsYWJvcmF0ZSBvbiB5b3VyIGNvbmNlcm5zPyBEbyB5b3UgYWN0dWFsbHkgbmVl
ZCBzdWNoIGxvdy1wb3dlcg0KPiBfYW5kXyBrZXJuZWwgbG9nZ2luZyBkaXJlY3RseSBvbiBzZXJp
YWw/DQoNCk5vdGhpbmcgc3BlY2lmaWMgY29tZXMgdG8gbWluZC4NClRoZXJlIHdhcyBhIHNpbWls
YXIgcGF0Y2ggaW4gdGhlIHBhc3QsIGFuZCB0aGUgbWFpbnRhaW5lcnMgYXQgdGhhdCB0aW1lDQps
ZWZ0IHNvbWUgY29tbWVudHMsIHNvIEkgdGhvdWdodCB0aGV5IG1pZ2h0IGJlIHVzZWZ1bCBhcyBh
IHJlZmVyZW5jZS4NCg0KPiANCj4gPiBXaGVuIGNyZWF0aW5nIG5iY29uIHBhdGNoLCBJIHNhdyBh
IHNpbWlsYXIgcGF0Y2ggWzJdIGZyb20gdGhlIHBhc3QuDQo+ID4gSGF2ZSB5b3UgY29uc2lkZXJl
ZCBjb29yZGluYXRpbmcgd2l0aCB0aGUgY2xrIHN1YnN5c3RlbSBpbXBsZW1lbnRhdGlvbg0KPiA+
IGZvciB0aGlzPw0KPiANCj4gQUZBSUNUIHRoZXJlIHdhcyBubyByZWFsIGp1c3RpZmljYXRpb24g
Zm9yIGVuYWJsaW5nIGNsb2NrcyBwZXIgd3JpdGUNCj4gb3RoZXIgdGhhbiBiZWNhdXNlIHdlIGNh
bi4gQSBsb3QgaGFzIGNoYW5nZWQgc2luY2UgMjAxMyBhbmQgbmVpdGhlcg0KPiBzcGluX2xvY2tz
IG5vciByYXdfc3Bpbl9sb2NrcyBhcmUgYXBwcm9wcmlhdGUgYmVjYXVzZSBhdG9taWMgcHJpbnRp
bmcNCj4gY2FuIG9jY3VyIGluIF9hbnlfIGNvbnRleHQgKGluY2x1ZGluZyBOTUkncykuDQo+IA0K
PiBJZiB0aGUgYW1iYS1wbDAxMSBpbnNpc3RzIG9uIGVuYWJsaW5nIGNsb2NrcyBwZXIgd3JpdGUs
IEkgd291bGQNCj4gcmVjb21tZW5kIG5vdCBpbXBsZW1lbnRpbmcgdGhlIHdyaXRlX2F0b21pYygp
IGNhbGxiYWNrLiBTaW5jZSBJIGFzc3VtZSBhDQo+IHNpZ25pZmljYW50IGFtb3VudCBvZiB1c2Vy
cyBfd2lsbF8gd2FudCBhdG9taWMgcHJpbnRpbmcgc3VwcG9ydCwgcGVyaGFwcw0KPiB5b3UgY2Fu
IGFkZCBhIEtjb25maWcgdG8gdG9nZ2xlIGJ1aWxkaW5nIHdpdGggY2xvY2stZGlzYWJsaW5nIGFu
ZCBubw0KPiBhdG9taWMsIG9yIGNsb2NrLWFsd2F5cy1vbiBhbmQgYXRvbWljLg0KPiANCj4gTm90
ZSB0aGF0IHRoZXJlIGlzIGFsc28gQ09OX05CQ09OX0FUT01JQ19VTlNBRkUgYXZhaWxhYmxlLCBp
ZiB0aGUgZHJpdmVyDQo+IHdhbnRzIHRvIHNvbWVob3cgYmxpbmRseSBlbmFibGUgY2xvY2tzIG9u
IHBhbmljIGluIG9yZGVyIHRvIHVuc2FmZWx5DQo+IGR1bXAgcGFuaWMgbG9ncy4NCg0KVGhhbmsg
eW91IGZvciB0aGUgZXhwbGFuYXRpb24uDQpJZiB0aGUgY29uY2x1c2lvbiBpcyB0aGF0IHRoaXMg
aXMgbm8gbG9uZ2VyIHNvbWV0aGluZyB3ZSBuZWVkIHRvIHdvcnJ5IGFib3V0LA0KdGhlbiBJIGRv
buKAmXQgaGF2ZSBhbnkgZnVydGhlciBjb21tZW50cy4NCg0KVGhhbmtzLA0KVG9zaGl5dWtpIFNh
dG8NCg0KPiANCj4gSm9obiBPZ25lc3MNCj4gDQo+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC9hbDRLZHNVOVlMT213RG9WQHBhdGh3YXkuc3VzZS5jei8NCj4gPiBbMl0NCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzEzNTk0NzU1MjYtMTc1MjMtMS1naXQtc2VuZC1lbWFp
bC13YWxpbWlzZGV2QGdtYWlsLg0KPiBjb20vDQo=
