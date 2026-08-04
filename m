Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012012.outbound.protection.outlook.com [40.107.75.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942633F582;
	Tue,  4 Aug 2026 03:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815589; cv=fail; b=Qg3T1oyRdNm+J+q0zdwrRb4ryUOf8ryuu47gJREkOEEtuxfiyjV3SmjOiOyLn1KUr5CgHx11YwBO4GJUzbWvfU7zpllsEXhHR7hLIWsVCO0JQ4E1Mw2lugS7AvNJQsD31KzbYnq0NZMDIY5NqtIkvrD4+/7RyWkv57nt6xmjiqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815589; c=relaxed/simple;
	bh=mw3fjfi6QrYYpmXNHvJdDsXiYQ9WXchpaTOXry4jvks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QrbYbJkHNyjl+itfkdZPzRmJ3gbhFAJOylLvsAesaoPvCujqGwx45a5aALvrJaJt9n2r9bbtV6ZawTwDbyNKkMHz9oZWLcXgAPbhTirm5lQRPfUqbk8eZ11tfQIuoWZPJvyfl1T+rPQG7swxYV2Z2Dead5ZVMOe01/M3eDPgJRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=amzpRbMm; arc=fail smtp.client-ip=40.107.75.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="amzpRbMm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGbZGW9LWWsHAzDqeWqakcn3WWZBjSLttiQJLIlDWPnVU+H+WnsGr4hOP/h/3sr8gtlQGK4umttZ3ehxHRrK/RonAI+SuiEPKGlUQqxwNoOH48y4I8DQLaAe0e9rBTxa0YbvJOLglYKBcAg+pfYsU7kbAMsW7TaSG1WkEwNoAycWrn9gczRVejFuGthBVY0NQW+MEZfep66gdt7aQwJdNlL7wvd6KO+aLFfNNThZ094zrdgmHYNURadb7w9Y9+xy5DQJHpmtOSmi3rva/hF8Ju9RAKvWMcFj6GM5s1dRHCzf/imL/sTXkQ/sBWPHgFrcttKgE+mKFxC6MOHdzKfg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNLG7J/2I+Vd9e+tn22cBr2PUCyWseJEdSLXeXuD748=;
 b=CJOPgJpWQPT8fdmO30FNYkU+ouqMxj0e7DJdxy3oV/S919rovoNnV7E3t7KxiQuL6+9duhCpc9M/9FNp+sgbVi+ukIn2wTV3Bj3ri6/A+fbLx999NbF5tKU3FAKATukODsSQSvPUsn766HsmB+kxCFiiXgsBpKzYtyqm7S6BZgGvD0r9xi2iNsThUD+lcROdin16LiYPEazp8knl6N5GDxq9bWGUd/fv6l3ix4HuO5T750/bjZ9ssbFKj2rXw0lBhfIlraEYGpwaj6XtZDffLOBGurn23f9WPcJLkqDLZlBW7HSBUWjjXbn/R3GjECSIqYTFPYwtW2vxha0A94LmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNLG7J/2I+Vd9e+tn22cBr2PUCyWseJEdSLXeXuD748=;
 b=amzpRbMmiiV7tLQ6TEjeN+e/EbBmIAF6Is8FpGPQSp3ISlMWW3UfA3uVILBelKM3Ftwpqr4gVMX/dorXTBg5baq7/69lORn5IuEjeYwqyVAfqs3Dd3ndfr9JsXM/i+crO6+dI0438WpbaMv9VCNvEwqkWIPrYaPXpgpftSxTJzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY0PR0101MB4262.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 03:53:03 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 03:53:03 +0000
Date: Tue, 4 Aug 2026 11:52:54 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com, EddieSY.Lin@moxa.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 12/14] serial: 8250: allow UART drivers to override
 rx_trig_bytes handling
