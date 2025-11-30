Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022099.outbound.protection.outlook.com [40.107.75.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA1287257;
	Sun, 30 Nov 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499576; cv=fail; b=r0Or+AwsaXHys03rhZWcg8DbjSqdQmOWNhp5dvzkmpOZ0UAXgm154JYvqpuZFvwb1WZ9EvlcxgGRsq7DdLPcTarwDMNM+0ifIR39pozq9Nq4kG21emKoH6DTSLC4dl9ojGM3SU2U0xP/CiyIU4O3ZgB7DdW4p9EeEbUEHAVjr+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499576; c=relaxed/simple;
	bh=cbqI3JvyHbB14oAQj2eL6O5H+WzCz6tch6KCxU1rRM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qXuTl85Xqz+KNp6eemYiI7BaWYqehIT7YLy7tCV5ElT3I55SU/7yzCmkYZ+IRew2z03S6SeMqK1TwZZi7pbgAeaV7iIumV0X/VBuSQiYBuLEAr+XneGB6SDiZ7MbbfloPlPWVRPvuCACo5ECCNvMliu4NotJSGkeXHTu2SK55NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=fdAMktPh; arc=fail smtp.client-ip=40.107.75.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="fdAMktPh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wv+X+Q2DtH5J09Xk1pJOWbOeY6NfeHb0ebSFepzG8NjWSiOB2A2dewXtSnNtSILMP/kr4es2POCeFece/54th5ysxTx2m7q5yPL3X8VPPasBy3xzBh4a6529hq+D9r3tNggBb8uG8eg6qUdTzfFdx3U986S0YnnqLmoHoHYzncqOXwtuq+nCw3STZ06EYL80DSurW4BqDdRhh1SKqCICHFQ1F7SaFqVUcc9GGySjeQXBaL5J3SCsUBGz/PO15ub1Z/CqE6Gg6YO5dpYVX00LS1ojpWHr5ab6SXKy5T7N53KcLi7YW51AnXNYRqV8pd6POfSa9J7XSWxScghxRH5B8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9ulhTJZOXWCUPTCIvS2UahsJlRXUzw/jGH+GR8Bvzw=;
 b=Tk5mVhNhpkYoD4SXTaOV4Aufjk5U9CrJpVxYPjaAsSDSToQSU2Nkj7bEZ4iSJ2jIg4mI4V1pVX2w99+i4DEAGsFip2roPFIpbgkqa6cr4yRyoeazyPOYd4dP1tJykngi2FIZ5WjRaU3LVBoirI0/5lfhBDcmx1dIwwP/ITY38ft2QST53OAR9zqwen4qHQHlR7t5mZn46dlbpxfGDkY1p1YYrzhITZiqFuzNvgD8qZaNRk5Vq31gsNAJe+d7WN26AM367s7GQ6av77w4hAEmXI9FDwq48OcNfKjKqYATAlJdHIb7X/cHGfV1nEkyGGaDTYOHZqGsdTYACHXtaKVqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9ulhTJZOXWCUPTCIvS2UahsJlRXUzw/jGH+GR8Bvzw=;
 b=fdAMktPhanYpNv6R2jWy6YpfP/X7q8N6xn1hgIwnDVJN7Ewt3gVM3Znct3aK08AR6ycZZk7YHy5egxPkZLf3JQYlh/r0orJRRsgCcA8Kgv3a9aKnrKt02vmg5WRbxUUCCjuLa5k92qbvTPEDd42dxFP/+ivORHNDph1f6BMxdkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:46:08 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:46:07 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 31/31] serial: 8250_mxpcie: add RS485-2W auto-adjust sysfs control
