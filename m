Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142E1E0E01;
	Tue,  7 Jan 2025 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736237807; cv=fail; b=WiqT8CDD33wqr9refysvnMyHadCUuPev6osfwj/IBU+Z33cLrnB34f9P571zrJCA14crS25KODtrJZ6ZGWusVMAwRJpPCM8MvjndtCE+Q3BmoyyMYXis+ckwkKbcaF0H1+ppmujR9BaYqUiZcRQNu8h1m5ZEGu1PnMqM6HnJ95Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736237807; c=relaxed/simple;
	bh=XA2gVpLMh7YZbkrXcRPw4Y0gS9CnwLHOForbbNp9KM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KHGk89rbQSefIM3UVj4Kt+j/d5OHhXnFlC9m1F03vLtrvk+w8DWCQRXA/C9+VigxGZXxJQAenyK/Snh9wJfLRTQORnFzfAK8ZK+3BXtZZlQgb7ImEXiwoAFixyWfPz5OjBsiuq+IezURjmz7MRLYNcB7qZNyysVIuyVWqN5j474=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oOQVNTRe; arc=fail smtp.client-ip=40.107.104.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oOQVNTRe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLfBooAHcQh0+Rb/DLjD7Fro+ToI6mT9QRXR8Umj5WpZmTggje3ZuhoJB/uaC76NoR8AB8m5t28F2coWAdSOqVzB1gbBLcpDv5i9NSC2LxN3rhhneSfed4Unic8c4rjapwX9aYylUEzXqsLpxgb6ZP8MzGo0M+NzdnSIAsdzfepfdJGkfmjWPKZ87I98YCbjj8zwxTIhRq8puYavgwiZKm5YsKLHyUZ0Fywcg+kzoErNKsfzF3mclEQ3U+Ytz4EQEdgqVAOo3xmbhiuPrGEIyKjjpRhDw3HtN6gtSNtfN0kbFd5DvWftixMFytouLjYXnGZRhuFu/nL2RM/6zrDwOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1reHugOcErv9BvUJ7vVRQP56NdiJhCH6EZ5WIe5pYQ=;
 b=e/ADqLzKCK4+HT9UrElb4V1/3rmqm+XKjs/CXJCFhnzDWX2T8yvGJ+59Sebi0HFz4YBWqT2sxZ+YiOj4DaZS/KIJyZSHv3W6jfTRC/z7Hojv9K1FaAUGe3mRWM8RCeMnFRGa5Bhv9RdOLk9gxX3E0RPwle9LBRGTrR5ETcxDpXB+freyGBHX99uqgFEvi5N7lgrVNJXzwS1hi9bR1SOvi9iy1RhxPDOAzPiJC7cBrkpdKrOSQAVesQhTuAljDgsrAgF9yUA5Z2IN5ykKeJeerxffzhLU+fttK7R3GUU7YMm/wr1sTpS/JBG4oFp9uVyB1PTn30CMJSO3SKxYH1E4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1reHugOcErv9BvUJ7vVRQP56NdiJhCH6EZ5WIe5pYQ=;
 b=oOQVNTReQcvZnMO7+AXHY5nimsSgJN41iFfyT7IQ5FhAvnMc/rajTF77j7MvaYGU1yuvt3xiZ8M//4YbYtOdXwO04fBSSl+bR+XYnQcQGcqMgwsHO6V+RHgJacea8kpfngkeLMNoLfaM79jCoOVS1guOXFwcTRKB21wLT7r8lc2vrd4Q8tVDHZDLNyQTfUZXAn0frnGEe0j2gYiW9qjirIRyLwtX8vbQvNN2b50I8OA8Kwmxq610/p04EpUz6QtfzWvpZ8xbBN6zDxbIzyZh8BNQszH0k/P7bmnefTq/QzzQe4XAMMEIh1adpIf7bsFKT4FGD7P47NwQpGqgZT/ERA==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by VI2PR04MB10714.eurprd04.prod.outlook.com (2603:10a6:800:26d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 08:16:41 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 08:16:41 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
Thread-Index: AQHbXa8xeDDJ4lnkCkiOGzKD/DUd4LMEwrkAgASWmwCAAG2hgIABNRPg
Date: Tue, 7 Jan 2025 08:16:40 +0000
Message-ID:
 <DB9PR04MB842919A4D63AC7CAC1C3FA5392112@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250103071154.3070924-1-sherry.sun@nxp.com>
 <2025010351-overlap-matchless-5c00@gregkh>
 <DB9PR04MB842950C5700AEE30968FA1CC92102@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <2025010602-cozily-rind-c2c6@gregkh>
