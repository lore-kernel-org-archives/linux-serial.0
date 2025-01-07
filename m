Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6C7081E;
	Tue,  7 Jan 2025 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736243691; cv=fail; b=Ihhw3u0or+8KPBROGZddqIdQ7h7WYEIRJYRWg2p0S2d5JnysjjLkksd8yXXDt/GH4PHCjTI+N1bvhanrvFNySXx7d3BsJnJLtENltAazzR4S97gvhgwahChK+EGevzw3hpPPzv0ILFyxgT496M5z4w1hrea7LmcsyZdSiDUMi8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736243691; c=relaxed/simple;
	bh=EYumOaxAoDiSv9fG6xuSZdcBCRdaTjhiN2MQXc15yD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NWMODlwbpl3ZbBrZEijnyFxLZyyZEl62QIGnXu6hpnhICjrj4qyWJIf2NrZef5IrCUI/ftFt9qiQS2XRWo5nbJfpHO4W92Q94Fv3SvX+HoEs/MxeNNrFjPFZwLMoLE8QmkzLoZXyXxmoVfrGBpNW4nbZBUuCuO1nCX1tuzEg+yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jELSImey; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jELSImey"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elN3+7LF1D+X9Uquo990kfb+8vIAoo2FnQnC1otwbgWYw/jP+CnEbr0jIQS0knjhUNDeiQLFR6qh6+ELbCih9/3I9tVu0yqB3OaDfAvbSQKRUzUUWkGcytVG6kvWjJ8JOypEKYuF5bJzTdGSPbWTKzUC9uyDbP7dpcVO2OfpgqbVNkhns0hnn7JNBFqM4lK96RvZ/NKgoVI/OrEkZk0Xsxq3Sl8YznP13qiYFZ4j8xfBxbFIA6Rlb/y8ROYgIu0AKrHuIOpXp5dS2OfbNsIRklfxOeAfLhlF5BSjZzoX4YDLG/WOUOMlL+2fkj4r/+fgqqFBFoisb5+9LJVbLdKwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Tzn+fsllIgzGbhsp6EiwwOT/sj4050BIWV0b2p2Gg8=;
 b=XVdSaobRcV2nEmQ+nZa2tESPVIQWspVc/wlBf+0+i5yJe9YH8JefK9Rciscx63QGLw2qqSMUyW+I5q/TdyYaMYGgiahh8eiKOQjZmZaAG+jpS/eqiwkth15wbS6Tgm/Cn7KokveKtULZLZ8bSmdNtlRrZy/qL2Id6M+SB7HMrP6PKlikUD/ZihFvFTWPTMKDuE0KIznyNV4FUxrX2aXbmxoYqfQL9nPlqbwIqtc3rtHmiF2z6y79BwpAVQeAw7yrdYVpDUkxCoaInl3tNA5tf3IIzBxQLJ5tviI0IKDRSP3kJq+zkOug69HthC0xzwyZhklG+WcKL2DL+Zqe/QNgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Tzn+fsllIgzGbhsp6EiwwOT/sj4050BIWV0b2p2Gg8=;
 b=jELSImey9jG/+Nbyu6lruUkWhzKegsR580HR3+m03iH/xnTHcA7Gp2ixOFAdPorns816ygFLJdE1CCK54WjSkpczDyvsDSLmd6TAynuP45EWGTIE2ZNTkP6sna+R0dWyTvhPADC1ZqOVrgx/XsJczEXcITcdTmreZkTPBJXfAmC/xnL7hbcke2pIiyXoYDafmMctBunQeTJWs6GQw2U4Ewy7I+rL+BXC0QDekkwtgpfuLE1vqtxvrSKEEJd52M99ypiuDKNNiD/PvX/t2hgyVD9Xz1iPkkzCmNB945bgZ9Fcmi5Yt+z4vGUmCaEhD3cZ0Bh2YdFb+0SzaP2wLcnfeQ==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DB9PR04MB9402.eurprd04.prod.outlook.com (2603:10a6:10:36a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 09:54:45 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 09:54:44 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
Thread-Index:
 AQHbXa8xeDDJ4lnkCkiOGzKD/DUd4LMEwrkAgASWmwCAAG2hgIABOQ7QgAAFDQCAABHroA==
Date: Tue, 7 Jan 2025 09:54:44 +0000
Message-ID:
 <DB9PR04MB8429E68D7A21BD8196CEF1E192112@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250103071154.3070924-1-sherry.sun@nxp.com>
 <2025010351-overlap-matchless-5c00@gregkh>
 <DB9PR04MB842950C5700AEE30968FA1CC92102@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <2025010602-cozily-rind-c2c6@gregkh>
 <DB9PR04MB84290597CC2BA6CFA096849B92112@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <2025010738-uplifting-avenging-63e8@gregkh>
In-Reply-To: <2025010738-uplifting-avenging-63e8@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|DB9PR04MB9402:EE_
x-ms-office365-filtering-correlation-id: 3e3da343-eeec-40c1-0ad2-08dd2f01507a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sGcZ9rmCpgRgF4k0ulgaq5QXL8A2BDRozJ/0bBRJB7x/N3jkqzqBbuJGJHqv?=
 =?us-ascii?Q?ugbzeWcnBrHDdLkLIz0xxNxw3I0EWA4ruVxZJso1hqjcT+dPBVuFX3AZ3Qpd?=
 =?us-ascii?Q?pjK05/WDNrAVzFJrraw6dQ1KkwFKaZhMQFI0eren4JMdw9bfKq0hNmnKBQlG?=
 =?us-ascii?Q?QBK+tFDxDHMt5Nur5CXRU7badP9tHwctP120XssMWFtoGiKwx2MvlGXQXzqF?=
 =?us-ascii?Q?VqJQwbz+1Nt4bEsvkc2B0gRiJD+9TIFYUsE+Hgr+gUd0kDXobgjRf8D1pR49?=
 =?us-ascii?Q?Y5JlLYs36yRMuTAvUs36SdJbH8tYa+9x/uQ7VJ0bLG+1WoabBvmSeAK2qLUy?=
 =?us-ascii?Q?6byfIE/m2rk4MTuxia8gKLIsu4MNXKdcpcasSQVIAhZgVKZEvMdPrY40dLlY?=
 =?us-ascii?Q?v+dCq2PSW2NdGCzYxXnpljMRnfLq579kfZmliINOHzoCtYZU6e5j8Up4wdEa?=
 =?us-ascii?Q?wa6U4IIfBu3tLrx8aVLNjrpaWYUixxoqI48BDuq7kBuivJampDShC3fYPB4n?=
 =?us-ascii?Q?vxmBipHFMH8djszbuS02bh5T+gzzFEWBQGfk49RcZS8X6As6Efh72kLa7KO0?=
 =?us-ascii?Q?TeO4t2n848UYfYchdy8CryZ/SnpXkUX5OPqsSt3zTwU5Yp1urXdx+VnQdmo/?=
 =?us-ascii?Q?T9fNG0Fw6JRByaTsyZi1gyzZ+XlbqYu/FxBB+j81J0TZAwtQ9lU2jeUtFEf9?=
 =?us-ascii?Q?W1z5ERSOPSM48VlYTCVuXK18dUnEBKZYmcx80yz2BqxdiuJhyQ/IFtEf7jHs?=
 =?us-ascii?Q?xCRHBJNanc+iSap4RRkU3HxeDK+Mef70VSTk1D4PhNzq0/Y5DBwA8kxo0nE/?=
 =?us-ascii?Q?QVoCX1XJIXeu/A6OcvbTcuyY3P/BYlkR/wMLYONqVXpdNrxeTVpvjKWBf8in?=
 =?us-ascii?Q?+IfsHDjONfByU24DuOQI/xx52lNkZKyT79lfmhOvaL8w1eN552J2EZZqzRzP?=
 =?us-ascii?Q?5g91Xrb+gw+4JaAZYpUIJadg7Ye4Ji3tY/2rhTBiOwIbTDoVBQBDZIruNKWK?=
 =?us-ascii?Q?K8Kt3cWDdsZMd1PtPvnCqKYPFP7Ji/q7vRGBxLihbpw8TX4OwruEPo3lryDX?=
 =?us-ascii?Q?bSZClNfgOi2TNHjXTM9fMimmRZkMhmx3ub+Wj08vQlLPF7bjzr2E+DC6dKMb?=
 =?us-ascii?Q?5lx0VGu6HgPBmnPak2dHKxjO3OnDPvekJx1VLqkKM7mWaBnwyHxoh+4IvWzW?=
 =?us-ascii?Q?y7XsY3XURJKQwBSTWx10S/h0VPZtwU9hCvxmjGoE31wVYQi8adb1mDB1phMx?=
 =?us-ascii?Q?57IETRrvx8z0oK7tvHnzx2rjSclHo7sR7HJz1JCG5ICfiMjVA+8L93MsPgJV?=
 =?us-ascii?Q?N0/NMY3PpbuIEKUM6yOzJKuOOeLqARXvAfR4PWhXG9g9JnLcLgqQHqV8Pub8?=
 =?us-ascii?Q?hP816YV75f7u/lFyvwjdW1M9afpH5p9UuH7iF/B5b/1u1SBV0ZkcS027rCW6?=
 =?us-ascii?Q?W18aXJivAIrLWWxhZ0Dfh/Jp94EnIQ/T?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NKcsOBkgRsptAJB8KRxFgvBojVHoY86O5fSW1yYQhcn57GoSe3lH6ILpIiCM?=
 =?us-ascii?Q?IMHI1AnOLSltZ9Ms9+OZDXZKbCLAwD4wEqy0mGaVAOVskQZw5kQFvaZhcYV+?=
 =?us-ascii?Q?tseEmY04MiTaQqlk5UgG+pZFpCjgNwQuOLL8AGZ16BkFAr5UemeR2FAexZA2?=
 =?us-ascii?Q?7gKMvnSUPh6DY7UNzFHLokHtinrpo/Yri5B84Benz3C/XB3rhtAMTt0wPURU?=
 =?us-ascii?Q?Y+2cjD5QiP7qqvNHaEE8IXla/L3IEImyYwo+bIZwi6Dv84GQNmz/H1T6cTV1?=
 =?us-ascii?Q?Sq6Or6zMuvgBvad9M6pn2mK21gq3FKlXRx5A7oZeXtqF85o+tedQVjmht1oh?=
 =?us-ascii?Q?07Zm98xElwkS7ajol1YpuJo7hcF7yEYehchc0yK2B7czfXjMVtr3urcR9HwX?=
 =?us-ascii?Q?IQVl7aYfJPth/0Rj1t7neMjX1Mt9LIlOcemhIG2BNwq6sDXIjQUQE56rIKfu?=
 =?us-ascii?Q?2zcYSiZd8NPRd8C/v65SzoPxRwDRNtRy1EiTw49m0Yp3ReeuVceegkfPjrHE?=
 =?us-ascii?Q?lhB7bw2RxwWY9qQrVWdh1uP5NosH1R79BU3FpbWMfumajIYVmPFzI91qyixA?=
 =?us-ascii?Q?VXaiaTcrBTjxYTo9xLypz4YmOH6W8AFC6vPo8E+yQTbjLVL+2PbD1Egtqj2o?=
 =?us-ascii?Q?D2h74bzWuVtr2/37WZpDBIs+iCmAo8xpP+lE0eL3vup9A30mT5BjM6LlGZYB?=
 =?us-ascii?Q?C4kaFyJkurfN51zYhzYfuNJZspziLbpZwtOwlpWRVqPfqO4Jq95ekmwbAf/4?=
 =?us-ascii?Q?x/klmZcJ2zz1b1pegUGTjUOfxzbT2d+OpOeU4Bs94A3Zw4diOuwGxQLEBTok?=
 =?us-ascii?Q?bdobjn2limJc7XUefxNr21ueNhJvP+092j9+DYmKs2BPPQ8hUN2P5p37QDyz?=
 =?us-ascii?Q?9q/TtbO6+jv/i80XS29nxwLbpOYRNF9aYMPtwajFhwds9Rvi6OYqtvw8Ny2L?=
 =?us-ascii?Q?KkU6gh/V9xeh6L9H6NhBP1Ik67qLnIZMtjMtCh/LF0uj6Y7N/wQQICjI8UW0?=
 =?us-ascii?Q?Nu3sOY9Us38IzA5s7XqdMYJ6ARQoISza45K2q2vao5LV+EmjwuyO0FW9jCYF?=
 =?us-ascii?Q?0bcVEIqVBnGjZEUlsYMDZe37YG+B0LU8vAwCQWJoXxuS75R0byjrW3b//4R9?=
 =?us-ascii?Q?HMfp9lqjzoyHMrOUh2B+0nAc1Omm1jCMyR+3XLcJIDRDpRxBPaI3LIQouBPJ?=
 =?us-ascii?Q?ZOBrxKxhqR2k73nl3KhHvTp2rMOkPGA87VP/ApxUJ8xBDYACZph7IumlwY6Y?=
 =?us-ascii?Q?USQZE12kyCqPgrMAFABbvJa7wV9CofSdSSX2hLi/tQMPuterInj1sQAfI4mn?=
 =?us-ascii?Q?EC98GjW7OZsmOimlsXr680oDBvULAhcDig63tiqHRFJn1Xo0AXrO+o2fK5WC?=
 =?us-ascii?Q?ygaz36TQEZc4KU14NPhw5hU/JT57Bj+SEDFq8vwldG/mbOrfZ8CF7Eb62zsX?=
 =?us-ascii?Q?DM0PlId04SjLoPCOBhBLW8ctRyNagG1e6e6nkXtlbPvXOL6Sa5a0PofhNd76?=
 =?us-ascii?Q?BRtOzTh+UOGZk2fS+M8lGTfSbw/dPBGOYboatUB8jvkgHxX4r69uGa+zbaAu?=
 =?us-ascii?Q?HwfWWSOiuTmBWUa4Lx8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3da343-eeec-40c1-0ad2-08dd2f01507a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 09:54:44.7564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9TUFiYrpb5JSCaEWyLXAcPI739m92VOy13mVV8qrfNqKRMcr99QgUFLeoV8opDN9ilDS0Fk/dbxAMTvDPg/ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9402



> > > > > -----Original Message-----
> > > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > > Sent: Friday, January 3, 2025 5:08 PM
> > > > > To: Sherry Sun <sherry.sun@nxp.com>
> > > > > Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> > > > > kernel@vger.kernel.org; imx@lists.linux.dev
> > > > > Subject: Re: [PATCH] tty: serial: fsl_lpuart: increase maximum
> > > > > uart_nr to 12
> > > > >
> > > > > On Fri, Jan 03, 2025 at 03:11:54PM +0800, Sherry Sun wrote:
> > > > > > Some SoCs like the i.MX943 have aliases for up to 12 UARTs,
> > > > > > need to increase UART_NR from 8 to 12 to support lpuart9-12 to
> > > > > > avoid initialization failures.
> > > > > >
> > > > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > > > ---
> > > > > >  drivers/tty/serial/fsl_lpuart.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > > > > b/drivers/tty/serial/fsl_lpuart.c index
> > > > > > 57b0632a3db6..7cb1e36fdaab
> > > > > > 100644
> > > > > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > > > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > > > > @@ -245,7 +245,7 @@
> > > > > >
> > > > > >  #define DRIVER_NAME	"fsl-lpuart"
> > > > > >  #define DEV_NAME	"ttyLP"
> > > > > > -#define UART_NR		8
> > > > > > +#define UART_NR		12
> > > > >
> > > > > Why not fix this properly and make this dynamic and get rid of
> > > > > the static array causing all of this problem?  That way when you
> > > > > get a system with 13 uarts, you will be ok :)
> > > > >
> > > >
> > > > Hi Greg,
> > > >
> > > > Thanks for your comment.
> > > > But I checked all the uart drivers under drivers/tty/serial/,
> > > > UART_NR is widely used, currently almost every uart driver that
> > > > supports multiple uart ports defines this macro, this value is
> > > > needed for the nr parameter of struct uart_driver, also for
> > > > console index checking and setup.
> > >
> > > Yeah, it's messy, but it can be done (for example see all of the
> > > usb-serial devices, we don't limit the number of those ports in the
> > > system except to 256 I think.)
> >
> > BTW, it seems that usb-serial devices also have the max ports limit,
> > you can check the MAX_NUM_PORTS macro in include/linux/usb/serial.h, it
> was extended from 8 to 16 now.
> >
> > /* The maximum number of ports one device can grab at once */
> > #define MAX_NUM_PORTS       16
>=20
> That's different, that is "max devices a single device can use".  We don'=
t know
> of any single-usb-device that has more than 16 ports on it, do you?  I've=
 seen
> big ones, but internally they are all split up into smaller USB devices i=
n order
> to handle the bandwidth properly.  And I think even the 16 port devices a=
re
> almost always really just 2 8-port devices, or 4 4-port ones.
>=20
> Now you can have a lot of 16-port devices in the system at the same time,=
 but
> I think we max out at 256.
>=20
> Oops, nope, we now support 512 usb-serial ports in the system at one
> time:
> 	#define USB_SERIAL_TTY_MINORS   512     /* should be enough for a
> while */
>=20
> Well "now" is relative, that change was made in 2013 :)
>=20
> The commit that bumped the number also gives a hint on how to make this
> more dynamic, if you want to read the changelog text for commit
> 455b4f7e18e7 ("USB: serial: increase the number of devices we support") f=
or
> more details.
>=20

Hi Greg,
Thanks for the detailed explanation, yes it is clear to me now, anyway the =
next
step may needs to remove the limitation of both normal uart and usb serial,
dynamic configuration is our goal.

Best Regards
Sherry