Date: Sun, 30 Nov 2025 18:42:22 +0800
Message-ID: <20251130104222.63077-32-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cbf700-4481-4d94-771f-08de2ffdab28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWFsQjR5OXdLTTBoUmdLSzJ6eGozdXJvVFVZUWlhazNNY0NvK0g4TktlQnZD?=
 =?utf-8?B?aVgrS2Y3QitHLytCSU5KZkZEUFZLZ1lXS1VsTEppSHl4UjdOaTl0bmtZZzc1?=
 =?utf-8?B?Q0xvQ1E5R05adE5tVitOdG1jNklwSGExdXNjZU00MlRuU3lLbVpvNzAyZldX?=
 =?utf-8?B?RS9od2dTUlB2RXFYcWphQzliV0ZheTRqTzRqdUZIelV5K1g4b0FqNEQ0Y3R3?=
 =?utf-8?B?Qm1FWStFdkpFTllVeGNKM2lYdjVPNE0vZWhyREUxWlpEdWdoNDl3RGVEWG5h?=
 =?utf-8?B?KzBnMkpnR2l5cHozQ2liUmVoZXk2aWdUYWhCb3lSdG5TcndvdWZpK3pNcmVh?=
 =?utf-8?B?MHpSeXBtSkpVa05hVVlwWHZTbm5icWRuaVdqdk55ajlISXdweml0R1hOeTkx?=
 =?utf-8?B?M0JZTlBTMndxK1gyOFhyQklTOUNiUEo0U2xkdWxLa1F2ck40cy9iZEtyNDM4?=
 =?utf-8?B?K1FlM2xzYTJHSFBHZytwWmYxa1d2Q1hGaERqRHNmcjBMS2hWSEszdWx5QU9z?=
 =?utf-8?B?OVFRR3VZMFM4WVI2WXlXdVRJU3psTWthaVpwc1M2R3BwRG1HUHlRa0hFZXBC?=
 =?utf-8?B?WFdYVW42MnlxNHdUamExQUZrc29rRUtxV205WVhHN0puamptTGR5UnRSUFUx?=
 =?utf-8?B?N3puY201OHFBNDhONWJNbW9GQ0ZQVUMwSmtjYzNjZGcwdVNkNmg0VmJWUm41?=
 =?utf-8?B?a2FWVSsvY0Y3YUl3eEt6VnJMV0pDVWU0Um1BR2M5QmxkZVVWUFZNaFRQWmgw?=
 =?utf-8?B?TVExakVmUG5CZ1pyTjk3Z2M0eTJGc3lCcnArRFRIU0MxcnpmUnVZQjQ4TGV3?=
 =?utf-8?B?RTZpMytuRy9zY1dVSFY0cWZTYlJkN3RZWUk2UkpRN1dCVXpMek1UOW9hbXRw?=
 =?utf-8?B?bitsY2MzSGVYdXpnaFFXQStJZHJ1OWI4YWYzTFRyeFJpd05HNVdCcmE1RE5y?=
 =?utf-8?B?WFd1a2tkL2c1RFUrZHhnUkRsRGkxb1M3N29uUXVMTDR5ZGVYM2g1RUk5c3Ju?=
 =?utf-8?B?YkJkVnJJdkI1UkZIUWVmRDJ6SlVKY3VSbnB3NlNYSTJqYmovMnFSU3JDNzBZ?=
 =?utf-8?B?dmVnS3R0TmNldHR3S2tIVUtQbDlwSnYrT08zbzJ1dVh6WldJYUYwb0IvWWJJ?=
 =?utf-8?B?Ym1iZGRnbVFNVlNXRjVZNW92cnFrM21jcWUyRXhsNTR1MFN0L3dhcWVkQlJ3?=
 =?utf-8?B?WE1hUTViSkZydHlla2VYem9JN1lrMnhQTmdkODBKdDF4Tm4ybGxjR3pNcU5w?=
 =?utf-8?B?SkFkMzlWNTNkV1N6NkdUUm1CUVVzWC9hYkhKT3h0RTFaOTBDaTR0R3lFem9y?=
 =?utf-8?B?OThWU1JRSGkzY2tUZUhvUHhWYm5LZlFpUk9nSWExVGs2em1SVlcweW1DYy84?=
 =?utf-8?B?R05RcjBQeXBsZ211bDZHeVh0WHNiaE1Ed0pCSS9nMm9FSDFSckxaZUtXU0JO?=
 =?utf-8?B?TWFUL3lSK1NmY0YxUXFBamlBUW5BTnlKMXhtNm10ZUNobXc0di9QZktpU2ty?=
 =?utf-8?B?aHBIMkc4RjFGRXVaOFh2bDhWTkNKQUNhUlVVN0N0MDhZTWNhSDJpcW4wSi9q?=
 =?utf-8?B?QVk1cGNhTUsvSnNQZE9ubDc2bDJocjlOWXFheElHd1NpME55alYzbUJsNnJm?=
 =?utf-8?B?YTh4ZnVTS2xVMXMrWmZyRmF1WER4MWMyRWhwSXVYb0JnR2k3T2w4L0RZNHlN?=
 =?utf-8?B?UE1FYnpycmMyc3pyN3VjVktWT0w4cXZSVzFqZGhwMGVRSzBtTVJMb2daTFBH?=
 =?utf-8?B?VzNMcjlocmxIM1ZaR3JxWE03ODlYbVcxclZiTko3NnNGeDFmRG9ub2FobnlR?=
 =?utf-8?B?b20waXE4cW5yV2MrbHFCdmw5dFdpNTJBZGIwSkE5S3o2WmptLzMvOTNieTJH?=
 =?utf-8?B?V0xPTWxpdkQzb3NKaXF1bVRKQitBanBSNEdXcXQzWmFTS3NIUGtianEwRmtq?=
 =?utf-8?B?UWdRQzNUVjdZNE5qaUlCbERkRmhNODNMbUNNa3hLT3hPNE5lMFE3MVJESlRP?=
 =?utf-8?B?WWpNMFNlN0RxMjg1UWZ0MXVtNGxyaXVGNW80blUyMjRRYlZLY1kwbnpIendB?=
 =?utf-8?Q?FVU6Tm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWplaXFxYmlNbS9EZ3BNYzFnRThIcUl3cHRMSW4yZ25HTXlSd3M0TFFOTGVR?=
 =?utf-8?B?eXpNUDQwYk9ZTUZDYTVjOVBRWXFXd0lkNkw3MU9QdTNnL256S0hCNllHOU4v?=
 =?utf-8?B?c21HSFVzeHp4MzFxRjhnbFNqbkQ5T1V2MW9ua0xoaWQ1aEU5MlZuRkkyOUZ0?=
 =?utf-8?B?NlNFNklTY0VjK1lmd04vK2NkZStCcWtLM1luc21OMVJOSHE5OVNhVk1tc3hJ?=
 =?utf-8?B?QXZ3V25BKzlFQjNSQVhPSHFXSVhLUktSbVBTVFRrMUh0RnNFSnJhV2dkeVlw?=
 =?utf-8?B?ck9EWngxTzlVaWU1dGM0SVNOWTcwMzNnL3VsbWZMRERsbjVXaUc0REJjU0JG?=
 =?utf-8?B?UHpIL3Y0UzVxL0pZRXNHY2hTZmkxb2dvT1VLLzRvUVMwbUZxRFp1SzNLdCtQ?=
 =?utf-8?B?TXJ4NzFDUUdTakh6dThhRDBTUUxHRXYwcmJFSC9PSlJUeEpwdEFjdWZiNk5m?=
 =?utf-8?B?ckFFS1RQZG9DU0NLYkRsOVdMcWlCeDlkQmVqRWhhd0p0RTQzbEdVSFNUVHRl?=
 =?utf-8?B?aDZmVTA5Mk1xQVZEUDhtN3laL3F1M3FZYUsxWUhBZ1h6UFY1a1F0YmRodG9S?=
 =?utf-8?B?dHB2UERUeERzOFkzWFhrc0xZcVNPeWtMT1ZrUU5LR1M3RHExNU1KK1BsZ2Nm?=
 =?utf-8?B?R1lSaDZKQTNLUkJaU0hiOGpraWdxK2hIQk40ZzJJSUxocEMwRDArTERwamZy?=
 =?utf-8?B?Vzh0REdEbjBjMld2SmZkTmlBQldVZHNzSTRkQVJ2UEMzaGNwaTVReXdnd0pG?=
 =?utf-8?B?UEhLOWo3VWNDZGoxVThiVmxIcmIvTUp0QlEzQkkwZmdZTC9qdHlLZ1ZFMEI0?=
 =?utf-8?B?UU9iMnlSN0NwbGp2MDFJRUp3eVd3MzIwS3hBM2RnWkl2dkUxM1M5bFZuMHk5?=
 =?utf-8?B?bDBLWVg1bmpqY1lteGROenI0dDcrMnJidFYxclE4TTRJY1IvcW9oSlRyK2hz?=
 =?utf-8?B?bTZMRis0dlc4Rnh5YVhQa09ENXFYK051VDEvMHE2TmFhR3BNNW1YdHJjVXdE?=
 =?utf-8?B?ZFpaV25FbUZZQTl4OVoyWW1UUElMUjd1MzI3UWVtd0VBbWRxSEgxdmR3UEFY?=
 =?utf-8?B?WU1iU1NZbmRtUFVuZ0E4alNGT0NteC9EUkJUUGNrR1A2TFMrUlNOQ3NlOTgr?=
 =?utf-8?B?QUs4QXFjejZuVUxkeTYzQllzelFIZUtuYXVUSkkxZFZCajBSQlN1WkVJc25w?=
 =?utf-8?B?SitXUnlpQUszcFRWTU03ODBndlhDUWkrVG1hZENvMzFNRVlaMTIveVZldC9W?=
 =?utf-8?B?bmhFeEpzSkxtOGdHN04xODk4K2htdXI5aE5FcS9adnBLTVBtc3FOeFg2K2pr?=
 =?utf-8?B?VWZhczlzZHRYNnhJRHhFTEtZdjNURER5UGpCZzVRQzdMRW81bEZEZzhTTTFi?=
 =?utf-8?B?Q1UxQ2ttYUlPdmJQekVscVloakNJc3h2N3pkS2wvekk5K0ZkR0hSQyt4WTZl?=
 =?utf-8?B?YXFDTXpmcVVGVzZsSlBWYU5jWmRCTFlmTDJ1R3BJU1ZlOU1ueHIzMmpjaUtz?=
 =?utf-8?B?Tnk2b3BHQ0x3TkpKeUhhNnlGT0NBNzk3cUZPVXcvTkhrZnh2SE9Ga1lmUFc5?=
 =?utf-8?B?YVRpWXhGK0NLVS9FalJvK1NOcVVqMkh2ZlRlR2ZXcWFGY3BVKzJQeU5veCtL?=
 =?utf-8?B?TVhmRmlGUXBKbVZQSjdnTFlQam9FTzlGWkpsWlZ5bW1DMUZ1ZHhrTnJIbmha?=
 =?utf-8?B?U0d4Y1lkajdjLzlKZnlNd1ljQ2ZRUWl4Zm9wRXZBcUM3cHdlNnVsYm9iR1VD?=
 =?utf-8?B?V2tQQW16S05SR2lSUGJWMGcyQlBlK2wzdm1VVHhjeUVoSDFiWFZjeEtWNEFG?=
 =?utf-8?B?TWs4SFZsUjVQTEVhNTJQYU1wR3l3TURHQmdNdjJWa1lYSzVhNDI1Zkg4QmpJ?=
 =?utf-8?B?cXZtTnZuNVlRSlVZTU5raWJjZ1VIOEpEN2FCSmkvR3R3TkFpR3o1OGI2ZzZQ?=
 =?utf-8?B?dy9jMDIrMTNiejhmMzdFMm54L0J1RkRmS2FuMG16VGt4ckFDZ0ZjUnBPMUkw?=
 =?utf-8?B?WlR6a1VPRVk0NHlZRU01Y2w2UlZpQzBFOUJ2WnRhL0xwbGJ4cmFkUVpManVZ?=
 =?utf-8?B?Q05lY1hsT0FkTHQybW5GUXFDaUdsQldGWHFQenVIZFh1WTNoYU1kZGovS1FI?=
 =?utf-8?B?VEo4WUZWYWNqNC8zbitnelAzWktmWHFIRnJ0S1BqSXFpNlZLUE9qMXRzMkZn?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cbf700-4481-4d94-771f-08de2ffdab28
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:46:07.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRpbLXYHhL2KZEkGkEzXJkXee/H172GJhhi0ewNaC/kqsf659Mp5irk0tIln8VAbqUDVOouUGOwUnP7TapHEhbinTFZap79qCZ6cGjZ27xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

