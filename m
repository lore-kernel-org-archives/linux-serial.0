Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577721AB52F;
	Wed, 29 Jan 2025 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137872; cv=fail; b=dsDKAXrT3tgqvATq3kSOM7ryPJEMgQiBF02suyDk2NyHQ/hNaHxMH81msnhX37Ujj8tcPcaKO8Y2vWgN0K0H3ryHwT4hUev22z03+99SaF44Hx6sa1lJtva3QXqWTPI4ZRkdnidz3B9IwJtx6wvryBfF6/e7SutDNh1oJ3YKErE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137872; c=relaxed/simple;
	bh=mJyJjGupDxNgD7qvMW+EBIk0LiOmhE2+41oe7rlItIU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y9Abc6/UdF7Gzyw5pexZUdc2FtOVtejJxgO73ih9MWE19+lsn9EtQYsw7Qq7oIk+4a7JuX7y7UasvVuJrfKXFGgzceS+MEUyYCAs19UNSgOp0B5nGK2rgXWQEjXhDeR2wzvjlOFgHLC3oTbC7jHQXvMm30ym4B2vN+wUa/muWUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c3ygkjDL; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c3ygkjDL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiVzsQnrzMn9nc3+8haAvVHdGwadeSVSjwSWMFJ5bGDftTXQGMHQMzxAC2PsMKvQo86PTA2KBte/pS7hYyYVwFoyu92yYNdVrnKrojlAB6AzXs1P7QmUZSi5hjzRzIz1yKei6UilzLLKyf8CG3f5AKBrE9JS0VnJoMLg69cbQ28ilUtICwrEHXEGBHCmL/qoxiWmgtzQ8EXh7SmsTib09SSGCqC5QmAI7dPWOecrc6PIdSzz5fzsmxSn+8uiTs2R7FiES2sNzobvbX+F70tyqSANZFVHdeZ71hOJivtPiI/s0TC7EW0OgDTbV1yzWL/4ZodikmeWM524kjdvnvHBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJyJjGupDxNgD7qvMW+EBIk0LiOmhE2+41oe7rlItIU=;
 b=L3wCeWYMy6KcH4BOL/DkmGXknL3edOzGytf85xHVT+FTCzDs7W1F4j8FRfB2408z4rO7OEE4+qDFGkdDS0wDu+YZlAV2rzq1nR3093CmrrneFhGD9jaPw5t0StrIrbG/FmKAv1sim8sA+Fk0dVLKlRlp62ETqwEF97VYmtLTI/TqPOS4Vv7EXc9m2llYtf+8mzhLJCLe6H0NkbH3N5KE4pPw+a6Gv9GohejOI7143ytBc514GOls+fRH/0z5tiLI399q7OzS6oHdFevK+MG1/Y9IU579ODIz09uy+HnL2zevAGAgUyQT7sy8PnZDmuJejcN7Lhf6Pducjy9pbwY+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJyJjGupDxNgD7qvMW+EBIk0LiOmhE2+41oe7rlItIU=;
 b=c3ygkjDLE+hVH6hiEJX51KapoPEQPi9kLgS2z/GV+tjChDFeSg67eXKGTjvi0Bxsv9dhF0F9eXnVeNQJ0JWvZO4ajSHgS8LtNpAZsZ2/olcDl56Lc4XaLKJGmO1vlOyP+aiJ/PpOSmUaLqAEdDfX1VxF6IySSMyxuz82MrhpoLAudLqWEEbU9C030DjpcIn3EE8zNIz2Rr/1jeF1UmGcIfahdoSC3aOK8xDStzB8o7fBzhfcpseXuXVQc4ovhVnM5ZPZYPmG561+oDok5tCqKk5Q8nGSbbvy3H3idwSsW2y9oABUY1FL58/nRmOWkA0EnRmsOiMF2gEIMVb4TPKF+Q==
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 08:04:27 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::1770:161a:675f:7861]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::1770:161a:675f:7861%4]) with mapi id 15.20.8398.014; Wed, 29 Jan 2025
 08:04:27 +0000
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
	<hvilleneuve@dimonoff.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "schnelle@linux.ibm.com"
	<schnelle@linux.ibm.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 2/2] serial: tegra-utc: Add driver for Tegra UART Trace
 Controller (UTC)
