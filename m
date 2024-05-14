Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2105.outbound.protection.partner.outlook.cn [139.219.146.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8106AD53;
	Tue, 14 May 2024 03:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715656064; cv=fail; b=CmmE3iZ+usvRQz6eNo9Mo/74bz88FDgQd+iqVygNO8NI75UkbbBbFNHb4i+GG/W+rOTAjpcTNQOQLc8NAU4QfkezXvCMSOsPzXOxwkZKKJl3Y2kKvDMp/jgEziGCk2LctRYuxHJ4sp27QhY+fdecnfyxa00GvsM53ri6pQh4Hdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715656064; c=relaxed/simple;
	bh=YIFtvHRj/GSKaU7/S0F22EvOvHVMVEUBqarLSbhARMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cGW3lJHvdm0C8ObW9j5ELLGdjP6XY/c7nyZu37TU9Y9cHTDQTzS9+msPJSEAJRC8FIapKAXkUfoTciRwM3wWcpdaq06yejDHOCdl9UeSFksC9glHEIG7ic9/A/+KbOhy1OVUr8FK9EAp9DwW5KSpo+DLtFP1D7J6cOr4M0hRK6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GD4J5748VSaody4YaqEr+YV+dmlAleXs4XCHJcMqLhwd532xfLhM5vhGSEDRSyp1mVBYXTcH1og3ffia6WnuaT5LeObOEAq9DMYBWrU0l327K6+5cbT2TdozIVSFtLQudHqbEH36+W59i9skcxM0lUjNtcq+LwHT7WkNhgETjcTq2U9Ovw8oov/maBZiQkPJq4SZpfEi5/LjgPUf4jmvs0hMd8Mpggg6f3hbYDHvmjez2eDlhsH9ycj/kJWMI3Wvp6a+JxYVioMcM/5RXle03flUhHCDLr0Csy4T+sbYMOyWFEBGVxggm1pxM5Pi6x3OrbxORxoWN7ZXGScyCjJ6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO0z2UMYTRg06rzXauU8FDG8H4bePTnSjdVR0nxLcOg=;
 b=IZBEnfafA0TMIoT5pf0ygXmOpDVQJyYbsBMJiESsZ88B2hPkrA2Qz/SYOOt+VQSWv/OCdl7JZhsmI2SRMBXk+MW1AnW6Bnl0lnNotizHJBDvpNq7yVTA7r4bfScbI2v1oqJQ8rn8mqNqs6LVrvmUsHgAlp0scsD1q9PSH4zum3yO2VApw7/XQ4CMFg06hUNZku3lHdx+cNWUOtS3diY2RkByKN1ETOL9es7xLUueYrCMrKQa/GtCqDlLm4pYBbn2WIGHg3CPohmsOl40rh5QCQnajUi9HW0O6vAtxO/JDW6WGWnd6B8TBmeKQx/jaPOytPOLsT/w4S6Eu7+fdd1EMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0539.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 14 May
 2024 03:07:25 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Tue, 14 May 2024
 03:07:25 +0000
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
Thread-Index: AQHaoL9J0lwk/jg/a0+LeeDupwAoCLGUgoawgADYHgCAAAMG8IAALSSAgACFTQA=
Date: Tue, 14 May 2024 03:07:25 +0000
Message-ID:
 <SH0PR01MB084183D40B4ECC0C4B3A9BF0F9E32@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240507204311.2898714-1-Frank.Li@nxp.com>
 <20240507204311.2898714-2-Frank.Li@nxp.com>
 <SH0PR01MB084187FBA1E4EE786A8996C9F9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZkI4GO4czdgs5/Xy@lizhi-Precision-Tower-5810>
 <SH0PR01MB084189445E4928BC5047495AF9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZkJgf/oRMMBswih1@lizhi-Precision-Tower-5810>
In-Reply-To: <ZkJgf/oRMMBswih1@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0539:EE_
x-ms-office365-filtering-correlation-id: ead3bd44-06e6-41d7-f33d-08dc73c2fb3e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hW864F0ZZWesMH8uPNjtOYZO0FSr4zbNTGbludneNwcUdEESqAWIhYC75ZOLu3tJ+ltk3UNDPXLEQU810rDD6MdI1YQmlX9COg8hBfazhvWOQPbYI3j6+GDBUbE5h4drHxRf0jkqAPHxcAX9HMZBPMGOsZzpt8Woblaet0qEOZ+LGz0MjbyIc0yUK3wTK5lls2IqhHR1yep+jAfwhJF4UiSQT5Ym4IeLo0y6TwD5n1MdF49yAwls5yTRi8JutAfVdD/n179wkNxkpuO0aNWgyqcYqVqCyB0PV+wSYC2anp53jggBWJDi6Pms09tZiSaUpeemNhdTY0ICBNgJ/Au0VchB3YW8nRFy7rU1brKhMYWfBAR7ZUbNicP1pBuYpcVhR2OPeVXjgfjDNpP9dhZJbXX8VFyFPGkJeZxeXpU35RigxpjRFEiF7y525Wf8gVzoy+oYzgFsbvD9l8cbnZTQwt75zfaiUTdeB/4dyiifJfSK7EAeb8c82YXoNFfj0uklB4SApQNgKjBjnqDNV8cCiwBm0wmt+xWeR+Eu6vGCy6btS+yC1ILg06Hg2VRevk0gDUN3Mu2sWS9YDxsI7Mr3224Gbd3BhffCe8XNHlZiC6oF/TtWghISTKCkL4wX38gd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tJo1rxvBvDqGj2j7aXGTJ42x3b1iaKCXHUKIhCnKLLbUbacCnKgXxwDOCgCe?=
 =?us-ascii?Q?6p9vsfLD+R6/6kTnLyIQJNl7U3DD/l0p3p3bm2zG9P71vnCBqMzYYN5QbGbG?=
 =?us-ascii?Q?BzLMQCs1L209jHrpbpxYVA1mVHvj+9X4am5kbcwUlweHmry/FbfuObfs80KV?=
 =?us-ascii?Q?rLzwOxey4N5K+KShAtMw7Bb6JkMWl7gKbPvFjg0GpsWp2m7/ZuafQ0baU3er?=
 =?us-ascii?Q?Awjp5Zx1lDJ1kiP1KNymZo+AlbZh9wVFUOMiBo6Y7bVdwr0efWk4l08vn2ss?=
 =?us-ascii?Q?Hy0IJQrMyUERc4p85cHH+Ye0Wf/mS7j1RBnpVYVn2wSYPnMp9amRrhW8jhPX?=
 =?us-ascii?Q?ZNRNMpjJxGkEwLDTRK0l0u/qzVJZnGZV7nJLH0BfAu47eaet4bp05226Hqpl?=
 =?us-ascii?Q?gagiSHNRTV0+YvXBip2A1y+ONFiA7/VslOFgPD85ksCKwU3nmk23YWRL1LJf?=
 =?us-ascii?Q?kJXq23lmU1mFtp89a4IiW4TzRC0uDyyGsQOx25PV2a9VdDwWPpFs8VdRZgC0?=
 =?us-ascii?Q?Aakg94bFEqLs8ol6GcyTagQTCBYxeUR52e/F+s/pu6U87tOWLRgNmwWbfc6b?=
 =?us-ascii?Q?G0D7GXc9biLo+vYkOcdKxo8yGeapi3BSABh23SFW0Ox53ekCP/va9BIYkrl6?=
 =?us-ascii?Q?eQD3A0aD0GryKV8NnMuRF2jZTGTvvjN3vR9MyLVs+dFHciraBLXV6PfT7ddZ?=
 =?us-ascii?Q?cXZ3n2OOE+SeAztFCHJX1T0UjyVTq9bQOmt/MbXc8t85I1TY+fk+BDl2HHZ6?=
 =?us-ascii?Q?hvSlBylSMfqrvB9oOy5EfX8xYUB4y80iIoWb5KLeo3ObXsM0sddRvl3K6FMx?=
 =?us-ascii?Q?TlRc9/lfY3dPQlpW8kls9KNqmkm70DnjvW0rZqeTZGxkzLIp8XvDavbvIQMo?=
 =?us-ascii?Q?NNBlJtfnFD5Ic+qnPfEStpN9MSS3jpNIJ+se99+hbgKl34AVs3SmAiVrp+eW?=
 =?us-ascii?Q?l7+rg6O/AC+spXC12pSe1lIARx5itYLjldftcqyp+l+oDxVqIFS0raj1bIXc?=
 =?us-ascii?Q?fpUK4wp7nNCs7RgwsNjpU/0oeyoLt7qqN2C9i3tmSxsg7Pc00HNh/lv2V5u3?=
 =?us-ascii?Q?YWF7Q1YBq88JkDf70d1wxdbSOWvwm+5wTjSy6z0YcpMz7YqE0JRe/fQiscsu?=
 =?us-ascii?Q?NjG8FhSgxCu0o4o9CfGc558vPPFb7vyTSawU6Jr3KDYreIFN4JNiV7nCTn4U?=
 =?us-ascii?Q?lFARzX9g2ziQfxGH7M2DGoASdclJyl2rUAXiQ0cfq2j6ReND++9SftSFgaj8?=
 =?us-ascii?Q?Ip/6wqHTbVuw/mRQ/GVyJhHyin0LOW7ltVeXiN8YM7h02uOo2IIofUEKh/wb?=
 =?us-ascii?Q?NOE/pR+n2x1pUtwc3Q+D9JtOgNFDDoiIeR6Yp+ZJL8jr8wTyOY+WQv78bg6T?=
 =?us-ascii?Q?PF8g7KJldo2Dz6XgX48YOG7wEcCeUBWBesz2pwNHRlwG15UedPutTpZWKWTf?=
 =?us-ascii?Q?7lL51HxUkejP8a7ct4YhObl6KKZXOPnSBIyGCJcmE3ksF3A4oHWNFDaeIGY2?=
 =?us-ascii?Q?Q6LKnq2ypGLkncDRBK1RdKQfOnoV6ja12DjV3Szv4BkKfMHMkac6R1BlJZbN?=
 =?us-ascii?Q?tuDQ2wg0XHemoa08MjkZX5KX2haeQuwcFfuOywO3L1Fb91nPou/BE2UnWBQS?=
 =?us-ascii?Q?8w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ead3bd44-06e6-41d7-f33d-08dc73c2fb3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 03:07:25.5256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+02ode8CZc4pG9I8yda4+eDK+6dENyd9ZU0SSavLeUOgaXLxDZK3aQQ5reYhMTeZ4Hn7m/EjRVuEAo9sz974tJR5NEk3MDJP4AG/MeR6dY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0539

Frank Li wrote:
>=20
> On Mon, May 13, 2024 at 04:18:00PM +0000, Joshua Yeong wrote:
> > Frank Li wrote:
> > > On Mon, May 13, 2024 at 03:16:05AM +0000, Joshua Yeong wrote:
> > > > Joshua Yeong wrote:
> > > > >
> > > > > Introduce a new target core layer in order to support target
> > > > > functions in linux kernel. This comprises the controller library
> > > > > and function
> > > library.
> > > > > Controller library implements functions specific to an target
> > > > > controller and function library implements functions specific to
> > > > > an target
> > > function.
> > > > >
> > > > > Introduce a new configfs entry to configure the target function
> > > > > configuring and bind the target function with target controller.
> > > > >
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >
> > > > > Notes:
> > > > >     Change from v8 to v9
> > > > >     -none
> > > > >
> > > > >     Change from v7 to v8
> > > > >     Added missed head files
> > > > >
> > > > >     Change from v5 to v6
> > > > >     - fixed build error when have not CONFIG_TARGET_CONFIGFS
> > > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > > >     | Closes:
> > > > > https://lore.kernel.org/oe-kbuild-all/202402030437.GdGCrKeK-
> > > > > lkp@intel.com/
> > > > >
> > > > >     Chagne from v4 to v5
> > > > >     - add include <linux/slab.h> to fix build error
> > > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > > >     | Closes:
> > > > > https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > > > > lkp@intel.com/
> > > > >
> > > > >     Chagne from v4 to v8
> > > > >     - add include <linux/slab.h> to fix build error
> > > > >     | Reported-by: kernel test robot <lkp@intel.com>
> > > > >     | Closes:
> > > > > https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > > > > lkp@intel.com/
> > > > >
> > > > >  drivers/i3c/Kconfig        |  28 +-
> > > > >  drivers/i3c/Makefile       |   2 +
> > > > >  drivers/i3c/i3c-cfs.c      | 389 ++++++++++++++++++++++++++
> > > > >  drivers/i3c/target.c       | 453 ++++++++++++++++++++++++++++++
> > > > >  include/linux/i3c/target.h | 548
> > > > > +++++++++++++++++++++++++++++++++++++
> > > > >
> > > > > ...
> > > > >
> > > > > diff --git a/include/linux/i3c/target.h
> > > > > b/include/linux/i3c/target.h new file mode 100644 index
> > > > > 0000000000000..b0bf06685834c
> > > > > --- /dev/null
> > > > > +++ b/include/linux/i3c/target.h
> > > > >
> > > > > ...
> > > > >
> > > > > +/**
> > > > > + * struct i3c_target_ctrl_ops - set of function pointers for
> > > > > +performing controller operations
> > > > > + * @set_config: set I3C controller configuration
> > > > > + * @enable: enable I3C controller
> > > > > + * @disable: disable I3C controller
> > > > > + * @raise_ibi: raise IBI interrupt to master
> > > > > + * @alloc_request: allocate a i3c_request, optional, default
> > > > > +use kmalloc
> > > > > + * @free_request: free a i3c_request, default use kfree
> > > > > + * @queue: queue an I3C transfer
> > > > > + * @dequeue: dequeue an I3C transfer
> > > > > + * @cancel_all_reqs: call all pending requests
> > > > > + * @fifo_status: current FIFO status
> > > > > + * @fifo_flush: flush hardware FIFO
> > > > > + * @hotjoin: raise hotjoin request to master
> > > > > + * @set_status_format1: set i3c status format1
> > > > > + * @get_status_format1: get i3c status format1
> > > > > + * @get_addr: get i3c dynmatic address
> > > > > + * @get_features: ops to get the features supported by the I3C
> > > > > +target controller
> > > > > + * @owner: the module owner containing the ops  */ struct
> > > > > +i3c_target_ctrl_ops {
> > > > > +	int (*set_config)(struct i3c_target_ctrl *ctrl, struct
> > > > > +i3c_target_func
> > > > > *func);
> > > > > +	int (*enable)(struct i3c_target_ctrl *ctrl);
> > > > > +	int (*disable)(struct i3c_target_ctrl *ctrl);
> > > > > +	int (*raise_ibi)(struct i3c_target_ctrl *ctrl, void *p, u8
> > > > > +size);
> > > > > +
> > > > > +	struct i3c_request *(*alloc_request)(struct i3c_target_ctrl
> > > > > +*ctrl, gfp_t
> > > > > gfp_flags);
> > > > > +	void (*free_request)(struct i3c_request *req);
> > > > > +
> > > > > +	int (*queue)(struct i3c_request *req, gfp_t gfp_flags);
> > > > > +	int (*dequeue)(struct i3c_request *req);
> > > > > +
> > > > > +	void (*cancel_all_reqs)(struct i3c_target_ctrl *ctrl, bool
> > > > > +tx);
> > > > > +
> > > > > +	int (*fifo_status)(struct i3c_target_ctrl *ctrl, bool tx);
> > > > > +	void (*fifo_flush)(struct i3c_target_ctrl *ctrl, bool tx);
> > > > > +	int (*hotjoin)(struct i3c_target_ctrl *ctrl);
> > > > > +	int (*set_status_format1)(struct i3c_target_ctrl *ctrl, u16
> status);
> > > > > +	u16 (*get_status_format1)(struct i3c_target_ctrl *ctrl);
> > > > > +	u8  (*get_addr)(struct i3c_target_ctrl *ctrl);
> > > > > +	const struct i3c_target_ctrl_features *(*get_features)(struct
> > > > > i3c_target_ctrl *ctrl);
> > > > > +	struct module *owner;
> > > > > +};
> > > >
> > > > This structure looks very different from the master controller ops
> > > 'i3c_master_controller_ops'.
> > > > I think you could probably combine 'set_config, enable' into
> > > > 'bus_init',
> > > 'disable' to 'bus_cleanup'.
> > > > Also using the 'struct i3c_priv_xfer' rather redefining another
> > > > 'struct
> > > i3c_request' would be much cleaner.
> > >
> > > Thanks, let me think this. i3c_priv_xter may include read and write,
> > > or write and read. I3C is quite fast. Most time software are not
> > > quite enough to handle it in time.
> > >
> > > If data len bigger than FIFO size, it have to use DMA to transfer it
> > > because there are not flow controler at target side (write direction)=
.
> > > Read, hardware to use early terminate to tell host read too fast.
> > > but for write, 9th bit is parit check bit. Data will be lost if
> > > software have not read from FIFO in time. If use external DMA to do
> > > that, it needs switch dma channel(generally, DMA rx and tx are two
> > > channel). switch channel automatically are quite challenge at current=
 dma
> engine framework.
> > >
> >
> > I guess when data is larger than FIFO, the i3c controller (master)
> > should 'aware' of this limitation when using such target device. So
> > that appropriate handle like make new read command, or do a write then
> > another larger read request.
>=20
> Between two commands, such as two write command, some data may lost
> because first one have not chance to fetch it from FIFO.
>=20
> Function driver can add some recovery mathod. But still better to use mod=
em
> async method to queue multi transfer and handle by dma automatically. One
> transfer each time are just special case for queue.
>=20
> If DMA support,  queue can work as big cycle buffer, underrun will never
> happen unless system wrong, such as disable irq over 1 second.
>=20
> Actually, I worry about still i3c_priv_xfer, write followed read case.
> Most likely, host driver do like
>=20
> 	write (cmd index/reg index) then read value or command result.
>=20
> It is hard to decode cmd and send back data immedicately.
>=20
> if there are not special DMA support,  more realistic usage mode is
>=20
> cmd1, cmd2, cmd3,....
>=20
> send back
> 	resp1, resp2, ....
>=20
> instead of comebine cmd1 and resp1 at one transfer.
>=20
> Host can do that just because all SCL are controller by host controllers.

The DMA queue mechanism should still be invisible to the framework. Target
could use info from SETMRL/SETMWL to 'prepare' whether internally DMA=20
is needed.

We can also argue that the max read length should always not larger than=20
the FIFO size. Slave data transfer interface should still match what i3c
spec expect to be, rather than the hardware limitation here.


>=20
> >
> > > Of course it will be possible if hardware implement simpilar I3C HCI
> > > command queue. But I still not found any hardware that can do that ye=
t.
> > >
> > > If only limited data size to FIFO size, there are still limiation
> > > for xfer.  if write, read, write, read, two write may combined in
> > > one FIFO, target driver may not split it which depend on hardware
> > > detect repeat start and insert something into fifo.
> > >
> > > It is hard to support all user case by I3C target software in linux.
> >
> > Can I know the speed limitation that you having issue while running on
> silicon?
>=20
> I am not sure what "speed limitation" here? Do you means irq latency issu=
e.
>=20
> when I get "stop", there are new data already come into FIFO.  It is not =
for
> problem for tty case now.
>=20
> But if it is well defined frame data, it may be problem.
>=20
> I saw some data lost when target are busy without DMA support. driver can
> query how many fifo space avaible before send data, but it reduced bus
> utilities rate.
>=20
> >
> > >
> > > write follow by read, generally used from get hardware register
> > > value from target side, which almost impossible by software, it is
> > > not quick enough to parse (write value) then send back data.
> > >
> > > >
> > > > In the master i3c side they don't abbreviate i3c_master_controller
> > > > to i3c_master_ctrl. I think we should do the same here to standardi=
ze it.
> > > > Thanks
> > >
> > > The problem is in I3C spec: "master" already depericated
> > >
> > > from i3c spec 1.1.1
> > >
> > > "Controller: An I3C Device that is capable of controlling the I3C Bus=
."
> > >
> > > master/slave =3D> controller/target.
> > >
> > > It will become more confused if i3c_target_controller. "controller"
> > > are ambiguity.
> > >
> > > If "master" =3D> "host" would be better situation, but not happen. A
> > > point, I use "ctrl"  here to avoid I3C spec defined "controller" term=
.
> > >
> > > Anyway, I hope more people that involve target support discussion.
> > >
> > > >
> > > > Regards,
> > > > Joshua
> > > >
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > >
> > > > > --
> > > > > linux-i3c mailing list
> > > > > linux-i3c@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-i3c
