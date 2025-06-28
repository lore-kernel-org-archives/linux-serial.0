Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011041.outbound.protection.outlook.com [52.101.70.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF4148838;
	Sat, 28 Jun 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751097840; cv=fail; b=alo97nwGgmhm9li8SYifl4/xjjD6OhhVApN8SQXAi0FmUzBtHs9BRbebC9sQgBREnORxUS+/Ii4zYw1c8ot+o04ZMxQ6MLakXlA4ahO7aEMIOrIKd49gf5vRQ8rqeDUD+HIaKCuwXNv/4DV5gQYT1MA+XOlsEsOu9FwsDUInTgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751097840; c=relaxed/simple;
	bh=qSgrLPo8A+fYAhmv8N75AWiPMkrw0OwjG5LsqFWWbDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QNhGDl63d4jU59uCHOrAETwi+v16jxCGoQZJOXnHQVrocS8ny52A11HyyCCxBtBMZTRcsJlV7K76cm5NwFKMqGbfxC+/4FVv2as2a6qzMVcJukeC2YG57IAZMoDXdKuKC8oxG+BD7KwjiHr9ucjTM9UF3rmxncN4g+uut4E0XGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RXEgW21l; arc=fail smtp.client-ip=52.101.70.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RXEgW21l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNnhRPsO6PAcxiHofhaPbBYyxhMw3EfvjoHHlWDmzISo/hiYewxNHMweKKuxLfNkPtZmWr/OA8RitbEycG1ni/sM1wXqZfspZhCmceqXzl4ePnIjGz6GSZyp9INoKEXJ+LXAX7vMjyJF/ZcE/cLPuNrEVP3mpapkqr+nUrmef1/KLkdipCaV5cmgOsNLmJTe3eRshaT1bD11FCkUxj0FnRIguiIfCtkIRoEibttyXYcLDntPohhhUIZBpj8YcMF5RKbhJQ/YES72IeO+ZVVHIH60iswanN279E7XujbM5qpFoCZ9na6O53iDS20E3djHeF1/Xwbzy9wTg9SiOVwPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ORGurHIJcELMrcy5gUMDvSHBeoCsZMLYhIfHWDHVEk=;
 b=Gzm5dF6zzPcqJa1fh+KvFmPnHtcXdt6t0wdOWctKsc89P7xRdUMudeSSQcxzuKW8szwZakZqnt5N3tvmI7h4LFSyJedLUA4X5ZDL8qNUSRnhWilv7yrivEU5RRrUCe6Rh2xiwq5EPkuhcka6paPoCrkDTrOSj+CD03THm61zC/Ui7dn1YC8ecydtfqvoH+tYof1RxM5Duub/LNmdk7gcRtk4Gozk7INzynAXsWMmTXX/KdJa+dMmCwg5xsKGVCRJ211wU2rJh4ce63j4FUU0oBSFlfVycPZrYGrEMHs4EnTtEyLbpyVv31xvLuMFRW2Y50AqKpWb7XDLpjCblZN3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ORGurHIJcELMrcy5gUMDvSHBeoCsZMLYhIfHWDHVEk=;
 b=RXEgW21l9+qR0y9WfF3WpAy9LEuVhoS2Tl1GkjHURmuBKcdPxIJTrS8lhth8ECD2n2nrwVOkck+tfBBcAu+wkdA8Gq0m0U89hF8R6XDOwRlp/ZfIiHOBEBUFCae+wk0Stk3t42pp4nLgvYEWiqXPrm66anY3owBaphTYEEs0cgFDFDj0wEnA+NxLifHfrGUXagXRaegx3B9TmxP7NPxArwCSQ3Q4h1kAfCIqHn9rTZ3Jhif8qcVh1Y0rd5dPz0v64zoYSyoUn3Ep+CWhG1zZW2HsJY+F/ABB3XUuSiGKcnmlLE84QcghLRTL8P7/gZtAxLrvwhCUMOTRudIYFv8N3g==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Sat, 28 Jun
 2025 08:03:54 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%3]) with mapi id 15.20.8880.024; Sat, 28 Jun 2025
 08:03:54 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: Constify struct lpuart_soc_data
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: Constify struct lpuart_soc_data
Thread-Index: AQHb5/gSsANzN0yzF02M20O4v43EJ7QYNjlg
Date: Sat, 28 Jun 2025 08:03:53 +0000
Message-ID:
 <DB9PR04MB8429BB610945B0CEC89CA7199244A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References:
 <93dc860a06f92236db283c71be0640cc477b7291.1751092467.git.christophe.jaillet@wanadoo.fr>
