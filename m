Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2092.outbound.protection.partner.outlook.cn [139.219.146.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2BC383BE;
	Wed, 15 May 2024 03:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715744483; cv=fail; b=g8RkaPLB4RSFwetY4Divj2bIntLrMED8beaZQkNn8zqKgifX4MdYP6sXwhysZROqUTcjuiUmEdI7cxp8y3UfjTj6zVp62nacvUSTwaW/Sr1OAel7B6wDqA5b71xaLXHcO7cQqP+9Ctgvkk8mnPZY9dEUF4SqWBFjmX6BZG1Rcg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715744483; c=relaxed/simple;
	bh=yfFhVG4S6cthnEGo3THsj+rnsgXbSAiLN/UY0Sr0+FQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qAKky+/OwEJNEty7Azy4b7X2HJ6U/Qlz7Mj4y7Vwq02U9mdu5rTKhn9QAsoKjY12KRk/AXJY627PRD8m8QfeAFTG29E7KI9fk9t/SHZ17v4p8mAt28pPXDGyWB+/qRpB+sEt3ySYBodo9L4GgRt8mQt0DsLcq0PFIJe6pPqBvsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URdEEfJXtqmZCk/xr9+9w4xRks7DA4Mcw9AiOXAgSLYsAuBDzwPqjQQG6u53wo+vwisp8MIfL81+lajJEkv4rIJ1/1+TbmiYIVFdjsrHnfBjW3IjRLll8nxMz9L5xFyuDd2/I31iJsxbmOn58ay2Q70f0P9JHPHcZoflSMxhR4A/8qqWppSVD5nHRlOrUZN4JGgIh4JW6CKD/CaKUnT4jPuouvz86QSofy61WWXZm+Q4vncGt6+AQtp6ol3bgM0RLc7Sxkun4l7JFPXEhkRFePTdjm5X7GxzlnWqphlxkAvTjtHVQXxww/U63pSaH95TEtU/aixYteWa4GomZn9wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/3NYGxjoU3cqSCsyOiV/C9gdPGPZ6D/vXwxfaz5XBM=;
 b=Q3tU9MburJFykTYBWiwzwSfo4i6rOu4kjoRpyAxsACk1Rf8RhZyK0eLupiujUy6Ng/KfEiiojHMnA6k5hqRs52TFaL4CxoK/bWV2DUfTyZZtwfMFbdxMQ/4sbpiXigZRz2cL6ySyWATmBlk/w4rVwbyMBWE0w06+WAjTpcn6UOeAb6Vz9+qMqemorE9+hKn1AeI+mv9tIrF6ilzm7GIuQ6y2CeZxdrMZOLQj5kVDzPqVhommHyb0AfO6/CE3j9EvQqm0CzGS1RkIX6rg/2o/kJUNKe645sYRbaWjgk2agkVs9PBX4G1dSD0vOCAbSpyCarzIZiLSUA8rA8Nx4MQM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0732.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:23::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 15 May
 2024 03:07:37 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Wed, 15 May 2024
 03:07:37 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Frank Li <Frank.li@nxp.com>
CC: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "joe@perches.com" <joe@perches.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "robh@kernel.org"
	<robh@kernel.org>, "zbigniew.lukwinski@linux.intel.com"
	<zbigniew.lukwinski@linux.intel.com>
Subject: RE: [PATCH resend v9 1/8] i3c: add target mode support
Thread-Topic: [PATCH resend v9 1/8] i3c: add target mode support
Thread-Index:
 AQHaoL9J0lwk/jg/a0+LeeDupwAoCLGUgoawgADYHgCAAAMG8IAALSSAgACFTQCAAOELgIAAtQzA
Date: Wed, 15 May 2024 03:07:37 +0000
Message-ID:
 <SH0PR01MB084106A67DF4656C9B8CF686F9EC2@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240507204311.2898714-1-Frank.Li@nxp.com>
 <20240507204311.2898714-2-Frank.Li@nxp.com>
 <SH0PR01MB084187FBA1E4EE786A8996C9F9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZkI4GO4czdgs5/Xy@lizhi-Precision-Tower-5810>
 <SH0PR01MB084189445E4928BC5047495AF9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZkJgf/oRMMBswih1@lizhi-Precision-Tower-5810>
 <SH0PR01MB084183D40B4ECC0C4B3A9BF0F9E32@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZkONGQPBeuR6oZ0Q@lizhi-Precision-Tower-5810>
In-Reply-To: <ZkONGQPBeuR6oZ0Q@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0732:EE_
x-ms-office365-filtering-correlation-id: defb5a36-6661-4411-bcc4-08dc748c2cb8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IaEhCEyccKThB5kctU2IlgukrHwSfHM05vKQOfuHLmugC7i2oSNpChSBZfzXzJYt9VQ9WP+u2KyEOcsPlWruPPwLAFgWCMIOdQZTZ5yNNNvhiXo+MdSclkNKeRWZvuJtRB0DMHw1wEptlZsKf7XS3yTGLAcywigFPTPBacPFKgk+rNxGmN+krBkh3Y3hOdU1Bm4pM721AqM4uWdOQXXHw2G5+1vjGKYYManVrLepDQHqzNzhuLyRjBH09NquW2lcCytn6KuiMdHKf+3CCwA6Ng9is2LkJo2hhIwqxAYeQXYzEdzpJlNFyifGjnLvoGrw/qlDbPxQ9dYbL69SxxoPJ+DJE1eYadaHkF8PvztK63zEQ010nJElbIduNzxwzLyNQwBW3qh+PX8HmBpUWdOi64ynpx73JhQh7s8EyxoXbj1dcz8CLlbpmv2vC77dD0f5lEHhAQ/O8TH2+6HCois5ViOpO8yQYWnb8dkOZxFshSM69VkX6Fa0gUo8mLwPcaokW+kVa7PBXXg5M7J5onjw222N1T13+BwdedeNcpjFSmU6pnNJuhYvH4o0ggs0Kg2YqxfYUBgQYQP4ZgklJ7Dlc25nkBIJ0Gtql8mnkJBU92CeXb2pCN53lHp2gAg6nK02
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(41320700004)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+1WQxI7mt4T1JAzKl35kI6U3bpTsRZ8KUMqPPN21Hcfu+/7RXbj0d3CeyUV9?=
 =?us-ascii?Q?yvPmhld4refVRg6rS22ltJL6X+t8XlgVGDMIeXUUJaP7Iw5bB9XIKrFHBN59?=
 =?us-ascii?Q?xVLV1BpXg7Bm99UMg/vB6+K9frkfXkUx69PpBj5e0EH5qoXUJDyxEtQsDz4E?=
 =?us-ascii?Q?gmr3DgLxWqke1jBZkcfBSS/qbZpaA4raPz584xsRbNlGd0PNYKpArn5nT+dl?=
 =?us-ascii?Q?hGXaTWOCWLBCIdY5aLdKtb2fi9kp1N04UioQavlR7Rg9peTUc36qwz7tdZYT?=
 =?us-ascii?Q?cs4P8O+ni54KvIaO7Wn1IJKCCDkwJwWrLLBlyYZopJU9FSFOxSy058BdREJC?=
 =?us-ascii?Q?kYZfLPUKzM5yPMRaTB4fOkQCJ+SOBpY33P/i8floRvD/QZ/LGH3431NEjSYV?=
 =?us-ascii?Q?CAKuXzH4QiG3oPPnfu2x3I0ymi2W+d7fvgS5J1quw31azrR+H5D4VaVKie3e?=
 =?us-ascii?Q?p/mTbGQkoYPKXxm2djoLn84eyqN9rT4Cu9HbfOyM69tAqFruszoAngJbFLMx?=
 =?us-ascii?Q?KESqo2KxSguW7f3A5hZgwhCSoXipZS7YNDn9XdwOfqdaqIZs8bbKuRJIgCQJ?=
 =?us-ascii?Q?xBsaRD6lHTQ5EPPyvC4k4CPJ2FoBvRr1tPiPZSbfsjj+LKzAc0vNUdWNTNCF?=
 =?us-ascii?Q?pGqli0kbNjlRlE5juE/4lfNsVo1k9sOILcYS2Hs+DFuVIYxPYrtEYhHpZpXP?=
 =?us-ascii?Q?KBs8huf3K3RNY4P0sKHAjklvpgS2UvhP19lip1Lo994kDA9zSIer7h9+7NQ3?=
 =?us-ascii?Q?qMRK9apS6sCEIwAaoi5ym5IVy2C4kTHGHNx2WWpQFtDoqO/wEpyhf22ah/lT?=
 =?us-ascii?Q?Pame1MRA4S6WK0SL+CEAGcLwitD65Qfmq5+tUck2kmcAlWUuDXga7Zl/wZoK?=
 =?us-ascii?Q?40knxU8PD8Sjdx/802G8bYkEOB+ZQnZI3M9oMCjOpgOi/edb+ezT3OMzLSxR?=
 =?us-ascii?Q?P4ruyGeGylJ+CV9n9xMnuiyyMV2CTC1pHs2nyiqXD60KLnEWqJNq317WuO5q?=
 =?us-ascii?Q?paFDWnq/NNPrf+Vptk/MKB7qO4dJTDG9S6uHnoSnGXBk23+N0vKhvvPGZDsy?=
 =?us-ascii?Q?6EnDYnhjcN6eUslWkfUbh91wHMSmugWbSeH1WtFlxSmFD+fyk31PfirD+o2q?=
 =?us-ascii?Q?9edRxvnjSk8X5y+tyVviT6K3N77qcfGvah9cRxLdYaPOz2RhU6jZarJ8IhA9?=
 =?us-ascii?Q?FNWUHP3hdsth6PQ2qYw4Ke2AxO8xoxjPZSWiG1/fUsuKZpCK1PJ+tDWzprXZ?=
 =?us-ascii?Q?vaQ5bzU2gA3q5qgOMaeFs8izaRLmvlbXVQFbcvsFpgRM8RG7HZ5xwm0uWLxw?=
 =?us-ascii?Q?1D9QIGSSo6Z6r7mOEPJnnEFOxILebkCef3c6H9WHSPLeX88pax8uvbi505+B?=
 =?us-ascii?Q?HBqXkdgtKYUCsw9/ddxL9kOaYsT3OiVz94LriCb3cDOEDRA9xx0I/SiMhl95?=
 =?us-ascii?Q?v746+k6OIdfgrlwz0sZvv3pAuIqv3D+LN9PySfdNTteQ8Wcd2+9eKoZOUpCF?=
 =?us-ascii?Q?0ak9DMRGOZ6ldDMsN5UYQIlb/xUoSYqH10MJqPDkKipePcy4/dFjtbgpjHR6?=
 =?us-ascii?Q?og/cOGmp+x2IxyOQGrZLHynuAp8GiJNMtuKtcFjBXYP2SzkYvMB6XDgZwaKD?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: defb5a36-6661-4411-bcc4-08dc748c2cb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 03:07:37.4171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTLLzIc4rvxEJKLdQvH+rpAuXipqqnTWwiBO6JhLemFnD6U1nR10/JQq4y+CbWGko2S4aYFHb8OrcxDELRrlr/AmDHTjgQR+Ag4Izh7xku0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0732

Frank Li wrote:
>=20
> On Tue, May 14, 2024 at 03:07:25AM +0000, Joshua Yeong wrote:
> > Frank Li wrote:
> > >
> > > On Mon, May 13, 2024 at 04:18:00PM +0000, Joshua Yeong wrote:
> > > > Frank Li wrote:
> > > > > On Mon, May 13, 2024 at 03:16:05AM +0000, Joshua Yeong wrote:
> > > > > > Joshua Yeong wrote:
> > > > > > >
> > > > > > > Introduce a new target core layer in order to support target
> > > > > > > functions in linux kernel. This comprises the controller
> > > > > > > library and function
> > > > > library.
> > > > > > > Controller library implements functions specific to an
> > > > > > > target controller and function library implements functions
> > > > > > > specific to an target
> > > > > function.
> > > > > > >
> > > > > > > Introduce a new configfs entry to configure the target
> > > > > > > function configuring and bind the target function with target
> controller.
> > > > > > >
> > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Notes:
> > > > > > >     Change from v8 to v9
> > > > > > >     -none
> > > > > > >
> > > > > > >     Change from v7 to v8
> > > > > > >     Added missed head files
> > > > > > >
> > > > > > >     Change from v5 to v6
> > > > > > >     - fixed build error when have not CONFIG_TARGET_CONFIGFS
> > > > > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > > > > >     | Closes:
> > > > > > > https://lore.kernel.org/oe-kbuild-all/202402030437.GdGCrKeK-
> > > > > > > lkp@intel.com/
> > > > > > >
> > > > > > >     Chagne from v4 to v5
> > > > > > >     - add include <linux/slab.h> to fix build error
> > > > > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > > > > >     | Closes:
> > > > > > > https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > > > > > > lkp@intel.com/
> > > > > > >
> > > > > > >     Chagne from v4 to v8
> > > > > > >     - add include <linux/slab.h> to fix build error
> > > > > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > > > > >     | Closes:
> > > > > > > https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > > > > > > lkp@intel.com/
> > > > > > >
> > > > > > >  drivers/i3c/Kconfig        |  28 +-
> > > > > > >  drivers/i3c/Makefile       |   2 +
> > > > > > >  drivers/i3c/i3c-cfs.c      | 389 ++++++++++++++++++++++++++
> > > > > > >  drivers/i3c/target.c       | 453
> ++++++++++++++++++++++++++++++
> > > > > > >  include/linux/i3c/target.h | 548
> > > > > > > +++++++++++++++++++++++++++++++++++++
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > diff --git a/include/linux/i3c/target.h
> > > > > > > b/include/linux/i3c/target.h new file mode 100644 index
> > > > > > > 0000000000000..b0bf06685834c
> > > > > > > --- /dev/null
> > > > > > > +++ b/include/linux/i3c/target.h
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > +/**
> > > > > > > + * struct i3c_target_ctrl_ops - set of function pointers
> > > > > > > +for performing controller operations
> > > > > > > + * @set_config: set I3C controller configuration
> > > > > > > + * @enable: enable I3C controller
> > > > > > > + * @disable: disable I3C controller
> > > > > > > + * @raise_ibi: raise IBI interrupt to master
> > > > > > > + * @alloc_request: allocate a i3c_request, optional,
> > > > > > > +default use kmalloc
> > > > > > > + * @free_request: free a i3c_request, default use kfree
> > > > > > > + * @queue: queue an I3C transfer
> > > > > > > + * @dequeue: dequeue an I3C transfer
> > > > > > > + * @cancel_all_reqs: call all pending requests
> > > > > > > + * @fifo_status: current FIFO status
> > > > > > > + * @fifo_flush: flush hardware FIFO
> > > > > > > + * @hotjoin: raise hotjoin request to master
> > > > > > > + * @set_status_format1: set i3c status format1
> > > > > > > + * @get_status_format1: get i3c status format1
> > > > > > > + * @get_addr: get i3c dynmatic address
> > > > > > > + * @get_features: ops to get the features supported by the
> > > > > > > +I3C target controller
> > > > > > > + * @owner: the module owner containing the ops  */ struct
> > > > > > > +i3c_target_ctrl_ops {
> > > > > > > +	int (*set_config)(struct i3c_target_ctrl *ctrl, struct
> > > > > > > +i3c_target_func
> > > > > > > *func);
> > > > > > > +	int (*enable)(struct i3c_target_ctrl *ctrl);
> > > > > > > +	int (*disable)(struct i3c_target_ctrl *ctrl);
> > > > > > > +	int (*raise_ibi)(struct i3c_target_ctrl *ctrl, void *p, u8
> > > > > > > +size);
> > > > > > > +
> > > > > > > +	struct i3c_request *(*alloc_request)(struct
> > > > > > > +i3c_target_ctrl *ctrl, gfp_t
> > > > > > > gfp_flags);
> > > > > > > +	void (*free_request)(struct i3c_request *req);
> > > > > > > +
> > > > > > > +	int (*queue)(struct i3c_request *req, gfp_t gfp_flags);
> > > > > > > +	int (*dequeue)(struct i3c_request *req);
> > > > > > > +
> > > > > > > +	void (*cancel_all_reqs)(struct i3c_target_ctrl *ctrl, bool
> > > > > > > +tx);
> > > > > > > +
> > > > > > > +	int (*fifo_status)(struct i3c_target_ctrl *ctrl, bool tx);
> > > > > > > +	void (*fifo_flush)(struct i3c_target_ctrl *ctrl, bool tx);
> > > > > > > +	int (*hotjoin)(struct i3c_target_ctrl *ctrl);
> > > > > > > +	int (*set_status_format1)(struct i3c_target_ctrl *ctrl,
> > > > > > > +u16
> > > status);
> > > > > > > +	u16 (*get_status_format1)(struct i3c_target_ctrl *ctrl);
> > > > > > > +	u8  (*get_addr)(struct i3c_target_ctrl *ctrl);
> > > > > > > +	const struct i3c_target_ctrl_features
> > > > > > > +*(*get_features)(struct
> > > > > > > i3c_target_ctrl *ctrl);
> > > > > > > +	struct module *owner;
> > > > > > > +};
> > > > > >
> > > > > > This structure looks very different from the master controller
> > > > > > ops
> > > > > 'i3c_master_controller_ops'.
> > > > > > I think you could probably combine 'set_config, enable' into
> > > > > > 'bus_init',
> > > > > 'disable' to 'bus_cleanup'.
> > > > > > Also using the 'struct i3c_priv_xfer' rather redefining
> > > > > > another 'struct
> > > > > i3c_request' would be much cleaner.
> > > > >
> > > > > Thanks, let me think this. i3c_priv_xter may include read and
> > > > > write, or write and read. I3C is quite fast. Most time software
> > > > > are not quite enough to handle it in time.
> > > > >
> > > > > If data len bigger than FIFO size, it have to use DMA to
> > > > > transfer it because there are not flow controler at target side (=
write
> direction).
> > > > > Read, hardware to use early terminate to tell host read too fast.
> > > > > but for write, 9th bit is parit check bit. Data will be lost if
> > > > > software have not read from FIFO in time. If use external DMA to
> > > > > do that, it needs switch dma channel(generally, DMA rx and tx
> > > > > are two channel). switch channel automatically are quite
> > > > > challenge at current dma
> > > engine framework.
> > > > >
> > > >
> > > > I guess when data is larger than FIFO, the i3c controller (master)
> > > > should 'aware' of this limitation when using such target device.
> > > > So that appropriate handle like make new read command, or do a
> > > > write then another larger read request.
> > >
> > > Between two commands, such as two write command, some data may lost
> > > because first one have not chance to fetch it from FIFO.
> > >
> > > Function driver can add some recovery mathod. But still better to
> > > use modem async method to queue multi transfer and handle by dma
> > > automatically. One transfer each time are just special case for queue=
.
> > >
> > > If DMA support,  queue can work as big cycle buffer, underrun will
> > > never happen unless system wrong, such as disable irq over 1 second.
> > >
> > > Actually, I worry about still i3c_priv_xfer, write followed read case=
.
> > > Most likely, host driver do like
> > >
> > > 	write (cmd index/reg index) then read value or command result.
> > >
> > > It is hard to decode cmd and send back data immedicately.
> > >
> > > if there are not special DMA support,  more realistic usage mode is
> > >
> > > cmd1, cmd2, cmd3,....
> > >
> > > send back
> > > 	resp1, resp2, ....
> > >
> > > instead of comebine cmd1 and resp1 at one transfer.
> > >
> > > Host can do that just because all SCL are controller by host controll=
ers.
> >
> > The DMA queue mechanism should still be invisible to the framework.
> > Target could use info from SETMRL/SETMWL to 'prepare' whether
> > internally DMA is needed.
>=20
> You are right. DMA should be invisiable to the framework, but framework
> need provide API to prepare receiver buffer advance before transfer happe=
n.
> Only function driver know how much data need be prepared advance. For
> host read/target write case, It also need cancel request function incase =
host
> have not fetch data in certain time. Data need be updated. function drive=
r
> can't simple update data buffer, because it may already map to DMA.
> function driver need dequeue and queue request again.
>=20
> framework should abstract common part of difference i3c target controller
> and target function driver to avoid duplicate code.
>=20
> And also need consider linux's irq latency limiation, try to make the fun=
ction
> driver can work on all target controller drivers.
>=20
> I think priv_xfer, W, R, ...  are hard to implement. Maybe limit priv_xfe=
r 's len to
> 1 or 2. But if limited to 1, it becames no big difference with current im=
plement.
>=20

I think if the target unable to handle multiple transaction I think it is s=
afe
to throw NACK. In the case small transaction is needed we can still use the=
=20
same 'struc i3c_priv_xfer'. If it is large transaction and target unable to=
=20
support multiple transaction it should be the target limitation rather than=
=20
limiting every target private transfer here.=20

> >
> > We can also argue that the max read length should always not larger
> > than the FIFO size. Slave data transfer interface should still match
> > what i3c spec expect to be, rather than the hardware limitation here.
> >
>=20
> According to spec:
>  	5.1.9.3.5 Maximum write length in a single command
>=20
> I am not resure "singe command here". I think it should be between "start=
"
> and "repeat start/stop".
>=20
> If my understand is correct,  host still send out W R W R ... as whole I3=
C
> transaction, each one less than FIFO size. but totally size may exceed FI=
FO size.
>=20
>=20
> >
> > >
> > > >
> > > > > Of course it will be possible if hardware implement simpilar I3C
> > > > > HCI command queue. But I still not found any hardware that can do
> that yet.
> > > > >
> > > > > If only limited data size to FIFO size, there are still
> > > > > limiation for xfer.  if write, read, write, read, two write may
> > > > > combined in one FIFO, target driver may not split it which
> > > > > depend on hardware detect repeat start and insert something into =
fifo.
> > > > >
> > > > > It is hard to support all user case by I3C target software in lin=
ux.
> > > >
> > > > Can I know the speed limitation that you having issue while
> > > > running on
> > > silicon?
> > >
> > > I am not sure what "speed limitation" here? Do you means irq latency
> issue.
> > >
> > > when I get "stop", there are new data already come into FIFO.  It is
> > > not for problem for tty case now.
> > >
> > > But if it is well defined frame data, it may be problem.
> > >
> > > I saw some data lost when target are busy without DMA support.
> > > driver can query how many fifo space avaible before send data, but
> > > it reduced bus utilities rate.
> > >
> > > >
> > > > >
> > > > > write follow by read, generally used from get hardware register
> > > > > value from target side, which almost impossible by software, it
> > > > > is not quick enough to parse (write value) then send back data.
> > > > >
> > > > > >
> > > > > > In the master i3c side they don't abbreviate
> > > > > > i3c_master_controller to i3c_master_ctrl. I think we should do =
the
> same here to standardize it.
> > > > > > Thanks
> > > > >
> > > > > The problem is in I3C spec: "master" already depericated
> > > > >
> > > > > from i3c spec 1.1.1
> > > > >
> > > > > "Controller: An I3C Device that is capable of controlling the I3C=
 Bus."
> > > > >
> > > > > master/slave =3D> controller/target.
> > > > >
> > > > > It will become more confused if i3c_target_controller. "controlle=
r"
> > > > > are ambiguity.
> > > > >
> > > > > If "master" =3D> "host" would be better situation, but not happen=
.
> > > > > A point, I use "ctrl"  here to avoid I3C spec defined "controller=
" term.
> > > > >
> > > > > Anyway, I hope more people that involve target support discussion=
.
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > > Joshua
> > > > > >
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > linux-i3c mailing list
> > > > > > > linux-i3c@lists.infradead.org
> > > > > > > http://lists.infradead.org/mailman/listinfo/linux-i3c
