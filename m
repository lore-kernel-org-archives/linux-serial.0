Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010012.outbound.protection.outlook.com [52.103.7.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCAB4A0C;
	Thu,  5 Jun 2025 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749091767; cv=fail; b=O8wbkyeYCus15BpeLpMNn6dMF0LNwRooNm5xGbHG0cDnl26DFGGQ4qDrxuSmvzFEMbluljebqsLQBT5McmPMdNHTpX/SD7f+rOpGgCTzMWAu3qOi7nqeTp62GScaa2Sg9bhcYTlDsX3LBVXfqHTDOQ45TG5Sf3k1tfdsV2jkGfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749091767; c=relaxed/simple;
	bh=4vEmJNQi6ftDTZzuEQb5DbLgNMlG7k3JhmjDnUgFU0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KMAp1+jXJy8DaoSrDZIJvqSltNSmJxI+6g+b8GYbXTf/L3hDcIjRx1sV1pH6XxN5vQxd1yRuvwE+fFIepFZZW1bw6JRLRhhDAYYZ1TXiYSKXahfZhc0Bi1buITYYhFc5YqBInDjgB6wPmyfUWF8Eyj7fdb0tK3sWIeMKo4jWgTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jTc4aytJ; arc=fail smtp.client-ip=52.103.7.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jTc4aytJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avnaA19usq2tiVx6tVzgfgGfxOnoUyhmtni+oQpHY8FASMKARwocC0d7RYGnT5jlmZtDPGH1ZcKIuOUBJOTyAuh6MGJnydbvWeYN7StHPFS0DNAiP9puSVzBAj7U+t9RukGjd3UpijA9ROh/MlfjhCGfm00dYaGHuGPD2EFclEvZr1WPub0fZE7a++Vc+Lh+apijpDfvJEXvzQNbqGqvcdAmtzV8SMMcr+lc0p8hbHzNHO7yTzPWZdKJZrmhwJFN7PMGY5PliomvSH8WEIy1aC14IXsE+EKhRYngdJ2idQXpwsR+nSAWJxhHAQnNIigk4RQNY086+8lqExb5BJT84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47ebaHgc66u49sVxsHkgTs0twVvYp66WtnC7+is2Nvo=;
 b=N3DHmkZUNdsjAm2O4NWvB1qzz2yV1xcNhKpS5a3Lo2BOQiLzpyG6Nus1qFrtGN1yeRPlwbTrbmDsmtRLvRKZM4pteGjJPpbpvswFey03vL3odbmZwdVIea28TgGUvbpFirnyWF0lcSD8FJWSm30RIXw4hbUzQbY68qNgjjm+gz2816qXtMiUlJEihtAzKH2B8817+++zVticwZMACmIQvOcQJpaLUhNhDM5i/D82Ff670LjrWV7Uc1THdCmb5p6cwI/7AGQYijo6HdG8eOFuY7M41Zx9AyQyagWtBdK3CkoXyzTsb+lBbJlhMbPg0vu7oMrY2erbjEM2ZTSMwn1EWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47ebaHgc66u49sVxsHkgTs0twVvYp66WtnC7+is2Nvo=;
 b=jTc4aytJoLaOkid4X4XjW6+ipQZMwcfXexRxvOqNRX3eAWKfDvqDIVQ6ZClW7iPq/M88AaE/L38JLLTI4ihBl3AP3WMWNGrPpjK7Ooz6jPcdAb0yCPlE8Zp1AVYSQQJHNoPov4zEew6+95xcBr5eRFmKdYfudyaMthXngGj/xjiWCwfDXpkoloWkz0UiWpGPlfPC4wwvWJl2jvgFyH8Re9jDS75/zIvVgnJw+YmT6X4/4cME3eHd47E1+hzePZy6+lhs9cZ26FQE9IFRhCXN4C1uftiCsKKOreNbI1tYPckPpenDJTXZK8cQKlgoByTypj/p82xcPqnD7ykjLy8W4w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8459.namprd02.prod.outlook.com (2603:10b6:303:157::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 02:49:22 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8813.016; Thu, 5 Jun 2025
 02:49:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>, 'John Ogness'
	<john.ogness@linutronix.de>
CC: "pmladek@suse.com" <pmladek@suse.com>, 'Ryo Takakura'
	<ryotkkr98@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: Problem with nbcon console and amba-pl011 serial port
Thread-Topic: Problem with nbcon console and amba-pl011 serial port
Thread-Index: AdvULbS8DdGjT9TLS9OOSVhbv2AtDgAN1+gwAALFDgAAAfWTAAAeB8NgADP4FvA=
Date: Thu, 5 Jun 2025 02:49:22 +0000
Message-ID:
 <SN6PR02MB41575419E1223B8A8B0A1F1FD46FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de> <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=be343133-71c6-4d99-8848-8967c516ceda;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-06-04T01:30:08Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8459:EE_
x-ms-office365-filtering-correlation-id: 8981e437-e760-498d-2a4e-08dda3db9372
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwW0/Oyp7YGYB8PXZKvbjyK4/gNNJgyH6qmeqixNxQxkwwpQafzTi7DxjQAk+3XXqRVM6f2hmjnuSj0uhIYDSN0rs+xQ/xQKticzQr7Vg6R2ycFIdgPNxVV+KHzPWvk5GQPcbJ4k6oK8GVUS3YDuZu0HiEbjD4lIbYJFalvGQZFNIGnxXGLYPCuqlHEYEfzcOg/6VxNvjVKDF2hp44ayLzcQMxWFrc00PauldOHQpR4HQ8tXnjZ8/Eif42bxhyZ9butFbFYLTaQkfedEUnnOlHcC2GDTXVvSUf8s9zpt7be8XBt9Yxi+t9+/TpRBCjUJVk6jOei4H2mMLjVTBLskg8XYj8kWiCXN65Sq/nk8E5tSNkkpnu/hvMynevqj147bvICbTqebfLNbLfN6rfQ1OYBrkBhFF8qO6h8sXxPDD4Zl8bPh3GATYA8DyU9rB+eIsZXIH11qXLD/0T0sOHq/wJneBMTmPqaKa3JkmhEl2auNcGOpyPaE4b6HbadxrvgNVK3t1lwk9TxGJPfga/gpjpPxXdM4zs8iG9gAxWKlh0iA1Sz73UgCngwDNHsin5kd/mZE11j+52FGQ6T0Unv+dCPHDxg3fv5HY5R/ZePO/qPW6469S+6oTyeNEM7rbYdu/VI6AVpu0uvidDODKk7jfXQQy1iuejYRESpj1beQ/QvAE5dbffUPqHoqcNTUdJah5uLPflWKltQM70HWU8m7U5aFlmS7ub5woYjHNze+COp0vb+m+f0tbb3kmTN6anp8r3E=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|19110799006|8060799009|15080799009|461199028|41001999006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1ZRkXo3NASHS2bUYn4pQ4uh4IUz+V2qpT1ViSNrCwZjKg2Vp5+CDbSa9fjTe?=
 =?us-ascii?Q?hrQ5kbOmC5mczRLcAz3eXJkRbUkkjEnFSz3QNANbzExQHnWVzfvWOCKNQ0FJ?=
 =?us-ascii?Q?pa8iszTk7wp0NvJ/sPqIyW7D39jw1qj6O5ABkB4lE5cO3+2FqV7ELiJ55EkH?=
 =?us-ascii?Q?e6tU9CNEceFUuAIWXwm6P+34MaNsPOUlflzIJVD9b5N/oYS+Lgeg/oT/dy0+?=
 =?us-ascii?Q?G3W/FGnTSJ+jERuKsyQQX1QNIYdj6CdS1LP+LeebbTZnY2RNVmXnBYJtGiat?=
 =?us-ascii?Q?Sg1iSTA/jN1HJYpv0VRu29p/VBKpd36TF3KyEz6on8NbCfRCjTBOjOR0N3va?=
 =?us-ascii?Q?jC4ZVBrGRTv2S8QtRsn9yYCkXma2LGoYFmZA8OJx4ttUr3v34LL8irxOmSOR?=
 =?us-ascii?Q?OYxC/+gjl6S1WWuNhG/CKxSKUS8Dj7LPTTcIZca/5tulR18UuFVUIbGlLzqH?=
 =?us-ascii?Q?5iYw/7ZU8mMVBUZjUEF4M9fkwPG10J16twmBT8ZEzOiCayCEJlUMvr4Hs5gI?=
 =?us-ascii?Q?oVK2jgBFHfpPoTmGvjE1sr4hWvdyz7BVM+0zb3P4sg2eeE39Pe5qZGG3/26u?=
 =?us-ascii?Q?d8u6o9isMMYSADsqT9F7EYZew6WMVFeTF9hSzwCf2DW7wVqXUGvWCug5/scT?=
 =?us-ascii?Q?R9lQYuSuDaLvaV4DJxNqLrHhmEk0yWxw9dO2XuzA/FbOZe8M0ZQNlGSx0smN?=
 =?us-ascii?Q?AM+h0dISjwagunt9reIky1Zpbjt+QsIPD/Sb94wJCeLz8TOEtbm9WbQESt00?=
 =?us-ascii?Q?6JZ8qkrqWRMKctZbPS+sKx7lTQkHOTTXtq+1hTOW5JXkYj0NDIlssEJBONp1?=
 =?us-ascii?Q?lZSn5IgWiAkOwZY2ydsaZam6DPBod7SGyqU4ULDgcOSlG3cMkjoJyaVJs6If?=
 =?us-ascii?Q?ATelRu2rE78a2cVMEnnrkRpwDdh6guFbJ+YFDMUyfpnX3vZTVtDX79hpyw0j?=
 =?us-ascii?Q?kOOz89ojBaQtorhSjg8TbcnkzCM0HV6qfkVGUhsLL0h7nEO2CJ10Pm/i9kbN?=
 =?us-ascii?Q?ZOQvu9WUD3xmiBRxPp5aj+uNMXgX4lOxFEkp0kBkVmc5ZBZ0r5Ib2EngwWfV?=
 =?us-ascii?Q?yGjNsDLf00Dj2whqsou+pUyQYKyC5BY5Ywxklj5yZpHu5p0Fa+M=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2BOew1EIFSaRIuzY6T4PN33lk7SjMlzGsaRtvufeK3LClhNhcmj31PHmgDUq?=
 =?us-ascii?Q?+fGqfkmdKDAVDlE6qDMnzqZPn5XYXZiuxZ/h0KAcFl4tvlyXWk4cJJ7ahO2M?=
 =?us-ascii?Q?edcfolGBVMUQZff13lbHw6PEPL6ZCfGrixfsZcy6QQm+sBggdGj4iERboljp?=
 =?us-ascii?Q?7Y12zANI43+3O9b4fwxIhyw59aY9eqMyLYF5QzAdts1bhz8jTTwd8lOKKZcn?=
 =?us-ascii?Q?vu5NZch8PH7mO9h/ZZKrAiBPu0FRZcZTb5wSw5aCrtWYUfCEQ8mmlLSTjDzV?=
 =?us-ascii?Q?+GLDRR8zCwuo7LdVF1EbbhmV3biYoLSI34hHsBvYOeI5DFc5RZVd7ZZfcTGM?=
 =?us-ascii?Q?wTsh6x4oWDmIPXnKv3RzU6CyKNr5QuWtzKlCkGyzu8DmiEDt21dKK5lV1/pW?=
 =?us-ascii?Q?2lCqenPOZEJcIm+sbahd8KhV/BAYP+ifmakdT0kh5YV8bHQgVGAD8l8VHN7r?=
 =?us-ascii?Q?8h+g2M+UWZ7TmIc9KHJOzZQ/CUtsFpufWXQtczDPBzmJzHvgnYbXuurQ+Vj3?=
 =?us-ascii?Q?s35+8e93jVmoyzYMKDXYBIMFZcthiNn3/ct5CF6OrINjRK7u+w5OTzyWR7rR?=
 =?us-ascii?Q?PPYkaqj7JTN1xfBvARTHLkKcn1avz5QbbrJWZ0YI8xY5ibjDrgVZOJ9Vju9B?=
 =?us-ascii?Q?mmUa1sgeg3hGvE64fAIQ6eQettbIMVc6zfGEq42RnNVILRxemLHMBEO2EQtg?=
 =?us-ascii?Q?+SO0mWNeZ3TxlkL2NV4L3Ba4qQwm7vUt7PMIlFleD0DIwubm5qfLoQIeFdQZ?=
 =?us-ascii?Q?hAVyw6/4lOLzJY6ZQAL3f6XuNJsbqyY7GLboROiNQWvCMujqOstatVsPZAsd?=
 =?us-ascii?Q?M0Npz0y4tU8hiOA2kbqXKdd+OCDVyKfJWjUE4NrwjHFTja2tnFfvRbao0Vmu?=
 =?us-ascii?Q?LItgLv9v+eEBsnNkX4Q8WWOYwXWK9iZ+EWLaNEhLzQ7mYYhYa32cFHyWVbx6?=
 =?us-ascii?Q?Nt5YQr62qS4s/icLXk+j0Nl3y39VpmI0WgZ3RM2WAgjqTRwHt7egjUucNA4w?=
 =?us-ascii?Q?UhVk8/wQpKvskT9M244mbxBAmOIV7CPp2bkxxulfdj5Cg0cWsGznpbyX61AC?=
 =?us-ascii?Q?MeVlZkIguVyMaPyDoqUs5CU2pG4KPiqH98XvQ2c03obIgbGr4VEP5KtlNjNz?=
 =?us-ascii?Q?OWKLpkqBIgBk4vyn8hCqgqnC4A9zll42c83eas8DoNpn82xcrl8pCyO5BYSy?=
 =?us-ascii?Q?CL1wzaaG6npIV55xph1/TtUITd0gWO4mJPbhPSgWjr8a8ZHyYGkOTEjD2vo?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8981e437-e760-498d-2a4e-08dda3db9372
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 02:49:22.3106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8459

From: Toshiyuki Sato (Fujitsu) <fj6611ie@fujitsu.com> Sent: Tuesday, June 3=
, 2025 9:11 PM
>=20
> Hi Michael, John,
>=20

[snip]

>=20
> This is a proposed fix to force termination by returning false from
> nbcon_reacquire_nobuf when a panic occurs within pl011_console_write_thre=
ad.
>  (I believe this is similar to what John suggested in his previous reply.=
)
>=20
> While I couldn't reproduce the issue using sysrq-trigger in my environmen=
t
>  (It seemed that the panic was being executed before the thread processin=
g),
> I did observe nbcon_reacquire_nobuf failing to complete when injecting an
> NMI (SError) during pl011_console_write_thread.
> Applying this fix seems to have resolved the "SMP: failed to stop seconda=
ry
> CPUs" issue.
>=20
> This patch is for test.
> Modifications to imx and other drivers, as well as adding __must_check,
> will likely be required.
>=20
> Michael, could you please test this fix in your environment?

I've tested the fix in my primary environment (ARM64 VM in the Azure cloud)=
,
and I've seen no failures to stop a CPU. I kept my custom logging in place,=
 so I
could confirm that the problem path is still happening, and the fix recover=
s from
the problem path. So the good results are not due to just a timing change. =
The
"pr/ttyAMA0" task is still looping forever trying to get ownership of the c=
onsole,
but it is doing so at a higher level in nbcon_kthread_func() and in calling
nbcon_emit_one(), and interrupts are enabled for part of the loop.

Full disclosure: I have a secondary environment, also an ARM64 VM in the
Azure cloud, but running on an older version of Hyper-V. In this environmen=
t
I see the same custom logging results, and the "pr/ttyAMA0" task is indeed
looping with interrupts enabled. But for some reason, the CPU doesn't stop
in response to IPI_CPU_STOP. I don't see any evidence that this failure to =
stop
is due to the Linux pl011 driver or nbcon. This older version of Hyper-V ha=
s a
known problem in pl011 UART emulation, and I have a theory on how that
problem may be causing the failure to stop. It will take me some time to
investigate further, but based on what I know now, that investigation shoul=
d
not hold up this fix.

Michael

>=20
> Regards,
> Toshiyuki Sato
>=20
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 11d650975..c3a2b22e6 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2577,8 +2577,10 @@ pl011_console_write_thread(struct console *co, str=
uct nbcon_write_context *wctxt
>  		}
>  	}
>=20
> -	while (!nbcon_enter_unsafe(wctxt))
> -		nbcon_reacquire_nobuf(wctxt);
> +	while (!nbcon_enter_unsafe(wctxt)) {
> +		if (!nbcon_reacquire_nobuf(wctxt))
> +			return;
> +	}
>=20
>  	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) & uap->vendor->f=
r_busy)
>  		cpu_relax();
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 8f10d0a85..ae278b875 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -604,14 +604,14 @@ extern void nbcon_cpu_emergency_exit(void);
>  extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
>  extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
>  extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
> -extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
> +extern bool nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
>  #else
>  static inline void nbcon_cpu_emergency_enter(void) { }
>  static inline void nbcon_cpu_emergency_exit(void) { }
>  static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) =
{ return false; }
>  static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt)=
 { return false; }
>  static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) =
{ return false; }
> -static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wct=
xt) { }
> +static inline bool nbcon_reacquire_nobuf(struct nbcon_write_context *wct=
xt) { }
>  #endif
>=20
>  extern int console_set_on_cmdline;
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index fd12efcc4..ec016bb24 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -909,14 +909,18 @@ EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
>   * output buffer because that has been lost. This function cannot be use=
d to
>   * resume printing.
>   */
> -void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
> +bool nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
>  {
>  	struct nbcon_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
>=20
> -	while (!nbcon_context_try_acquire(ctxt))
> +	while (!nbcon_context_try_acquire(ctxt)) {
>  		cpu_relax();
> +		if (other_cpu_in_panic())
> +			return false;
> +	}
>=20
>  	nbcon_write_context_set_buf(wctxt, NULL, 0);
> +	return true;
>  }
>  EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);

