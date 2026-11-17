Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794955606;
	b=sz+uBlHZPuUZDX524Wa09YRlvsJ7O3VlLWNezR9XNJyV8fyQQZYhdMRL3V6KnJa0h06j
	 HChI5sW0mXU36dPu6WyOs5EjQ1kCTrfBQc3K3htuV6mUWfH2l01m8GktIW/vbvOl1v+Cs
	 xM/Q1h+weMhX+X3jYxXMT18SEV/suDOoxynabOR5qcrusBqs4vG3d9iOAPUPoB10umeFH
	 mTs/aL4bRaCtmai3CypKEeuP2AzMIJ4URLJU5DI2ga1pQg+vS1ljSH/tmYTSvPsMWJVdR
	 Mvk/47BrnkQOUhPf95sqvlyUR6ZNolJwcP2SmCVqzAGF4Mr5jme5EYAdWoRP/A6w50g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955606;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2fowSkkdtV/6ZNRQhmDrxQ/BMxU0Lk/R7gHeue9wqz0=;
	b=MxEP+NrUK312jaz9ggI27W9+/RFyPmVBuBIorZ3D1XO9h/yXZJoN3HOIRx+4r8sCx+8h
	 wJR4v6sS6pzmUzcocTnsKxF3JXA/OcwzjIh8e2Kxma+u2h4Kj/w15w8y0n2g2g+aC9SmG
	 0FE5+lzXt1WATzF3QY5db9gHZG4YCxnKOpUh0JRJ/th+o0QyKJuOVh8OY/1JoAlEScPle
	 Mt+rUj6vFJ7Q++aTCC4kY93ojU9wiEPI0KjoPP2GJ02DCty6il7E9RhRd7WFzzPRTESDs
	 U0vrpqU0W9oJ85G9IyoNQIkUTMimrxR5xILagJJhp8L/bjbQCQ1pk2jpQ+kVxoTTXxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b="d57W/Fa5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.60
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68687606A331
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 22:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68687606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=d57W/Fa5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1J8a/tv5HCjDkCI3dEwY+QJAAEsrWwbVeg6FfM4Lx2DVcGFSmLYv1pu1xq4iOMFVubJ0VzLPJMQgbmT0ACj3O7Elv4a254MCZKT9jyFgsBzEFIQfW0mLyOEU6dIm0XlUYqe6jGmqhEswGtDm7/SsEAgfgqhvMeipjEULjRZRZ/1IlJuwA/eStW13Zvbesuo3+ePoMaPaX7h/v2O1rjEB5bm8pDj4dWAvhRtBr63LfW2TmulcJc1obdVcll8D0vx2K0qjIV/ArKSBmrBBtPmHlOavjaLotrB+rxL4nzubZiRHsTJkNxbHl4O1BxtV4eVpIUVLqrOBlWPyb8d+bNtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fowSkkdtV/6ZNRQhmDrxQ/BMxU0Lk/R7gHeue9wqz0=;
 b=HJejT3uwNz2vrmxk1RYmNf7aKZpQLb9ZUGNBG0BriySbb1GaH3T+ZU9bJWPlrABvTxYtgMR60YASSUSK3JBqiA/loxOPXH4OUsnOxNYTgVRi+dCNj51nsqhgAhHqwqSRCONgiH5yhF0WnzbCN9ANsx2p8CBdN7qV8AVTlAVbMbB5yMyzkYQJaUW1vsCrcezpNtWJxP3yYMHM3EtGO1hEWZLgbJMT+eKG4GJIMnDVwCRXBXrETZCsvOkMmkZo0DQqxzdAwdMEpEP0SdPsHRZDegzjGvR51x0MX4yeaSEZ4Lxwm1G4SXXNBsG+GLUW4VoXnnheO+ym2uvg4lBmXozNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fowSkkdtV/6ZNRQhmDrxQ/BMxU0Lk/R7gHeue9wqz0=;
 b=d57W/Fa5EUAtiWf2/yHZ5uNFEH4MD0gr6jqVSJCjUSItSLX/H8CaFZYjQNyZf0Y/nTLH/GmTTbV0qw9h+wldJc9BkWCya7ZUo0wHpYl348R7Wk2ElE5z5mIkfuvSNn+Z5hiOyHYv0y2q/+f4Y0uJBOvsnfK6qW5eq7o4sSVL2pI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11) by TY4PR01MB13444.jpnprd01.prod.outlook.com
 (2603:1096:405:1e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:46:43 +0000
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4]) by TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:46:43 +0000
Message-ID: <edd6bff7-34c4-4c0c-bc6c-b12d7434e68b@renesas.com>
Date: Tue, 17 Nov 2026 22:46:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] serial: sh-sci: Keep TX enabled on TEI while data
 is pending
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org, wsa+renesas@sang-engineering.com
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
 <20261113-g2ul_sci-v4-2-6815e41d90c5@renesas.com>
 <sashiko-outbox-213538@kernel.org>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
