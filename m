Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0641420B7;
	Thu, 13 Jun 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272992; cv=fail; b=k4GHa9Bose3zbziEl8u1UpRP/UsNJXHEGV7t1f6dnRWXRd5a/YxpRtPu/5N6XI4F7YVpEU5y0QOPCYibg6BDRT/8mHB5QAbOeLKAEoHikyLz2zx89uMFK+tK7tqZNohlK88bWVnxl6BoHZtmH/cE6sMKK2lXwl3TkTR2H7G9ZaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272992; c=relaxed/simple;
	bh=C8WkURUuL55jpjF6kVGFToo8z8PMwzKB3ipK4H4wgdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DVusO04fUxf3tDep1k/wFfgvicoFoejxpbIGrVCR83nVHceWHNxfLOUlsZ0hXvwBvlwyBdZ/wcpMEmsInTx+JjpEuUkB54BJBn79GzormY28YF6jaA4r94w545XUisNi41Z2BXpZShD5ohtrG4XXdWoqYGbawm/Y8+Mn3FA6QVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Z93Jk7gN; arc=fail smtp.client-ip=40.107.117.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Z93Jk7gN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csWnvqi16t/lXI+ksojSCnp6BVkLAUurXp9zSmbewvQehaKD34R2JhB+0ccveEgHAPEBPvOMPooT0ud68EA2BaSudgIunDplPWrgbeVaDO2iCbbUUMZxamibhX583CtpaYsOCoalZ/JhvYOScaJml/894h8rROIZroCMNNFnm65sfEifbuXlLlFY6Hb2jkWGgtGjSy++TDYH2jF6bfu4zzLQ2G+KH/tmkohGXZ9x7898we5dQUrZAoxhobBEb3Tc9X6l79Tjfu6pul1PnPBCI0uCIApeKTQXmfsq2E+0occ2IF3jSyF2C/zaFdwAW5NJZt5jrTWUhZfJ5yj/es0DGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujnSCR9ODKgxaBj18BT3cqyc0ZgNpoowUITVz60HVws=;
 b=L+wcUtSPfSNhRjtCzXwiNxADGSALHieAsvsa5H5qLxdYwRLfuBY4VdjbtHBBdR+q7+nc+qK4ysgCiqZPjfmXcZEGyQU+OgLc0ZYzn5DWPnZ+dxlmt5TC8kCOa41AE6OgUvUdYYfIHCTaSAqz/PpBy+u6SJtvh+YxEjO6Bspzdusw0hxRhCLn1+eTX9gRU0sF4wtMBx78eLFoAaO+OP7+ECFMExkzUo8Ndq1LHVubu8KIA9agYkWF+VrgnhIJt7XDi0R1/Z5oguLRq3wLPlIhp0b91o01WmsV1Dr0eym/NIcmkjYNdQRSMUj2783GHVQY7mlI8F3hh0uGyt8Ilfl+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujnSCR9ODKgxaBj18BT3cqyc0ZgNpoowUITVz60HVws=;
 b=Z93Jk7gNznWX2T/5gbBrx0ZYA/9deZZPJRRZnaHP3KotQvFzGnaGZn3H6/Wh4F8SLx+Iub1MYxYjFQp+eRIv10Fke9v8PDgWwEHo7A0qMf7zmklJOb7WLuwwT29iq0K3J85bV9v3gvVDF6VOZTgXfJBEK0SgTrNkEJj8b5wHIs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SI2PR01MB4226.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1aa::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.22; Thu, 13 Jun
 2024 10:03:07 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 10:03:07 +0000
Date: Thu, 13 Jun 2024 18:03:03 +0800
From: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/6] tty: mxser: serial: 8250: Relocate device IDs from
 mxser to 8250_pci
Message-ID: <ZmrD1wZGha9aC+Ri@localhost.localdomain>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
 <20240607114336.4496-4-crescentcy.hsieh@moxa.com>
 <0d8da651-4e41-4af2-81cc-732f17aab403@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d8da651-4e41-4af2-81cc-732f17aab403@kernel.org>