Moxa CP118E/CP138E/CP134EL/CP116E boards support a hardware "auto mode"
in RS485-2W where the CPLD can automatically configure terminator and
pull-state based on the selected baud rate and line condition. This mode
is not meant to be kept enabled continuously — instead, it is triggered
for a short period (about 2s) to let the hardware calibrate itself.

This patch adds a write-only sysfs attribute that requests a one-shot
hardware auto-adjust of terminator and pull-state. Writing a supported
baud rate value (one of 9600, 19200, 38400, 57600, 115200, 230400,
460800, or 921600) into the attribute programs the CPLD baud code and
runs a temporary AUTO mode cycle (about 2s) on RS485-2W ports of the
supported boards. Invalid interfaces or devices are rejected.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 143 ++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index e9e3d03b7712..b3146cac0298 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -107,11 +107,15 @@
 #define MOXA_CPLD_SET_STATE_BASE	0x18
 #define MOXA_CPLD_STATE_MASK		0x0F
 
+#define MOXA_CPLD_SET_BAUD_BASE	0x08
+#define MOXA_CPLD_BAUD_MASK	0x07
+
 #define MOXA_CPLD_DATA_MASK	0x1F	/* Pin0 ~ Pin4 */
 #define MOXA_CPLD_CTRL_MASK	0xE0	/* Pin5 ~ Pin7 */
 
 #define MOXA_CPLD_PULL_STATE_FLAG	0x01
 #define MOXA_CPLD_TERMINATOR_FLAG	0x02
