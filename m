Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2116.outbound.protection.outlook.com [40.107.237.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42DD20E7
	for <linux-serial@vger.kernel.org>; Tue,  9 Jan 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="UffH+z4c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbWvT80WCBHZD8T31wyRauW3eKnmw6j++0ka0UuOIwZ89S4VmNu3fjBQH2F32C/L/LiiDn0+4tPb5jM0vH1e+n4GmSbk3AE2C/9GoeKUiqe6ckHzplbHZaJP9iof7wCg6fPIa3u8W6XeCNu+I0HLku6udYC2E/ZZE0qWTJcv7RkzweHX95C1G4s4OdMJoeNejB+Mxik3XfEuaszw8UAk1Kwfwd3VIeHC4rRFCa9CUCj5EWgrhurpiXTZEu+AsOkP1/TWZ3TGj0QBCl+HedFwruFz/j8KVhV67nDZHNond3/5Cv89B92pWcDQYZokKVrffEntUDvj0MlssBvpoubDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+W6xzl4RWpBGK4MdRETAB5oeajjWIlZfz4aTSrhrPg=;
 b=h9aeoL6Ik9DvQ4GpXQKoWzWiYNIFtYjT3E7ldQPSazcduoFAmLnmS+2tCH9YNPLyXvj+QytZFDdfITblVVcG7PJ0agSu3EP0KNaMWb2FGacftWxT3gKNlwDL5VXuj9s+1CPRjziK5hekEZPaLkXLQJSPfMOvhEhABU1pL71bK4tkS64KmSQK4RD0TCEkNToFalw7GbLvtGSPy0OSWnNfztxP63uXL6dYNx0TZH96Xp971KPon45nZ1puJcPkkWGhB4WgViKA8vbBu7G7U6IWkvTPGnGc9bVw7wHPHiTrS2GSx56BaBZiXpj+DchjLLdKKyUoHA13ijMvurxILt55tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+W6xzl4RWpBGK4MdRETAB5oeajjWIlZfz4aTSrhrPg=;
 b=UffH+z4cfoqmwkf8oGDsx2RvbyWKUuZWqGA66veOjs+EtuNQme/FBw8qWmZ6B2RDxh6P7Q0Q1xvEkt0WiGrNVsIpJDD75N0l0mIVoZF8V5/8aR4njuicyAXryvABzKQwKWBtsqCgWzzMnzJm7OmgL79wpiVEbUgRKa7T2PoWwil+/PV8tsGgDZCcQmH90DE4Hg3FtWIJXtLZvm4tQqMwIcRJ0HsLmqGv4Lnzthn/MPzuP+8GUsKng5Y0gL6lNd0Z7pQQFW2hJ3yKl5b3O743l0xlf33byhyIHEx2u+UAX3mxzfAjSZec3l/dAubf9jwOeOQ+u2iNgQJna93LDnDJPQ==
Received: from DM4PR01MB7595.prod.exchangelabs.com (2603:10b6:8:5e::22) by
 PH7PR01MB7702.prod.exchangelabs.com (2603:10b6:510:1d5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Tue, 9 Jan 2024 21:25:03 +0000
Received: from DM4PR01MB7595.prod.exchangelabs.com
 ([fe80::6878:c4a4:24f7:4e5d]) by DM4PR01MB7595.prod.exchangelabs.com
 ([fe80::6878:c4a4:24f7:4e5d%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 21:25:03 +0000
From: "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com>
To: Hugo Villeneuve <hugo@hugovil.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: max14830 irq
Thread-Topic: max14830 irq
Thread-Index: AdpCZgM5EpVKR9TvQJaVhp41Fise0gAHCR4AACRxtcA=
Date: Tue, 9 Jan 2024 21:25:03 +0000
Message-ID:
 <DM4PR01MB75959DD41CC90B1B704A05D29E6A2@DM4PR01MB7595.prod.exchangelabs.com>
References:
 <DM4PR01MB75952BAB0B535CF832C89AD99E6B2@DM4PR01MB7595.prod.exchangelabs.com>
 <20240108172934.c457ca06b6543f868d32de46@hugovil.com>
In-Reply-To: <20240108172934.c457ca06b6543f868d32de46@hugovil.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR01MB7595:EE_|PH7PR01MB7702:EE_
x-ms-office365-filtering-correlation-id: a19dbf4e-6768-42d2-e60d-08dc11597167
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RsE2FXMRhm4Wrr+4+Q37f6x6bSiUd0AGOY6nIMxVBUsv1vckPTtlCDPLRCAYDGTDJ9KqAs22KR0sNoznpJJlWh9R3ByV7kanTizoZn6qe6SZ5XHTIqaxhl/NmHg1PKU+ZKOcVI/lCZ4RNVKDlaFwhlnWeFKn3VR8Z/mDyYHJZmk5poCWWefvwaNo7KUrqBEKIFrVjH+fiNhwgUD8OXhJYJ7tQW0ENw1fz2bRSkmFeMxb5MPGAtKSGQezmgYza/yIW4cRqsqcDo1WsKdjb5rHhuQJZ6y/Kil+WekFMfquoZdN7QM39HNAuFNtppGbLMjJt5lp3/k08U8U73X/kMjMUtflHCkU7l8F6Ep7yDTk2s31kM3M0uzCWEaIhyVl9UzrLnx8DvdXplUJ2moIdi13okdafrU5iEnT/qnEdFs+7CDr+3ffQ4VE6PP7gXm50oPj+NdWBBpmlwFzbrprx2UmBWcCAdl/LawTYwRgWFR/Km5aVeHrJ+NUsq08+fsQ9MSGTsIJPVXXADYFeGDkzq6/P7HP8xir/yvPwUT49TbJfZaG2inSI3MIXnMi37Pkq9H8qnt29rwpEDQVPYOH29n40xvQLE4xVg39UjQnhL2qGQxG+hGm3QrO6fVVhUN85uXML+IVt2gIf4txKYrFLqRiGhHX67Tl6QabVaeFeSh8/Fk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR01MB7595.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39850400004)(136003)(366004)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(55016003)(53546011)(9686003)(26005)(6506007)(7696005)(478600001)(71200400001)(122000001)(38100700002)(86362001)(33656002)(2906002)(41300700001)(66556008)(5660300002)(38070700009)(83380400001)(316002)(8936002)(76116006)(66946007)(66446008)(6916009)(64756008)(66476007)(52536014)(7116003)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?apUaD8+n2BhAL2vKcP5WYRVuutBHJR4EYfBAfD9P/ETfYhOqYCnO9LVk18r/?=
 =?us-ascii?Q?/ESpGTF8m4ZCrQV7ruNV/BDpBl2eg9PxmlySwe5I0Dqo4sGDmOOMnk02sDid?=
 =?us-ascii?Q?4dor4Zmrw6s6cF5P5mfE/thnLxoTqpQgOJh4eUlOO2IJ4HnoHcQwwPy9JyRO?=
 =?us-ascii?Q?Y9/mhv9Kep1BMnABNtM9dDYaMiNPgw5yOzlrxPU6LC/+jBOPzXLD8wPG8zNq?=
 =?us-ascii?Q?9ZkPQTSBcYgDtKQFTpcrfkQ9m9Rh655nx+p4h5BO6DCAzf4StisfjJZnMNiA?=
 =?us-ascii?Q?ehlPfceyLQZr1tHrpkXOE17aC5IrpcRedce/XEbSxgd7eSjrPm8DFAgDcCAa?=
 =?us-ascii?Q?2Us3VFXhkkFQ51/6bz2dQqI0EOKBmsnw9b4K1vZ+WTt47nLWfNfre60UgcpA?=
 =?us-ascii?Q?4Hr2nPg+8CBbbSLGv6zwlryNzybAWjI8Z98WdNeutN0/4yJr7vzmznNwvBMm?=
 =?us-ascii?Q?q7lRzR8V/iWQTn4limNYCcP7FBvGLJzsmyarrB6kHUQZj6utX+LG+afXhNPO?=
 =?us-ascii?Q?mcjj/mwS+ErKWHHbft32tZ8vg8gyhNtswYzRAQQhRcChaX678bLHF92PnP6Y?=
 =?us-ascii?Q?wA0WBh9xxvKNgg/+hG71JeKzEvns3H5pmWBzolRQiklycXOO5J4FkEQp6xMU?=
 =?us-ascii?Q?svl+ETv8g0AxWftWEmTi1DueHj3jCLkakw1fXdKAETN1lcQMohImn6yqScZB?=
 =?us-ascii?Q?ebSl8R05qpfhKgKbjlfPkShkd5+Uexy7rhZmlkVv8T9+ZI7FDjo0Rg7HDbMR?=
 =?us-ascii?Q?TljaTQArwqq4NxJ9obK2KSolxiU08PlABMA4O1h+c9F/a9gugoeBd0Hr78pP?=
 =?us-ascii?Q?k6+rxFtq3oUVT42pmzoGNLZYoBC060r4K+RKZxMI5UmaeDPFbnp6vu3ndv6a?=
 =?us-ascii?Q?pGgUuhx3klV8Ny1UB5FPuz6y3D1HFDbfke468GNBv6EvSkbqr4DDrGj6GRVK?=
 =?us-ascii?Q?zEOQjAd5Uxjs03x5imy7EbAz+oD3BkpQTnNWq4mch0abEOnfdud+nG1xoGmr?=
 =?us-ascii?Q?IkiSUk57l5vAWAWq0yJ/gdxFBrN7oNmCND3xntjBEs96IhG6tmvfEmp6kKC5?=
 =?us-ascii?Q?5mJK9i4Yhga+cRu4vQtjuwWLvgnLXcZX+jOX/Y/HeAFWwml/XNLg3p9bgH+N?=
 =?us-ascii?Q?b4VRMflUZyVgpDqroljRrbSdeRdQ+likhGRFRSAi1J83fbfjLcvJ2WYolX08?=
 =?us-ascii?Q?Vq9nhaT/LZ6eEV4PMyrVjrbxdaB8m7rQiY9xMbf37UDRD6yhTDxBDbNAbpqv?=
 =?us-ascii?Q?xcrLeMtXAFmlggbXFcBD1hSM3qbphEle68b4CJJm0pGqivOwtZOqOoj5YBSB?=
 =?us-ascii?Q?HQ2dAXs9wFo2WmPGqwfS2y9CxT07RdY8ni75utuwLanO4srocgv/5P4NzECG?=
 =?us-ascii?Q?KiHCL98EJkum6ny8p60iRvnpMhvhd7SagqCgRAOm73TY3XiPJ/d2Ih93MLiz?=
 =?us-ascii?Q?gCln5PJJvYJz2P5yqhRyNI1/UYJF26tsYwRUpPcIoOZkVA5RkIYEPDTWBo4q?=
 =?us-ascii?Q?Rx2w4aVxSIhlXcKC89WPmmKtG49WQ1Ze8xYttMsW4IM4pyDKFaOfg+NHIVeC?=
 =?us-ascii?Q?mmX7OpbEwNj3MUfOEh0ecm1X6PTdeydQ3RMxWh3kgo2CPSkEkpE8Xe16gcnT?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR01MB7595.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19dbf4e-6768-42d2-e60d-08dc11597167
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 21:25:03.1988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69IgQTmwlHEMAZ1fvLbkVHp9O6KwD/S7QAqCsU5sFkYqhtAS3YmBgYEgIhIrWcvL/FT2yLQhnsbIM1brahNBWSBSr75ynMSI2inlmffYabWU0bc4BUvIH1Ps52cD8Dfj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7702

Hi Hugo.
Thanks so much for your response.

I was building with 6.1 had one patch but not the other.  I brought over th=
e 2nd patch as well but made no difference.

I switched from 6.1 to 6.6 which has both patches and still the same issue.

What do you suggest next?
Usha



> -----Original Message-----
> From: Hugo Villeneuve <hugo@hugovil.com>
> Sent: Monday, January 8, 2024 5:30 PM
> To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> Cc: linux-serial@vger.kernel.org
> Subject: Re: max14830 irq
>
> On Mon, 8 Jan 2024 19:08:08 +0000
> "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com> wrote:
>
> > Hello,
> > I am trying to get max14830 working on our platform and I'm seeing a st=
ack
> trace for each of the UARTs in my device tree.  I'm not sure what the fix=
 is.  I'm
> running 6.1.15-580639a (OpenBMC 2.14.0) on ASPEED ast2600.  Any help
> appreciated.
> > [    2.608620] max310x 11-006c: clock is not stable yet
> > [    2.614933] 11-006c: ttyMAX0 at I/O 0x0 (irq =3D 57, base_baud =3D 3=
750000) is a
> MAX14830
> > [    2.625532] 11-006c: ttyMAX1 at I/O 0x1 (irq =3D 57, base_baud =3D 3=
750000) is a
> MAX14830
> > [    2.636061] 11-006c: ttyMAX2 at I/O 0x2 (irq =3D 57, base_baud =3D 3=
750000) is a
> MAX14830
> > [    2.646513] 11-006c: ttyMAX3 at I/O 0x3 (irq =3D 57, base_baud =3D 3=
750000) is a
> MAX14830
>
> Hi,
> it seems you have I2C communication with your device and the ID register =
was
> read correctly in the probe() function. If it was not the case, you would=
 have an
> error message about that.
>
> > And,
> > [   88.430219] irq 57: nobody cared (try booting with the "irqpoll" opt=
ion)
>
> This is probalbly happening because max310x_ist() was called, but when it
> exited the interrupt line was still active, so that it was not handled pr=
operly.
>
> Can you make sure you have the following two patches in your kernel
> version:
>
> 984a4afdc87a ("regmap: prevent noinc writes from clobbering cache")
> c94e5baa989f ("serial: max310x: fix IO data corruption in batched
> operations")
>
> I do not have hardware to test it, and this is a wild guess, but they may=
 be
> relevant to your problem because they enable the FIFOs to be read/written
> properly. If Rx FIFO for example cannot be read, the source of the interr=
upt
> cannot be cleared, and could potentially explain your problem.
>
> Hugo Villeneuve
>
>
> > [   88.437720] CPU: 0 PID: 65 Comm: irq/57-11-006c Not tainted 6.1.15-
> 580639a #1
> > [   88.445687] Hardware name: Generic DT based system
> > [   88.451046]  unwind_backtrace from show_stack+0x18/0x1c
> > [   88.456906]  show_stack from dump_stack_lvl+0x40/0x4c
> > [   88.462556]  dump_stack_lvl from __report_bad_irq+0x44/0xc8
> > [   88.468784]  __report_bad_irq from note_interrupt+0x2c8/0x314
> > [   88.475208]  note_interrupt from handle_irq_event+0x90/0x94
> > [   88.481436]  handle_irq_event from handle_level_irq+0xbc/0x1b4
> > [   88.487952]  handle_level_irq from generic_handle_domain_irq+0x30/0x=
40
> > [   88.495253]  generic_handle_domain_irq from
> aspeed_gpio_irq_handler+0xac/0x158
> > [   88.503326]  aspeed_gpio_irq_handler from
> generic_handle_domain_irq+0x30/0x40
> > [   88.511305]  generic_handle_domain_irq from gic_handle_irq+0x6c/0x80
> > [   88.518411]  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
> > [   88.525316]  generic_handle_arch_irq from call_with_stack+0x18/0x20
> > [   88.532328]  call_with_stack from __irq_svc+0x98/0xb0
> > [   88.537973] Exception stack(0xbf925eb0 to 0xbf925ef8)
> > [   88.543614] 5ea0:                                     45854088 00000=
003 00000001
> 00000000
> > [   88.552742] 5ec0: 00000000 4184ee80 45854088 00000000 45854000
> 41a64140 00000000 00000000
> > [   88.561870] 5ee0: 00000000 bf925f00 4016bb7c 4016bac0 600f0013 fffff=
fff
> > [   88.569252]  __irq_svc from __wake_up_common_lock+0x1c/0xb8
> > [   88.575483]  __wake_up_common_lock from __wake_up+0x20/0x28
> > [   88.581714]  __wake_up from irq_thread+0x118/0x1ec
> > [   88.587070]  irq_thread from kthread+0xd8/0xf4
> > [   88.592040]  kthread from ret_from_fork+0x14/0x2c
> > [   88.597288] Exception stack(0xbf925fb0 to 0xbf925ff8)
> > [   88.602923] 5fa0:                                     00000000 00000=
000 00000000
> 00000000
> > [   88.612053] 5fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> > [   88.621179] 5fe0: 00000000 00000000 00000000 00000000 00000013
> 00000000
> > [   88.628559] handlers:
> > [   88.631088] [<4f379e2c>] irq_default_primary_handler threaded
> [<26199d83>] max310x_ist
> > [   88.639952] Disabling IRQ #57
> >
> > __________________________
> > Usha Srinivasan
External recipient
