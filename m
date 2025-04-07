Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8C717BD3
	for <linux-serial@vger.kernel.org>; Mon,  7 Apr 2025 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032552; cv=fail; b=ovtXwI1E4Zn9fwgMt6Rj+UWeWn69QP/pKVnhbKeAHTCh4jyh3qTP/XBw2/4JxIBmGxnhqZ1xVuQURtDG07N9QDvtfNMy3tj7WQB1EaCMZXEkliz4aYRgpnuurQO2+K/iD8C4BjyJZk9+eByd3OWNDadRPdjxcjBSGkF3W5cRFF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032552; c=relaxed/simple;
	bh=qrTmvOfq17Y5feOkeGFzQMD6ybZ2rMa9Rpnp269iK5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QAGJwbnuVemY7UcCzTNblr6/nUvWyJTQVGfVl95TWJMVpOZDbyT++m2K8sMxticnS9StOmMUA6DpOEfaV+J/jCWRWq4+MhoIwIKEEkr5XNp65FIToVEr5bUoT4BwKETjgKVd5v8vXoKTVlaRC/k8+nDPkaLndGxSUXWts8Ck1Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mwwhCzyI; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mwwhCzyI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S729O43zrqQ4eqmlHNQFLzZCZxt/FJgkMNYvWB7a2wEZF6luT/iyXOEgP2lpI+Zy0tDQqPou1wkzc6XhheLLJ6aW9QcnFDvjoBgUzaR1g1A874C9qHPfrIAJmBIlAHDLXaqn/MZryUhQKboXH6LeRU2awfgPUk0/Jcwgl0tU71mDysm49wpngv2dqzWpisEtqV21EqGzdns38/gX+l1m01rudlJt5iPUTSlf6mke66vn5FpSDQpC6MWQ+dbJNXiqe/kPS5ujfLOaWI0ctLVqlhZ6gZBpaJNZ/hJdwOVqY5N/O+cQi3LsKE5gc+kBUhAbG/qV/3//ouIFgEMcyrbyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqQWXksyFC6FRsFjEgVcIQOp9hwlVFDfLn0L5tZ7AVM=;
 b=fl1jPtaPGopB21bKVlxI6qf+D2eP7OYEl54d9tiKAoFFV+87LqIwUPp80xUo9IvvDKJ4rkdK28gPkDJEJAYPIr0FznYnmwfN8Q0sPB6gnoVEWddcnd858vfamPttCPng5VryDLolpGN1lX47WkDxJ57MR8xpEVsDRva1kZ9xQwsbEVgJtHX5tO+T1fgqg06+ScsAHBi8fifEFvxy59jHljoSlWw95GQB8BmVSY9A4XqM+1TP0TXiA//W0CSjBwJwB6XaK9m+Z18hKPJJeP96RZ6d6eLY+bISv7It7ce3iWx769s10JQXuAZ2+HAeibnx3I+JCTDgMZBL5vKqBbQn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqQWXksyFC6FRsFjEgVcIQOp9hwlVFDfLn0L5tZ7AVM=;
 b=mwwhCzyIrm6+f14X8qg7GlBrDOeT/xRuvt9Gw6d3EQ0h+kSheyL/8FRto3mFlOa2kiDxQyslNkHyjeBo9s3+6geHxeyVoSdF/pk7wuZjGYMrNPraBcY6K+DeDUb02tAOEiQVf6VTFTH9kRvbEdHjySIYgDBgaHw/6szBX/TeKzRzc03kMnx6V/+FqrWZq5xWZBGtiKuzZDtZfJx3gGLDAXsr0wmJrnbEWYoP0uPSLYyXUByMyQ7WA8D6ecRTZt80CQltZn9ifHCz1spQqy7Ll4KY0BkD07BlYyNqNwJC0n21atWW1XMsG/ouhhqJk865SDel0cnU7cBRh4AnB0FESw==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 13:29:07 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:29:07 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: "robh@kernel.org" <robh@kernel.org>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Manjeet
 Gupta <manjeet.gupta@nxp.com>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Loic Poulain <loic.poulain@linaro.org>