In-Reply-To: <sashiko-outbox-213538@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0204.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::20) To TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYPR01MB15118:EE_|TY4PR01MB13444:EE_
X-MS-Office365-Filtering-Correlation-Id: 3985e1be-4b30-476b-08dc-08df44fca666
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|10067099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SdzEpnEZMZEY/OcsnWEhF3sdIgEK+1EjStlxqW0vHfVwC6o3WFgRIs/nWIzFlNu6VrHFYr0llpgVIL7cRNE88DoURZsQhD9xErE/Smwxz0+k79Y/Q5ZviVF1vkpSdlFcbM31rIFsgY7iHdnqYhFLspJ00e8gDWZhdeJS16VC7F287IsWh0GkV6MF+MIUhlzsw1FvumBYYfTPIc6ajYE2Equ4hbMhZQoMWRwM82jdjhLWq+rSF0gmIlNcySvGMeRj8YomdkGn7c2ULoT/1tb1aRnhttQgBWwACYIVDz85Eq26DUf6SlLq1wjWMwMUOIMspr5PSwB7woOe/EK2ipAm1/5kWwxmqXaS2C1xM5rAtihFb0G3cmX2RTAlWg6yjDtMXiTLI1cGf3w5w48qJhZqHJwf4Rm/NJZOu/kQGF4pDgQovoVAR9Ct7LEqgFkLA32dqUO9FeNpVQTL0neqq/vqcvPMIUoVG4SDPh2Vufjt83odUptlp1+nyUq+OxEsaQo/BC4+F7/9oZeytRqz1UXaW77wXh2KVdqDTIHjkxZwNXHaVu7CIHNpplT1/7ZtZDZnG5PgJysL6HXVIB16pgY9Tyge6jN+CRRchNsVOwtGDg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15118.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFdjVmN0M0RiVTZqajlqbC9FWVdsSTVXaUVBMnZsejA5MDRmNDE5VGRUMCtm?=
 =?utf-8?B?aWMyMVE2S0VJN3gxSlRGS3pWVDNsTXpUM21hQUx1OThObmdxY1hnZm1XNGdS?=
 =?utf-8?B?VWMwR2VKSndwbFdzKzM3a0dpdEN0T243RytyUjlBbGJyN3Y0SjRVbG1hcjl3?=
 =?utf-8?B?YXZKR3oyTDVsQ3NiZFZmdGo1cC8yd1RlY2pudyswSkpmK01HSytPWVhiTVU5?=
 =?utf-8?B?R29Hd1UvN1NFM2dCa3M1ZkVhVGVnS0NRak1hZkhVOGtHNys4Y0dIL05pNXc0?=
 =?utf-8?B?MkpDRlZOVVlTZEdQNFd6QVYyTzNnUklWT3hydmVQYytEeG1WbUNDR2tWN3RZ?=
 =?utf-8?B?UVhsM0pmNDUyYWIyaWh6QnFaYTFVZWs2N2N0b1lWbUlTaVFGbXVSZkR3dVkx?=
 =?utf-8?B?ZnU2NUZFNWhCM0lxbWo4dW50d21VUGlMWUN5bzlkdS9TbnJiZ3BGWmJkVlBm?=
 =?utf-8?B?VUZPRVR2UmU1enFlU2l0STJGRU1wOGtwUGNpeWdqOGo4N2JkSkgvMlNTaFZq?=
 =?utf-8?B?dmhuS05nMFdnbXYwOWdwRTNtWkhWeHMrNVY5Sk9haU1ZajlJSkt6NlZWeGE1?=
 =?utf-8?B?THhxaW1HNXM0TjRxWkxDTXhIZ3hCeVYyNE5XakkrNzkzUVdSaEhpVFZWSjh0?=
 =?utf-8?B?YThBcXdhZDRXTDN2c2ZmeFVCRlEvU1ZrQ0lVVWpZSEUyMHJGbFRhREtSTzRz?=
 =?utf-8?B?V05JanJxaEVodjFYWnQyN1ExbGlQVTFiR0ZBRmZYYmRaNTFHdWYrVng1cFBB?=
 =?utf-8?B?TjFaN3ZnYlFIMWZDOUJ4OW1rWlpUNTVtNzBrUEk1L2JwdlN6NTdnZm5yaTN1?=
 =?utf-8?B?d2VHMXVCSmNmWlBWTWFWeXN0S3BMZkI2d1V0ZnFCUHVNWGUrUEc3SHNaK2Vo?=
 =?utf-8?B?blFFekx6SU91MVBRU0t5Uk1XYmNsbVZvS0NGaW51UzJ3eUpmaGwybDI4dXdx?=
 =?utf-8?B?TUU0RFZJWjROMkh0L2lpN09ndUlpTFlrV2IyV0NBOHZEY1RVVU41RUN6Umw4?=
 =?utf-8?B?UkFvNjBod0Z1UnpnK20vc2VPMzk1aXBVWERvc0QzWUE0dm1hUUN2R3V5dWtj?=
 =?utf-8?B?am0zVEpsM2srbjQwbXIyQUtKVzVyNjhxY3k1ZnF0cnlQeGFYWGpIdEt3b2h4?=
 =?utf-8?B?aVJBOXJHUG5pSmo1Q3RkeHBvNlRVK1lNNUtmTDk5ejg3Mzdvbk1OdjBnMUQ0?=
 =?utf-8?B?NHR1UHJFUnR4NFdpOEliSEJmd1dqOGJyNkZJczZ1VTFjdklhdHV5VXFNb2ty?=
 =?utf-8?B?ZFcyeG1hL3pvZ0ZSZkwzNHJOMVBad1kvSEE2d1R6N25wZDdrQkJtZFQ0OWVB?=
 =?utf-8?B?NFVydXk3SDZUamluZUtTZ0hoUmdBNDQvVEEzSCtrcUNpcWZQQ09UaFdOK2tG?=
 =?utf-8?B?UFNGU253a0xLQlRObTB0TFR5akxDa2tqcVQzRk44TmErOXVjalNGbUlJWUlH?=
 =?utf-8?B?dXd1WXVaYWdHRE1zbG9iMnpKVm5OTmlwRHJPMGgwUmJ3cFE2bVVlcVNnNlZF?=
 =?utf-8?B?YmZJRlU2UDFSZ0luVzdydTZWTHhsL1RhVGFla3hnZXJzeHhocGJmNkF4WlFI?=
 =?utf-8?B?WFhqbG14NElwOUl2Q3FycmQ4dFdtUk96ZnBpZjM3TG1GUmNNMjR6MXBZNEJK?=
 =?utf-8?B?cVNUZkNqZzNTVlFwTDJDRUg1SE9mN2tVOTE5N3BaSm15SlVCNGpiZzBUUXJs?=
 =?utf-8?B?c2IrUmVtZXduOVQ0QVRsc0lQNVhyS1lwcTQrNGxhY3RxOVpidXVrNUtXSDRZ?=
 =?utf-8?B?ejR1QUQ1RkdaWkQvanRDRFpmeHo4R1ZHbXlLNklLNWo2eDNxVEVOdUUwaDNY?=
 =?utf-8?B?RXBXZE5jOFU1TW0xQ3lBcFF2bXNTbnFhVEhKN3lJcFpkLzNoV01ya0tQTjdw?=
 =?utf-8?B?cXZGWmwwU2ZJeVo3U1prS05za3FPWmlIeHJzMmdVMTltdC8xaEZOME1yQVZn?=
 =?utf-8?B?bll4cFpKR3dyQWFSMmlpUFNBc1cvejU1QjlBYUsxMkF6MFYxTzZiSlU5My9Z?=
 =?utf-8?B?bDJjUlk3QlgycldyaU1EMWxUbXErNWhuRUhJYi9udU9KVjFMY3c4ZjdhSmZR?=
 =?utf-8?B?M2ZaMGtURjFlbkVZWGsxM0g5TTZuckt5ZS9iblBEbzFvOWtaT09LS0lBSXJS?=
 =?utf-8?B?NURVaU5mTmZmdGZHeS9STTBqSk5QTk91QWRKbTl1Z05aM0dnTm9sUGpKOXhk?=
 =?utf-8?B?Q3NSbGZWbmY4c1RLRlhOd2M3RHgzTzdEK0h5YVBLUEJjQzVsZmNERml1d1Fn?=
 =?utf-8?B?VzlTTDlLRk1EeGY2ME5PSWdzMk9jRVA4ejl5Q20rWjBXZ3VIYWpvOVVMNElm?=
 =?utf-8?B?dFg3eUdGT0R1ZVA0NEIyVkM0R29hNGxjeW9Oc3FLT09yUy9mS1Vldz09?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3985e1be-4b30-476b-08dc-08df44fca666
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15118.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:46:42.7856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPeS26Lc+CKsTmqI0HOy1A9BOD7/NqkfSkL06UKjgBuxwQs+1jZ6cT+kt0QwalFmHsPVk46YEdH6vZoA6g5oY6o4FAgowDxBmlPxO2RpupA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13444