In-Reply-To: <2025010602-cozily-rind-c2c6@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|VI2PR04MB10714:EE_
x-ms-office365-filtering-correlation-id: 02244947-cb89-4469-a2a0-08dd2ef39d78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nhWCOqckOBuMzrVuEioE/piaR2SxI/4AnEK3EkEQlMEL91T/+bSWcRwuMVHu?=
 =?us-ascii?Q?otZeO8w4eIyu0aoI07Y7ChELGqbxhPJmQz73vm7+vObxOLYqFPARlhcptxaW?=
 =?us-ascii?Q?NNkOZokePQ2D6lY2dIfO8GW4/tAMfKzgVj1wkizX/XvceoaHKqwIrfZR5q/O?=
 =?us-ascii?Q?iL1AO6BzKgtk3Yfg2DzbSE14l5Q033kUwUgWyglpJPOxD0iEtYk6mQEkmJkx?=
 =?us-ascii?Q?yCd4prOxECCmQGbHsFuETQ1o2dXFyIMl/uamTV6/LBfwUn778Hyd0Rag+c69?=
 =?us-ascii?Q?1vKe6oodTUSaIMvF4SaLmnWkeU9dYCzUkTmLaYgoX+NLaSxRVr0cy39jzlh2?=
 =?us-ascii?Q?lpVtRv9XStmMqEHFPshfKNHnitElC5Du9JI2iGXTdwRQwq1U7J2E/iVSFTMe?=
 =?us-ascii?Q?uo0bGGRf4PirL02zVXeQymku7klHun6G/GPM+dytFrrz9gTL/L/wxZPKiKpf?=
 =?us-ascii?Q?qNP94nfA3aEgOWb8uZfrL+MCJbebv+5Gbn3WnIM2TsbGV77TDfR1gNLtRaU6?=
 =?us-ascii?Q?Poe9Iq3MkEPAisrOfEmXnOmKBJRmAd4cOP+n8vsrbJPPpQA7siv2nYYq7pdj?=
 =?us-ascii?Q?qB1oXuzybbXA3YR0aO2zOGzpeCuNdkk1N3UpFqZVS98/OBLU3SgalLRgcduT?=
 =?us-ascii?Q?lfow/fOGyvDSTpP1hLqRKCWzJAroXD6317+ZaB6JeH6J7/htDZ0rAujAgkrr?=
 =?us-ascii?Q?w3u5EBFuHQdchXpDDWJazasU8kGrVsEVShbVjPLVlvX5vD3V0hxuqJFlGZQH?=
 =?us-ascii?Q?oNY56TnfTgiK3WhjJ/R8Y3bWuLBZU3nEGoxliHGL97tnm11It8toDp4d2WE0?=
 =?us-ascii?Q?2FqWunzAxsnTK3DDymPARcdXXqoWN8jLhxD1PVM5V04qa/3TKamgXYPTOCdJ?=
 =?us-ascii?Q?/t5C23BFKWThcw2lzulO8k+pC4WDKM/BP/uUbUtmVe+RCHOIn3jROxOihbLE?=
 =?us-ascii?Q?tTLm2W2DgyGKJT9byLweHG8YwNUiSNcFltSR9l/BYJS6aD61Oe9HzK9WlfWy?=
 =?us-ascii?Q?/doGaSR9HV6GeRQ8FioSxjSuIScLtufo06N3SoT/ierciBUMEaPXCdC//P0Y?=
 =?us-ascii?Q?xQYY4ILJ40iSfvo9X5rvqkIMGAoZSCV/WMVNURcJ4j2L9zveJeWPj54SzKSt?=
 =?us-ascii?Q?NDDag9Nm4A7cn074DgI4lNJ0WfqgnjOkUyHGwqiDsW8prEbjCXO77PzuJR7g?=
 =?us-ascii?Q?UZmV2vwiL+t9SdaJH4Cz30VEbDPnYcVJc3tBkgdiIMVHsNA1fUbw9ru6B48u?=
 =?us-ascii?Q?Y7gxJ5KGgb76jnhr7Zje4rn8Dqpekk+JX7IZXUiUAPwZydz+DS2VZVoDKhqU?=
 =?us-ascii?Q?i0vQicKOeLV2UzJnZoVzpaT69dyelcBhsHBJiemHLGgtKFusai1biCiqEeIs?=
 =?us-ascii?Q?5G0PiC2bCkJ4WSLJ9EaKx4idqqUT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G9d77qTAhTr0uI9Mm9bKJ5KcSXfLOeXKJSPsDBEHOw58mcXTN6OuykV7/QzC?=
 =?us-ascii?Q?eatM3GJAqmLWJJaykQwtBekurDOQlTFtu4byHriFKBJhHE7jlcSspzNsfbij?=
 =?us-ascii?Q?ot0wWziYKd34BG0HjRRyjt15J1Dv7zNvHAuUsBxAylhMVGqaoVHhgKE/i4UD?=
 =?us-ascii?Q?HZuoaJrRIXydvb0EeNDyxUKysfS3ncPE5VjzBESR67GPcjVt5DZJrnWA9t6W?=
 =?us-ascii?Q?PkrQabfq2DmK44i+2UAn5jks5LdldXxCk2kKojMWvQ9QzWi7gnsWebd1qaZY?=
 =?us-ascii?Q?nb2Iukn+hv4n0+DPG+rGHyQbnaMLs0DYq5tfbgsc41k7PqPQ2Sjh+otGaFGz?=
 =?us-ascii?Q?LklivV/LVF2Sngjf+z0GVrUe7ni3zvj5nze+3FTtj/uEmxoSHjRO4wDcqiUE?=
 =?us-ascii?Q?CAMfvThUZfa+/mTjkfg4jqLRnY9DG7ZizA1YGu7fYZlENk4ETJQDdpGjJqIE?=
 =?us-ascii?Q?GW9/8qwn4HvKuUvUoYLagikyJDfMnl420XTtY47UiH2hM+0S6NhRrttgPqFo?=
 =?us-ascii?Q?Y6hWRkNbsZrl8ReolVMdD1DCK1nJyfE3g0+IxIgULV0LdBCW3tKpKE5Qcz1v?=
 =?us-ascii?Q?+MUkr4PmXkDli6R9rYozmlcz8JH7YW/cP1rwR4lN1AA/hU+5R/DDPI8owNb/?=
 =?us-ascii?Q?0wfejvhAbTp3A6x933KQZeO9nvcvmE629+2ZUzkmOjL+nZZvveWoEvIqrRQB?=
 =?us-ascii?Q?5Plcnd81ZMJp/yrBCmhbsHjpOVY5qmukt5OtiSrEQUm/pz+mQQDpDfL5u+l9?=
 =?us-ascii?Q?05m8zw2mGQOaruVsmwfnErwEB3JSWTqVZJPB6YnVvxa9WPTrTUjW/ipYV4DS?=
 =?us-ascii?Q?KEbTAQMsaSB9V/VtmlG94b92NDSxoT/D71FHD4WJpnVCLCfzeQheR32PxJTp?=
 =?us-ascii?Q?bUy+7b6AMABrgZ27lbgp+pgdkBvyBvThq17g948nNTIRmvTyaFdTk27VbyYh?=
 =?us-ascii?Q?y1PPrzyX+SDIbSFyKKHRRhAdOWveZWQdTU5219mNvZ6xWi3RGOJMJdVkWi6R?=
 =?us-ascii?Q?whGssbGVkuMqMOl6NS+hMn2nmjFc4ZAHaNRnMU+yHD1+w4J96pxPau9bzYBF?=
 =?us-ascii?Q?1cgY+YS9Ruam3Vc/MXR8Ez8TzMGIjybsj2Exw1GG7rKozOLvVBbazhPmX0jv?=
 =?us-ascii?Q?RLl5WEPN3/pXdplzAjXJjzzM4BVJXRTiJm2gQc61kd26xiTJ5TMtNKWkTpcp?=
 =?us-ascii?Q?lay+yWJ0Zi/VTlzGi92gDL3H+FHYKn3lhpdECu+D0BNAgPCKUME8Qtc5WEic?=
 =?us-ascii?Q?Qpzas61m7A0LSIFHcnPZ8DVZapxMMTNI53kdDyufVWvbmrGi+hNK1twr1Q9T?=
 =?us-ascii?Q?nPx0tyxgKrP7sD2m6zn9xViAKiISwrqV29tk6CTXZT8lV9AFtmJy6cBOYqtY?=
 =?us-ascii?Q?QPxRLFwx5zgeCaM6MvVeFvikFzOPMyINuBnYHQFDMW+kU1JjZCo6KjSAD2Fg?=
 =?us-ascii?Q?yvw+SpJ5pp9mwzjX7N7RR67KTiw/1VzJONrRwGQ3L8ihKRBoyd7lvpJfcWsp?=
 =?us-ascii?Q?9EglFTr1pPbQhnEcuKCaMDYeQ4qfuXKPnX22YBTyQZ+OC6bC4NCAymrJ2RYX?=
 =?us-ascii?Q?BvW7A5tcU9dY8s5Oo0U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02244947-cb89-4469-a2a0-08dd2ef39d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 08:16:40.9892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4CPEH1ljxmmo4MnLN6iCEF37r6psyXhZsKk9AmxXxhYsFwZDnpgbep7RPYJeQ5pTFcDF5shXtJnVs4KsvbdIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10714



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, January 6, 2025 9:45 PM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> kernel@vger.kernel.org; imx@lists.linux.dev
> Subject: Re: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to=
 12
