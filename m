Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2096.outbound.protection.partner.outlook.cn [139.219.146.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE9145B0A;
	Mon, 13 May 2024 03:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715570186; cv=fail; b=P2jUCP95OEgFlKJ+b1gJ8x816knfXUJ6ghZKT4yJLGsk/IgrL9U7/b1kY8pJ73ZwQbfy2Eouf6OHj00arw0/JeraU9UbTQwRLnCy7Bxd9/RR47vMezFKEYEZjbpIanCvPY9WuRWzy6R4hKvcE3poUIucnd421tfBZTIB1cUxqrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715570186; c=relaxed/simple;
	bh=htnfL11LcYNS5fplqGS+tlhtNbCEYHcoi6MqbnNPUuY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DK7fd90opeX9oWPeQfF6U2ZOkbwyyQBbdjHRNWzUy6hyy5PrLmD+VlSal/xlD2sC6SKUCUVyvc9xix8wWT/dI/pqddExEOA79DBEEl++J9NoqQIlsZ86yFoJkOnG8eEsK8Rc7KL+kN8n/PJnxo++1zwxcBv6iSUv7S1NL73r8Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJh6xtqKhSJ1zRdpamkqxSO1wx9gpraaMYPinohgUn0ivR4WsyZ5uPWtFmQE6dykTb47DQSZqD3TjVnZLBiTfwaSss5Pvt1F7rw8ePyO1bfdY/P9VOJGqne/Qk81JtMZw5JtuBeZ7GFk3YcBIS+A6kg/lYAcd1VIWTkEupGkS8JvzAMKh1V985AuAytrA41VCdPV03cPBDThhFdHOH4r+PVSBhUQaSWxk23eMlNL1Fu+4sKnewg5qjQ55wnbsrRrVAipVWRp7+gsvsPzvJRZISATXV9feOoIXuT2yJrqLVHjeerNQHYelUO8i5OMPi+9tniV5A1/9Wt5vYWnVKRApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jX2bh41WhE8eTPK4Fs/+vHGzJuAQAasQ5kIrFISVn1k=;
 b=i2ZyEHSMM4mBgBAqWWMaXVenb/sPwV6ZLG+Gzz5es9SBRg5bPwydpUCCbvKWyD/KF68T0SLz8vtiEvisAeSRZiiRr8zkpn5cn0QrN6INJ1d66DIm6JMYixEjpzFOcivJXcdgn3GvOTR3FB704iCg+992hkRqsoXBtijqyldIS/Q/QwbueWKXbq8eLOyiKyB8T3pWVNf9VNNTRxq2ikHfPh2bXfiF/6pZHF3KlaTX4dqdqE2nDjzOVp3Sl8w329hQ4av071QWZlSoZanTA9ERv+3Qkiv4EsbCs+MkBmwc40DMqrFTB9eVYQhG4Eiy7OfzokvrriFd6zULH/iHkJYZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0555.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 13 May
 2024 03:16:05 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Mon, 13 May 2024
 03:16:05 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Frank Li <Frank.Li@nxp.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>
CC: "conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
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
Thread-Index: AQHaoL9J0lwk/jg/a0+LeeDupwAoCLGUgoaw
Date: Mon, 13 May 2024 03:16:05 +0000
Message-ID:
 <SH0PR01MB084187FBA1E4EE786A8996C9F9E22@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240507204311.2898714-1-Frank.Li@nxp.com>
 <20240507204311.2898714-2-Frank.Li@nxp.com>
In-Reply-To: <20240507204311.2898714-2-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0555:EE_
x-ms-office365-filtering-correlation-id: 0f2ece38-1c4b-486c-e9ac-08dc72fb06c8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mjC4M/eMaIhFRV2NRAZb1f6Xw0f1ukejnEp0JfU4fGBbxeU2jrnrFdHviQ+7etJc9MFdmk/JGLUKWary3eDY5zg/PZ1F5a6EdNSnw+gQU0u7p90Ve7nyjSoKzNIrFPEE9ebl5OJkXi4R+rAt76PPzGdgpisD4IB27C3tR5L6pu/VOuMW+yZ+2lhKtW1+96CdokpYAgV8NZxZx6Li9ZMcKWeb0ZJ6/IMRu2oO0SG2tTS4vuEWKkpB6sG6ftKa16nMZo2vrFl8Y/eaWtSAJZBAM3Yes0xmdVmLLh0u5nFeTnbu/IJO5SOeQaNOTHayYmqoLlzGLyF5BF8TlQKAZJ77MwC4lVl49MA4HLpIQ3iBj7ZU9nvP3ThsXKkD1y57SqbktVVQag7tldGDd0JOKkuCO/Ox57ObNASOEGqzqgmAlQFORlwDXOrmCUhWbBquheyFN8fKyulw5nNE2Rs45u0Xd5ttFAUwyt4cLMrV3n4x4Eaeyx+ZNwnCBHmi9jHzpqFj4APIn5rVYNYdQD8Am/gcQPjThSnSneq1rxgYjP89D0CsnD3qhPU/UVsfS8YLXYqUZ9I6ElXF4lk9A0TbAU5ijWnGTeQdoVzVvf3oM+FVyxLj1L15VNgu2Y7niw/g45et
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(41320700004)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5cFJc5b1KoDlprn18BUBa1U5aE8NC7FadivsA3seiz2dQM6onS49/KC9j+v0?=
 =?us-ascii?Q?z6cGsPL5ivxl4vQUhovQYzU8fLlQ53vfbS3xi+ztHTryKbpM/4E9mI4gt624?=
 =?us-ascii?Q?jQU2MYQjyPxCaxfvqNQULklSbwG4nJ5gnsfB7tRx/RQmasmGk3O7JEv/S2ub?=
 =?us-ascii?Q?bJYNyO8/YwaDsutxW1q6QWWwOR+bmbcR3yvXSKKtulSKRghmREbf2476nxHJ?=
 =?us-ascii?Q?8CPPFsouRCDrF9/Dzq+eEvdEP82p0HCl2WFwGMnoEIZFfGiPFmDMr+ELo+qr?=
 =?us-ascii?Q?JJpklfqg28j+nvFjN3Xk5PXaKcMwjGmS2gYFgWV38Tpbsv7z+RE5rCJ9eheq?=
 =?us-ascii?Q?f/jEnoj7uTg2u79yMIokGJCHkyZ04Fr106MyLOMmb5PCwyBnQks57JuziHn1?=
 =?us-ascii?Q?sflnvc5uSA2wuPD3PHCiEOfN1M14f3swKQL7SXD+AxzKeCCT+uYVIL0obDKO?=
 =?us-ascii?Q?u9AsfkvHTkz2yEmWyo4gs8YQ5C4WJ5hiMTt+OLHSaBIexOXBuy5jV7/kg88g?=
 =?us-ascii?Q?Q66sqadyADMrhJSMDvqwHpcvOQ3+LYhe4jh8/4ndR77grgB9ea/qMH1rF6zX?=
 =?us-ascii?Q?Ktc1Ru43+R6N9RtojOgF8t0CpC9aBnNiRBg9T0vBjcbRoTW084cztd4Pc1W5?=
 =?us-ascii?Q?qTa5GM/OPOaQIb8K5py38FdfSAac7WECbHfLcu3K7LI2T/jdRr4IV43KiY+1?=
 =?us-ascii?Q?guht8/JjkjMe7BT/kIXYY/jOuDSwlMLnJ5aRfpFulo0NHVvSFH4hr2kxwNlT?=
 =?us-ascii?Q?MxoiAVYhNVjdNio9F6brurfq64kTN2jcic2UvIM+0IxSzZribLgdadqR00Y9?=
 =?us-ascii?Q?a0G1PBVab5LwUJ77ajXkOgCXzhqN1YKY2TJPJrjbZDlTAIj9MsKE5+HgryMJ?=
 =?us-ascii?Q?feKeQXuiMvJ3f86S8TDrMwC3z2S2eH1JcVLQCTj50/3o4aGVtUYg0mNT82q6?=
 =?us-ascii?Q?gTy31KR7NeYhczGojwrjwNB29T4EdHvDSxeynRY65KmHmrrwJ4HDy9mZgrA5?=
 =?us-ascii?Q?LPgpry3uMsr1607dVG41TbUAfm6cCzx9cDLAJF6R/WyuTDLe95muJY+8yMv2?=
 =?us-ascii?Q?0cRdXUtvuEoxdiQI9/+2CNZdLnolC/+wiqXJ7PRNXpEFxYAZFx1Zh0FlACUZ?=
 =?us-ascii?Q?VmWcN6WrbzL2btO/ThQhoi/ktzO8qprhCd8bKXPdylEr3dYJpjDVOZw0CIzr?=
 =?us-ascii?Q?UOd2mkK0/vdZ31KO4lJoCHfrfPE3er9ZB2ONXdq1kckYBVXfo0ppXFhUNOBi?=
 =?us-ascii?Q?4VziwvqVBehU3tt19kXKZX6Z1YpwDuSszygnH9cenfnXye1NmqH8tTKyzMk3?=
 =?us-ascii?Q?SvH+Jo8Qogtkz6CfAmDLme4RE4U19oJXQ2P40/havLbJNlmGy8anZGTKdGu+?=
 =?us-ascii?Q?z09nH7/uBiHCAx6LayrOG9AFbHXslrBT3E5Gj1SZXck9Dq8V3G+4li6TNC4O?=
 =?us-ascii?Q?U7DdsWE0/tr8QTBwjMoh15Kullqw9DrVFXHHq2mNugSmMuh0WyQpy0aHXLHQ?=
 =?us-ascii?Q?a2uKOjl34DgWT7TbY/+szVkskfDDJ89mc5I7FyMdbJvk5NALnqVbApM7N9bw?=
 =?us-ascii?Q?MRNPs4tqRR9jBhHNhcwMsiYZm5WCp33WMliGbERGisO/3Ll88XlYoLsidnRt?=
 =?us-ascii?Q?Xg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2ece38-1c4b-486c-e9ac-08dc72fb06c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 03:16:05.5641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: meLKca3lf/TFg7RMqDVN60oKSRxqg9QkvJYqVBT4g7AI2pWeEx/KrYZBCR2b6AaWciNufN6RVId91ITHAoEZ7MmI8QYZUkiG47LZdfEKQwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0555

Joshua Yeong wrote:
>=20
> Introduce a new target core layer in order to support target functions in=
 linux
> kernel. This comprises the controller library and function library.
> Controller library implements functions specific to an target controller =
and
> function library implements functions specific to an target function.
>=20
> Introduce a new configfs entry to configure the target function configuri=
ng
> and bind the target function with target controller.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>=20
> Notes:
>     Change from v8 to v9
>     -none
>=20
>     Change from v7 to v8
>     Added missed head files
>=20
>     Change from v5 to v6
>     - fixed build error when have not CONFIG_TARGET_CONFIGFS
>     | Reported-by: kernel test robot <lkp@intel.com>
>     | Closes: https://lore.kernel.org/oe-kbuild-all/202402030437.GdGCrKeK=
-
> lkp@intel.com/
>=20
>     Chagne from v4 to v5
>     - add include <linux/slab.h> to fix build error
>     | Reported-by: kernel test robot <lkp@intel.com>
>     | Closes: https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT=
-
> lkp@intel.com/
>=20
>     Chagne from v4 to v8
>     - add include <linux/slab.h> to fix build error
>     | Reported-by: kernel test robot <lkp@intel.com>
>     | Closes: https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT=
-
> lkp@intel.com/
>=20
>  drivers/i3c/Kconfig        |  28 +-
>  drivers/i3c/Makefile       |   2 +
>  drivers/i3c/i3c-cfs.c      | 389 ++++++++++++++++++++++++++
>  drivers/i3c/target.c       | 453 ++++++++++++++++++++++++++++++
>  include/linux/i3c/target.h | 548
> +++++++++++++++++++++++++++++++++++++
>
> ...
>
> diff --git a/include/linux/i3c/target.h b/include/linux/i3c/target.h new =
file
> mode 100644 index 0000000000000..b0bf06685834c
> --- /dev/null
> +++ b/include/linux/i3c/target.h
>
> ...
>
> +/**
> + * struct i3c_target_ctrl_ops - set of function pointers for performing
> +controller operations
> + * @set_config: set I3C controller configuration
> + * @enable: enable I3C controller
> + * @disable: disable I3C controller
> + * @raise_ibi: raise IBI interrupt to master
> + * @alloc_request: allocate a i3c_request, optional, default use
> +kmalloc
> + * @free_request: free a i3c_request, default use kfree
> + * @queue: queue an I3C transfer
> + * @dequeue: dequeue an I3C transfer
> + * @cancel_all_reqs: call all pending requests
> + * @fifo_status: current FIFO status
> + * @fifo_flush: flush hardware FIFO
> + * @hotjoin: raise hotjoin request to master
> + * @set_status_format1: set i3c status format1
> + * @get_status_format1: get i3c status format1
> + * @get_addr: get i3c dynmatic address
> + * @get_features: ops to get the features supported by the I3C target
> +controller
> + * @owner: the module owner containing the ops  */ struct
> +i3c_target_ctrl_ops {
> +	int (*set_config)(struct i3c_target_ctrl *ctrl, struct i3c_target_func
> *func);
> +	int (*enable)(struct i3c_target_ctrl *ctrl);
> +	int (*disable)(struct i3c_target_ctrl *ctrl);
> +	int (*raise_ibi)(struct i3c_target_ctrl *ctrl, void *p, u8 size);
> +
> +	struct i3c_request *(*alloc_request)(struct i3c_target_ctrl *ctrl, gfp_=
t
> gfp_flags);
> +	void (*free_request)(struct i3c_request *req);
> +
> +	int (*queue)(struct i3c_request *req, gfp_t gfp_flags);
> +	int (*dequeue)(struct i3c_request *req);
> +
> +	void (*cancel_all_reqs)(struct i3c_target_ctrl *ctrl, bool tx);
> +
> +	int (*fifo_status)(struct i3c_target_ctrl *ctrl, bool tx);
> +	void (*fifo_flush)(struct i3c_target_ctrl *ctrl, bool tx);
> +	int (*hotjoin)(struct i3c_target_ctrl *ctrl);
> +	int (*set_status_format1)(struct i3c_target_ctrl *ctrl, u16 status);
> +	u16 (*get_status_format1)(struct i3c_target_ctrl *ctrl);
> +	u8  (*get_addr)(struct i3c_target_ctrl *ctrl);
> +	const struct i3c_target_ctrl_features *(*get_features)(struct
> i3c_target_ctrl *ctrl);
> +	struct module *owner;
> +};

This structure looks very different from the master controller ops 'i3c_mas=
ter_controller_ops'.
I think you could probably combine 'set_config, enable' into 'bus_init', 'd=
isable' to 'bus_cleanup'.
Also using the 'struct i3c_priv_xfer' rather redefining another 'struct i3c=
_request' would be much cleaner.

In the master i3c side they don't abbreviate i3c_master_controller to i3c_m=
aster_ctrl. I think we should
do the same here to standardize it. Thanks

Regards,
Joshua

> --
> 2.34.1
>=20
>=20
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c