Thread-Topic: [PATCH 2/2] serial: tegra-utc: Add driver for Tegra UART Trace
 Controller (UTC)
Thread-Index: AQHbch1sVgAcYS714UGjzFwJBtbpM7MtZIyA
Date: Wed, 29 Jan 2025 08:04:27 +0000
Message-ID: <101d68c9789ef774c242d038a51b35113e6fbcc0.camel@nvidia.com>
References: <20250128064633.12381-1-kkartik@nvidia.com>
	 <20250128064633.12381-3-kkartik@nvidia.com>
	 <Z5nTm9UniwCgGNOY@smile.fi.intel.com>
In-Reply-To: <Z5nTm9UniwCgGNOY@smile.fi.intel.com>
Reply-To: Kartik Rajput <kkartik@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5716:EE_|PH7PR12MB7162:EE_
x-ms-office365-filtering-correlation-id: 0eb086cc-a21d-412c-8aca-08dd403b8d1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzdJbG5icEUrS2pCaW16ZmxRTUg1Y0p5dlpvdjRuWVArN2tSRUNiNjdlekNX?=
 =?utf-8?B?dmIydVpHQURrSWZFWG8rakdlS3MxdG9zRm1tZFRjRGhUb2RNUm9xa1QwSmcr?=
 =?utf-8?B?UkNrVkxRWGxSUVpwVXQ4aFpybW1TTWJJRlE5UktCajA2NzZseUNUN2N4bHpS?=
 =?utf-8?B?bDVqdmkzazE4SFZ6QXlvUURScm8rdU04cGFtTFEvZUx1QmZiTkY5dVp1Q3Bq?=
 =?utf-8?B?TEEzVzMzR0RYNTNpYmhDU3FTMXB1NkZwZ2pCU0FSSVlUVDdPbU1kYytrZTFU?=
 =?utf-8?B?YlFtbzdWZFkrdW9DQmt3UkIyZ3FVOWpRbkZTOVQxTDJEdHB4ZFBlV1ZITDZY?=
 =?utf-8?B?aitNVWRCbWlqTU5MYUdxdHlIbmNxSlpXUEcwZG1WT0R6SUlKTDFBbHZBNFda?=
 =?utf-8?B?cXFXaXRXcFVZOGZmOWhsbGtxUTViYWt3VTB2VUloMCszUzI5WHZ2T25ka0Rv?=
 =?utf-8?B?NlE4UE1veUF0d1QycnRJZUYrU0FOWVFZbXROa2daMEpleENkUFFUd2NLSEVU?=
 =?utf-8?B?ZmtnWGJxZy85ZWU2NFY0Y2U3RG1VSzNDQVFwUUJUSEdQd1dFRUpoclRiUHZv?=
 =?utf-8?B?bWI3MHBjWjlkeTIzcmRDRENpbDNjK2pBa2FRK3VraGhZSlRVWTdhV0xFUDVn?=
 =?utf-8?B?QTBZWWNLVmJVNHJ6MnQ0TnlKOHFxMm1jdjZKY3BoK25LNWY4SmJHRGFHcnZy?=
 =?utf-8?B?b3BkKzN0bU5qc1ZFVTE5TFBjYzV6UW9CQTNHYmwraS9xTmJqUmEvMnFFdS93?=
 =?utf-8?B?YUdRc3Z2WEd6TlY3ai94T2R4akw1ckxRbmk1RGVNVTBLK1dGQjRkSkZaTzVx?=
 =?utf-8?B?dWFPZzZWQVNEcE9vbG9TejhrUE1jUisxS1lVbTA2WXRuVi96a1FXc09KN0JV?=
 =?utf-8?B?WGI0aURwMzdSRTMzajlUdlc3WXZiaGVaRlIrSkJ0cDkrVkp6Z1dGdFpNVzJ1?=
 =?utf-8?B?dVMyV3JBNFk5ckxZRzNtbUJURms1WXI5NEZzV1d2KzFtSjB5anp3NXpZKzEy?=
 =?utf-8?B?Q2t1c1I2OTl5TVFER04rS1ZoZlYyZUlTV2xDSzlYZGJraDNxSWNINVFqTWNB?=
 =?utf-8?B?aHlhemZISXAzNnZLaTdROW44WEptRzFpeWRONm9UMVBHbGo4dWRValUyTDhB?=
 =?utf-8?B?STFmYjI0SGEzbjBQd05GaHQ1SUhXTGw1R2tlQ1lTcTc0YWw4bEdLWVNwZzl1?=
 =?utf-8?B?cGJURWF2cnk0bTF2bVYyeGNSYjFjdFRmMjVqZ1BDcUsvT0NKMExMeEYzTzRi?=
 =?utf-8?B?YmtkdzQwVTVvL21vSWNvUlM1eC96VVV1enlDS0owRGRSTWk2WjlqTE5ZYjli?=
 =?utf-8?B?UXRZRlJZMElKMU5CUFVrY0xhYnVTUkxRVzgwNGU0WmRBRE5BeHBYOXFZUERT?=
 =?utf-8?B?aTVNbngxaTFCbDN2Y3NDWEZtZ1V3RUhmQlcwZTVmUHJuT25WVlJSdmVXQjdT?=
 =?utf-8?B?MWthYm1UajFRQ0dZVW9pa3NyYzZndnZSYkdoMW5WZHRxTURsa1hHcDhrWElY?=
 =?utf-8?B?LyttRm1VVDJQaDBhRTRpZ2hVU0R5T3lMQmZ0NHhHR3VtVmhlUEo1a3MxakZv?=
 =?utf-8?B?czQ3SEVhRE1Xb1FxMFdMNS8xQjAyL253bkp6Si9iTzJTbU54cWpwc1VNSGxa?=
 =?utf-8?B?dno5NStnSkMrUXQzelJrSk9yNGdXMjlsa1IzaDJzMFoyR3pXZmNtOTNWdzQ1?=
 =?utf-8?B?Ni9FaUMrZTU0eURXcGRTNDYzWGxPK2dHWVRJalNuaUcvN2tKNU9kQ1FJckV3?=
 =?utf-8?B?UlJ6eUFNNlBSQXFmczNrVURZcldMTFZaUzRSWTBPZ0RTWjBjZ3ovNWMyL0Np?=
 =?utf-8?B?YmxoTlMxRmVld3MwRmtYTnFZNDRWTHNtMnJSbTgrT0ROL2h1SXRYalM3aEZo?=
 =?utf-8?B?VXhLdXVZOHN0eGcrelVKa2oyKzR6dWJuNnBNckpLUC80bWNuYi8zMFU0ZW9I?=
 =?utf-8?Q?Np7yzhM9KyQkXlUPMsO/YZS4WGClX68m?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OG9nL0hBbGQ3K1A1WGVYd3hrRzVzN1BOR2lxeVBubWJ1SkY2UndTSGtBaFVs?=
 =?utf-8?B?bXVtRzFmY1J0ZFZXOEhJc2llcmlYN0xDVmgwQVZST2NJeVNaRVBKWDlRYzJN?=
 =?utf-8?B?SmhzVU1kRTRubzlBUTgyNlpTeE9BWTZBRG5ZN3J2V0hmZFpTOHhDWTdJUGlQ?=
 =?utf-8?B?RXlGcysySFdIbFFmRnJ0ekxTckxubzhnRit5QjRlamFJenRDaXhTcU95U0hO?=
 =?utf-8?B?MndxVFhzZER6ZUhza043U2dKaFVwYUlhazdrQVVKV1ZZMEtKa0E0SmY4enAw?=
 =?utf-8?B?TldnVkZ2c1lENmlwaGJWMUhmWnpaa2paZW1xT01Oc1BockFIUUY0dmM2Vkdk?=
 =?utf-8?B?NUxSSFlhTXQ3WjkwMTNKaGRhaDdhdE81bVA2WVorTUpacG54ZnNLYXFTM29a?=
 =?utf-8?B?Ny81K1RGbzYvNTlkTkZBTVM1OUg5b0lZemYzcGFTcFZVWkxLN1RpaXMxMy9J?=
 =?utf-8?B?b04rQnRxSnRtemNQcS9MQUp1Y1dESWdCb3k4R09sRVJUWE1xREFtMHJ4SGl1?=
 =?utf-8?B?MkJOZ0hwVFhjTXpTcUd4OGxTaDBsTnhERzNpTGh5TG11THpPUlZ2ZnlVc1dX?=
 =?utf-8?B?K0hxQWpiSzY1dzFHWXZycllkbS9LWVBnellHUXpmaXhTeU5ROFZ0MkxyVW9S?=
 =?utf-8?B?R1BxdkplRFJWcG15WUc0cWwxd05PUjZEYllhTkYxb1E1YmlkenFmY3pUaXdJ?=
 =?utf-8?B?Tyt0UHFPV3FFUExTdm13MUZsWXlhUDJpRENyUElMSEZjaTJEMlpDV0FPSGoz?=
 =?utf-8?B?eEwyeG1WMDZLc0gxVUd3aGtkSTgwZ0F2R1BVOVBRNUh3SFNaaDFzMFBLcHdL?=
 =?utf-8?B?UnVSNGo5Tlp3Q0hTdVBSY1ZqSnQvZ3M0RW1qWlBRQmlwZXlsN0trYjAvRXlZ?=
 =?utf-8?B?dFlCZDVucDhZZlV3VGdULzNhQ3pwdGlWMUhHUjFJcmlVQnZ2bS9GQm1MSzl4?=
 =?utf-8?B?ZitWbHMzOUs1YzhOeVZuL1ZSR2xmdm9IclArVnp3VDRJYlNRWWZTbCsrR3k0?=
 =?utf-8?B?TFdGQjJzNGdXSEUyYUVKVVN2ZkNicUZldCtxUkg5eFRMS0pueVMwaklLeHRv?=
 =?utf-8?B?dkI5eDNTc0c2SStKUEJLeDFQU1NITUYyOGc0aC9oN013VnVQcDNCYWtFSU9q?=
 =?utf-8?B?OGdSaHNndEs5Z1Z6b0doSkRzZTNqUGxjWE5hZGRVNkVqSnNyUnFpK2NmMHJr?=
 =?utf-8?B?S05FYi9SSk1qUzhCZGExclRkSGUrbCtiR0JRaUxHNFFKNDRyNCt1bUtjYjJt?=
 =?utf-8?B?eWd2MWozNVpSSGNkMjYyRUNxbUpoZFF1cFdyWU4rcGVGL3FncXM5dmhqUzJa?=
 =?utf-8?B?Y1lxNUd4Y0JOb2I2VThaRnJYTkdFa283Nm5tSzJqeGw1amJ1OFZzR0JwaGVE?=
 =?utf-8?B?L0xPcDJ5VmpsZGxabFRBRE05dXUzMWFGeE5xaDRIKzNJNXVQTUdBcUdJOFFU?=
 =?utf-8?B?aUZjK0F3SmdMcWVoaFduV3RIZVNrMFZRZlN5L3VlN0trS29TTnlyaTdKL2lv?=
 =?utf-8?B?NW8rMnhqTGF3TnJaL1NEMm9aQlAvaUNYTjVXeDBDRTRXMlREaGhXQmZFbDVY?=
 =?utf-8?B?WjZUeEtNVmhqaS9XVXEzNU91dFRLWEprbWthdURqVlpobFhXeUR5cUg1SmdF?=
 =?utf-8?B?QUUrUGhWQVBXekREQnhPT09lazVHdEJ3T1BxeUV4d041NEZwUzNacktCK29Q?=
 =?utf-8?B?N1Y2T3JPNEM5QUZQYXV2RG9xUlZtVlpHazJYWmYyN2VKdCtCSlgxeVpIVlRF?=
 =?utf-8?B?YmxIYVN2VGVPeGovVzRnREM5aWFHWlFpeVR3YUdmQTA5K3lGZ2JvRlRVb2h5?=
 =?utf-8?B?WnBqUVNiU0pXQlNsSjliNHErL2dMWGtWV0VPdEtHRUhPeWE4RjhyeWFPN2ph?=
 =?utf-8?B?NUpXMFhqL294SXRoTExmSSsweXRQaU1FNWZ0ck85SnVHTE5SMUlrQnI5UEtM?=
 =?utf-8?B?QjlUWDc0eUpiMkFiT0tiYXEvdFFmdi9IU3NFUWUyYzRkQXd1ZGpvTFAzam5K?=
 =?utf-8?B?cUQ4TUVyRmxJaHNJemZWOTJnRnJTaUVNcUR1eFhCdkNUdzdQRW1sWHIvbHNh?=
 =?utf-8?B?REF6dlNSNW5pRnB3ODhGQU9TMktYYit1b29wRThuWUZSL2NhaUFjQVJpUjZ1?=
 =?utf-8?B?Y25Zam9vWVFMYiszRTJyQlJIa1pxbW5ETms4aVkzWDUrajFQS3hjdjJmYnhP?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AA31E7A6A5C2B4984170D3C06A699E6@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb086cc-a21d-412c-8aca-08dd403b8d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 08:04:27.0671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/etfBdpCNIRADylBVAI3vLAVuiv2Jhd8dgFBoA0HS5Gwusf7YUu3BLloWFraRHRb4ADsPm6gJC/FognIgDr+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162

VGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIHBhdGNoIEFuZHkhDQoNCk9uIFdlZCwgMjAyNS0wMS0y
OSBhdCAwOTowNyArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFp
bDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9u
IFR1ZSwgSmFuIDI4LCAyMDI1IGF0IDEyOjE2OjMzUE0gKzA1MzAsIEthcnRpayBSYWpwdXQgd3Jv
dGU6DQo+ID4gVGhlIFRlZ3JhMjY0IFNvQyBzdXBwb3J0cyB0aGUgVUFSVCBUcmFjZSBDb250cm9s
bGVyIChVVEMpLCB3aGljaA0KPiA+IGFsbG93cw0KPiA+IG11bHRpcGxlIGZpcm13YXJlIGNsaWVu
dHMgKHVwIHRvIDE2KSB0byBzaGFyZSBhIHNpbmdsZSBwaHlzaWNhbA0KPiA+IFVBUlQuDQo+ID4g
RWFjaCBjbGllbnQgaXMgcHJvdmlkZWQgd2l0aCBpdHMgb3duIGludGVycnVwdCBhbmQgaGFzIGFj
Y2VzcyB0byBhDQo+ID4gMTI4LWNoYXJhY3RlciB3aWRlIEZJRk8gZm9yIGJvdGggdHJhbnNtaXQg
KFRYKSBhbmQgcmVjZWl2ZSAoUlgpDQo+ID4gb3BlcmF0aW9ucy4NCj4gPiANCj4gPiBBZGQgdGVn
cmEtdXRjIGRyaXZlciB0byBzdXBwb3J0IFRlZ3JhIFVBUlQgVHJhY2UgQ29udHJvbGxlciAoVVRD
KQ0KPiA+IGNsaWVudC4NCj4gDQo+IC4uLg0KPiANCj4gPiArc3RhdGljIGludCB0ZWdyYV91dGNf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiArew0KPiA+ICvCoMKgwqDC
oCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+ID4gK8KgwqDC
oMKgIHN0cnVjdCB0ZWdyYV91dGNfcG9ydCAqdHVwOw0KPiA+ICvCoMKgwqDCoCBpbnQgaW5kZXg7
DQo+ID4gK8KgwqDCoMKgIGludCByZXQ7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCBpbmRleCA9IG9m
X2FsaWFzX2dldF9pZChucCwgInNlcmlhbCIpOw0KPiA+ICvCoMKgwqDCoCBpZiAoaW5kZXggPCAw
KSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKCZwZGV2LT5kZXYsICJm
YWlsZWQgdG8gZ2V0IGFsaWFzIGlkLCBlcnINCj4gPiAlZFxuIiwgaW5kZXgpOw0KPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGluZGV4Ow0KPiA+ICvCoMKgwqDCoCB9DQo+IA0K
PiBDYW4gd2UgcGxlYXNlIHVzZSB1YXJ0X3JlYWRfcG9ydF9wcm9wZXJ0aWVzKCkgaW5zdGVhZCBv
ZiBvcGVuLWNvZGluZw0KPiBldmVyeXRoaW5nDQo+IGFnYWluIGFuZCBhZ2Fpbj8NCj4gDQoNCkFj
ay4gSSB3aWxsIHVzZSB1YXJ0X3JlYWRfcG9ydF9wcm9wZXJ0aWVzKCkgaW4gdjIuDQoNCj4gPiAr
wqDCoMKgwqAgdHVwID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZihzdHJ1Y3QgdGVn
cmFfdXRjX3BvcnQpLA0KPiA+IEdGUF9LRVJORUwpOw0KPiA+ICvCoMKgwqDCoCBpZiAoIXR1cCkN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4g
PiArwqDCoMKgwqAgcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIobnAsICJjdXJyZW50LXNwZWVk
IiwgJnR1cC0NCj4gPiA+YmF1ZHJhdGUpOw0KPiANCj4gV2h5IG5vdCBjbG9jay1mcmVxdWVuY3k/
IEJ1dCBpZiBuZWVkZWQsIGFkZCB0aGlzIHRvIHRoZSBhYm92ZQ0KPiBtZW50aW9uZWQgQVBJIGFz
DQo+IEkga25vdyBtb3JlIHRoYW4gb25lIGRyaXZlciBtYXkgdXRpbGlzZSB0aGlzLg0KPiANCj4g
DQoNCiJjdXJyZW50LXNwZWVkIiBpcyB0byBzcGVjaWZ5IHRoZSBiYXVkcmF0ZSBhdCB3aGljaCB0
aGUgVVRDIGlzDQpvcGVyYXRpbmcuIE5vdCBzdXJlIGlmICJjbG9jay1mcmVxdWVuY3kiIGlzIHRo
ZSBpZGVhbCBwcm9wZXJ0eSBmb3IgdGhpcw0KYXMgd2UgYXJlIG5vdCBjb25maWd1cmluZyBhbnkg
Y2xvY2tzIGluIHRoZSBkcml2ZXIuDQoNCkFsc28sIHRvIGFkZCB0aGlzIGluIHVhcnRfcmVhZF9w
b3J0X3Byb3BlcnRpZXMoKSB3b3VsZCByZXF1aXJlIHVwZGF0aW5nDQp1YXJ0X3BvcnQgc3R1Y3R1
cmUgdG8gc3RvcmUgdGhlIGJhdWRyYXRlIHZhbHVlLiBXb3VsZCB0aGlzIGJlIGZpbmU/DQpBc2tp
bmcgYmVjYXVzZSBJIGRvIG5vdCBzZWUgdGVybWlvcyByZWxhdGVkIGNvbmZpZ3VyYXRpb25zIHN0
b3JlZCBpbg0KdWFydF9wb3J0IHN0cnVjdHVyZS4NCg0KPiA+ICvCoMKgwqDCoCBpZiAocmV0KSB7
DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKCZwZGV2LT5kZXYsICJtaXNz
aW5nIGN1cnJlbnQtc3BlZWQgZGV2aWNlLQ0KPiA+IHRyZWUgcHJvcGVydHlcbiIpOw0KPiANCj4g
V2l0aA0KPiANCj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtZGV2
Ow0KPiANCj4gdGhpcyBhbmQgb3RoZXIgbGluZXMgd2lsbCBiZSBuZWF0ZXIuDQo+IA0KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4gDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZGV2X2Vycl9wcm9iZSguLi4pOw0KPiANCg0KQWNrLiBJ
IHdpbGwgdXBkYXRlIHRoaXMgaW4gdjIuDQoNCj4gPiArwqDCoMKgwqAgfQ0KPiA+ICsNCj4gPiAr
wqDCoMKgwqAgcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIobnAsICJudmlkaWEsdXRjLWZpZm8t
dGhyZXNob2xkIiwNCj4gPiAmdHVwLT5maWZvX3RocmVzaG9sZCk7DQo+ID4gK8KgwqDCoMKgIGlm
IChyZXQpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoJnBkZXYtPmRl
diwgIm1pc3NpbmcgbnZpZGlhLGZpZm8tdGhyZXNob2xkDQo+ID4gZGV2aWNlLXRyZWUgcHJvcGVy
dHlcbiIpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4gPiAr
wqDCoMKgwqAgfQ0KPiA+ICsNCj4gPiArwqDCoMKgwqAgdHVwLT5pcnEgPSBwbGF0Zm9ybV9nZXRf
aXJxKHBkZXYsIDApOw0KPiA+ICvCoMKgwqDCoCBpZiAodHVwLT5pcnEgPCAwKSB7DQo+IA0KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRv
IGdldCBpbnRlcnJ1cHRcbiIpOw0KPiANCj4gRHVwLiBUaGlzIGVycm9yIHJlcG9ydCBpcyBkb25l
IGJ5IHRoZSBhYm92ZSBBUEkuDQo+IA0KDQpBY2suIEkgd2lsbCBmaXggdGhpcyBpbiB2Mi4NCg0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHR1cC0+aXJxOw0KPiA+ICvCoMKg
wqDCoCB9DQo+IA0KPiA+ICvCoMKgwqDCoCB0dXAtPnNvYyA9IG9mX2RldmljZV9nZXRfbWF0Y2hf
ZGF0YSgmcGRldi0+ZGV2KTsNCj4gDQo+ID4gK8KgwqDCoMKgIHR1cC0+dHhfYmFzZSA9IGRldm1f
cGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUocGRldiwNCj4gPiAidHgiKTsNCj4gPiAr
wqDCoMKgwqAgaWYgKElTX0VSUih0dXAtPnR4X2Jhc2UpKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIodHVwLT50eF9iYXNlKTsNCj4gPiArDQo+ID4gK8KgwqDC
oMKgIHR1cC0+cnhfYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUo
cGRldiwNCj4gPiAicngiKTsNCj4gPiArwqDCoMKgwqAgaWYgKElTX0VSUih0dXAtPnJ4X2Jhc2Up
KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIodHVwLT5yeF9i
YXNlKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgIHRlZ3JhX3V0Y19zZXR1cF9wb3J0KCZwZGV2LT5k
ZXYsIHR1cCwgaW5kZXgpOw0KPiA+ICvCoMKgwqDCoCBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2
LCB0dXApOw0KPiA+ICsNCj4gPiArwqDCoMKgwqAgcmV0dXJuIHRlZ3JhX3V0Y19yZWdpc3Rlcl9w
b3J0KHR1cCk7DQo+ID4gK30NCj4gDQo+IC4uLg0KPiANCj4gPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgdGVncmFfdXRjX29mX21hdGNoW10gPSB7DQo+ID4gK8KgwqDCoMKgIHsg
LmNvbXBhdGlibGUgPSAibnZpZGlhLHRlZ3JhMjY0LXV0YyIsIC5kYXRhID0NCj4gPiAmdGVncmEy
NjRfdXRjX3NvYyB9LA0KPiA+ICvCoMKgwqDCoCB7fSwNCj4gDQo+IE5vIGNvbW1hIGZvciB0aGUg
dGVybWluYXRvciBsaW5lLg0KPiANCj4gPiArfTsNCj4gDQoNCkFjay4gSSB3aWxsIGZpeCB0aGlz
IGluIHYyLg0KDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28N
Cj4gDQo+IA0KDQpUaGFua3MgJiBSZWdhcmRzLA0KS2FydGlrDQo=
