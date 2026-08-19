Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013002.outbound.protection.outlook.com [40.107.44.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076B1D86FF;
	Wed, 19 Aug 2026 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133652; cv=fail; b=UYz+2khZTdBu9/mTG/d5uo49SZifwQ8G3ynsN/f+RBzWeL5OCukeGRFs81klnpxTW8uBC4RKbmIiwrWec+leN2psnh9IykiqFiQTuhOoLlL9aa1JIwvAknia849QJnBaCYB4XIi4r8u69Nqp4IngYZW9cQDhIcIkXVMQTYgNr38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133652; c=relaxed/simple;
	bh=kK2MZAGPYbAsI6zNY+Jxj8SB2VKIzV9nY4+ApV0gsvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rjUNhmi+zjDTLhhT6V4ZCKvLHdwAmnAD/wTF6PdzLfMra7hNKZ5jRcvp6lX3CRl4mX42sExkooLtBtcf17+wR32MxeGK9EQI+xGh2DGqs1OXJYerWFEL1wXFOQO1hJjryAq3/HVwGBnTbRGHGDSil+zL+ADQCIpgTLFCbhJjXwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=QFjyvYg4; arc=fail smtp.client-ip=40.107.44.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="QFjyvYg4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGF0IeC/buX+EfbTUx0q8Hc1In3znwJfl+85acGmN5PmC0+mPU8ryqHCFYsPyV9QjQAXhwuKuAGxvFK+QV93IwCG97o36OBY3lcEC8Y19nXrVTCPFnoPlwGlPdQ1OfWhI+sboF+cc7aB1ErsjnN9yjoiTZEHyPeSDtvAJJuLMkrnc2i5sITOmUaKv/gP8h7vs3VO0AmREDON2waHRQuUDGi8L37gj9KUIL2DeKEymM91G6/Ki4h40hAGxPY/J9LX9wb26nW6oiqW/+LYBxg9IrBnnwovgKl5w5DbPZMr9cTimB8RWoLhVTX+Jw+liiW9MnakjEAPmSlEqegHXujKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tc7qudEF2eM3n0YyGYRgrII4ISTSpe7Q3ds+h8QDVlY=;
 b=qn2k5/HMcbYP8L8WhVy25ihvk0Lt6fVOU+xfWmBfxBkJoLlCPMEasblPiaM2mQD8OE1g5YO0+ST1rFdvItxSnIYFx0ArQ83tn6gvOTiARBREear77z/uvWBuFGeWNyH8N50p9bl7UVtw9rc2L1wJO0RAilOM/QAHj+7mS+BBAKvHk7v+HitNwMb+7HFcA8Ct0DTBBDQVccU73PJ1ejvDqvWCONdnJzaCZTknWDoZUhuQcmbmQl0bpybQp57IUg9Bqhmv0gjCFOdNkjahTChLVK9oyHgaFxN2d4qWiMBkghflaFl31sPk/CH6mbPhnc2yGyeEGSjzHADvmoCyHQ6Xvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc7qudEF2eM3n0YyGYRgrII4ISTSpe7Q3ds+h8QDVlY=;
 b=QFjyvYg48021ldb2IGO6WcX2LeAxJla3SiRmXGKRVrPkdEMYpfvN/4RFUsjCFMZMWcceTQCoBQPaCs5QaTewKRi4TPQtbS9WZ58K5Xn/AM2/jPAuUTZ5AP89vW1zI+f7pRpTKoDfO+qjUp1XFhUu2zJ1TU34iRtEDe5zqRcZUOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by OSNPR01MB7745.apcprd01.prod.exchangelabs.com
 (2603:1096:604:31c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 10:00:44 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 10:00:44 +0000
Date: Wed, 19 Aug 2026 18:00:38 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] serial: 8250_mxpcie: take the line settings from the
 new termios
Message-ID: <aoV-xi0uPEf62-U1@moxa-KabyLake-H>
References: <20260818093918.3190686-1-lilinmao@kylinos.cn>
 <20260818093918.3190686-4-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818093918.3190686-4-lilinmao@kylinos.cn>
X-ClientProxiedBy: TP0P295CA0036.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::15) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|OSNPR01MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: b61ab439-5cdb-4911-0a7f-08defdd8bc31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|18002099003|22082099003|56012099006|4143699003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	QY8MNf5/mVNbalvsN2HEdoN/4mBMNsj9WrUr3DFmc5Ro5+TpzTWEOcPkDjlbWcR/u6JngXy7AnMREh/yntDqAIp1Dgl8Byr4iWvYzLo/+PyPHJnwdqPepVbahvmTKoJ+kt8S27rL5mMO6apRkpQ/clJBjEPBF09c3FjasUGQfqHZnt+/YKkCbeWVcn2H5bN/cL2iO76pAg3oakN99LtOMi9wYeZaAvWjfJx7RBnVNlTtA7qsolk0mrjH5D05l1z3yjnvwL1fzMN+6D4W3qNdNrcCSUklxGhFB82FreFDTj0Vj/O397tXLRfsXBxsSM0VuhcyRoatmRPHcuRni0FRPsRamnEM5lav26ItOrgkj5Pm5fyIWZaEH7n/Kbe5piBXl3yXE5hWvF/xbNFRRMxvZ+GdLpVL9zXnbcNPRofLjpXkV7bR/DXFuANATY9UfgUGep7kbmMxcG48StdaurSn9t+kFHrc1AW2VRq2bkzzj5FJ0QSKZi28KKcAU7VndiicwsXNb8h/feVTHvPcoKH2Szjw3K1W1wEPcgw0RuY7ATXpdIvU4+Xriwb3ZuM8CG+P6P7apdK3hH/AhhZ8ufyjVN5+Nc5XsGl7MUAc3hNfdYFpOd6hOKU0O2KUmxGJt+Hh8yNXgMcs+IfwSlOpvSxto4CjyMPPNvEdtStSrLlLduBqIsqhSL+2WYpHvgvGPnI47yLdcFh73XbaU0heWm1bCJZ4qq+SrnWiVv9Cv5VHRS4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sze7daM7Sw0EJUjh42y39NgbDkK0KJuARC5Z9FVTBIF35IIqQ+E+jVwNkjjV?=
 =?us-ascii?Q?ACbV70YYJgP/5ndWeSf27wo4aH3PuTWemxiuAmp4Cdz2y8GXFw+GndMW9/qz?=
 =?us-ascii?Q?RIahfMQLBg9WumI3CfGlCz4Z5KePHL/D2PnfFJ/puSh5LzZDuxto/ZaSDLwb?=
 =?us-ascii?Q?A4Jhl82hSOKf1483pkMAcb43UGv9yb6CulVaTBzhQMNhddkm16wcKxz0JWI4?=
 =?us-ascii?Q?VO5G+iVbQrZjFvuSI+rcw6ITLHwaMgAGom+5mkDsVxrczC9ENm23bM4Mhof9?=
 =?us-ascii?Q?Rzg84zWv7oKSwVKFGEOx6tN5IId3/CIW0scL2JqJ5GWUq+N3+xNK0gyVZWrw?=
 =?us-ascii?Q?2MX/aawP4qL7Xbr5vlRqenIUf0xDU5MEDTYMVgBvGkakgsILXrfzyJEbodyl?=
 =?us-ascii?Q?LuikLPCVz90QiLTiX93T5CeVIXOneVGl/oMyRDk1WCeUn5wHxBQA6iXkbtfH?=
 =?us-ascii?Q?yMuhol5DIDWz+qz/LoAZGu9WxnSLwWyqamaVWbajTzEcaUreA4Q7fIutyB83?=
 =?us-ascii?Q?za9vl9nGyCqNEW8FUOthiWXWVZePLuRY8k+w6RfKKe9xM3LYZ+9cRGs0yDY0?=
 =?us-ascii?Q?WoXCZg5ztx0aeGqX86O5pTzce3Eo9bf/evSVyFH+xwAqh2fL5HZwzILv/Ewh?=
 =?us-ascii?Q?/UlGCkQXyJZOFb8E1vM42pzAhwipNW+I5CKGvnrz5jTPx8GPQrZJ7pd0AiML?=
 =?us-ascii?Q?xr9HolL0X0hDqqfV+BJffwnQRhuBDJW4xkWwip0HYQv1IwPYbNJ0lCsCtgGb?=
 =?us-ascii?Q?7lWKAUveWWL3vsUbRKqGGafXR/LlfSLm4GY59NXOhHi5y3EkP+SFSVnBE8ji?=
 =?us-ascii?Q?+usrh5d4g2i0nvITwXCngHpRB3z67vcLu+w10AmdCib1NgiBgOAp4Cjnkohf?=
 =?us-ascii?Q?lTJr+/OXhutXGHGtGO9v6kKwysEEa3PHxXQkktBS0ViZ5iauz7JviN7YaIMU?=
 =?us-ascii?Q?og+DFYIUQnqjIf5j5Pl4ckCpO0ANbsEKITFYZaTJZDedtff1tKr1l+A6MJfx?=
 =?us-ascii?Q?EpzXyuzVzgo31BUvMKQ4umnX0bqy/zrMBewB3mOobAX8zyDz57DNIrgrGV9M?=
 =?us-ascii?Q?eFfDeRgu3pjhUroNVplCPP1sGAryNUqfBJ14JoOcJU+vZv6jXH41fQNyU9mV?=
 =?us-ascii?Q?zzcu5NdPj69uz8vD0jBBvehkAAKXD2sSazh7wRJzEeag83ji1wlq8JJaecrB?=
 =?us-ascii?Q?E54wk8wS+gHO5+mwNXb3kHiPKlN80APwEsq7i490DAOyNCH1qKbrnPtxXZvo?=
 =?us-ascii?Q?buY9fOHsRJMKFycHgo0O7MA3sogk4GXgR9qS4jIt1lJUPdTRWxdiKw/C3Rkc?=
 =?us-ascii?Q?JPM/Sy3y9NCOcOBD2hPNY/GCwZkPpneglLimPlsa0+tOH/6pekf4kDd7jwsE?=
 =?us-ascii?Q?d9P4IeEQLPsL/YR9iDJad+iMTFkZLJnBsKVucVBzoqmoBPlJ4o+32q7YPyxC?=
 =?us-ascii?Q?Z2u2qrR1rcLLZunzPtjGkRdnrSgZalr3gNBbmKbLmNlkNzCslEKerij3L6dA?=
 =?us-ascii?Q?1Gh8WStU5VS0rhqMU6HijYht8sBRrFWszMB3joTzdhe+i+b/rTd1DSsB5x9y?=
 =?us-ascii?Q?5NyExCjT0f2nakOCOhehz7MRTuEwiFFI+8TXo9Cnl1bsRewioR277xIzrDSm?=
 =?us-ascii?Q?Kow+3SxT0VonDQSTCFBr3XIisedvUv2RltxeP7STGLxzJJQRhodZPBL8/kLs?=
 =?us-ascii?Q?j4lEOtE1drdxmVizA+lfTVtjLy8em7JE2l8XVdZbr9WoJymBWfPqt3R/4Yh/?=
 =?us-ascii?Q?aeYBbMwtQ5CSF3HkqCgorH2EBTj5QWw=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61ab439-5cdb-4911-0a7f-08defdd8bc31
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:00:44.7662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p245Umva7fZBat5z4ffieu2GW9SVmDKLMdUgYLcy3oC9pZDhu4u2Jx5Zj+m9CFWzciGk2b8JDB2vOVmdFvUB7bSOlK5Zm63v3BzEEZPMENU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR01MB7745