>
> On Mon, Jan 06, 2025 at 10:24:52AM +0000, Sherry Sun wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Friday, January 3, 2025 5:08 PM
> > > To: Sherry Sun <sherry.sun@nxp.com>
> > > Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; imx@lists.linux.dev
> > > Subject: Re: [PATCH] tty: serial: fsl_lpuart: increase maximum
> > > uart_nr to 12
> > >
> > > On Fri, Jan 03, 2025 at 03:11:54PM +0800, Sherry Sun wrote:
> > > > Some SoCs like the i.MX943 have aliases for up to 12 UARTs, need
> > > > to increase UART_NR from 8 to 12 to support lpuart9-12 to avoid
> > > > initialization failures.
> > > >
> > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > ---
> > > >  drivers/tty/serial/fsl_lpuart.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > > b/drivers/tty/serial/fsl_lpuart.c index 57b0632a3db6..7cb1e36fdaab
> > > > 100644
> > > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > > @@ -245,7 +245,7 @@
> > > >
> > > >  #define DRIVER_NAME    "fsl-lpuart"
> > > >  #define DEV_NAME       "ttyLP"
> > > > -#define UART_NR                8
> > > > +#define UART_NR                12
> > >
> > > Why not fix this properly and make this dynamic and get rid of the
> > > static array causing all of this problem?  That way when you get a
> > > system with 13 uarts, you will be ok :)
> > >
> >
> > Hi Greg,
> >
> > Thanks for your comment.
> > But I checked all the uart drivers under drivers/tty/serial/, UART_NR
> > is widely used, currently almost every uart driver that supports
> > multiple uart ports defines this macro, this value is needed for the
> > nr parameter of struct uart_driver, also for console index checking
> > and setup.
>
> Yeah, it's messy, but it can be done (for example see all of the usb-seri=
al
> devices, we don't limit the number of those ports in the system except to=
 256
> I think.)
>
> > This patch just refers to many other uart driver patches to extend
> > maximum uart number, such as
> >
> https://lore.ke/
> rnel.org%2Fall%2F20240112095300.2004878-3-
> valentin.caron%40foss.st.com%2F&data=3D05%7C02%7Csherry.sun%40nxp.co
> m%7C4c12dccfce2c44e0a21408dd2e584fba%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C638717679009907376%7CUnknown%7CTWFpbGZsb3
> d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
> OIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Duq3dYJI3va5uRu
> LcPkF8DxP0mMPcYBiflG%2Bc18TiC3U%3D&reserved=3D0.
> > Agree that it will be nice to dynamically allocate everything, but for
> > now I prefer to simply change this value as there doesn't seem to be a
> > good uart implementation at the moment, not sure what you prefer?  :)
>
> I'd prefer not hard-coding stuff like this but if it's going to be too mu=
ch of a
> pain I guess I'll take this for now...
>

Yes, agree, at least for now change the old hard-coding stuff which are wid=
ely
used in uart seems painful, maybe we can try to improve this after further
research and discussion later.

Best Regards
Sherry
