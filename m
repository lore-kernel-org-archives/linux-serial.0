Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2099.outbound.protection.partner.outlook.cn [139.219.146.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12DB14F114;
	Mon, 13 May 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617098; cv=fail; b=evp8wyLv/v6BR78lp+S7DoUj6ZHpIRl/LlCShPQiaVudES26zom8IYUnHsZVM3LGBALU4FHryqaaCSnDqu+LWuS8PmvLUpdLvd5Q+C8zglC0s2KOCltArU70lDfphx5LcerQ82YSBswR9whCshqBXzUbuM7UYseNTtqmb0b9dLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617098; c=relaxed/simple;
	bh=zWPtiIfPQ+oZzqOhYANssgV8l+KpI4ZtaXtnojyIqh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AgNU/KiYUY/RekJd4SEGGjWFB5O7qcXOu/Vt1/OcwE17FEOJO6pzlQ3G1sCnfPEhFzlfWPJWwJkb1g3xgnpIUxCWizQ/6u/JA055WvR0E8P3U6xX+1QcF6wX1+mwFh68BR5ZpBUYofuRdK2DbsSnttBf0LJE4eLO95VzQq9qYWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw9yjfr34twx1nBLfuQf2iyJdyE2ivoffISib0qN/26BriMVH5zlfHAukgxbaL8gtdLoAQvfpUvl8EbPPGquPy9Ct2UF0j3B03GqfJonyC9kCN5Gh7IoJj3Rd5761sscfhAiv/SNGqk+jL6Jf+KGLQtOlBULR0qxee7cDxawOoiOvnh+74z3ESfW+cOviH7jyGxpir1kPH9SKDBF6TfqxfPrVrkLAc6qEP4bIjfLmYxgS3Z+ux5ZIz5UNJrB7BhbEOOm9lqEonM74mr49yloRGAq2u/FptiQzy3TZ1YhhfStqLtkbstvudFvUwdCxYq4pBLsK2to6HRjvMixtvUkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fifDCzdyeHbmnLFxJclfJMq8nW+rEwhlPH+L6XSZfyo=;
 b=cbusA8hZOCp7aUBIMIlpIyuPTIbx0Higdw78hcGaQBV7a4Qexk3gLg1KVB6LBt/zIkriGvz0pnh0jLTAlNK9A70FUf8gzpHTKHSK/jwI7BrPYJv6joCtsAMQgcgNCR858BBvSSeHQAXedjYON8tpNiILZLCaK3FtpYLaHAbYZ5mT1uYR0Ml8UApiEBSPk2CPphQK4JEW07kEbwYibP71TtAzfWMOqxb6HptbkLG33py1SOvDG0CtSNcqV4q8IvmRWqRZXqLx7KIFn65rLubXfvTGd+At6jzxHn2k6vg13fUfwVdw6t7K/vs7E8VJ/MEAB8QQhhVW66n85mFxD7DmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0761.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 13 May
 2024 16:18:01 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Mon, 13 May 2024
 16:18:01 +0000
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
Thread-Index: AQHaoL9J0lwk/jg/a0+LeeDupwAoCLGUgoawgADYHgCAAAMG8A==
Date: Mon, 13 May 2024 16:18:00 +0000
Message-ID:
 <SH0PR01MB084189445E4928BC5047495AF9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240507204311.2898714-1-Frank.Li@nxp.com>
 <20240507204311.2898714-2-Frank.Li@nxp.com>
 <SH0PR01MB084187FBA1E4EE786A8996C9F9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZkI4GO4czdgs5/Xy@lizhi-Precision-Tower-5810>
In-Reply-To: <ZkI4GO4czdgs5/Xy@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0761:EE_
x-ms-office365-filtering-correlation-id: 880da501-35d8-49e3-f27f-08dc73684287
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 C2tv5uDiRotP8h8iTJNvfDqnfafDtBePddrwc1CEnELbo829BocO7SVtFhlhazUhX/92I6rCiKxy4bR7OYXeU6sXHVTn+VEQ2LfuVXLFf9MPYa9NiTFai09OgdTAtEV095DB15yu6MeL6BAPnuZshB4Jf0eYdmYOJQS6Wbsy0HYUnIAc+U4Agov7ZGgxOHPRID+h0s2U/eN54EZ/mqszZkPDntkF7Cd2wPdcxd9F7Rr3vejujkNY6dBpaUdvgLWwLuE9PwlNGMBazvYAj/IW4MLjj0X7ZDZdz55bDRQyhZ6YctJ1e43pVbODvkRZBJgDqj7HGXP8ol6d+jmP39MCoShK50NEsTeJtIu9cxjbn0875oxRcN2emFpNjcOGfCFLSaY54If2juRaOfzWI/A9H7XUOihkO6pgzn55sxWqnKrMCIFMr334o7VdeCogSOgCciMLXXJWgh++iqnSitQack13r79hwYq7A2VdQ5ZXyeb0zhz84cb5DvyCYf+jT7P5E3fiFQ1eNgWn6uVU4Jopns3kLJloFgIibuPqK2uIT8EZBL1qbIbBF8gDjab67wWtfULLXxSPNY2ZtoQ8sJmFEVT043t7uNc3LryxDZp+53izpFBHvj793u5z1yhg4wP/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(41320700004)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kWvIGGFqzELoh6lwxnAJWJafhzBhwsbXPKHsIJ+xNdfZ48O2etr2GCvbMrgq?=
 =?us-ascii?Q?9mqUx2mPqrDuTZOYy0G3RFqPUW72bSLFV721fCLsJDAIbU/krlAjGOzdnORF?=
 =?us-ascii?Q?693Cq0UqSbXfFxUufUyYP98gEmuLELthrlV4hATyW+6gkPP89uBwXVK8kOib?=
 =?us-ascii?Q?1XJeFw/m8bQABbz8BAAxHWx2vXywgwqVKMzNIq+i9sp/8ZofLbkkWISOiZYs?=
 =?us-ascii?Q?GRU1gNXsPF6gPwr2kW0k172tanpuPx6aCyoEeW2n2qiXD8rYlvkVIuahLaWp?=
 =?us-ascii?Q?qw83YcdOkgsTuOpA82ioXZjYC4D5qOFes0Sr8f1wWXtNZbIvR4pN83zzXMrq?=
 =?us-ascii?Q?j6KBr0mPk8haygz8PUKw/CmXLRlRm6cEvbrE0Oq720HsTcigodfQbI951GuM?=
 =?us-ascii?Q?jS6LPgEDkgii1aiG2yg+QLQ3Bym6FMsVLfVFotu/kSPDVtSVhnbP1ZvQ4xgX?=
 =?us-ascii?Q?4SLqX41Ru9tbNRhtMXsFuUkl+g3QgpdsvQnuKUpxoFpAzjAB6NrEsltImByQ?=
 =?us-ascii?Q?fHWMG81hHKjeSIwCziwbfTaYVl5F8ap0HpaJIbDL2vBhxKGEzQXEmcWixfP8?=
 =?us-ascii?Q?18eKCQMcQqeH0AY7QzYRtduwtCS+teTZt7w7e6t8KspL9wAZxD30I24fFbwy?=
 =?us-ascii?Q?lAW8agIMcF4mwJuI85hukogmBefhcZkniMh9FCwTnTn57U1OL2o42AB77HiL?=
 =?us-ascii?Q?h9kdUpprhCHmcGSVdpqzRMoXVmeBHgEkSB9pjk+1c7XpYP6Ss/C6SssoLu1l?=
 =?us-ascii?Q?0Ghb96gav89I4ZX/Bdgb/LzSkqgRcqveDHAEtSa0OltlHsi9EyytCdB69FFI?=
 =?us-ascii?Q?gn0U6YAETwG3rYUeOqy1ErAxh2Zt8HD5WG+w8xzOUo/vu5dCZR7gKonLleFU?=
 =?us-ascii?Q?CpOSGoKRvVGjhC/UcmDLhJVbuKDfr6YHObodEpuGKWg+pTGuiUB2Izb/GtkT?=
 =?us-ascii?Q?JRUwT19lP72RlJAcQzRifWMordZOk7eMD2tl0B0L1FuLzGcn+lVOT17DJrAU?=
 =?us-ascii?Q?RL5qhcfiEu8mBt8xikxWxhw3vSzx9aF7Imm+0qWt247LkKnl+p4qQuOgDRnE?=
 =?us-ascii?Q?hxbNfrdQDydaF6XB55Qw42uRmkSLd9xXCC0nhnZHjP+O/JwTtLLzj5HM2fFo?=
 =?us-ascii?Q?76SRwQZBBkNbuBHLG4HuNvxyuInUqtSjbJg6MuIwHZFHIa1/11GcNkPtqSdN?=
 =?us-ascii?Q?EEqJrFHvV9XCyFLAeueaCYWK5UPq/JNLDf1jcZ5NQpqd9cUj2Q0GI2vwj/Jv?=
 =?us-ascii?Q?out3yFV6fSIYcRdPU1PZmVjtXo6X6WXHqMsiqtACKSBUBpyoy8VzlA62e7YW?=
 =?us-ascii?Q?z/ya+yb4P8Z772G05xpGFoyls9LQ5TneQTlJ48FvL9YQIUomr5Goj/dqmeV+?=
 =?us-ascii?Q?z1Q2yx+ezJGDKgvaDGAlb33IjNO945CPP/hTjpfbMM5eLpNsrhjQUWY/PDTg?=
 =?us-ascii?Q?v6HLg3sryMNL3+1HjxcaVHda82HRoXBVN4+xpD7Y98JYpX9dl7UqcA/CigVS?=
 =?us-ascii?Q?WqFxqB9fjdMEQvyYzHE7mclfOQON/Ro4MmGADawzNafh8hjf45BD4Ekw/+id?=
 =?us-ascii?Q?n/zaYBUZIL8fx1XA3KOphzqn1/IaW8GD2RWlLXVDe227eH3qVilMmPUzUz90?=
 =?us-ascii?Q?Xw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 880da501-35d8-49e3-f27f-08dc73684287
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 16:18:00.9167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyHe4wgoXIEgNDP0MabXaBaSQsFcUbVekgxm6TjVdKwHCQvn2l1gyZ/g3UuQQQSejdZ4JSyph8WoscDuwLVQDA7f1u35u4N1XHTGLffzdUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0761

Frank Li wrote:
> On Mon, May 13, 2024 at 03:16:05AM +0000, Joshua Yeong wrote:
> > Joshua Yeong wrote:
> > >
> > > Introduce a new target core layer in order to support target
> > > functions in linux kernel. This comprises the controller library and =
function
> library.
> > > Controller library implements functions specific to an target
> > > controller and function library implements functions specific to an t=
arget
> function.
> > >
> > > Introduce a new configfs entry to configure the target function
> > > configuring and bind the target function with target controller.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >
> > > Notes:
> > >     Change from v8 to v9
> > >     -none
> > >
> > >     Change from v7 to v8
> > >     Added missed head files
> > >
> > >     Change from v5 to v6
> > >     - fixed build error when have not CONFIG_TARGET_CONFIGFS
> > >     | Reported-by: kernel test robot <lkp@intel.com>
> > >     | Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202402030437.GdGCrKeK-
> > > lkp@intel.com/
> > >
> > >     Chagne from v4 to v5
> > >     - add include <linux/slab.h> to fix build error
> > >     | Reported-by: kernel test robot <lkp@intel.com>
> > >     | Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > > lkp@intel.com/
> > >
> > >     Chagne from v4 to v8
> > >     - add include <linux/slab.h> to fix build error
> > >     | Reported-by: kernel test robot <lkp@intel.com>
> > >     | Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-
> > > lkp@intel.com/
> > >
> > >  drivers/i3c/Kconfig        |  28 +-
> > >  drivers/i3c/Makefile       |   2 +
> > >  drivers/i3c/i3c-cfs.c      | 389 ++++++++++++++++++++++++++
> > >  drivers/i3c/target.c       | 453 ++++++++++++++++++++++++++++++
> > >  include/linux/i3c/target.h | 548
> > > +++++++++++++++++++++++++++++++++++++
> > >
> > > ...
> > >
> > > diff --git a/include/linux/i3c/target.h b/include/linux/i3c/target.h
> > > new file mode 100644 index 0000000000000..b0bf06685834c
> > > --- /dev/null
> > > +++ b/include/linux/i3c/target.h
> > >
> > > ...
> > >
> > > +/**
> > > + * struct i3c_target_ctrl_ops - set of function pointers for
> > > +performing controller operations
> > > + * @set_config: set I3C controller configuration
> > > + * @enable: enable I3C controller
> > > + * @disable: disable I3C controller
> > > + * @raise_ibi: raise IBI interrupt to master
> > > + * @alloc_request: allocate a i3c_request, optional, default use
> > > +kmalloc
> > > + * @free_request: free a i3c_request, default use kfree
> > > + * @queue: queue an I3C transfer
> > > + * @dequeue: dequeue an I3C transfer
> > > + * @cancel_all_reqs: call all pending requests
> > > + * @fifo_status: current FIFO status
> > > + * @fifo_flush: flush hardware FIFO
> > > + * @hotjoin: raise hotjoin request to master
> > > + * @set_status_format1: set i3c status format1
> > > + * @get_status_format1: get i3c status format1
> > > + * @get_addr: get i3c dynmatic address
> > > + * @get_features: ops to get the features supported by the I3C
> > > +target controller
> > > + * @owner: the module owner containing the ops  */ struct
> > > +i3c_target_ctrl_ops {
> > > +	int (*set_config)(struct i3c_target_ctrl *ctrl, struct
> > > +i3c_target_func
> > > *func);
> > > +	int (*enable)(struct i3c_target_ctrl *ctrl);
> > > +	int (*disable)(struct i3c_target_ctrl *ctrl);
> > > +	int (*raise_ibi)(struct i3c_target_ctrl *ctrl, void *p, u8 size);
> > > +
> > > +	struct i3c_request *(*alloc_request)(struct i3c_target_ctrl *ctrl,
> > > +gfp_t
> > > gfp_flags);
> > > +	void (*free_request)(struct i3c_request *req);
> > > +
> > > +	int (*queue)(struct i3c_request *req, gfp_t gfp_flags);
> > > +	int (*dequeue)(struct i3c_request *req);
> > > +
> > > +	void (*cancel_all_reqs)(struct i3c_target_ctrl *ctrl, bool tx);
> > > +
> > > +	int (*fifo_status)(struct i3c_target_ctrl *ctrl, bool tx);
> > > +	void (*fifo_flush)(struct i3c_target_ctrl *ctrl, bool tx);
> > > +	int (*hotjoin)(struct i3c_target_ctrl *ctrl);
> > > +	int (*set_status_format1)(struct i3c_target_ctrl *ctrl, u16 status)=
;
> > > +	u16 (*get_status_format1)(struct i3c_target_ctrl *ctrl);
> > > +	u8  (*get_addr)(struct i3c_target_ctrl *ctrl);
> > > +	const struct i3c_target_ctrl_features *(*get_features)(struct
> > > i3c_target_ctrl *ctrl);
> > > +	struct module *owner;
> > > +};
> >
> > This structure looks very different from the master controller ops
> 'i3c_master_controller_ops'.
> > I think you could probably combine 'set_config, enable' into 'bus_init'=
,
> 'disable' to 'bus_cleanup'.
> > Also using the 'struct i3c_priv_xfer' rather redefining another 'struct
> i3c_request' would be much cleaner.
>=20
> Thanks, let me think this. i3c_priv_xter may include read and write, or w=
rite
> and read. I3C is quite fast. Most time software are not quite enough to h=
andle
> it in time.
>=20
> If data len bigger than FIFO size, it have to use DMA to transfer it beca=
use
> there are not flow controler at target side (write direction).
> Read, hardware to use early terminate to tell host read too fast. but for=
 write,
> 9th bit is parit check bit. Data will be lost if software have not read f=
rom FIFO
> in time. If use external DMA to do that, it needs switch dma channel(gene=
rally,
> DMA rx and tx are two channel). switch channel automatically are quite
> challenge at current dma engine framework.
>=20

I guess when data is larger than FIFO, the i3c controller (master) should=20
'aware' of this limitation when using such target device. So that appropria=
te
handle like make new read command, or do a write then another larger read
request.=20

> Of course it will be possible if hardware implement simpilar I3C HCI comm=
and
> queue. But I still not found any hardware that can do that yet.
>=20
> If only limited data size to FIFO size, there are still limiation for xfe=
r.  if write,
> read, write, read, two write may combined in one FIFO, target driver may =
not
> split it which depend on hardware detect repeat start and insert somethin=
g
> into fifo.
>=20
> It is hard to support all user case by I3C target software in linux.

Can I know the speed limitation that you having issue while running on sili=
con?=20

>=20
> write follow by read, generally used from get hardware register value fro=
m
> target side, which almost impossible by software, it is not quick enough =
to
> parse (write value) then send back data.
>=20
> >
> > In the master i3c side they don't abbreviate i3c_master_controller to
> > i3c_master_ctrl. I think we should do the same here to standardize it.
> > Thanks
>=20
> The problem is in I3C spec: "master" already depericated
>=20
> from i3c spec 1.1.1
>=20
> "Controller: An I3C Device that is capable of controlling the I3C Bus."
>=20
> master/slave =3D> controller/target.
>=20
> It will become more confused if i3c_target_controller. "controller"
> are ambiguity.
>=20
> If "master" =3D> "host" would be better situation, but not happen. A poin=
t, I use
> "ctrl"  here to avoid I3C spec defined "controller" term.
>=20
> Anyway, I hope more people that involve target support discussion.
>=20
> >
> > Regards,
> > Joshua
> >
> > > --
> > > 2.34.1
> > >
> > >
> > > --
> > > linux-i3c mailing list
> > > linux-i3c@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-i3c