X-ClientProxiedBy: TYAPR01CA0143.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::35) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SI2PR01MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e9fc30-6def-4596-4b3a-08dc8b9005ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|366010|52116008|38350700008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h5iIV/9dgSo4q+2jQsY44papt/tcTPffc2wkTAQ/0EQQkXvov0YydLiqJSY1?=
 =?us-ascii?Q?BbiFXd4rNJ1xr75m02llPhuopVBP9p1O00y2Yetd4dyOD5egJiceQShoA/vs?=
 =?us-ascii?Q?qXQpWSDo4GnG1p+noc/SLYz8Cq7UDwMQUU9/x9zuRuLSl0lwxtcqXp1uaFY+?=
 =?us-ascii?Q?9mIn8EgYzIH9KJ/Sht0h98wwx1iNXz08PKlsGtH6ojq9OQuVLLIWxREww9+G?=
 =?us-ascii?Q?XIM2Tg2RRfeWlocPTgDakZAC6ojewgw9/hMLOPAqW2iPUUrDeNPVvmIAkuJK?=
 =?us-ascii?Q?laQg0CEJJ39/XY8nXmZ20xvokzAt111rUOXcOHjlv3C3p4YU/T+tUFOvNCtF?=
 =?us-ascii?Q?geWULxfw7OU832Dm/ySvslhL1eLW4Y8PIQfgtMeFcyjplYcS5O6Rg9hU+qbg?=
 =?us-ascii?Q?CDSRAX9Kt1reI5mYUDoW1YwheIOS8FjHnvyEEmelICTRm1eNxCWraQ8P1Mxg?=
 =?us-ascii?Q?kc3iggnrhtDC9LGyZZGDgN0ihoaEGKCgMUbBBndKEMfoNRG6rFfLE6d12tfV?=
 =?us-ascii?Q?pBp9kko1HfEwSbHWoE+SWGrpLD/2r3B0yU4mvCIpx/80tDPWdmiOSMr1KVw5?=
 =?us-ascii?Q?aAAdhD7McS08pgTDjlQ3fUE3+FsCqzhU5o2+vOknmxeFRT6YO1Wd0vtw/p4r?=
 =?us-ascii?Q?ZbElM0DZkYTmVhCexDHaqaHhVroY76wmBOE3a2P5+gaWsNEkMI/0ACXZFH+u?=
 =?us-ascii?Q?ZX2DNliwc9JNpz3K1n/Pi4sjhJmQKE5Xc1h24DAeSh2XLrFjV2ejr7nh4kz9?=
 =?us-ascii?Q?va+s3OgxWx1OmjuN0guV3ESGPShjpyA0DD3NfIdWHqUqysr3eV6ENlcDSZE9?=
 =?us-ascii?Q?S2kux09UIV+qYyVVd0A+GDpbJo7x/3Jwk6n9hagbGRuakAzBsw/pXZ7/5Kn5?=
 =?us-ascii?Q?BT2lF9iReSkPwbkFQRKUSkSN3jxCI6kcNPj7Yerdrvy4EgIl1Kwe7DHB4e1a?=
 =?us-ascii?Q?zHeS6MGii83isIqHI61UqB/UoYjNh7wro0+guWb32ffRQgv4pd0xbalsvXQ4?=
 =?us-ascii?Q?9ECrZ5nv9Qjkaal9mIa/gC+lFFtKujruOgtm12Zq3zlIIJY6VMf6ourZ7ACv?=
 =?us-ascii?Q?0Lx+hg4p2pgW4vMqPjmBMbZYrTwl6xOkA61tBIz4LAKqfH8Taky7tYzZwPBo?=
 =?us-ascii?Q?TD3ZQ4NrIn5XM0+3wbRdc7Bx0d2ihjNKIIfGLPFI5jgHDSSADIXIlEX/FKfB?=
 =?us-ascii?Q?Jar/QolLnZ0yk1nlJNBzF8SA9f6T7m5IzohoRmx/aLafFWLkgFg0Ml3yROCn?=
 =?us-ascii?Q?RMKF9F/5JjFFArwKimqVQ+BugowWUwhipEGLoYwNvArvOm8Bbpsyk3zfKSTV?=
 =?us-ascii?Q?XXLR9bBxdzNVn7FiMBqkIwYK0JzvQfVi9R9IGZwx/KWJapJS9w4dsDwTdu9M?=
 =?us-ascii?Q?b/Z7rqM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(52116008)(38350700008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2zTVc/1OaDe0h0WtLkN7kx2n5iwRHBG+8HlB+aSIT8EecQarftifTWax1dTQ?=
 =?us-ascii?Q?ELsstoNFHwkGizfNzikq2lLAvn+aw4tHMMVTInyCufcIcPxm/GMDQNPDlcme?=
 =?us-ascii?Q?/1ChfjU8C2HAtEbk8Kvtc1LHBRrdSEhDaH9xphixdRhr16z0d10ESdoSiIKQ?=
 =?us-ascii?Q?H65JjmZQO7Rmu72u48UJ2rHT34O5GMOwjTjqS+64XwmDIGeSrB4aL7brWvo5?=
 =?us-ascii?Q?48mBrk6fEKGQOor7XBk+KwM4vFCAVAzTRBQ3BioGO96pdvBk5HlYGtH7RNL+?=
 =?us-ascii?Q?jJwPqOWVIZ8U9L3OSLW+UNMEiK/FT5qGGinZKxKnek7EkiyObjM4wFvs/LxL?=
 =?us-ascii?Q?8NayX/jyHitRt9i2qgE2dBWh4MWHJIJ/KB/SiRjht1lYX4N4Ze33cnsV0UiL?=
 =?us-ascii?Q?IYWoCNIbJ4SAEhQQoCoesuq21c37dDuTQ6ng2EmvK1wn6U0Mlmvihd2Xa8N2?=
 =?us-ascii?Q?mrPnk5WIOtC4n8waFYV5e4u5hbQAxdChVPTv3BfWC1ISwNfNgSFG1u0cm2ds?=
 =?us-ascii?Q?Nk3FYGZI3s0se8SILBVQVq24p4ZX6NefExv34Q5QryyHEZz3jA2ZS6BATAgL?=
 =?us-ascii?Q?XF35koUPMVYIzoOhT3uOFxW2Co1hK3KLemJ5QYleSaJ0K/RsBoc4zTvlzPHQ?=
 =?us-ascii?Q?eWwEOx3AqtBfnzuJRwW+TYjvfKc3uhZ48zeetuymjc154mfQMhlJuVotraUH?=
 =?us-ascii?Q?ESYS57KjllP6FCDvX2WEb0XzAt79ouNuy/BwTVzI7rgdOY2WAZC24g8mKnbp?=
 =?us-ascii?Q?MAsiTMPw6/7zozyH68G6cqoHOwB4+/3Ydb1kgKOWPS068LVH2nvNRP7T0Uwv?=
 =?us-ascii?Q?0xGGIExiO9YKGf4/I+H3wtw1zyo8ZK7Y7Erl1ryQCjy+vovjFCFxKBN3iPBx?=
 =?us-ascii?Q?h5k5M32A4FMbeY3hC/4m1MoWxdJKHbqjYDfeidtfY9jwIjrlvpGCCOybwtBN?=
 =?us-ascii?Q?NeE1IzHO4CXzbgmxCkpn0rpC4wpLhySAe4XDD3FmdsL/Hs2AJA21p1+b6zlX?=
 =?us-ascii?Q?nx7yZXzeaUjiXU9DWMP9UhWYbfpjbfmkB0uPqJUqcvk7+XAzx6gPWDFnNvxr?=
 =?us-ascii?Q?hLiR0rwnpXPCrl0Ll3MkCUHwgB0PED2vFT4lwnvSHRihzpkB+WW5sbmxBFkY?=
 =?us-ascii?Q?DjexlA9FSkfIoeCQTHTTHOuGPpAT2rjM5J99Bd8CSsnIUyVNAkdAjU4oxLDG?=
 =?us-ascii?Q?CatsYX8hycFqe0SEMi5MeFMU9KmCXZiLAIYr5y1wZTVpOg75Op/BRe0ycqe7?=
 =?us-ascii?Q?OdSmafFxD4XchAfCyBvtygAc3BynvkaMzpR+wK6LZ94iFerv87AMTYs4CN0G?=
 =?us-ascii?Q?+pn8Wgd+GnvWgW3AvSVLCWMbnVN8WE7v/gpm9HNYNXNomedUf5BIp9n8YQmy?=
 =?us-ascii?Q?WqUb3yBVYONk4QTT28ANP6cZ+3vvr2oBmHarkSPfvonxVgduNWbmksFn+Obn?=
 =?us-ascii?Q?3UTjK/jLvJCN1hPZiM9tmjyCMDU22g8KHwWZ0oQuGsUyrWmlJ+z/mLs1beHS?=
 =?us-ascii?Q?KXIMtRtdp7PPYy5JAAoyJMSLBm9PnKA5UAz4z06/0T4E5QADnAMv1EvptVA+?=
 =?us-ascii?Q?ePqisHhXjpdqFRL4C2QiQ6KZbQDtyzwRBDxnKOoMNu561JxDswBDbyGrPvdD?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e9fc30-6def-4596-4b3a-08dc8b9005ea
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 10:03:07.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZgQz1BaTlJB5SCmu8SYhp03zl0qifXeRp27pX4uInkgI9Hu0QyBn3+5Hf3gKsLFuEukARj+9uP3Ujes5WzhICjS+6nroYdl2BVvO2tUc1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4226

On Tue, Jun 11, 2024 at 09:42:36AM +0200, Jiri Slaby wrote:
> On 07. 06. 24, 13:43, Crescent Hsieh wrote:
> > @@ -212,32 +187,7 @@ static const struct {
> >   /* driver_data correspond to the lines in the structure above
> >      see also ISA probe function before you change something */
> >   static const struct pci_device_id mxser_pcibrds[] = {
> > -	{ PCI_DEVICE_DATA(MOXA, C168,		8) },
> > -	{ PCI_DEVICE_DATA(MOXA, C104,		4) },
> > -	{ PCI_DEVICE_DATA(MOXA, CP132,		2) },
> > -	{ PCI_DEVICE_DATA(MOXA, CP114,		4) },
> > -	{ PCI_DEVICE_DATA(MOXA, CT114,		4) },
> > -	{ PCI_DEVICE_DATA(MOXA, CP102,		2 | MXSER_HIGHBAUD) },
> 
> How is this MXSER_HIGHBAUD handled in 8250_pci?

I will first create a patch to split the Moxa-related code from
`8250_pci.c` into `8250_moxa.c`. Then, I will try to migrate `mxser.c`
to `8250_moxa.c` and handle MXSER_HIGHBAUD there.

> 
> > -	{ PCI_DEVICE_DATA(MOXA, CP104U,		4) },
> > -	{ PCI_DEVICE_DATA(MOXA, CP168U,		8) },
> > -	{ PCI_DEVICE_DATA(MOXA, CP132U,		2) },
> > -	{ PCI_DEVICE_DATA(MOXA, CP134U,		4) },
> > -	{ PCI_DEVICE_DATA(MOXA, CP104JU,	4) },
> >   	{ PCI_DEVICE_DATA(MOXA, RC7000,		8) }, /* RC7000 */
> 
> Can you simply add this exception to mxser_get_nports() I suggested in 1/6
> and drop the whole mxser then \o/?
> 
> I had a long-term plan to mount mxser onto serial-core (or 8250). I haven't
> managed the conversion yet. So I am glad to see this.

Yes, I know you have been working hard to convert `mxser.c` into a
general driver, and I truly appreciate your efforts.
https://lore.kernel.org/linux-serial/20210618061516.662-1-jslaby@suse.cz/

However, I am curious if a general serial driver can support the full
functionality of PCI serial boards. Additionally, what's the plans for
addressing specific functionalities?

---
Sincerely,
Crescent Hsieh