+#define MOXA_CPLD_AUTO_MODE_FLAG	0x08
 
 #define MOXA_CPLD_READ	0
 #define MOXA_CPLD_WRITE	1
@@ -125,6 +129,18 @@
 #define MOXA_PULL_STATE_ENABLE	1
 #define MOXA_PULL_STATE_DISABLE	0
 
+#define MOXA_AUTO_MODE_ENABLE	1
+#define MOXA_AUTO_MODE_DISABLE	0
+
+#define MOXA_CPLD_BAUD_9600	0
+#define MOXA_CPLD_BAUD_19200	1
+#define MOXA_CPLD_BAUD_38400	2
+#define MOXA_CPLD_BAUD_57600	3
+#define MOXA_CPLD_BAUD_115200	4
+#define MOXA_CPLD_BAUD_230400	5
+#define MOXA_CPLD_BAUD_460800	6
+#define MOXA_CPLD_BAUD_921600	7
+
 #define MOXA_UIR_OFFSET		0x04
 #define MOXA_UIR_RS232		0x00
 #define MOXA_UIR_RS422		0x01
@@ -566,6 +582,54 @@ static int mxpcie8250_cpld_get_pull_state(resource_size_t iobar_addr, u8 port_id
 	return MOXA_PULL_STATE_DISABLE;
 }
 
