Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42466252909;
	Fri, 25 Apr 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588322; cv=fail; b=a5ERwbiKA4xyzoFc8nzIFSfOx4d7TdYyY8Ambo3ymjIrTgEPWPKpvpbz6LMq6oHvd7S+mcVv8VrcfOmH57Hh+KN3f2lMfpaPPflx39LjfPo4ToQCbCnt4slA35iWM7ysxjI5GLmW4MJVV+DXI9Xrun0AyVKrNxRdPJ7+27ZK59c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588322; c=relaxed/simple;
	bh=01o91xGzWqmgM29fijZmx66qx7Vh4YzA6aWlBjgXFpY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vAT5YlRezCu7dgOTVxSzHmklxeHEPmY5qVSDx03T2Ba7d3HDWuztxUtSQC/eZo2v0EmDiSaRJMNp/At/Oj39cVLsSQxRDHP/joZoqrqrMZeRkEmWWcAmodJgf6pDTncdBfKp1fCE+2jALKgtYLzHnIxxJlGuYrtVUeihQGeq2OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ENYVnMov; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ENYVnMov"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7rroKpuZCD7w3wBxEgH2Zatg5jCzTyIEpgpbPZ92jYr2tkStHpjzTiBRw0H+gnPoNVaozEDyW/Q12f0fjhc52vaUsESBC9Yf1I2rVRtF+EzDphvs6kvDk3KtB4nv1YPLFtqzsiRkKk2wUysNHKMTyY3Wb6pq6aFOWh+pymeN1fxvUNuaTUOvESVVBP7hwgQ97sWuDKDw0T8VVUIkqjHMR4PEIIHzVJ4+XQHYw/lW8fhWQ6INWLA0KR2VGnN6kvFlAqeSSErmGgqyC0rjMNt6XxWCkLHTTDYvuSz7F9nX+voS+MNQA25vhKLjOh7CQDXSrkQkYkvUEMNgSs/4HsWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01o91xGzWqmgM29fijZmx66qx7Vh4YzA6aWlBjgXFpY=;
 b=xgJcDaW2vxCn5buh0hPaNq9oarUmAT5LHIom1uHt3GzTqu9sXr4/F950bLITIQOZm/TyL8yIZ6iSW/tNOKv2lKOuQym6jgFisJNvzLptN4W0/h6x0WqDTTWHHP+oGt1gCy3hYT7+ofuMvzIgpPWfsZnuOTXp2PV4o2b1J2vCq0lodsFwf5eozeUCYsSVXFkZSpRHkqDEk1oYHGa6XbDOrdY4SJxH9yaxjSjP4YtOf1ixDYArjss0b9K//0u9T12guiJ0xIj6P7wdH8syEVh6/jl4cRgL9/W41aW+HjX0rXffyHDV2CxXmitdNCImT5poedWXDl7tC78i4suJLscc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01o91xGzWqmgM29fijZmx66qx7Vh4YzA6aWlBjgXFpY=;
 b=ENYVnMovhyj2YBuKsUfcRwmWZrFmfzjL7KUXeBdQSbWggVhEr0MBgScqe3gZMrBXLyPprEtHQV16AXFSummw9bQLfKTYJLwLfty05vh0/j/MpUKL6VJYoeXOJh7o1RjqJQo7kV6rSeMW4UlTd/LjkGmX/EOT8Pk9A/GM2tFTlLDy/2NZGZAdh2xu6fPUanzMuWrr615FZzaaOIn8gw5WVlnnvqW5fYYAXeN7kIIGOMp4LKZljv7iZY2/6sjrY9vvv3hrKlu8LgsKctgNMbZwawQ17ki7/rf/DF3UyYhtBmkS/5NrWEjZKGA/O7zNtWPCkb925kyTxSKesogtZCg1vw==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 13:38:36 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 13:38:36 +0000
From: <Rengarajan.S@microchip.com>
To: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <UNGLinuxDriver@microchip.com>,
	<Kumaravel.Thiagarajan@microchip.com>, <linux-kernel@vger.kernel.org>,
	<Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v2 tty-next] 8250: microchip: pci1xxxx: Add PCIe Hot reset
 disable support for Rev C0 and later devices
Thread-Topic: [PATCH v2 tty-next] 8250: microchip: pci1xxxx: Add PCIe Hot
 reset disable support for Rev C0 and later devices
