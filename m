Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DB4C96;
	Thu, 24 Apr 2025 03:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745467057; cv=fail; b=DZ8AraWx8VPr4+Lsma1KMoOvqzdW67dB/2t0X8R9dKXXy0+RvNYqHaFs2yMPpGvDJykpAPI6IrxPBt2vcpqrAoBl9x82IRCcoP391jcwdb9eG0mpX6qq9YnjTfob0WpkJSaipuDNcJlbDobgh2T68a5Cn0Ksdty4oVb6nKcB6xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745467057; c=relaxed/simple;
	bh=xShKWRRxNlDa4Ledi7oHj142XTItSUDCGAJkTnTX6p0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fJXNab112SS4kx99Qf1qFX/NqDPTZom7E49skOJcdFvyT4DvmIDBU2Bj+HwJ1zBDkTRklX7ouiRSQ23Ptd1ii9DFyB9V6g2BZ9Wm1b9B5UWEa1FzQbiyNsOdjLo9rBK/5eLHhSsLyCae0EdMnoG7zsqk3l32R8Tt0bhXAWa9DK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V9ioBlxn; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V9ioBlxn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y21StPE4+yvHYGqlAnkCKJw4WsYqg4padQYacdtjVs2AK401qHRtxn5Ea0eCjqnC7eOSf+PU0eRTBku9Kg2K+yNHf/ymH6UNRKXz+9IXgSb50drwh5hBBskeBmb1TD+9BrJ4zTbf1XVEUGpicBrbyPhwgL/jqn1XZikZwFwr+osrnIIorwQ6xrUEy2UjgbIpu2AX79VxeyXoJYRF570BZtP1znZTEgteBeed/RJPQdmwT80Azpa+dNRIiFcmB6FJY6O9w1NEBPdZKb3Poh57oT5uEmMa3x/bdGRaLPxYs/LUkekDof1T2Qb75U3iuL+oA2P80uyTmxJoO7jxB+dl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xShKWRRxNlDa4Ledi7oHj142XTItSUDCGAJkTnTX6p0=;
 b=Y1wVp4GQWbKN61Qd3ubQootG22QHyy3sAdt0A01mDm2qDyw6ipyvoD2r0zSFTUfR7ap/ryIMZGe1lXout/h0k4l9byaLCPCv6fwaqbh667pbvJlSacl1jdm9ysIo9T0gQ15huGrcEUUKq5Zcq62/iEHwe6bjvu39btpvRq6EkakZZdjb1Y/kigI6dO53fmGy0JmPsjzRLQkZMRQkCsmbxQlfgrL/ik7+FJ0gANNL8U+HxJt6qDK1ZHm308CC0IVaWAb3FMslpurpzk94L7plbLdkyupPJwwUVzwP5ZSy7j8pw/BS8PBDwNr3RA+JqlMaVnJFmFoV4lL9n3fOWYeoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xShKWRRxNlDa4Ledi7oHj142XTItSUDCGAJkTnTX6p0=;
 b=V9ioBlxnOhtRIFEPMBjLqnjHe0Hb0ah6qyfUmCtojyVYO0ivG0ERYi/OiRZ+cFU6y2E3+FTTwmFEVs4XEUL/dC4gueWHmr40/e73lSwV9CsxTWiK4ry9uLnswKipxXNAi7gp6uXlYq3Vqu/Z3AZEmkE7EyhTtgfQDgTP0yr9b5N1yqQ+iaWZgvOjRdmgbxDdl5bZk/ci+73ghe08KW9Fv5hZ7DW80rNKgVNOyacwQq6IIiv3nqCSz70OepDLMY7/ZPduhifLeEMVsmgLAF8+Ow26pkslf2cRQLG5sXwELBNXdf0IaGo4d2Py4DOYKQYnR883gP5YwE8lHen5x44YSw==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by SA1PR11MB5921.namprd11.prod.outlook.com (2603:10b6:806:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 03:57:31 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%4]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 03:57:30 +0000