+/**
+ * mxpcie8250_cpld_set_auto_mode() - Set the auto mode of the specified port
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @port_idx:	The port index (0 to 7)
+ * @state:	Desired auto mode state (MOXA_AUTO_MODE_ENABLE or MOXA_AUTO_MODE_DISABLE)
+ *
+ * Updates the auto mode setting in the CPLD for the specified port by reading
+ * the current state, modifying the auto mode bit, and writing the updated
+ * state back to the CPLD.
+ */
+static void mxpcie8250_cpld_set_auto_mode(resource_size_t iobar_addr, u8 port_idx, u8 state)
+{
+	u8 addr, data;
+
+	addr = MOXA_CPLD_GET_STATE_BASE + port_idx;
+	mxpcie8250_cpld_read(iobar_addr, addr, &data);
+
+	data = data & MOXA_CPLD_STATE_MASK;
+
+	if (state == MOXA_AUTO_MODE_ENABLE)
+		data |= MOXA_CPLD_AUTO_MODE_FLAG;
+	else
+		data &= ~MOXA_CPLD_AUTO_MODE_FLAG;
+
+	addr = MOXA_CPLD_SET_STATE_BASE + port_idx;
+	mxpcie8250_cpld_write(iobar_addr, addr, data);
+}
+
+/**
+ * mxpcie8250_cpld_set_baud_rate() - Set the baud rate code of the specified port
+ * @iobar_addr:  The base address of the GPIO I/O region
+ * @port_idx:    The port index (0 to 7)
+ * @baud:        CPLD baud rate code (MOXA_CPLD_BAUD_9600 ... MOXA_CPLD_BAUD_921600)
+ *
+ * Writes the baud rate selection value directly into the CPLD SET_BAUD register
+ * for the specified port. The caller must ensure the value is pre-mapped to
+ * the 3-bit CPLD baud code.
+ */
+static void mxpcie8250_cpld_set_baud_rate(resource_size_t iobar_addr, u8 port_idx, u8 baud)
+{
+	u8 addr, data;
+
+	data = baud & MOXA_CPLD_BAUD_MASK;
+
+	addr = MOXA_CPLD_SET_BAUD_BASE + port_idx;
+	mxpcie8250_cpld_write(iobar_addr, addr, data);
+}
+
 static bool mxpcie8250_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N ||
