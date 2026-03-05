Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D23783AA;
	Thu,  5 Mar 2026 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706033; cv=fail; b=JURNMSd9YLTStVhNC7QswVynv6XYNVPuidKMffXbJWIVqIwLijWeQRxHfVywkMCjIS8LcSLh4vo7YQMuZNenwK8O/P0V/iNKlnCN0vnVyDQjh9O7ipbqzc1NW68cr5FG9Kgq9TRwZtkGIE2E7wf4Urkta6BnxMQJQJX3azgAc3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706033; c=relaxed/simple;
	bh=k3Wk+wJs1B8G9f7OTVQ+7E8XT1t3A9HDlrKHvBuQezA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rOm2OuMqBJQ22ubA5kPpa8K8bFcFvDCMYlJXBRnDGUY9tKIMLw2see5gFmVkojWkLjFM0T0oy8Qm1I8eo5n0bYIdLx7+kVHRxIKD/l5tdAb8L4d2cVFLrIpxZrUibifCbTqMYs+R7o0UgM0LGADdW4D4eo8i69Iw+W2Ur83FK2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2pp3VNqb; arc=fail smtp.client-ip=40.107.208.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2pp3VNqb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6HpZU5ftS7LcQQ5ia2B5LDUswLxpj8Q1RwYkdZyooc7wq2AusS4pbNaorLHGqoHKWJl5xqFdzvvJukBNYgvrWPpjUyuxz0N7X4ZDSJel1u7nFGg9utOfAV52BrMD9Fw86NxB8aIcpdnP7YlGapQ1uvFGWzghX7e3SRi3R4q9nneP2O4SUmO42n6YFpEbiUhtv0ORlwRXYRxQcydwxNkRFddgRdgwjTwNyxxq3QqwF8rp2ywtuXAEV8ilD91rPAwGVBYMkyYoKi2vuXvKTnoaxVdg35Xsz/1SFPO80TyboJrQ5QuwMf1Eewmld+85yZks3NFullSRogNhzQ/4E4DyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3Wk+wJs1B8G9f7OTVQ+7E8XT1t3A9HDlrKHvBuQezA=;
 b=CO+wzAEuJNIko5y33Z/OpQLJvoGiWXS1v/Kr2Cn3F2ftgQ0jnjvzLNvN5/RwkgZdLHG5dwJEEn0T5TtopXGcWYW7WOOTK0HsZAJOh+pWI67Tm92ZM+fXkImccI8C2i8bqR15EvYcecej7r3fFIpwCK0ucun+zdeXIBstTZY6swQP5jl6PQSYOdaOt0CbwM/xFj0MQH+6l8OTknh40oPmJI7bRoNQB8feb0sUz7Y0PVHeCZoi/1ROsmgTpeTcuBd+nnI9DcjeeFtr1nGNpemZnR1Hb0b6sqa/HQPWOpzDD1kYv/8ozS6tU3YtWmigKcwI/SOJpztb/mxIsJoMIYjh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3Wk+wJs1B8G9f7OTVQ+7E8XT1t3A9HDlrKHvBuQezA=;
 b=2pp3VNqbDDT1ehJBTy1aCM1WLNinDiQSxVKM7U9r3tGqbjuJhGTonp/ucdf/kByO/umWlvoKG/flz6+aenE5Idqv4Pv+6NF2VVSUbvORDcyKOjUYsIGl6y1CuuGYDaNzw3UXTIagyMZYLpkNRIZEc/7t9vwyGiYp+04z7ujThJBfrSsOOTpmKNVLxsvgjhGn1EeBn/PzeGFwy/7vjqm2mJoyVdYmTjr/3wTf6Xi8gLdpffvB4dmbtJDqpi+UeRo5Qpe9E7BCs+dq3qYoVgplto8G4JgOMTe0EFCtOqJAhVE8BwEK1bCCaERIyy8gaHKFOaIWSkzXsGoLKhE6L4JzDA==