On Tue, Aug 18, 2026 at 05:39:18PM +0800, Linmao Li wrote:
> mxpcie8250_set_termios() reads the line settings out of
> port->state->port.tty, which is only set once the port has been opened.
> 
> uart_set_options() builds a termios of its own and calls ->set_termios()
> with no tty behind it, so using such a board as the console
> (console=ttyS<n>) dereferences a NULL tty during console setup, as does
> attaching kgdboc to it and resuming a suspended console from
> uart_resume_port().
> 
> Read the settings from the termios the serial core passes in instead.
> It holds the same values on the normal path - uart_change_line_settings()
> passes &tty->termios - and it is what serial8250_do_set_termios() right
> above already uses.
> 
> Fixes: 55edf8511f47 ("serial: 8250_mxpcie: enable automatic RTS/CTS flow control")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Hi,

I tested this by configuring kgdboc on a CP-168EL-A. Thanks for the fix.

> ---
>  drivers/tty/serial/8250/8250_mxpcie.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
> index ddd02d5622ec4..eba59f1724b78 100644
> --- a/drivers/tty/serial/8250/8250_mxpcie.c
> +++ b/drivers/tty/serial/8250/8250_mxpcie.c
> @@ -217,8 +217,7 @@ static void mxpcie8250_set_termios(struct uart_port *port,
>  				   const struct ktermios *old)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
> -	struct tty_struct *tty = port->state->port.tty;
> -	unsigned int cflag = tty->termios.c_cflag;
> +	unsigned int cflag = new->c_cflag;

