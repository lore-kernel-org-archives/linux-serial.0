Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991621D3F7;
	Thu, 13 Feb 2025 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449688; cv=fail; b=V7cR1Nhie043nUXWl2l5TM5FMFPZ1V1SlsqTeikStJiuiNXdqMFdNMEjKC2AwyYLCmRkuT3yMSAX+AnR90H1gRPg4DYEQue4Hk9IBmHAsftGkRJ2xw/ywGMOgRmZVlpNb/kU1QQd6gjfMk2Vt18eVFLuWXkp0PoegNs7oSa2nN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449688; c=relaxed/simple;
	bh=cEH9sRJlqLB+fmq9O91eES0i3PeotGDLJEsXjOxBIlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gyvv5lkLA2RXBpdj/v7NXccHJTbrvKp5CQ6mJKXoWfHTd+QJscUbOf+H4YmN/R4r5nFsgL+nsXPNiNrEwJ6saEXvk6IzytfjHJCln1AnAwhdDpWBjSxPMNkvshl81RDsy+CMIsnWYurKXsJIj8CDDqQaB53BAwMR6033DHxaWuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SXTLwBmd; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SXTLwBmd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyOLTCbXD0AUJ41H+40gBUIvJG97UhaxRdEfJm644djvYbq9IqyHugRMO9lWT7wLxKSh5dlvBPQEDdXSff2nGX6LoT3wuvIJhJz+BQMEk2lVMl/F+UmZ09hnM+76jcGZvdRRt36+XF/SCvCDPy9rDpfHhaBvH9x1evl6Ds3fRAYmAe7YxnZl7StJHFSvYE8RN1ZU1gdT+J6iA/qM021m1gDEQ4cgAT9rVOsi9NjsjC+8MJh9kVth3UUpCLozF5ysqPU5iR4k4uSgyJcheDDzP6gGhTv/NDaqZ8DlenuUD/3eGqivjbwPjOSWRy++23Ras84EdMLKM9imryGYP+oGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEH9sRJlqLB+fmq9O91eES0i3PeotGDLJEsXjOxBIlo=;
 b=D/diAtThTnGrt2JdVp30kSDUowQkGrUV29OOIyDk6e8BReXnSRc2CijcKyviTx8FQngb6IkfR0GtfdWl2lmUGnlrHX9ZdtcuwskSQQssWlObRgvsVdatjdF/Aotw2KHHteq+XMZVhsxtQfm7n5tVcT0VLUr7xNM8ntkmxGvX4JqB6MCUqZ8DeIxAw+1JK7ZHgdHZ74mNWuac7aC95BO/8RmKIzpG7XtmC8WP2W33/w/AwzGhD6+mLIxQOw71YHAhkE6ICaCUws1hDhYLLER6pnNEXsuWnEWHyTvFfu5pQ6lNGQiIpGtwqjxIAyyNJaaMdY5GkHawOLZS3c8JLph7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEH9sRJlqLB+fmq9O91eES0i3PeotGDLJEsXjOxBIlo=;
 b=SXTLwBmd5XI9/DKmNEcLbV6oSlq8AcwqlvTMmJDKNxpsYKW56svX1lBtGjVlhhDHWoR/6cMUDOjw9hB62bsujbwtBcB3/JK8vx+dVakASlYVgYokjsXG4WHs+fkSFv71TbIzJNq17pkYAXGoXk7oQtC+U0CQ9MRKk4VZiVhyo418TZJ+MvOGMAdKesa6OGkJmt+0ajSUda0QNJaIjUn8HJbyCmHYnXcZ5sqeiFeDCvkbjKLncbizTa3N9p0J/jOzS5BRvdXcGDmgOO+cSXL0FNAGNRDX2TgQ9ENOYUvFtx7KHl1Wk8YcYwkmtU+bQKp1dEzVsa67+m9mgC+/4WPqUQ==
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 12:28:04 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::1770:161a:675f:7861]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::1770:161a:675f:7861%4]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 12:28:04 +0000
From: Kartik Rajput <kkartik@nvidia.com>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: Jon Hunter <jonathanh@nvidia.com>, "robh@kernel.org" <robh@kernel.org>,
	"robert.marko@sartura.hr" <robert.marko@sartura.hr>, "arnd@kernel.org"
	<arnd@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "hvilleneuve@dimonoff.com"
	<hvilleneuve@dimonoff.com>, "schnelle@linux.ibm.com"
	<schnelle@linux.ibm.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] serial: tegra-utc: Add driver for Tegra UART Trace
 Controller (UTC)
