Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023114.outbound.protection.outlook.com [40.107.162.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A847C0FC;
	Thu,  8 Oct 2026 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450433; cv=fail; b=Ph99V9QfZrO3xYFTUjXdXIBLq//DN9KK4R4lsfebEH5m0TapH3cLbRhsg49i1OIP6P2sDwyG5w7QkR2Ung847cFc8u1/7bUy0iCP0LHSXYfrdGuIWZgZWzX1huUoqC0g5IOox6LniDjfQ9xB40w3xZlC9S5uWbuS/+getNfDt2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450433; c=relaxed/simple;
	bh=VOR9i9cGO5i+Sek8/OCu7LSAsgRA+P/TIW/O+cE5Ygk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=edlNyVqYgtfm0/bWAZPdo7C9nRbQcuaJEkAbd4v2mm0oFfsSczL/g8N1O/gj0SqhbwDVJOH81Gw5LGpGLb+rJFyDI5L6eX3pV4TELaTXax5poUCaNskisW3A+TBgLed+z1E+5XnGnquBrEOVjpq3neblWv9Ua2tQhSo4L7NM4SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=lX1i31kv; arc=fail smtp.client-ip=40.107.162.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="lX1i31kv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhNwur6aw1KzhBd3jbQvTFRlrDmFF+FPLi5Lf5N1XNCkPsoxN9HhQpOUdNJprDtyf+dBmMLZkycJb2/kqKvQVLRCaklC4jh9NxbaVv0HLBZqaECsVuIrtJduQVl7O2l51WHNzUnFKCNxt8gOpQNaHDd/+FwP1/3gdujPJ/w8YSy8wnWKfV+XnQmSQfwZoSuBa5qvB+syjFKTBolyBZRDxKiHAZjwPDmOPLvi2Jk6pAPJwU+fIyOpUE0hTIdRwb8x8UQu7tP9lE/LMzZA8laOWcW5v/YsjnNczPa0euhSkvVcBWuPTkqLSOq9iAi0d2yqxt8m84xSQoIN8UjYEUYv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOR9i9cGO5i+Sek8/OCu7LSAsgRA+P/TIW/O+cE5Ygk=;
 b=Uo649jVROu11jPSwpBmnq24Ekr+1IqkoGEq320P0Mapgs9ycxQqQWLN5Olrnk9EV+i67MkxcqcM+01cNR6uUfKehykP0mbqfUZEhOgskWD2YF1QVjEgk+cwlR11xiD5lI8wWPqBU3lTnsNMvfoHweVT9jtNEBDdBSeKYl/1rBT0x1UUkEZWWVnkHFLM6WPda0s2HD7SnccWfKYtEsdP3vsEMt7dMDGi0IWd4uuzQ2Azjahxbl8HQHiar5/vef58g66yemI3gQGEgyGJRwYPDuZWqisKxscdPL6jmfcLu9EH3a66RaSxQAOaGNdfehsl0P4GFnlE5VKOOD14diemTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOR9i9cGO5i+Sek8/OCu7LSAsgRA+P/TIW/O+cE5Ygk=;
 b=lX1i31kvIS87GJJBcG1NWu5s1ajqBx/ynqxDrjmwpCQVNrDxaxuYPA7osq4VU5yN+EYDUz8KazP8N0bLHmThXKvQ728VvPxmENIqPRaJ90HQCaTJHB9+kMcdLukvewLp+o1Sbm7KfVZMExDFGZiLQIyiticddeMOtPrKASQAzw5PGscqIG7aNWlOh860HRQKBia1WkWvmA4IUP8xuc/7fIbloJNTaK0UGZa746XFpAJXvzY1AtavepHnXShiteaxESCvfwn0AyJMJsU3jCSk6YGDiW9JxNIlnNhwlassIFYIhRuLFrXidBPatBx3ze1MqSLlOXUgSznF5yY+8ZyyYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by VI0PR06MB10918.eurprd06.prod.outlook.com (2603:10a6:800:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 09:07:00 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 09:07:00 +0000
Message-ID: <4082527a-85a7-4770-8312-b27cf3cfd942@vaisala.com>
Date: Thu, 8 Oct 2026 12:06:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/9] serial: max310x: don't clobber the TX break bit in
 set_termios
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>,
 Maarten Brock <Maarten.Brock@sttls.nl>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
 <20261005-max310x-rs485-sw-delay-v7-1-6ae392eca08c@vaisala.com>
 <20261005115737.3a26240eadeff00262e920ff@hugovil.com>
 <a69c09a9-76d8-46c2-9aa3-64b7a961cdad@vaisala.com>
 <20261006094223.f6ebb7729377787ef43cbb54@hugovil.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20261006094223.f6ebb7729377787ef43cbb54@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0074.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::15) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|VI0PR06MB10918:EE_