Nit: Since cflag is used only once, while c_iflag and c_cc are
accessed directly through new below, could we drop the local variable
and use new->c_cflag directly for consistency?

>  	u8 efr, val;
>  
>  	serial8250_do_set_termios(port, new, old);
> @@ -233,18 +232,20 @@ static void mxpcie8250_set_termios(struct uart_port *port,
>  		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
>  	}
>  	/* Set on-chip software flow control character */
> -	serial_out(up, MOXA_PUART_XON1, START_CHAR(tty));
> -	serial_out(up, MOXA_PUART_XON2, START_CHAR(tty));
> -	serial_out(up, MOXA_PUART_XOFF1, STOP_CHAR(tty));
> -	serial_out(up, MOXA_PUART_XOFF2, STOP_CHAR(tty));
> +	serial_out(up, MOXA_PUART_XON1, new->c_cc[VSTART]);
> +	serial_out(up, MOXA_PUART_XON2, new->c_cc[VSTART]);
> +	serial_out(up, MOXA_PUART_XOFF1, new->c_cc[VSTOP]);
> +	serial_out(up, MOXA_PUART_XOFF2, new->c_cc[VSTOP]);
>  
> -	val = I_IXON(tty) ? MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_RX_FLOW_DISABLED;
> +	val = (new->c_iflag & IXON) ? MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1 :
> +				      MOXA_PUART_EFR_RX_FLOW_DISABLED;
>  	FIELD_MODIFY(MOXA_PUART_EFR_RX_FLOW_MASK, &efr, val);
>  
> -	val = I_IXOFF(tty) ? MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_TX_FLOW_DISABLED;
> +	val = (new->c_iflag & IXOFF) ? MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1 :
> +				       MOXA_PUART_EFR_TX_FLOW_DISABLED;
>  	FIELD_MODIFY(MOXA_PUART_EFR_TX_FLOW_MASK, &efr, val);
>  
> -	if (I_IXOFF(tty))
> +	if (new->c_iflag & IXOFF)
>  		up->port.status |= UPSTAT_AUTOXOFF;
>  
>  	serial_out(up, MOXA_PUART_EFR, efr);
> -- 
> 2.25.1
> 

---
Thanks,
Crescent Hsieh