Subject: RE: [PATCH] serdev: Add support for wakeup-source
Thread-Topic: [PATCH] serdev: Add support for wakeup-source
Thread-Index: AQHbmmSWtvbme4Z8Vk6ymVBEClMypLOYN+hA
Date: Mon, 7 Apr 2025 13:29:07 +0000
Message-ID:
 <AS4PR04MB9692E5B8B5DC1917A02EFEDDE7AA2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250213143430.3893651-1-loic.poulain@linaro.org>
 <20250321132435.GA442087@PE-DT639>
In-Reply-To: <20250321132435.GA442087@PE-DT639>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AS8PR04MB7878:EE_
x-ms-office365-filtering-correlation-id: c8a3891c-8071-4e07-3a89-08dd75d82c37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WwNg6ULTgypO4vu03VvWjjIunQw2qMXQ1cQenQlY80MRAaSftCYFByLQogic?=
 =?us-ascii?Q?M28mBXpb740B8SaiSFETv59PV7aum1V56JksmX2UBE+oU4x42nYVWd14UtAP?=
 =?us-ascii?Q?lJANH7BU/EmcsluK19B/C5AiIkI63qJ5zlLo0zYhKHLd3DQj5daqz4JMYuKS?=
 =?us-ascii?Q?vptiBTVrK1R8MrOWXLro/cN+djDaN7xMZ9KJBfYozcD71YjOpzRnPuOYTFYg?=
 =?us-ascii?Q?AyE+gw18t5Zc9R7JkowtjZ+QRK9FTo7x2oGw57JENM6e+ReG177eqEq2PhPH?=
 =?us-ascii?Q?KEtEK56aBepY7uFWKmtw+9115mX4OjFJJsgC+IXvOhIWoYaDoT1LnFOnxq8Q?=
 =?us-ascii?Q?s4nvHa6dhkX05f9rwxQ203A3bVSdM97yN0gC7W2IRlEVvaeZpdhh6//OIlhp?=
 =?us-ascii?Q?7326E9+q5zf3TqF4f0DzIDJXSYLDpFWk6aUDjTQ3urtuKyW87q4QvSULaj6u?=
 =?us-ascii?Q?o5rZOfcstz7ovBryeq+R6Fb3HaShjPwJh02DGj+iq6TDHDP4I6HLU4aYAqO+?=
 =?us-ascii?Q?AvFd+2QaBRbWoUwYIuHghYzItTL9zT3HcNZn9EsUh/l0wzZWDgP3sL/DZfv/?=
 =?us-ascii?Q?gQNUAXaDcrJsdk5VOB4zNlwY2aUrOm+LFWsYHYMpL6F1nya+efPqwtjtpup1?=
 =?us-ascii?Q?vo8AwJ9dMiq7BnJ2dU5xj7IVOq8C068OMxVFy8tCPGM3RIoCLjqZWAaaSr20?=
 =?us-ascii?Q?6j7Tn8ETgzV+t8WXhomJ8paQHW3li7HIcJelwvzj/jNSqb6hUl8+EXu7PhG7?=
 =?us-ascii?Q?YKQp5uOpD07K+0WSpvSCXV7CFE70H6ppvk2z7CsJ95iE5Y4olQOxzjELFslL?=
 =?us-ascii?Q?fmbH7gj56LRyltqzuc0VA0AyLfZ6cG3dPopWZHTROJYH3Qu4jypFYTjkPy7h?=
 =?us-ascii?Q?mec+6K07+P/6F/mPX1BbqtwwLtFZQR9u9X6BZ3KEXQpafn4kBepW1+6gqCIF?=
 =?us-ascii?Q?FEf7NoFgwl31SNkeRmI0m5J0svN9XlOuP+weOYpDfqdPmEJwfYH3lvTG2tHH?=
 =?us-ascii?Q?1JgYFtWEGgHXnXOmEZDCJTgdTwZKtZtvQH6eiSD+eIMiLJe6kCPYtzYbmD6I?=
 =?us-ascii?Q?YPyEsBIxQxNN3lmuNWDafR1wd+CdQ57USl2M4884uwLV7lP1VhrIhG58jljq?=
 =?us-ascii?Q?950yPnqAvqg6US2jwlJBbfXc57AOFdPZWiVLjcoZ/qhr1fAh2TgIYg8e5aUh?=
 =?us-ascii?Q?ex+DzNnztdDuKi/DP2HHe272n9OvZvbUdjfK8rOlXW4POkJEZ5BgAjA8pIHo?=
 =?us-ascii?Q?T7Qiw4TbYdjccUufSeVTbeOdJRGqFRPs032oIkKPkNsXTWOoAm9n44Bz/+za?=
 =?us-ascii?Q?kEfs1OBNbjLc+mkw99IKOsg+s/NnuhgKNSe8XOjS3kI0E6gpU4TWBho0/w/l?=
 =?us-ascii?Q?RyJc44iCrr/P2bQ8PCcytuatB38r6co5w9ZRtX8cRiSaQVaKYMRHGhwfDIz3?=
 =?us-ascii?Q?6yr0TrNTXL1SAcBNJESCmpCaV8tyS5V8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gd7/bzsZb3B4mjlQ+DVTU8RqnJFqrcPI8wbs3DgLpEQpNHpVZBaOwLvaVS7Z?=
 =?us-ascii?Q?4IkyHoMg1953RbUGUlhcaROil7sGYagkjC0L8ygXw2DXKtZ2gUtkGedFDwjT?=
 =?us-ascii?Q?47jOG8EGQfID+S+AfyN8lrdqGN2ROyQTuqeah+O3KoBHxVIQWxC0hDRdCBr0?=
 =?us-ascii?Q?QbHcvG87MhzgxXlSCqmW9gJ8AT+aVP+g8I3/suDCO/3RmqkHYB2vEcjhP1pN?=
 =?us-ascii?Q?cXYxDaHrh2KYsO6bsJkjdnV2p4kU5odrU+1qXuBzDMBx9CR65wBM/cQfpQCP?=
 =?us-ascii?Q?uUkiVyNonIp4S3ohksqObzPyXEV/yMC+rvm/ymJQn6bXXfAmQxsh9r//rAHZ?=
 =?us-ascii?Q?0qiNZ8guQF1tn+Bbm3B4b2uakK6HL39rlGBlcokxCwlpuXObBm0V01IZK8oJ?=
 =?us-ascii?Q?7uyHiVLA3y/LXOLB1trHhP39AIt1nF1CoY/hjawkmczpit2zI2iBYvi8G73V?=
 =?us-ascii?Q?I+sDU15VqoLHQGficaxmfs+eyTeSUDlbkSiqSdombdKiYg3xg+/v9Ej2nBSB?=
 =?us-ascii?Q?uhbBF5IYX2plbSOAHLb5xkvmTfuYTY2U5MZkZjf1miYvbR4i9YP0peIWr5ze?=
 =?us-ascii?Q?Bap96Nli395mAMYA0W6ItgN8KakYSlzKs+g/a9tdCe0JidgU2ETxzUUlCO6X?=
 =?us-ascii?Q?/bvIwexnab08/3LfDDdrrqfdMdO29/xl4BP8bgQ/pVvO2EhuRFRLd0Pdqc1j?=
 =?us-ascii?Q?wwPo4pdDFHYx2Xr4J9syi9KeDLFjcEmzyOtjA/uH2tOYQSEl/MywqAxfSEJt?=
 =?us-ascii?Q?d6E6kjRvF3Mhc37Qcs4Bh7mekfZUICqiTEHav5YWV1Bv6OT95STcJwLnTq3r?=
 =?us-ascii?Q?ORCV2EXGze85Bli7E2QuEFz0P2IkKZXEvYBK27LXDmOxUT44wla4a2z4gRZq?=
 =?us-ascii?Q?Xg6opIlhbZIXC/pRA29HEm4yaivNwhOULC+XNbz6c4Yuk4P+U89ltoJtl/7/?=
 =?us-ascii?Q?n1xw4zugqafQeRbf/UYBYAGt5OPIz5bvUvs7vjGLfAB2lPt7ZIELFCT4IM3L?=
 =?us-ascii?Q?z9r9vDauvNtDPuuiOyK5x54MmlzEpLCfgJozsA20/a+6jlQZmTTZU7+f+iuM?=
 =?us-ascii?Q?NvC8vSl+IjipDwdsW+qHjGuTdfdq34vbDL0yPZDPnvpgl3+sc5mdE+IXAPxH?=
 =?us-ascii?Q?Tq2vZGKWQTX/g+HEfqW3GcKOGli75y9zAIbvmFHf4wJVb7BKOVIuDQ8Ed6bc?=
 =?us-ascii?Q?QVYX0ORWBVCvOwHPS7fl9fjaxhbbi5kzvawZtOJnDLlyigoJHRs5TLZwatOG?=
 =?us-ascii?Q?OT5beJJfWsWOkpyOTLr/buAwPnt6AzrcLIS5sS8ltC+RbDYmrBjxuMXuErAf?=
 =?us-ascii?Q?fjuVFaIiv7xVb22pM5uSvWit8n3OfGziuS9YS5fEEb94Cy/a0tlSHWdP8bVl?=
 =?us-ascii?Q?9oR4uhCoR38mEE1xIbNHBmJEY/uZXhvQn+sLIppOyfwUa7VpDMwhnzclq8PT?=
 =?us-ascii?Q?PwN1ZXoiU2BZjVPA2TP2wGS2fO2WvpVRZAdVYsFhPplsV67o/NRhLITr6WhI?=
 =?us-ascii?Q?Znklbaudmo8cPdcL+Q7P9Z432VeKqSQPmdh+OA4kwnyYiupbqA1FXNhlS0ZI?=
 =?us-ascii?Q?H643Iz0JydK/FbYh1zteBoYxSTIjTzKaiMIckMQ2?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a3891c-8071-4e07-3a89-08dd75d82c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 13:29:07.1460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bw+DSg/avYYVT4o4icXYmW9Uyt0YNOB/dhMHSCH2v2KajWaHn3DxIgruSyHfzpLc/an23t/xdT5M12Co2Q2kAXmRmgEqP9Y78qZFroQFDlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

