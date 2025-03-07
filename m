Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D921A45A;
	Fri,  7 Mar 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375196; cv=fail; b=aExc3YMhK2kVu87YlEEguOS8nWSCsb3tQLwLLVOPSLUQ2gHRuTtuNRqyLGQD13v5uukdN4meA8lWSvorzvCJNn9fKsQzRWynrXY3nLBIBLb5/qLDYiocvetHT8DNU5zb2IGdbLnzLeXY91yd9Fle6UoNRKPCSC+WDRn2eBpynnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375196; c=relaxed/simple;
	bh=OTrotL7llf1ioHpxlkZ/mTDFk4HjnHo7c48m8MhAi6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VM2xDDIk/4qleFyXiFjNEnwm5TFnVkZwm28rSvN6Bx4xW225Pob5YuocEpG0KBQ9q+D7Kl2x0G1SXDr6Zzg5AdJDluK58vpBaqg8ykKEbu9DT46jeGAOjVwSGQN6mPLEoxtL7XsX4qtulIG8TKjp+GEuh8oLPevUa20cjpNg4Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aIBxtp2Y; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aIBxtp2Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDGIyhf9p4Xjnt7YWi8yaNUr9mRGbpYs7Or3BiNNT7CGOX43XvcqoKlUgJQ4x+7YPeIrc8rQvWei7Chr+FuQZEYvmPzBf+tj1RQAyXWbspj1kdxvTYdq31IeE9kdW6bJFzoz1B5dmyp2hkjhsQrMVGIBeUh6U3D0rapqd6JyJ6GGfLIlb/zj6GFCWxLGotQ6D2zk7+euSek3URvaSIje+KXzsN6xITgegdFa+CMurV1SD7a3eWxXUV1ocxVMIXSbaKaWnqxjdp0gCaRyNVly5TGLZBURF1G4xgUeZDVlCcbjunn1jvq3QLzLMUR3FfM6I3+uT79oygMNhl1+3UuRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sprhuhyy2bS9kSsqy4uiktgbvl0OrVigMNh95iF5RyY=;
 b=jeDN7wEPBbRnQrCRbZpFHtWNNhmvY0glBsj6C484kL4dnTIzDWvHlWfdMrAKWq9O7MCctyMZ6lRFcs1o2P9NfsjgZYHC7VwGbB8H80N0rR2LP4gLjVVXsCcGOypdzJspIyQs5eUnQMLHx0e48eS7qO5SbqDA2vtJlzGh6kQRPv11HWIpAnTyupSioCEAhwPwEG2KHo76BjVz+Qhcciu8fqh25Ahk7DzXFMXZJzthjRC30MPMZFymv+PxtB78VHFfW4q93KJ7a0rAPejJUJVgPpH0WBRgO9yk2Rg2jPAIQp9D6fPlzxhdOPvG0e/4+9SFYmzjUgq3zLEfe3dyLdfx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sprhuhyy2bS9kSsqy4uiktgbvl0OrVigMNh95iF5RyY=;
 b=aIBxtp2Y34bkHiJWUqy+5iWTNwGH6V/SJInU9eBsXFLlIgOVYXSxV76sNdzWdz8JkZc8+qc2Eg3xf9u1dh52XiBCXsmAi08Z3kbQ+jfKZggcPbCzB3FsLX8/IEF5P1p5PKBW1qKwQZVK6O9KMoMCBo/S8SlqdORgEAZB6gtnjndxR6qub6m9GXuakoMp7v8PUdsAMGSjQvpFeunA4Ich6uhIKz69gWq2IMtiaERNikg8xnVNnHNhYHWExfSMx01r936A5bHW/0Ydpu5G7zmoxP9aSX1fLFWMuCqpp/DIswoJsLmUwT6svJsiu4d/6rH1zCoTydD8snK55gMHEt2xxQ==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GV1PR04MB10918.eurprd04.prod.outlook.com (2603:10a6:150:207::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.24; Fri, 7 Mar
 2025 19:19:48 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 19:19:48 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: disable transmitter before
 changing RS485 related registers
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: disable transmitter before
 changing RS485 related registers
Thread-Index: AQHbjwdrI17dbdYUjEGgjdmD4rfiRLNoB41A
Date: Fri, 7 Mar 2025 19:19:48 +0000
Message-ID:
 <PAXPR04MB91855AF296383041F5FD502389D52@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250307021950.1000221-1-sherry.sun@nxp.com>
In-Reply-To: <20250307021950.1000221-1-sherry.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|GV1PR04MB10918:EE_
x-ms-office365-filtering-correlation-id: e0ae5159-ab6f-4c65-dfad-08dd5dad06fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lsDl6z7smejErYYawNJCeFyoUxfo9pksIh2N7eC4+upZFuhiMg/eM7XyOiy4?=
 =?us-ascii?Q?28Mw2mZXQDyyAlL2AL5jn3TB/0NgTyISQcznvSwnhJhHoE45xw7ubmqdto3W?=
 =?us-ascii?Q?HuuSIoK2gZxacAAjGy2Yo4XlRccMmyLpRfzDifJ5wD5Qb0IkzBpG8tbret2k?=
 =?us-ascii?Q?JB1M6OVQfSrsUrxvkPhFWXpLNRjcVUhfcluawNZ8pQKgOma6YRe//0xsDU1v?=
 =?us-ascii?Q?jOCKe8tESaBaIXsXaxdRw0qwYTtdqHeH/nQpdwH3pWshfb/BhXE/PS2leXJh?=
 =?us-ascii?Q?zVvw4u9FsM+j6uTO2hR8lT88V/omZ5WI7bDm1dsw93sTykpxRWKMNqQOD5ER?=
 =?us-ascii?Q?mmpWsceqodoaTjV21bo1dpNc4hH0dW/Zw50z8iDua+u/6g8HS101muK/W6RG?=
 =?us-ascii?Q?JPyUgqxj7MI79bY5axWkHqwNqpJeFNWQWuut0WTP6j3jQyL410ehNl1AS4u2?=
 =?us-ascii?Q?6G1v4dwUtU3NGqAahbMLZCpw88Tl565eK5MoG+zkXVgpYgZWnxhfqSsP1sTa?=
 =?us-ascii?Q?224A5Vqi5ui2iRaaQBYlcrLhSDMWLpM/So6GcwkSyxWO2187gX4TVQQ5tpGI?=
 =?us-ascii?Q?VcYRVFMd68QlZDHJZl1LCdLc9jvinLDG8nH3zx1ApFWKlZ6n3/lTq4VAYfHB?=
 =?us-ascii?Q?SO0bcDX3r5me7rqRdyxhEj04iqIAX/MJwceqZ7G5MYhoiuzSll3H1UHaEdry?=
 =?us-ascii?Q?UDTxvviWr8V1hUhTstyxKPz8Ip7WsnflMY2uiBNmFtloZGHNpIoCCUxISXwg?=
 =?us-ascii?Q?hYgcZGMoQ6ar40Gr4FcGAP+83c2pIOEb44QmfAeMloYA/Ljy7zlcp4bonfwa?=
 =?us-ascii?Q?tkevcr3vXvhTHL44DevGOBeAAooz73xVkM+Mz6s3SVcBUPvaROXwSBhrAtnR?=
 =?us-ascii?Q?9KMsro/O8XpdXO+c1DcY+rfLXaWoGRLJHz6KV5Ja3im2ALRy2q/Cx4+sjsW1?=
 =?us-ascii?Q?7oJwV+64rNgbfunkUpgUdnVozrM4BQbOf98oULwHxaXDhHrxddqEEPgregJ5?=
 =?us-ascii?Q?EEDCq37ovPu8Fkehx31vg9ypi7Uix1QOCAgXkVynI6yR1LW/FtY3rz+VaW9c?=
 =?us-ascii?Q?Ix602+YzQqvAsJY2gvDJHOVk96BBrWui91U6aYWkMeMvnKQwSyjfwgOo/gP5?=
 =?us-ascii?Q?YwIYOZ9vD/2f0tlaiX7i7I2kT1I79xv/aj/ukydT2+R2jQf3iZ4o7u6Wt5vZ?=
 =?us-ascii?Q?qMXVtmUyEjNodT6qhZW3fylkTyhB36ORwWv30jnIs0j6PevVff/Ml5mG+817?=
 =?us-ascii?Q?mC2BOhS08nHiKfRO6XFtZoY15jo1gH9+lyCxe9TexJth4sdpPGlDGwzTiHTL?=
 =?us-ascii?Q?VK9cG1uALJJKFSlHschIPH1ihkWYkNGvTYR7DTau+KQfO1JKkfvXzVC+acl2?=
 =?us-ascii?Q?JRJML5IbcrNpZKYhjvcthGBh1NidpUNM1THjIfHnjDDQnmmAAalaBbVdNnvJ?=
 =?us-ascii?Q?qvxP7IV5RALLbePMC4gsQtdICqf9rg2B?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C4JxTaYf2oPuloyAw+3731JzPeLbGDDHtau0bBVG8uE0YKDCsUJq6k5uxSWG?=
 =?us-ascii?Q?4WVJ1pM9K2HnBeCFmz2XTzi4FAL7G06XVjPvUO3rp4ysTwlrNCJPCQnuLqN8?=
 =?us-ascii?Q?46Z8nWikOYUJ3nNj2k9RtiAJxbsv890tYo78lAuqZFtEDAQsreMSITCK1Yih?=
 =?us-ascii?Q?h2jXKqUMDBu+F5iRt4aPq7OW1Odh97zvb7E3hN4Fzx6TYpuojBa6mr2V+Egn?=
 =?us-ascii?Q?9NYTDXUCmUStqhqX/ypiEtIzCXnAlCkJjlLz1B27n3AL9CXbNd10S6iYvGO8?=
 =?us-ascii?Q?ljJ0mO5TW8hqS0OmTrkiE4ycqdNyvYE7qJDEb9lAIyzjcnkrC/yNi7P4aVAo?=
 =?us-ascii?Q?RQ4QLZUcZ9K09IIgIlLrFJWNttsPzjqaDHv3B7NHCq1L9PPf+mGVFDKJzBIS?=
 =?us-ascii?Q?FjbWmqV857XNeuKEF5NBAOkuDMsceGF4Cwo9a5JI1g7HxS3///vXBPsgm8Hu?=
 =?us-ascii?Q?Y+NaT+34ruOba72EORMJsg2wsTJDaqe2tTExOdx7Y3wEB3zG+CLrxAQDeA+1?=
 =?us-ascii?Q?OV/hH7LMkHGmFIZDXLerIT6fTJdQXKJkoQRBHOIRUtNnbcJ5/Wt2S3lIVHFl?=
 =?us-ascii?Q?g87w4M7lTRxRDZU/ItBnDhmxWmPwlZBNaTzATJI09C+jeW0CvMLmJEH79eV9?=
 =?us-ascii?Q?4dH7wng1p6NSOfi6fKEpCz6CdPMt/S0IK+jzKn7fT63iYpBMnGttU4U1bQaT?=
 =?us-ascii?Q?SyEOG25u7mbc0ay2XCh3KVROZEc6GzReYcw3ff3JPZk4xJan30WIwWlbPkbI?=
 =?us-ascii?Q?jeVv6eddPGAy0RFqx9gwdhZMUidFpfhygM7WGHfb7rqFLwaMRnrKaPOGgin+?=
 =?us-ascii?Q?M34VoQrAi5jcD0xVcyZB3Hzrq2IwOMnjoF0K83ZZFm/90QjcIHmc8udU/m2D?=
 =?us-ascii?Q?z5p3YbYoX7RLpjHfe2yCoQ1T7znRXQk9sp8Oh0ZthNlFFob6kQhrg51Fy76L?=
 =?us-ascii?Q?IC2TB8An2SwQ8oLGw6Tucx8sH1lqZFoaCbYinOd7wBs865ncYY8uO4oaaikL?=
 =?us-ascii?Q?0V0CAahinXyhLp49sDeQv8BwPCsIbZzlYCe3J9iWjzDFaR1y6d4eZUbleARN?=
 =?us-ascii?Q?eanuTC4HCHFYF4g9j0S7Z6OSpycvjmk1jK+wI/9oS9AXS0BJTurMG6l7H8rw?=
 =?us-ascii?Q?jqckoCfzHH46OLeLfjfKLER7oYUCu99WAHC9sxU4t8x4uBOW4Ugctq19N11r?=
 =?us-ascii?Q?mdF9SOVYdtYZuilGBMAEDogczEfAtZUoK5QJcRi6IBBQRgd2Etpy7z0pynB2?=
 =?us-ascii?Q?Wdse0be1YT/db7qe/c2uII6Ii8Kjlj/P4yN6WDmITdQ4RKnSxff3Krk/c93o?=
 =?us-ascii?Q?fHDpgnLbtkB5thd43EJ4PocZkK5dnc4Y+S3OZtBPs9gjekFtCWeDoh7ibokJ?=
 =?us-ascii?Q?2K3mnm7aNpG+KZEdH5utGzGfGI5yh1cvBpe7n1pXNqQve3hPV3XAdHmNyjS4?=
 =?us-ascii?Q?rGdJ9iIpWqdanWDq7lZp91s9UUPLrnSczbAMr0bbqLKIqpJc/2Qq2HOwOUTu?=
 =?us-ascii?Q?f/GriV0ueXIvnCmYDGls+eaipdLNviA7O+QrfDmsM3EXPvN+Xy98XYqUgD0N?=
 =?us-ascii?Q?HRI7V2wLOC1phXdTjeFjn0jZH2C+BUch+weID5nW?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae5159-ab6f-4c65-dfad-08dd5dad06fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 19:19:48.4268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rJxi+WrqmN2IEw/ACrpJtybDIIcjKoxr9MGi6d1Y3F6RWrActtEd7JCH1jkIVbFmgfmH4hDJyA9XNl3cZZdDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10918



> -----Original Message-----
> From: Sherry Sun <sherry.sun@nxp.com>
> Sent: Thursday, March 6, 2025 8:20 PM
> To: gregkh@linuxfoundation.org; jirislaby@kernel.org
> Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org;
> imx@lists.linux.dev; Shenwei Wang <shenwei.wang@nxp.com>
> Subject: [PATCH] tty: serial: fsl_lpuart: disable transmitter before chan=
ging RS485
> related registers
>=20
> According to the LPUART reference manual, TXRTSE and TXRTSPOL of MODIR
> register only can be changed when the transmitter is disabled.
> So disable the transmitter before changing RS485 related registers and re=
-enable
> it after the change is done.
>=20
> Fixes: 67b01837861c ("tty: serial: lpuart: Add RS485 support for 32-bit u=
art
> flavour")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 91d02c55c470..4dc2f3e2b8e0 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1484,6 +1484,16 @@ static int lpuart32_config_rs485(struct uart_port
> *port, struct ktermios *termio
>=20
>  	unsigned long modem =3D lpuart32_read(&sport->port, UARTMODIR)
>  				& ~(UARTMODIR_TXRTSPOL |
> UARTMODIR_TXRTSE);
> +	u32 ctrl;
> +
> +	/* TXRTSE and TXRTSPOL only can be changed when transmitter is
> disabled. */
> +	ctrl =3D lpuart32_read(&sport->port, UARTCTRL);
> +	if (ctrl & UARTCTRL_TE) {
> +		/* wait transmit engin complete */
> +		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
> +		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE,
> UARTCTRL);

Since there may be a delay between writing to the register and the UARTCTRL=
_TE bit actually=20
changing to 0, we should poll the UARTCTRL register and verify that UARTCTR=
L_TE has really=20
become 0 before proceeding. Otherwise, subsequent operations would still ex=
ecute while the
UARTCTRL_TE bit remains in the status of 1, which is not the intention of t=
his patch.

Thanks,
Shenwei

> +	}
> +
>  	lpuart32_write(&sport->port, modem, UARTMODIR);
>=20
>  	if (rs485->flags & SER_RS485_ENABLED) { @@ -1503,6 +1513,10 @@
> static int lpuart32_config_rs485(struct uart_port *port, struct ktermios =
*termio
>  	}
>=20
>  	lpuart32_write(&sport->port, modem, UARTMODIR);
> +
> +	if (ctrl & UARTCTRL_TE)
> +		lpuart32_write(&sport->port, ctrl, UARTCTRL);
> +
>  	return 0;
>  }
>=20
> --
> 2.34.1

