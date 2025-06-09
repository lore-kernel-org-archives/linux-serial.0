Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012049.outbound.protection.outlook.com [52.103.2.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C9625A359;
	Mon,  9 Jun 2025 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749440292; cv=fail; b=Of4FyaMo59ZIBd2O3Hatu5Q40eM3Vi2fQDYG7FGuFAUgy0qtIlfhEwNDFssjLS8ZkiryJiLP9s6R7r5z5ktBG+1x/WuQ1bB+nfQcTvOFKFj8gu9/wYEE8FLEhqOAPVU6m6HMxGKbVCH7CoemcSFZ+Wk/SDwtsIkfRBrQXuT0iMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749440292; c=relaxed/simple;
	bh=H9tnEJ/q9SqoZwDKpEd/6S/x08VO6I07R7EGf4WulLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mg5w25qSgiTv3yfCj/Vp9gTWTrgcHOrs9+tQSpfyPGddyKh9kLqRGQWjXzhr9ANCeMYQi/7TjTZbhTmXk0MoRO3JNP3bPgroP+9esyOcLIUBTsUS0mW0E+BeeIw4SagSfR0MSebEnO6CZCPbTPeX3Zv0xyDgc0H9s5I7Ei/cnEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iKSIGvgJ; arc=fail smtp.client-ip=52.103.2.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iKSIGvgJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNdGyowg6d7QWkTskaAiF/CVlKJJE+hiFUjsriAfVCw7aNTO3nycok8LQx3HMLOko/1MpkUQVQZs33/mbPWCU2g+jP9CJ4lMyeq3o1UBrjOzTfeTA6bVcYhc5JcOWB8QjzPyFXSRsZzBl63TY+JHZvwiB9UhjbDKxB7klFMyrZ6D+Tm540vcuDHJtItnzhvU0Vnv/nWKTD5fiiTeckae3I6raDiiBDvt4t7MsA0C5E1EDfaL9Mz3fGfPwSyrJrrRDcffVbOHq+na29ddkCkg5MFCdCqrfZS0YiuSS+W3xtVDQDOmKBjFyi4H3vFEpoV2c5DUu5S893f5NW+aAYaSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9tnEJ/q9SqoZwDKpEd/6S/x08VO6I07R7EGf4WulLg=;
 b=y+N92OIwtGf8lgPkWIQfAnFlSccHipgarYvzCfjJYts3hgHZZN6WalIFRGqKAFKTiEIY5zZh5mKtgTvGuA4/mjpfnVcJkNhWf2r7jtyKOSd3xRxYb/hxtX4URuUgYhf9MHU9GY6oOBr2OqkWnWeT9skl7pMXRSN8dv21DFNTsX/WbXjVsb78MdTpXVUPfGvMZHBtuKQvH1JnXk6S+RlsY+reOaBwelhx+6GSQcLkvFO46qq5WzsFNfEPVZ1zzuCOl10r97Ou+D9icDWI8WZvuW1SuhXiQxPELvJBDulilG612tle8gVv0ONt4eLjSSUIMTcIaKtuPh7aylMEdr54FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9tnEJ/q9SqoZwDKpEd/6S/x08VO6I07R7EGf4WulLg=;
 b=iKSIGvgJYiGFfbgy8MM9AT8O8XDXYbUiwMQSROLN5SVVwL0xSxFQwytppGIMDamEBV+F/B+XMCITDD0nI88r3xlwNHE4v0yWymKIoJLZRgt8OhxxrxYhsGBEmDziIBrWmo1IKufoaH+J1ayLYbPhkJAizqgj2OEnoOl7HF+RoZgeAPr7tnTc//6fpVMAiYOfRELk0IR2JfZHT8YzIPjo6QS0crU03st2OrTo+9d/aLkHHc5/rUargMczivDnhV7uB5Y9WaCyCIkpMTddbDaBHykuUMjikxtPfeG0A4QPsgqfxkZzm2zzwJ+izR0XuJJTrJrR5s6McvozKTjjfdVm+A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10643.namprd02.prod.outlook.com (2603:10b6:408:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Mon, 9 Jun
 2025 03:38:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8813.016; Mon, 9 Jun 2025
 03:38:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: John Ogness <john.ogness@linutronix.de>, "Toshiyuki Sato (Fujitsu)"
	<fj6611ie@fujitsu.com>
CC: "pmladek@suse.com" <pmladek@suse.com>, 'Ryo Takakura'
	<ryotkkr98@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Toshiyuki Sato (Fujitsu)"
	<fj6611ie@fujitsu.com>
Subject: RE: Problem with nbcon console and amba-pl011 serial port
Thread-Topic: Problem with nbcon console and amba-pl011 serial port
Thread-Index:
 AdvULbS8DdGjT9TLS9OOSVhbv2AtDgAN1+gwAALFDgAAAfWTAAAeB8NgADP4FvAABDFXIAAHKeQAAL9pDfA=
Date: Mon, 9 Jun 2025 03:38:07 +0000
Message-ID:
 <SN6PR02MB41578CF81FC4C831C02525F5D46BA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de> <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <SN6PR02MB41575419E1223B8A8B0A1F1FD46FA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <TY4PR01MB1377757DD5E7F27A41F0B4723D76FA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <84frgevdl9.fsf@jogness.linutronix.de>
In-Reply-To: <84frgevdl9.fsf@jogness.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10643:EE_
x-ms-office365-filtering-correlation-id: 28b79bc9-15a8-4fcb-c05d-08dda7070ce0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|461199028|15080799009|19110799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ccu5HwJY9s5ykIKPR21/vE1y+pIqm9g54VspOTT1w22jVLI6mwzw8B9BwFlh?=
 =?us-ascii?Q?zUWwpBQuQWTksyFJhVgcmP/e+Iz6NoEN+qzWqqMilQwMAnRi+n1cqYgHZ414?=
 =?us-ascii?Q?F3y4zrbEA8QVQKudRyfQhg0VWziJo1D2MF2OS3jyE09VGvyCggs5RMdxFSO5?=
 =?us-ascii?Q?6AJWFFagqOhFSDl/SjkA9ykek9jd7SXTZ98v2cl/SaBnAJ54fRVU1tImcGf0?=
 =?us-ascii?Q?n68d2z7DwLs7mi5kmckxeahkfc+yJoI3cJYQYTwZ5EHuFWEF38as+XWq6270?=
 =?us-ascii?Q?xtQ+ou4Am1dPmD1hKTOX0Epe4rKf1uWjF0KOQD3E7c0vSUReJs7tddD58zCQ?=
 =?us-ascii?Q?YwyZK6J07hpLSN+xVaLnprhw/WBGkU4WRWOtBen1MnrphlhrB3N+TETmrEhT?=
 =?us-ascii?Q?V3qJcc+vd0U+PPHRFmwpgX5xMxj2vW0IQ0A+3RPVg5Ur0EJuCHvKPtoL/NBg?=
 =?us-ascii?Q?1+6h3OnC5iWEFaWh9sfgH6VOeoCz/1+4HIMIv176Gyj7PRLJd4JHdQE5igro?=
 =?us-ascii?Q?hndt4RrXCU1AlFBRZ/GxY+8cDha0ROxZV7X3Um7M2lxLPVjxjwg2OJhkd2tj?=
 =?us-ascii?Q?eQC+3Y1rFW6iGap4Cub+ba9JPu1dp79F3zxKY2s09RlAXnEmXz+3rMThU+Od?=
 =?us-ascii?Q?VdVr9SVgjrb/poGnrJ85GlY9R2LOFIdXMQogBNARhiZH5/kvphwFT7T08tIa?=
 =?us-ascii?Q?JX6eFMxGMvQjOyoUZ8EvqkmypLNo3j4nEG1AexHFYSM909GEtIlwxl3AD5rF?=
 =?us-ascii?Q?QJV9KKDCJl5ozuJhgPUiifMC2F89R4AU/ymlYtrhnihVzBv6UOOx+bFRwWS5?=
 =?us-ascii?Q?FUAVF3XOIU+Ghdexx1lxnT/E6xaMhjfThpGweG9pJO4nEfMqa2TFYhZn/KCK?=
 =?us-ascii?Q?YtTx8kXYVjLDd90zwemsnAC8Npj+LOtWLVGddGKbtzb/E4LREebiDcv+u+XR?=
 =?us-ascii?Q?B2vz5CwJNXSDiDTQ9CgyI5Lk3xovxd5N8ttjPZt/ZhvjGIj8bkYRHHolK3T0?=
 =?us-ascii?Q?m+eyiMKWKk/Kfj1xOEVn8Tq0AWo4Hl5eqzMPGdwREw+z6oWfXI97qCDra+2Z?=
 =?us-ascii?Q?IIWA2s5uYSQQnKPkIjSaXTfbiqXrKg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?91+VivNKXNo1ThFsz7GJh/zyB+9F9DPPl2pjEQp4qYHnux1kuu5eYnCx57g8?=
 =?us-ascii?Q?rdOAUATWnw/N4A+4Yslct/JCx4RwOEdFrbHAWChBv4mrpliCPDEC0iwzuNIw?=
 =?us-ascii?Q?LeIlf+9051538rh5GG7N+K9A939e2CttUfRgkZpIm5CyvdbZ4uKgYZBrfA9C?=
 =?us-ascii?Q?LWV5/iRcXBWtNjMpqb/H/MalcG1GCwAlxbqBiX7MS5UY+hrythcX8aZN/nzp?=
 =?us-ascii?Q?GsaMJLdba5QjSH6C0gr8lstpku/b1Vb2qsjBm7dDlb+L8Ww4kI0NMV1rWtep?=
 =?us-ascii?Q?OYTVR1L2AXnU35gj/4hAQRNXAcz92mSjTakFB0n7nv3/phBy4w/SWbSq90cN?=
 =?us-ascii?Q?bRk47QKtPAGDbsii4MAA2KE1Jtvqob64liQJDmkdKzh238hjOmC4425smn93?=
 =?us-ascii?Q?7ZAqMNBDo98FCIu8hwmZPQoaspBZ4k++tb2ykSu4dfqSPs8AfMNeuOeabUSo?=
 =?us-ascii?Q?cj8ezqk975PKgQtWK4K3l9GLJG4gWFa2cB6ghkOSs1A7yBZRMg+qrYWSJNA1?=
 =?us-ascii?Q?/nVbMz+99s1b5c93mGZug8OR+qbleJyDqBhIjCBnXR3fezcEGXMXYXPVEltf?=
 =?us-ascii?Q?aNiAliLUhxMu02fp1yY4q07UQQsIaMTkfsCfiMg4jKI8+l14YdxZjiRGXS+s?=
 =?us-ascii?Q?tGmKyuHHQQrUjcpyfkPglVqjlVGsxYKrIrXm/lgIRyvQoFQpd7jHWCk15DoQ?=
 =?us-ascii?Q?+q4Rp9q+9pBpIGKbb6f1TcTp4bIc9Gh7v57FgoHMAD72g+hg/qblzzYx6JDP?=
 =?us-ascii?Q?97VfNojjZeJw1T8W8ZfQ+yL3BKvaxWL02QwVVYFXof4F8TPMET9Alvqh4iNR?=
 =?us-ascii?Q?KJ4eLDdFqJSRtvlhBCaqHxY+FZMFhUa/ljpRku9PDkrBxVqgPE1Ki63y+/oM?=
 =?us-ascii?Q?P+Ys/4WWBPsypwsXNunE8mQ8vsSTj8KrlHgJFxSzhXvgmqhDM0TowAaA4aAx?=
 =?us-ascii?Q?RzXhKRG7H51HxB5G078SK18larf3dkBOhIBxZBs/qJ+vrr+LLgljGQwsOfwr?=
 =?us-ascii?Q?xTCFmuO7mBvQj+aDphs4gLfZH/kWLdvbS3rHMz/G9yFW3se1impoa7BhWeYg?=
 =?us-ascii?Q?sxjRxbBM9DMPURGdp0JeVSp3XvP/428cboC0lm6+YZyds+huTJVwi6mHG28l?=
 =?us-ascii?Q?uI0T+EbQaRNnvf35Z5CWw9knvqk30sDX2Y+pRwfHZmVwcKncxg8tuQt0LJbh?=
 =?us-ascii?Q?91CTj8bTiFNxYKB+Vj7ALfMlMls++wIEFV4o0Jtth5pqU1NEeulBrFQOvys?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b79bc9-15a8-4fcb-c05d-08dda7070ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 03:38:07.9067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10643

From: John Ogness <john.ogness@linutronix.de> Sent: Thursday, June 5, 2025 =
12:43 AM
>=20
> On 2025-06-05, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
> >> I've tested the fix in my primary environment (ARM64 VM in the Azure c=
loud), and
> I've seen no failures to stop a CPU. I kept my
> >> custom logging in place, so I could confirm that the problem path is s=
till happening,
> and the fix recovers from the problem path.
> >> So the good results are not due to just a timing change. The "pr/ttyAM=
A0" task is still
> looping forever trying to get ownership
> >> of the console, but it is doing so at a higher level in nbcon_kthread_=
func() and in
> calling nbcon_emit_one(), and interrupts are
> >> enabled for part of the loop.
> >>
> >> Full disclosure: I have a secondary environment, also an ARM64 VM in t=
he Azure
> cloud, but running on an older version of
> >> Hyper-V. In this environment I see the same custom logging results, an=
d the
> "pr/ttyAMA0" task is indeed looping with
> >> interrupts enabled. But for some reason, the CPU doesn't stop in respo=
nse to
> IPI_CPU_STOP. I don't see any evidence that this
> >> failure to stop is due to the Linux pl011 driver or nbcon. This older =
version of Hyper-V
> has a known problem in pl011 UART
> >> emulation, and I have a theory on how that problem may be causing the =
failure to
> stop. It will take me some time to investigate
> >> further, but based on what I know now, that investigation should not h=
old up this fix.
> >>
> >> Michael
> >
> > Thank you for testing the patch.
> > I'm concerned about the thread looping...
>=20
> The thread would only loop if there is a backlog. But that backlog
> should have been flushed atomically by the panic CPU.
>=20
> Are you able to dump the kernel buffer and see if there are trailing
> messages in the kernel buffer that did not get printed? I wonder if the
> atomic printing is hanging or something.
>=20

Getting back to your question. There are 24 lines of console output
in the panic path with sysrq, up to and including the "SMP: stopping
secondary CPUs" line. The nbcon kthread starts to output the
first line, which is at INFO level. Then the panic() function outputs
the 2nd line at EMERGENCY level and in doing so it takes control
of the console, and re-outputs the 1st line followed by the 2nd line.
The panic function then outputs the remaining 22 lines. What I see
is that in nbcon_kthread_func(), the call to rcuwait_wait_event()
completes about 80,000 times after the panic() path takes control
of the console. That rcuwait_wait_event() stops completing sometime
between when the panic path calls nbcon_emit_next_record() for
the 2nd line and again for the 3rd line. Then nbcon_kthread_func()
remains quiescent as the panic path outputs the remaining lines in
successive calls to nbcon_emit_next_record(). Of course, the other
CPUs then get stopped, and the kthread can't do anything anyway. I
haven't tried to track down all the nuances of the expected behavior,
and my custom tracing has limitations. But maybe the kthread looping
behavior is as expected?

Separately, I see that you have posted a patch that solves the
original problem in a different way. I'll test that tonight or
tomorrow.

Michael