From: <Rengarajan.S@microchip.com>
To: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <UNGLinuxDriver@microchip.com>,
	<Kumaravel.Thiagarajan@microchip.com>, <linux-kernel@vger.kernel.org>,
	<Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v1 tty-next] 8250: microchip: pci1xxxx: Add PCIe Hot reset
 disable support for Rev C0 and later devices
Thread-Topic: [PATCH v1 tty-next] 8250: microchip: pci1xxxx: Add PCIe Hot
 reset disable support for Rev C0 and later devices
Thread-Index: AQHbtAGtnpYBXuNVwk6R9MPVHI6DXrOwtDmAgAF86AA=
Date: Thu, 24 Apr 2025 03:57:29 +0000
Message-ID: <52fb85019a97095c081609b4f106fe10023b441f.camel@microchip.com>
References: <20250423033841.33758-1-rengarajan.s@microchip.com>
	 <3292610b-acb0-4b72-8aa8-9eec491238c5@kernel.org>
In-Reply-To: <3292610b-acb0-4b72-8aa8-9eec491238c5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|SA1PR11MB5921:EE_
x-ms-office365-filtering-correlation-id: a0e29e15-a165-4e48-d30e-08dd82e42296
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RG55UzkwRnRnU25iRysrRlNlMk9rRmxzRVc0ZHVWUWRCYUltUzBpNFkrVUtr?=
 =?utf-8?B?MThCWDNZTm82VTM0dG9OOVg1TEorWkFQVUZwMy8yLytqRjB2dXdhZThyejBL?=
 =?utf-8?B?b2ZuZkw1a1FLK1lxTS9uajkwSzFzQ0kxdnJPRS9FWXBWSmpOU2kyNWxOcmd2?=
 =?utf-8?B?WEZSc3g2eVRTL3VpazdmTmI4aUhjUGF1bjYycmVnT3cwN0RxZDN3M05NUTA1?=
 =?utf-8?B?V0NNWk5VdDRDM2NPS3o5UHhMUDFTY29mRytZckRtZk9XWi9JMDE5dzNOUGRk?=
 =?utf-8?B?RUVySlFpdXhzU1BKdFdZamlERDFHdzlaTkMxdEtKNmcyMXRZZU9lbU02UUVN?=
 =?utf-8?B?VWk5N0t0ejRKd2ZjdzI0Z1dFbHdKekxJVXJWYjV0QTZHeTFJZEI0SHhOT2Mw?=
 =?utf-8?B?L21TYjZKc1BNelE0MHBvczFYV21TeG9kKzM5OHZKSks0Y2NLdUJDdFdRd2ha?=
 =?utf-8?B?aVQ3THZDNjBid2RQclpWbTk5SDZJdmFwWGtvWExSVk9lVGFJYWphWnpVZHVt?=
 =?utf-8?B?cE1HWWdPUlRtMlU5My9sQzg4VllkOEpla1lnWWlLMUR6eHBsNHJzYWx4S0dQ?=
 =?utf-8?B?RzJFQ1ptZGVYM1ZkZks2M1VLL1Myb0VDNlBYQlFLSER4ODMvZ2h4ek14TDdt?=
 =?utf-8?B?cXZBUkNaUXJqb0Q4K3FvUlZBWGMwbVVGeElYNmQ5eUY5Um05WXNLRXNvU1dq?=
 =?utf-8?B?RFRGWloxRXBrUmlEa3ppUHJHMXlkMFlmcUt1MUpaTGRYd3g2Tm4vY1Y4NU0r?=
 =?utf-8?B?WWt0bGNZK2NGQVdGa09TemhPUWkxZm96OHFvTzdpZmhCRjNPQjdPSFkxUmdn?=
 =?utf-8?B?Ly83eDFFbFRTUWZXWHJXckN0cHZpam5SYjFsMU1WUmFPK09RalNtU1d1VlJK?=
 =?utf-8?B?Tk9vMGFNb3hTWWV2Z0tBN2h1NzdwVkUzS1BRTjYyNWl6cUkwZ2wybFFNdHJy?=
 =?utf-8?B?NjBPYksvSVJuTUEyTHluQjhDeEg3Zk5vYVUvd0kyV09QVm1TZjFDSEk3aVhk?=
 =?utf-8?B?c0lMcjZIZlBiMEhXQUdWNkpxbTF3VHpUdXNWdi9xcHowTnA2N0VrRHFkd2J5?=
 =?utf-8?B?YThhdjJiejVsK2N1RkdwWUU3bjNMaUJsYlBFaG1xZVN2cHBmRHJSYi8xanVy?=
 =?utf-8?B?NEVhTVdhWUtxb3BCY3JrbExnUmZ5b1VkL2g0VUo0TDNpZkNZdDQxVXBKKzB2?=
 =?utf-8?B?Y285U2VUc1ZPdll1Y0MvbDBEWjRNSFUrMmE3MTU2ZE05YjdOdEZMRUdvM0Y3?=
 =?utf-8?B?aG1iVzNrNjFaN1NQODJobFhGRXJYSHZmMHNZRFd5Ry8xSnRnbldPYk1SbWJs?=
 =?utf-8?B?UHY4NWRqbUlIQ0lBZUxPNmFHUGZYWGVZemRNRm14cWM2Y1ZtRDArYUNUa280?=
 =?utf-8?B?RW1kZVpzMzY5Nkg5QnNOdmhwQ29RK1ZYWlkxNHgvcEd5akluOWlrL0FXTXRY?=
 =?utf-8?B?WTJHbEY3T3M0VzQ2OXBrdGx0LzRTQ1ArdXFLa2tGcXdWL2JNdEFOUTlhOXBt?=
 =?utf-8?B?K2xmOTJ3VEltWngvcUlzWllub1RIL1VCUGE2bVR4ekN6N1MxUUdGTXBqbmNV?=
 =?utf-8?B?RXBQZEJqdXpGeTVvb0Z2T3h6YTcyM2xTUFNLMlZWTzZ2N2pRamxwdHlwWStK?=
 =?utf-8?B?V1ZhdkxSUng0a1IvV3dYamNVMmFXRHplL0QyKzJ3S3huVTVMM2ZCam5qbHNo?=
 =?utf-8?B?blhDdE5mU1ZnQ3RYc3VUbllqdWNWVXppN1Z6Q0pFd2NXdUY0QUNHeTJLaWdN?=
 =?utf-8?B?TlBITmxRYTdwbGJ1OHQ0MVFBalJWQUtHbmVDOVF3RXFBODRYZUJ1VmUvN1RQ?=
 =?utf-8?B?TE1iWm1DVlhKUXUyWjIyRHBlcXE1RnZoeTNMT0tqWUMzaWFDMUltbncxK3Iw?=
 =?utf-8?B?VzZXVWV1YnBWdzNSUmozQ2t1VlVPSmNncWRBSStvMmxsZjE3U25keUk5L20r?=
 =?utf-8?B?M0VFWHZHalRlY1VxV3FsbDJoOVNCeWNVQzZQaXNjNnRaSXBqZkNFNHBoVFll?=
 =?utf-8?Q?TaJgG5TCYXaVJ7cvc5xplYpSP+dBOc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTNqSno1M0REWWNNTUd4VXRINEt5MVVreE9COUtjcHp2ZzhuaTFxeUkybTha?=
 =?utf-8?B?RXZXRWhoYmkvSnpIWHI0bEVHbzNScXpoZ0w4eUZNNHZ6bnREK2Jhby9RSHh2?=
 =?utf-8?B?VjNSVTBLR0tOREpFbEU2Yk13Z0NXUlFJMnNrcGJROVBlY3VHd3RVZC9QNFNv?=
 =?utf-8?B?Wnh1eGVVeFZCL3NZeVlUdnZaWXBsb2IrQkk2TzdPZWVEOTc4S1A4SkkyOXFm?=
 =?utf-8?B?N2pQQ0pQSFQzTlRFWk5RUGl3NVVSM1VQZnIwOStLYmZTSE5wVUVoNzlWNkEy?=
 =?utf-8?B?dnF6dlY2QXAzenRxQXhxSGFtUFEzTndLeXJOamxTU1VZeXEzNGZRZmdSWmhO?=
 =?utf-8?B?THlqWlRab1lsdmM1WlZaR2tMcEdRVEFLcGlTZDAyWEtWbWhWbTRrRWNGcFZO?=
 =?utf-8?B?ZVIrSFROWVAzOCt1MHgyaDdpZnVLdW5tUmVhZ0JrQVQ5ckVDQTJ0QlNOWTl3?=
 =?utf-8?B?Z1JyUXUvaU11Nlk0dnVkYzhmYkZYY3krNGxHN2pLWXR3TjFXMWQ4V0RHSjF3?=
 =?utf-8?B?bWNuWHRvSTV4RmxBamJjcHVwTCt6UDhhTzQxaDF4Y3RUdnFwRG9JVXYyM0Iy?=
 =?utf-8?B?QWNqYUlNVlpZLzVhdmQ1cGxGL0ovN1JjSi8vcm5CbGUxQWxWSEdyZ3o0dUR3?=
 =?utf-8?B?akhtSzRLQlNUMmMyZmw2RXo1MXpRV296RnEyZTNYQzhVMUZjRllvQjg4Qkda?=
 =?utf-8?B?V0VOd01hYi80VFNHc0tyM05pSnE0NkFURGVkS2ZwOFJFcUFiU214WjdoZERI?=
 =?utf-8?B?WXFXUkIzb2JPOVBWcEppYVJVempMdUtWRmhmMllrWTlySm83YXVsYXlRQ0Jl?=
 =?utf-8?B?MDhpU2ltRnhlbmU1d1VTU1VnMjlOVmRxa0tobzZsa2tUcjZBSGpMSmMrbnpV?=
 =?utf-8?B?WkxmemJ5UjkrNDZvUEtRMmpCaFpGY3R0ZmEvVDBsN1ZsR29iaVFEMFFHYVdJ?=
 =?utf-8?B?NG9hWFpMbitxMVNkcEt3Ty85NU1TQ3RUZmxHY3I0WkY2Sy9URmVHb2FGUFpz?=
 =?utf-8?B?SG9WTEJLUzIyR0tqVWN4VjJSK2dEdWI3T0YxSTg1TmkzV3NlSy9UVUt2SlRx?=
 =?utf-8?B?OTVxRGhkeVRIZmxoZXJTRTNacFJvaThOWTIwU3hwY25yN1lqYmFSMDJCNlBF?=
 =?utf-8?B?OWxVM2xsY2V4cGhlNUliVmNtVWxUblVsbmpBV216Q0JYdTFqbzNrbXYvSnJm?=
 =?utf-8?B?WGpRaEtTUjg0cW1GR2FsaEM4aGU3Rm9rZGhxd0MwRU1zNkR3elhsNkdSVVAr?=
 =?utf-8?B?WmhBYnU4eDVOdjRPWWlEUnFleWNvK1E3eW45T3FDU1VzQXpDSGkybnkrVTdq?=
 =?utf-8?B?djRiTjZhWjRYK3NXNnl4TStuOEo5VEFqZ2hvaGNvVy9ObEtZVTYxSVJRWlFW?=
 =?utf-8?B?MzFRNVdqMVMzTGJKUEI4VCt4ZkZVOEJ2NEdZYXlIejltWlFkbzlxY2xiSUpF?=
 =?utf-8?B?MVFveVlyYmVuaUx5b1V3UkZrZk1icm9YWTh6RjFxTmZ0eGVMd0FaVTlQVHBJ?=
 =?utf-8?B?c3hrUGRSTERDeDgyT1dFVlpscG9QcG5uTmdTOXZndlU0dFpQdzVRLzB5WVhG?=
 =?utf-8?B?TmR3ejA4ZTFrSlV2U2lGNHVGK0J2OXN0cVJmZUk4bm5Mcm1Fc2hpd1A3Rmd5?=
 =?utf-8?B?NnM4cDREbVA0bzNwRzFJcisvaW5TSk5PR2dac3JtOEdjbGVVZ0dCQmtyWW5L?=
 =?utf-8?B?dCt6elg0bmhSZ0RVV2Vwd0NXQmNsdnozYWN2bUJmK0JoeEMyT3BCL1FoWU40?=
 =?utf-8?B?VUZKMm9rMFdJcGpVd3BQa3pGQmJNZnNnZFNyRFFSRnlaYmlyUGp0ZVJuY3Zl?=
 =?utf-8?B?aTJISFl5L3NWdUVBanF5VFhDLzRzNHUzUE13WWRZQXRHdW9hRHRZSEtIY1hh?=
 =?utf-8?B?cGhUa25yUFBGYUlaR2xndCt2d3ZJL1g5OVFQVFRTVURQalY4VnVpRTgxTDk4?=
 =?utf-8?B?emhCMlNPSm9UNDh4T0VMWlFURjhMM20wQUxhV0hiY3pEdVpkNTRrYlVBRy9o?=
 =?utf-8?B?a3FoZDhIM24xamdIMXU5cWk0b2N6N2UyWSsyL1NWQXdNekZNZ1JZclppTjFy?=
 =?utf-8?B?WEJOSlQxK3V1aEFTWUxJMWhYUVVlelIwNEIvazM2WVZJdlZCT3pzL2Z0TXdx?=
 =?utf-8?B?azQ1NmpjSlBTcVBXYmJSOUo1ZE8yS2hhSnFQMGdFdVVxUFNEejhhMDBZVE1o?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ACD932580005B41A16FDC199DC4A38E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e29e15-a165-4e48-d30e-08dd82e42296
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 03:57:30.0350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/g1SWZnDpgWUw3PUQ4ONFA565V5d0nViLup3En/hWvSEV1vIYgRJVK/OBUvSktE6WE8Tn/5DwEtDUtFxI76OTZhreyYoXn8M2/A5oHFP+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5921