On 11/13/2026 7:18 PM, sashiko-bot@kernel.org wrote:
> [Não costuma receber e-mails de sashiko-bot@kernel.org. Saiba por que motivo isto é importante em https://aka.ms/LearnAboutSenderIdentification. ]
> 
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] serial: sh-sci: missing sci_stop_tx() when stopped in
>    sci_transmit_chars()
> - [Medium] serial: sh-sci: premature TE disable in
>    sci_tx_end_interrupt() during active TX
> --
> 
> commit 2144acd3ea7e3d82d9a7516af61337ce1de099e8
> Author: Biju Das <biju.das.jz@bp.renesas.com>
> 
> serial: sh-sci: Keep TX enabled on TEI while data is pending
> 
> This commit keeps the transmitter enabled in sci_tx_end_interrupt() when
> x_char or unstopped xmit_fifo data is pending, and updates
> sci_transmit_chars() and rsci_transmit_chars() to switch from TIE to TEIE
> when transmission is stopped.
> 
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index 9eb297dbc9010..6df25fef5a5f5 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
> [ ... ]
>> @@ -1007,6 +1011,20 @@ static int sci_rxfill(struct uart_port *port)
>>    *                   the interrupt related routines                       *
>>    * ********************************************************************** */
>>
>> +static void sci_clr_tie_set_teie(struct uart_port *port)
>> +{
>> +     struct sci_port *s = to_sci_port(port);
>> +     unsigned short ctrl;
>> +
>> +     if (s->type != PORT_SCI)
>> +             return;
>> +
>> +     ctrl = sci_serial_in(port, SCSCR);
>> +     ctrl &= ~SCSCR_TIE;
>> +     ctrl |= SCSCR_TEIE;
>> +     sci_serial_out(port, SCSCR, ctrl);
>> +}
>> +
>>   static void sci_transmit_chars(struct uart_port *port)
>>   {
>>        struct tty_port *tport = &port->state->port;
>> @@ -1050,14 +1068,10 @@ static void sci_transmit_chars(struct uart_port *port)
>>        if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>>                uart_write_wakeup(port);
>>        if (kfifo_is_empty(&tport->xmit_fifo)) {
>> -             if (s->type == PORT_SCI) {
>> -                     ctrl = sci_serial_in(port, SCSCR);
>> -                     ctrl &= ~SCSCR_TIE;
>> -                     ctrl |= SCSCR_TEIE;
>> -                     sci_serial_out(port, SCSCR, ctrl);
>> -             }
>> -
>> +             sci_clr_tie_set_teie(port);
>>                sci_stop_tx(port);
>> +     } else if (stopped) {
>> +             sci_clr_tie_set_teie(port);
>>        }
>>   }
> 
> [Severity: High]
> Does the "else if (stopped)" branch leave SCSCR_TIE enabled on
> non-PORT_SCI ports?
> 
> sci_clr_tie_set_teie() returns immediately when s->type != PORT_SCI, and
> this branch does not call sci_stop_tx().  If sci_transmit_chars() runs on
> a PORT_SCIF, PORT_SCIFA, PORT_SCIFB, PORT_HSCIF, or PORT_IRDA port while
> stopped with data still in xmit_fifo (for example, after uart_send_xchar()
> calls sci_start_tx()), SCSCR_TIE remains set and triggers a continuous TXI
> interrupt storm until transmission is unstopped.

