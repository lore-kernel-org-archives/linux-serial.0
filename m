Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012030.outbound.protection.outlook.com [40.107.75.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C12D9EED;
	Thu, 20 Aug 2026 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192574; cv=fail; b=QVscQe0YeaQlX19FIB3vEhPleNxr9YGCBiWji/0sHINp2Za+wRF9RYi/VZXdyKK1xxRu/4c39KW7JhqrcouEv77LriUr7PzwK7Qovo2Sjh5xez+D52NxIlnYd4KBoeNBkm2XZHpupK1izMG9FTjVybp1tkRUyITV0SGRLHHmiMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192574; c=relaxed/simple;
	bh=VaZ3xCrsWX+1j2f1lOi/y+maHfgaVtczrXNwqjyf4pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kMjq1EOmJUSYBwaC7VHkbcQX6QNrIkzoqcrTjnb4xv6+9iwqWH0k+mk9ht/fm5Wnjrhn6y4UL1FZaBasnZwpA/CA1m6pOVVcCo+HwSCjPhVYjSPjWCFQmZvRzzSnavMJGlXUE4R1qvE55WHN7Q8i7qEoAz/j3mQAwUzhdIi5ZM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=BGHuDiPh; arc=fail smtp.client-ip=40.107.75.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="BGHuDiPh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nymcwF637yCpkCrXN8r/TzM6kld0s4CeREM0gi3oI3yweut6mHVKNpSBVkvK9k8c+JZRKJb013J6+r4IY9OzgchbacLNzDkzGU9Isgyy9sS+41d4jisOHMGd0kroup/ke9gWhDXhKy/f7JKBVklpwmXiObqvlsim2ZS6ZKxkeeqyMAqM/XYNMUIPhJGcYuz+qzFzMJvwEuSZWyoAuipqMxgu646wRCknyu/aA+ZzGucMe+teeO2A/JBYdC+6+K7OpHgzLMGfSsiOZEHoc6CVXSLgTEhGemBidV/FIqGwa2SSj+1JzCkmMAV7kMFQDEftUBjwlQrML3kLzfJBVaKOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZJQJtmdZWAdJwrxV/3UwVHrTXy7G/V+cRC/3X5pdng=;
 b=kGvHuTNGiE0nPDmKhQQwVMds1qCcyM37uT6/sw9XYEX7hcSYMhgEfdPFH7+LDttlShGOSOEDVilfjRJDkqhEi8IGQUHgUnuPe4mClXRc/BDqPdn+Ks4zQDJ6Nn7yBnrVqCMMGwOOAer4dVeGzyoIGQVZBfQQtUak4+9DhEhLpTFKfU3ryb3uVpZ7tnNo/7qODbyiZZRGRNQzc9ez64wT2GYvXms1lfW9rPLEP6kh5c6deq+WfTuNwddiniqfXgEuoF11iSHXGiI9zA6lqVCuEbod6tCH+IXSKeKQkwweyQg9zWET2y12bHQ9ru4WwlXBWtEloY88lqEyuNThGYo53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZJQJtmdZWAdJwrxV/3UwVHrTXy7G/V+cRC/3X5pdng=;
 b=BGHuDiPhCQKj9sVun3tUECtMl8o0cxiSd7L3aL6SrDgkCysXpZrmiAcAyfJtN9Jf3jfDOzjzuqaBUNj/OzxWd2JIIc9O1MyewFOGQjEXQ3rPOmMxvvlAVcbI3eccXrG1XmV8AdNCgFINQ2DCFE6zS95i9DEnJlqReo4lpySdpqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB4933.apcprd01.prod.exchangelabs.com
 (2603:1096:820:bb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 02:22:48 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 02:22:48 +0000
Date: Thu, 20 Aug 2026 10:22:45 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] serial: 8250_mxpcie: take the line settings from the
 new termios
Message-ID: <aoZk9e3-0UHLGpSB@moxa-KabyLake-H>
References: <20260818093918.3190686-1-lilinmao@kylinos.cn>
 <20260818093918.3190686-4-lilinmao@kylinos.cn>
 <aoV-xi0uPEf62-U1@moxa-KabyLake-H>
 <d4915b7c-9a46-45b1-8b0f-e746772d1e54@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4915b7c-9a46-45b1-8b0f-e746772d1e54@kylinos.cn>
X-ClientProxiedBy: TP0P295CA0058.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::17) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB4933:EE_
X-MS-Office365-Filtering-Correlation-Id: b0eab664-08d2-45a0-1ad5-08defe61ed6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|52116014|56012099006|10067099003|22082099003|18002099003|4143699003|38350700014;
X-Microsoft-Antispam-Message-Info:
	E/bDkRq3TzT43Uyj2no+HCj3UVu2fDMc8UXLWIHoGMdckSpcUha8rffrsLfixldD2hfAtwBti7g40mgalMKUp/w0hVTWXsdOQ+ubqI/taWQM5gbg3F0bV2tsu0Nz6Sa2wB/gQaJjPwkOAMKteE2TEGb96Qy13BSmcQRg2A+FsMVYRFJAOwWvdAFEiC+hz4Uh1zLa7MIAUAp0UjKlQX5dMoXLY1fzjgXzJV74KRtVJ0rywSXvNlC87tLfVVB9R3EYyD4VQXfQjMqsqnhX1c2dtxfPb1IMnhFgLHEHtp2r014OfafjljvCKv/aFe806DyUpWMZzQey/qv3Df0Y8qvnMlCA1G08f4CHK3oAfwGn13gMU08812oGPFjTG594OFzzrKIkvfYd1drUgOV3k8i9zN/DWHkJozZtUtDWUCR8w6WP2Bgdh6rjOnwbnkMTumQiAETSoOKynmeJYr71UAIACnFPXSkRE8cKRkP+5CvjNzToVBuLzZsHYhi1YLKofcSPPvQWL/2U8rd+uAUet7N9jRVpk+gF2UGFZBEGhbVpbeX6OQHQGdnfGURnW4Bn+V+6jlh8J1buelD3sSKiBbrVQShb50h0uTyaxE/t8Vde+jpeImmn5OTWJURp4fkTdDx9OxvU5mA8KznD3r6NekUzWm3A6popHbkInZ5V78G6nG1vpk2BQ1fTLt1Su519lhr6q5ozM33lZKZDIxhvYTXExH6kd6RVDFl4AJvpVw76xjQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(52116014)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW1QMzhtbTQrZzVqUElpd3RzUnU0MUpZeXJ1NTJaOXh6OWZ6QUpSOEt5dVpt?=
 =?utf-8?B?cEZEU3VCdU9wTnFMZFRrbyt1RWRQd3g2ZVJITjhzNkNtTytmM0NXMjlnYVVG?=
 =?utf-8?B?c2VvMDI1UHVLU2FqRnVWZmQvYzN6TFlZcWNZT29TOVVLYUYwQmVOUlQzdDc2?=
 =?utf-8?B?bjlQSktYUGVxOFRQckhkM3hMK1ZKRnR3L0o5dE5kSk9JdlVtSVAyWWdzVm1M?=
 =?utf-8?B?bkRQbGhSZ0lzZHNWbUNuM0R0M2pBTi9obmFaNGErOGxMOThIbENJWHpjOVdE?=
 =?utf-8?B?ZTA5eDdDT1BPWGc0TDZQTzFpdnRubXhQdm1IYTNKL0JYMGZnTlFmMjdTNEdJ?=
 =?utf-8?B?cHJRS1daTjNKVmRWOGxsWExKMjk0QzZ6SE9QWmJDaDJpVWovZU9aMnJMSGMy?=
 =?utf-8?B?WjZ6aC9mdGZ1amFlREllUmFFYjQ3TmV2RlNPbmZPL2lmNXZDSGtWZUFJUU9a?=
 =?utf-8?B?cmNBclFMTTkxNDFsN0FLV1htcDh4MnVKdHZ5c1Zkd0hvazF3MllDTnVjSW1j?=
 =?utf-8?B?b241Y1RWQzFLTXBUL0dmTGpwMjlSL0hFcjBVTUhpVzJDZmZZR2FKbGZKOWR4?=
 =?utf-8?B?NGpJSjZ3MlJmVmhjeVBmVEg3M1F3WmdJeXhDa2dRUUJCUmc0Y1lZKzM1MmpL?=
 =?utf-8?B?MlNjcTV1Witub1czcHdZNTNzRUV6b2pBYjFacmx4OStDVi9waWtUWHhNMUlm?=
 =?utf-8?B?b1RiZU9mVytPMm9PVys4VnBWZmgydzJIYU13MjFjZTZWNXZ6aFB6OGVjRXUw?=
 =?utf-8?B?bEpNaEZIVGpjYlhhYzN2bFMyb25CNk1IcG9ndEpJZ3pBdm1hVEtuSjZac2Rn?=
 =?utf-8?B?RTgyeGFiOWh3WlZtV01RK01UajI5WmFXV2Y1NjNMcTRWWHpkc1oxMXJMRmFS?=
 =?utf-8?B?QTNTZU1uemlNcDRyWEorbHJJUVlOYjl6Q3dlcWhtQk5nYnBGYkdSNTVMOXVL?=
 =?utf-8?B?VDZ5b0xkcHUwa1g3WkdJMmRmVWpvRzJtZlhLTjdYSk5YZG1ETnFtNFBrVngv?=
 =?utf-8?B?Yi9LSEhRcVNYTXNNaHpuSGFkQjJ3cklTalVraXp4WHdJRitwZzYyTEYrd1Rz?=
 =?utf-8?B?aHNiQVgxV0hUcHRMTVJhODVadVJrTkxVaWZCMnZTejNrbWFrdTZSY3hmaHNv?=
 =?utf-8?B?UE1zNldSdzU2Y08rajgrRjRJM2dMNkNGMmQyRE5DUDhvdXJXOHlSYXkzb0h6?=
 =?utf-8?B?UHR1ZjBjemF0OG5zYnBXYkJBbmlTd08xeitjUlVaUHdRT2N4N1d1eFQxcTEw?=
 =?utf-8?B?WFpseFZJZTR0RGlESGFPWGhYMkRncWo5Vmh5WVZOY2M2M004RXdWTmo2cExF?=
 =?utf-8?B?SUFZa2E3ZVQxU09sMTFQMW1lR3hzUWVvVW1ncmFtM2tFSXIweENwUmFDMDNZ?=
 =?utf-8?B?MEFCWGxjdVFxVndIeEVvU3gveTM3b3JPQjFYS21aSEJSSGt2U1hNaE40TTZw?=
 =?utf-8?B?ZSs1S2Y3NGp4VzdKZnRHRlB5R1BOQ1RZcWsvY0NFSmQrZGRaZ09TcHdhazRS?=
 =?utf-8?B?TGlESW5ieHFIcldNRjhtaVU2bmZ6QWgvb2NaaGcxQUxXNkRIeXdVZktvMjJp?=
 =?utf-8?B?eGRYZnlaSlovdzVKRTVmVTRZRWpTNVdJZnJOcGh1clZaWUZkdXNaWjRPc3Yw?=
 =?utf-8?B?QnlxTGsvcDZoV2h6d2lIYUZ4Sm9KUzJDVWdHbHhIRVBySm9FTFFTc0REbUsy?=
 =?utf-8?B?cU9idllNT0lSbTF0UmZpN0VtRFo3S0lQZFNObGlJMFVPNHRQL3pqR2FuNk1E?=
 =?utf-8?B?Tk8zdlRhR3BPZ3ZTbkY4bTVuUC80enBHTmgyRGN4Z0c5RXNkL0xxcThEK1Ar?=
 =?utf-8?B?WEhleXUzRzlQem9GYnNvZ3pmUnhlNE9XbVRwM3RvVFBDSTBtWXNKMkpxYW0r?=
 =?utf-8?B?cTMrd1ZNaU5WYmdwSlZvSDZnRnFlS0NpNFF5K2tKbDFIR3lOS0tGYkxiazFF?=
 =?utf-8?B?QWkrN1hIY216elFxNTlEM1dzdFJVSUNHd2xBeFhKc0NIUEMzQjZmWXJ5ZUp3?=
 =?utf-8?B?RlhHcE5LY0Y3dW1WM3JtTXFsZmNPN2xUQ2sxUmJCUzlITm1ITTh3SndSaU9N?=
 =?utf-8?B?WUI0bldzY2JUcmtWZkJCSHduRFdkQk1ySGFiRWFndERZUjZ2czN2TlRGZDdL?=
 =?utf-8?B?KzZKdm5FcjV2ME0wdzd4WFZxK3JPQnR5Q2h4ZGc1K3RldTlFcnZUVHQxak5M?=
 =?utf-8?B?aGJVODVuM25lSW4wN3AvV0ZlSlRseFdGM05Sd3RiKzhmdHFuQ0tMeEJacVhD?=
 =?utf-8?B?OFZjajcxNGMvR0Rqdk5jT0w0QnVXUitXRUY0dTZibC9OeTVidjRBdEN4NVk1?=
 =?utf-8?B?UmJ0REQxV0FmWTl4WU5RbWRGbStTVGNoOE1rbWNmM2Ntem9FQUJaaHZYc1Vz?=
 =?utf-8?Q?3KBBuOyGNyDSJ/qg=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0eab664-08d2-45a0-1ad5-08defe61ed6e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 02:22:48.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+gYHjTlby1QziI20LjBxdozrgud6/H1jyBCOO6hIaPHk2R8GEO/mB9XQcMVYfvMrC/UaC56LnGuFSAwYLJTj1FEPDR4gB+WfvgCnPsPj0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4933