In-Reply-To:
 <93dc860a06f92236db283c71be0640cc477b7291.1751092467.git.christophe.jaillet@wanadoo.fr>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|DUZPR04MB9784:EE_
x-ms-office365-filtering-correlation-id: 65dd9f42-c14e-4995-7ae0-08ddb61a5357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?n2WuR8lY6uMkf955gQNI6cGjIs7gZ1vtLB2G5aKBpyAjai7PsCMpeOOjRWqk?=
 =?us-ascii?Q?M9j7JdMfEmTvxqc4ST1bKLT8YNAMJcO1oK7YI+1Vv+1AaGNwowFdFmZUAP7/?=
 =?us-ascii?Q?jea5rYa7ivclwfICJKl41aFOxiT8tMcdcU1CAxzdeoHrivr+QhogQhCUXtlc?=
 =?us-ascii?Q?fwp1g7AFMCvDECJvfHgLVFZoRtEZsR2MmQ/UBm2ZldcDjnuLC0rhtNDiejNd?=
 =?us-ascii?Q?2S6IiDWg0ed68j9o1iB2O9Nfcv6egOuJTXc2pZWEtsmdR7veRdmXouuWAAU8?=
 =?us-ascii?Q?c+zjrwzLtCxoE1PNKy8Z5YKKn2PEoB9ep0ob3EEJvm24gqGRF+B08tMfRMwu?=
 =?us-ascii?Q?Dw8BrXU5p4vpa5iE8+NOLvGVUSkkS3UmdnF1pV7PgPHDmeHGIoxHmUxNz2Sg?=
 =?us-ascii?Q?fb8SFDLyD6hvGmAzW5M9qXaYgLUzLVKSw4KzpgkQ6lOUV0jdmYobOsmIsIAH?=
 =?us-ascii?Q?hWbds0RXBv+8HV50MMFAikz4tBpBT4AqWKLpRb0A3SrR2X0Rxs72ytfRHVwd?=
 =?us-ascii?Q?yZYIOrXwcBEkllVNrbJweJimxZ5ZLiSqMNUouQOfK4ylCdDJrp1q0HSWvjTU?=
 =?us-ascii?Q?UGG5e/vTK8a3vh4VQyby3kwdHerrWS+vuHbZW/hwB3zwXkqrFP8LcoVkLKtm?=
 =?us-ascii?Q?4apcud8bStmLgLoIGCQ/6S2qWyRJysBIQI4DiDs8KUs4UHzBooI7Jkbx+hG5?=
 =?us-ascii?Q?YGpc16I2wVtmL+/L0hpHAbcLZRy1nlnm3PYIfhekdl5hL17lW5QNSiwai1c+?=
 =?us-ascii?Q?YqtpxOSp/DBpnjYtL1K22Ti/bS1EuiHSDo7EhjNPeUj9VQwjaC43avdJ11Am?=
 =?us-ascii?Q?8PvSZWBRBl0qvahu33RnKrdPDCrSpmc6DcUNPxGPeIDf4uPEe24aiTBfGNh9?=
 =?us-ascii?Q?zZNy18PM7fbOrQch+3XxmJc+YbvkLkeIhZHjcCqqvohsUjMdi708OjudxXld?=
 =?us-ascii?Q?HDGOtjxaRfGFtMwQhatv2Q37VR64PWM374mMLz2/pURELM8W20uL2g+iAl3l?=
 =?us-ascii?Q?evEc/Yoi/8GS8LaB3I0POVzbHbZYWDZxW3KO46Ts0hEwj1/qHRdYiChGMG3Z?=
 =?us-ascii?Q?5lIVnCVdcce0B+CjTmXxsUWgkCsh0V2opdhoYmSIT8UsukokrQ9t2b7/Sxe1?=
 =?us-ascii?Q?mim9UZnUxNAGyILjWeTdn31NB9V/jXkBngW3ryYRZDp7LnfP7tbdwc2Iq4Ur?=
 =?us-ascii?Q?XW50NfAg8ky1XG8shWFApOaG/qOxIy60s29Qc9MI0EfNrTCaTAj28QO7PZbb?=
 =?us-ascii?Q?BUY/K45bYKxdcvAznDi7fguZut8iG9ROv1MfMesAyWNPUUZrdTd38WORR5NU?=
 =?us-ascii?Q?3lVCqP91QsNDFBQNR18SWvSwziaTUEut0WWKKtmq1wjikloFwChAhxCCpN7N?=
 =?us-ascii?Q?SIMHDIX2Hi4Xl9FY+vifL7tGVbV19zuGDMrL85AwKYnr936+R5sDRHzHKaGV?=
 =?us-ascii?Q?ZtouUPlLzk4QDGVEUY65kL6514iNq5/fs1YuYw5rai8ZxXXjqw81vA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?edwue4mdTfY7uvNjqKuOTNLUFuIIlsOQDhnZOSdpjL/GZ7lQhO55EDOS1uTU?=
 =?us-ascii?Q?wcoDOzPFvBIzT/FmubJu5pnfwdobG/0lHpe2hHOU3rUi2qVPFfVWBRyTk8MX?=
 =?us-ascii?Q?sEtJC8Bc8DrXjbtLku0X1jYxWb1oT9o0tFIaeCwt4EVavKMeDVDgD8RuBEPA?=
 =?us-ascii?Q?A5cyKCqAmj7TsZRLLd+kjunyr0Nhx7FcMR1qCV+bnKRaIeJW9C1k18rv3f46?=
 =?us-ascii?Q?OVs0wgec0Rqmm0UyZ+oOb+KmAwpoDdaZpu7zLuvspqVXNn8JiVur4reXniyH?=
 =?us-ascii?Q?WY3zRpoPeiAag8IE4LstyijNH0LEUxJsUIgLvxqNGHmhjMOyDuEraJbvnf7W?=
 =?us-ascii?Q?rb00C3XW1yZ8LRLkqkJqF7K4gokmSn7NQbJrgsL3a8vX4wKSW9uHzg/0VmGB?=
 =?us-ascii?Q?/PrEJu3972nJAgkJ3cM51wn2+K/VDZwHbKDH5X7kqLNefKbBzlYAXw1/ylts?=
 =?us-ascii?Q?b+LiVvxDYX002f0Nk1JgzdvPU09PqvNy1iUkvEtHI3m2rjxvmDJ1HIeBg9L9?=
 =?us-ascii?Q?8uXHeYgpadWk0N1x6f2lgfljH8vqi6X3HXjqXRxwlEwGwq+4/u3F9rUEPaWl?=
 =?us-ascii?Q?vtDNzCzqBDJZoiZPc7Eh7HrfVc/plaaA633KkWV3iVJfq62ToluXrePQ6dv1?=
 =?us-ascii?Q?GbpdjdOg9n45PKBs7qgWahXCMdub0MTDx5ZUyDOc4VVM7xwnUcQ6HHuwrVWE?=
 =?us-ascii?Q?LHv/r9AKnylazucvA4FUxpMaM0tUMxFdDCQZ1EcXf6x/uezqqyoHVm1Vb0iw?=
 =?us-ascii?Q?CDqwktN3+NBnUFviChOVA83mijRTSLSGqMb7boDCJMOeMssPLjsQb13dE9bJ?=
 =?us-ascii?Q?z8Ocq7zOtTFskuIP1t+GENle+TDpRWqZZudkL2kn4kDGoST6BoKtswWrBPAq?=
 =?us-ascii?Q?rE8IDiux3F1M/OTKrjhF25eVqRU1On/luDdc67OMJmhKLJO0Oj+DBTibWzWa?=
 =?us-ascii?Q?SJ1rdwA+RjqiIfRy9MXu2xPItod9nAg984SRtzlSQaxg14qhBaA+NJm+r7SJ?=
 =?us-ascii?Q?iVhHMSYwwPIm3Rv904m8DZjprZY2a0U7sARtcYATxuTigGxIJOQKjsUSO86b?=
 =?us-ascii?Q?Q24mG/OP/rz0IovKeCfNn5iGGkFbRP8uZ9taOLsKITTOBlCw8JKBHD46iIBp?=
 =?us-ascii?Q?nzBvMTZ6xlbZU6j0CYGHVievZBpIc6WnFxhK2WHwrA1FfDVtqoOTMGhDgyJn?=
 =?us-ascii?Q?bXR+MGyHQNKX/nkt6ksu9d6/8uJ/6n3qmdPd7oLvhg8Ht8HuVpRrLygINbek?=
 =?us-ascii?Q?73nIQjBBC24ccehKMcmqyMyV/fR2UiJLZF5QMYxg4dNANr/8mk0qlU5IxNae?=
 =?us-ascii?Q?ncH1HqWLMY3RLrZcF578GejBl7lHj1UgeoaebeMLtdHXJu2Rn254ZaPe0KuB?=
 =?us-ascii?Q?/I7faczslkWipxEuVyymhRCzXBwBHFJF4StvNTGF5CdxwYOYlTH/pdmC+oZM?=
 =?us-ascii?Q?I6QoG3e+vUI+WYKKdB1ZlE94LoWJBFzzF7+uQiNHSbiyQKYpKipcVJwExutx?=
 =?us-ascii?Q?TMRnDXSNj5buvgirVbasApfdz8a5jRDUlD3q09PgTboHZrWfrzvm0mHMKBKj?=
 =?us-ascii?Q?Bw8di6XB1sQVfiNqqn4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dd9f42-c14e-4995-7ae0-08ddb61a5357
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 08:03:53.9927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8jVVzL1UD0A7LB/PkOpmReLAhnvnfzCy9F7ZhCrbdU94Pv7GSVeGCJmX04KemMsjTyLijE+sKAEvAvZTI53iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784



> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: Saturday, June 28, 2025 2:35 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby
> <jirislaby@kernel.org>
> Cc: linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christ=
ophe
> JAILLET <christophe.jaillet@wanadoo.fr>; linux-serial@vger.kernel.org
> Subject: [PATCH] tty: serial: fsl_lpuart: Constify struct lpuart_soc_data
>=20
> 'struct lpuart_soc_data' are not modified in this driver.
>=20
> Constifying these structures moves some data to a read-only section, so
> increases overall security.
>=20
> This also makes the code more consistent.
>=20
> On a x86_64, with allmodconfig, as an example:
> Before:
> =3D=3D=3D=3D=3D=3D
>    text	   data	    bss	    dec	    hex	filename
>  172668	  23470	    128	 196266	  2feaa
> 	drivers/tty/serial/fsl_lpuart.o
>=20
> After:
> =3D=3D=3D=3D=3D
>    text	   data	    bss	    dec	    hex	filename
>  172924	  23214	    128	 196266	  2feaa
> 	drivers/tty/serial/fsl_lpuart.o
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Sherry Sun <sherry.sun@nxp.com>

Best Regards
Sherry


> ---
> Compile tested only
> ---
>  drivers/tty/serial/fsl_lpuart.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 2790b4078e7e..c9519e649e82 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -318,27 +318,27 @@ static const struct lpuart_soc_data ls1028a_data =
=3D {
>  	.rx_watermark =3D 0,
>  };
>=20
> -static struct lpuart_soc_data imx7ulp_data =3D {
> +static const struct lpuart_soc_data imx7ulp_data =3D {
>  	.devtype =3D IMX7ULP_LPUART,
>  	.iotype =3D UPIO_MEM32,
>  	.reg_off =3D IMX_REG_OFF,
>  	.rx_watermark =3D 1,
>  };
>=20
> -static struct lpuart_soc_data imx8ulp_data =3D {
> +static const struct lpuart_soc_data imx8ulp_data =3D {
>  	.devtype =3D IMX8ULP_LPUART,
>  	.iotype =3D UPIO_MEM32,
>  	.reg_off =3D IMX_REG_OFF,
>  	.rx_watermark =3D 3,
>  };
>=20
> -static struct lpuart_soc_data imx8qxp_data =3D {
> +static const struct lpuart_soc_data imx8qxp_data =3D {
>  	.devtype =3D IMX8QXP_LPUART,
>  	.iotype =3D UPIO_MEM32,
>  	.reg_off =3D IMX_REG_OFF,
>  	.rx_watermark =3D 7, /* A lower watermark is ideal for low baud rates.
> */  }; -static struct lpuart_soc_data imxrt1050_data =3D {
> +static const struct lpuart_soc_data imxrt1050_data =3D {
>  	.devtype =3D IMXRT1050_LPUART,
>  	.iotype =3D UPIO_MEM32,
>  	.reg_off =3D IMX_REG_OFF,
> --
> 2.50.0
>=20