Received: from IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13)
 by PH7PR11MB6793.namprd11.prod.outlook.com (2603:10b6:510:1b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 10:20:28 +0000
Received: from IA1PR11MB7725.namprd11.prod.outlook.com
 ([fe80::da2d:31ac:13fb:aa17]) by IA1PR11MB7725.namprd11.prod.outlook.com
 ([fe80::da2d:31ac:13fb:aa17%2]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 10:20:28 +0000
From: <Kumaravel.Thiagarajan@microchip.com>
To: <Lavanya.Nehru@microchip.com>, <jirislaby@kernel.org>
CC: <gregkh@linuxfoundation.org>, <rengarajan.s@microchip.com>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Lavanya.Nehru@microchip.com>
Subject: RE: [PATCH tty] 8250: microchip: pci1xxxx: Fix hardware flow control
 failure
Thread-Topic: [PATCH tty] 8250: microchip: pci1xxxx: Fix hardware flow control
 failure
Thread-Index: AQHcqv03oGpqsTJXyk6vQDyJ87cSLrWfuzxA
Date: Thu, 5 Mar 2026 10:20:28 +0000
Message-ID:
 <IA1PR11MB772561B63A0A4D6C4EE0E5DCE97DA@IA1PR11MB7725.namprd11.prod.outlook.com>
References: <20260303110201.38732-1-Lavanya.Nehru@microchip.com>
In-Reply-To: <20260303110201.38732-1-Lavanya.Nehru@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7725:EE_|PH7PR11MB6793:EE_
x-ms-office365-filtering-correlation-id: c8fb3d74-d7b6-4058-773d-08de7aa0d2f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 s2waxsKhf3QBQhNSppm34kplLxkeQIB62/UU+Ftfw0GkYl92j8qY28ULKds9tQ8r0aym1UaUKqhKc4y3vZxeIyKhURuW7z33abccnB9P0x7eY+kfWn8d/dOlGqgWzuAzNpOiN8+9EBYgakNTJqr6Pze+EukAmiu7r3Zb1oLDz1vCoQbQGohpqXaD+T+DNXKiY6JsZK7UDXYBshCvJHm6fOEDp4B3wYxXNGFcwCIpK0GrxN96qNayiwuwfWUftmrAS5cY70iAWnsQ805G73w8jQM3XTYTupR/iQrAxfSOSiyaO9IOEj30rDSfMNo6Jrribx+3oMZztgVBMMTVVxz3lfHTQwk1usCxNB4kglaUUNOeEoFbrjELuO2D6phLBi821qdzU0StnWhrVQ7U6EYxruaemT7IjZ/kxKEqd7Jl+IwRE+uzAhtb3QpQJGw9TOGIiRHpDc3eQOgrmxF9EsIFvMK/6DQf3ZOTkoCHXJAdmaLAMatCAtxuUTfD8eMVGVs/RuUhC98EeG84ocdxlVows2FdeDdVZvzr6MpLLRr/qqMor2dLv/cgjm3rBPtzSyh7IoXqKeDvrNdsOQYPL4OTu+HBMrzzvAvxxjhsgS8X+3UWrk6zZjo49j7FtEmCZd2lkje12PZdFHl0KByJzvnsypGusWxqYAOdrzIBvbIWnvzIDgXNYdLxO+pYWavhO8x2D/nRmAS/6O8p5ph1QvEgSthGKvE2NEnJRhtZz/Kf1J9N+5diAxyA9BOljbErDwGcjsSA9MfczYjKddaLqjy21e0O//c3nP2Nm5PKlD1qQbA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7725.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qekrD9WEaF0EQeINUV9+6JZLwjW8VWuUktwg2n/rCIBh7e1pJ/3bfyM6f5Ke?=
 =?us-ascii?Q?1RPeaxWfI2jP7RCYBMc6i5TEjytGkTUD4AoFJoogYLVWvuLRWjoOGlR2zGDH?=
 =?us-ascii?Q?xu1/8uQ3+5dTxu2beKXhQkEeAcm+hwNpcXbvzfDDXFjRU0ACM3kS9xchaM2O?=
 =?us-ascii?Q?ZQh1w4kOvsqvw1PPPQBZWmCzu6RvJcy3q9ltRDqjmoP+iOUBjCIbZ8wDPnQs?=
 =?us-ascii?Q?/MRZt94bZqEeBpF6Y3X7nspFHHAqQd5JTFbPMQynQ50i1JkRTXqV2vxYwjKU?=
 =?us-ascii?Q?SSxR4pA63QbbwopQcpB3pzO7IB9b0M0KHeh1d91QTFA3DdaQa2I9sXO6/jXz?=
 =?us-ascii?Q?KFbuQkBYrlbLdE/mrBxCNPF0DnXFa5/OD4nIig9YLfxnEsXbb+fbwvXTKN3/?=
 =?us-ascii?Q?1AZQzCqaPP+Udt6NczbvDqpqZUkZZCaUGhtlFYxZC2CY4e29YqvHPKrse4MI?=
 =?us-ascii?Q?Dyi2PUf5qHLBhGdrJ/zIVI25iKmg3UA8QK3ss/lRN7+gDpS5iD/qN/wfVniw?=
 =?us-ascii?Q?uKXQJyCh0p+OUV7Ef6kci1hSKEU7kYr+Vc+imYTtQuskJMe8mKVoyEvSGZt8?=
 =?us-ascii?Q?7WzZuU8SvU3Z0dABUmvXIB3mc19Ez6RZF1KVYB0P+iBJcDCFzmhzyyb5YMF8?=
 =?us-ascii?Q?EZaKGJuui4/qu6rlR/wCP3lDbPtb5gNoqHK7X5LU8gTlSKicYGCCKqcX7q+l?=
 =?us-ascii?Q?ODvpm9sEuQAiVewa6dfqImbVKx9S1ir+HQQdgXVOvV4Tsunmkb8+ghYIIJkN?=
 =?us-ascii?Q?BWMpHq0gj02qT67X0IECkwzI3ZzdG2HxSg/unO7D0MXb7GHHe7LOZ5hLjVNO?=
 =?us-ascii?Q?pgfBa+Iy3sNw0TSvp5PoBgfFqITsXjx8/om0qNznjuOBXSisr6ORJGPtrUKX?=
 =?us-ascii?Q?8UDE1YmGkT/1VKiHFNTclQiAHb1INl9pShzB5h/LHgWVFijJYrmxb7CXRpF7?=
 =?us-ascii?Q?MJsJ+LeDhdrZPn3Ok3CnqnkEhe0Qb1KWMH6vzxcj+xmGya31BlxkJcds8zoz?=
 =?us-ascii?Q?T1ztEgis/f/eDCAVA45DoGDkyFg9HKvYtiACeSaedTXAg9byjobkWHKWc+3g?=
 =?us-ascii?Q?fu2ncMwvDv7EYR+JTxPVzglV3/Iz6FcxJkUOvTV3xo/RUahKaZ34+EC6T8Ei?=
 =?us-ascii?Q?RI8dDAVCD2kv5DHLnKO0fqrMbaCJIJXXKPkdpCHkfS4MVugh17hLcjXMrYj5?=
 =?us-ascii?Q?W685rWqGV0eZGGr0slfwipeW8Kl8n5byjD4qx6hcGw9TJOTYWdlW8BNg45HK?=
 =?us-ascii?Q?BVy2zRRAS15B2KskztiMElHvIC7JDm5uGXk6peADZd9rrRoNW09MDs/gOz9Y?=
 =?us-ascii?Q?fICm24QA9qc24w7eBSshQ1Y+QGLVVKhkCmByiVj8IOMdgbaw6qxYxa+Zw0wP?=
 =?us-ascii?Q?nae1XyAwjqzL4PM3LL86z8hZBvkOUN/rodcNJ1JhSkwjqu72PgDplfUFFvA+?=
 =?us-ascii?Q?EnW0tyH6bfIIpEWrh1N4SyAyoee/k+xvCNBuYZ8LFSpH8/5Dqg04DPP8Bwpp?=
 =?us-ascii?Q?1IzZNkzk65mP7dXChE17LCmUruh99XowRNY0ZctkAvLADPFybUV+WjR3kIU8?=
 =?us-ascii?Q?L3XSxqI78vStMP27Dx84qQFd9Cq1Ho9/102i+p1XBPWJA8sGeftcj4bDJUE+?=
 =?us-ascii?Q?4/727jIgDJ5y7CwuJnBczoyTv1j9kBJpbS/72DhCS0lvr20Fn/wuDzpv2cke?=
 =?us-ascii?Q?Vlw2TD0cxFMoKBOStVi2/zVdykvKF3/ZdL56yU6wc9oodrqGaoNsD7SXwj/c?=
 =?us-ascii?Q?EEW9+J3VgHSIsIaN3xMZ7kia7PGcaGU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7725.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fb3d74-d7b6-4058-773d-08de7aa0d2f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 10:20:28.5197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JX+Chy12euAWseDNv3uC+GY9ZGiZmK48sFEOdaKz63keFG4kn6bVGl9jhLr1EbY6bY/dy2AUtLGesGaRYa36i07vsV0ZcRSJRxYuf7YDBm1oLDQ1B+/88Ty7s1L/siJL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6793


> -----Original Message-----
> From: Lavanya N <Lavanya.Nehru@microchip.com>
> Sent: Tuesday, March 3, 2026 4:32 PM
> To: jirislaby@kernel.org
> Cc: gregkh@linuxfoundation.org; Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>; rengarajan.s@microchip.com;
> linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; UNGLinuxDrive=
r
> <UNGLinuxDriver@microchip.com>; Lavanya Nehru - I74215
> <Lavanya.Nehru@microchip.com>
> Subject: [PATCH tty] 8250: microchip: pci1xxxx: Fix hardware flow control
> failure
>=20
> Fix the interrupt handler in the pci1xxxx UART driver by adding the missi=
ng
> serial8250_modem_status() call.
>=20
> Without this call, modem status interrupts (CTS, DSR, RI, DCD) are not
> processed, which breaks hardware flow control.
>=20
> Fixes: aba8290f368d ("8250: microchip: pci1xxxx: Add Burst mode reception
> support in uart driver for writing into FIFO")
> Signed-off-by: Lavanya N <Lavanya.Nehru@microchip.com>

Reviewed-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