Hello maintainers,

This patch is in review for quite some time, and it's an important feature =
which we would like to have support for, in the NXP BT UART driver.

 If there are no further review comments, can you please help approve this?

Thanks,
Neeraj

> Hi Loic,
>=20
> Thank you for the patch.
>=20
> I have verified this patch with btnxpuart driver and I am able to wakeup =
the
> host with a GPIO interrupt signal from BT controller.
>=20
> Tested-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
>=20
> Thanks,
> Neeraj
>=20
> On Thu, Feb 13, 2025 at 03:34:30PM +0100, Loic Poulain wrote:
> > This brings support for dedicated interrupt as wakeup source into the
> > serdev core, similarly to the I2C bus, and aligned with the documentati=
on:
> > Documentation/devicetree/bindings/power/wakeup-source.txt
> >
> > As an example, this can be used for bluetooth serial devices with
> > dedicated controller-to-host wakeup pin.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > ---
> >  drivers/tty/serdev/core.c | 48
> +++++++++++++++++++++++++++++++++++++--
> >  include/linux/serdev.h    |  1 +
> >  2 files changed, 47 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index ebf0bbc2cff2..2d016fa546ca 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -13,8 +13,10 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/pm_wakeirq.h>
> >  #include <linux/property.h>
> >  #include <linux/sched.h>
> >  #include <linux/serdev.h>
> > @@ -164,6 +166,9 @@ int serdev_device_open(struct serdev_device
> *serdev)
> >  		goto err_close;
> >  	}
> >
> > +	if (serdev->wakeup_source)
> > +		device_wakeup_enable(&serdev->dev);
> > +
> >  	return 0;
> >
> >  err_close:
> > @@ -181,6 +186,9 @@ void serdev_device_close(struct serdev_device
> *serdev)
> >  	if (!ctrl || !ctrl->ops->close)
> >  		return;
> >
> > +	if (serdev->wakeup_source)
> > +		device_wakeup_disable(&serdev->dev);
> > +
> >  	pm_runtime_put(&ctrl->dev);
> >
> >  	ctrl->ops->close(ctrl);
> > @@ -406,18 +414,52 @@ int serdev_device_break_ctl(struct serdev_device
> > *serdev, int break_state)  }
> > EXPORT_SYMBOL_GPL(serdev_device_break_ctl);
> >
> > +static int serdev_wakeup_attach(struct device *dev) {
> > +	int wakeirq;
> > +
> > +	if (!of_property_read_bool(dev->of_node, "wakeup-source"))
> > +		return 0;
> > +
> > +	to_serdev_device(dev)->wakeup_source =3D true;
> > +
> > +	device_set_wakeup_capable(dev, true);
> > +
> > +	wakeirq =3D of_irq_get_byname(dev->of_node, "wakeup");
> > +	if (wakeirq =3D=3D -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> > +	else if (wakeirq > 0)
> > +		return dev_pm_set_dedicated_wake_irq(dev, wakeirq);
> > +
> > +	return 0;
> > +}
> > +
> > +static void serdev_wakeup_detach(struct device *dev) {
> > +	device_init_wakeup(dev, false);
> > +	dev_pm_clear_wake_irq(dev);
> > +}
> > +
> >  static int serdev_drv_probe(struct device *dev)  {
> >  	const struct serdev_device_driver *sdrv =3D
> to_serdev_device_driver(dev->driver);
> >  	int ret;
> >
> > -	ret =3D dev_pm_domain_attach(dev, true);
> > +	ret =3D serdev_wakeup_attach(dev);
> >  	if (ret)
> >  		return ret;
> >
> > +	ret =3D dev_pm_domain_attach(dev, true);
> > +	if (ret) {
> > +		serdev_wakeup_detach(dev);
> > +		return ret;
> > +	}
> > +
> >  	ret =3D sdrv->probe(to_serdev_device(dev));
> > -	if (ret)
> > +	if (ret) {
> >  		dev_pm_domain_detach(dev, true);
> > +		serdev_wakeup_detach(dev);
> > +	}
> >
> >  	return ret;
> >  }
> > @@ -429,6 +471,8 @@ static void serdev_drv_remove(struct device *dev)
> >  		sdrv->remove(to_serdev_device(dev));
> >
> >  	dev_pm_domain_detach(dev, true);
> > +
> > +	serdev_wakeup_detach(dev);
> >  }
> >
> >  static const struct bus_type serdev_bus_type =3D { diff --git
> > a/include/linux/serdev.h b/include/linux/serdev.h index
> > ff78efc1f60d..2b3ee7b2c141 100644
> > --- a/include/linux/serdev.h
> > +++ b/include/linux/serdev.h
> > @@ -47,6 +47,7 @@ struct serdev_device {
> >  	const struct serdev_device_ops *ops;
> >  	struct completion write_comp;
> >  	struct mutex write_lock;
> > +	bool wakeup_source;
> >  };
> >
> >  static inline struct serdev_device *to_serdev_device(struct device
> > *d)
> > --
> > 2.34.1
> >