It is true that the condition should read

if (kfifo_is_empty(&tport->xmit_fifo) || stopped)

mirroring what is done on this series for RSCI. Will adjust for v5.

>> @@ -2012,6 +2026,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
>>   {
>>        struct uart_port *port = ptr;
>>        struct sci_port *s = to_sci_port(port);
>> +     struct tty_port *tport = &port->state->port;
>>        const struct sci_common_regs *regs = s->params->common_regs;
>>        unsigned long flags;
>>        u32 ctrl;
>> @@ -2020,8 +2035,18 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
>>                return sci_tx_interrupt(irq, ptr);
>>
>>        uart_port_lock_irqsave(port, &flags);
>> -     ctrl = s->ops->read_reg(port, regs->control) &
>> -             ~(s->params->param_bits->te_clear);
>> +     ctrl = s->ops->read_reg(port, regs->control);
>> +     if (port->x_char || (!kfifo_is_empty(&tport->xmit_fifo) &&
>> +                          !uart_tx_stopped(port))) {
>> +             ctrl &= ~(s->params->param_bits->teie);
>> +             ctrl |= s->params->param_bits->tie;
>> +             s->ops->write_reg(port, regs->control, ctrl);
>> +             s->ops->transmit_chars(port);
>> +             uart_port_unlock_irqrestore(port, flags);
>> +             return IRQ_HANDLED;
>> +     }
>> +
>> +     ctrl &= ~(s->params->param_bits->te_clear);
>>        s->ops->write_reg(port, regs->control, ctrl);
>>        uart_port_unlock_irqrestore(port, flags);
> 
> [Severity: Medium]
> Can sci_tx_end_interrupt() still clear TE while newly written bytes are
> being transmitted?
> 
> When transmit_chars() drains xmit_fifo, it clears TIE and sets TEIE while
> the last byte is still shifting out.  If uart_write() runs before that
> byte finishes, sci_start_tx() or rsci_start_tx() sets TIE without clearing
> TEIE, leaving both interrupts enabled:
> 
> CPU0                              CPU1
> transmit_chars()
>    /* drains xmit_fifo */
>    ctrl &= ~TIE;
>    ctrl |= TEIE;
> uart_write()
>    start_tx()
>      ctrl |= TIE | TE;
>      /* TIE and TEIE both set */
>                                    /* TDR transfers to shift reg: TXI */
>                                    /* shift reg finishes: TEI */
>                                    sci_tx_interrupt()
>                                      lock(port)
>                                      transmit_chars()
>                                        /* writes new byte to TDR,
>                                           drains xmit_fifo */
>                                      unlock(port)
>                                    sci_tx_end_interrupt()
>                                      lock(port)
>                                      /* xmit_fifo is now empty */
>                                      ctrl &= ~te_clear;
>                                        <-- clears TE during active TX
>                                      unlock(port)
> 
> Because sci_tx_end_interrupt() checks only x_char and xmit_fifo without
> verifying in regs->status that poll_sent_bits (TDRE and TEND) are still
> set in hardware, it disables the transmitter before the newly written byte
> has been sent.

Again this is a correct finding, although harder to trigger as it 
requires that TEI is pinned to a different core than TXI, which I have 
confirmed in my testing by pinning TEI to core 1 and TEI to core 0 and 
then hammering (N=10000) pair of writes delayed by such an amount that 
write #2 arrives after the first write's TXI has finished but before the 
corresponding TEI fires. Eventually we hit this condition, sometimes 
after 2 tries and sometimes after 900.

Will fix in v5 by checking in sci_tx_end_interrupt() if the HW is still 
actively sending out data before disabling TX.

> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com?part=2