X-MS-Office365-Filtering-Correlation-Id: 07858114-5b95-4aed-1077-08df251b8330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	AwAdnO/WrpbRvpGHAihanxEHc3ctnbp9Ar0AhMiyeTwzO6A+0dqmAfImA5p+7VYE51cIT26g0pfQjdWoKPVJqFzbRPtCuth5loQ4qOFBOdcBWfus9SFMfLZqzWmZlrn7QnsXe+j1pVQXU8GBO9JI4hrRbxlURu/GawBrphEu3gzvWvPHoRDGZixtHRqZ5yJj1kHFoEPHq4yg2hcAo0K6MyAz6JqE7xt0WUaF387CfZznW1LLtDuNn9/b2chZFHdQUtnrDvfoJ08YuWG1ko6okfX2X1KxCqO7cIW2EA8JJPmlcPsXJ89cEMFlNCH2oOfHKo4Wov+8bQjfkBZ7xRLhnZ4QGklakRX2wTs6ltTTGS4Nh/1PEYN0r+xLYTQ6wgjeQyW14K6GIOufdcNCUwMG6z5nNKLPJWNHFIZ4022jQBS7Bd+plDyNK5rtr8WFremQloFiug/tojrfRWe1bmPJg7HmPYs0xu4YEN2FE07p2/glPtshfppDHhD4JTh+FeYA1Fc/QxC32mY2UZl4OnVIjIOQSTqWWnz2J8eBWfkaq3FLALkFFI1kr/1jQpVuwxCiWeZ8GPAjNzPpiY61LwyEOhPwiyGbIHXsAyLIUVaFdSLIwCrfA3PpbM9ITZUwAOVZTH0+ayoHP+KTxQ52u59TQQ2cBw7oL+V+iviR1RUjHD4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkxHNE9WMVlVY1hXUHZMOU1xTzUvTTRYR0dyTmd1UjFpb1FhRi9mSUVnK2Vs?=
 =?utf-8?B?MXV5cEU5TS9CS1J3MDUyWWhYQjRkakRKWDVlckNMRldhenJyM1BtNTd6czZG?=
 =?utf-8?B?bTNkd2ZLR2xqR1ZXTzlZMG5mS1Q0dWFpRk5KMXVtNHJSREcxaGJYVFVuMG9y?=
 =?utf-8?B?dFdMS2tuUGxRN1ZWbVlrQVMxelNBbm50S1J2Q0htdFZhU1BSYXNROVJzS2Yy?=
 =?utf-8?B?VURWZFpPdnZzaCtVMVFyZW9ncktvcUNPcHAxalNmcXhCSWNaY0R0WStNQllE?=
 =?utf-8?B?TDgrMDdIcmtQelBCWjBKdlhmMnZmMXJPbUVGdHMrQkVWZkc3TjlFYmdqRlg3?=
 =?utf-8?B?VW56NkdZU3I2eFV5c1pKWXJNTUhTUWRmUFFrTU1OWnIvZHE4TzdwOTVEMU1S?=
 =?utf-8?B?eGhRdkttbFU5VnZJbEZWRkhvbDBBN0l1ODNVMGZ4bG8rb281cDNiTWxsZ2ky?=
 =?utf-8?B?dVF3b3ZGeHp4UHZwald2aldOVk4xWXRXQVhqWTM2a1NWaWxlb3VtRVpkaWFG?=
 =?utf-8?B?dFZqZHd0Ny84Mlg3akd0QlZIUm81MEFqT2FMWFRpb2dFdG5qUnMvZ1ViRXht?=
 =?utf-8?B?MFpkRG01N3RjNC91MjhCS1ZUMWVQaDFHdHRIVHhMek9PdmZUUlpLdUJwbjd1?=
 =?utf-8?B?MzN6L05vMGUxSXZEWXRncGVTNjIvMnRDcmdoaGloZHNDVFZibllJZzluRjdB?=
 =?utf-8?B?OElqdXp5Yy9PcTBHcmZDRWFGUlpMQlhnRW1jVDlvSWtvTDV2SmJZaityRDNq?=
 =?utf-8?B?RGdMRHlpV0VWSTdEVDFQVFpobk11S0hqOG1WS2RmSHRzQ0JHNXJGbkhCNktJ?=
 =?utf-8?B?czlTSHFNZmVhejZuMXh4YXBuSEFnbUdJTmhISzY0TzRONXJaTW91dW1HWnlw?=
 =?utf-8?B?enAybHZGWUY4UkFOMkhZekJXZklJWmJTMzZsMDhJSDlVR0NSTzFhc09TMXo3?=
 =?utf-8?B?bENtczJxaWtRalRRYkR0TmVsSVE0QldhTXVnMUx1Z2hKc3NBa2FTUTRCVzBu?=
 =?utf-8?B?Mmk0VnEvUnRsb0gvL2cxUGVYNHZzTHltRGRuNk94SlYxU3lwbG1YUFk5T3k2?=
 =?utf-8?B?WWo4Z3F0VE5oQ0pWdGQ3eTh1bHg5S3JKZWFuaUMzbGY5eTAyM0I2SXFBUTRC?=
 =?utf-8?B?VFVuOU0yNFhHQjVDaUhVbFRDQ2RIVDN5dGVmL1NwVkphV3A2Qkh0NUlhT09k?=
 =?utf-8?B?b3IwMHVTY3RvWWhmeCthTmpPVkt0VlNLd29KYkN1TmlQV2w2UGpEZXhmRlNM?=
 =?utf-8?B?aWtLUW5rUnhwam9LeENheUFmdlRDNUVpWnBqR1lSUEwxOWp0c0tHa1M0MXor?=
 =?utf-8?B?SDFubkRGT2JFZnhsMTREYyt4dTlsMmRsQWdWVUdaOWpZSXNZRHFzY2xYNWlM?=
 =?utf-8?B?TXFSVGVxVnRCSWF0RWhIUHpiZHc0ZVBuRWZ2ZWg3VGI4SUwwTTc0YWFaT3Vl?=
 =?utf-8?B?RmJIQmJlM2M3bm9FZWxMUDlFU3NzWjdpeElVMHZYa3EwR0pyZ2ozd0VzNERy?=
 =?utf-8?B?M3phVjRQU2ZLTXY3SkRERVNueGNpNTRBc3dEZFJsejRQT0pnbVc0RVZiRmNW?=
 =?utf-8?B?akhmbDArQjRrR1h0SWRrbWozY042cWxDRUxrMmFIMDkzeUZDZHlQNUxzYlNJ?=
 =?utf-8?B?QWpGVlRVSnpudkpJQ2dtc2VadUFaMDJHUVRIWnZoOWtxQUhIb21iN0RvY2xX?=
 =?utf-8?B?U2Yrc3UrVzcrYnI0UHJwUnZZYkRPeEJpeEtuUXF5SGFTQXlQRmVlWkpJVi9N?=
 =?utf-8?B?cHlZUzZrU1MvbFlOZ2RTUG1tTTJMNXJFYVh3R3NxZGZSK250a1FhUUlpejB0?=
 =?utf-8?B?Z0w0ejNWb3ZYKzluSEhBOXlOa1JRV3doNG05TmMvbW5VSmUxalJ3eEhibERU?=
 =?utf-8?B?TUVhN0w4VW1hMklyQ1F2d2RyQzVFb0JJN2U3YWk4bTVoUnhRcDBGeG1aOWlL?=
 =?utf-8?B?ZTRMWnhZM1NQdXN4bG03cmVram5MT1o2YXlkY0RIT3lKR3FZMTE3bXpVbXd6?=
 =?utf-8?B?djkvVDBTd0dySWdmS3FRempKMVErUk9nRWQxWDlxZS9YWFlVZGJoQ0hMS0E1?=
 =?utf-8?B?RkRmT04vbnZPK0NKT3pHMEE4WmpWbUNaSmxWc2YxaEwwYjNhalZlc3ZkV3Ny?=
 =?utf-8?B?K3E3MURBQkFxVTFhZUIxNW5NYWY1eGRSaTFsSzY2KytPdDV6KzU0cmlneFR6?=
 =?utf-8?B?M2xReUY5K1M0MUFQSU1QaXJiQzBQeUtYZUZGb1J4UkpLZ0NCY2ZqVkdRZmFG?=
 =?utf-8?B?VDM1bVAzNVA5MUtBYnJLZVRwSi9hZ3RDZ2I0QTZ0QzVZR3FOT3cyY2tlc2pm?=
 =?utf-8?B?MURhRktMS3dyUXhSUlRwMFAzSXNjMzRSM2xGMkxwbng1WGU2MDcrRm56Mk9I?=
 =?utf-8?Q?5XqNYG+svgMuXJc0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07858114-5b95-4aed-1077-08df251b8330
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:07:00.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQV7yrWPpax/f+dVEgV2mf7h2nmGk0+DC6PpfZ1KKBGi1jNPtL7zAnXmkup0P1m7O4dOlt3XdGG5dpysgxzgvgwV8lKAXWF2AUpnvvmdTBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB10918

Hi Hugo,

On 10/6/26 16:42, Hugo Villeneuve wrote:

> some other patches in your series also have a title that simply state
> what is done, but not why, so make sure to check their titles too.

Will do. v8 will retitle the three fixes whose titles read as
cleanups (patches 2, 4 and 5) to name the failure they fix, and keep
the what-titles for the refactor/preparation/feature patches where
that is the convention.

Tapio