Thread-Index: AQHbtM3HiwuhEPp+XkeGI2hhiE1QsLOygIyAgAHjrQA=
Date: Fri, 25 Apr 2025 13:38:36 +0000
Message-ID: <f843a0060c1ca54c563f828a03f1dd56293715ea.camel@microchip.com>
References: <20250424035913.7673-1-rengarajan.s@microchip.com>
	 <bf5c1f39-149e-4bb4-9c07-a38ce5a99341@kernel.org>
In-Reply-To: <bf5c1f39-149e-4bb4-9c07-a38ce5a99341@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|CY8PR11MB7339:EE_
x-ms-office365-filtering-correlation-id: 9ca74daa-46b2-4068-4fe8-08dd83fe7b25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2c3SC9tTGZpamlRRU9Hc0w5S1BJOTRQaGcwazRvNWxYa3MzQ1NrRXpQSlhY?=
 =?utf-8?B?NG5qRHVrYzYzTGN3cHB2KzNMTVA3T3c1a2o1LzZ3NEtmVkFNM0IzWG1tdHlN?=
 =?utf-8?B?ZTZzWXRTaE1NUjVTUGNkWXFWWW9rMThlZDhneXhpQ3pMNWhZamdRdjRTQ05k?=
 =?utf-8?B?MURqYU9BaHFVZVM3M0szZ21KYnNlTE45dHF1S0R6NzFWcjd0SEhGUmNDSzlh?=
 =?utf-8?B?UU03c3JRN0ovdDdZM1RGSVBIbVBVZUc2RWt1YlpnSzRiWDVCSEN4YlQ3UGw5?=
 =?utf-8?B?VUhMdWtZT0hQR0M5em5JLzlISUQ1WjhnQlFwa0RSMUQvcU5ueHBhaGNMYUkz?=
 =?utf-8?B?TWdrQklxQ0doaHlpWVZITWlyTnJITXorZ3dEWmZEZjlQSlhXT09nTXExV3Bz?=
 =?utf-8?B?Y3dUTURSNDdtTUkyY2NzVVdBSmp0cld3c3dtcWZnWVNjZFMwanlaUGN3WlVj?=
 =?utf-8?B?bml1NS9zL1Brb2U4T241MlBURnFjeHhVdXBkYzJ4Q2dTbzZMQmcvbnFnci9i?=
 =?utf-8?B?QXY4RDVUK25nSThsZmhMV1UzM3VVdUZ6ZDZQVVc1MktnWThxZGJlTVhoKytZ?=
 =?utf-8?B?MkVvTzRvczZmcnQxNkYzL3NaUTA3bXlUeTY4RDJkcHovbWlSVXlxOWhmSW0x?=
 =?utf-8?B?c0ZOaFNXS0IyUXozY2tXbjNRb2s2Z2YzVENzRThTaEZTM1VabHE5Q3lJeW1a?=
 =?utf-8?B?bzRVT3o2eHRkNXpsUlllT3VpbUttVWgyNnpBVTdvZmMzRTQ0bjJvZm51VEFv?=
 =?utf-8?B?a01uYUIyeVJnR0xuWnp5VmVUOCtieURibkNoY1B4RFc5Vno2cHFXZzJlbWVF?=
 =?utf-8?B?S1d0aThBNitxcWZyRDNkeXluYWFFd1hRaGJQQjRmbmdnbkNidmpJcGdpYUFR?=
 =?utf-8?B?R3g4eE0xVXI1TU5NODFPMWpVdjNiaFo1SlJkZUNreXhaNUlpd3o1L2F1ZSti?=
 =?utf-8?B?U2ZVZy81YTNON3lqYXUvRlhOYXJ6THFWZzlxcmxjZ0Z2NDM5YXZvc3ovbVJn?=
 =?utf-8?B?c285eDQxbUIzTStNd0hhZmpqbW5YQXlDTVJ3U2ZJdDB6R0tvU0ZIV05zTko5?=
 =?utf-8?B?azB5NmtpY25wampuU0RQek8wMGRJZFdBelFCNXhTV3VWeWtvYjV6MHQ0Vlpp?=
 =?utf-8?B?YXE5YkI3Q2VLMmdnU3VXSHNMLyt1YXJwMXgrZjNBQlhhRzY2M2h1VXZ4d2VD?=
 =?utf-8?B?eHpuWUpteFVtQjJrb1ltb043bWM0Z3pzTXlRcjd6U1c4OVIzZytUZUVURFlx?=
 =?utf-8?B?d2FIeVhrWVlqYytQellFajBlb1FtN1ZDSUFhZUtlUTRBSWtMZVdLUmlvZE1H?=
 =?utf-8?B?bE8wRFBSM3BoSDJZNHdIdGRlTXp6cmpwSDJSUDhCdUx5MVhJZlg2V3hsVVdN?=
 =?utf-8?B?RnFCc1FlMjFKcTRLVTVleEExbTYzVVJWZENBRUZvQXZRYWpONStmUFZ5Ymhl?=
 =?utf-8?B?b1lCRVpBODl1WDRmbzFTbDZBQ3liM2ViVHR3K1I0MVpqVzBBZkZScW1qejVU?=
 =?utf-8?B?SWhRdGZTTkZaNTBnbnYxbG8yUnl1WXByTkxoUUh3a3cyK2JER3hxenZNbWlx?=
 =?utf-8?B?ZkNIbUZDN0p2eGg0MmpVNHBhb2cvV3NyWWhHMXl2QmpTVXZ4MjFCNmtNYkl0?=
 =?utf-8?B?UWY0NHdRMThsY3ZoTFVvODBhbGYvVmtDbVFxaVluUmpmSzNYYnB6ZEc0VjZE?=
 =?utf-8?B?dDZRWi9WbmVGR2dlcVN3TGpYTlk4M0ZsWlRnVmtNUlI0ZjZ3c1VyWkU2cEgr?=
 =?utf-8?B?L0IzYngwOGZsemdoSytiU0hwc1dnN3lZTUNpVUxmUnZhTTRXeXRzT0tIeFhM?=
 =?utf-8?B?UkR1N2lTQnQzazVIU1c3TXBkVTYwWHd2L1E4NEhzbXZNb2JpaHZLM3lmMElZ?=
 =?utf-8?B?dzFNRGI3QkVPaGYzcWN6blc0RERFbnAxZllldkxPdXRLWHRjMldIUllCQXo5?=
 =?utf-8?B?SE1KNUV5cVdURVJTVDAvdjhSM01xT1l3R09rYnAwMExyVlFyamRXWm40SzlK?=
 =?utf-8?Q?GJfYtivgRSK4xNL69UwY9tHdqIjAlc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzJ6MXhYemJUZGJxK2dvWWlJbkFXdWFySHI4RGdFVStsTWVjbnpRWVBKSzFJ?=
 =?utf-8?B?Y2xDZWV4elQ0alA1dDRtVmFHWEkyTlBxOHM5TWo5WjJYd0wvcEgrYVEyRzRM?=
 =?utf-8?B?R0xra0xjTmlQVkFaTUkxbmRTeCs3cEkyZzhUdE9GV3ZEa3dkbUFNc2dDT3Bj?=
 =?utf-8?B?ZWczLzRhczhaam4vak44SmRHc1NtcVZENjY0TVRpK2k2cjA1b1lxSUVDN3pm?=
 =?utf-8?B?VUZxck9LMjV2eWFMMVJSbkdZaU8zUk1xaFR0N3VZLzFIdUcxVElqb2h5cTN2?=
 =?utf-8?B?a0QzMUZ3RkZIN001L3YyN2J0TFplUHF5b2NFVmN2UHBKVEk4ZW9GL25OcEJI?=
 =?utf-8?B?bzRiOUFIK0pqb2JJelRpSkV1QVlnTlVpNktpNUNFR05qeTRZMVhUTnByakJs?=
 =?utf-8?B?T3NWUkFUOHo5NjErVU9lakp3YTVBb0pPTWxGSWZvSnNGcS9sVldsTVN1S1VI?=
 =?utf-8?B?QzgrZ3cvanBnOUc2OWVpZFEzMEU4aStQL0p1YVNhVkMxTzllNE9RRjVjS0ow?=
 =?utf-8?B?cHBFaHgxdVJpMjU4ZmtIWGtFRCtwc2tJRlJUZXNEOUU1Wm1aMFJybm1tSTd0?=
 =?utf-8?B?ODd1RXA5eGZhMmZWVktzNEFhL1hjRDIycy9XbWlmcnk0UkZaMHFiUlFrQVVP?=
 =?utf-8?B?SlZyRDJpNlBaUngxcmV4TlFjOXhFYzFRNkNNa1k5R3VjODAzZ1dOcThhRjF1?=
 =?utf-8?B?T0xnR0FSMExIZVIySDYwZ29RMGZ5N2tWMUJEVkNWN09kck5KaWFFa01Za0Fq?=
 =?utf-8?B?dVcyUUt3NHIwRGNtcVZUYURHc05CQ2tRdGUrUkVIQTI1S0pRMDJKRFhtV3J5?=
 =?utf-8?B?alJhKzRtNkVtQUFCcjFzd2x0WlVDRk5EZEp4VlR6STV6ZXpDWVVETm5FYXRC?=
 =?utf-8?B?SU8zNHFVTm9iTUgvZTdjMk0xS25HdjlCa3BZd2VRRVFlejZYVHIrdCtYNzdo?=
 =?utf-8?B?bjU4TlhhbWJiWUdFVzIyS295STkzMHdrRXNUbHNuaUU5VU81Z2duRTR5TGN0?=
 =?utf-8?B?dldZWW5WQUVmcGtZVzE4cVdmcUhuM3dnNDdsdnJkeTFPcnJucHg1WnYrb2xN?=
 =?utf-8?B?eksxMVVBUnA0WHloS2hYcGcvMVM0ditNdjRqM1VubWkwUlFYU21Edk8xRjl5?=
 =?utf-8?B?YzJPZ3JBTjI0ZnJhejZjeDFnRkxVTXRQenFncVZYalZuVCtEeTJFN2dqeWpy?=
 =?utf-8?B?MjdHZXUyUExQdDl3eXFucTdiZU5DcjJzekRHMjRMeUo4bytST0ZSenpCNmpi?=
 =?utf-8?B?c1VZdTBJaHJCdlQ1cGN2YTNkY0dLNG1QNWJDeGxjTnFGM0NKWldsSWppVjVR?=
 =?utf-8?B?Ui9kMkV1NmFxdERYeFdKTmtjS0JGcGRsSTUrMjRUbkdDMFNBZ2c4aG5seHFU?=
 =?utf-8?B?cEhrSkkvMHpYY0VwVFlXSmpEQ2s5RGhUOThVUXN6VWRDVFZqZnE3T1M2MzFT?=
 =?utf-8?B?blJWZlFuRldKUE5XM2JyS0tUU0JpOXNvN25FZGh3TlhNbFNIbW5oNHZUeDd1?=
 =?utf-8?B?TnFTTGI1c3c1UkEyU3lCeDNtb0ZZK3A4VVFhZ3ptKzYrektzRzg3TWRsYzZN?=
 =?utf-8?B?Ty82MHhIOXNVTWh2Um5FSEpZTkdkbVJxM1pNcWN0eC94N3pDTzBXMFZzTlVS?=
 =?utf-8?B?aEFyei9Pc1VFSzNkOCtKZFcySmRTSnFVYVZPOUhLZm5DS2tBVGsrUjZJMlRV?=
 =?utf-8?B?QkhzWXljaktBWE4xejZPUjlRbVhKVXRyS09kWlRNV3o4RCt3RkVlLys2ZUJM?=
 =?utf-8?B?NHlQZDREZXhKbGdTZ21zK1NqQXRucDFnL00xZVI0dWVpTVlSSHk5UDJtcjRi?=
 =?utf-8?B?RExjbXA1OTExYjY1cjJhMXR3YlRKNFJLeHlmUVp2a05NUWFkNzdIaVcreStF?=
 =?utf-8?B?OTduQnlmbGJoQlJqbW1FQzFpSVl6eTVqcFgzUVFpT2dRbEVJWERMKzcvMkll?=
 =?utf-8?B?aURYSmlnQkxTd3A3TVg5MmZpSDhUMnd4eWNDTWVaOXFjVGNLaW1QMS8ycVYv?=
 =?utf-8?B?WnE1dkZQK2RiRkM4anBBT0dtV3FZazArY3NpZGtVZmlEK1pOVzcvcVBiNll6?=
 =?utf-8?B?TG5ZQ1NlTGh4Z08rcUZBMHBkWnljRjJBZUhmUFE3TnhjenA5NTl5MVd1NEp2?=
 =?utf-8?B?c1U5Rk54NUcrMWVsY3dVR3NpanlqZnNETkZYN2N1K2pQanNCQ1FUZDAzZnY5?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C9712D029F6C84D98F4AFAC7597D3F6@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca74daa-46b2-4068-4fe8-08dd83fe7b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 13:38:36.6949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBKL69gVKixVKfdmY+jLFuGWMuriRPcZp7bhUvmILQ644GGWgoFb/WgFtnb7Vvtfnn2yNQ/F/iyX4qq7ZFnUqIh/zZjnmUWQJOGRexzJZ+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339