@@ -1134,12 +1198,91 @@ static ssize_t mxpcie8250_pull_state_show(struct device *dev,
 	return -ENODEV;
 }
 
+static ssize_t mxpcie8250_auto_mode_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf,
+					  size_t count)
+{
+	struct tty_port *tport = dev_get_drvdata(dev);
+	struct uart_state *ustate = container_of(tport, struct uart_state, port);
+	struct uart_port *port = ustate->uart_port;
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
+	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
+	int ret;
+	u32 baud;
+
+	if (!count)
+		return -EINVAL;
+
+	ret = kstrtou32(buf, 10, &baud);
+
+	if (ret < 0)
+		return ret;
+
+	if (priv->port[port->port_id].interface != MOXA_UIR_RS485_2W) {
+		dev_warn(dev, "The serial interface of this port should be RS485-2W\n");
+		return -EINVAL;
+	}
+	if (pdev->device == PCI_DEVICE_ID_MOXA_CP118E_A_I ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP138E_A   ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP134EL_A  ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP116E_A_A ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP116E_A_B) {
+		switch (baud) {
+		case 9600:
+			baud = MOXA_CPLD_BAUD_9600;
+			break;
+		case 19200:
+			baud = MOXA_CPLD_BAUD_19200;
+			break;
+		case 38400:
+			baud = MOXA_CPLD_BAUD_38400;
+			break;
+		case 57600:
+			baud = MOXA_CPLD_BAUD_57600;
+			break;
+		case 115200:
+			baud = MOXA_CPLD_BAUD_115200;
+			break;
+		case 230400:
+			baud = MOXA_CPLD_BAUD_230400;
+			break;
+		case 460800:
+			baud = MOXA_CPLD_BAUD_460800;
+			break;
+		case 921600:
+			baud = MOXA_CPLD_BAUD_921600;
+			break;
+		default:
+			dev_warn(dev, "The baud rate should be one of 9600, 19200, 38400, 57600, 115200, 230400, 460800, 921600\n");
+			return -EINVAL;
+		}
+		spin_lock(&priv->board_lock);
+		mxpcie8250_cpld_set_baud_rate(iobar_addr, port->port_id, baud);
+		mxpcie8250_cpld_set_auto_mode(iobar_addr, port->port_id, MOXA_AUTO_MODE_ENABLE);
+		spin_unlock(&priv->board_lock);
+
+		msleep(2000);
+
+		spin_lock(&priv->board_lock);
+		mxpcie8250_cpld_set_auto_mode(iobar_addr, port->port_id, MOXA_AUTO_MODE_DISABLE);
+		spin_unlock(&priv->board_lock);
+
+		return count;
+	}
+
+	return -ENODEV;
+}
+
 static DEVICE_ATTR_RW(mxpcie8250_terminator);
 static DEVICE_ATTR_RW(mxpcie8250_pull_state);
+static DEVICE_ATTR_WO(mxpcie8250_auto_mode);
 
 static struct attribute *mxpcie8250_dev_attrs[] = {
 	&dev_attr_mxpcie8250_terminator.attr,
 	&dev_attr_mxpcie8250_pull_state.attr,
+	&dev_attr_mxpcie8250_auto_mode.attr,
 	NULL
 };
 
-- 
2.45.2

