Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2128.outbound.protection.outlook.com [40.107.94.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C878C18AE1
	for <linux-serial@vger.kernel.org>; Mon, 15 Jan 2024 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Ex7UsO5g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSp5rG46VWnVDrC9knGHeWj6b/sk6PTzfp3BIpv4wzNmsK7Ja8XCWsOLnQbnqf/Irt8DNiAfmulQ7Hq9afbc09Tc8AJDs16yHgnW1QAEML+C5LJy4gJmLgdHphyz1Uul7Y0JsJaxkQcizs0QgKsPl+lcXHfua73GmkuffJS/Iwm2CKgKzdpqUuT24t+JfccvdV34r74Mxn8/njV+4imOSXgeNQRdleJ6u0aqSIDrMQOSoV4u6nChs2509lZD7UCzRAS3Lh++mF3kDCzQfIdskW5N8NL64I4j8a60oJyWcIjjm81MCkxIIENRR8VGXZe0EyAE3/V8YL+9UTJhKHgS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dddn34Nxc8vqJHE7CSWmKSjZrVhYtizTHPpa4o7woZo=;
 b=ccsNecgc+l3BhtpYmutAu3I6Y7J6vnmF5AIBed6/kyjhgYOLgm4/GQApz0+mzlaTy4fNcyR0Ews01BNZpDRHnTd5lpi3PLn71GD8ldhYYm7svNCs7Dr+dYN0nvyQhStzME/KpLJtFNGnFptci+pisN76lytrJ6Rif0tBuxwT94m9aWzKNexG+aB4/LV1sfricVI5m6cY+m7J9evFkwQCPs5HwtS+VTIBNj5DztYduCo4XRqIAiCxRSeUGD0IZBHCtMsU7qnr5jLDW2S5QhYDOMlLTenqo7Ol4k1dm55bP2tx9UGmdSg0NDmPS4vhVWiROxSLw3iNGkUR2KxLl4ymaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dddn34Nxc8vqJHE7CSWmKSjZrVhYtizTHPpa4o7woZo=;
 b=Ex7UsO5g5GHaUBp4dZXnqBvBXG0H7jpytDA3R3PD5GT1wccBGJE3NSbXrV5dQs1RZzfhSoQWwwq6dzEPe/+9uHQk8pfwSU9rlWfUbpzD29wZv2pv06u2KP8zSscVM15VQoVOghHg9JiunD6bf+yGVPbR+s1qjJ+BRZEtbbyloxWMg1Nwf3w73at20foVY3cGWZxW/RdlRmuNuu8ZdxdsrLvS/XOvUPZA3Yi36kKIXs06mtGWsQ1hYPD4jy1soQ0uBpWH4EyWZ29Dg5W3WbYQHN73B8O0N87+JFGLegIbC7AxX87tKUSmC2GxdEut2E1pnh1mdXjCThrBFsKw3SLFXA==
Received: from BY5PR01MB5635.prod.exchangelabs.com (2603:10b6:a03:1a9::29) by
 BY3PR01MB6785.prod.exchangelabs.com (2603:10b6:a03:365::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.23; Mon, 15 Jan 2024 19:07:31 +0000
Received: from BY5PR01MB5635.prod.exchangelabs.com
 ([fe80::46d2:6053:23de:c858]) by BY5PR01MB5635.prod.exchangelabs.com
 ([fe80::46d2:6053:23de:c858%3]) with mapi id 15.20.7181.019; Mon, 15 Jan 2024
 19:07:30 +0000
From: "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com>
To: Hugo Villeneuve <hugo@hugovil.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: max14830 nobody cared Disbling IRQ issue
Thread-Topic: max14830 nobody cared Disbling IRQ issue
Thread-Index: AQHaR+YWx8arCI/v3UGtuO9AmL25TQ==
Date: Mon, 15 Jan 2024 19:07:30 +0000
Message-ID:
 <BY5PR01MB5635C11E9BE2B105FB7B87A09E6C2@BY5PR01MB5635.prod.exchangelabs.com>
References:
 <DM4PR01MB75952BAB0B535CF832C89AD99E6B2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240108172934.c457ca06b6543f868d32de46@hugovil.com>
	<DM4PR01MB75959DD41CC90B1B704A05D29E6A2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240110174015.6f20195fde08e5c9e64e5675@hugovil.com>
	<BY5PR01MB5635A9264220404AA6EA5C089E682@BY5PR01MB5635.prod.exchangelabs.com>
	<20240111115239.63d408a688b1b8783de3064f@hugovil.com>
	<BY5PR01MB56351BA462070C585273B3909E682@BY5PR01MB5635.prod.exchangelabs.com>
 <20240111140833.4d312e7e4ae11f1770df8968@hugovil.com>
In-Reply-To: <20240111140833.4d312e7e4ae11f1770df8968@hugovil.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR01MB5635:EE_|BY3PR01MB6785:EE_
x-ms-office365-filtering-correlation-id: c6196230-3524-4863-3148-08dc15fd38f2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MfQqrg35M/EoelPGbNjSRWLtudALAAevlqWOB2ugCEX7elpk6Jf6U1PNZhpdjG732WlcHHrd7rVKfgeQL0WpERN2NFKBncooS6DG6tohqq8N6Z7KDKmEYYHYaCkN8+6RNtzejBk/yiSrFLBxnETg04avuW7Q7idlCUql//iNTfAmM1xvGJN2E1jjTa7+vagVNfaokxta4f2FHGN7GbnPTUnilmJZ3gZli4FLlnDxIX4cjZ2kpjae1a00Mu6tvP4G6AVglfrynSpRZAbJVjvrZcXPrCfkJbe4jrkF6tKayOKYwe4Pc8OvtXY5fTToNjF4ROQGMJgnY2ty7oLAP/QLCWGTFdgrKUA8KgHp9eaLHv5EFb/1YXgdbwMdQG1alXIHMSNxzCRolUnRDYrft+SS0GPBHK7A/vnqdsPSLGTsW+bR/9Rj7I60kY7AR5c855cByoo1rtgkmefRqXXPALzOA9nSNFlPcDzzbU/bNPnQYFhCUeMn+9XZdAKKow2X4aEo/aG4c5LjpVOgSraylYTvUs+Ej654vTkrDY43IoMP9MeoMmxKYv86oGBvm8dp7Djr3DwjCmZidq4esAypGYeH7pNsy6SbRfl22aoqDhy1Ayj6XFsOzjZCBjUIYbgtwHSiL3WKR3qHnS7KFw1vQokEXi7UvSmALW/V7u0GCA762OY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR01MB5635.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(396003)(366004)(136003)(346002)(230273577357003)(230173577357003)(64100799003)(186009)(1800799012)(451199024)(6916009)(55016003)(2906002)(4744005)(5660300002)(8676002)(66946007)(71200400001)(316002)(8936002)(41300700001)(66476007)(66556008)(4326008)(52536014)(76116006)(66446008)(64756008)(86362001)(38070700009)(38100700002)(122000001)(33656002)(26005)(478600001)(83380400001)(6506007)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R66v17v69huFpTVP7kKBryjPKqz937a02ZK+plP6vDZAy2u9u0Kz+kGgG1jo?=
 =?us-ascii?Q?VjW+cMNkVwe8OYEgOnIR1sxagl5wymMnNsV9NsrJ9PXGXoT6lww4kCQcymNO?=
 =?us-ascii?Q?RcWrREMDIKn4ymVJeMMjOmp3hwPQ1QHFgnJgPJEhElbFXNj2IO0o5/6H+cIY?=
 =?us-ascii?Q?k/aN4kn3bHrDfqQwN1mxNzlkfVjQsIms3cSP6h5wyXC2YfscdnkjvUlVRB47?=
 =?us-ascii?Q?V2xKC19lvSB5sn2ovttZ/Lh1J4buH6M9wTq2RsdZorLu0X9pH0+Vn6YjYeEc?=
 =?us-ascii?Q?q3X4A0eTYncMb8+3yNJWh0gZpkQFBFSObfVsK4sc2CkoghPYf/8sDMMIle+K?=
 =?us-ascii?Q?YQppkFlho3NJqwd5zo0TLfcb2jKG9L2t+ejV20SczksdNFSkqTvvVmViCEzW?=
 =?us-ascii?Q?/pwjkP/dz3KQW5nrz8O6bPqqBuaet68CimzG5Uv/PdIh0J0pLXMh50a9aAlQ?=
 =?us-ascii?Q?BwUkkmeDb90QDUcSvHafZrjmFyLJhEXWOa1u/7lN/Msgp69pb73y98uWSl8s?=
 =?us-ascii?Q?s4t3rHCFUomh0uM0uilNAUVt51hy675M3HefbjLiIsmrXojhLLx0ciL39V3v?=
 =?us-ascii?Q?31zh4gEmT0Rw5jBYb2wwV81R9/EpecAl+1D02osjLMIfbK993QrjLhp82W7t?=
 =?us-ascii?Q?/oMzTwnSXcNm8SGFEX4b1MjEtxf3Nfyd2FAEW2wVobqLYRm2JFzNml7JmGLs?=
 =?us-ascii?Q?Y5gl41tGDKHPpPFYxAyrnAEeDO401ixA+D7G8ANtqq3CsscTa7ONvEdTTA7V?=
 =?us-ascii?Q?qS98aWRmx03UKbQXoPROF6Geu+WiGrcyqBkDnsjrCTdPmSn5osJ7Y7sa854s?=
 =?us-ascii?Q?qA0qIQe/JBciZSagELq4FzQMOpv5R0InPbxD8L5OXBNBTMXhaoSnzn5lUhdV?=
 =?us-ascii?Q?Z1VCeTcfeyU8tI8MH8tAMQ3ZChu7qde23NcnRc+kyHJlLKvXZGbL/6H+U1PY?=
 =?us-ascii?Q?kthDOibiU/ADnlKi87BALeMLTU9mA+vRqZL9c4PrS/lp2IJt1is6QjeG5RyH?=
 =?us-ascii?Q?ZqNWGTLGfwqEGmOURYkbgipnPxrTMO8YtKN91ULC/WAH/hyjOCqX2s5/D6rg?=
 =?us-ascii?Q?HW0ukTHj57WHLLL/a5t2Cvqzw77jluBQzRNhsq6e/A4P8sXiLYs52Qb2cEz0?=
 =?us-ascii?Q?Aqe38kQK3xL71D2Ply90sbGhj9r49YfmAowXy9fWwzD3Xdu2sIit9CpwaUaB?=
 =?us-ascii?Q?pYcH608/fD5q/+4avdeE6N1JjW84hCQ3WXykArhvEp0btFkRpc9z8QQo7v3+?=
 =?us-ascii?Q?epMONysRD8qN7CfbaUDbxR3RTMPFdcvTCYtcbL5NA7KhLCcz79cJMOwjvmHV?=
 =?us-ascii?Q?k3bOlJneu3F155Fq3r333INDSAaMte+rqOdre7/3gRMk+U30FMmFLOqKs/ZN?=
 =?us-ascii?Q?kk+In7gY0DPuzeM4lSELP6UA53Lkrhhq1bdq0KtPQ7/A9ddXwPbcI2zcPsm5?=
 =?us-ascii?Q?ltqoRA/ByRHgzE6YjibT+sDwLq8trmKf6ZQ8J8aNoIm0z0vuphKN2//XBrrB?=
 =?us-ascii?Q?BfYPz0Six/vw5g64tZG/l5VZ+rGawxhn3lqhx+wLEdC1CfA/UYAtOiXV2JH7?=
 =?us-ascii?Q?d8j9Tk4QYZ9SH70jKONHDnJXQtd1Z8APhELB2zFtdI+d+KjFAAxrgLdDHoMA?=
 =?us-ascii?Q?Qg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY5PR01MB5635.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6196230-3524-4863-3148-08dc15fd38f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 19:07:30.5795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: In4oVsZMxoyUeqesedeUB5dwybf6CL+yWWbz2//5SPGLS7f0pdvdhI8zQh/SnVjMuDpXADzDCb0lbn7fCeVEtj56Ngspv5D8vrq6yo+dJz5Bkq2+E8YuDotV7JFYZVsS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6785

Hi, Hugo.
We fixed our clock issue in the platform; and you were right, I need to bum=
p the delay to 100 in addition. I pulled in the latest version of max310x.c=
 from torvals linux and I still get the "nobody cared" stack traces & the i=
nterrupts get disabled.  I'm hoping you can help me get beyond this.

57:     100001          0 1e780000.gpio 152 Level     11-006c
 58:     500001          0 1e780000.gpio 153 Level     11-0061
 59:     100001          0 1e780000.gpio 154 Level     11-0062
 60:     100001          0 1e780000.gpio 155 Level     11-0064
[   88.832861] [<da8c4f2b>] irq_default_primary_handler threaded [<ac7ce979=
>] max310x_ist
[   88.841725] Disabling IRQ #57
[  175.370303] [<da8c4f2b>] irq_default_primary_handler threaded [<ac7ce979=
>] max310x_ist
[  175.379166] Disabling IRQ #59
[  262.242889] [<da8c4f2b>] irq_default_primary_handler threaded [<ac7ce979=
>] max310x_ist
[  262.251752] Disabling IRQ #60
[  369.903466] [<da8c4f2b>] irq_default_primary_handler threaded [<ac7ce979=
>] max310x_ist
[  369.912332] Disabling IRQ #58

Thank you.
Usha
External recipient