SGkgSmlyaSwNCg0KVGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLg0KDQpPbiBUaHUsIDIw
MjUtMDQtMjQgYXQgMTA6NDQgKzAyMDAsIEppcmkgU2xhYnkgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjQuIDA0LiAyNSwgNTo1OSwgUmVu
Z2FyYWphbiBTIHdyb3RlOg0KPiA+IFN5c3RlbXMgdGhhdCBpc3N1ZSBQQ0llIGhvdCByZXNldCBy
ZXF1ZXN0cyBkdXJpbmcgYSBzdXNwZW5kL3Jlc3VtZQ0KPiA+IGN5Y2xlIGNhdXNlIFBDSTFYWFhY
IGRldmljZSByZXZpc2lvbnMgcHJpb3IgdG8gQzAgdG8gZ2V0IGl0cyBVQVJUDQo+ID4gY29uZmln
dXJhdGlvbiByZWdpc3RlcnMgcmVzZXQgdG8gaGFyZHdhcmUgZGVmYXVsdCB2YWx1ZXMuIFRoaXMN
Cj4gPiByZXN1bHRzDQo+ID4gaW4gZGV2aWNlIGluYWNjZXNzaWJpbGl0eSBhbmQgZGF0YSB0cmFu
c2ZlciBmYWlsdXJlcy4gU3RhcnRpbmcgd2l0aA0KPiA+IFJldmlzaW9uIEMwLCBzdXBwb3J0IHdh
cyBhZGRlZCBpbiB0aGUgZGV2aWNlIGhhcmR3YXJlICh2aWEgdGhlIEhvdA0KPiA+IFJlc2V0IERp
c2FibGUgQml0KSB0byBhbGxvdyByZXNldHRpbmcgb25seSB0aGUgUENJZSBpbnRlcmZhY2UgYW5k
DQo+ID4gaXRzDQo+ID4gYXNzb2NpYXRlZCBsb2dpYywgYnV0IHByZXNlcnZpbmcgdGhlIFVBUlQg
Y29uZmlndXJhdGlvbiBkdXJpbmcgYQ0KPiA+IGhvdA0KPiA+IHJlc2V0LiBUaGlzIHBhdGNoIGVu
YWJsZXMgdGhlIGhvdCByZXNldCBkaXNhYmxlIGZlYXR1cmUgZHVyaW5nDQo+ID4gc3VzcGVuZC8N
Cj4gPiByZXN1bWUgZm9yIEMwIGFuZCBsYXRlciByZXZpc2lvbnMgb2YgdGhlIGRldmljZS4NCj4g
PiANCj4gPiB2Mg0KPiA+IFJldGFpbmVkIHRoZSBvcmlnaW5hbCB3cml0ZWwgYW5kIHNpbXBsaWZp
ZWQgdGhlIGhvdCByZXNldCBjb25kaXRpb24NCj4gPiB2MQ0KPiA+IEluaXRpYWwgQ29tbWl0Lg0K
PiANCj4gVGhpcyBzaG91bGQgaGF2ZSBiZWVuIHVuZGVyIHRoZSAtLS0gbGluZSBiZWxvdy4NCg0K
U3VyZSB3aWxsIHVwZGF0ZSBpbiB0aGUgbmV4dCByZXZpc2lvbi4NCg0KPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBSZW5nYXJhamFuIFMgPHJlbmdhcmFqYW4uc0BtaWNyb2NoaXAuY29tPg0KPiANCj4g
UmV2aWV3ZWQtYnk6IEppcmkgU2xhYnkgPGppcmlzbGFieUBrZXJuZWwub3JnPg0KPiANCj4gPiAt
LS0NCj4gDQo+IHZ2dnZ2IGhlcmUNCj4gDQo+ID4gICBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84
MjUwX3BjaTF4eHh4LmMgfCAxMCArKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gdGhhbmtzLA0KPiAtLQ0KPiBqcw0KPiBzdXNlIGxhYnMNCg==