SGkgSmlyaSBTbGFieSwNCg0KVGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLg0KDQpPbiBX
ZWQsIDIwMjUtMDQtMjMgYXQgMDc6MTEgKzAyMDAsIEppcmkgU2xhYnkgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjMuIDA0LiAyNSwgNToz
OCwgUmVuZ2FyYWphbiBTIHdyb3RlOg0KPiA+IFN5c3RlbXMgdGhhdCBpc3N1ZSBQQ0llIGhvdCBy
ZXNldCByZXF1ZXN0cyBkdXJpbmcgYSBzdXNwZW5kL3Jlc3VtZQ0KPiA+IGN5Y2xlIGNhdXNlIFBD
STFYWFhYIGRldmljZSByZXZpc2lvbnMgcHJpb3IgdG8gQzAgdG8gZ2V0IGl0cyBVQVJUDQo+ID4g
Y29uZmlndXJhdGlvbiByZWdpc3RlcnMgcmVzZXQgdG8gaGFyZHdhcmUgZGVmYXVsdCB2YWx1ZXMu
IFRoaXMNCj4gPiByZXN1bHRzDQo+ID4gaW4gZGV2aWNlIGluYWNjZXNzaWJpbGl0eSBhbmQgZGF0
YSB0cmFuc2ZlciBmYWlsdXJlcy4gU3RhcnRpbmcgd2l0aA0KPiA+IFJldmlzaW9uIEMwLCBzdXBw
b3J0IHdhcyBhZGRlZCBpbiB0aGUgZGV2aWNlIGhhcmR3YXJlICh2aWEgdGhlIEhvdA0KPiA+IFJl
c2V0IERpc2FibGUgQml0KSB0byBhbGxvdyByZXNldHRpbmcgb25seSB0aGUgUENJZSBpbnRlcmZh
Y2UgYW5kDQo+ID4gaXRzDQo+ID4gYXNzb2NpYXRlZCBsb2dpYywgYnV0IHByZXNlcnZpbmcgdGhl
IFVBUlQgY29uZmlndXJhdGlvbiBkdXJpbmcgYQ0KPiA+IGhvdA0KPiA+IHJlc2V0LiBUaGlzIHBh
dGNoIGVuYWJsZXMgdGhlIGhvdCByZXNldCBkaXNhYmxlIGZlYXR1cmUgZHVyaW5nDQo+ID4gc3Vz
cGVuZC8NCj4gPiByZXN1bWUgZm9yIEMwIGFuZCBsYXRlciByZXZpc2lvbnMgb2YgdGhlIGRldmlj
ZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSZW5nYXJhamFuIFMgPHJlbmdhcmFqYW4uc0Bt
aWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1
MF9wY2kxeHh4eC5jIHwgMTggKysrKysrKysrKysrKysrKy0tDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMTYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wY2kxeHh4eC5jDQo+ID4gYi9kcml2ZXJz
L3R0eS9zZXJpYWwvODI1MC84MjUwX3BjaTF4eHh4LmMNCj4gPiBpbmRleCBlOWM1MWQ0ZTQ0N2Qu
LmVjNTczMzI3NTkwZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84
MjUwX3BjaTF4eHh4LmMNCj4gPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3Bj
aTF4eHh4LmMNCj4gPiBAQCAtMTE1LDYgKzExNSw3IEBADQo+ID4gDQo+ID4gICAjZGVmaW5lIFVB
UlRfUkVTRVRfUkVHICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHg5NA0KPiA+ICAgI2Rl
ZmluZSBVQVJUX1JFU0VUX0QzX1JFU0VUX0RJU0FCTEUgICAgICAgICBCSVQoMTYpDQo+ID4gKyNk
ZWZpbmUgVUFSVF9SRVNFVF9IT1RfUkVTRVRfRElTQUJMRSAgICAgICAgICAgIEJJVCgxNykNCj4g
PiANCj4gPiAgICNkZWZpbmUgVUFSVF9CVVJTVF9TVEFUVVNfUkVHICAgICAgICAgICAgICAgICAg
ICAgICAweDlDDQo+ID4gICAjZGVmaW5lIFVBUlRfVFhfQlVSU1RfRklGTyAgICAgICAgICAgICAg
ICAgIDB4QTANCj4gPiBAQCAtNjIwLDcgKzYyMSwxMyBAQCBzdGF0aWMgaW50IHBjaTF4eHh4X3N1
c3BlbmQoc3RydWN0IGRldmljZQ0KPiA+ICpkZXYpDQo+ID4gICAgICAgfQ0KPiA+IA0KPiA+ICAg
ICAgIGRhdGEgPSByZWFkbChwICsgVUFSVF9SRVNFVF9SRUcpOw0KPiA+IC0gICAgIHdyaXRlbChk
YXRhIHwgVUFSVF9SRVNFVF9EM19SRVNFVF9ESVNBQkxFLCBwICsNCj4gPiBVQVJUX1JFU0VUX1JF
Ryk7DQo+ID4gKw0KPiA+ICsgICAgIGlmIChwcml2LT5kZXZfcmV2ID49IDB4QzApDQo+ID4gKyAg
ICAgICAgICAgICB3cml0ZWwoZGF0YSB8IChVQVJUX1JFU0VUX0QzX1JFU0VUX0RJU0FCTEUgfA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgIFVBUlRfUkVTRVRfSE9UX1JFU0VUX0RJU0FCTEUpLCBw
ICsNCj4gPiBVQVJUX1JFU0VUX1JFRyk7DQo+ID4gKyAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAg
ICAgd3JpdGVsKGRhdGEgfCBVQVJUX1JFU0VUX0QzX1JFU0VUX0RJU0FCTEUsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgcCArIFVBUlRfUkVTRVRfUkVHKTsNCj4gDQo+IEluc3RlYWQgb2YgdGhp
cyBvdmVybHkgbG9uZyBsaW5lcywgY291bGQgeW91IGp1c3Q6DQo+ICAgIGRhdGEgfD0gVUFSVF9S
RVNFVF9IT1RfUkVTRVRfRElTQUJMRTsNCj4gYW5kIGtlZXAgdGhlIHdyaXRlbCgpIGFzIGlzPw0K
DQpTdXJlIHdpbGwgdXBkYXRlIHRoZSBjb2RlIGluIHRoZSBuZXh0IHJldmlzaW9uLg0KDQo+IA0K
PiB0aGFua3MsDQo+IC0tDQo+IGpzDQo+IHN1c2UgbGFicw0K