On Wed, Aug 19, 2026 at 08:15:48PM +0800, Linmao Li wrote:
> 在 2026/8/19 18:00, Crescent Hsieh 写道:
> > On Tue, Aug 18, 2026 at 05:39:18PM +0800, Linmao Li wrote:
> > > mxpcie8250_set_termios() reads the line settings out of
> > > port->state->port.tty, which is only set once the port has been opened.
> > > 
> > > uart_set_options() builds a termios of its own and calls ->set_termios()
> > > with no tty behind it, so using such a board as the console
> > > (console=ttyS<n>) dereferences a NULL tty during console setup, as does
> > > attaching kgdboc to it and resuming a suspended console from
> > > uart_resume_port().
> > > 
> > > Read the settings from the termios the serial core passes in instead.
> > > It holds the same values on the normal path - uart_change_line_settings()
> > > passes &tty->termios - and it is what serial8250_do_set_termios() right
> > > above already uses.
> > > 
> > > Fixes: 55edf8511f47 ("serial: 8250_mxpcie: enable automatic RTS/CTS flow control")
> > > Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> > Hi,
> >
> > I tested this by configuring kgdboc on a CP-168EL-A. Thanks for the fix.
>
> Thank you for testing it.  May I add your Tested-by to v2?

Yes, please add:

Tested-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>

---
Thanks,
Crescent Hsieh