Message-ID: <anFiFtp5vP0CtDVO@moxa-KabyLake-H>
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
 <20260731074820.735619-13-crescentcy.hsieh@moxa.com>
 <CAHp75VcRkgsBOYWwk9pUxDvc4-YmSvVn0fkrhPSHHerwykVvWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcRkgsBOYWwk9pUxDvc4-YmSvVn0fkrhPSHHerwykVvWQ@mail.gmail.com>
X-ClientProxiedBy: TP0P295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::7)
 To PUZPR01MB5405.apcprd01.prod.exchangelabs.com (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TY0PR0101MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 61595bb0-5a42-4d86-e55b-08def1dbe22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|52116014|56012099006|10067099003|4143699003|6133799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	oUOq7BRuxBIzH0v0sS9V0IZ7htoZoUSCSTRWAc3xnGMugq9DmP+pHmu4uLKbZiw0kVdHjMFuJRd/gSUp830SMcH+3m8LeEdytBcuLOo9JMTaByC9ydH9wIr8TDOYgzijqUSBJDckc0flXFpAMiEDGw+KlQd0m2tfq0uchwUbX6vs+KSRjlMjX0tFRU/zaamAZr0eHqToDIAo4/5Wh4uJ0ApmT+E0x9HPGbd4yd379DX5xk+3N+6Vpg2bWYM0frXQ93qp/QfN4HzV0chaoEDtedPiSfOFPX2nj5rlE55jgcmkQ1B5kDxvEXCvZ7zOQQCCAvRgUdvfgF7gFE12qYOfDmsB6Nv33ZmVuLySCD8hpkO6Wt9rQh448CZUQPGtMJxfuuavMxQ73ROI8czPUVCgbG4XRWU/4cAneHDqqk0xg6IT47UFwQQgr54ABHq5n7nbQuMSngtGsImjWVUt8EOkgUR67I7Su2NWhzqy4so1l9jDVd4GHvTnvn01Qm/IqBJtF2l8wQ+gY/q9DBsFbMjzGfohd8SNmqd+K1Ke1VQbiJcRd7DpDIoN+myibcjfF3FqRKgOsED30vrwbMhxsyp60rbUesffWSWYDtV2t+0Xwo0KIoKI8yUmGeiMPQF9I4+lMi3Qq9CDD7WH7H1vPgwSqPx6r7XwOiONksrsd8AJzltH6+0FlXQBXGj/fabK2GWeZk4ALAFr05H+YvKU/EBjb30ROdpguRykdwps9He5er4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(52116014)(56012099006)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnE1MWtxaHFvTmxxVlFPUk0rR3NjTFlqbjIyTFZBTSsvQk9iSkhnbzh4WWxh?=
 =?utf-8?B?WStxRHBvT2ZvT0h3NCt2cFMzc0tFU1QrdTF0Y2RrWmlveXFEREhUZ0RRMGFW?=
 =?utf-8?B?ejJrOWFkN3pSbERWUmFtSUdrMU1uL2hPYW5vNU1SclNLdC9TbzE3TFU4ZzZB?=
 =?utf-8?B?bzZ1akNwRjIrZlFOcDR0ZmRKQzJpbnhMN2ZsK2MxYzZmemFwTGpxeVBkS01x?=
 =?utf-8?B?aFZON1BEMGx5RWx4UDVnbFc1T0xIZ2k3Zm5KR3NnQ3o3NllQOENocW0zc0tw?=
 =?utf-8?B?TTlBejdsSWZ4aHNyd2NVSFpjMFZ5dFpTUDd5T3NCZnViN01KUm1QM2Z3V1lC?=
 =?utf-8?B?MnkrYW01NExZU1lIY3JpQ09qa2g0TEkrc25ZaXptOGMwcWoza3o5cUlkQjR5?=
 =?utf-8?B?WWw4aGd4b2NubS8zMmxWVXB0ZUVkK3laK1dGS1laUW9oU0RFemtIUGhvbkJo?=
 =?utf-8?B?dXlHUDNNbm1pNGxGRkhkTFMxdzZpdU40NTdPT3hBaXRiUlIzUElVQkFtd3I5?=
 =?utf-8?B?SzhMdE9Wa0NSbTJxOW95RUxxU0o2Uk93N21OWHBxVkw3WTJqRGtieTJXdm9v?=
 =?utf-8?B?b1I0OVhiNE1xd3JRVWc3MDFWSnRyTFNCVSt6UUFxMUk0aml0UVRSYWRZb1Q3?=
 =?utf-8?B?czBtcVhSSk5qRDlseVNOMlplaUxmMDhOOFFNS1lIRVJiWUpUL2N1b0FMbEN0?=
 =?utf-8?B?SG1ZdWJEQ2tKNTJ6T091VWhlYXlNOHhnTm9tZ0VWdnJjd3hqekFmcWJWdmlV?=
 =?utf-8?B?K0cxamxjbEZ6aXVZNklzbWRpNlZhRk1vN0s2OGZKOTluOXd4TEF5b1doNzky?=
 =?utf-8?B?OHVXT3Y1REkxWFMrMnZRUlJ5VDhNY3N3Y3U4cjBLeWNDYjJFZlN3Vm10Nmht?=
 =?utf-8?B?cEduVVBsa3lKWjJpREhVaUFGRVR2L0dTZGxHd3RIZDZsQi9YNHBVdVBVNExw?=
 =?utf-8?B?MnpTOGVNZkFyTWNtUmFOeGpQdlNYRVZLQWZqQ2pLNVRkdXJiMGhIR0VBcFZa?=
 =?utf-8?B?VDk1TFNWajF5TXBHMmFkbCt1UXBuTE5laHUwRHd0eUtlaEF0YjhwUzVHUzdO?=
 =?utf-8?B?OXA3K1lMSW5HRThJWWI3QlBHVEVDV25ZZE5FbXBmd0lNNEw4TFpSRVQrYjUy?=
 =?utf-8?B?V1ErT015azNnRElvRVBTNmRDa2dDb1phbjhudjZxa3p6UGUxNzExS3VITmpO?=
 =?utf-8?B?SkNicEpaYjNMSzFMTnZ1clFzWHpEbkVhRGk2OXJGK2pMYi84a1RQSEhoSXBY?=
 =?utf-8?B?OHBiUjE5QWtrYWRDOG5IaTFsQ2pSU1pORUxQUitzVFlOZWR3bXByeE5sNWw1?=
 =?utf-8?B?TFBJYnROaXJlUUFIRDhGZWJuOG96WGg3VzVObGorKzFVbVBuOWE3Q1VzWVZY?=
 =?utf-8?B?VGJzemtVNVlYVDR5VEFZS0lBNFV4UHZldTZ4WVVENFVlSzdhM0xjRlc2aWo1?=
 =?utf-8?B?OWZwK2JzY1ZUNExxaGJvb1pqcHI3NmpoMDlUOTFIaFRSSnVFZFFEdU5JZ0V1?=
 =?utf-8?B?ZlgxZFNNbjdVcXFyd0RkUjh1bnMxNHZPTXpUUmNzdG9jd0pGZTRrWEQxanF4?=
 =?utf-8?B?K05Eb3k1QisvT00rVmlvVlAzcmp4ZElPa3FxZTROZ25JdWk4QnNpOHZBT1BB?=
 =?utf-8?B?TnhDbGQ3Rmo3L0NLTU9IckRDc2NoVmlDeG1iTzFmN1VvQ2thTXgwZTUzbThY?=
 =?utf-8?B?VEFSb1ZxVDJSZytDLzUrSTRyM1FOVytoWTVCdm5lSlg2a3phTEpJbTFhQTVz?=
 =?utf-8?B?d0V6QmRNMkZqOWVFanZaOUVmVS8rcGlXdXNsKzJFa0dhSTBVaHRuVlpYa3Fh?=
 =?utf-8?B?UU5oMjRtMGVwaWd5SWlxdGZJTlBxMkpWTzdLdEhBZTBlRldQWGhKL0xMNHBN?=
 =?utf-8?B?dFd1ZERieFgvcWlXM2tiRk1MVFY1bmhoa2F4MGJ0TUZ5OU5NTThPaGRWRTcy?=
 =?utf-8?B?WXAydmZtVjBON1RCZmxYU0xDOHZ3NXhUL0Y2ZVZiRGt6dGZXNGV5QU5yMTJ3?=
 =?utf-8?B?VUY2dkh6OElrc1VGeWFmVmhXeTB4cnFYY2EzbDgrNW9kTyt3eTZUdEU2Vi94?=
 =?utf-8?B?bTlxRGV5WnRPd0ZMWHNWWUN0V0VmTVE0cHBpeU1WdXM2TkU1cE81dnRqb2xE?=
 =?utf-8?B?RHA1bXJIUWNudUtSU0R1aGx6YmQ4UFNSbW1Zem4rcVErVjBOVHJxcGJjbUxv?=
 =?utf-8?B?d09wbGVvZHppN2cyTFJFK2pFOVcvd2ZqQk5FVGJhcmsxdmpiL2toWGpyUUlQ?=
 =?utf-8?B?SE03NEpVL3R2MGZ3empRa3l6c1RnOXlCdzU5VExFc0FRT3hGTW5zRFlEdEw3?=
 =?utf-8?B?VFgvWFBMTG1tNXl5eHUvQWRiRUM4dmpLT1FIVkJKbDRya0loNTVpOURXMjhm?=
 =?utf-8?Q?roozgBskW5Oats+Y=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61595bb0-5a42-4d86-e55b-08def1dbe22e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 03:53:03.1608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH9fNNxcKvl1Yb/y8Lpkb1NRkZyu4WL1kIi8d+CJPpD+dPnDps+smnzTh+6/R8JLrYxHONZusrt2G+HU4I9rmrrIVltxlvLUxjJJyz3bQZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4262

On Sun, Aug 02, 2026 at 12:20:18PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 31, 2026 at 10:49 AM Crescent Hsieh
> <crescentcy.hsieh@moxa.com> wrote:
> >
> > The rx_trig_bytes sysfs attribute currently relies on 8250-internal
> > helper functions and assumes a fixed mapping between trigger levels and
> > FIFO behavior.
> >
> > Some UARTs provide hardware-specific RX trigger mechanisms that do not
> > fit this model. Add optional uart_port callbacks for setting and getting
> > the RX trigger level, and use them when provided, while preserving the
> > existing 8250 helpers as the default fallback.
> 
> ...
> 
> >         struct tty_port *port = dev_get_drvdata(dev);
> > +       struct uart_state *state = container_of(port, struct uart_state, port);
> > +       struct uart_port *uport = state->uart_port;
> >         int rxtrig_bytes;
> 
> Hmm... do_set_rxtrig() and do_get_rxtrig() do the same, but under the
> mutex lock. Hence there are questions:
> - is it correct to have without mutex?
> - if so, why not to propagate these (if you really need it), to the callees?
> - or should these callbacks be integrated in the lower level?
> 
> > -       rxtrig_bytes = do_serial8250_get_rxtrig(port);
> > +       if (uport->get_rxtrig)
> > +               rxtrig_bytes = uport->get_rxtrig(uport);
> > +       else
> > +               rxtrig_bytes = do_serial8250_get_rxtrig(port);

Yes, the callback path should be protected by the same mutex.

I agree that the callback dispatch should be moved into the lower-level
helpers rather than handled directly in rx_trig_bytes_show() and
rx_trig_bytes_store().

I also think the function names should be aligned with the naming
convention used by the other generic 8250 helpers for consistency.

So the resulting call  flow would be like:

		      rx_trig_bytes_store/show()
				  |
				  v
		     serial8250_set/get_rxtrig()
	                          |
	  +-----------------------+-----------------------+
	  |						  |
	  v						  v
uport->set/get_rxtrig()                  serial8250_do_set/get_rxtrig()

--
Thanks,
Crescent Hsieh