Thread-Topic: [PATCH v3 2/2] serial: tegra-utc: Add driver for Tegra UART
 Trace Controller (UTC)
Thread-Index: AQHbfWAxahR/yn7oCUOxvUw4vBkqkrNE8iGAgAAN9ICAAAR9gIAADNkAgAAZSIA=
Date: Thu, 13 Feb 2025 12:28:04 +0000
Message-ID: <cf4f7b915a2777cbf447936c1b13d30b8a1bd51c.camel@nvidia.com>
References: <20250212104132.61060-1-kkartik@nvidia.com>
	 <20250212104132.61060-3-kkartik@nvidia.com>
	 <Z6y5vRGyouZsQWyj@smile.fi.intel.com>
	 <ec06322386adbf4404e2fbc5d7656e3465eb4320.camel@nvidia.com>
	 <Z63Bk6sgQryG1pFK@smile.fi.intel.com>
	 <88a54c9bf88dac0a3316224b08d0e2378e8fc6f0.camel@nvidia.com>
	 <Z63QHvayYRS0U8Ln@smile.fi.intel.com>
In-Reply-To: <Z63QHvayYRS0U8Ln@smile.fi.intel.com>
Reply-To: Kartik Rajput <kkartik@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5716:EE_|CY5PR12MB6276:EE_
x-ms-office365-filtering-correlation-id: ac21f3d7-e889-47fe-3c3b-08dd4c29dcf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?OVR6S29aaDZMcThXa3VXN3RXNnFKSkNidS8zTmtJWmxLaVBKL1RmN1JwSW9m?=
 =?utf-8?B?YjhnTFp1SUFLNmw1Y2RaVzdXWmJQbS93R3Y3UXJyaVI0TjFyVldYSVhLbXJ0?=
 =?utf-8?B?Tk1UWVJiNHFnSzg5eEs2SE1sOVZLc0ZVZHVTRXZPbGJGdHI3aldGQzFxaFBy?=
 =?utf-8?B?SDdSQjRpMWR3T09vQWRCaCtIU01TNHAyWVlCVmxNNnZUb2J2bkoxL05rUkRL?=
 =?utf-8?B?UnlBZHY2L0JOdnpkZmVjMTZWL0U2TGs5TS9HaGtFTDdYbWRmYlRPM1RRYkJ5?=
 =?utf-8?B?bVNCK2NCYnJsUE9uY0tNVzFabzdkNjZzTVF6WmEvQ3dIbC9wTjNWSzFaMjZk?=
 =?utf-8?B?ODVZWEVjMVhIRnpZZU8rVnVVTTB5YlR0blk2cHI3WWdoaWZtbUlPdGhJdGFy?=
 =?utf-8?B?ZWljYnFBN0p5QlVBTjBHSm1WamIrYWdIaWE0R05xTWw3dU5NVDU5U3JLdm9w?=
 =?utf-8?B?WlR5U1lGekxER292bERHWXlkWml0OTdaTHpPcDhwbUhVeTJQVzA4Szg4SXNw?=
 =?utf-8?B?T1dGM0d3ZmErRDdVN0pWMW5FVVdXOUJrU0tkMW0yRHFHSlZ2SS9ISmd6R0Ro?=
 =?utf-8?B?QUZsREQ4TmhVS0YrMTFRaWhyTTEzaDdXWVFyZ1BQTllEb0J6WmhDc2pnL0tZ?=
 =?utf-8?B?cjVpVnlqcWNJeDBHOWxaNDh1aXVvTGM4TFhITCt3V0VLT1FMTFVQcXJJUXRX?=
 =?utf-8?B?MnFEMVJoZGgwOHdnM3dFZXVDKy9kYWlKaDh2ckhmM2pJUHBnSUQrbkNoeXNw?=
 =?utf-8?B?VXYwYTlpZTNpdkVCc2hCbStQb1F4OEZ5dDQvbktVR1YrMUJHeXh0eVdYYXJl?=
 =?utf-8?B?bzY5RHIzNW1VdFBxc1RRa3FKaDN5bGR3TFJKbFpzbTU4cERxOHJWN1ZjVWFo?=
 =?utf-8?B?MnJLTjAwbnpHOVg2UGFSVHc3OE9icU5lTzBoQVcvcmtwSTArNms5RjdoT1lB?=
 =?utf-8?B?ZmhmazY2MTZ2ekdKWEpUQXZFMmlTM1FJMDAzTFljd3pUTEpEcHNxTTgxSjlU?=
 =?utf-8?B?Mi93ZFB5aC8yMytqeG5ZejVKZUdkNnYvdkl4VURxanBUdE9heWxiNi8xTmtx?=
 =?utf-8?B?ZVFEeFBJRUdqUTUzT1Y1dDcvZ0lrYThTY0VJc2NhbWdJWXJFN1ZQakJvNmhQ?=
 =?utf-8?B?bGF4QWRIM2ZvKzJ6WElvWmliVis4elJDSTN3Wk9sZWdHSnBYaldGNTRad1Uz?=
 =?utf-8?B?RUtndFZhbTZvckFXMU1oNXdnamdXQlRkZGs1YThUQThLeXZtb2dNWkNDdDNE?=
 =?utf-8?B?Ky9qQkhTTGtmN21jYm5uQlIxQkpSaFVnUHRaR3FYSEIyMWloVXAwL0tid2t3?=
 =?utf-8?B?UmlZcTRhbUE0OUNpa1UvdE5IZDF5UlNkWmJhZ1VXOXU3ZkRtOEhSNEdnRzRF?=
 =?utf-8?B?UEJOaDdwSlJYZjBzRXNxeXNmVlU1Q1FFTnlLMTNxT1Jzdy85cGkwTklMUzNa?=
 =?utf-8?B?bCtMeWJ4NkFKY2oyM2VpU0RodVY5Q0U2d0k3Q08wYW8yanF3WnRWMzE4RmQ3?=
 =?utf-8?B?Wncxa3BUMmxQcHM4Q0VXUzRMZE1pTEZLTmdQT2lsTy9SdHlyS3FBS3ZleUo2?=
 =?utf-8?B?NEtNTTlBMk9Xd2xLWURWb1AvWnU1b01ZNVc3M0ZFcVMwanJLVE5SSGgrdE5t?=
 =?utf-8?B?MEpZNDlQTjgxVVhMTW1GdnBDR1RrTE9tN3VUSm1GZnV4NUwzeVh4RXA4SW96?=
 =?utf-8?B?YzFIZ212RTVrQklEcVQ4cWpZeGlEQ2Q1S2dSL2x1a0dWOFhNN2hlYTRxR1Ex?=
 =?utf-8?B?dmE4Qmp2RUtpbnlyRUQ0MFBaa09pSjNzU2RNOFQrdzVnU2p1NmlwY1h6Yk5i?=
 =?utf-8?B?RWthOWt3dVhHQWpsYmdzY21DdW5CdmtmMHo3YVBUUzFvZ3gyajltQ3N6ZVRU?=
 =?utf-8?B?SzhMU280KzlIbDQ2YmpSTUVHZGsyUkFaRkIwMWNJVkZsZHVvcERyb2pEVlpD?=
 =?utf-8?Q?9PLQpTsiOKemQxCkRDEK6CCs1tpIHNMs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODJZOC83YTRzcER0MmNBTHlrTmdONE9TTkxWSTlvMWlPbVVWeTJPVFpieEpL?=
 =?utf-8?B?cUFmcXY2VnRNbEFyR3AwUFUyV0ZUOFJxNVltWDA1ekRuR3Jxa0ltZDFFR2xN?=
 =?utf-8?B?MXFacU9zaDVkUFk0bXVpc2NBdHl1eXRTREVZZEpjSnlSRlJkS0d2cGRDUmk2?=
 =?utf-8?B?VWQ3WVFMTjRENkhoUjBTMkhUS3lKSDlQbDBoY2JXOEc5NFZFeVFGcXJ0aHRY?=
 =?utf-8?B?alRocnlSSFozNzREMHR1SFczRVdWQ3YwQi9sYmRNVmM5UXAybXBVdXZ6a3Z4?=
 =?utf-8?B?ZHA3OVgwd095cFpoMzNFS0hXQXRvZ2ErYnUrT3dIMURqS1A3VGZ4R0IrbnQ4?=
 =?utf-8?B?dm4rMW1PZ04yTzAzamdyRjU2NThuakVRck9lb1ZKU2lIMHVnUVBCbGVLbEZ0?=
 =?utf-8?B?R2U5VjRTUEhmVENBMmFidGhtcTJkV0Jya0pJdHo5RkVpam9mSEpJdUVkMk9v?=
 =?utf-8?B?OU96TkJiYm15c3pBMnJoRzVIaUgrMG9rQjRwa1FRN0JBanhGTHo0QUt6Zysx?=
 =?utf-8?B?VnNhRTR3NmJuZEh5M3pKQTRKZnd5UFBkMDkwam0veEl3dS9HUHVucys1Z2hS?=
 =?utf-8?B?YjZGU3hTdXBZZ1gxUXhMbndlZzlCVkRCNEpwSGQ1enp5dUE3dzBad090NWN4?=
 =?utf-8?B?T3o0UjgyUUsxZFA1aG9YSGNiQjFJcnl6bTFqbW9oYWtJQ3RnVnpXNEMvNmt6?=
 =?utf-8?B?Q3A5VmJUY0hmV3R4bFZ1eEQ2VDB0NUNGRGIwNHFkRnJNZ1V2dkdiRTAvS3BZ?=
 =?utf-8?B?MjhzQXowSVI3UzJLUmxLQm9VdlJuMCs1TjJUbXBlS0E3cW9rT0NXZ29ldlEx?=
 =?utf-8?B?enk2ZlNNazNlclhHcUlLVUdtTTBZWVZ1UDl6VVFQYk5QMUR1VFpDS3VGS2NM?=
 =?utf-8?B?SGdxYlJIenEyVHZ3TmNXSHB1SlFldzZUYXNTN3dETHUxSENVV1VMd0x6WVVN?=
 =?utf-8?B?amx3bXpwQkxGQ3Z4ZnA0S0NNc0pYTTlrdHVvZXBJNVhrMjNCbFBXTzRFNVFq?=
 =?utf-8?B?QmloQm1HMXZjN0U0VmZLTUY1K2ZldWhMaURSU20ycTEvd3owQUtBZzNxRHVO?=
 =?utf-8?B?MHJrWWZlYmlGNzV1WXFWdDhYaVNEaWQ5RlZ6elA1SjFranNweUxVUlJtZHhW?=
 =?utf-8?B?RndOZjlkRklnOFZkRVFiMGh3U1lGOWdONEtZMDNRUkY2c1pDZUZma0hoKzJQ?=
 =?utf-8?B?K2t6ajk4L251NFhGNzVKemtRdHpXb015MVNDT0pueHM1bFEySkdKNVNlcHJL?=
 =?utf-8?B?b2srbGVNTXAwcmFIUGFlNnJGN21GVjU1TE9zNEJ2M2NGVmJuREdYRDBWM3ZC?=
 =?utf-8?B?dlZEbXN6cmQ3TU5qOHZpdXE2cGk3dVJvYU9BMFEraTM4Zzd5Ui9JY3lBRkgy?=
 =?utf-8?B?RTMxc2psRHdPZDdaam9SRlB6bjFIam5BVnNQbGphWEMrRXVMU1ErNzZJdzh3?=
 =?utf-8?B?Y2dEeXFFQXN0S2Z2YWZaM0ZYS3dTWFJsOHdiM3pXV2x3UGtyYkVZRlFJREhw?=
 =?utf-8?B?bDAwMmhxVE1IQ1RlVGE1b1BTbER1N1JQR3IwdFFORWxVUC9aaTVvL2VQbCtD?=
 =?utf-8?B?cm5OK2RhVEFvZlJDWVNxTExBU1RVNzFMZDVaL1pmNkU4dFpVV3lWR3hRVXFN?=
 =?utf-8?B?cWhONm1lL1EzK0ZiYTE1SEFBRThUS0h4dVZXWE9xdm1hb21vZlJYalRWRXhN?=
 =?utf-8?B?em1lODYxdVFPUWgrNVQxT3YwZG84N3J2MDQ4WFlsZ3J2V1d6YnRseU43SE1E?=
 =?utf-8?B?OHBJdnFHVlJvYzY3TUdxR20xN2xRanlhaFdsT3A0T244Rm85a1h4MGZHOXRE?=
 =?utf-8?B?emk0ZWFSQ2lrOWtsSEtmYjFhS3dhMG4vUWdGMDV5cDdpOXpXTlZvTExzQ0ll?=
 =?utf-8?B?TlFnZEZTMmszWlpYQ3RzSlpmeDZ4QXpJUFhqQTUrcGZZZk45bHR6NDRVaGVK?=
 =?utf-8?B?WlhwanhDMWNyaW81MnlpRDRqU3M5Y3EvcnFKdkF4QUUvNFhMWXNhS2cyclo2?=
 =?utf-8?B?U0RvV2I0SGp5QWp3NW1iQ1kxRjhob3pHUUsvWXhZQi9oTUgrdDZway80bXBu?=
 =?utf-8?B?NXpoWW1nQzBhcWZxV21qa0NpUXU3WEJkTFVuNjZUL2hlc3QyczlFNldmTTc2?=
 =?utf-8?B?OUxDc01FTVB4Q3IzUlM4ZkNRNW80aXlsaWhxQWlEWSs3Y0lLcUFHalBXbi9p?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <247FD1BE0E200A4B90DC221975DF62FA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac21f3d7-e889-47fe-3c3b-08dd4c29dcf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 12:28:04.0347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZYJ8vFymDmCTzb+8HbE2kog/BPuV9WG3UD412ojuf3JGDSk3RFAy9PCSL+G/TLq656kqrir9uBEW+6J0p2vvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDEyOjU3ICswMjAwLCBhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20NCndyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3Blbmlu
ZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIFRodSwgRmViIDEzLCAyMDI1IGF0
IDEwOjExOjM2QU0gKzAwMDAsIEthcnRpayBSYWpwdXQgd3JvdGU6DQo+ID4gT24gVGh1LCAyMDI1
LTAyLTEzIGF0IDExOjU1ICswMjAwLA0KPiA+IGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVs
LmNvbQ0KPiA+IHdyb3RlOg0KPiA+ID4gT24gVGh1LCBGZWIgMTMsIDIwMjUgYXQgMDk6MDU6MzZB
TSArMDAwMCwgS2FydGlrIFJhanB1dCB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCAyMDI1LTAyLTEy
IGF0IDE3OjA5ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gPiA+ID4gT24gV2Vk
LCBGZWIgMTIsIDIwMjUgYXQgMDQ6MTE6MzJQTSArMDUzMCwgS2FydGlrIFJhanB1dA0KPiA+ID4g
PiA+IHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgIGZvciAoaSA9
IDA7IGkgPCBsZW47IGkrKykgew0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoIW5iY29uX2VudGVyX3Vuc2FmZSh3Y3R4dCkpDQo+ID4gPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4gPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVhZF9wb2xsX3RpbWVvdXRfYXRv
bWljKHRlZ3JhX3V0Y190eF9yZWFkbCwNCj4gPiA+ID4gPiA+IHZhbCwNCj4gPiA+ID4gPiA+ICEo
dmFsICYgVEVHUkFfVVRDX0ZJRk9fRlVMTCksDQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgMCwgVVNFQ19QRVJfU0VDLA0KPiA+ID4gPiA+ID4gZmFsc2UsDQo+ID4gPiA+ID4gPiB0dXAs
DQo+ID4gPiA+ID4gPiBURUdSQV9VVENfRklGT19TVEFUVVMpOw0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IE5vIGVycm9yIGNoZWNrPw0KPiA+ID4gPiANCj4gPiA+ID4gSSdtIG5vdCBzdXJlIGFib3V0
IHRoaXMuIFRoZSBjYXNlIHdoZXJlIHRoZSBUWCBGSUZPIGRvZXNuJ3QNCj4gPiA+ID4gY2xlYXIN
Cj4gPiA+ID4gdXAsDQo+ID4gPiA+IGV2ZW4gYWZ0ZXIgcG9sbGluZyBmb3IgMSBzZWNvbmQsIGlz
IGhpZ2hseSB1bmxpa2VseSwgZXNwZWNpYWxseQ0KPiA+ID4gPiBzaW5jZQ0KPiA+ID4gPiB0aGVy
ZSdzIG5vIGZsb3cgY29udHJvbCBpbnZvbHZlZCBoZXJlLiBFdmVuIGlmIHRoYXQgZGlkIGhhcHBl
biwNCj4gPiA+ID4gd3JpdGluZw0KPiA+ID4gPiB0byB0aGUgVFggRklGTyBzaG91bGQganVzdCBy
ZXN1bHQgaW4gYW4gb3ZlcmZsb3csIHdoaWNoIGlzDQo+ID4gPiA+IHByb2JhYmx5DQo+ID4gPiA+
IGFjY2VwdGFibGUgaW4gdGhpcyBzY2VuYXJpby4NCj4gPiA+IA0KPiA+ID4gUGVyaGFwcyBhIHdh
cm5pbmcgKGRlYnVnPykgbWVzc2FnZSBpbiBzdWNoIGEgY2FzZT8NCj4gPiANCj4gPiBJIHdvdWxk
IHByZWZlciBhdm9pZGluZyBhbnkgcHJpbnRzIGluIHRoaXMgZnVuY3Rpb24sIGFzIHdlIGFyZQ0K
PiA+IHdyaXRpbmcNCj4gPiBkZWJ1ZyBtZXNzYWdlcyB0byB0aGUgVUFSVCBIVyBoZXJlLg0KPiAN
Cj4gTm90IGV2ZXJ5IHByaW50ZigpIGdvZXMgdG8gVUFSVCwgYnV0IHRvIHlvdXIgcG9pbnQgdGhl
IE5CQ09OIHNob3VsZA0KPiBzb2x2ZSB0aGF0DQo+IGlzc3VlIHRvIHNvbWUgZXh0ZW50LiBPZiBj
b3Vyc2UsIGlmIHRoZSBIVyBpbiBhIGJyb2tlbg0KPiAodW5yZWNvdmVyYWJsZSkgc3RhdGUsDQo+
IG5vdGhpbmcgd29uJ3QgaGVscC4NCj4gDQoNCkkgYWdyZWUsIGJ1dCB3ZSBzdGlsbCByaXNrIGZs
b29kaW5nIHVwIHRoZSByaW5nIGJ1ZmZlciBpZiB3ZSBhZGQgZGVidWcNCm1lc3NhZ2UgaGVyZS4N
Cg0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1YXJ0X2NvbnNvbGVfd3Jp
dGUoJnR1cC0+cG9ydCwgd2N0eHQtPm91dGJ1Zg0KPiA+ID4gPiA+ID4gKyBpLA0KPiA+ID4gPiA+
ID4gMSwNCj4gPiA+ID4gPiA+IHRlZ3JhX3V0Y19jb25zb2xlX3B1dGNoYXIpOw0KPiA+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIW5iY29uX2V4
aXRfdW5zYWZlKHdjdHh0KSkNCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgIH0NCj4gDQo+IC0t
DQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCj4gDQo+IA0KDQpUaGFu
a3MgJiBSZWdhcmRzLA0KS2FydGlrDQo=
